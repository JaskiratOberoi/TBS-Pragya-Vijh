import { z } from "zod";

const rupeesToPaise = (r: number) => Math.round(r * 100);

export const adminProductBodySchema = z.object({
  name: z.string().min(1, "Name is required"),
  slug: z.string().min(1).optional(),
  description: z.string().min(1, "Description is required"),
  categoryId: z.string().min(1),
  productType: z.enum(["PHYSICAL", "DIGITAL"]),
  priceRupees: z.number().int().nonnegative(),
  salePriceRupees: z.number().int().nonnegative().nullable().optional(),
  stock: z.number().int().min(0),
  images: z.array(z.string().min(1)).optional().default([]),
  healingProperties: z.string().nullable().optional(),
  wearHand: z.string().nullable().optional(),
  shippingClassId: z.string().nullable().optional(),
  hsnCode: z.string().nullable().optional(),
  gstRateBps: z.number().int().min(0).max(30000).optional(),
  isActive: z.boolean().optional(),
});

export type AdminProductBody = z.infer<typeof adminProductBodySchema>;

export function bodyToPrismaData(
  parsed: AdminProductBody,
  slug: string
): {
  name: string;
  slug: string;
  description: string;
  categoryId: string;
  productType: "PHYSICAL" | "DIGITAL";
  price: number;
  salePrice: number | null;
  stock: number;
  images: string[];
  healingProperties: string | null;
  wearHand: string | null;
  shippingClassId: string | null;
  hsnCode: string | null;
  gstRateBps: number;
  isActive: boolean;
} {
  const price = rupeesToPaise(parsed.priceRupees);
  let salePrice: number | null = null;
  if (parsed.salePriceRupees != null && parsed.salePriceRupees > 0) {
    salePrice = rupeesToPaise(parsed.salePriceRupees);
    if (salePrice >= price) {
      throw new Error("Sale price must be less than regular price");
    }
  }
  const images =
    parsed.images && parsed.images.length > 0
      ? parsed.images
      : ["/assets/products/placeholder.svg"];
  return {
    name: parsed.name.trim(),
    slug,
    description: parsed.description.trim(),
    categoryId: parsed.categoryId,
    productType: parsed.productType,
    price,
    salePrice,
    stock: parsed.stock,
    images,
    healingProperties: parsed.healingProperties?.trim() || null,
    wearHand: parsed.wearHand?.trim() || null,
    shippingClassId: parsed.shippingClassId || null,
    hsnCode: parsed.hsnCode?.trim() || null,
    gstRateBps: parsed.gstRateBps ?? 1800,
    isActive: parsed.isActive ?? true,
  };
}
