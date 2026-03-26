import Link from "next/link";
import { ShoppingBag, Heart, User, Store } from "lucide-react";

const items = [
  { href: "/shop", label: "Shop", Icon: Store },
  { href: "/wishlist", label: "Wishlist", Icon: Heart },
  { href: "/cart", label: "Cart", Icon: ShoppingBag },
  { href: "/account", label: "Account", Icon: User },
];

export function MobileNav() {
  return (
    <nav className="fixed bottom-0 left-0 right-0 z-40 flex border-t bg-background/95 py-2 md:hidden">
      {items.map(({ href, label, Icon }) => (
        <Link key={href} href={href} className="flex flex-1 flex-col items-center gap-0.5 text-[10px] text-muted-foreground">
          <Icon className="h-5 w-5" />
          {label}
        </Link>
      ))}
    </nav>
  );
}
