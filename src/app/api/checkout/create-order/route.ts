import { NextResponse } from "next/server";
import { getServerSession } from "next-auth";
import { authOptions } from "@/lib/auth";
import { prisma } from "@/lib/prisma";
import { loadCartItems, resolveCartOwner } from "@/lib/cart-query";
import { computeOrderTotals } from "@/lib/order-build";
import { createRzpOrder } from "@/lib/razorpay";
import { validateCouponForCart } from "@/lib/coupon-validator";
import { rowsToCartLines } from "@/lib/order-build";
import { effectiveUnitPrice } from "@/lib/promo-engine";

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

  const gift = await prisma.product.findUnique({ where: { slug: "money-potli-gift" } });
  const business = await prisma.businessSettings.findUnique({ where: { id: "singleton" } });
  const sellerState = business?.stateCode ?? "07";

  const hasPhysical = rows.some((r) => r.product.productType === "PHYSICAL");
  if (hasPhysical && !body.shippingAddress) {
    return NextResponse.json({ error: "Shipping address required" }, { status: 400 });
  }

  const buyerStateCode = (body.shippingAddress?.stateCode as string) || "07";

  let couponDiscountPaise = 0;
  let couponId: string | undefined;
  if (body.couponCode) {
    const c = await prisma.couponCode.findUnique({ where: { code: body.couponCode.trim().toUpperCase() } });
    if (!c) return NextResponse.json({ error: "Invalid coupon" }, { status: 400 });
    const uses = userId
      ? await prisma.couponUsage.count({ where: { couponId: c.id, userId } })
      : await prisma.couponUsage.count({
          where: { couponId: c.id, guestEmail: guestEmail ?? "" },
        });
    const lines = rowsToCartLines(rows as Parameters<typeof rowsToCartLines>[0]);
    const sub = lines.reduce((s, l) => s + l.unitPricePaise * l.quantity, 0);
    const v = validateCouponForCart(c, lines, sub, uses);
    if (!v.ok) return NextResponse.json({ error: v.message }, { status: 400 });
    if (c.discountType !== "FREE_SHIPPING") couponDiscountPaise = v.discountPaise;
    couponId = c.id;
  }

  const totals = computeOrderTotals(rows as Parameters<typeof computeOrderTotals>[0], {
    giftProductId: gift?.id ?? "",
    couponDiscountPaise,
    sellerStateCode: sellerState,
    buyerStateCode,
  });

  const order = await prisma.order.create({
    data: {
      userId,
      guestName,
      guestEmail,
      guestPhone,
      status: "PENDING",
      paymentStatus: "PENDING",
      subtotal: totals.subtotalPaise,
      discount: totals.promoDiscountPaise + totals.couponDiscountPaise,
      couponId,
      tax: totals.taxPaise,
      shippingAmount: totals.shippingPaise,
      total: totals.totalPaise,
      shippingAddress: body.shippingAddress ?? undefined,
      billingAddress: body.billingAddress ?? body.shippingAddress ?? undefined,
      items: {
        create: [
          ...rows.map((r) => ({
            productId: r.productId,
            quantity: r.quantity,
            variantSelection: r.variantSelection as object | undefined,
            unitPrice: effectiveUnitPrice(r.product),
            gstRateBps: r.product.gstRateBps,
            hsnCode: r.product.hsnCode ?? undefined,
          })),
          ...(totals.giftProductIds.length && gift
            ? [
                {
                  productId: gift.id,
                  quantity: 1,
                  unitPrice: 0,
                  gstRateBps: gift.gstRateBps,
                  hsnCode: gift.hsnCode ?? undefined,
                },
              ]
            : []),
        ],
      },
    },
  });

  try {
    const rzp = await createRzpOrder(totals.totalPaise, order.id, { orderId: order.id });
    await prisma.order.update({ where: { id: order.id }, data: { rzpOrderId: rzp.id } });
    return NextResponse.json({
      orderId: order.id,
      rzpOrderId: rzp.id,
      amount: totals.totalPaise,
      key: process.env.RAZORPAY_KEY_ID,
      currency: "INR",
    });
  } catch (e) {
    await prisma.order.delete({ where: { id: order.id } });
    const msg = e instanceof Error ? e.message : "Payment init failed";
    return NextResponse.json({ error: msg }, { status: 500 });
  }
}
