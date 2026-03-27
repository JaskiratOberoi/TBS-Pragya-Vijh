"use client";

import { useCallback, useEffect, useState } from "react";
import { AnimatePresence, motion, useReducedMotion } from "framer-motion";
import { ChevronLeft, ChevronRight } from "lucide-react";
import { cn } from "@/lib/utils";

type T = { id: string; name: string; text: string };

const AUTO_MS = 6000;

export function TestimonialsCarousel({ testimonials }: { testimonials: T[] }) {
  const [i, setI] = useState(0);
  const [dir, setDir] = useState<1 | -1>(1);
  const [paused, setPaused] = useState(false);
  const [docHidden, setDocHidden] = useState(false);
  const reduce = useReducedMotion();

  const len = testimonials.length;
  const go = useCallback((next: number, direction: 1 | -1) => {
    if (len === 0) return;
    setDir(direction);
    setI(((next % len) + len) % len);
  }, [len]);

  useEffect(() => {
    setDocHidden(typeof document !== "undefined" && document.hidden);
    const onVis = () => setDocHidden(document.hidden);
    document.addEventListener("visibilitychange", onVis);
    return () => document.removeEventListener("visibilitychange", onVis);
  }, []);

  useEffect(() => {
    if (len === 0 || paused || docHidden) return;
    const t = setInterval(() => go(i + 1, 1), AUTO_MS);
    return () => clearInterval(t);
  }, [len, paused, docHidden, i, go]);

  const next = () => go(i + 1, 1);
  const prev = () => go(i - 1, -1);

  if (len === 0) return null;
  const t = testimonials[i % len];

  return (
    <div
      className="mx-auto max-w-3xl"
      onMouseEnter={() => setPaused(true)}
      onMouseLeave={() => setPaused(false)}
    >
      <h2 className="text-center font-serif text-2xl font-semibold text-primary md:text-3xl">What clients say</h2>
      <div className="relative mt-8">
        <motion.button
          type="button"
          aria-label="Previous testimonial"
          className="absolute left-0 top-1/2 z-20 flex h-11 w-11 -translate-x-1 -translate-y-1/2 items-center justify-center rounded-full border border-border/60 bg-card text-foreground shadow-bento-sm md:-translate-x-4 md:h-12 md:w-12"
          onClick={() => prev()}
          whileHover={{ scale: 1.06 }}
          whileTap={{ scale: 0.94 }}
        >
          <ChevronLeft className="h-5 w-5" />
        </motion.button>
        <motion.button
          type="button"
          aria-label="Next testimonial"
          className="absolute right-0 top-1/2 z-20 flex h-11 w-11 -translate-y-1/2 translate-x-1 items-center justify-center rounded-full border border-border/60 bg-card text-foreground shadow-bento-sm md:h-12 md:w-12 md:translate-x-4"
          onClick={() => next()}
          whileHover={{ scale: 1.06 }}
          whileTap={{ scale: 0.94 }}
        >
          <ChevronRight className="h-5 w-5" />
        </motion.button>

        <div className="overflow-hidden rounded-3xl border border-border/50 bg-card px-6 py-10 shadow-bento md:px-10 md:py-12">
          <AnimatePresence initial={false} mode="wait">
            <motion.div
              key={t.id}
              variants={{
                enter: reduce
                  ? { opacity: 0 }
                  : {
                      x: dir * 28,
                      opacity: 0,
                    },
                center: { x: 0, opacity: 1 },
                exit: reduce
                  ? { opacity: 0 }
                  : {
                      x: dir * -20,
                      opacity: 0,
                    },
              }}
              initial="enter"
              animate="center"
              exit="exit"
              transition={{ duration: reduce ? 0.15 : 0.32, ease: [0.25, 0.1, 0.25, 1] }}
            >
              <p className="text-center text-lg leading-relaxed text-muted-foreground md:text-xl">&ldquo;{t.text}&rdquo;</p>
              <p className="mt-6 text-center font-medium text-primary">— {t.name}</p>
            </motion.div>
          </AnimatePresence>
        </div>

        <div className="mt-6 flex justify-center gap-2">
          {testimonials.map((item, idx) => (
            <button
              key={item.id}
              type="button"
              aria-label={`Go to testimonial ${idx + 1}`}
              aria-current={idx === i ? "true" : undefined}
              className={cn(
                "h-2.5 rounded-full transition-all focus-visible:outline-none focus-visible:ring-2 focus-visible:ring-ring focus-visible:ring-offset-2",
                idx === i ? "w-8 bg-primary" : "w-2.5 bg-muted-foreground/35 hover:bg-muted-foreground/55"
              )}
              onClick={() => {
                const d = idx > i ? 1 : -1;
                go(idx, d);
              }}
            />
          ))}
        </div>
      </div>
    </div>
  );
}
