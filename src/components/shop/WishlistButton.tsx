"use client";

import { useSession } from "next-auth/react";
import { useState } from "react";
import { Button } from "@/components/ui/button";
import { Heart } from "lucide-react";
import { cn } from "@/lib/utils";

type Props = {
  productId: string;
  /** Default row button; `icon` = floating heart for product tiles */
  variant?: "default" | "icon";
  className?: string;
};

export function WishlistButton({ productId, variant = "default", className }: Props) {
  const { status } = useSession();
  const [done, setDone] = useState(false);

  if (status !== "authenticated") return null;

  return (
    <Button
      type="button"
      variant={variant === "icon" ? "secondary" : "outline"}
      size={variant === "icon" ? "icon" : "sm"}
      className={cn(
        variant === "icon" &&
          "h-10 w-10 shrink-0 rounded-full border-0 bg-white/95 text-foreground shadow-bento-sm backdrop-blur-sm hover:bg-white",
        className
      )}
      disabled={done}
      aria-label={done ? "Saved to wishlist" : "Add to wishlist"}
      onClick={() =>
        void fetch("/api/wishlist", {
          method: "POST",
          headers: { "Content-Type": "application/json" },
          credentials: "include",
          body: JSON.stringify({ productId }),
        }).then(() => setDone(true))
      }
    >
      <Heart className={cn("h-4 w-4", done && "fill-primary text-primary")} />
      {variant === "default" ? (done ? "Saved" : "Wishlist") : null}
    </Button>
  );
}
