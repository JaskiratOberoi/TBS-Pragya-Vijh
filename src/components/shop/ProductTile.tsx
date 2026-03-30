"use client";

import Link from "next/link";
import Image from "next/image";
import { motion } from "framer-motion";
import { Card, CardContent } from "@/components/ui/card";
import { Badge } from "@/components/ui/badge";
import { formatINR } from "@/lib/utils";
import { WishlistButton } from "@/components/shop/WishlistButton";
import { cn } from "@/lib/utils";

const MotionCard = motion(Card);

export type ProductTileModel = {
  id: string;
  slug: string;
  name: string;
  images: string[];
  price: number;
  salePrice: number | null;
  productType?: "PHYSICAL" | "DIGITAL";
};

type Props = {
  product: ProductTileModel;
  unitPricePaise: number;
  className?: string;
};

export function ProductTile({ product, unitPricePaise, className }: Props) {
  const off =
    product.salePrice != null && product.salePrice < product.price
      ? Math.round((1 - product.salePrice / product.price) * 100)
      : 0;
  const onSale = product.salePrice != null && product.salePrice < product.price;
  const img = product.images[0] ?? "/assets/products/placeholder.svg";

  return (
    <MotionCard
      className={cn(
        "group overflow-hidden rounded-2xl border border-border/60 bg-card shadow-elevation-rest transition-shadow duration-300 hover:border-border hover:shadow-elevation-hover",
        className
      )}
      whileHover={{ y: -4 }}
      whileTap={{ scale: 0.995 }}
      transition={{ type: "spring", stiffness: 420, damping: 28 }}
    >
      <div className="relative aspect-[4/5] overflow-hidden rounded-t-2xl bg-muted">
        <Link href={`/shop/${product.slug}`} className="absolute inset-0 z-0 block overflow-hidden">
          <Image
            src={img}
            alt={product.name}
            fill
            className="object-cover transition-transform duration-500 group-hover:scale-[1.05]"
            sizes="(max-width: 640px) 50vw, (max-width: 1280px) 33vw, 25vw"
          />
        </Link>
        <div className="pointer-events-none absolute inset-0 z-10">
          <div className="pointer-events-auto absolute right-2 top-2">
            <WishlistButton productId={product.id} variant="icon" />
          </div>
          {off > 0 && (
            <Badge className="pointer-events-auto absolute left-3 top-3 border border-metal/30 px-2.5 py-0.5" variant="metal">
              −{off}%
            </Badge>
          )}
          {product.productType === "DIGITAL" && (
            <Badge
              className="pointer-events-auto absolute bottom-3 left-3 rounded-full border border-border/50 bg-background/90 text-foreground backdrop-blur-sm"
              variant="secondary"
            >
              Digital
            </Badge>
          )}
        </div>
      </div>
      <CardContent className="space-y-2 p-4 pt-3">
        <Link
          href={`/shop/${product.slug}`}
          className="line-clamp-2 font-medium leading-snug text-foreground transition-colors hover:text-primary"
        >
          {product.name}
        </Link>
        <div className="flex flex-wrap items-baseline gap-x-2 gap-y-0.5">
          {onSale && (
            <span className="text-sm text-muted-foreground line-through">{formatINR(product.price)}</span>
          )}
          <span
            className={cn(
              "font-display text-lg font-semibold tabular-nums",
              onSale ? "text-metal-muted" : "text-foreground"
            )}
          >
            {formatINR(unitPricePaise)}
          </span>
        </div>
      </CardContent>
    </MotionCard>
  );
}
