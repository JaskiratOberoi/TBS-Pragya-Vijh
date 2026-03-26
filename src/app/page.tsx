import Link from "next/link";
import Image from "next/image";
import { prisma } from "@/lib/prisma";
import { Button } from "@/components/ui/button";
import { Card, CardContent } from "@/components/ui/card";
import { Tabs, TabsContent, TabsList, TabsTrigger } from "@/components/ui/tabs";
import { Badge } from "@/components/ui/badge";
import { formatINR } from "@/lib/utils";
import { effectiveUnitPrice } from "@/lib/promo-engine";
import { TestimonialsCarousel } from "@/components/home/TestimonialsCarousel";
import { KpiCounters } from "@/components/home/KpiCounters";

export const revalidate = 60;

export default async function HomePage() {
  const [hotProducts, services, testimonials] = await Promise.all([
    prisma.product.findMany({
      where: { isActive: true },
      take: 4,
      orderBy: { createdAt: "desc" },
      include: { category: true },
    }),
    prisma.service.findMany({ where: { isActive: true }, orderBy: { price: "asc" } }),
    prisma.testimonial.findMany({ where: { isActive: true }, orderBy: { sortOrder: "asc" } }),
  ]);

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
      <section className="relative overflow-hidden bg-gradient-to-b from-secondary/60 to-background">
        <div className="mx-auto grid max-w-7xl items-center gap-10 px-4 py-16 md:grid-cols-2">
          <div>
            <h1 className="font-serif text-4xl font-bold tracking-tight text-primary md:text-5xl">
              Heal, manifest & align with Master Pragya Vijh
            </h1>
            <p className="mt-4 text-lg text-muted-foreground">
              Premium healing crystals, bracelets, pyramids — and personal audio & video sessions for clarity and
              growth.
            </p>
            <div className="mt-8 flex flex-wrap gap-3">
              <Button asChild size="lg">
                <Link href="/services">Book now</Link>
              </Button>
              <Button asChild size="lg" variant="outline">
                <Link href="/about">Read more</Link>
              </Button>
            </div>
          </div>
          <div className="relative aspect-[4/5] max-h-[420px] justify-self-center overflow-hidden rounded-2xl border bg-muted shadow-xl">
            <Image
              src="/assets/products/placeholder.svg"
              alt="Master Pragya Vijh"
              fill
              className="object-cover"
              priority
            />
          </div>
        </div>
      </section>

      <section className="mx-auto max-w-7xl px-4 py-14">
        <h2 className="text-center font-serif text-2xl font-semibold text-primary">Hot sellers</h2>
        <div className="mt-8 grid gap-4 sm:grid-cols-2 lg:grid-cols-4">
          {hotProducts.map((p) => (
            <Card key={p.id} className="overflow-hidden">
              <Link href={`/shop/${p.slug}`}>
                <div className="relative aspect-square bg-muted">
                  <Image src={p.images[0] ?? "/assets/products/placeholder.svg"} alt={p.name} fill className="object-cover" />
                </div>
              </Link>
              <CardContent className="p-4">
                <p className="line-clamp-2 font-medium">{p.name}</p>
                <p className="mt-2 text-sm text-primary">{formatINR(effectiveUnitPrice(p))}</p>
              </CardContent>
            </Card>
          ))}
        </div>
      </section>

      <section className="bg-secondary/30 py-14">
        <div className="mx-auto max-w-7xl px-4">
          <h2 className="text-center font-serif text-2xl font-semibold text-primary">Book your session</h2>
          <Tabs defaultValue="top" className="mt-8">
            <TabsList className="mx-auto flex w-full max-w-md">
              <TabsTrigger value="top" className="flex-1">
                Top
              </TabsTrigger>
              <TabsTrigger value="audio" className="flex-1">
                Audio
              </TabsTrigger>
              <TabsTrigger value="video" className="flex-1">
                Video
              </TabsTrigger>
            </TabsList>
            <TabsContent value="top" className="mt-6 grid gap-4 sm:grid-cols-2 lg:grid-cols-3">
              {topServices.map((s) => (
                <ServiceCard key={s.id} s={s} />
              ))}
            </TabsContent>
            <TabsContent value="audio" className="mt-6 grid gap-4 sm:grid-cols-2 lg:grid-cols-3">
              {audio.map((s) => (
                <ServiceCard key={s.id} s={s} />
              ))}
            </TabsContent>
            <TabsContent value="video" className="mt-6 grid gap-4 sm:grid-cols-2 lg:grid-cols-3">
              {video.map((s) => (
                <ServiceCard key={s.id} s={s} />
              ))}
            </TabsContent>
          </Tabs>
        </div>
      </section>

      <section className="mx-auto max-w-7xl px-4 py-14">
        <div className="flex items-end justify-between gap-4">
          <h2 className="font-serif text-2xl font-semibold text-primary">Shop healing crystals</h2>
          <Button variant="outline" asChild>
            <Link href="/shop">See all</Link>
          </Button>
        </div>
        <div className="mt-8 grid gap-4 sm:grid-cols-2 md:grid-cols-4">
          {hotProducts.slice(0, 4).map((p) => (
            <Card key={p.id} className="overflow-hidden">
              <Link href={`/shop/${p.slug}`}>
                <div className="relative aspect-square bg-muted">
                  <Image src={p.images[0] ?? "/assets/products/placeholder.svg"} alt={p.name} fill className="object-cover" />
                </div>
              </Link>
              <CardContent className="p-3">
                <p className="line-clamp-2 text-sm font-medium">{p.name}</p>
                <p className="text-sm text-primary">{formatINR(effectiveUnitPrice(p))}</p>
              </CardContent>
            </Card>
          ))}
        </div>
      </section>

      <section className="bg-muted/40 py-14">
        <div className="mx-auto max-w-7xl px-4">
          <h2 className="text-center font-serif text-2xl font-semibold text-primary">On Instagram</h2>
          <div className="mt-8 grid grid-cols-3 gap-2 sm:grid-cols-4 md:grid-cols-6">
            {Array.from({ length: 12 }).map((_, i) => (
              <div key={i} className="relative aspect-square overflow-hidden rounded-md bg-muted">
                <Image src="/assets/products/placeholder.svg" alt="" fill className="object-cover opacity-70" />
              </div>
            ))}
          </div>
          <p className="mt-4 text-center text-sm text-muted-foreground">@pragya.vijh_astrotalks — follow for daily guidance</p>
        </div>
      </section>

      <section className="mx-auto max-w-7xl px-4 py-14">
        <TestimonialsCarousel testimonials={testimonials} />
      </section>

      <KpiCounters />

      <section className="pb-16 text-center">
        <Button asChild variant="secondary" size="lg">
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
    <Card>
      <CardContent className="space-y-3 p-5">
        <div className="flex items-center justify-between gap-2">
          <h3 className="font-medium">{s.name}</h3>
          <Badge variant="secondary">{s.type}</Badge>
        </div>
        <p className="text-sm text-muted-foreground">{s.durationMinutes} min</p>
        <p className="text-lg font-semibold text-primary">{formatINR(s.price)}</p>
        <Button className="w-full" asChild>
          <Link href={`/book/${s.id}`}>Book now</Link>
        </Button>
      </CardContent>
    </Card>
  );
}
