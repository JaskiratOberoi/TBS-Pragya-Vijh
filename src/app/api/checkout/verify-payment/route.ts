import { NextResponse } from "next/server";
import { cookies } from "next/headers";
import { prisma } from "@/lib/prisma";
import { verifySignature, fetchPaymentDetails } from "@/lib/razorpay";
import { sendRawEmail } from "@/lib/email";
import { CART_COOKIE } from "@/lib/cart-session";

export async function POST(req: Request) {
  const body = (await req.json()) as {
    orderId?: string;
    rzpOrderId?: string;
    rzpPaymentId?: string;
    rzpSignature?: string;
  };
  if (!body.orderId || !body.rzpOrderId || !body.rzpPaymentId || !body.rzpSignature) {
    return NextResponse.json({ error: "Missing fields" }, { status: 400 });
  }

  if (!verifySignature(body.rzpOrderId, body.rzpPaymentId, body.rzpSignature)) {
    return NextResponse.json({ error: "Invalid signature" }, { status: 400 });
  }

  const order = await prisma.order.findUnique({
    where: { id: body.orderId },
    include: { items: { include: { product: true } }, user: true },
  });
  if (!order) return NextResponse.json({ error: "Order not found" }, { status: 404 });
  if (order.rzpOrderId !== body.rzpOrderId) {
    return NextResponse.json({ error: "Order mismatch" }, { status: 400 });
  }
  if (order.paymentStatus === "PAID") {
    return NextResponse.json({ ok: true, orderId: order.id });
  }

  const customerEmail = order.user?.email ?? order.guestEmail;
  if (!customerEmail) {
    return NextResponse.json({ error: "Order has no customer email" }, { status: 400 });
  }

  const payment = await fetchPaymentDetails(body.rzpPaymentId);
  const paidAmount = payment && "amount" in payment ? Number((payment as { amount: number }).amount) : 0;
  if (paidAmount && paidAmount !== order.total) {
    return NextResponse.json({ error: "Amount mismatch" }, { status: 400 });
  }

  const business = await prisma.businessSettings.findUnique({ where: { id: "singleton" } });
  if (!business) return NextResponse.json({ error: "Business settings missing" }, { status: 500 });

  const invoiceNumber = `${business.invoicePrefix}-${business.nextInvoiceNumber}`;

  const cookieStore = cookies();
  const rawSid = cookieStore.get(CART_COOKIE)?.value;
  const sessionId = rawSid ? decodeURIComponent(rawSid) : undefined;

  await prisma.$transaction(async (tx) => {
    await tx.order.update({
      where: { id: order.id },
      data: {
        paymentStatus: "PAID",
        status: "PROCESSING",
        rzpPaymentId: body.rzpPaymentId,
        rzpSignature: body.rzpSignature,
        paymentMethod: payment && "method" in payment ? String((payment as { method: string }).method) : undefined,
      },
    });

    for (const line of order.items) {
      if (line.product.productType === "PHYSICAL" && line.product.slug !== "money-potli-gift") {
        await tx.product.update({
          where: { id: line.productId },
          data: { stock: { decrement: line.quantity } },
        });
      }
    }

    await tx.businessSettings.update({
      where: { id: "singleton" },
      data: { nextInvoiceNumber: { increment: 1 } },
    });

    const buyerName = order.user?.name ?? order.user?.email ?? order.guestName ?? order.guestEmail ?? "Customer";
    const ship = (order.shippingAddress as Record<string, string> | null) ?? {};
    await tx.invoice.create({
      data: {
        invoiceNumber,
        orderId: order.id,
        buyerName,
        buyerAddress: order.shippingAddress ?? {},
        buyerState: ship.state ?? business.state,
        buyerStateCode: ship.stateCode ?? business.stateCode,
        items: order.items as unknown as object[],
        subtotal: order.subtotal,
        cgst: Math.round(order.tax / 2),
        sgst: order.tax - Math.round(order.tax / 2),
        igst: 0,
        totalTax: order.tax,
        grandTotal: order.total,
        placeOfSupply: business.state,
        isInterState: false,
      },
    });

    for (const line of order.items) {
      const assets = await tx.digitalAsset.findMany({ where: { productId: line.productId } });
      for (const a of assets) {
        await tx.digitalPurchase.create({
          data: {
            userId: order.userId,
            guestEmail: order.userId ? null : order.guestEmail?.toLowerCase() ?? null,
            orderId: order.id,
            productId: line.productId,
            digitalAssetId: a.id,
            accessUrl: a.url,
          },
        });
      }
    }

    if (order.couponId) {
      await tx.couponCode.update({ where: { id: order.couponId }, data: { usedCount: { increment: 1 } } });
      await tx.couponUsage.create({
        data: {
          couponId: order.couponId,
          userId: order.userId,
          guestEmail: order.userId ? null : order.guestEmail?.toLowerCase() ?? null,
          orderId: order.id,
          discountAmount: order.discount,
        },
      });
    }

    if (sessionId) {
      await tx.cartItem.deleteMany({ where: { sessionId } });
    }
    if (order.userId) {
      await tx.cartItem.deleteMany({ where: { userId: order.userId } });
    }
  });

  const html = `<p>Thank you! Order <strong>${order.id.slice(0, 8)}</strong> is confirmed. Total ${(order.total / 100).toFixed(0)} INR.</p>`;
  await sendRawEmail({
    to: customerEmail,
    subject: "Order confirmed — The Blissful Soul",
    html,
    templateName: "OrderConfirmation",
    relatedType: "ORDER",
    relatedId: order.id,
  });
  const admin = process.env.ADMIN_EMAIL;
  if (admin) {
    await sendRawEmail({
      to: admin,
      subject: `New order ${order.id.slice(0, 8)}`,
      html: `<p>New paid order from ${customerEmail}</p>`,
      templateName: "AdminNewOrder",
      relatedType: "ORDER",
      relatedId: order.id,
    });
  }

  return NextResponse.json({ ok: true, orderId: order.id });
}
