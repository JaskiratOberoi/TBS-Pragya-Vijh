"use client";

import { useSearchParams } from "next/navigation";
import { useSession } from "next-auth/react";
import Link from "next/link";
import { useState, Suspense } from "react";
import { Button } from "@/components/ui/button";
import { Input } from "@/components/ui/input";
import { Label } from "@/components/ui/label";

function SuccessInner() {
  const searchParams = useSearchParams();
  const orderId = searchParams.get("orderId") ?? "";
  const { status } = useSession();
  const [password, setPassword] = useState("");
  const [confirm, setConfirm] = useState("");
  const [msg, setMsg] = useState("");
  const [done, setDone] = useState(false);

  async function registerAccount() {
    setMsg("");
    if (password.length < 8) {
      setMsg("Password must be at least 8 characters.");
      return;
    }
    if (password !== confirm) {
      setMsg("Passwords do not match.");
      return;
    }
    const r = await fetch("/api/auth/register-post-order", {
      method: "POST",
      headers: { "Content-Type": "application/json" },
      body: JSON.stringify({ orderId, password }),
    });
    const d = (await r.json()) as { error?: string };
    if (!r.ok) {
      setMsg(d.error ?? "Could not create account");
      return;
    }
    setDone(true);
  }

  return (
    <div className="mx-auto max-w-md px-4 py-16 text-center">
      <h1 className="font-serif text-2xl font-bold text-primary">Thank you for your order</h1>
      <p className="mt-4 text-sm text-muted-foreground">
        Order: <span className="font-mono">{orderId.slice(0, 12)}…</span>
      </p>
      <p className="mt-2 text-sm">A confirmation email has been sent.</p>
      {status === "unauthenticated" && !done && orderId && (
        <div className="mt-10 space-y-4 rounded-lg border p-6 text-left">
          <p className="text-sm font-medium">Create an account with the same email (optional)</p>
          <div>
            <Label htmlFor="pw">Password</Label>
            <Input id="pw" type="password" value={password} onChange={(e) => setPassword(e.target.value)} className="mt-1" />
          </div>
          <div>
            <Label htmlFor="pw2">Confirm password</Label>
            <Input id="pw2" type="password" value={confirm} onChange={(e) => setConfirm(e.target.value)} className="mt-1" />
          </div>
          {msg && <p className="text-sm text-destructive">{msg}</p>}
          <Button type="button" className="w-full" onClick={() => void registerAccount()}>
            Create account
          </Button>
        </div>
      )}
      {done && <p className="mt-6 text-sm text-primary">Account created. Sign in to view orders and digital library.</p>}
      <Button variant="link" className="mt-8" asChild>
        <Link href="/">Back to home</Link>
      </Button>
    </div>
  );
}

export default function CheckoutSuccessPage() {
  return (
    <Suspense fallback={<div className="p-10 text-center">Loading…</div>}>
      <SuccessInner />
    </Suspense>
  );
}
