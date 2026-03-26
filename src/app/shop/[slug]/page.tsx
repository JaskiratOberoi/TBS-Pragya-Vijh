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
import { Card, CardContent } from "@/components/ui/card";
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
      <nav className="mb-6 text-sm text-muted-foreground">
        <Link href="/shop">Shop</Link>
        <span className="mx-2">/</span>
        <Link href={`/shop?category=${product.category.slug}`}>{product.category.name}</Link>
        <span className="mx-2">/</span>
        <span className="text-foreground">{product.name}</span>
      </nav>
      <div className="grid gap-10 lg:grid-cols-2">
        <div className="relative aspect-square overflow-hidden rounded-xl border bg-muted">
          <Image src={product.images[0] ?? "/assets/products/placeholder.svg"} alt={product.name} fill className="object-cover" priority />
          {off > 0 && (
            <Badge className="absolute left-3 top-3" variant="destructive">
              -{off}%
            </Badge>
          )}
          {product.productType === "DIGITAL" && (
            <Badge className="absolute right-3 top-3">Digital product</Badge>
          )}
        </div>
        <div>
          <h1 className="font-serif text-3xl font-bold text-primary">{product.name}</h1>
          <div className="mt-3 flex items-center gap-3">
            {product.salePrice != null && product.salePrice < product.price && (
              <span className="text-lg text-muted-foreground line-through">{formatINR(product.price)}</span>
            )}
            <span className="text-2xl font-semibold text-primary">{formatINR(unit)}</span>
          </div>
          {product.productType === "PHYSICAL" && (
            <p className="mt-2 text-sm text-muted-foreground">In stock: {product.stock}</p>
          )}
          <p className="mt-4 text-xs text-muted-foreground">
            Free Money Potli on orders ≥ ₹1499 · Buy 3 Get 1 Free (auto-applied in cart)
          </p>
          <div className="mt-6 flex flex-wrap gap-2">
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
        <section className="mt-16">
          <h2 className="font-serif text-xl font-semibold text-primary">Related products</h2>
          <div className="mt-6 grid gap-4 sm:grid-cols-2 md:grid-cols-4">
            {related.map((p) => (
              <Card key={p.id} className="overflow-hidden">
                <Link href={`/shop/${p.slug}`}>
                  <div className="relative aspect-square bg-muted">
                    <Image src={p.images[0] ?? "/assets/products/placeholder.svg"} alt={p.name} fill className="object-cover" />
                  </div>
                </Link>
                <CardContent className="p-3">
                  <Link href={`/shop/${p.slug}`} className="line-clamp-2 text-sm font-medium">
                    {p.name}
                  </Link>
                  <p className="text-sm text-primary">{formatINR(effectiveUnitPrice(p))}</p>
                </CardContent>
              </Card>
            ))}
          </div>
        </section>
      )}
    </div>
  );
}
