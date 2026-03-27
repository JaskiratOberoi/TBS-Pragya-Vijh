import { NextResponse } from "next/server";
import { strapiFetch, normalizeDoc } from "@/lib/strapi";

export async function POST(req: Request) {
  const body = (await req.json()) as { token?: string; password?: string };
  if (!body.token || !body.password || body.password.length < 8) {
    return NextResponse.json({ error: "Invalid request" }, { status: 400 });
  }
  const tokRes = await strapiFetch<{ data?: unknown[] }>(
    `/api/password-reset-tokens?filters[token][$eq]=${encodeURIComponent(body.token)}&populate[user]=true&pagination[pageSize]=1`
  );
  const rowRaw = tokRes.data?.[0];
  if (!rowRaw) return NextResponse.json({ error: "Invalid or expired token" }, { status: 400 });
  const row = normalizeDoc(rowRaw) as { documentId?: string; expiresAt?: string; user?: { documentId?: string } };
  if (row.expiresAt && new Date(row.expiresAt) < new Date()) {
    return NextResponse.json({ error: "Invalid or expired token" }, { status: 400 });
  }
  const userDocId = row.user?.documentId;
  if (!userDocId) return NextResponse.json({ error: "Invalid token" }, { status: 400 });

  await strapiFetch(`/api/users/${userDocId}`, {
    method: "PUT",
    body: JSON.stringify({ password: body.password }),
  });
  await strapiFetch(`/api/password-reset-tokens/${String(row.documentId)}`, { method: "DELETE" });
  return NextResponse.json({ ok: true });
}
