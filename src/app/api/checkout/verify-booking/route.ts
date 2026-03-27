import { NextResponse } from "next/server";
import { strapiFetch, normalizeDoc } from "@/lib/strapi";
import { verifySignature, fetchPaymentDetails } from "@/lib/razorpay";
import { assertSlotStillAvailable } from "@/lib/slot-availability";
import { sendRawEmail } from "@/lib/email";
import { buildBookingIcs } from "@/lib/ics-generator";
import { getBookingSettings, getBusinessSettings } from "@/lib/strapi-queries";

function contactLine(booking: {
  user?: { phone?: string | null; email?: string } | null;
  guestPhone?: string | null;
  guestEmail?: string | null;
}) {
  if (booking.user) return booking.user.phone ?? booking.user.email;
  return [booking.guestPhone, booking.guestEmail].filter(Boolean).join(" · ");
}

function customerEmail(booking: { user?: { email?: string } | null; guestEmail?: string | null }) {
  return booking.user?.email ?? booking.guestEmail ?? "";
}

function customerLabel(booking: {
  user?: { username?: string | null; email?: string } | null;
  guestName?: string | null;
  guestEmail?: string | null;
}) {
  return booking.user?.username ?? booking.user?.email ?? booking.guestName ?? booking.guestEmail ?? "Guest";
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

  const bRes = await strapiFetch<{ data?: unknown }>(
    `/api/bookings/${encodeURIComponent(body.bookingId)}?populate[service]=true&populate[user]=true`
  );
  const bookingRaw = bRes.data;
  if (!bookingRaw) return NextResponse.json({ error: "Not found" }, { status: 404 });
  const booking = normalizeDoc(bookingRaw) as Record<string, unknown>;
  const bookingDocId = String(booking.documentId ?? booking.id ?? body.bookingId);

  if (booking.rzpOrderId !== body.rzpOrderId) return NextResponse.json({ error: "Mismatch" }, { status: 400 });
  if (booking.paymentStatus === "PAID") return NextResponse.json({ ok: true, bookingId: bookingDocId });

  const toAddr = customerEmail(booking as never);
  if (!toAddr) return NextResponse.json({ error: "Booking has no contact email" }, { status: 400 });

  const scheduledAt = new Date(String(booking.scheduledAt));
  const endAt = new Date(String(booking.endAt));

  const dayStart = new Date(scheduledAt);
  dayStart.setHours(0, 0, 0, 0);
  const dayEnd = new Date(scheduledAt);
  dayEnd.setHours(23, 59, 59, 999);

  const overlapRes = await strapiFetch<{ data?: unknown[] }>(
    `/api/bookings?filters[scheduledAt][$gte]=${encodeURIComponent(dayStart.toISOString())}&filters[scheduledAt][$lte]=${encodeURIComponent(dayEnd.toISOString())}&pagination[pageSize]=200`
  );
  const overlapping = (overlapRes.data ?? [])
    .map((x) => normalizeDoc(x))
    .filter((o) => String(o.documentId ?? o.id) !== bookingDocId)
    .map((o) => ({
      scheduledAt: new Date(String(o.scheduledAt)),
      endAt: new Date(String(o.endAt)),
      status: String(o.status ?? ""),
    }));

  if (!assertSlotStillAvailable(scheduledAt, endAt, overlapping)) {
    return NextResponse.json({ error: "Slot no longer available" }, { status: 409 });
  }

  await fetchPaymentDetails(body.rzpPaymentId);

  const settings = await getBookingSettings();
  const status = settings?.autoConfirm !== false ? "CONFIRMED" : "PENDING";

  await strapiFetch(`/api/bookings/${bookingDocId}`, {
    method: "PUT",
    body: JSON.stringify({
      data: {
        paymentStatus: "PAID",
        status,
        rzpPaymentId: body.rzpPaymentId,
        rzpSignature: body.rzpSignature,
      },
    }),
  });

  const business = await getBusinessSettings();
  const service = booking.service as { name?: string } | undefined;
  const ics = business
    ? buildBookingIcs({
        title: `${service?.name ?? "Session"} — The Blissful Soul`,
        description: `Booking ID: ${bookingDocId}. Contact: ${contactLine(booking as never)}`,
        start: scheduledAt,
        end: endAt,
        uid: `${bookingDocId}@theblissfulsoul`,
      })
    : null;

  const h24 = new Date(scheduledAt.getTime() - 24 * 60 * 60 * 1000);
  const h1 = new Date(scheduledAt.getTime() - 60 * 60 * 1000);
  for (const [reminderType, scheduledFor] of [
    ["SESSION_REMINDER_24H", h24],
    ["SESSION_REMINDER_1H", h1],
  ] as const) {
    await strapiFetch(`/api/scheduled-reminders`, {
      method: "POST",
      body: JSON.stringify({
        data: {
          reminderType,
          scheduledFor: scheduledFor.toISOString(),
          booking: { connect: [bookingDocId] },
        },
      }),
    });
  }

  const when = scheduledAt.toLocaleString("en-IN");
  await sendRawEmail({
    to: toAddr,
    subject: "Booking confirmed — The Blissful Soul",
    html: `<p>Your ${service?.name ?? "session"} is confirmed for <strong>${when}</strong>.</p>${ics ? `<pre>${ics.slice(0, 200)}…</pre>` : ""}`,
    templateName: "BookingConfirmation",
    relatedType: "BOOKING",
    relatedId: bookingDocId,
  });
  const admin = process.env.ADMIN_EMAIL;
  if (admin) {
    await sendRawEmail({
      to: admin,
      subject: `New booking ${bookingDocId.slice(0, 8)}`,
      html: `<p>${customerLabel(booking as never)} booked ${service?.name ?? "session"} at ${when}</p>`,
      templateName: "AdminNewBooking",
      relatedType: "BOOKING",
      relatedId: bookingDocId,
    });
  }

  return NextResponse.json({ ok: true, bookingId: bookingDocId });
}
