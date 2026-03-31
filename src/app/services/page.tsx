import Link from "next/link";
import { strapiFetchPublicList, normalizeDoc } from "@/lib/strapi";
import { Button } from "@/components/ui/button";
import { SessionCategoryTabs } from "@/components/services/SessionCategoryTabs";

export default async function ServicesPage() {
  const j = await strapiFetchPublicList<{ data?: unknown[] }>(
    `/api/services?filters[isActive][$eq]=true&sort[0]=name:asc&pagination[pageSize]=100`,
    { next: { revalidate: 60 } }
  );
  const services = (j.data ?? []).map((x) => normalizeDoc(x)) as Array<{
    id: string;
    name: string;
    type: string;
    price: number;
    durationMinutes: number;
  }>;
  const audio = services.filter((s) => s.type === "AUDIO");
  const video = services.filter((s) => s.type === "VIDEO");
  const topFiltered = services.filter((s) => s.name.includes("Tarot") || s.name.includes("All-in"));
  const top = topFiltered.length > 0 ? topFiltered : services.slice(0, 6);

  return (
    <div>
      <section className="border-b border-metal/15 bg-inverse py-16 text-inverse-foreground md:py-24">
        <div className="mx-auto max-w-3xl px-4 text-center">
          <p className="text-xs font-medium uppercase tracking-luxury text-metal">Sessions</p>
          <h1 className="mt-3 font-display text-4xl font-semibold tracking-display md:text-5xl">Our services</h1>
          <p className="mx-auto mt-5 max-w-2xl text-sm leading-relaxed text-inverse-muted md:text-base">
            Choose audio or video sessions — tarot, kundali, therapy, and full astrology readings.
          </p>
          <Button asChild variant="secondary" className="mt-8 rounded-full border-0 bg-metal text-metal-foreground hover:bg-metal/90">
            <Link href="/contact">Questions? Contact us</Link>
          </Button>
        </div>
      </section>

      <div className="mx-auto max-w-6xl px-4 py-16 md:py-24">
        <SessionCategoryTabs top={top} audio={audio} video={video} />
      </div>
    </div>
  );
}
