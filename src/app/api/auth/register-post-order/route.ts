import { NextResponse } from "next/server";
import { strapiFetch, normalizeDoc } from "@/lib/strapi";

export async function POST(req: Request) {
  const body = (await req.json()) as { orderId?: string; password?: string };
  if (!body.orderId || !body.password || body.password.length < 8) {
    return NextResponse.json({ error: "orderId and password (8+ chars) required" }, { status: 400 });
  }

  const orderRes = await strapiFetch<{ data?: unknown }>(
    `/api/orders/${encodeURIComponent(body.orderId)}?populate[digitalPurchases]=true`
  );
  const orderRaw = orderRes.data;
  if (!orderRaw) return NextResponse.json({ error: "Invalid order" }, { status: 400 });
  const order = normalizeDoc(orderRaw) as Record<string, unknown>;
  const orderDocId = String(order.documentId ?? body.orderId);

  if (order.paymentStatus !== "PAID") return NextResponse.json({ error: "Invalid order" }, { status: 400 });
  if (order.user) return NextResponse.json({ error: "Order already linked to an account" }, { status: 400 });

  const email = String(order.guestEmail ?? "").toLowerCase();
  if (!email) return NextResponse.json({ error: "No guest email on order" }, { status: 400 });

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

  await strapiFetch(`/api/orders/${orderDocId}`, {
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

  const dpRes = await strapiFetch<{ data?: unknown[] }>(
    `/api/digital-purchases?filters[order][documentId][$eq]=${encodeURIComponent(orderDocId)}&pagination[pageSize]=100`
  );
  for (const x of dpRes.data ?? []) {
    const d = normalizeDoc(x);
    const id = String(d.documentId ?? d.id);
    await strapiFetch(`/api/digital-purchases/${id}`, {
      method: "PUT",
      body: JSON.stringify({
        data: {
          user: { connect: [userDocId] },
          guestEmail: null,
        },
      }),
    });
  }

  return NextResponse.json({ ok: true });
}
