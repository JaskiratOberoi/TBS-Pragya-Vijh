import { NextResponse } from "next/server";
import { getServerSession } from "next-auth";
import { authOptions } from "@/lib/auth";
import { strapiFetch, normalizeDoc } from "@/lib/strapi";

export async function GET() {
  const session = await getServerSession(authOptions);
  if (!session?.user?.id) return NextResponse.json({ items: [] });
  const j = await strapiFetch<{ data?: unknown[] }>(
    `/api/wishlist-items?filters[user][documentId][$eq]=${encodeURIComponent(session.user.id)}&populate[product]=true&pagination[pageSize]=200`
  );
  const items = (j.data ?? []).map((x) => normalizeDoc(x)) as Array<{
    documentId?: string;
    id?: string;
    product?: Record<string, unknown>;
  }>;
  return NextResponse.json({
    items: items.map((w) => {
      const p = w.product ?? {};
      return {
        id: String(w.documentId ?? w.id),
        product: {
          id: String(p.documentId ?? p.id),
          name: p.name,
          slug: p.slug,
          price: p.price,
          salePrice: p.salePrice,
          images: p.images,
          productType: p.productType,
        },
      };
    }),
  });
}

export async function POST(req: Request) {
  const session = await getServerSession(authOptions);
  if (!session?.user?.id) return NextResponse.json({ error: "Login required" }, { status: 401 });
  const body = (await req.json()) as { productId?: string };
  if (!body.productId) return NextResponse.json({ error: "productId required" }, { status: 400 });

  const ex = await strapiFetch<{ data?: unknown[] }>(
    `/api/wishlist-items?filters[user][documentId][$eq]=${encodeURIComponent(session.user.id)}&filters[product][documentId][$eq]=${encodeURIComponent(body.productId)}&pagination[pageSize]=1`
  );
  if ((ex.data?.length ?? 0) > 0) return NextResponse.json({ ok: true });

  await strapiFetch(`/api/wishlist-items`, {
    method: "POST",
    body: JSON.stringify({
      data: {
        user: { connect: [session.user.id] },
        product: { connect: [body.productId] },
      },
    }),
  });
  return NextResponse.json({ ok: true });
}

export async function DELETE(req: Request) {
  const session = await getServerSession(authOptions);
  if (!session?.user?.id) return NextResponse.json({ error: "Login required" }, { status: 401 });
  const id = new URL(req.url).searchParams.get("id");
  const productId = new URL(req.url).searchParams.get("productId");
  if (id) {
    const rowRes = await strapiFetch<{ data?: unknown }>(`/api/wishlist-items/${id}?populate=user`);
    const row = rowRes.data ? normalizeDoc(rowRes.data) : null;
    const u = row?.user as { documentId?: string } | undefined;
    if (u?.documentId !== session.user.id) return NextResponse.json({ error: "Forbidden" }, { status: 403 });
    await strapiFetch(`/api/wishlist-items/${id}`, { method: "DELETE" });
  } else if (productId) {
    const list = await strapiFetch<{ data?: unknown[] }>(
      `/api/wishlist-items?filters[user][documentId][$eq]=${encodeURIComponent(session.user.id)}&filters[product][documentId][$eq]=${encodeURIComponent(productId)}&pagination[pageSize]=10`
    );
    for (const x of list.data ?? []) {
      const d = normalizeDoc(x);
      await strapiFetch(`/api/wishlist-items/${String(d.documentId ?? d.id)}`, { method: "DELETE" });
    }
  } else return NextResponse.json({ error: "id or productId" }, { status: 400 });
  return NextResponse.json({ ok: true });
}
