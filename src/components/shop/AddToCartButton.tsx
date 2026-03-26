"use client";

import { useState } from "react";
import { Button } from "@/components/ui/button";
import { useRouter } from "next/navigation";

export function AddToCartButton({ productId, quantity = 1 }: { productId: string; quantity?: number }) {
  const [loading, setLoading] = useState(false);
  const router = useRouter();

  async function add() {
    setLoading(true);
    try {
      await fetch("/api/cart", {
        method: "POST",
        headers: { "Content-Type": "application/json" },
        credentials: "include",
        body: JSON.stringify({ productId, quantity }),
      });
      window.dispatchEvent(new Event("cart:updated"));
    } finally {
      setLoading(false);
    }
  }

  return (
    <div className="flex flex-wrap gap-3">
      <Button className="rounded-full px-8" onClick={() => void add()} disabled={loading}>
        {loading ? "Adding…" : "Add to cart"}
      </Button>
      <Button
        type="button"
        variant="secondary"
        className="rounded-full px-8"
        disabled={loading}
        onClick={() => void add().then(() => router.push("/checkout"))}
      >
        Buy now
      </Button>
    </div>
  );
}
