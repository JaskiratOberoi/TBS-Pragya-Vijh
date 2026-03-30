"use client";

import { useEffect, useState, useCallback } from "react";
import Script from "next/script";
import { useSession } from "next-auth/react";
import { useRouter } from "next/navigation";
import Link from "next/link";
import { Button } from "@/components/ui/button";
import { Input } from "@/components/ui/input";
import { Label } from "@/components/ui/label";
import { formatINR } from "@/lib/utils";
import { LoadingScreen } from "@/components/shared/LoadingSpinner";
import { effectiveUnitPrice } from "@/lib/promo-engine";

declare global {
  interface Window {
    Razorpay?: new (opts: Record<string, unknown>) => { open: () => void };
  }
}

type CartLine = {
  id: string;
  quantity: number;
  product: { name: string; slug: string; price: number; salePrice: number | null; productType: string };
};

export default function CheckoutPage() {
  const { data: session, status } = useSession();
  const router = useRouter();
  const [cart, setCart] = useState<{ items: CartLine[]; summary: { totalPaise: number; subtotalPaise: number } } | null>(null);
  const [coupon, setCoupon] = useState("");
  const [guestName, setGuestName] = useState("");
  const [guestEmail, setGuestEmail] = useState("");
  const [guestPhone, setGuestPhone] = useState("");
  const [addr, setAddr] = useState({ name: "", phone: "", line1: "", city: "", state: "", pincode: "", stateCode: "07" });
  const [err, setErr] = useState("");
  const [rzpReady, setRzpReady] = useState(false);

  const load = useCallback(() => {
    void fetch("/api/cart", { credentials: "include" })
      .then((r) => r.json())
      .then(setCart);
  }, []);

  useEffect(() => {
    load();
  }, [load]);

  useEffect(() => {
    if (session?.user) {
      setGuestName(session.user.name ?? "");
      setGuestEmail(session.user.email ?? "");
      setAddr((a) => ({ ...a, name: session.user?.name ?? a.name }));
    }
  }, [session]);

  const needsShip = cart?.items.some((i) => i.product.productType === "PHYSICAL");

  function pay() {
    setErr("");
    if (!cart?.items.length) return;
    if (!session?.user) {
      if (!guestName.trim() || !guestEmail.trim() || !guestPhone.trim()) {
        setErr("Enter your name, email, and phone.");
        return;
      }
    }
    if (needsShip && (!addr.line1 || !addr.city || !addr.pincode || !addr.phone)) {
      setErr("Please fill shipping address and phone.");
      return;
    }
    if (!window.Razorpay) {
      setErr("Payment script loading… try again.");
      return;
    }
    const shippingAddress = needsShip
      ? {
          name: addr.name || guestName,
          phone: addr.phone || guestPhone,
          line1: addr.line1,
          city: addr.city,
          state: addr.state,
          pincode: addr.pincode,
          stateCode: addr.stateCode,
        }
      : undefined;

    void (async () => {
      const body: Record<string, unknown> = {
        shippingAddress,
        billingAddress: shippingAddress,
        couponCode: coupon.trim() || undefined,
      };
      if (!session?.user) {
        body.guestName = guestName.trim();
        body.guestEmail = guestEmail.trim();
        body.guestPhone = guestPhone.trim();
      }
      const co = await fetch("/api/checkout/create-order", {
        method: "POST",
        headers: { "Content-Type": "application/json" },
        credentials: "include",
        body: JSON.stringify(body),
      });
      const data = (await co.json()) as { error?: string; key?: string; rzpOrderId?: string; orderId?: string; amount?: number };
      if (!co.ok) {
        setErr(data.error ?? "Could not start checkout");
        return;
      }
      const prefill = session?.user
        ? { name: session.user.name ?? undefined, email: session.user.email }
        : { name: guestName.trim(), email: guestEmail.trim(), contact: guestPhone.trim() };
      const options = {
        key: data.key,
        amount: data.amount,
        currency: "INR",
        order_id: data.rzpOrderId,
        name: "The Blissful Soul",
        description: "Order payment",
        prefill,
        handler: async (res: { razorpay_order_id: string; razorpay_payment_id: string; razorpay_signature: string }) => {
          const v = await fetch("/api/checkout/verify-payment", {
            method: "POST",
            headers: { "Content-Type": "application/json" },
            credentials: "include",
            body: JSON.stringify({
              orderId: data.orderId,
              rzpOrderId: res.razorpay_order_id,
              rzpPaymentId: res.razorpay_payment_id,
              rzpSignature: res.razorpay_signature,
            }),
          });
          if (v.ok) {
            window.dispatchEvent(new Event("cart:updated"));
            if (session?.user) router.push("/account?tab=orders");
            else router.push(`/checkout/success?orderId=${encodeURIComponent(data.orderId ?? "")}`);
          } else setErr("Verification failed");
        },
        theme: { color: "#4a3058" },
      };
      new window.Razorpay!(options).open();
    })();
  }

  if (status === "loading" || !cart) return <LoadingScreen label="Loading checkout" />;

  return (
    <>
      <Script src="https://checkout.razorpay.com/v1/checkout.js" onLoad={() => setRzpReady(true)} />
      <div className="mx-auto grid max-w-6xl gap-10 px-4 py-10 md:py-14 lg:grid-cols-3">
        <div className="lg:col-span-2">
          <p className="text-xs font-medium uppercase tracking-luxury text-muted-foreground">Secure pay</p>
          <h1 className="mt-2 font-display text-3xl font-semibold tracking-display text-foreground md:text-4xl">
            Checkout
          </h1>
          {!session?.user && (
            <div className="mt-8 space-y-4 rounded-2xl border border-border/60 bg-card p-6 shadow-elevation-rest">
              <h2 className="font-display text-lg font-semibold tracking-display">Contact</h2>
              <div className="grid gap-3 sm:grid-cols-2">
                <div>
                  <Label htmlFor="gn">Full name</Label>
                  <Input id="gn" value={guestName} onChange={(e) => setGuestName(e.target.value)} />
                </div>
                <div>
                  <Label htmlFor="ge">Email</Label>
                  <Input id="ge" type="email" value={guestEmail} onChange={(e) => setGuestEmail(e.target.value)} />
                </div>
                <div className="sm:col-span-2">
                  <Label htmlFor="gp">Phone</Label>
                  <Input id="gp" value={guestPhone} onChange={(e) => setGuestPhone(e.target.value)} />
                </div>
              </div>
            </div>
          )}
          {needsShip && (
            <div className="mt-6 space-y-4 rounded-2xl border border-border/60 bg-card p-6 shadow-elevation-rest">
              <h2 className="font-display text-lg font-semibold tracking-display">Shipping address</h2>
              <div className="grid gap-3 sm:grid-cols-2">
                <div>
                  <Label htmlFor="nm">Full name</Label>
                  <Input id="nm" value={addr.name} onChange={(e) => setAddr({ ...addr, name: e.target.value })} />
                </div>
                <div>
                  <Label htmlFor="ph">Phone</Label>
                  <Input id="ph" value={addr.phone} onChange={(e) => setAddr({ ...addr, phone: e.target.value })} />
                </div>
                <div className="sm:col-span-2">
                  <Label htmlFor="l1">Address</Label>
                  <Input id="l1" value={addr.line1} onChange={(e) => setAddr({ ...addr, line1: e.target.value })} />
                </div>
                <div>
                  <Label htmlFor="ct">City</Label>
                  <Input id="ct" value={addr.city} onChange={(e) => setAddr({ ...addr, city: e.target.value })} />
                </div>
                <div>
                  <Label htmlFor="st">State</Label>
                  <Input id="st" value={addr.state} onChange={(e) => setAddr({ ...addr, state: e.target.value })} />
                </div>
                <div>
                  <Label htmlFor="pin">PIN code</Label>
                  <Input id="pin" value={addr.pincode} onChange={(e) => setAddr({ ...addr, pincode: e.target.value })} />
                </div>
                <div>
                  <Label htmlFor="sc">State code (GST)</Label>
                  <Input id="sc" value={addr.stateCode} onChange={(e) => setAddr({ ...addr, stateCode: e.target.value })} />
                </div>
              </div>
            </div>
          )}
          {!needsShip && <p className="mt-4 text-sm text-muted-foreground">Digital-only cart — no shipping required.</p>}
          <div className="mt-6">
            <Label htmlFor="cp">Coupon code</Label>
            <Input id="cp" value={coupon} onChange={(e) => setCoupon(e.target.value)} placeholder="Optional" className="max-w-xs" />
          </div>
          {err && <p className="mt-4 text-sm text-destructive">{err}</p>}
        </div>
        <div className="h-fit rounded-2xl border border-border/60 bg-card p-6 shadow-elevation-rest lg:sticky lg:top-28">
          <h2 className="font-display text-lg font-semibold tracking-display">Order summary</h2>
          <ul className="mt-4 space-y-2 text-sm">
            {cart.items.map((l) => (
              <li key={l.id} className="flex justify-between gap-2">
                <span>
                  {l.product.name} × {l.quantity}
                </span>
                <span>{formatINR(effectiveUnitPrice(l.product as Parameters<typeof effectiveUnitPrice>[0]) * l.quantity)}</span>
              </li>
            ))}
          </ul>
          <div className="mt-4 border-t pt-4 font-semibold">
            Total <span className="float-right">{formatINR(cart.summary.totalPaise)}</span>
          </div>
          <Button
            className="mt-6 h-12 w-full rounded-full text-base"
            type="button"
            disabled={!cart.items.length || !rzpReady}
            onClick={() => pay()}
          >
            Pay with Razorpay
          </Button>
          <Button variant="link" className="mt-2 px-0" asChild>
            <Link href="/cart">Back to cart</Link>
          </Button>
        </div>
      </div>
    </>
  );
}
