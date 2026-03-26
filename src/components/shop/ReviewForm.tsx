"use client";

import { useState } from "react";
import { useSession } from "next-auth/react";
import { Button } from "@/components/ui/button";
import { Input } from "@/components/ui/input";
import { Textarea } from "@/components/ui/textarea";

export function ReviewForm({ slug }: { slug: string }) {
  const { status } = useSession();
  const [rating, setRating] = useState(5);
  const [comment, setComment] = useState("");
  const [msg, setMsg] = useState("");

  if (status !== "authenticated") {
    return <p className="text-sm text-muted-foreground">Sign in to write a review.</p>;
  }

  return (
    <form
      className="space-y-2 rounded-md border p-4"
      onSubmit={async (e) => {
        e.preventDefault();
        setMsg("");
        const r = await fetch(`/api/products/${slug}/reviews`, {
          method: "POST",
          headers: { "Content-Type": "application/json" },
          body: JSON.stringify({ rating, comment }),
        });
        if (r.ok) {
          setComment("");
          setMsg("Thanks! Refresh to see your review.");
        } else setMsg("Could not submit.");
      }}
    >
      <p className="text-sm font-medium">Your review</p>
      <div className="flex items-center gap-2">
        <label className="text-sm text-muted-foreground">Rating</label>
        <Input type="number" min={1} max={5} value={rating} onChange={(e) => setRating(Number(e.target.value))} className="w-20" />
      </div>
      <Textarea value={comment} onChange={(e) => setComment(e.target.value)} placeholder="Share your experience" required />
      <Button type="submit">Submit</Button>
      {msg && <p className="text-xs text-muted-foreground">{msg}</p>}
    </form>
  );
}
