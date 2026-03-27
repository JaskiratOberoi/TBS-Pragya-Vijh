import { NextResponse } from "next/server";
import { getServerSession } from "next-auth";
import { authOptions } from "@/lib/auth";
import { strapiFetch, commerceCreateOrder } from "@/lib/strapi";
import { loadCartItems, resolveCartOwner } from "@/lib/cart-query";
import { computeOrderTotals } from "@/lib/order-build";
import { createRzpOrder } from "@/lib/razorpay";
import { validateCouponForCart } from "@/lib/coupon-validator";
import { rowsToCartLines } from "@/lib/order-build";
import { effectiveUnitPrice } from "@/lib/promo-engine";
import {
  countCouponUsagesForGuest,
  countCouponUsagesForUser,
  findCouponByCode,
  findProductBySlug,
  getBusinessSettings,
} from "@/lib/strapi-queries";

function normEmail(s: string) {
  return s.trim().toLowerCase();
}

export async function POST(req: Request) {
  const session = await getServerSession(authOptions);
  const owner = await resolveCartOwner();
  if (!owner) {
    return NextResponse.json({ error: "Cart session required — add items from the shop first" }, { status: 400 });
  }

  const body = (await req.json()) as {
    shippingAddress?: Record<string, string>;
    billingAddress?: Record<string, string>;
    couponCode?: string;
    guestName?: string;
    guestEmail?: string;
    guestPhone?: string;
  };

  const rows = await loadCartItems(owner);
  if (rows.length === 0) return NextResponse.json({ error: "Cart empty" }, { status: 400 });

  const userId = session?.user?.id ?? null;
  let guestName: string | null = null;
  let guestEmail: string | null = null;
  let guestPhone: string | null = null;

  if (!userId) {
    const gn = body.guestName?.trim();
    const ge = body.guestEmail?.trim();
    const gp = body.guestPhone?.trim();
    if (!gn || !ge || !gp) {
      return NextResponse.json({ error: "Name, email, and phone are required for checkout" }, { status: 400 });
    }
    if (!/^[^\s@]+@[^\s@]+\.[^\s@]+$/.test(ge)) {
      return NextResponse.json({ error: "Invalid email" }, { status: 400 });
    }
    guestName = gn;
    guestEmail = normEmail(ge);
    guestPhone = gp;
  }

  const gift = await findProductBySlug("money-potli-gift");
  const business = await getBusinessSettings();
  const sellerState = (business?.stateCode as string) ?? "07";

  const hasPhysical = rows.some((r) => r.product.productType === "PHYSICAL");
  if (hasPhysical && !body.shippingAddress) {
    return NextResponse.json({ error: "Shipping address required" }, { status: 400 });
  }

  const buyerStateCode = (body.shippingAddress?.stateCode as string) || "07";

  let couponDiscountPaise = 0;
  let couponDocumentId: string | undefined;
  if (body.couponCode) {
    const c = await findCouponByCode(body.couponCode.trim().toUpperCase());
    if (!c) return NextResponse.json({ error: "Invalid coupon" }, { status: 400 });
    const uses = userId
      ? await countCouponUsagesForUser(c.id, userId)
      : await countCouponUsagesForGuest(c.id, guestEmail ?? "");
    const lines = rowsToCartLines(rows as Parameters<typeof rowsToCartLines>[0]);
    const sub = lines.reduce((s, l) => s + l.unitPricePaise * l.quantity, 0);
    const v = validateCouponForCart(c, lines, sub, uses);
    if (!v.ok) return NextResponse.json({ error: v.message }, { status: 400 });
    if (c.discountType !== "FREE_SHIPPING") couponDiscountPaise = v.discountPaise;
    couponDocumentId = c.id;
  }

  const totals = computeOrderTotals(rows as Parameters<typeof computeOrderTotals>[0], {
    giftProductId: gift?.id ?? "",
    couponDiscountPaise,
    sellerStateCode: sellerState,
    buyerStateCode,
  });

  const linesPayload = rows.map((r) => ({
    productDocumentId: r.productId,
    quantity: r.quantity,
    variantSelection: r.variantSelection,
    unitPrice: effectiveUnitPrice(r.product),
    gstRateBps: r.product.gstRateBps,
    hsnCode: r.product.hsnCode ?? undefined,
  }));

  let giftLine: Record<string, unknown> | null = null;
  if (totals.giftProductIds.length && gift) {
    giftLine = {
      productDocumentId: gift.id,
      gstRateBps: gift.gstRateBps,
      hsnCode: gift.hsnCode ?? undefined,
    };
  }

  let orderId: string;
  try {
    const created = await commerceCreateOrder({
      userDocumentId: userId,
      guestName,
      guestEmail,
      guestPhone,
      shippingAddress: body.shippingAddress,
      billingAddress: body.billingAddress ?? body.shippingAddress,
      couponDocumentId,
      lines: linesPayload,
      giftLine,
      totals: {
        totalPaise: totals.totalPaise,
        subtotalPaise: totals.subtotalPaise,
        promoDiscountPaise: totals.promoDiscountPaise,
        couponDiscountPaise: totals.couponDiscountPaise,
        taxPaise: totals.taxPaise,
        shippingPaise: totals.shippingPaise,
      },
    });
    orderId = created.orderId;
  } catch (e) {
    const msg = e instanceof Error ? e.message : "Order create failed";
    return NextResponse.json({ error: msg }, { status: 500 });
  }

  try {
    const rzp = await createRzpOrder(totals.totalPaise, orderId, { orderId });
    await strapiFetch(`/api/orders/${orderId}`, {
      method: "PUT",
      body: JSON.stringify({ data: { rzpOrderId: rzp.id } }),
    });
    return NextResponse.json({
      orderId,
      rzpOrderId: rzp.id,
      amount: totals.totalPaise,
      key: process.env.RAZORPAY_KEY_ID,
      currency: "INR",
    });
  } catch (e) {
    try {
      await strapiFetch(`/api/orders/${orderId}`, { method: "DELETE" });
    } catch {
      /* ignore */
    }
    const msg = e instanceof Error ? e.message : "Payment init failed";
    return NextResponse.json({ error: msg }, { status: 500 });
  }
}
