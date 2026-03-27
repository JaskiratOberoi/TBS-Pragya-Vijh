import Link from "next/link";
import Image from "next/image";
import { Button } from "@/components/ui/button";
import { strapiFetch, normalizeDoc } from "@/lib/strapi";
import { TestimonialsCarousel } from "@/components/home/TestimonialsCarousel";

export default async function AboutPage() {
  const j = await strapiFetch<{ data?: unknown[] }>(
    `/api/testimonials?filters[isActive][$eq]=true&sort[0]=sortOrder:asc&pagination[pageSize]=100`,
    { next: { revalidate: 60 } }
  );
  const testimonials = (j.data ?? []).map((x) => {
    const t = normalizeDoc(x);
    return { id: String(t.id), name: String(t.name), text: String(t.text) };
  });
  return (
    <div className="mx-auto max-w-3xl px-4 py-12">
      <h1 className="font-serif text-4xl font-bold text-primary">About the Master</h1>
      <div className="relative mt-8 aspect-[4/3] max-h-80 overflow-hidden rounded-xl bg-muted">
        <Image src="/assets/products/placeholder.svg" alt="Master Pragya Vijh" fill className="object-cover" />
      </div>
      <ul className="mt-8 list-inside list-disc space-y-2 text-muted-foreground">
        <li>Experienced in tarot, astrology, therapy & counselling</li>
        <li>Thousands of consultations with compassionate guidance</li>
        <li>Holistic approach combining crystals, rituals, and practical advice</li>
        <li>Based in Delhi — serving clients across India and globally online</li>
      </ul>
      <Button className="mt-8" asChild>
        <Link href="/services">Book a session</Link>
      </Button>
      <div className="mt-16">
        <TestimonialsCarousel testimonials={testimonials} />
      </div>
    </div>
  );
}
