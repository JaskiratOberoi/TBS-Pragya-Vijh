import { NextResponse } from "next/server";
import { strapiFetch, normalizeDoc } from "@/lib/strapi";
import { getServerSession } from "next-auth";
import { authOptions } from "@/lib/auth";
import { findProductBySlug } from "@/lib/strapi-queries";

export async function GET(_req: Request, { params }: { params: Promise<{ slug: string }> }) {
  const { slug } = await params;
  const product = await findProductBySlug(slug);
  if (!product) return NextResponse.json({ error: "Not found" }, { status: 404 });
  const pid = product.id;
  const j = await strapiFetch<{ data?: unknown[] }>(
    `/api/reviews?filters[product][documentId][$eq]=${encodeURIComponent(pid)}&populate[user]=true&sort[0]=createdAt:desc&pagination[pageSize]=50`
  );
  const reviews = (j.data ?? []).map((x) => normalizeDoc(x)) as Array<{
    id?: string;
    rating?: number;
    comment?: string;
    createdAt?: string;
    user?: { username?: string };
  }>;
  return NextResponse.json({
    reviews: reviews.map((r) => ({
      id: String(r.id),
      rating: r.rating,
      comment: r.comment,
      createdAt: r.createdAt,
      author: r.user?.username ?? "Customer",
    })),
  });
}

export async function POST(req: Request, { params }: { params: Promise<{ slug: string }> }) {
  const session = await getServerSession(authOptions);
  if (!session?.user?.id) return NextResponse.json({ error: "Login required" }, { status: 401 });
  const { slug } = await params;
  const product = await findProductBySlug(slug);
  if (!product) return NextResponse.json({ error: "Not found" }, { status: 404 });
  const body = (await req.json()) as { rating?: number; comment?: string };
  if (!body.rating || body.rating < 1 || body.rating > 5 || !body.comment) {
    return NextResponse.json({ error: "Invalid review" }, { status: 400 });
  }
  await strapiFetch(`/api/reviews`, {
    method: "POST",
    body: JSON.stringify({
      data: {
        rating: body.rating,
        comment: body.comment,
        product: { connect: [product.id] },
        user: { connect: [session.user.id] },
      },
    }),
  });
  return NextResponse.json({ ok: true });
}
