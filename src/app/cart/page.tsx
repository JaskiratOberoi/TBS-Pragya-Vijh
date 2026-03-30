"use client";

import { useEffect, useState, useCallback } from "react";
import Image from "next/image";
import Link from "next/link";
import { Button } from "@/components/ui/button";
import { formatINR } from "@/lib/utils";
import { effectiveUnitPrice } from "@/lib/promo-engine";
import { LoadingScreen } from "@/components/shared/LoadingSpinner";

type Line = {
  id: string;
  quantity: number;
  product: { name: string; slug: string; images: string[]; price: number; salePrice: number | null };
};

export default function CartPage() {
  const [data, setData] = useState<{
    items: Line[];
    summary: { subtotalPaise: number; promoDiscountPaise: number; totalPaise: number };
  } | null>(null);

  const load = useCallback(() => {
    void fetch("/api/cart", { credentials: "include" })
      .then((r) => r.json())
      .then(setData);
  }, []);

  useEffect(() => {
    load();
  }, [load]);

  if (!data) return <LoadingScreen label="Loading cart" />;

  return (
    <div className="mx-auto max-w-4xl px-4 py-10 md:py-14">
      <p className="text-xs font-medium uppercase tracking-luxury text-muted-foreground">Bag</p>
      <h1 className="mt-2 font-display text-3xl font-semibold tracking-display text-foreground md:text-4xl">
        Shopping cart
      </h1>
      {data.items.length === 0 ? (
        <div className="mt-10 rounded-2xl border border-border/60 bg-card p-8 shadow-elevation-rest">
          <p className="text-muted-foreground">
            Your cart is empty.{" "}
            <Link href="/shop" className="font-medium text-primary underline-offset-4 hover:underline">
              Continue shopping
            </Link>
          </p>
        </div>
      ) : (
        <>
          <ul className="mt-10 divide-y divide-border/60 rounded-2xl border border-border/60 bg-card shadow-elevation-rest">
            {data.items.map((line) => {
              const unit = effectiveUnitPrice(line.product as Parameters<typeof effectiveUnitPrice>[0]);
              return (
                <li key={line.id} className="flex flex-wrap items-center gap-4 p-4 first:rounded-t-2xl last:rounded-b-2xl sm:p-5">
                  <Link
                    href={`/shop/${line.product.slug}`}
                    className="relative h-24 w-20 shrink-0 overflow-hidden rounded-dense border border-border/50 bg-muted"
                  >
                    <Image
                      src={line.product.images[0] ?? "/assets/products/placeholder.svg"}
                      alt=""
                      fill
                      className="object-cover"
                      sizes="80px"
                    />
                  </Link>
                  <div className="min-w-0 flex-1">
                    <Link href={`/shop/${line.product.slug}`} className="font-medium hover:text-primary">
                      {line.product.name}
                    </Link>
                    <p className="mt-1 font-display text-sm font-semibold text-foreground">{formatINR(unit)} each</p>
                  </div>
                  <div className="flex items-center gap-2">
                    <Button
                      size="sm"
                      variant="outline"
                      type="button"
                      className="h-9 w-9 rounded-full border-border/80 p-0"
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
                    <span className="w-8 text-center text-sm tabular-nums">{line.quantity}</span>
                    <Button
                      size="sm"
                      variant="outline"
                      type="button"
                      className="h-9 w-9 rounded-full border-border/80 p-0"
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
                      className="text-destructive hover:text-destructive"
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
          <div className="mt-8 rounded-2xl border border-border/60 bg-card p-6 shadow-elevation-rest md:p-8">
            <h2 className="font-display text-lg font-semibold tracking-display">Order summary</h2>
            <div className="mt-6 flex justify-between text-sm">
              <span className="text-muted-foreground">Subtotal</span>
              <span className="tabular-nums">{formatINR(data.summary.subtotalPaise)}</span>
            </div>
            {data.summary.promoDiscountPaise > 0 && (
              <div className="mt-2 flex justify-between text-sm text-emerald-700 dark:text-emerald-400">
                <span>Promotions (Buy 3 Get 1, etc.)</span>
                <span className="tabular-nums">−{formatINR(data.summary.promoDiscountPaise)}</span>
              </div>
            )}
            <div className="mt-4 flex justify-between border-t border-border/60 pt-4 font-display text-lg font-semibold">
              <span>Estimated total</span>
              <span className="tabular-nums">{formatINR(data.summary.totalPaise)}</span>
            </div>
            <p className="mt-2 text-xs text-muted-foreground">Shipping &amp; GST finalized at checkout.</p>
            <Button className="mt-8 h-12 w-full rounded-full text-base" asChild>
              <Link href="/checkout">Proceed to checkout</Link>
            </Button>
          </div>
        </>
      )}
    </div>
  );
}
