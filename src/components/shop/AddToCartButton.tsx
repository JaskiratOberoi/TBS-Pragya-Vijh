"use client";

import { useState } from "react";
import { Button } from "@/components/ui/button";
import { useRouter } from "next/navigation";
import { cn } from "@/lib/utils";

export function AddToCartButton({
  productId,
  quantity = 1,
  className,
}: {
  productId: string;
  quantity?: number;
  className?: string;
}) {
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
    <div className={cn("flex w-full flex-col gap-3 sm:w-auto sm:flex-row sm:flex-wrap sm:items-stretch", className)}>
      <Button
        className="h-12 w-full rounded-full px-8 text-base sm:min-w-[200px]"
        onClick={() => void add()}
        disabled={loading}
      >
        {loading ? "Adding…" : "Add to cart"}
      </Button>
      <Button
        type="button"
        variant="secondary"
        className="h-12 w-full rounded-full border-border/80 px-8 sm:w-auto"
        disabled={loading}
        onClick={() => void add().then(() => router.push("/checkout"))}
      >
        Buy now
      </Button>
    </div>
  );
}
