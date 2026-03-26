"use client";

import { useState, Suspense } from "react";
import { useSearchParams } from "next/navigation";
import Link from "next/link";
import { Button } from "@/components/ui/button";
import { Input } from "@/components/ui/input";
import { Label } from "@/components/ui/label";

function Form() {
  const token = useSearchParams().get("token") ?? "";
  const [password, setPassword] = useState("");
  const [msg, setMsg] = useState("");

  return (
    <div className="mx-auto max-w-sm px-4 py-12">
      <h1 className="font-serif text-2xl font-bold text-primary">Reset password</h1>
      <form
        className="mt-6 space-y-4"
        onSubmit={async (e) => {
          e.preventDefault();
          const r = await fetch("/api/auth/reset-password", {
            method: "POST",
            headers: { "Content-Type": "application/json" },
            body: JSON.stringify({ token, password }),
          });
          if (r.ok) setMsg("Password updated. You can sign in.");
          else setMsg("Invalid or expired link.");
        }}
      >
        <div>
          <Label>New password</Label>
          <Input type="password" value={password} onChange={(e) => setPassword(e.target.value)} required minLength={8} />
        </div>
        <Button type="submit" className="w-full">
          Update
        </Button>
        {msg && <p className="text-sm text-muted-foreground">{msg}</p>}
        <Button variant="link" asChild className="px-0">
          <Link href="/account">Back to account</Link>
        </Button>
      </form>
    </div>
  );
}

export default function ResetPasswordPage() {
  return (
    <Suspense fallback={<div className="p-10 text-center">Loading…</div>}>
      <Form />
    </Suspense>
  );
}
