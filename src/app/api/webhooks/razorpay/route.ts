import { NextResponse } from "next/server";
import crypto from "crypto";
import { prisma } from "@/lib/prisma";

export async function POST(req: Request) {
  const secret = process.env.RAZORPAY_WEBHOOK_SECRET;
  const body = await req.text();
  const sig = req.headers.get("x-razorpay-signature");
  if (!secret || !sig) return NextResponse.json({ error: "Unauthorized" }, { status: 401 });
  const expected = crypto.createHmac("sha256", secret).update(body).digest("hex");
  if (expected !== sig) return NextResponse.json({ error: "Bad signature" }, { status: 400 });

  const event = JSON.parse(body) as { event?: string; payload?: { payment?: { entity?: { id?: string; order_id?: string; status?: string } } } };
  if (event.event === "payment.captured" && event.payload?.payment?.entity) {
    const p = event.payload.payment.entity;
    const orderId = p.order_id;
    if (orderId) {
      await prisma.order.updateMany({
        where: { rzpOrderId: orderId, paymentStatus: "PENDING" },
        data: { paymentStatus: "PAID", status: "PROCESSING", rzpPaymentId: p.id },
      });
    }
  }
  return NextResponse.json({ received: true });
}
