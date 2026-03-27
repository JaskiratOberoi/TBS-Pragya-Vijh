import { prisma } from "@/lib/prisma";
import { Tabs, TabsContent, TabsList, TabsTrigger } from "@/components/ui/tabs";
import { Card, CardContent } from "@/components/ui/card";
import { Badge } from "@/components/ui/badge";
import { formatINR } from "@/lib/utils";
import { BookNowButton } from "@/components/services/BookNowButton";

export default async function ServicesPage() {
  const services = await prisma.service.findMany({ where: { isActive: true }, orderBy: { name: "asc" } });
  const audio = services.filter((s) => s.type === "AUDIO");
  const video = services.filter((s) => s.type === "VIDEO");
  const topFiltered = services.filter((s) => s.name.includes("Tarot") || s.name.includes("All-in"));
  const top = topFiltered.length > 0 ? topFiltered : services.slice(0, 6);

  return (
    <div className="mx-auto max-w-6xl px-4 py-12">
      <h1 className="text-center font-serif text-4xl font-bold text-primary">Our services</h1>
      <p className="mx-auto mt-4 max-w-2xl text-center text-muted-foreground">
        Choose audio or video sessions — tarot, kundali, therapy, and full astrology readings.
      </p>
      <Tabs defaultValue="top" className="mt-10">
        <TabsList className="mx-auto flex w-full max-w-lg">
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
        <TabsContent value="top" className="mt-8 grid gap-4 sm:grid-cols-2 lg:grid-cols-3">
          {top.map((s) => (
            <ServiceCard key={s.id} s={s} />
          ))}
        </TabsContent>
        <TabsContent value="audio" className="mt-8 grid gap-4 sm:grid-cols-2 lg:grid-cols-3">
          {audio.map((s) => (
            <ServiceCard key={s.id} s={s} />
          ))}
        </TabsContent>
        <TabsContent value="video" className="mt-8 grid gap-4 sm:grid-cols-2 lg:grid-cols-3">
          {video.map((s) => (
            <ServiceCard key={s.id} s={s} />
          ))}
        </TabsContent>
      </Tabs>
    </div>
  );
}

function ServiceCard({ s }: { s: { id: string; name: string; type: string; price: number; durationMinutes: number } }) {
  return (
    <Card>
      <CardContent className="space-y-3 p-5">
        <div className="flex items-center justify-between gap-2">
          <h2 className="text-lg font-semibold">{s.name}</h2>
          <Badge variant="secondary">{s.type}</Badge>
        </div>
        <p className="text-sm text-muted-foreground">{s.durationMinutes} min</p>
        <p className="text-xl font-bold text-primary">{formatINR(s.price)}</p>
        <BookNowButton serviceId={s.id} />
      </CardContent>
    </Card>
  );
}
