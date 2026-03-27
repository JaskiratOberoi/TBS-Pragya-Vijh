"use client";

import { Children, isValidElement } from "react";
import { motion } from "framer-motion";
import { cn } from "@/lib/utils";

const container = {
  hidden: { opacity: 0 },
  show: {
    opacity: 1,
    transition: { staggerChildren: 0.07, delayChildren: 0.04 },
  },
};

const item = {
  hidden: { opacity: 0, y: 12 },
  show: { opacity: 1, y: 0, transition: { duration: 0.35, ease: [0.25, 0.1, 0.25, 1] } },
};

type Props = {
  children: React.ReactNode;
  className?: string;
};

export function StaggerGrid({ children, className }: Props) {
  return (
    <motion.div className={cn(className)} variants={container} initial="hidden" animate="show">
      {Children.map(children, (child, i) => (
        <motion.div
          key={isValidElement(child) && child.key != null ? String(child.key) : `stagger-${i}`}
          variants={item}
          className="contents"
        >
          {child}
        </motion.div>
      ))}
    </motion.div>
  );
}
