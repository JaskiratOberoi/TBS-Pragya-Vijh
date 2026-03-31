"use client";

import { useState } from "react";
import { AnimatePresence, motion, useReducedMotion } from "framer-motion";
import { Tabs, TabsList, TabsTrigger } from "@/components/ui/tabs";
import { SessionServiceCard, type SessionServiceModel } from "@/components/services/SessionServiceCard";
import { cn } from "@/lib/utils";

const TAB_IDS = ["top", "audio", "video"] as const;
type TabId = (typeof TAB_IDS)[number];

const LABELS: Record<TabId, string> = {
  top: "Top",
  audio: "Audio",
  video: "Video",
};

type Props = {
  top: SessionServiceModel[];
  audio: SessionServiceModel[];
  video: SessionServiceModel[];
  className?: string;
};

export function SessionCategoryTabs({ top, audio, video, className }: Props) {
  const [tab, setTab] = useState<TabId>("top");
  const reduce = useReducedMotion();

  const list = tab === "top" ? top : tab === "audio" ? audio : video;

  const panelVariants = reduce
    ? { initial: {}, animate: {}, exit: {} }
    : {
        initial: { opacity: 0, y: 16 },
        animate: { opacity: 1, y: 0 },
        exit: { opacity: 0, y: -12 },
      };

  return (
    <Tabs value={tab} onValueChange={(v) => setTab(v as TabId)} className={cn("w-full", className)}>
      <TabsList className="mx-auto flex h-auto w-full max-w-lg flex-wrap gap-1 rounded-full border border-border/50 bg-muted/40 p-1.5 shadow-elevation-rest backdrop-blur-sm">
        {TAB_IDS.map((id) => (
          <TabsTrigger
            key={id}
            value={id}
            id={`services-tab-${id}`}
            className={cn(
              "relative z-10 flex-1 rounded-full px-4 py-2.5 text-sm font-medium transition-colors",
              "focus-visible:outline-none focus-visible:ring-2 focus-visible:ring-ring focus-visible:ring-offset-2",
              "data-[state=active]:bg-transparent data-[state=active]:shadow-none",
              "data-[state=active]:text-primary-foreground data-[state=inactive]:text-muted-foreground",
              "data-[state=inactive]:hover:text-foreground/80"
            )}
          >
            {tab === id && (
              <motion.span
                layoutId="services-category-pill"
                className="absolute inset-0 -z-10 rounded-full bg-primary shadow-md ring-1 ring-metal/20"
                transition={{ type: "spring", stiffness: 400, damping: 32 }}
                aria-hidden
              />
            )}
            <span className="relative">{LABELS[id]}</span>
          </TabsTrigger>
        ))}
      </TabsList>

      <AnimatePresence mode="wait" initial={false}>
        <motion.div
          key={tab}
          role="tabpanel"
          id={`services-panel-${tab}`}
          aria-labelledby={`services-tab-${tab}`}
          initial={panelVariants.initial}
          animate={panelVariants.animate}
          exit={panelVariants.exit}
          transition={{ duration: reduce ? 0 : 0.28, ease: [0.25, 0.1, 0.25, 1] }}
          className="mt-10"
        >
          {list.length > 0 ? (
            <div className="grid gap-6 sm:grid-cols-2 lg:grid-cols-3">
              {list.map((s) => (
                <SessionServiceCard key={s.id} s={s} />
              ))}
            </div>
          ) : (
            <p className="rounded-2xl border border-dashed border-border/60 bg-muted/20 py-12 text-center text-sm text-muted-foreground">
              No sessions in this category yet.
            </p>
          )}
        </motion.div>
      </AnimatePresence>
    </Tabs>
  );
}
