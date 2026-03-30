"use client";

import { motion, useReducedMotion } from "framer-motion";
import { cn } from "@/lib/utils";

type Props = {
  children: React.ReactNode;
  className?: string;
  /** Slightly stronger motion for hero-adjacent blocks */
  emphasis?: boolean;
};

/**
 * Scroll-triggered fade / lift. Wrapper is a div so you can nest real <section> inside.
 */
export function MotionSection({ children, className, emphasis }: Props) {
  const reduce = useReducedMotion();
  const y = emphasis ? 20 : 14;
  return (
    <motion.div
      className={cn(className)}
      initial={reduce ? { opacity: 1, y: 0 } : { opacity: 0, y }}
      whileInView={{ opacity: 1, y: 0 }}
      viewport={{ once: true, margin: "-60px", amount: 0.15 }}
      transition={{
        duration: reduce ? 0 : emphasis ? 0.65 : 0.5,
        ease: [0.25, 0.1, 0.25, 1],
      }}
    >
      {children}
    </motion.div>
  );
}
