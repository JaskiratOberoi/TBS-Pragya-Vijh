"use client";

import { motion, useReducedMotion } from "framer-motion";
import { Clock, Headphones, Sparkles, Video } from "lucide-react";
import { BookNowButton } from "@/components/services/BookNowButton";
import { formatINR } from "@/lib/utils";
import { cn } from "@/lib/utils";

export type SessionServiceModel = {
  id: string;
  name: string;
  type: string;
  price: number;
  durationMinutes: number;
};

type Props = {
  s: SessionServiceModel;
  className?: string;
};

export function SessionServiceCard({ s, className }: Props) {
  const reduce = useReducedMotion();
  const isVideo = s.type === "VIDEO";
  const isAudio = s.type === "AUDIO";

  const Icon = isVideo ? Video : isAudio ? Headphones : Sparkles;

  return (
    <motion.article
      className={cn(
        "group relative flex h-full flex-col overflow-hidden rounded-2xl border border-border/50 bg-gradient-to-b from-card via-card to-muted/25 shadow-elevation-rest backdrop-blur-[2px]",
        "transition-[border-color,box-shadow] duration-300 hover:border-metal/30 hover:shadow-elevation-hover",
        className
      )}
      initial={false}
      whileHover={
        reduce
          ? undefined
          : {
              y: -5,
              transition: { type: "spring", stiffness: 420, damping: 26 },
            }
      }
    >
      {/* Type accent rail */}
      <div
        className={cn(
          "h-[3px] w-full shrink-0 bg-gradient-to-r",
          isVideo && "from-primary via-primary/80 to-metal/50",
          isAudio && "from-bento-mint via-metal/60 to-primary/50",
          !isVideo && !isAudio && "from-muted-foreground/30 via-border to-muted-foreground/20"
        )}
        aria-hidden
      />

      {/* Hover wash */}
      <div
        className="pointer-events-none absolute -right-20 -top-24 h-48 w-48 rounded-full bg-gradient-to-br from-primary/[0.09] via-metal/[0.05] to-transparent opacity-0 blur-2xl transition-opacity duration-500 group-hover:opacity-100"
        aria-hidden
      />
      <div
        className="pointer-events-none absolute -bottom-16 -left-16 h-40 w-40 rounded-full bg-gradient-to-tr from-bento-mint/25 to-transparent opacity-0 transition-opacity duration-500 group-hover:opacity-100"
        aria-hidden
      />

      <div className="relative flex flex-1 flex-col p-5 sm:p-6">
        <div className="flex items-start justify-between gap-3">
          <div className="flex min-w-0 flex-1 gap-3">
            <span
              className={cn(
                "flex h-12 w-12 shrink-0 items-center justify-center rounded-2xl border border-border/60 bg-gradient-to-br from-elevated to-muted/40 text-primary shadow-sm",
                "transition-transform duration-300 ease-out group-hover:scale-[1.06] group-hover:shadow-md",
                isVideo && "from-primary/[0.08] to-primary/[0.02] text-primary",
                isAudio && "from-metal/15 to-metal/5 text-metal-muted"
              )}
            >
              <Icon className="h-5 w-5" strokeWidth={1.65} aria-hidden />
            </span>
            <div className="min-w-0 pt-0.5">
              <h3 className="font-display text-lg font-semibold leading-snug tracking-display text-foreground transition-colors duration-200 group-hover:text-primary sm:text-[1.05rem]">
                {s.name}
              </h3>
            </div>
          </div>
          <span
            className={cn(
              "shrink-0 rounded-full border px-2.5 py-1 text-[10px] font-semibold uppercase tracking-luxury",
              isVideo && "border-primary/20 bg-primary/[0.07] text-primary",
              isAudio && "border-metal/35 bg-metal/12 text-metal-muted",
              !isVideo && !isAudio && "border-border bg-muted/60 text-muted-foreground"
            )}
          >
            {s.type}
          </span>
        </div>

        <div className="mt-5">
          <span className="inline-flex items-center gap-2 rounded-full border border-border/40 bg-muted/30 px-3 py-1.5 text-xs font-medium text-muted-foreground backdrop-blur-sm">
            <Clock className="h-3.5 w-3.5 text-metal-muted/80" strokeWidth={2} aria-hidden />
            {s.durationMinutes} min
          </span>
        </div>

        <div className="mt-auto flex flex-col gap-4 pt-6">
          <div>
            <p className="text-[10px] font-semibold uppercase tracking-luxury text-muted-foreground">Session fee</p>
            <p className="mt-1 font-sans text-xl font-medium tabular-nums tracking-normal text-foreground antialiased sm:text-2xl sm:font-semibold">
              {formatINR(s.price)}
            </p>
          </div>
          <BookNowButton
            serviceId={s.id}
            size="lg"
            className="rounded-xl font-medium shadow-sm transition-all duration-300 hover:shadow-md focus-visible:ring-2 focus-visible:ring-metal/40"
          />
        </div>
      </div>
    </motion.article>
  );
}
