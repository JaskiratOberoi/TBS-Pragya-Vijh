import type { Product } from "@prisma/client";

/** Props shape for the client ProductForm when editing an existing row. */
export type ProductFormInitial = {
  id: string;
  name: string;
  slug: string;
  description: string;
  categoryId: string;
  productType: "PHYSICAL" | "DIGITAL";
  priceRupees: number;
  salePriceRupees: number | null;
  stock: number;
  images: string[];
  healingProperties: string | null;
  wearHand: string | null;
  shippingClassId: string | null;
  hsnCode: string | null;
  gstRateBps: number;
  isActive: boolean;
};

function paiseToRupees(paise: number) {
  return Math.round(paise / 100);
}

/** Map Prisma Product → form initial state (must live outside `"use client"` for RSC imports). */
export function productToFormInitial(p: Product): ProductFormInitial {
  return {
    id: p.id,
    name: p.name,
    slug: p.slug,
    description: p.description,
    categoryId: p.categoryId,
    productType: p.productType,
    priceRupees: paiseToRupees(p.price),
    salePriceRupees: p.salePrice != null ? paiseToRupees(p.salePrice) : null,
    stock: p.stock,
    images: p.images,
    healingProperties: p.healingProperties,
    wearHand: p.wearHand,
    shippingClassId: p.shippingClassId,
    hsnCode: p.hsnCode,
    gstRateBps: p.gstRateBps,
    isActive: p.isActive,
  };
}
