"use client";

import { useEffect, useState } from "react";
import { Card, CardContent } from "@/components/ui/card";
import { Button } from "@/components/ui/button";
import { ChevronLeft, ChevronRight } from "lucide-react";

type T = { id: string; name: string; text: string };

export function TestimonialsCarousel({ testimonials }: { testimonials: T[] }) {
  const [i, setI] = useState(0);
  useEffect(() => {
    const t = setInterval(() => setI((x) => (x + 1) % Math.max(testimonials.length, 1)), 6000);
    return () => clearInterval(t);
  }, [testimonials.length]);

  if (testimonials.length === 0) return null;
  const t = testimonials[i % testimonials.length];

  return (
    <div>
      <h2 className="text-center font-serif text-2xl font-semibold text-primary">What clients say</h2>
      <Card className="relative mx-auto mt-8 max-w-3xl">
        <CardContent className="p-8">
          <p className="text-lg leading-relaxed text-muted-foreground">&ldquo;{t.text}&rdquo;</p>
          <p className="mt-4 font-medium text-primary">— {t.name}</p>
          <div className="mt-6 flex justify-center gap-2">
            <Button type="button" variant="outline" size="icon" onClick={() => setI((x) => (x - 1 + testimonials.length) % testimonials.length)}>
              <ChevronLeft className="h-4 w-4" />
            </Button>
            <Button type="button" variant="outline" size="icon" onClick={() => setI((x) => (x + 1) % testimonials.length)}>
              <ChevronRight className="h-4 w-4" />
            </Button>
          </div>
        </CardContent>
      </Card>
    </div>
  );
}
