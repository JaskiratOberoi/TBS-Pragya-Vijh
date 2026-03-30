import Image from "next/image";
import Link from "next/link";
import { notFound } from "next/navigation";
import { Truck, RotateCcw, ShieldCheck } from "lucide-react";
import { strapiFetchPublicList, normalizeDoc, unwrapList } from "@/lib/strapi";
import { findProductBySlug, findProductBySlugFull } from "@/lib/strapi-queries";
import { toProductTileModel } from "@/lib/strapi-mappers";
import { formatINR } from "@/lib/utils";
import { effectiveUnitPrice } from "@/lib/promo-engine";
import { Badge } from "@/components/ui/badge";
import { AddToCartButton } from "@/components/shop/AddToCartButton";
import { WishlistButton } from "@/components/shop/WishlistButton";
import { ProductDetailTabs } from "@/components/shop/ProductDetailTabs";
import { StaggerGrid } from "@/components/motion/StaggerGrid";
import { ProductTile } from "@/components/shop/ProductTile";
import { cn } from "@/lib/utils";
import type { Metadata } from "next";

export async function generateMetadata({ params }: { params: Promise<{ slug: string }> }): Promise<Metadata> {
  const { slug } = await params;
  const p = await findProductBySlug(slug);
  if (!p) return {};
  const imgs = p.images;
  const images = Array.isArray(imgs) ? imgs.map(String) : [];
  return { title: p.name, openGraph: { title: p.name, images } };
}

export const revalidate = 60;

