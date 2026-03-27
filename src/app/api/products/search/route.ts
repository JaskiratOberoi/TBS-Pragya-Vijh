import { NextResponse } from "next/server";
import { strapiFetch, normalizeDoc } from "@/lib/strapi";

export async function GET(req: Request) {
  const q = new URL(req.url).searchParams.get("q")?.trim();
  if (!q || q.length < 2) return NextResponse.json({ products: [] });
  const j = await strapiFetch<{ data?: unknown[] }>(
    `/api/products?filters[isActive][$eq]=true&filters[$or][0][name][$containsi]=${encodeURIComponent(q)}&filters[$or][1][description][$containsi]=${encodeURIComponent(q)}&populate[category]=true&pagination[pageSize]=8`
  );
  const products = (j.data ?? []).map((x) => normalizeDoc(x)) as Array<{
    id?: string;
    name?: string;
    slug?: string;
    price?: number;
    salePrice?: number | null;
    images?: unknown;
    category?: { name?: string };
  }>;
  return NextResponse.json({
    products: products.map((p) => ({
      id: String(p.id),
      name: p.name,
      slug: p.slug,
      price: p.price,
      salePrice: p.salePrice,
      images: p.images,
      category: p.category?.name,
    })),
  });
}
