"use client";

import { useEffect, useRef, useState } from "react";

const kpis = [
  { label: "Happy clients", value: 800, suffix: "+" },
  { label: "Years experience", value: 3, suffix: "+" },
  { label: "Consultations", value: 4500, suffix: "+" },
  { label: "Positive feedback", value: 10, suffix: "%" },
];

function useCountUp(target: number, start: boolean) {
  const [n, setN] = useState(0);
  useEffect(() => {
    if (!start) return;
    const dur = 1200;
    const t0 = performance.now();
    const tick = (now: number) => {
      const p = Math.min(1, (now - t0) / dur);
      setN(Math.round(target * p));
      if (p < 1) requestAnimationFrame(tick);
    };
    requestAnimationFrame(tick);
  }, [target, start]);
  return n;
}

export function KpiCounters() {
  const ref = useRef<HTMLDivElement>(null);
  const [vis, setVis] = useState(false);
  useEffect(() => {
    const el = ref.current;
    if (!el) return;
    const io = new IntersectionObserver(([e]) => setVis(e.isIntersecting), { threshold: 0.2 });
    io.observe(el);
    return () => io.disconnect();
  }, []);

  return (
    <section
      ref={ref}
      className="section-inverse-aurora relative border-y border-metal/15 bg-inverse py-16 md:py-24"
    >
      <div className="relative z-[1] mx-auto grid max-w-7xl gap-10 px-4 sm:grid-cols-2 lg:grid-cols-4">
        {kpis.map((k) => (
          <Kpi key={k.label} {...k} start={vis} />
        ))}
      </div>
    </section>
  );
}

function Kpi({ label, value, suffix, start }: { label: string; value: number; suffix: string; start: boolean }) {
  const n = useCountUp(value, start);
  return (
    <div className="text-center">
      <p className="font-display text-4xl font-semibold tabular-nums text-metal md:text-5xl">
        {n}
        {suffix}
      </p>
      <p className="mt-2 text-xs font-medium uppercase tracking-luxury text-inverse-muted">{label}</p>
    </div>
  );
}
