"use client";

import { useSession } from "next-auth/react";
import { useEffect } from "react";

export function CartMergeOnLogin() {
  const { status, data } = useSession();
  useEffect(() => {
    if (status !== "authenticated" || !data?.user || typeof window === "undefined") return;
    if (sessionStorage.getItem("bs_cart_merged")) return;
    sessionStorage.setItem("bs_cart_merged", "1");
    void fetch("/api/cart/merge", { method: "POST", credentials: "include" }).then(() => {
      window.dispatchEvent(new Event("cart:updated"));
    });
  }, [status, data?.user]);

  return null;
}
