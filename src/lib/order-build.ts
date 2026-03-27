import type { Product, ShippingClass } from "@prisma/client";
import { effectiveUnitPrice, buildPromoSummary, type CartLine } from "@/lib/promo-engine";
import { computeShippingForPhysicalItems, cartHasPhysical } from "@/lib/shipping";
import { aggregateOrderGst } from "@/lib/gst";

export type CartRow = {
  productId: string;
  quantity: number;
  variantSelection: unknown;
  product: Product & { shippingClass: ShippingClass | null };
};

export function rowsToCartLines(rows: CartRow[]): CartLine[] {
  return rows.map((r) => ({
    productId: r.productId,
    slug: r.product.slug,
    quantity: r.quantity,
    unitPricePaise: effectiveUnitPrice(r.product),
    productType: r.product.productType,
  }));
}

export function computeOrderTotals(
  rows: CartRow[],
  opts: {
    giftProductId: string;
    couponDiscountPaise?: number;
    sellerStateCode: string;
    buyerStateCode: string;
  }
) {
  const lines = rowsToCartLines(rows);
  const promo = buildPromoSummary(lines, {
    thresholdPaise: 149900,
    giftProductId: opts.giftProductId,
    giftUnitPricePaise: 0,
  });
  const subAfterB3 = promo.subtotalPaise - promo.buyXGetYDiscountPaise;
  const couponDisc = Math.min(opts.couponDiscountPaise ?? 0, subAfterB3);
  const afterCoupon = subAfterB3 - couponDisc;
  const shipping = cartHasPhysical(rows) ? computeShippingForPhysicalItems(rows, afterCoupon) : 0;
  const gstLines = rows.flatMap((r) => {
    const unit = effectiveUnitPrice(r.product);
    const lineTotal = unit * r.quantity;
    const share = promo.subtotalPaise > 0 ? lineTotal / promo.subtotalPaise : 0;
    const lineDiscount = Math.round((promo.buyXGetYDiscountPaise + couponDisc) * share);
    const taxable = Math.max(0, lineTotal - lineDiscount);
    return [
      {
        taxablePaise: taxable,
        gstRateBps: r.product.gstRateBps,
        sellerStateCode: opts.sellerStateCode,
        buyerStateCode: opts.buyerStateCode,
      },
    ];
  });
  const { cgst, sgst, igst, totalTax } = aggregateOrderGst(gstLines);
  const total = afterCoupon + shipping + totalTax;
  return {
    subtotalPaise: promo.subtotalPaise,
    promoDiscountPaise: promo.buyXGetYDiscountPaise,
    couponDiscountPaise: couponDisc,
    shippingPaise: shipping,
    taxPaise: totalTax,
    totalPaise: total,
    giftProductIds: promo.giftLines.map((g) => g.productId).filter(Boolean),
  };
}
