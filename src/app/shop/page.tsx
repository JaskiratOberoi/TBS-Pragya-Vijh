import Link from "next/link";
import Image from "next/image";
import { prisma } from "@/lib/prisma";
import { formatINR } from "@/lib/utils";
import { effectiveUnitPrice } from "@/lib/promo-engine";
import { Card, CardContent } from "@/components/ui/card";
import { Badge } from "@/components/ui/badge";
import { Button } from "@/components/ui/button";
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
  const where = {
    isActive: true,
    ...(sp.category ? { category: { slug: sp.category } } : {}),
    ...(sp.type === "PHYSICAL" || sp.type === "DIGITAL" ? { productType: sp.type as "PHYSICAL" | "DIGITAL" } : {}),
    ...(sp.q
      ? {
          OR: [
            { name: { contains: sp.q, mode: "insensitive" as const } },
            { description: { contains: sp.q, mode: "insensitive" as const } },
          ],
        }
      : {}),
  };
  let orderBy: { createdAt?: "desc"; price?: "asc" | "desc"; name?: "asc" } = { createdAt: "desc" };
  if (sp.sort === "price_asc") orderBy = { price: "asc" };
  if (sp.sort === "price_desc") orderBy = { price: "desc" };
  if (sp.sort === "name") orderBy = { name: "asc" };

  const [total, products, categories] = await Promise.all([
    prisma.product.count({ where }),
    prisma.product.findMany({
      where,
      orderBy,
      skip: (page - 1) * limit,
      take: limit,
      include: { category: true },
    }),
    prisma.productCategory.findMany({ orderBy: { sortOrder: "asc" } }),
  ]);

  const totalPages = Math.ceil(total / limit);
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
        <h2 className="font-semibold text-primary">Categories</h2>
        <ul className="space-y-2 text-sm">
          <li>
            <Link href="/shop" className={!sp.category ? "font-medium text-primary" : "text-muted-foreground"}>
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
                className={sp.category === c.slug ? "font-medium text-primary" : "text-muted-foreground"}
              >
                {c.name}
              </Link>
            </li>
          ))}
        </ul>
        <h2 className="pt-4 font-semibold text-primary">Type</h2>
        <ul className="space-y-2 text-sm">
          <li>
            <Link href={`/shop?${qsb}`} className={!sp.type ? "font-medium text-primary" : "text-muted-foreground"}>
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
              className={sp.type === "PHYSICAL" ? "font-medium text-primary" : "text-muted-foreground"}
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
              className={sp.type === "DIGITAL" ? "font-medium text-primary" : "text-muted-foreground"}
            >
              Digital
            </Link>
          </li>
        </ul>
      </aside>
      <div className="min-w-0 flex-1">
        <h1 className="font-serif text-3xl font-bold text-primary">Shop Crystals</h1>
        <form className="mt-4 flex flex-wrap gap-2" action="/shop" method="get">
          {sp.category && <input type="hidden" name="category" value={sp.category} />}
          {sp.type && <input type="hidden" name="type" value={sp.type} />}
          <input
            name="q"
            defaultValue={sp.q}
            placeholder="Search crystals…"
            className="flex h-10 max-w-md flex-1 rounded-md border border-input bg-background px-3 text-sm"
          />
          <Button type="submit">Search</Button>
        </form>
        <div className="mt-4 flex flex-wrap items-center gap-2">
          <span className="text-sm text-muted-foreground">Sort:</span>
          {[
            ["latest", "Latest"],
            ["price_asc", "Price ↑"],
            ["price_desc", "Price ↓"],
            ["name", "Name"],
          ].map(([v, l]) => (
            <Button key={v} variant="outline" size="sm" asChild>
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
        <div className="mt-8 grid gap-4 sm:grid-cols-2 xl:grid-cols-3">
          {products.map((p) => {
            const unit = effectiveUnitPrice(p);
            const off = p.salePrice != null && p.salePrice < p.price ? Math.round((1 - p.salePrice / p.price) * 100) : 0;
            return (
              <Card key={p.id} className="overflow-hidden">
                <Link href={`/shop/${p.slug}`}>
                  <div className="relative aspect-square bg-muted">
                    <Image src={p.images[0] ?? "/assets/products/placeholder.svg"} alt={p.name} fill className="object-cover" />
                    {off > 0 && (
                      <Badge className="absolute left-2 top-2" variant="destructive">
                        -{off}%
                      </Badge>
                    )}
                    {p.productType === "DIGITAL" && (
                      <Badge className="absolute right-2 top-2" variant="secondary">
                        Digital
                      </Badge>
                    )}
                  </div>
                </Link>
                <CardContent className="space-y-2 p-4">
                  <Link href={`/shop/${p.slug}`} className="line-clamp-2 font-medium hover:underline">
                    {p.name}
                  </Link>
                  <div className="flex items-center gap-2 text-sm">
                    {p.salePrice != null && p.salePrice < p.price && (
                      <span className="text-muted-foreground line-through">{formatINR(p.price)}</span>
                    )}
                    <span className="font-semibold text-primary">{formatINR(unit)}</span>
                  </div>
                </CardContent>
              </Card>
            );
          })}
        </div>
        <div className="mt-10 flex justify-center gap-2">
          {page > 1 && (
            <Button variant="outline" asChild>
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
            <Button variant="outline" asChild>
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
