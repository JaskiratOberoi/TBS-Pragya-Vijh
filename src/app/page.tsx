import Link from "next/link";
import Image from "next/image";
import { strapiFetchPublicList, normalizeDoc } from "@/lib/strapi";
import { toProductTileModel } from "@/lib/strapi-mappers";
import { Button } from "@/components/ui/button";
import { Card, CardContent } from "@/components/ui/card";
import { Tabs, TabsContent, TabsList, TabsTrigger } from "@/components/ui/tabs";
import { Badge } from "@/components/ui/badge";
import { formatINR } from "@/lib/utils";
import { effectiveUnitPrice } from "@/lib/promo-engine";
import { TestimonialsCarousel } from "@/components/home/TestimonialsCarousel";
import { HomeBentoReveal } from "@/components/home/HomeBentoReveal";
import { KpiCounters } from "@/components/home/KpiCounters";
import { StaggerGrid } from "@/components/motion/StaggerGrid";
import { ProductTile } from "@/components/shop/ProductTile";
import { BookNowButton } from "@/components/services/BookNowButton";

export const revalidate = 60;

export default async function HomePage() {
  const [pr, sr, tr] = await Promise.all([
    strapiFetchPublicList<{ data?: unknown[] }>(
      `/api/products?filters[isActive][$eq]=true&populate[category]=true&sort[0]=createdAt:desc&pagination[page]=1&pagination[pageSize]=4`,
      { next: { revalidate: 60 } }
    ),
    strapiFetchPublicList<{ data?: unknown[] }>(
      `/api/services?filters[isActive][$eq]=true&sort[0]=price:asc&pagination[pageSize]=100`,
      { next: { revalidate: 60 } }
    ),
    strapiFetchPublicList<{ data?: unknown[] }>(
      `/api/testimonials?filters[isActive][$eq]=true&sort[0]=sortOrder:asc&pagination[pageSize]=100`,
      { next: { revalidate: 60 } }
    ),
  ]);
  const hotProducts = (pr.data ?? []).map((x) => toProductTileModel(normalizeDoc(x)));
  const services = (sr.data ?? []).map((x) => normalizeDoc(x)) as Array<{
    id: string;
    name: string;
    type: string;
    price: number;
    durationMinutes: number;
  }>;
  const testimonials = (tr.data ?? []).map((x) => {
    const t = normalizeDoc(x);
    return { id: String(t.id), name: String(t.name), text: String(t.text) };
  });

  const topServices = services.filter((s) => s.name.includes("Tarot") || s.name.includes("All-in"));
  const audio = services.filter((s) => s.type === "AUDIO");
  const video = services.filter((s) => s.type === "VIDEO");

  const jsonLd = {
    "@context": "https://schema.org",
    "@type": "LocalBusiness",
    name: "The Blissful Soul",
    description: "Healing crystals and spiritual sessions.",
    address: { "@type": "PostalAddress", addressLocality: "Delhi", addressCountry: "IN" },
  };

  return (
    <>
      <script type="application/ld+json" dangerouslySetInnerHTML={{ __html: JSON.stringify(jsonLd) }} />
      <HomeBentoReveal>
        <div className="grid auto-rows-fr gap-4 md:grid-cols-12 md:gap-5">
          <div className="relative flex flex-col justify-between overflow-hidden rounded-4xl bg-gradient-to-br from-bento-mint via-card to-bento-cream p-8 shadow-bento md:col-span-7 md:row-span-2 md:min-h-[320px]">
            <div>
              <p className="text-sm font-medium uppercase tracking-wide text-primary/90">Welcome</p>
              <h1 className="mt-2 font-serif text-3xl font-bold tracking-tight text-foreground md:text-4xl lg:text-5xl">
                Heal, manifest & align with Master Pragya Vijh
              </h1>
              <p className="mt-4 max-w-xl text-lg text-muted-foreground">
                Premium healing crystals, bracelets, pyramids — and personal audio & video sessions for clarity and
                growth.
              </p>
            </div>
            <div className="mt-8 flex flex-wrap gap-3">
              <Button asChild size="lg" className="rounded-full px-8">
                <Link href="/services">Book now</Link>
              </Button>
              <Button asChild size="lg" variant="outline" className="rounded-full border-border bg-card/80 px-8">
                <Link href="/about">Read more</Link>
              </Button>
            </div>
          </div>

          <div className="relative hidden min-h-[200px] overflow-hidden rounded-4xl border border-border/50 bg-muted shadow-bento md:col-span-5 md:block">
            <Image
              src="/assets/products/placeholder.svg"
              alt="Master Pragya Vijh"
              fill
              className="object-cover"
              priority
            />
          </div>

          <Link
            href="/shop"
            className="flex flex-col justify-between rounded-4xl bg-bento-peach p-6 shadow-bento transition hover:shadow-bento-sm md:col-span-5"
          >
            <div>
              <p className="text-sm font-semibold text-primary">Shop</p>
              <h2 className="mt-1 font-serif text-xl font-bold text-foreground">Crystals &amp; tools</h2>
              <p className="mt-2 text-sm text-muted-foreground">Bracelets, pyramids, tumbles &amp; more.</p>
            </div>
            <span className="mt-4 inline-flex w-fit items-center rounded-full bg-primary px-4 py-2 text-sm font-medium text-primary-foreground">
              Explore shop
            </span>
          </Link>
        </div>
      </HomeBentoReveal>

      <section className="mx-auto max-w-7xl px-4 py-10">
        <div className="flex flex-col gap-2 md:flex-row md:items-end md:justify-between">
          <div>
            <h2 className="font-serif text-2xl font-bold text-foreground md:text-3xl">Hot sellers</h2>
            <p className="text-sm text-muted-foreground">Fresh picks from the catalog</p>
          </div>
          <Button variant="outline" asChild className="mt-2 w-fit rounded-full md:mt-0">
            <Link href="/shop">See all</Link>
          </Button>
        </div>
        <StaggerGrid className="mt-8 grid gap-5 sm:grid-cols-2 lg:grid-cols-4">
          {hotProducts.map((p) => (
            <ProductTile
              key={p.id}
              product={p}
              unitPricePaise={effectiveUnitPrice({ price: p.price, salePrice: p.salePrice })}
            />
          ))}
        </StaggerGrid>
      </section>

      <section className="bg-bento-mint/50 py-14">
        <div className="mx-auto max-w-7xl px-4">
          <h2 className="text-center font-serif text-2xl font-bold text-foreground md:text-3xl">Book your session</h2>
          <p className="mx-auto mt-2 max-w-lg text-center text-sm text-muted-foreground">Audio &amp; video readings and counselling</p>
          <Tabs defaultValue="top" className="mt-10">
            <TabsList className="mx-auto flex h-auto w-full max-w-md flex-wrap justify-center gap-1 rounded-full border border-border/60 bg-card/90 p-1 shadow-sm">
              <TabsTrigger value="top" className="rounded-full px-4 data-[state=active]:shadow-sm">
                Top
              </TabsTrigger>
              <TabsTrigger value="audio" className="rounded-full px-4 data-[state=active]:shadow-sm">
                Audio
              </TabsTrigger>
              <TabsTrigger value="video" className="rounded-full px-4 data-[state=active]:shadow-sm">
                Video
              </TabsTrigger>
            </TabsList>
            <TabsContent value="top" className="mt-8 grid gap-5 sm:grid-cols-2 lg:grid-cols-3">
              {topServices.map((s) => (
                <ServiceCard key={s.id} s={s} />
              ))}
            </TabsContent>
            <TabsContent value="audio" className="mt-8 grid gap-5 sm:grid-cols-2 lg:grid-cols-3">
              {audio.map((s) => (
                <ServiceCard key={s.id} s={s} />
              ))}
            </TabsContent>
            <TabsContent value="video" className="mt-8 grid gap-5 sm:grid-cols-2 lg:grid-cols-3">
              {video.map((s) => (
                <ServiceCard key={s.id} s={s} />
              ))}
            </TabsContent>
          </Tabs>
        </div>
      </section>

      <section className="mx-auto max-w-7xl px-4 py-14">
        <div className="flex items-end justify-between gap-4">
          <div>
            <h2 className="font-serif text-2xl font-bold text-foreground md:text-3xl">Shop healing crystals</h2>
            <p className="mt-1 text-sm text-muted-foreground">Same favorites as the shop grid</p>
          </div>
          <Button variant="outline" asChild className="rounded-full">
            <Link href="/shop">See all</Link>
          </Button>
        </div>
        <StaggerGrid className="mt-8 grid gap-5 sm:grid-cols-2 md:grid-cols-4">
          {hotProducts.slice(0, 4).map((p) => (
            <ProductTile
              key={`dup-${p.id}`}
              product={p}
              unitPricePaise={effectiveUnitPrice({ price: p.price, salePrice: p.salePrice })}
            />
          ))}
        </StaggerGrid>
      </section>

      <section className="bg-bento-cream/60 py-14">
        <div className="mx-auto max-w-7xl px-4">
          <h2 className="text-center font-serif text-2xl font-bold text-foreground md:text-3xl">On Instagram</h2>
          <div className="mt-8 grid grid-cols-3 gap-2 sm:grid-cols-4 md:grid-cols-6 md:gap-3">
            {Array.from({ length: 12 }).map((_, i) => (
              <div key={i} className="relative aspect-square overflow-hidden rounded-3xl bg-muted shadow-sm">
                <Image src="/assets/products/placeholder.svg" alt="" fill className="object-cover opacity-70" />
              </div>
            ))}
          </div>
          <p className="mt-6 text-center text-sm text-muted-foreground">@pragya.vijh_astrotalks — follow for daily guidance</p>
        </div>
      </section>

      <section className="mx-auto max-w-7xl px-4 py-14">
        <TestimonialsCarousel testimonials={testimonials} />
      </section>

      <KpiCounters />

      <section className="pb-16 text-center">
        <Button asChild variant="secondary" size="lg" className="rounded-full">
          <a href="https://g.page/r/YOUR_PLACE_ID/review" target="_blank" rel="noreferrer">
            Google reviews
          </a>
        </Button>
      </section>
    </>
  );
}

function ServiceCard({ s }: { s: { id: string; name: string; type: string; price: number; durationMinutes: number } }) {
  return (
    <Card className="rounded-3xl border-0 shadow-bento">
      <CardContent className="space-y-4 p-6">
        <div className="flex items-center justify-between gap-2">
          <h3 className="font-medium leading-snug">{s.name}</h3>
          <Badge variant="secondary" className="shrink-0 rounded-full">
            {s.type}
          </Badge>
        </div>
        <p className="text-sm text-muted-foreground">{s.durationMinutes} min</p>
        <p className="text-lg font-semibold text-primary">{formatINR(s.price)}</p>
        <BookNowButton serviceId={s.id} className="rounded-full" />
      </CardContent>
    </Card>
  );
}
