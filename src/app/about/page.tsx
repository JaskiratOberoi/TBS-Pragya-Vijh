import Link from "next/link";
import Image from "next/image";
import { Button } from "@/components/ui/button";
import { strapiFetchPublicList, normalizeDoc } from "@/lib/strapi";
import { TestimonialsCarousel } from "@/components/home/TestimonialsCarousel";

export default async function AboutPage() {
  const j = await strapiFetchPublicList<{ data?: unknown[] }>(
    `/api/testimonials?filters[isActive][$eq]=true&sort[0]=sortOrder:asc&pagination[pageSize]=100`,
    { next: { revalidate: 60 } }
  );
  const testimonials = (j.data ?? []).map((x) => {
    const t = normalizeDoc(x);
    return { id: String(t.id), name: String(t.name), text: String(t.text) };
  });
  return (
    <div>
      <section className="border-b border-metal/15 bg-inverse py-16 text-inverse-foreground md:py-24">
        <div className="mx-auto max-w-3xl px-4 text-center">
          <p className="text-xs font-medium uppercase tracking-luxury text-metal">The master</p>
          <h1 className="mt-3 font-display text-4xl font-semibold tracking-display md:text-5xl">About the Master</h1>
          <p className="mx-auto mt-5 max-w-xl text-sm leading-relaxed text-inverse-muted">
            Tarot, astrology, therapy, and holistic guidance — rooted in compassion and experience.
          </p>
        </div>
      </section>

      <div className="mx-auto max-w-3xl px-4 py-16 md:py-24">
        <div className="relative aspect-[4/3] max-h-96 overflow-hidden rounded-3xl border border-border/50 bg-muted shadow-elevation-rest">
          <Image src="/assets/products/placeholder.svg" alt="Master Pragya Vijh" fill className="object-cover" />
        </div>
        <ul className="mt-10 list-inside list-disc space-y-3 text-muted-foreground">
          <li>Experienced in tarot, astrology, therapy & counselling</li>
          <li>Thousands of consultations with compassionate guidance</li>
          <li>Holistic approach combining crystals, rituals, and practical advice</li>
          <li>Based in Delhi — serving clients across India and globally online</li>
        </ul>
        <Button className="mt-10 rounded-full px-8" asChild>
          <Link href="/services">Book a session</Link>
        </Button>
        <div className="mt-20 border-t border-border/60 pt-16">
          <p className="text-center text-xs font-medium uppercase tracking-luxury text-muted-foreground">Voices</p>
          <h2 className="mt-2 text-center font-display text-2xl font-semibold tracking-display">What clients say</h2>
          <div className="mt-10">
            <TestimonialsCarousel testimonials={testimonials} />
          </div>
        </div>
      </div>
    </div>
  );
}
