import type { ProductLike, ShippingClassLike } from "@/lib/types/commerce";

export function computeShippingForPhysicalItems(
  items: { product: ProductLike & { shippingClass?: ShippingClassLike | null }; quantity: number }[],
  subtotalPaiseAfterDiscounts: number
): number {
  let maxFee = 0;
  for (const row of items) {
    if (row.product.productType === "DIGITAL") continue;
    const sc = row.product.shippingClass;
    if (!sc) continue;
    const rate = sc.rate;
    const freeAbove = sc.freeAbove;
    if (freeAbove != null && subtotalPaiseAfterDiscounts >= freeAbove) {
      maxFee = Math.max(maxFee, 0);
    } else {
      maxFee = Math.max(maxFee, rate);
    }
  }
  return maxFee;
}

export function cartHasPhysical(
  items: { product: { productType: string }; quantity: number }[]
): boolean {
  return items.some((i) => i.quantity > 0 && i.product.productType === "PHYSICAL");
}
