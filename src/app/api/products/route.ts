import { NextResponse } from "next/server";
import { strapiFetch, normalizeDoc } from "@/lib/strapi";

export async function GET(req: Request) {
  const { searchParams } = new URL(req.url);
  const page = Math.max(1, Number(searchParams.get("page") ?? "1"));
  const limit = Math.min(48, Math.max(1, Number(searchParams.get("limit") ?? "12")));
  const q = searchParams.get("q")?.trim();
  const category = searchParams.get("category");
  const type = searchParams.get("type") as "PHYSICAL" | "DIGITAL" | null;
  const sort = searchParams.get("sort") ?? "latest";

  const parts: string[] = ["filters[isActive][$eq]=true", "populate[category]=true"];
  if (q) {
    parts.push(`filters[$or][0][name][$containsi]=${encodeURIComponent(q)}`);
    parts.push(`filters[$or][1][description][$containsi]=${encodeURIComponent(q)}`);
  }
  if (category) {
    parts.push(`filters[category][slug][$eq]=${encodeURIComponent(category)}`);
  }
  if (type === "PHYSICAL" || type === "DIGITAL") {
    parts.push(`filters[productType][$eq]=${type}`);
  }

  let sortParam = "sort[0]=createdAt:desc";
  if (sort === "price_asc") sortParam = "sort[0]=price:asc";
  if (sort === "price_desc") sortParam = "sort[0]=price:desc";
  if (sort === "name") sortParam = "sort[0]=name:asc";

  const pagination = `pagination[page]=${page}&pagination[pageSize]=${limit}`;
  const qs = [...parts, sortParam, pagination, "pagination[withCount]=true"].join("&");

  const json = await strapiFetch<{ data?: unknown[]; meta?: { pagination?: { total?: number; pageCount?: number } } }>(
    `/api/products?${qs}`
  );
  const raw = json.data ?? [];
  const products = raw.map((r) => {
    const p = normalizeDoc(r);
    const cat = p.category as Record<string, unknown> | undefined;
    return {
      id: p.id,
      name: p.name,
      slug: p.slug,
      price: p.price,
      salePrice: p.salePrice,
      images: p.images,
      productType: p.productType,
      stock: p.stock,
      category: cat
        ? {
            name: cat.name,
            slug: cat.slug,
          }
        : null,
    };
  });

  const total = json.meta?.pagination?.total ?? products.length;
  const totalPages = json.meta?.pagination?.pageCount ?? Math.max(1, Math.ceil(total / limit));

  return NextResponse.json({
    products,
    total,
    page,
    limit,
    totalPages,
  });
}
