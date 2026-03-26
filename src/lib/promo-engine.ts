import type { Product } from "@prisma/client";

export type CartLine = {
  productId: string;
  slug: string;
  quantity: number;
  unitPricePaise: number; // after sale price
  productType: string;
};

export type PromoResult = {
  subtotalPaise: number;
  buyXGetYDiscountPaise: number;
  giftLines: { productId: string; quantity: number; unitPricePaise: number }[];
  /** IDs of cart lines that are "paid" product units for B3G1 (excludes gift product) */
  b3g1FreePaise: number;
};

const GIFT_SLUG = "money-potli-gift";

function effectiveUnitPrice(p: Product) {
  return p.salePrice != null && p.salePrice < p.price ? p.salePrice : p.price;
}

export function computeLineTotals(lines: CartLine[]): { subtotal: number } {
  const subtotal = lines.reduce((s, l) => s + l.unitPricePaise * l.quantity, 0);
  return { subtotal };
}

/** Apply Buy 3 Get 1 on cheapest qualifying unit among paid crystal lines (excludes gift slug & digital-only promos scope). */
export function applyBuy3Get1(lines: CartLine[]): number {
  const qualifying = lines.filter((l) => l.slug !== GIFT_SLUG && l.productType !== "DIGITAL");
  const units: number[] = [];
  for (const l of qualifying) {
    for (let i = 0; i < l.quantity; i++) units.push(l.unitPricePaise);
  }
  if (units.length < 4) return 0;
  units.sort((a, b) => a - b);
  const freeGroups = Math.floor(units.length / 4);
  let discount = 0;
  for (let g = 0; g < freeGroups; g++) {
    discount += units[g * 4];
  }
  return discount;
}

export function freeGiftThresholdMet(subtotalAfterB3G1: number, thresholdPaise: number) {
  return subtotalAfterB3G1 >= thresholdPaise;
}

export function buildPromoSummary(
  lines: CartLine[],
  opts: { thresholdPaise: number; giftProductId: string; giftUnitPricePaise: number }
): PromoResult {
  const { subtotal } = computeLineTotals(lines);
  const b3g1 = applyBuy3Get1(lines);
  const afterB3 = subtotal - b3g1;
  const giftLines: PromoResult["giftLines"] = [];
  if (afterB3 >= opts.thresholdPaise) {
    giftLines.push({ productId: opts.giftProductId, quantity: 1, unitPricePaise: opts.giftUnitPricePaise });
  }
  return {
    subtotalPaise: subtotal,
    buyXGetYDiscountPaise: b3g1,
    giftLines,
    b3g1FreePaise: b3g1,
  };
}

export { effectiveUnitPrice, GIFT_SLUG };
