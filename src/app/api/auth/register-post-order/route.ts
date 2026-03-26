import { NextResponse } from "next/server";
import bcrypt from "bcryptjs";
import { prisma } from "@/lib/prisma";

export async function POST(req: Request) {
  const body = (await req.json()) as { orderId?: string; password?: string };
  if (!body.orderId || !body.password || body.password.length < 8) {
    return NextResponse.json({ error: "orderId and password (8+ chars) required" }, { status: 400 });
  }

  const order = await prisma.order.findUnique({
    where: { id: body.orderId },
    include: { digitalPurchases: true },
  });
  if (!order || order.paymentStatus !== "PAID") {
    return NextResponse.json({ error: "Invalid order" }, { status: 400 });
  }
  if (order.userId) {
    return NextResponse.json({ error: "Order already linked to an account" }, { status: 400 });
  }
  const email = order.guestEmail?.toLowerCase();
  if (!email) return NextResponse.json({ error: "No guest email on order" }, { status: 400 });

  const exists = await prisma.user.findUnique({ where: { email } });
  if (exists) {
    return NextResponse.json({ error: "An account with this email already exists — sign in instead" }, { status: 400 });
  }

  const passwordHash = await bcrypt.hash(body.password, 12);
  const user = await prisma.user.create({
    data: {
      email,
      name: order.guestName ?? undefined,
      phone: order.guestPhone ?? undefined,
      passwordHash,
      role: "USER",
    },
  });

  await prisma.$transaction(async (tx) => {
    await tx.order.update({
      where: { id: order.id },
      data: {
        userId: user.id,
        guestName: null,
        guestEmail: null,
        guestPhone: null,
      },
    });
    await tx.digitalPurchase.updateMany({
      where: { orderId: order.id },
      data: { userId: user.id, guestEmail: null },
    });
  });

  return NextResponse.json({ ok: true });
}
