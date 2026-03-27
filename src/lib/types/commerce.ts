/** Minimal product shape for promos, shipping, GST (replaces Prisma types). */
export type ProductLike = {
  id: string;
  /** Strapi v5 document id when distinct from numeric `id` */
  documentId?: string;
  name?: string;
  slug: string;
  productType: "PHYSICAL" | "DIGITAL";
  price: number;
  salePrice: number | null;
  stock?: number;
  isActive?: boolean;
  images?: unknown;
  gstRateBps: number;
  hsnCode?: string | null;
  shippingClass?: ShippingClassLike | null;
};

export type ShippingClassLike = {
  rate: number;
  freeAbove: number | null;
};

export type CouponCodeLike = {
  id: string;
  code: string;
  discountType: "PERCENTAGE" | "FLAT" | "BUY_X_GET_Y" | "FREE_SHIPPING";
  discountValue: number;
  minCartTotal: number | null;
  maxDiscount: number | null;
  maxUses: number | null;
  usedCount: number;
  perUserLimit: number;
  validFrom: string | null;
  validUntil: string | null;
  isActive: boolean;
  applicableCategoryIds: unknown;
  applicableProductIds: unknown;
};
