"use client";

import Link from "next/link";
import { usePathname } from "next/navigation";
import { ShoppingBag, Heart, User, Store } from "lucide-react";
import { cn } from "@/lib/utils";

const items = [
  { href: "/shop", label: "Shop", Icon: Store },
  { href: "/wishlist", label: "Wishlist", Icon: Heart },
  { href: "/cart", label: "Cart", Icon: ShoppingBag },
  { href: "/account", label: "Account", Icon: User },
];

function routeActive(pathname: string, href: string) {
  if (href === "/shop") return pathname === "/shop" || pathname.startsWith("/shop/");
  return pathname === href || pathname.startsWith(`${href}/`);
}

export function MobileNav() {
  const pathname = usePathname();

  return (
    <nav
      className="fixed bottom-0 left-0 right-0 z-40 flex border-t border-border/50 bg-inverse/95 py-2 shadow-elevation-float backdrop-blur-lg supports-[backdrop-filter]:bg-inverse/85 md:hidden"
      style={{ paddingBottom: "max(0.5rem, env(safe-area-inset-bottom))" }}
    >
      {items.map(({ href, label, Icon }) => {
        const active = routeActive(pathname, href);
        return (
          <Link
            key={href}
            href={href}
            className={cn(
              "flex flex-1 flex-col items-center gap-0.5 py-1 text-[10px] font-medium transition-colors",
              active ? "text-metal" : "text-inverse-muted"
            )}
          >
            <Icon className={cn("h-5 w-5", active ? "stroke-[2.25px]" : "stroke-[1.5px]")} />
            {label}
          </Link>
        );
      })}
    </nav>
  );
}
