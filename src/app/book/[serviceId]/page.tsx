"use client";

import { useEffect, useState, useCallback } from "react";
import Script from "next/script";
import { useParams, useRouter } from "next/navigation";
import { useSession } from "next-auth/react";
import Link from "next/link";
import { Button } from "@/components/ui/button";
import { Input } from "@/components/ui/input";
import { Label } from "@/components/ui/label";
import { Textarea } from "@/components/ui/textarea";
import { Badge } from "@/components/ui/badge";
import { formatINR } from "@/lib/utils";

declare global {
  interface Window {
    Razorpay?: new (opts: Record<string, unknown>) => { open: () => void };
  }
}

type Service = { id: string; name: string; type: string; price: number; durationMinutes: number; description: string | null };

export default function BookPage() {
  const params = useParams();
  const serviceId = params.serviceId as string;
  const router = useRouter();
  const { data: session, status } = useSession();
  const [service, setService] = useState<Service | null>(null);
  const [date, setDate] = useState("");
  const [slots, setSlots] = useState<{ start: string; label: string }[]>([]);
  const [slot, setSlot] = useState<{ start: string; end: string } | null>(null);
  const [notes, setNotes] = useState("");
  const [guestName, setGuestName] = useState("");
  const [guestEmail, setGuestEmail] = useState("");
  const [guestPhone, setGuestPhone] = useState("");
  const [err, setErr] = useState("");
  const [rzpReady, setRzpReady] = useState(false);

  useEffect(() => {
    void fetch("/api/services")
      .then((r) => r.json())
      .then((d) => {
        const s = (d.services as Service[]).find((x) => x.id === serviceId);
        setService(s ?? null);
      });
  }, [serviceId]);

  useEffect(() => {
    if (session?.user) {
      setGuestName(session.user.name ?? "");
      setGuestEmail(session.user.email ?? "");
    }
  }, [session]);

  const loadSlots = useCallback(() => {
    if (!date) return;
    void fetch(`/api/bookings/availability?serviceId=${serviceId}&date=${encodeURIComponent(date)}`)
      .then((r) => r.json())
      .then((d) => setSlots(d.slots ?? []));
  }, [date, serviceId]);

  useEffect(() => {
    loadSlots();
  }, [loadSlots]);

  function pay() {
    setErr("");
    if (!slot) {
      setErr("Pick a time slot.");
      return;
    }
    if (!session?.user) {
      if (!guestName.trim() || !guestEmail.trim() || !guestPhone.trim()) {
        setErr("Enter your name, email, and phone.");
        return;
      }
    }
    if (!window.Razorpay) {
      setErr("Payment loading…");
      return;
    }
    void (async () => {
      const payload: Record<string, unknown> = {
        serviceId,
        scheduledAt: slot.start,
        customerNotes: notes,
      };
      if (!session?.user) {
        payload.guestName = guestName.trim();
        payload.guestEmail = guestEmail.trim();
        payload.guestPhone = guestPhone.trim();
      }
      const co = await fetch("/api/checkout/booking-payment", {
        method: "POST",
        headers: { "Content-Type": "application/json" },
        credentials: "include",
        body: JSON.stringify(payload),
      });
      const data = (await co.json()) as { error?: string; key?: string; rzpOrderId?: string; bookingId?: string; amount?: number };
      if (!co.ok) {
        setErr(data.error ?? "Could not start payment");
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
        description: service?.name,
        prefill,
        handler: async (res: { razorpay_order_id: string; razorpay_payment_id: string; razorpay_signature: string }) => {
          const v = await fetch("/api/checkout/verify-booking", {
            method: "POST",
            headers: { "Content-Type": "application/json" },
            credentials: "include",
            body: JSON.stringify({
              bookingId: data.bookingId,
              rzpOrderId: res.razorpay_order_id,
              rzpPaymentId: res.razorpay_payment_id,
              rzpSignature: res.razorpay_signature,
            }),
          });
          if (v.ok) {
            router.push(`/book/success?bookingId=${encodeURIComponent(data.bookingId ?? "")}`);
          } else setErr("Verification failed");
        },
        theme: { color: "#5c3d6e" },
      };
      new window.Razorpay!(options).open();
    })();
  }

  if (status === "loading" || !service) return <div className="p-10 text-center">Loading…</div>;

  return (
    <>
      <Script src="https://checkout.razorpay.com/v1/checkout.js" onLoad={() => setRzpReady(true)} />
      <div className="mx-auto max-w-lg px-4 py-10">
        <Link href="/services" className="text-sm text-muted-foreground hover:underline">
          ← All services
        </Link>
        <div className="mt-4 rounded-lg border p-6">
          <div className="flex items-center justify-between gap-2">
            <h1 className="font-serif text-xl font-bold text-primary">{service.name}</h1>
            <Badge>{service.type}</Badge>
          </div>
          <p className="mt-2 text-sm text-muted-foreground">{service.durationMinutes} minutes</p>
          <p className="mt-2 text-lg font-semibold text-primary">{formatINR(service.price)}</p>
          {service.description && <p className="mt-2 text-sm">{service.description}</p>}
        </div>
        <div className="mt-8 space-y-4">
          <div>
            <Label>Date</Label>
            <Input type="date" value={date} onChange={(e) => setDate(e.target.value)} className="mt-1" />
          </div>
          <div>
            <p className="text-sm font-medium">Available slots</p>
            <div className="mt-2 flex flex-wrap gap-2">
              {slots.length === 0 && <span className="text-sm text-muted-foreground">No slots — pick another date.</span>}
              {slots.map((s) => (
                <Button
                  key={s.start}
                  type="button"
                  size="sm"
                  variant={slot?.start === s.start ? "default" : "outline"}
                  onClick={() => {
                    const end = new Date(new Date(s.start).getTime() + service.durationMinutes * 60 * 1000).toISOString();
                    setSlot({ start: s.start, end });
                  }}
                >
                  {s.label}
                </Button>
              ))}
            </div>
          </div>
          {!session?.user && (
            <div className="space-y-3 rounded-lg border p-4">
              <p className="text-sm font-medium">Your details</p>
              <div>
                <Label htmlFor="gn">Full name</Label>
                <Input id="gn" value={guestName} onChange={(e) => setGuestName(e.target.value)} className="mt-1" />
              </div>
              <div>
                <Label htmlFor="ge">Email</Label>
                <Input id="ge" type="email" value={guestEmail} onChange={(e) => setGuestEmail(e.target.value)} className="mt-1" />
              </div>
              <div>
                <Label htmlFor="gp">Phone</Label>
                <Input id="gp" value={guestPhone} onChange={(e) => setGuestPhone(e.target.value)} className="mt-1" />
              </div>
            </div>
          )}
          <div>
            <Label>Notes (optional)</Label>
            <Textarea value={notes} onChange={(e) => setNotes(e.target.value)} className="mt-1" />
          </div>
          {err && <p className="text-sm text-destructive">{err}</p>}
          <Button className="w-full" type="button" disabled={!rzpReady || !slot} onClick={() => pay()}>
            Pay and book
          </Button>
        </div>
      </div>
    </>
  );
}
