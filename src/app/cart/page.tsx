"use client";

import { useEffect, useState, useCallback } from "react";
import Image from "next/image";
import Link from "next/link";
import { Button } from "@/components/ui/button";
import { formatINR } from "@/lib/utils";
import { effectiveUnitPrice } from "@/lib/promo-engine";

type Line = {
  id: string;
  quantity: number;
  product: { name: string; slug: string; images: string[]; price: number; salePrice: number | null };
};

export default function CartPage() {
  const [data, setData] = useState<{ items: Line[]; summary: { subtotalPaise: number; promoDiscountPaise: number; totalPaise: number } } | null>(null);

  const load = useCallback(() => {
    void fetch("/api/cart", { credentials: "include" })
      .then((r) => r.json())
      .then(setData);
  }, []);

  useEffect(() => {
    load();
  }, [load]);

  if (!data) return <div className="p-10 text-center text-muted-foreground">Loading cart…</div>;

  return (
    <div className="mx-auto max-w-4xl px-4 py-10">
      <h1 className="font-serif text-3xl font-bold text-primary">Shopping cart</h1>
      {data.items.length === 0 ? (
        <p className="mt-6 text-muted-foreground">
          Your cart is empty.{" "}
          <Link href="/shop" className="text-primary underline">
            Continue shopping
          </Link>
        </p>
      ) : (
        <>
          <ul className="mt-8 divide-y">
            {data.items.map((line) => {
              const unit = effectiveUnitPrice(line.product as Parameters<typeof effectiveUnitPrice>[0]);
              return (
                <li key={line.id} className="flex flex-wrap items-center gap-4 py-4">
                  <Link href={`/shop/${line.product.slug}`} className="relative h-20 w-20 shrink-0 overflow-hidden rounded-md bg-muted">
                    <Image src={line.product.images[0] ?? "/assets/products/placeholder.svg"} alt="" fill className="object-cover" />
                  </Link>
                  <div className="min-w-0 flex-1">
                    <Link href={`/shop/${line.product.slug}`} className="font-medium hover:underline">
                      {line.product.name}
                    </Link>
                    <p className="text-sm text-primary">{formatINR(unit)}</p>
                  </div>
                  <div className="flex items-center gap-2">
                    <Button
                      size="sm"
                      variant="outline"
                      type="button"
                      onClick={() =>
                        void fetch("/api/cart", {
                          method: "PATCH",
                          headers: { "Content-Type": "application/json" },
                          credentials: "include",
                          body: JSON.stringify({ itemId: line.id, quantity: line.quantity - 1 }),
                        }).then(load)
                      }
                    >
                      −
                    </Button>
                    <span className="w-8 text-center text-sm">{line.quantity}</span>
                    <Button
                      size="sm"
                      variant="outline"
                      type="button"
                      onClick={() =>
                        void fetch("/api/cart", {
                          method: "PATCH",
                          headers: { "Content-Type": "application/json" },
                          credentials: "include",
                          body: JSON.stringify({ itemId: line.id, quantity: line.quantity + 1 }),
                        }).then(load)
                      }
                    >
                      +
                    </Button>
                    <Button
                      size="sm"
                      variant="ghost"
                      type="button"
                      className="text-destructive"
                      onClick={() =>
                        void fetch(`/api/cart?itemId=${line.id}`, { method: "DELETE", credentials: "include" }).then(load)
                      }
                    >
                      Remove
                    </Button>
                  </div>
                </li>
              );
            })}
          </ul>
          <div className="mt-8 rounded-lg border p-6">
            <div className="flex justify-between text-sm">
              <span>Subtotal</span>
              <span>{formatINR(data.summary.subtotalPaise)}</span>
            </div>
            {data.summary.promoDiscountPaise > 0 && (
              <div className="mt-2 flex justify-between text-sm text-green-700">
                <span>Promotions (Buy 3 Get 1, etc.)</span>
                <span>−{formatINR(data.summary.promoDiscountPaise)}</span>
              </div>
            )}
            <div className="mt-4 flex justify-between border-t pt-4 font-semibold">
              <span>Estimated total</span>
              <span>{formatINR(data.summary.totalPaise)}</span>
            </div>
            <p className="mt-2 text-xs text-muted-foreground">Shipping &amp; GST finalized at checkout.</p>
            <Button className="mt-6 w-full" asChild>
              <Link href="/checkout">Proceed to checkout</Link>
            </Button>
          </div>
        </>
      )}
    </div>
  );
}
