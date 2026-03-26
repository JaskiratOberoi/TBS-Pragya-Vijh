"use client";

import Link from "next/link";
import Image from "next/image";
import { useEffect, useState, useCallback } from "react";
import { usePathname } from "next/navigation";
import { ShoppingBag, Heart, User, Search } from "lucide-react";
import { Button } from "@/components/ui/button";
import { Sheet, SheetContent, SheetHeader, SheetTitle, SheetTrigger } from "@/components/ui/sheet";
import { Input } from "@/components/ui/input";
import { formatINR } from "@/lib/utils";
import { signIn } from "next-auth/react";
import { useSession } from "next-auth/react";
import { cn } from "@/lib/utils";

const nav = [
  { href: "/", label: "Home" },
  { href: "/about", label: "About" },
  { href: "/services", label: "Book your session" },
  { href: "/shop", label: "Shop Crystals" },
  { href: "/contact", label: "Contact" },
];

type CartSummary = { totalPaise: number; subtotalPaise: number };

function navActive(pathname: string, href: string) {
  if (href === "/") return pathname === "/";
  return pathname === href || pathname.startsWith(`${href}/`);
}

export function SiteChrome() {
  const pathname = usePathname();
  const [cartOpen, setCartOpen] = useState(false);
  const [searchOpen, setSearchOpen] = useState(false);
  const [authOpen, setAuthOpen] = useState(false);
  const [cart, setCart] = useState<{ items: { id: string; quantity: number; product: { name: string; slug: string; salePrice: number | null; price: number } }[]; summary: CartSummary } | null>(null);
  const [q, setQ] = useState("");
  const [results, setResults] = useState<{ slug: string; name: string; images: string[] }[]>([]);
  const { data: session, status } = useSession();

  const refreshCart = useCallback(() => {
    void fetch("/api/cart", { credentials: "include" })
      .then((r) => r.json())
      .then(setCart)
      .catch(() => setCart({ items: [], summary: { totalPaise: 0, subtotalPaise: 0 } }));
  }, []);

  useEffect(() => {
    refreshCart();
    const onUpd = () => refreshCart();
    window.addEventListener("cart:updated", onUpd);
    return () => window.removeEventListener("cart:updated", onUpd);
  }, [refreshCart]);

  useEffect(() => {
    if (q.length < 2) {
      setResults([]);
      return;
    }
    const t = setTimeout(() => {
      void fetch(`/api/products/search?q=${encodeURIComponent(q)}`)
        .then((r) => r.json())
        .then((d) => setResults(d.products ?? []));
    }, 300);
    return () => clearTimeout(t);
  }, [q]);

  const itemCount = cart?.items?.reduce((s, i) => s + i.quantity, 0) ?? 0;

  return (
    <>
      <header className="sticky top-0 z-50 border-b border-border/60 bg-bento-canvas/90 shadow-bento-sm backdrop-blur-md">
        <div className="mx-auto flex max-w-7xl items-center justify-between gap-3 px-4 py-3 md:gap-6">
          <Link href="/" className="shrink-0 font-serif text-lg font-semibold text-primary md:text-xl">
            The Blissful Soul
          </Link>
          <nav className="hidden items-center gap-1 rounded-full border border-border/80 bg-card/80 p-1 shadow-sm md:flex">
            {nav.map((item) => {
              const active = navActive(pathname, item.href);
              return (
                <Link
                  key={item.href}
                  href={item.href}
                  className={cn(
                    "rounded-full px-3 py-2 text-sm font-medium transition-colors",
                    active ? "bg-primary text-primary-foreground shadow-sm" : "text-muted-foreground hover:bg-muted hover:text-foreground"
                  )}
                >
                  {item.label}
                </Link>
              );
            })}
          </nav>
          <div className="flex items-center gap-0.5">
            <Sheet open={searchOpen} onOpenChange={setSearchOpen}>
              <SheetTrigger asChild>
                <Button variant="ghost" size="icon" className="rounded-full" aria-label="Search">
                  <Search className="h-5 w-5" />
                </Button>
              </SheetTrigger>
              <SheetContent side="top" className="h-auto max-h-[80vh]">
                <SheetHeader>
                  <SheetTitle>Search products</SheetTitle>
                </SheetHeader>
                <Input
                  placeholder="Type to search…"
                  value={q}
                  onChange={(e) => setQ(e.target.value)}
                  className="mt-4 rounded-full"
                  autoFocus
                />
                <ul className="mt-4 max-h-64 space-y-2 overflow-auto">
                  {results.map((p) => (
                    <li key={p.slug}>
                      <Link
                        href={`/shop/${p.slug}`}
                        className="flex items-center gap-3 rounded-2xl p-2 hover:bg-muted"
                        onClick={() => setSearchOpen(false)}
                      >
                        {p.images[0] && (
                          <Image src={p.images[0]} alt="" width={40} height={40} className="rounded-lg object-cover" />
                        )}
                        <span className="text-sm">{p.name}</span>
                      </Link>
                    </li>
                  ))}
                </ul>
              </SheetContent>
            </Sheet>

            <Button variant="ghost" size="icon" className="rounded-full" asChild>
              <Link href="/wishlist" aria-label="Wishlist">
                <Heart className="h-5 w-5" />
              </Link>
            </Button>

            <Sheet open={cartOpen} onOpenChange={setCartOpen}>
              <SheetTrigger asChild>
                <Button variant="ghost" size="icon" className="relative rounded-full" aria-label="Cart">
                  <ShoppingBag className="h-5 w-5" />
                  {itemCount > 0 && (
                    <span className="absolute -right-0.5 -top-0.5 flex h-4 min-w-4 items-center justify-center rounded-full bg-primary px-1 text-[10px] text-primary-foreground">
                      {itemCount}
                    </span>
                  )}
                </Button>
              </SheetTrigger>
              <SheetContent className="rounded-l-3xl">
                <SheetHeader>
                  <SheetTitle>Your cart</SheetTitle>
                </SheetHeader>
                <div className="mt-6 space-y-4">
                  {(cart?.items?.length ?? 0) === 0 ? (
                    <p className="text-sm text-muted-foreground">Cart is empty.</p>
                  ) : (
                    cart!.items.map((line) => (
                      <div key={line.id} className="flex justify-between text-sm">
                        <span>
                          {line.product.name} × {line.quantity}
                        </span>
                      </div>
                    ))
                  )}
                  <div className="border-t pt-4 text-sm font-medium">
                    Total {formatINR(cart?.summary?.totalPaise ?? 0)}
                  </div>
                  <Button className="w-full rounded-full" asChild>
                    <Link href="/checkout" onClick={() => setCartOpen(false)}>
                      Checkout
                    </Link>
                  </Button>
                  <Button variant="outline" className="w-full rounded-full" asChild>
                    <Link href="/cart" onClick={() => setCartOpen(false)}>
                      View cart
                    </Link>
                  </Button>
                </div>
              </SheetContent>
            </Sheet>

            <Sheet open={authOpen} onOpenChange={setAuthOpen}>
              <SheetTrigger asChild>
                <Button variant="ghost" size="icon" className="rounded-full" aria-label="Account">
                  <User className="h-5 w-5" />
                </Button>
              </SheetTrigger>
              <SheetContent className="rounded-l-3xl">
                <SheetHeader>
                  <SheetTitle>{status === "authenticated" ? "Account" : "Sign in"}</SheetTitle>
                </SheetHeader>
                {status === "authenticated" ? (
                  <div className="mt-6 space-y-3">
                    <p className="text-sm text-muted-foreground">{session?.user?.email}</p>
                    <Button className="w-full rounded-full" asChild>
                      <Link href="/account" onClick={() => setAuthOpen(false)}>
                        My account
                      </Link>
                    </Button>
                    {session?.user?.role === "ADMIN" && (
                      <Button variant="secondary" className="w-full rounded-full" asChild>
                        <Link href="/admin" onClick={() => setAuthOpen(false)}>
                          Admin
                        </Link>
                      </Button>
                    )}
                  </div>
                ) : (
                  <form
                    className="mt-6 space-y-3"
                    onSubmit={(e) => {
                      e.preventDefault();
                      const fd = new FormData(e.currentTarget);
                      void signIn("credentials", {
                        email: String(fd.get("email")),
                        password: String(fd.get("password")),
                        callbackUrl: "/account",
                      });
                    }}
                  >
                    <Input name="email" type="email" placeholder="Email" required className="rounded-full" />
                    <Input name="password" type="password" placeholder="Password" required className="rounded-full" />
                    <Button type="submit" className="w-full rounded-full">
                      Sign in
                    </Button>
                    <Button variant="link" className="px-0" asChild>
                      <Link href="/account" onClick={() => setAuthOpen(false)}>
                        Register / full account page
                      </Link>
                    </Button>
                  </form>
                )}
              </SheetContent>
            </Sheet>
          </div>
        </div>
      </header>
    </>
  );
}
