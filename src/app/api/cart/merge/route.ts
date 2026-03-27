import { NextResponse } from "next/server";
import { getServerSession } from "next-auth";
import { authOptions } from "@/lib/auth";
import { strapiFetch, normalizeDoc } from "@/lib/strapi";
import { CART_COOKIE } from "@/lib/cart-session";

export async function POST(req: Request) {
  const session = await getServerSession(authOptions);
  if (!session?.user?.id) return NextResponse.json({ error: "Unauthorized" }, { status: 401 });
  const cookieHeader = req.headers.get("cookie") ?? "";
  const match = cookieHeader.match(new RegExp(`${CART_COOKIE}=([^;]+)`));
  const sessionId = match?.[1] ? decodeURIComponent(match[1]) : null;
  if (!sessionId) return NextResponse.json({ ok: true });

  const guestRes = await strapiFetch<{ data?: unknown[] }>(
    `/api/cart-items?filters[sessionId][$eq]=${encodeURIComponent(sessionId)}&pagination[pageSize]=200`
  );
  const guestItems = (guestRes.data ?? []).map((x) => normalizeDoc(x)) as Array<{
    documentId?: string;
    id?: string;
    quantity?: number;
    product?: { documentId?: string };
    productId?: string;
  }>;

  const uid = session.user.id;
  for (const g of guestItems) {
    const gDoc = String(g.documentId ?? g.id ?? "");
    const productDocId = String(g.product?.documentId ?? g.productId ?? "");
    if (!gDoc || !productDocId) continue;

    const exRes = await strapiFetch<{ data?: unknown[] }>(
      `/api/cart-items?filters[user][documentId][$eq]=${encodeURIComponent(uid)}&filters[product][documentId][$eq]=${encodeURIComponent(productDocId)}&pagination[pageSize]=1`
    );
    const existingRaw = exRes.data?.[0];
    if (existingRaw) {
      const existing = normalizeDoc(existingRaw) as { documentId?: string; quantity?: number };
      const exDoc = String(existing.documentId);
      await strapiFetch(`/api/cart-items/${exDoc}`, {
        method: "PUT",
        body: JSON.stringify({
          data: { quantity: Number(existing.quantity ?? 0) + Number(g.quantity ?? 0) },
        }),
      });
      await strapiFetch(`/api/cart-items/${gDoc}`, { method: "DELETE" });
    } else {
      await strapiFetch(`/api/cart-items/${gDoc}`, {
        method: "PUT",
        body: JSON.stringify({
          data: {
            user: { connect: [uid] },
            sessionId: null,
          },
        }),
      });
    }
  }

  const res = NextResponse.json({ ok: true });
  res.cookies.set(CART_COOKIE, "", { maxAge: 0, path: "/" });
  return res;
}
