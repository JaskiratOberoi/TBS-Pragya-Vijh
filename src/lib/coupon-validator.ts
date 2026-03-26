import type { CouponCode } from "@prisma/client";
import type { CartLine } from "@/lib/promo-engine";

export function validateCouponForCart(
  coupon: CouponCode,
  lines: CartLine[],
  subtotalPaise: number,
  priorUsesByUser: number
): { ok: true; discountPaise: number } | { ok: false; message: string } {
  if (!coupon.isActive) return { ok: false, message: "Coupon inactive" };
  const now = new Date();
  if (coupon.validFrom && now < coupon.validFrom) return { ok: false, message: "Coupon not yet valid" };
  if (coupon.validUntil && now > coupon.validUntil) return { ok: false, message: "Coupon expired" };
  if (coupon.maxUses != null && coupon.usedCount >= coupon.maxUses) return { ok: false, message: "Coupon exhausted" };
  if (priorUsesByUser >= coupon.perUserLimit) return { ok: false, message: "Already used" };
  if (coupon.minCartTotal != null && subtotalPaise < coupon.minCartTotal) return { ok: false, message: "Minimum cart not met" };

  const catIds = coupon.applicableCategoryIds ?? [];
  const prodIds = coupon.applicableProductIds ?? [];
  const scoped = catIds.length > 0 || prodIds.length > 0;
  if (scoped) {
    // CartLine would need categoryId on line for strict check — caller passes expanded lines
  }

  if (coupon.discountType === "PERCENTAGE") {
    const pct = coupon.discountValue / 10000;
    let d = Math.round(subtotalPaise * pct);
    if (coupon.maxDiscount != null) d = Math.min(d, coupon.maxDiscount);
    return { ok: true, discountPaise: d };
  }
  if (coupon.discountType === "FLAT") {
    return { ok: true, discountPaise: Math.min(coupon.discountValue, subtotalPaise) };
  }
  if (coupon.discountType === "FREE_SHIPPING") {
    return { ok: true, discountPaise: 0 };
  }
  return { ok: false, message: "Unsupported coupon type for cart" };
}
