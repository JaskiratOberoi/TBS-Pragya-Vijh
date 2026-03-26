import { NextResponse } from "next/server";
import bcrypt from "bcryptjs";
import { prisma } from "@/lib/prisma";

export async function POST(req: Request) {
  const body = (await req.json()) as { bookingId?: string; password?: string };
  if (!body.bookingId || !body.password || body.password.length < 8) {
    return NextResponse.json({ error: "bookingId and password (8+ chars) required" }, { status: 400 });
  }

  const booking = await prisma.booking.findUnique({ where: { id: body.bookingId } });
  if (!booking || booking.paymentStatus !== "PAID") {
    return NextResponse.json({ error: "Invalid booking" }, { status: 400 });
  }
  if (booking.userId) {
    return NextResponse.json({ error: "Booking already linked to an account" }, { status: 400 });
  }
  const email = booking.guestEmail?.toLowerCase();
  if (!email) return NextResponse.json({ error: "No guest email on booking" }, { status: 400 });

  const exists = await prisma.user.findUnique({ where: { email } });
  if (exists) {
    return NextResponse.json({ error: "An account with this email already exists — sign in instead" }, { status: 400 });
  }

  const passwordHash = await bcrypt.hash(body.password, 12);
  const user = await prisma.user.create({
    data: {
      email,
      name: booking.guestName ?? undefined,
      phone: booking.guestPhone ?? undefined,
      passwordHash,
      role: "USER",
    },
  });

  await prisma.booking.update({
    where: { id: booking.id },
    data: {
      userId: user.id,
      guestName: null,
      guestEmail: null,
      guestPhone: null,
    },
  });

  return NextResponse.json({ ok: true });
}
