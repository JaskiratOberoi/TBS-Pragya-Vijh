import Link from "next/link";
import { strapiFetchPublicList, normalizeDoc } from "@/lib/strapi";
import { Tabs, TabsContent, TabsList, TabsTrigger } from "@/components/ui/tabs";
import { Button } from "@/components/ui/button";
import { SessionServiceCard } from "@/components/services/SessionServiceCard";

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
        <Tabs defaultValue="top" className="w-full">
          <TabsList className="mx-auto flex h-auto w-full max-w-lg flex-wrap gap-1 rounded-full border border-border/50 bg-muted/40 p-1.5 shadow-elevation-rest backdrop-blur-sm">
            <TabsTrigger
              value="top"
              className="flex-1 rounded-full px-4 py-2.5 text-sm transition-all data-[state=active]:bg-primary data-[state=active]:text-primary-foreground data-[state=active]:shadow-md"
            >
              Top
            </TabsTrigger>
            <TabsTrigger
              value="audio"
              className="flex-1 rounded-full px-4 py-2.5 text-sm transition-all data-[state=active]:bg-primary data-[state=active]:text-primary-foreground data-[state=active]:shadow-md"
            >
              Audio
            </TabsTrigger>
            <TabsTrigger
              value="video"
              className="flex-1 rounded-full px-4 py-2.5 text-sm transition-all data-[state=active]:bg-primary data-[state=active]:text-primary-foreground data-[state=active]:shadow-md"
            >
              Video
            </TabsTrigger>
          </TabsList>
          <TabsContent value="top" className="mt-10">
            <div className="grid gap-6 sm:grid-cols-2 lg:grid-cols-3">
              {top.map((s) => (
                <SessionServiceCard key={s.id} s={s} />
              ))}
            </div>
          </TabsContent>
          <TabsContent value="audio" className="mt-10">
            <div className="grid gap-6 sm:grid-cols-2 lg:grid-cols-3">
              {audio.map((s) => (
                <SessionServiceCard key={s.id} s={s} />
              ))}
            </div>
          </TabsContent>
          <TabsContent value="video" className="mt-10">
            <div className="grid gap-6 sm:grid-cols-2 lg:grid-cols-3">
              {video.map((s) => (
                <SessionServiceCard key={s.id} s={s} />
              ))}
            </div>
          </TabsContent>
        </Tabs>
      </div>
    </div>
  );
}
