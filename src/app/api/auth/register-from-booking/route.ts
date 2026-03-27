import { NextResponse } from "next/server";
import { strapiFetch, normalizeDoc } from "@/lib/strapi";

export async function POST(req: Request) {
  const body = (await req.json()) as { bookingId?: string; password?: string };
  if (!body.bookingId || !body.password || body.password.length < 8) {
    return NextResponse.json({ error: "bookingId and password (8+ chars) required" }, { status: 400 });
  }

  const bRes = await strapiFetch<{ data?: unknown }>(`/api/bookings/${encodeURIComponent(body.bookingId)}`);
  const bookingRaw = bRes.data;
  if (!bookingRaw) return NextResponse.json({ error: "Invalid booking" }, { status: 400 });
  const booking = normalizeDoc(bookingRaw) as Record<string, unknown>;
  const bookingDocId = String(booking.documentId ?? body.bookingId);

  if (booking.paymentStatus !== "PAID") return NextResponse.json({ error: "Invalid booking" }, { status: 400 });
  if (booking.user) return NextResponse.json({ error: "Booking already linked to an account" }, { status: 400 });

  const email = String(booking.guestEmail ?? "").toLowerCase();
  if (!email) return NextResponse.json({ error: "No guest email on booking" }, { status: 400 });

  const existsRes = await strapiFetch<{ data?: unknown[] }>(
    `/api/users?filters[email][$eq]=${encodeURIComponent(email)}&pagination[pageSize]=1`
  );
  if ((existsRes.data?.length ?? 0) > 0) {
    return NextResponse.json({ error: "An account with this email already exists — sign in instead" }, { status: 400 });
  }

  const base = process.env.STRAPI_API_URL ?? process.env.NEXT_PUBLIC_STRAPI_URL ?? "http://localhost:1337";
  const reg = await fetch(`${base.replace(/\/$/, "")}/api/auth/local/register`, {
    method: "POST",
    headers: { "Content-Type": "application/json" },
    body: JSON.stringify({
      username: email,
      email,
      password: body.password,
    }),
  });
  const regData = (await reg.json()) as { user?: { documentId?: string }; error?: { message?: string } };
  if (!reg.ok || !regData.user?.documentId) {
    return NextResponse.json({ error: regData.error?.message ?? "Registration failed" }, { status: 400 });
  }
  const userDocId = regData.user.documentId;

  await strapiFetch(`/api/bookings/${bookingDocId}`, {
    method: "PUT",
    body: JSON.stringify({
      data: {
        user: { connect: [userDocId] },
        guestName: null,
        guestEmail: null,
        guestPhone: null,
      },
    }),
  });

  return NextResponse.json({ ok: true });
}