export default async function ProductPage({ params }: { params: Promise<{ slug: string }> }) {
  const { slug } = await params;
  const raw = await findProductBySlugFull(slug);
  if (!raw || raw.isActive === false) notFound();
  const product = raw as Record<string, unknown>;
  const category = (product.category ?? {}) as { slug?: string; name?: string; documentId?: string };
  const productDocId = String(product.documentId ?? product.id ?? "");
  const catDocId = String(category.documentId ?? "");

  const [relatedJson, reviewsJson] = await Promise.all([
    strapiFetchPublicList<{ data?: unknown[] }>(
      `/api/products?filters[isActive][$eq]=true&filters[category][documentId][$eq]=${encodeURIComponent(catDocId)}&filters[documentId][$ne]=${encodeURIComponent(productDocId)}&pagination[pageSize]=8`,
      { next: { revalidate: 60 } }
    ),
    strapiFetchPublicList<{ data?: unknown[] }>(
      `/api/reviews?filters[product][documentId][$eq]=${encodeURIComponent(productDocId)}&populate[user]=true&sort[0]=createdAt:desc&pagination[pageSize]=20`,
      { next: { revalidate: 60 } }
    ),
  ]);

  const related = (relatedJson.data ?? []).map((x) => toProductTileModel(normalizeDoc(x)));
  const reviewRows = unwrapList(reviewsJson) as Array<{
    id?: string;
    rating?: number;
    comment?: string;
    user?: { username?: string; email?: string };
  }>;

  const reviews = reviewRows.map((r) => ({
    id: String(r.id),
    rating: Number(r.rating ?? 0),
    comment: String(r.comment ?? ""),
    author: r.user?.username ?? r.user?.email ?? "Customer",
  }));

  const images = Array.isArray(product.images) ? product.images.map(String) : [];
  const unit = effectiveUnitPrice({
    price: Number(product.price ?? 0),
    salePrice: product.salePrice != null ? Number(product.salePrice) : null,
  });
  const price = Number(product.price ?? 0);
  const salePrice = product.salePrice != null ? Number(product.salePrice) : null;
  const off = salePrice != null && salePrice < price ? Math.round((1 - salePrice / price) * 100) : 0;
  const onSale = salePrice != null && salePrice < price;

  const jsonLd = {
    "@context": "https://schema.org",
    "@type": "Product",
    name: product.name,
    image: images,
    offers: { "@type": "Offer", priceCurrency: "INR", price: (unit / 100).toFixed(2) },
  };

  return (
    <div className="mx-auto max-w-7xl px-4 py-10 md:py-14">
      <script type="application/ld+json" dangerouslySetInnerHTML={{ __html: JSON.stringify(jsonLd) }} />
      <nav className="mb-8 text-sm text-muted-foreground">
        <Link href="/shop" className="transition hover:text-foreground">
          Shop
        </Link>
        <span className="mx-2 text-border">/</span>
        <Link href={`/shop?category=${category.slug ?? ""}`} className="transition hover:text-foreground">
          {category.name}
        </Link>
        <span className="mx-2 text-border">/</span>
        <span className="text-foreground">{String(product.name)}</span>
      </nav>

      <div className="grid gap-10 lg:grid-cols-2 lg:gap-14">
        <div className="lg:sticky lg:top-24 lg:self-start">
          <div className="relative aspect-[4/5] overflow-hidden rounded-3xl border border-border/50 bg-muted shadow-elevation-rest">
            <Image
              src={images[0] ?? "/assets/products/placeholder.svg"}
              alt={String(product.name)}
              fill
              className="object-cover"
              priority
              sizes="(max-width: 1024px) 100vw, 50vw"
            />
            {off > 0 && (
              <Badge className="absolute left-4 top-4 border border-metal/30 px-3 py-1" variant="metal">
                −{off}%
              </Badge>
            )}
            {product.productType === "DIGITAL" && (
              <Badge className="absolute right-4 top-4 rounded-full border border-border/60 bg-background/95 backdrop-blur-sm">
                Digital product
              </Badge>
            )}
          </div>
        </div>

        <div>
          <h1 className="font-display text-3xl font-semibold leading-tight tracking-display text-foreground md:text-4xl lg:text-[2.35rem]">
            {String(product.name)}
          </h1>

          <div className="mt-6 flex flex-wrap items-baseline gap-3">
            {onSale && <span className="text-lg text-muted-foreground line-through">{formatINR(price)}</span>}
            <span
              className={cn(
                "font-display text-2xl font-semibold tabular-nums md:text-3xl",
                onSale ? "text-metal-muted" : "text-foreground"
              )}
            >
              {formatINR(unit)}
            </span>
          </div>

          {product.productType === "PHYSICAL" && (
            <p className="mt-3 text-sm text-muted-foreground">In stock: {Number(product.stock ?? 0)}</p>
          )}

          <p className="mt-4 text-xs leading-relaxed text-muted-foreground">
            Free Money Potli on orders ≥ ₹1499 · Buy 3 Get 1 Free (auto-applied in cart)
          </p>

          <div className="mt-8 flex flex-col gap-3 sm:flex-row sm:flex-wrap sm:items-center">
            <AddToCartButton productId={productDocId} />
            <WishlistButton productId={productDocId} />
          </div>

          <ul className="mt-8 grid gap-3 sm:grid-cols-3">
            <li className="flex gap-2 rounded-2xl border border-border/60 bg-card/50 px-3 py-3 text-xs text-muted-foreground">
              <Truck className="h-4 w-4 shrink-0 text-metal-muted" aria-hidden />
              <span>Pan-India shipping on physical items</span>
            </li>
            <li className="flex gap-2 rounded-2xl border border-border/60 bg-card/50 px-3 py-3 text-xs text-muted-foreground">
              <RotateCcw className="h-4 w-4 shrink-0 text-metal-muted" aria-hidden />
              <span>See refund policy for returns</span>
            </li>
            <li className="flex gap-2 rounded-2xl border border-border/60 bg-card/50 px-3 py-3 text-xs text-muted-foreground">
              <ShieldCheck className="h-4 w-4 shrink-0 text-metal-muted" aria-hidden />
              <span>Secure checkout via Razorpay</span>
            </li>
          </ul>

          <ProductDetailTabs
            description={String(product.description ?? "")}
            healing={product.healingProperties != null ? String(product.healingProperties) : null}
            wearHand={product.wearHand != null ? String(product.wearHand) : null}
            isDigital={product.productType === "DIGITAL"}
            slug={slug}
            reviews={reviews}
          />
        </div>
      </div>

      {related.length > 0 && (
        <section className="mt-20 border-t border-border/60 pt-16 md:mt-24 md:pt-20">
          <h2 className="font-display text-xl font-semibold tracking-display text-foreground md:text-2xl">Related products</h2>
          <p className="mt-1 text-sm text-muted-foreground">More from this category</p>
          <StaggerGrid className="mt-8 grid gap-5 sm:grid-cols-2 md:grid-cols-4">
            {related.map((p) => (
              <ProductTile
                key={p.id}
                product={p}
                unitPricePaise={effectiveUnitPrice({ price: p.price, salePrice: p.salePrice })}
              />
            ))}
          </StaggerGrid>
        </section>
      )}
    </div>
  );
}
