import Link from "next/link";
import { strapiFetchPublicList, normalizeDoc } from "@/lib/strapi";
import { toProductTileModel } from "@/lib/strapi-mappers";
import { effectiveUnitPrice } from "@/lib/promo-engine";
import { Button } from "@/components/ui/button";
import { StaggerGrid } from "@/components/motion/StaggerGrid";
import { ProductTile } from "@/components/shop/ProductTile";
import type { Metadata } from "next";

export const metadata: Metadata = { title: "Shop Crystals" };

export const revalidate = 60;

export default async function ShopPage({
  searchParams,
}: {
  searchParams: Promise<{ page?: string; category?: string; sort?: string; type?: string; q?: string }>;
}) {
  const sp = await searchParams;
  const page = Math.max(1, Number(sp.page ?? "1"));
  const limit = 12;

  const parts: string[] = ["filters[isActive][$eq]=true", "populate[category]=true"];
  if (sp.q) {
    parts.push(`filters[$or][0][name][$containsi]=${encodeURIComponent(sp.q)}`);
    parts.push(`filters[$or][1][description][$containsi]=${encodeURIComponent(sp.q)}`);
  }
  if (sp.category) {
    parts.push(`filters[category][slug][$eq]=${encodeURIComponent(sp.category)}`);
  }
  if (sp.type === "PHYSICAL" || sp.type === "DIGITAL") {
    parts.push(`filters[productType][$eq]=${sp.type}`);
  }
  let sortParam = "sort[0]=createdAt:desc";
  if (sp.sort === "price_asc") sortParam = "sort[0]=price:asc";
  if (sp.sort === "price_desc") sortParam = "sort[0]=price:desc";
  if (sp.sort === "name") sortParam = "sort[0]=name:asc";
  const pagination = `pagination[page]=${page}&pagination[pageSize]=${limit}`;
  const qs = [...parts, sortParam, pagination, "pagination[withCount]=true"].join("&");

  const [productsJson, catJson] = await Promise.all([
    strapiFetchPublicList<{ data?: unknown[]; meta?: { pagination?: { total?: number; pageCount?: number } } }>(
      `/api/products?${qs}`,
      { next: { revalidate: 60 } }
    ),
    strapiFetchPublicList<{ data?: unknown[] }>(`/api/product-categories?sort[0]=sortOrder:asc&pagination[pageSize]=100`, {
      next: { revalidate: 60 },
    }),
  ]);

  const rawProducts = productsJson.data ?? [];
  const products = rawProducts.map((x) => toProductTileModel(normalizeDoc(x)));
  const categories = (catJson.data ?? []).map((x) => normalizeDoc(x)) as Array<{ id: string; name: string; slug: string }>;
  const total = productsJson.meta?.pagination?.total ?? rawProducts.length;
  const totalPages = productsJson.meta?.pagination?.pageCount ?? Math.max(1, Math.ceil(total / limit));
  const baseQs = () => {
    const qs = new URLSearchParams();
    if (sp.category) qs.set("category", sp.category);
    if (sp.sort) qs.set("sort", sp.sort);
    if (sp.type) qs.set("type", sp.type);
    if (sp.q) qs.set("q", sp.q);
    return qs;
  };
  const qsb = baseQs().toString();

  return (
    <div className="mx-auto flex max-w-7xl gap-8 px-4 py-10">
      <aside className="hidden w-56 shrink-0 space-y-4 lg:block">
        <h2 className="font-semibold text-foreground">Categories</h2>
        <ul className="space-y-1 text-sm">
          <li>
            <Link
              href="/shop"
              className={
                !sp.category
                  ? "inline-flex rounded-full bg-primary px-3 py-1.5 font-medium text-primary-foreground"
                  : "text-muted-foreground hover:text-foreground"
              }
            >
              All
            </Link>
          </li>
          {categories.map((c) => (
            <li key={c.id}>
              <Link
                href={`/shop?${(() => {
                  const x = baseQs();
                  x.set("category", c.slug);
                  return x.toString();
                })()}`}
                className={
                  sp.category === c.slug
                    ? "inline-flex rounded-full bg-primary px-3 py-1.5 font-medium text-primary-foreground"
                    : "text-muted-foreground hover:text-foreground"
                }
              >
                {c.name}
              </Link>
            </li>
          ))}
        </ul>
        <h2 className="pt-4 font-semibold text-foreground">Type</h2>
        <ul className="space-y-1 text-sm">
          <li>
            <Link
              href={`/shop?${qsb}`}
              className={!sp.type ? "inline-flex rounded-full bg-primary px-3 py-1.5 font-medium text-primary-foreground" : "text-muted-foreground hover:text-foreground"}
            >
              All types
            </Link>
          </li>
          <li>
            <Link
              href={`/shop?${(() => {
                const x = baseQs();
                x.set("type", "PHYSICAL");
                return x.toString();
              })()}`}
              className={
                sp.type === "PHYSICAL"
                  ? "inline-flex rounded-full bg-primary px-3 py-1.5 font-medium text-primary-foreground"
                  : "text-muted-foreground hover:text-foreground"
              }
            >
              Physical
            </Link>
          </li>
          <li>
            <Link
              href={`/shop?${(() => {
                const x = baseQs();
                x.set("type", "DIGITAL");
                return x.toString();
              })()}`}
              className={
                sp.type === "DIGITAL"
                  ? "inline-flex rounded-full bg-primary px-3 py-1.5 font-medium text-primary-foreground"
                  : "text-muted-foreground hover:text-foreground"
              }
            >
              Digital
            </Link>
          </li>
        </ul>
      </aside>
      <div className="min-w-0 flex-1">
        <h1 className="font-serif text-3xl font-bold text-foreground md:text-4xl">Shop Crystals</h1>
        <form className="mt-6 flex flex-wrap gap-2" action="/shop" method="get">
          {sp.category && <input type="hidden" name="category" value={sp.category} />}
          {sp.type && <input type="hidden" name="type" value={sp.type} />}
          <input
            name="q"
            defaultValue={sp.q}
            placeholder="Search crystals…"
            className="flex h-11 max-w-md flex-1 rounded-full border border-input bg-card px-4 text-sm shadow-sm"
          />
          <Button type="submit" className="rounded-full">
            Search
          </Button>
        </form>
        <div className="mt-4 flex flex-wrap items-center gap-2">
          <span className="text-sm text-muted-foreground">Sort:</span>
          {[
            ["latest", "Latest"],
            ["price_asc", "Price ↑"],
            ["price_desc", "Price ↓"],
            ["name", "Name"],
          ].map(([v, l]) => (
            <Button key={v} variant="outline" size="sm" className="rounded-full" asChild>
              <Link
                href={`/shop?${(() => {
                  const x = baseQs();
                  x.set("sort", v);
                  return x.toString();
                })()}`}
              >
                {l}
              </Link>
            </Button>
          ))}
        </div>
        <StaggerGrid className="mt-10 grid gap-5 sm:grid-cols-2 xl:grid-cols-3">
          {products.map((p) => (
            <ProductTile
              key={p.id}
              product={p}
              unitPricePaise={effectiveUnitPrice({ price: p.price, salePrice: p.salePrice })}
            />
          ))}
        </StaggerGrid>
        <div className="mt-12 flex justify-center gap-2">
          {page > 1 && (
            <Button variant="outline" className="rounded-full" asChild>
              <Link
                href={`/shop?${(() => {
                  const x = baseQs();
                  x.set("page", String(page - 1));
                  return x.toString();
                })()}`}
              >
                Previous
              </Link>
            </Button>
          )}
          {page < totalPages && (
            <Button variant="outline" className="rounded-full" asChild>
              <Link
                href={`/shop?${(() => {
                  const x = baseQs();
                  x.set("page", String(page + 1));
                  return x.toString();
                })()}`}
              >
                Next
              </Link>
            </Button>
          )}
        </div>
      </div>
    </div>
  );
}
