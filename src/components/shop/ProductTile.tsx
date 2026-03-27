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
  const img = product.images[0] ?? "/assets/products/placeholder.svg";

  return (
    <MotionCard
      className={cn(
        "group overflow-hidden rounded-3xl border-0 bg-card shadow-bento transition-shadow hover:shadow-bento-sm",
        className
      )}
      whileHover={{ y: -3 }}
      whileTap={{ scale: 0.99 }}
      transition={{ type: "spring", stiffness: 420, damping: 28 }}
    >
      <div className="relative aspect-square overflow-hidden rounded-t-3xl bg-muted">
        <Link href={`/shop/${product.slug}`} className="absolute inset-0 z-0 block overflow-hidden">
          <Image
            src={img}
            alt={product.name}
            fill
            className="object-cover transition-transform duration-300 group-hover:scale-[1.04]"
            sizes="(max-width: 640px) 50vw, (max-width: 1280px) 33vw, 25vw"
          />
        </Link>
        <div className="pointer-events-none absolute inset-0 z-10">
          <div className="pointer-events-auto absolute right-2 top-2">
            <WishlistButton productId={product.id} variant="icon" />
          </div>
          {off > 0 && (
            <Badge className="pointer-events-auto absolute left-3 top-3 rounded-full px-2.5 py-0.5 shadow-sm" variant="destructive">
              -{off}%
            </Badge>
          )}
          {product.productType === "DIGITAL" && (
            <Badge
              className="pointer-events-auto absolute bottom-3 left-3 rounded-full bg-background/90 text-foreground backdrop-blur-sm"
              variant="secondary"
            >
              Digital
            </Badge>
          )}
          <div className="pointer-events-none absolute bottom-3 right-3">
            <span className="inline-flex min-w-[3.5rem] items-center justify-center rounded-full bg-primary px-3 py-1.5 text-sm font-semibold text-primary-foreground shadow-bento-sm">
              {formatINR(unitPricePaise)}
            </span>
          </div>
        </div>
      </div>
      <CardContent className="space-y-1.5 p-4 pt-3">
        <Link href={`/shop/${product.slug}`} className="line-clamp-2 font-medium leading-snug text-foreground hover:text-primary">
          {product.name}
        </Link>
        {product.salePrice != null && product.salePrice < product.price && (
          <p className="text-sm text-muted-foreground line-through">{formatINR(product.price)}</p>
        )}
      </CardContent>
    </MotionCard>
  );
}
