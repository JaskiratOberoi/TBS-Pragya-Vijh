import Link from "next/link";
import { ChevronLeft, ChevronRight } from "lucide-react";
import { strapiFetchPublicList, normalizeDoc } from "@/lib/strapi";
import { toProductTileModel } from "@/lib/strapi-mappers";
import { effectiveUnitPrice } from "@/lib/promo-engine";
import { Button } from "@/components/ui/button";
import { StaggerGrid } from "@/components/motion/StaggerGrid";
import { ProductTile } from "@/components/shop/ProductTile";
import { cn } from "@/lib/utils";
import type { Metadata } from "next";

export const metadata: Metadata = { title: "Shop Crystals" };

export const revalidate = 60;

function sidebarLinkClass(active: boolean) {
  return cn(
    "block border-l-2 py-1.5 pl-3 text-sm transition-colors",
    active
      ? "border-metal font-medium text-foreground"
      : "border-transparent text-muted-foreground hover:border-border hover:text-foreground"
  );
}

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
    const q = new URLSearchParams();
    if (sp.category) q.set("category", sp.category);
    if (sp.sort) q.set("sort", sp.sort);
    if (sp.type) q.set("type", sp.type);
    if (sp.q) q.set("q", sp.q);
    return q;
  };

  const sortOptions = [
    ["latest", "Latest"],
    ["price_asc", "Price ↑"],
    ["price_desc", "Price ↓"],
    ["name", "Name"],
  ] as const;

  return (
    <div className="mx-auto flex max-w-7xl flex-col gap-8 px-4 py-10 md:flex-row md:gap-10 md:py-14">
      <aside className="hidden w-56 shrink-0 lg:block">
        <p className="text-xs font-medium uppercase tracking-luxury text-muted-foreground">Categories</p>
        <ul className="mt-4 space-y-0.5">
          <li>
            <Link href="/shop" className={sidebarLinkClass(!sp.category)}>
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
                className={sidebarLinkClass(sp.category === c.slug)}
              >
                {c.name}
              </Link>
            </li>
          ))}
        </ul>
        <p className="mt-8 text-xs font-medium uppercase tracking-luxury text-muted-foreground">Product type</p>
        <ul className="mt-4 space-y-0.5">
          <li>
            <Link
              href={`/shop?${baseQs().toString()}`}
              className={sidebarLinkClass(!sp.type)}
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
              className={sidebarLinkClass(sp.type === "PHYSICAL")}
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
              className={sidebarLinkClass(sp.type === "DIGITAL")}
            >
              Digital
            </Link>
          </li>
        </ul>
      </aside>

      <div className="min-w-0 flex-1">
        <div className="flex min-h-[3rem] flex-col gap-4 border-b border-border/70 pb-6 sm:flex-row sm:items-end sm:justify-between">
          <div>
            <h1 className="font-display text-3xl font-semibold tracking-display text-foreground md:text-4xl">Shop Crystals</h1>
            <p className="mt-1 text-sm text-muted-foreground">
              {total} {total === 1 ? "piece" : "pieces"}
              {sp.category && categories.find((c) => c.slug === sp.category) ? (
                <span className="text-foreground/80"> · {categories.find((c) => c.slug === sp.category)?.name}</span>
              ) : null}
            </p>
          </div>
          <div className="flex shrink-0 flex-wrap items-center gap-2">
            <span className="text-xs font-medium uppercase tracking-luxury text-muted-foreground">Sort</span>
            <div className="flex flex-wrap gap-1.5">
              {sortOptions.map(([v, l]) => {
                const hrefSort = v === "latest" ? undefined : v;
                const active = (sp.sort ?? "latest") === v || (!sp.sort && v === "latest");
                return (
                  <Button
                    key={v}
                    variant={active ? "default" : "outline"}
                    size="sm"
                    className={cn("h-9 rounded-full px-3 text-xs", !active && "border-border/80 bg-transparent")}
                    asChild
                  >
                    <Link
                      href={`/shop?${(() => {
                        const x = baseQs();
                        if (hrefSort) x.set("sort", hrefSort);
                        else x.delete("sort");
                        return x.toString();
                      })()}`}
                    >
                      {l}
                    </Link>
                  </Button>
                );
              })}
            </div>
          </div>
        </div>

        <div className="-mx-4 mt-6 lg:hidden">
          <div className="flex gap-2 overflow-x-auto px-4 pb-1">
            <Link
              href="/shop"
              className={cn(
                "shrink-0 rounded-full border px-4 py-2 text-xs font-medium transition-colors",
                !sp.category ? "border-metal/50 bg-metal/10 text-foreground" : "border-border/80 text-muted-foreground"
              )}
            >
              All
            </Link>
            {categories.map((c) => (
              <Link
                key={c.id}
                href={`/shop?${(() => {
                  const x = baseQs();
                  x.set("category", c.slug);
                  return x.toString();
                })()}`}
                className={cn(
                  "shrink-0 rounded-full border px-4 py-2 text-xs font-medium transition-colors",
                  sp.category === c.slug
                    ? "border-metal/50 bg-metal/10 text-foreground"
                    : "border-border/80 text-muted-foreground"
                )}
              >
                {c.name}
              </Link>
            ))}
          </div>
        </div>

        <form className="mt-6 flex min-h-11 flex-wrap gap-2 border-b border-border/40 pb-6" action="/shop" method="get">
          {sp.category && <input type="hidden" name="category" value={sp.category} />}
          {sp.type && <input type="hidden" name="type" value={sp.type} />}
          {sp.sort && <input type="hidden" name="sort" value={sp.sort} />}
          <input
            name="q"
            defaultValue={sp.q}
            placeholder="Search crystals…"
            className="flex h-11 max-w-md flex-1 rounded-full border border-border/80 bg-card px-4 text-sm shadow-elevation-rest"
          />
          <Button type="submit" className="rounded-full">
            Search
          </Button>
        </form>

        <StaggerGrid className="mt-10 grid gap-5 sm:grid-cols-2 xl:grid-cols-3">
          {products.map((p) => (
            <ProductTile
              key={p.id}
              product={p}
              unitPricePaise={effectiveUnitPrice({ price: p.price, salePrice: p.salePrice })}
            />
          ))}
        </StaggerGrid>

        {totalPages > 1 && (
          <div className="mt-12 flex h-12 items-center justify-center gap-6 border-t border-border/60 pt-8">
            {page > 1 ? (
              <Button variant="ghost" size="icon" className="h-10 w-10 rounded-full" asChild aria-label="Previous page">
                <Link
                  href={`/shop?${(() => {
                    const x = baseQs();
                    x.set("page", String(page - 1));
                    return x.toString();
                  })()}`}
                >
                  <ChevronLeft className="h-5 w-5" />
                </Link>
              </Button>
            ) : (
              <span className="h-10 w-10" aria-hidden />
            )}
            <span className="min-w-[6rem] text-center text-sm tabular-nums text-muted-foreground">
              {page} / {totalPages}
            </span>
            {page < totalPages ? (
              <Button variant="ghost" size="icon" className="h-10 w-10 rounded-full" asChild aria-label="Next page">
                <Link
                  href={`/shop?${(() => {
                    const x = baseQs();
                    x.set("page", String(page + 1));
                    return x.toString();
                  })()}`}
                >
                  <ChevronRight className="h-5 w-5" />
                </Link>
              </Button>
            ) : (
              <span className="h-10 w-10" aria-hidden />
            )}
          </div>
        )}
      </div>
    </div>
  );
}
