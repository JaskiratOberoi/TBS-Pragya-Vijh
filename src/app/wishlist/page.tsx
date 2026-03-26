"use client";

import { useEffect, useState } from "react";
import { useSession } from "next-auth/react";
import Image from "next/image";
import Link from "next/link";
import { Button } from "@/components/ui/button";
import { formatINR } from "@/lib/utils";
import { effectiveUnitPrice } from "@/lib/promo-engine";

type Item = { id: string; product: { id: string; name: string; slug: string; price: number; salePrice: number | null; images: string[] } };

export default function WishlistPage() {
  const { status } = useSession();
  const [items, setItems] = useState<Item[]>([]);

  useEffect(() => {
    if (status !== "authenticated") return;
    void fetch("/api/wishlist", { credentials: "include" })
      .then((r) => r.json())
      .then((d) => setItems(d.items ?? []));
  }, [status]);

  if (status === "loading") return <div className="p-10 text-center">Loading…</div>;
  if (status === "unauthenticated") {
    return (
      <div className="mx-auto max-w-md px-4 py-12 text-center">
        <h1 className="font-serif text-2xl font-bold text-primary">Wishlist</h1>
        <p className="mt-4 text-muted-foreground">Sign in to save and sync your wishlist.</p>
        <Button className="mt-6" asChild>
          <Link href="/account">Sign in</Link>
        </Button>
      </div>
    );
  }

  return (
    <div className="mx-auto max-w-5xl px-4 py-10">
      <h1 className="font-serif text-3xl font-bold text-primary">Wishlist</h1>
      <div className="mt-8 grid gap-4 sm:grid-cols-2 md:grid-cols-3">
        {items.length === 0 && <p className="text-muted-foreground">No saved items.</p>}
        {items.map((w) => (
          <div key={w.id} className="overflow-hidden rounded-lg border">
            <Link href={`/shop/${w.product.slug}`} className="relative block aspect-square bg-muted">
              <Image src={w.product.images[0] ?? "/assets/products/placeholder.svg"} alt="" fill className="object-cover" />
            </Link>
            <div className="space-y-2 p-4">
              <Link href={`/shop/${w.product.slug}`} className="font-medium hover:underline">
                {w.product.name}
              </Link>
              <p className="text-sm text-primary">{formatINR(effectiveUnitPrice(w.product as Parameters<typeof effectiveUnitPrice>[0]))}</p>
              <div className="flex gap-2">
                <Button
                  size="sm"
                  onClick={() =>
                    void fetch("/api/cart", {
                      method: "POST",
                      headers: { "Content-Type": "application/json" },
                      credentials: "include",
                      body: JSON.stringify({ productId: w.product.id, quantity: 1 }),
                    }).then(() => window.dispatchEvent(new Event("cart:updated")))
                  }
                >
                  Add to cart
                </Button>
                <Button
                  size="sm"
                  variant="outline"
                  onClick={() =>
                    void fetch(`/api/wishlist?id=${w.id}`, { method: "DELETE", credentials: "include" }).then(() =>
                      setItems((xs) => xs.filter((x) => x.id !== w.id))
                    )
                  }
                >
                  Remove
                </Button>
              </div>
            </div>
          </div>
        ))}
      </div>
    </div>
  );
}
