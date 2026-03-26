import { NextResponse } from "next/server";
import { prisma } from "@/lib/prisma";
import { verifySignature, fetchPaymentDetails } from "@/lib/razorpay";
import { assertSlotStillAvailable } from "@/lib/slot-availability";
import { sendRawEmail } from "@/lib/email";
import { buildBookingIcs } from "@/lib/ics-generator";

function contactLine(booking: {
  user: { phone: string | null; email: string } | null;
  guestPhone: string | null;
  guestEmail: string | null;
}) {
  if (booking.user) return booking.user.phone ?? booking.user.email;
  return [booking.guestPhone, booking.guestEmail].filter(Boolean).join(" · ");
}

function customerEmail(booking: { user: { email: string } | null; guestEmail: string | null }) {
  return booking.user?.email ?? booking.guestEmail ?? "";
}

function customerLabel(booking: { user: { name: string | null; email: string } | null; guestName: string | null; guestEmail: string | null }) {
  return booking.user?.name ?? booking.user?.email ?? booking.guestName ?? booking.guestEmail ?? "Guest";
}

export async function POST(req: Request) {
  const body = (await req.json()) as {
    bookingId?: string;
    rzpOrderId?: string;
    rzpPaymentId?: string;
    rzpSignature?: string;
  };
  if (!body.bookingId || !body.rzpOrderId || !body.rzpPaymentId || !body.rzpSignature) {
    return NextResponse.json({ error: "Missing fields" }, { status: 400 });
  }
  if (!verifySignature(body.rzpOrderId, body.rzpPaymentId, body.rzpSignature)) {
    return NextResponse.json({ error: "Invalid signature" }, { status: 400 });
  }

  const booking = await prisma.booking.findUnique({
    where: { id: body.bookingId },
    include: { service: true, user: true },
  });
  if (!booking) return NextResponse.json({ error: "Not found" }, { status: 404 });
  if (booking.rzpOrderId !== body.rzpOrderId) return NextResponse.json({ error: "Mismatch" }, { status: 400 });
  if (booking.paymentStatus === "PAID") return NextResponse.json({ ok: true, bookingId: booking.id });

  const toAddr = customerEmail(booking);
  if (!toAddr) return NextResponse.json({ error: "Booking has no contact email" }, { status: 400 });

  const overlapping = await prisma.booking.findMany({
    where: {
      scheduledAt: {
        gte: new Date(booking.scheduledAt.getTime() - 24 * 60 * 60 * 1000),
        lte: new Date(booking.scheduledAt.getTime() + 24 * 60 * 60 * 1000),
      },
      status: { not: "CANCELLED" },
      NOT: { id: booking.id },
    },
  });
  if (!assertSlotStillAvailable(booking.scheduledAt, booking.endAt, overlapping)) {
    return NextResponse.json({ error: "Slot no longer available" }, { status: 409 });
  }

  await fetchPaymentDetails(body.rzpPaymentId);

  const settings = await prisma.bookingSettings.findUnique({ where: { id: "singleton" } });
  const status = settings?.autoConfirm ? "CONFIRMED" : "PENDING";

  await prisma.booking.update({
    where: { id: booking.id },
    data: {
      paymentStatus: "PAID",
      status,
      rzpPaymentId: body.rzpPaymentId,
      rzpSignature: body.rzpSignature,
    },
  });

  const business = await prisma.businessSettings.findUnique({ where: { id: "singleton" } });
  const ics = business
    ? buildBookingIcs({
        title: `${booking.service.name} — The Blissful Soul`,
        description: `Booking ID: ${booking.id}. Contact: ${contactLine(booking)}`,
        start: booking.scheduledAt,
        end: booking.endAt,
        uid: `${booking.id}@theblissfulsoul`,
      })
    : null;

  const h24 = new Date(booking.scheduledAt.getTime() - 24 * 60 * 60 * 1000);
  const h1 = new Date(booking.scheduledAt.getTime() - 60 * 60 * 1000);
  await prisma.scheduledReminder.createMany({
    data: [
      { bookingId: booking.id, reminderType: "SESSION_REMINDER_24H", scheduledFor: h24 },
      { bookingId: booking.id, reminderType: "SESSION_REMINDER_1H", scheduledFor: h1 },
    ],
  });

  const when = booking.scheduledAt.toLocaleString("en-IN");
  await sendRawEmail({
    to: toAddr,
    subject: "Booking confirmed — The Blissful Soul",
    html: `<p>Your ${booking.service.name} is confirmed for <strong>${when}</strong>.</p>${ics ? `<pre>${ics.slice(0, 200)}…</pre>` : ""}`,
    templateName: "BookingConfirmation",
    relatedType: "BOOKING",
    relatedId: booking.id,
  });
  const admin = process.env.ADMIN_EMAIL;
  if (admin) {
    await sendRawEmail({
      to: admin,
      subject: `New booking ${booking.id.slice(0, 8)}`,
      html: `<p>${customerLabel(booking)} booked ${booking.service.name} at ${when}</p>`,
      templateName: "AdminNewBooking",
      relatedType: "BOOKING",
      relatedId: booking.id,
    });
  }

  return NextResponse.json({ ok: true, bookingId: booking.id });
}
