import { NextResponse } from "next/server";
import { strapiFetch, normalizeDoc } from "@/lib/strapi";
import { findProductBySlugFull } from "@/lib/strapi-queries";

export async function GET(_req: Request, { params }: { params: Promise<{ slug: string }> }) {
  const { slug } = await params;
  const product = await findProductBySlugFull(slug);
  if (!product || product.isActive === false) return NextResponse.json({ error: "Not found" }, { status: 404 });

  const productDocId = String(product.documentId ?? product.id ?? "");
  const category = (product.category ?? {}) as { documentId?: string };
  const catDocId = String(category.documentId ?? "");

  const relatedJson = await strapiFetch<{ data?: unknown[] }>(
    `/api/products?filters[isActive][$eq]=true&filters[category][documentId][$eq]=${encodeURIComponent(catDocId)}&filters[documentId][$ne]=${encodeURIComponent(productDocId)}&populate[category]=true&pagination[pageSize]=8`
  );
  const related = (relatedJson.data ?? []).map((x) => normalizeDoc(x));

  return NextResponse.json({ product, related });
}
