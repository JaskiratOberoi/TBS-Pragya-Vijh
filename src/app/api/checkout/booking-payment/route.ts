import { NextResponse } from "next/server";
import { getServerSession } from "next-auth";
import { authOptions } from "@/lib/auth";
import { prisma } from "@/lib/prisma";
import { createRzpOrder } from "@/lib/razorpay";

function normEmail(s: string) {
  return s.trim().toLowerCase();
}

export async function POST(req: Request) {
  const session = await getServerSession(authOptions);
  const body = (await req.json()) as {
    serviceId?: string;
    scheduledAt?: string;
    customerNotes?: string;
    guestName?: string;
    guestEmail?: string;
    guestPhone?: string;
  };
  if (!body.serviceId || !body.scheduledAt) return NextResponse.json({ error: "Invalid body" }, { status: 400 });

  const service = await prisma.service.findUnique({ where: { id: body.serviceId } });
  if (!service) return NextResponse.json({ error: "Service not found" }, { status: 404 });

  const scheduledAt = new Date(body.scheduledAt);
  const endAt = new Date(scheduledAt.getTime() + service.durationMinutes * 60 * 1000);

  let userId: string | null = session?.user?.id ?? null;
  let guestName: string | null = null;
  let guestEmail: string | null = null;
  let guestPhone: string | null = null;

  if (!userId) {
    const gn = body.guestName?.trim();
    const ge = body.guestEmail?.trim();
    const gp = body.guestPhone?.trim();
    if (!gn || !ge || !gp) {
      return NextResponse.json({ error: "Name, email, and phone are required" }, { status: 400 });
    }
    if (!/^[^\s@]+@[^\s@]+\.[^\s@]+$/.test(ge)) {
      return NextResponse.json({ error: "Invalid email" }, { status: 400 });
    }
    guestName = gn;
    guestEmail = normEmail(ge);
    guestPhone = gp;
  }

  const booking = await prisma.booking.create({
    data: {
      userId,
      guestName,
      guestEmail,
      guestPhone,
      serviceId: service.id,
      scheduledAt,
      endAt,
      status: "PENDING",
      paymentStatus: "PENDING",
      amountPaid: service.price,
      customerNotes: body.customerNotes,
    },
  });

  try {
    const rzp = await createRzpOrder(service.price, `BK-${booking.id}`, { bookingId: booking.id });
    await prisma.booking.update({ where: { id: booking.id }, data: { rzpOrderId: rzp.id } });
    return NextResponse.json({
      bookingId: booking.id,
      rzpOrderId: rzp.id,
      amount: service.price,
      key: process.env.RAZORPAY_KEY_ID,
      currency: "INR",
    });
  } catch (e) {
    await prisma.booking.delete({ where: { id: booking.id } });
    const msg = e instanceof Error ? e.message : "Payment init failed";
    return NextResponse.json({ error: msg }, { status: 500 });
  }
}
