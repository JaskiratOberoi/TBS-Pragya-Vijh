import { NextResponse } from "next/server";
import { getServerSession } from "next-auth";
import { authOptions } from "@/lib/auth";
import { strapiFetch } from "@/lib/strapi";
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

  const svcRes = await strapiFetch<{ data?: unknown[] }>(
    `/api/services?filters[documentId][$eq]=${encodeURIComponent(body.serviceId)}&pagination[pageSize]=1`
  );
  const svcRaw = svcRes.data?.[0];
  if (!svcRaw) return NextResponse.json({ error: "Service not found" }, { status: 404 });
  const service = svcRaw as { documentId?: string; id?: string; price?: number; durationMinutes?: number };

  const scheduledAt = new Date(body.scheduledAt);
  const endAt = new Date(scheduledAt.getTime() + Number(service.durationMinutes ?? 0) * 60 * 1000);

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

  const serviceDocId = String(service.documentId ?? body.serviceId);
  const data: Record<string, unknown> = {
    scheduledAt: scheduledAt.toISOString(),
    endAt: endAt.toISOString(),
    status: "PENDING",
    paymentStatus: "PENDING",
    amountPaid: Number(service.price ?? 0),
    customerNotes: body.customerNotes ?? null,
    guestName,
    guestEmail,
    guestPhone,
    service: { connect: [serviceDocId] },
  };
  if (userId) data.user = { connect: [userId] };

  let bookingDocId: string;
  try {
    const created = await strapiFetch<{ data?: { documentId?: string } }>(`/api/bookings`, {
      method: "POST",
      body: JSON.stringify({ data }),
    });
    bookingDocId = String(created.data?.documentId ?? "");
    if (!bookingDocId) throw new Error("No booking id");
  } catch (e) {
    const msg = e instanceof Error ? e.message : "Booking create failed";
    return NextResponse.json({ error: msg }, { status: 500 });
  }

  try {
    const rzp = await createRzpOrder(Number(service.price ?? 0), `BK-${bookingDocId}`, { bookingId: bookingDocId });
    await strapiFetch(`/api/bookings/${bookingDocId}`, {
      method: "PUT",
      body: JSON.stringify({ data: { rzpOrderId: rzp.id } }),
    });
    return NextResponse.json({
      bookingId: bookingDocId,
      rzpOrderId: rzp.id,
      amount: service.price,
      key: process.env.RAZORPAY_KEY_ID,
      currency: "INR",
    });
  } catch (e) {
    try {
      await strapiFetch(`/api/bookings/${bookingDocId}`, { method: "DELETE" });
    } catch {
      /* ignore */
    }
    const msg = e instanceof Error ? e.message : "Payment init failed";
    return NextResponse.json({ error: msg }, { status: 500 });
  }
}
