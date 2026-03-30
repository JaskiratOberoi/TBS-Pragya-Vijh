import Image from "next/image";
import Link from "next/link";
import { notFound } from "next/navigation";
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

  const jsonLd = {
    "@context": "https://schema.org",
    "@type": "Product",
    name: product.name,
    image: images,
    offers: { "@type": "Offer", priceCurrency: "INR", price: (unit / 100).toFixed(2) },
  };

  return (
    <div className="mx-auto max-w-7xl px-4 py-10">
      <script type="application/ld+json" dangerouslySetInnerHTML={{ __html: JSON.stringify(jsonLd) }} />
      <nav className="mb-8 text-sm text-muted-foreground">
        <Link href="/shop" className="hover:text-foreground">
          Shop
        </Link>
        <span className="mx-2">/</span>
        <Link href={`/shop?category=${category.slug ?? ""}`} className="hover:text-foreground">
          {category.name}
        </Link>
        <span className="mx-2">/</span>
        <span className="text-foreground">{String(product.name)}</span>
      </nav>
      <div className="grid gap-10 lg:grid-cols-2">
        <div className="relative aspect-square overflow-hidden rounded-4xl border border-border/40 bg-muted shadow-bento">
          <Image
            src={images[0] ?? "/assets/products/placeholder.svg"}
            alt={String(product.name)}
            fill
            className="object-cover"
            priority
          />
          {off > 0 && (
            <Badge className="absolute left-4 top-4 rounded-full px-3 py-1 shadow-sm" variant="destructive">
              -{off}%
            </Badge>
          )}
          {product.productType === "DIGITAL" && (
            <Badge className="absolute right-4 top-4 rounded-full bg-background/95 backdrop-blur-sm">Digital product</Badge>
          )}
        </div>
        <div>
          <h1 className="font-serif text-3xl font-bold text-foreground md:text-4xl">{String(product.name)}</h1>
          <div className="mt-4 flex items-center gap-3">
            {salePrice != null && salePrice < price && (
              <span className="text-lg text-muted-foreground line-through">{formatINR(price)}</span>
            )}
            <span className="inline-flex rounded-full bg-primary px-4 py-2 text-xl font-semibold text-primary-foreground shadow-bento-sm">
              {formatINR(unit)}
            </span>
          </div>
          {product.productType === "PHYSICAL" && (
            <p className="mt-3 text-sm text-muted-foreground">In stock: {Number(product.stock ?? 0)}</p>
          )}
          <p className="mt-4 text-xs text-muted-foreground">
            Free Money Potli on orders ≥ ₹1499 · Buy 3 Get 1 Free (auto-applied in cart)
          </p>
          <div className="mt-8 flex flex-wrap gap-3">
            <AddToCartButton productId={productDocId} />
            <WishlistButton productId={productDocId} />
          </div>
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
        <section className="mt-20">
          <h2 className="font-serif text-xl font-bold text-foreground md:text-2xl">Related products</h2>
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
