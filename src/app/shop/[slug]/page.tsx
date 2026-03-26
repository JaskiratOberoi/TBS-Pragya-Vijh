import Image from "next/image";
import Link from "next/link";
import { notFound } from "next/navigation";
import { prisma } from "@/lib/prisma";
import { formatINR } from "@/lib/utils";
import { effectiveUnitPrice } from "@/lib/promo-engine";
import { Badge } from "@/components/ui/badge";
import { AddToCartButton } from "@/components/shop/AddToCartButton";
import { WishlistButton } from "@/components/shop/WishlistButton";
import { ProductDetailTabs } from "@/components/shop/ProductDetailTabs";
import { ProductTile } from "@/components/shop/ProductTile";
import type { Metadata } from "next";

export async function generateMetadata({ params }: { params: Promise<{ slug: string }> }): Promise<Metadata> {
  const { slug } = await params;
  const p = await prisma.product.findUnique({ where: { slug } });
  if (!p) return {};
  return { title: p.name, openGraph: { title: p.name, images: p.images } };
}

export const revalidate = 60;

export default async function ProductPage({ params }: { params: Promise<{ slug: string }> }) {
  const { slug } = await params;
  const product = await prisma.product.findUnique({
    where: { slug },
    include: { category: true, shippingClass: true, variants: true, digitalAssets: true },
  });
  if (!product || !product.isActive) notFound();

  const [related, reviewRows] = await Promise.all([
    prisma.product.findMany({
      where: { isActive: true, categoryId: product.categoryId, NOT: { id: product.id } },
      take: 8,
    }),
    prisma.review.findMany({
      where: { productId: product.id },
      include: { user: { select: { name: true } } },
      orderBy: { createdAt: "desc" },
      take: 20,
    }),
  ]);

  const reviews = reviewRows.map((r) => ({
    id: r.id,
    rating: r.rating,
    comment: r.comment,
    author: r.user.name ?? "Customer",
  }));

  const unit = effectiveUnitPrice(product);
  const off = product.salePrice != null && product.salePrice < product.price ? Math.round((1 - product.salePrice / product.price) * 100) : 0;

  const jsonLd = {
    "@context": "https://schema.org",
    "@type": "Product",
    name: product.name,
    image: product.images,
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
        <Link href={`/shop?category=${product.category.slug}`} className="hover:text-foreground">
          {product.category.name}
        </Link>
        <span className="mx-2">/</span>
        <span className="text-foreground">{product.name}</span>
      </nav>
      <div className="grid gap-10 lg:grid-cols-2">
        <div className="relative aspect-square overflow-hidden rounded-4xl border border-border/40 bg-muted shadow-bento">
          <Image
            src={product.images[0] ?? "/assets/products/placeholder.svg"}
            alt={product.name}
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
          <h1 className="font-serif text-3xl font-bold text-foreground md:text-4xl">{product.name}</h1>
          <div className="mt-4 flex items-center gap-3">
            {product.salePrice != null && product.salePrice < product.price && (
              <span className="text-lg text-muted-foreground line-through">{formatINR(product.price)}</span>
            )}
            <span className="inline-flex rounded-full bg-primary px-4 py-2 text-xl font-semibold text-primary-foreground shadow-bento-sm">
              {formatINR(unit)}
            </span>
          </div>
          {product.productType === "PHYSICAL" && (
            <p className="mt-3 text-sm text-muted-foreground">In stock: {product.stock}</p>
          )}
          <p className="mt-4 text-xs text-muted-foreground">
            Free Money Potli on orders ≥ ₹1499 · Buy 3 Get 1 Free (auto-applied in cart)
          </p>
          <div className="mt-8 flex flex-wrap gap-3">
            <AddToCartButton productId={product.id} />
            <WishlistButton productId={product.id} />
          </div>
          <ProductDetailTabs
            description={product.description}
            healing={product.healingProperties}
            wearHand={product.wearHand}
            isDigital={product.productType === "DIGITAL"}
            slug={slug}
            reviews={reviews}
          />
        </div>
      </div>
      {related.length > 0 && (
        <section className="mt-20">
          <h2 className="font-serif text-xl font-bold text-foreground md:text-2xl">Related products</h2>
          <div className="mt-8 grid gap-5 sm:grid-cols-2 md:grid-cols-4">
            {related.map((p) => (
              <ProductTile key={p.id} product={p} unitPricePaise={effectiveUnitPrice(p)} />
            ))}
          </div>
        </section>
      )}
    </div>
  );
}
