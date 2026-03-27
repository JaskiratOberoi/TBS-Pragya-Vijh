"use client";

import { useEffect, useState, Suspense } from "react";
import { useSession, signIn, signOut } from "next-auth/react";
import { useSearchParams } from "next/navigation";
import Link from "next/link";
import { Button } from "@/components/ui/button";
import { Input } from "@/components/ui/input";
import { Label } from "@/components/ui/label";
import { Tabs, TabsContent, TabsList, TabsTrigger } from "@/components/ui/tabs";
import { formatINR } from "@/lib/utils";
import { LoadingScreen } from "@/components/shared/LoadingSpinner";

function AccountInner() {
  const { data: session, status } = useSession();
  const searchParams = useSearchParams();
  const tab = searchParams.get("tab") ?? "orders";
  const next = searchParams.get("next");

  const [reg, setReg] = useState({ name: "", email: "", phone: "", password: "" });
  const [login, setLogin] = useState({ email: "", password: "" });
  const [forgotEmail, setForgotEmail] = useState("");
  const [msg, setMsg] = useState("");
  const [orders, setOrders] = useState<
    { id: string; status: string; paymentStatus: string; total: number; createdAt: string; invoiceNumber?: string }[]
  >([]);
  const [bookings, setBookings] = useState<
    { id: string; status: string; scheduledAt: string; service: { name: string }; amountPaid: number }[]
  >([]);
  const [digital, setDigital] = useState<{ productName: string; url: string; assetType: string }[]>([]);

  useEffect(() => {
    if (status !== "authenticated") return;
    void fetch("/api/orders", { credentials: "include" })
      .then((r) => r.json())
      .then((d) => setOrders(d.orders ?? []));
    void fetch("/api/bookings/my", { credentials: "include" })
      .then((r) => r.json())
      .then((d) => setBookings(d.bookings ?? []));
    void fetch("/api/digital-library", { credentials: "include" })
      .then((r) => r.json())
      .then((d) => setDigital(d.items ?? []));
  }, [status]);

  if (status === "loading") return <LoadingScreen label="Loading account" />;

  if (status === "unauthenticated") {
    return (
      <div className="mx-auto max-w-md px-4 py-12">
        <h1 className="font-serif text-2xl font-bold text-primary">Account</h1>
        <Tabs defaultValue="login" className="mt-6">
          <TabsList className="grid w-full grid-cols-2">
            <TabsTrigger value="login">Sign in</TabsTrigger>
            <TabsTrigger value="register">Register</TabsTrigger>
          </TabsList>
          <TabsContent value="login">
            <form
              className="mt-4 space-y-3"
              onSubmit={(e) => {
                e.preventDefault();
                void signIn("credentials", {
                  email: login.email,
                  password: login.password,
                  callbackUrl: next ?? "/account",
                });
              }}
            >
              <div>
                <Label htmlFor="le">Email</Label>
                <Input id="le" type="email" value={login.email} onChange={(e) => setLogin({ ...login, email: e.target.value })} required />
              </div>
              <div>
                <Label htmlFor="lp">Password</Label>
                <Input id="lp" type="password" value={login.password} onChange={(e) => setLogin({ ...login, password: e.target.value })} required />
              </div>
              <Button type="submit" className="w-full">
                Sign in
              </Button>
            </form>
          </TabsContent>
          <TabsContent value="register">
            <form
              className="mt-4 space-y-3"
              onSubmit={async (e) => {
                e.preventDefault();
                setMsg("");
                const r = await fetch("/api/auth/register", {
                  method: "POST",
                  headers: { "Content-Type": "application/json" },
                  body: JSON.stringify(reg),
                });
                if (r.ok) setMsg("Registered — you can sign in now.");
                else setMsg((await r.json()).error ?? "Error");
              }}
            >
              <div>
                <Label>Name</Label>
                <Input value={reg.name} onChange={(e) => setReg({ ...reg, name: e.target.value })} />
              </div>
              <div>
                <Label>Email</Label>
                <Input type="email" value={reg.email} onChange={(e) => setReg({ ...reg, email: e.target.value })} required />
              </div>
              <div>
                <Label>Phone</Label>
                <Input value={reg.phone} onChange={(e) => setReg({ ...reg, phone: e.target.value })} />
              </div>
              <div>
                <Label>Password</Label>
                <Input type="password" value={reg.password} onChange={(e) => setReg({ ...reg, password: e.target.value })} required />
              </div>
              <Button type="submit" className="w-full">
                Create account
              </Button>
              {msg && <p className="text-sm text-muted-foreground">{msg}</p>}
            </form>
          </TabsContent>
        </Tabs>
        <div className="mt-8 border-t pt-6">
          <h2 className="text-sm font-medium">Forgot password</h2>
          <form
            className="mt-2 flex gap-2"
            onSubmit={async (e) => {
              e.preventDefault();
              await fetch("/api/auth/forgot-password", {
                method: "POST",
                headers: { "Content-Type": "application/json" },
                body: JSON.stringify({ email: forgotEmail }),
              });
              setMsg("If an account exists, we sent reset instructions.");
            }}
          >
            <Input placeholder="Email" value={forgotEmail} onChange={(e) => setForgotEmail(e.target.value)} />
            <Button type="submit" variant="secondary">
              Send link
            </Button>
          </form>
        </div>
      </div>
    );
  }

  return (
    <div className="mx-auto max-w-3xl px-4 py-10">
      <div className="flex flex-wrap items-center justify-between gap-4">
        <h1 className="font-serif text-2xl font-bold text-primary">My account</h1>
        <div className="flex items-center gap-2">
          <span className="text-sm text-muted-foreground">{session?.user?.email}</span>
          <Button variant="outline" size="sm" onClick={() => void signOut({ callbackUrl: "/" })}>
            Sign out
          </Button>
        </div>
      </div>
      <Tabs key={tab} defaultValue={tab} className="mt-8">
        <TabsList>
          <TabsTrigger value="orders">Orders</TabsTrigger>
          <TabsTrigger value="bookings">Bookings</TabsTrigger>
          <TabsTrigger value="digital">Digital library</TabsTrigger>
        </TabsList>
        <TabsContent value="orders" className="mt-4 space-y-4">
          {orders.length === 0 && <p className="text-sm text-muted-foreground">No orders yet.</p>}
          {orders.map((o) => (
            <div key={o.id} className="rounded-md border p-4 text-sm">
              <div className="flex flex-wrap justify-between gap-2">
                <span className="font-mono text-xs">{o.id.slice(0, 12)}…</span>
                <span>{new Date(o.createdAt).toLocaleDateString("en-IN")}</span>
              </div>
              <p className="mt-2">
                {o.status} · {o.paymentStatus} · {formatINR(o.total)}
              </p>
              {o.invoiceNumber && <p className="text-xs text-muted-foreground">Invoice {o.invoiceNumber}</p>}
            </div>
          ))}
        </TabsContent>
        <TabsContent value="bookings" className="mt-4 space-y-4">
          {bookings.length === 0 && <p className="text-sm text-muted-foreground">No bookings yet.</p>}
          {bookings.map((b) => (
            <div key={b.id} className="rounded-md border p-4 text-sm">
              <p className="font-medium">{b.service.name}</p>
              <p className="text-muted-foreground">{new Date(b.scheduledAt).toLocaleString("en-IN")}</p>
              <p>
                {b.status} · {formatINR(b.amountPaid)}
              </p>
            </div>
          ))}
        </TabsContent>
        <TabsContent value="digital" className="mt-4 space-y-3">
          {digital.length === 0 && <p className="text-sm text-muted-foreground">No digital purchases yet.</p>}
          {digital.map((d, i) => (
            <div key={i} className="flex items-center justify-between rounded-md border p-3 text-sm">
              <span>{d.productName}</span>
              <Button size="sm" variant="outline" asChild>
                <a href={d.url} target="_blank" rel="noreferrer">
                  Access
                </a>
              </Button>
            </div>
          ))}
        </TabsContent>
      </Tabs>
      <Button className="mt-8" variant="secondary" asChild>
        <Link href="/shop">Continue shopping</Link>
      </Button>
    </div>
  );
}

export default function AccountPage() {
  return (
    <Suspense fallback={<LoadingScreen label="Loading account" />}>
      <AccountInner />
    </Suspense>
  );
}
