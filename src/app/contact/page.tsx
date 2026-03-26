"use client";

import { useState } from "react";
import { Button } from "@/components/ui/button";
import { Input } from "@/components/ui/input";
import { Label } from "@/components/ui/label";
import { Textarea } from "@/components/ui/textarea";

export default function ContactPage() {
  const [form, setForm] = useState({ name: "", email: "", phone: "", company: "", message: "" });
  const [msg, setMsg] = useState("");

  return (
    <div className="mx-auto max-w-lg px-4 py-12">
      <h1 className="font-serif text-3xl font-bold text-primary">Contact us</h1>
      <p className="mt-2 text-muted-foreground">For any questions about crystals, orders, or sessions.</p>
      <form
        className="mt-8 space-y-4"
        onSubmit={async (e) => {
          e.preventDefault();
          const r = await fetch("/api/contact", {
            method: "POST",
            headers: { "Content-Type": "application/json" },
            body: JSON.stringify(form),
          });
          if (r.ok) {
            setMsg("Sent! Check your inbox for a confirmation.");
            setForm({ name: "", email: "", phone: "", company: "", message: "" });
          } else setMsg("Could not send. Try again.");
        }}
      >
        <div>
          <Label>Name</Label>
          <Input value={form.name} onChange={(e) => setForm({ ...form, name: e.target.value })} required />
        </div>
        <div>
          <Label>Email</Label>
          <Input type="email" value={form.email} onChange={(e) => setForm({ ...form, email: e.target.value })} required />
        </div>
        <div>
          <Label>Phone</Label>
          <Input value={form.phone} onChange={(e) => setForm({ ...form, phone: e.target.value })} />
        </div>
        <div>
          <Label>Company</Label>
          <Input value={form.company} onChange={(e) => setForm({ ...form, company: e.target.value })} />
        </div>
        <div>
          <Label>Message</Label>
          <Textarea value={form.message} onChange={(e) => setForm({ ...form, message: e.target.value })} required />
        </div>
        <Button type="submit">Send</Button>
        {msg && <p className="text-sm text-muted-foreground">{msg}</p>}
      </form>
    </div>
  );
}
