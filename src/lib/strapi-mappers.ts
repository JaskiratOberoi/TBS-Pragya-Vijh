import type { ProductTileModel } from "@/components/shop/ProductTile";

export function toProductTileModel(p: Record<string, unknown>): ProductTileModel {
  const imgs = p.images;
  const images: string[] = Array.isArray(imgs)
    ? imgs.map((x) => String(x))
    : typeof imgs === "string"
      ? [imgs]
      : [];
  return {
    id: String(p.id ?? p.documentId ?? ""),
    slug: String(p.slug ?? ""),
    name: String(p.name ?? ""),
    images,
    price: Number(p.price ?? 0),
    salePrice: p.salePrice != null ? Number(p.salePrice) : null,
    productType: p.productType as ProductTileModel["productType"],
  };
}
