"use client";

import { useSession } from "next-auth/react";
import { useState } from "react";
import { Button } from "@/components/ui/button";
import { Heart } from "lucide-react";

export function WishlistButton({ productId }: { productId: string }) {
  const { status } = useSession();
  const [done, setDone] = useState(false);

  if (status !== "authenticated") return null;

  return (
    <Button
      type="button"
      variant="outline"
      size="sm"
      className="gap-2"
      disabled={done}
      onClick={() =>
        void fetch("/api/wishlist", {
          method: "POST",
          headers: { "Content-Type": "application/json" },
          credentials: "include",
          body: JSON.stringify({ productId }),
        }).then(() => setDone(true))
      }
    >
      <Heart className="h-4 w-4" />
      {done ? "Saved" : "Wishlist"}
    </Button>
  );
}
