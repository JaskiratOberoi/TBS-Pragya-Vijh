import Link from "next/link";
import Image from "next/image";
import { strapiFetchPublicList, normalizeDoc } from "@/lib/strapi";
import { toProductTileModel } from "@/lib/strapi-mappers";
import { Button } from "@/components/ui/button";
import { Tabs, TabsContent, TabsList, TabsTrigger } from "@/components/ui/tabs";
import { formatINR } from "@/lib/utils";
import { effectiveUnitPrice } from "@/lib/promo-engine";
import { TestimonialsCarousel } from "@/components/home/TestimonialsCarousel";
import { HomeBentoReveal } from "@/components/home/HomeBentoReveal";
import { KpiCounters } from "@/components/home/KpiCounters";
import { StaggerGrid } from "@/components/motion/StaggerGrid";
import { ProductTile } from "@/components/shop/ProductTile";
import { SessionServiceCard } from "@/components/services/SessionServiceCard";
import { InstagramFeedSection } from "@/components/home/InstagramFeedSection";
import { MotionSection } from "@/components/motion/MotionSection";

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
        <div className="bento-stagger grid auto-rows-fr gap-4 md:grid-cols-12 md:gap-5">
          <div className="hero-sheen relative flex flex-col justify-between overflow-hidden rounded-4xl bg-gradient-to-br from-bento-mint via-card to-bento-cream p-8 shadow-elevation-hover md:col-span-7 md:row-span-2 md:min-h-[320px]">
            <div>
              <p className="text-xs font-medium uppercase tracking-luxury text-primary/90">Welcome</p>
              <h1 className="mt-3 font-display text-3xl font-semibold leading-tight tracking-display text-foreground md:text-4xl lg:text-[2.75rem]">
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

          <div className="group relative hidden min-h-[200px] overflow-hidden rounded-4xl border border-border/50 bg-muted shadow-elevation-rest transition-shadow duration-500 hover:shadow-elevation-hover md:col-span-5 md:block">
            <Image
              src="/assets/products/placeholder.svg"
              alt="Master Pragya Vijh"
              fill
              className="object-cover transition-transform duration-700 ease-out group-hover:scale-[1.03]"
              priority
            />
          </div>

          <Link
            href="/shop"
            className="flex flex-col justify-between rounded-4xl bg-bento-peach p-6 shadow-elevation-rest transition-all duration-500 hover:-translate-y-1 hover:shadow-elevation-hover md:col-span-5"
          >
            <div>
              <p className="text-xs font-medium uppercase tracking-luxury text-primary">Shop</p>
              <h2 className="mt-2 font-display text-xl font-semibold tracking-display text-foreground">Crystals &amp; tools</h2>
              <p className="mt-2 text-sm text-muted-foreground">Bracelets, pyramids, tumbles &amp; more.</p>
            </div>
            <span className="mt-4 inline-flex w-fit items-center rounded-full bg-primary px-4 py-2 text-sm font-medium text-primary-foreground">
              Explore shop
            </span>
          </Link>
        </div>
      </HomeBentoReveal>

      <section className="section-inverse-aurora relative border-y border-metal/10 bg-inverse py-16 text-inverse-foreground md:py-24">
        <span className="section-inverse-top-glow" aria-hidden />
        <span className="section-inverse-top-sweep" aria-hidden />
        <div className="relative z-[4] mx-auto max-w-7xl px-4 text-center">
          <p className="text-xs font-medium uppercase tracking-luxury text-metal">Curated for you</p>
          <h2 className="mx-auto mt-3 max-w-2xl font-display text-2xl font-semibold leading-snug tracking-display md:text-3xl">
            Crystals and sessions chosen for depth, clarity, and everyday ritual.
          </h2>
          <p className="mx-auto mt-4 max-w-xl text-sm leading-relaxed text-inverse-muted">
            Every piece is selected to support your journey — from wearable energy to one-on-one guidance with Master Pragya Vijh.
          </p>
          <Button asChild size="lg" className="mt-8 rounded-full bg-metal px-10 text-metal-foreground hover:bg-metal/90">
            <Link href="/shop">Browse the shop</Link>
          </Button>
        </div>
      </section>

      <MotionSection emphasis>
        <section className="mx-auto max-w-7xl px-4 py-16 md:py-24">
        <div className="flex flex-col gap-2 md:flex-row md:items-end md:justify-between">
          <div>
            <p className="text-xs font-medium uppercase tracking-luxury text-muted-foreground">Catalog</p>
            <h2 className="mt-2 font-display text-2xl font-semibold tracking-display text-foreground md:text-3xl">Hot sellers</h2>
            <p className="mt-1 text-sm text-muted-foreground">Fresh picks from the catalog</p>
          </div>
          <Button variant="outline" asChild className="mt-2 w-fit rounded-full border-border/80 md:mt-0">
            <Link href="/shop">See all</Link>
          </Button>
        </div>
        <StaggerGrid className="mt-10 grid gap-5 sm:grid-cols-2 lg:grid-cols-4">
          {hotProducts.map((p) => (
            <ProductTile
              key={p.id}
              product={p}
              unitPricePaise={effectiveUnitPrice({ price: p.price, salePrice: p.salePrice })}
            />
          ))}
        </StaggerGrid>
        </section>
      </MotionSection>

      <MotionSection>
        <section className="sessions-ambient bg-bento-mint/40 py-16 md:py-24">
          <div className="sessions-ambient-inner mx-auto max-w-7xl px-4">
          <p className="text-center text-xs font-medium uppercase tracking-luxury text-muted-foreground">Sessions</p>
          <h2 className="mt-2 text-center font-display text-2xl font-semibold tracking-display text-foreground md:text-3xl">
            Book your session
          </h2>
          <p className="mx-auto mt-2 max-w-lg text-center text-sm text-muted-foreground">Audio &amp; video readings and counselling</p>
          <Tabs defaultValue="top" className="mt-12">
            <TabsList className="mx-auto flex h-auto w-full max-w-md flex-wrap justify-center gap-1 rounded-full border border-border/60 bg-card/95 p-1 shadow-elevation-rest">
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
            <TabsContent value="top" className="mt-8">
              <div className="grid gap-6 sm:grid-cols-2 lg:grid-cols-3">
                {topServices.map((s) => (
                  <SessionServiceCard key={s.id} s={s} />
                ))}
              </div>
            </TabsContent>
            <TabsContent value="audio" className="mt-8">
              <div className="grid gap-6 sm:grid-cols-2 lg:grid-cols-3">
                {audio.map((s) => (
                  <SessionServiceCard key={s.id} s={s} />
                ))}
              </div>
            </TabsContent>
            <TabsContent value="video" className="mt-8">
              <div className="grid gap-6 sm:grid-cols-2 lg:grid-cols-3">
                {video.map((s) => (
                  <SessionServiceCard key={s.id} s={s} />
                ))}
              </div>
            </TabsContent>
          </Tabs>
          </div>
        </section>
      </MotionSection>

      <MotionSection>
        <section className="mx-auto max-w-7xl px-4 py-16 md:py-24">
        <div className="flex items-end justify-between gap-4">
          <div>
            <p className="text-xs font-medium uppercase tracking-luxury text-muted-foreground">Featured</p>
            <h2 className="mt-2 font-display text-2xl font-semibold tracking-display text-foreground md:text-3xl">
              Shop healing crystals
            </h2>
            <p className="mt-1 text-sm text-muted-foreground">Same favorites as the shop grid</p>
          </div>
          <Button variant="outline" asChild className="rounded-full border-border/80">
            <Link href="/shop">See all</Link>
          </Button>
        </div>
        <StaggerGrid className="mt-10 grid gap-5 sm:grid-cols-2 md:grid-cols-4">
          {hotProducts.slice(0, 4).map((p) => (
            <ProductTile
              key={`dup-${p.id}`}
              product={p}
              unitPricePaise={effectiveUnitPrice({ price: p.price, salePrice: p.salePrice })}
            />
          ))}
        </StaggerGrid>
        </section>
      </MotionSection>

      <InstagramFeedSection />

      <MotionSection>
        <section className="mx-auto max-w-7xl px-4 py-16 md:py-24">
          <TestimonialsCarousel testimonials={testimonials} />
        </section>
      </MotionSection>

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

