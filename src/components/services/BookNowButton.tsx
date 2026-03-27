"use client";

import type { ComponentProps } from "react";
import { useTransition } from "react";
import { useRouter } from "next/navigation";
import { Loader2 } from "lucide-react";
import { Button } from "@/components/ui/button";
import { cn } from "@/lib/utils";

type Props = {
  serviceId: string;
  className?: string;
  size?: ComponentProps<typeof Button>["size"];
  variant?: ComponentProps<typeof Button>["variant"];
};

export function BookNowButton({ serviceId, className, size = "default", variant: variantProp }: Props) {
  const router = useRouter();
  const [pending, startTransition] = useTransition();
  return (
    <Button
      type="button"
      className={cn("w-full", className)}
      size={size}
      variant={variantProp}
      disabled={pending}
      onClick={() => startTransition(() => router.push(`/book/${serviceId}`))}
    >
      {pending ? (
        <span className="inline-flex items-center justify-center gap-2">
          <Loader2 className="h-5 w-5 shrink-0 animate-spin text-current" aria-hidden />
          <span className="sr-only">Opening booking</span>
        </span>
      ) : (
        "Book now"
      )}
    </Button>
  );
}
