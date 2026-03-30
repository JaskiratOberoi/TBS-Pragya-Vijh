"use client";

import Link from "next/link";
import Image from "next/image";
import { useEffect, useState, useCallback } from "react";
import { usePathname } from "next/navigation";
import { motion } from "framer-motion";
import { ShoppingBag, Heart, User, Search } from "lucide-react";
import { Button } from "@/components/ui/button";
import { Sheet, SheetContent, SheetHeader, SheetTitle, SheetTrigger } from "@/components/ui/sheet";
import { Input } from "@/components/ui/input";
import { formatINR } from "@/lib/utils";
import { signIn } from "next-auth/react";
import { useSession } from "next-auth/react";
import { cn } from "@/lib/utils";

const MotionLink = motion(Link);
const MotionButton = motion(Button);

const nav = [
  { href: "/", label: "Home" },
  { href: "/about", label: "About" },
  { href: "/services", label: "Book your session" },
  { href: "/shop", label: "Shop Crystals" },
  { href: "/contact", label: "Contact" },
];

type CartSummary = { totalPaise: number; subtotalPaise: number };

type CartLineProduct = {
  name: string;
  slug: string;
  salePrice: number | null;
  price: number;
  images?: string[];
};

function navActive(pathname: string, href: string) {
  if (href === "/") return pathname === "/";
  return pathname === href || pathname.startsWith(`${href}/`);
}

export function SiteChrome() {
  const pathname = usePathname();
  const [cartOpen, setCartOpen] = useState(false);
  const [searchOpen, setSearchOpen] = useState(false);
  const [authOpen, setAuthOpen] = useState(false);
  const [cart, setCart] = useState<{
    items: { id: string; quantity: number; product: CartLineProduct }[];
    summary: CartSummary;
  } | null>(null);
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
      <header className="sticky top-0 z-50 border-b border-border/70 bg-elevated/85 shadow-header backdrop-blur-xl supports-[backdrop-filter]:bg-elevated/70">
        <div className="mx-auto flex max-w-7xl items-center justify-between gap-3 px-4 py-3.5 md:gap-6 md:py-4">
          <Link href="/" className="group shrink-0">
            <span className="font-display text-xl font-semibold tracking-display text-primary md:text-2xl">The Blissful Soul</span>
            <span className="mt-0.5 block text-[10px] font-medium uppercase tracking-luxury text-muted-foreground md:text-[11px]">
              Healing &amp; crystals
            </span>
          </Link>
          <nav className="relative hidden items-center gap-0.5 rounded-full border border-border/80 bg-card/90 p-1 shadow-elevation-rest md:flex">
            {nav.map((item) => {
              const active = navActive(pathname, item.href);
              return (
                <MotionLink
                  key={item.href}
                  href={item.href}
                  className={cn(
                    "relative inline-flex rounded-full px-3.5 py-2 text-sm font-medium transition-colors",
                    active
                      ? "z-10 text-primary-foreground"
                      : "text-muted-foreground hover:bg-muted/80 hover:text-foreground"
                  )}
                >
                  {active && (
                    <motion.span
                      layoutId="navActivePill"
                      className="absolute inset-0 -z-10 rounded-full bg-primary shadow-elevation-rest ring-1 ring-metal/25"
                      transition={{ type: "spring", stiffness: 400, damping: 34 }}
                    />
                  )}
                  <span className="relative">{item.label}</span>
                </MotionLink>
              );
            })}
          </nav>
          <div className="flex items-center gap-0.5">
            <Sheet open={searchOpen} onOpenChange={setSearchOpen}>
              <SheetTrigger asChild>
                <MotionButton
                  variant="ghost"
                  size="icon"
                  className="rounded-full text-foreground/90"
                  aria-label="Search"
                  whileHover={{ scale: 1.05 }}
                  whileTap={{ scale: 0.94 }}
                >
                  <Search className="h-[1.25rem] w-[1.25rem] stroke-[1.5]" />
                </MotionButton>
              </SheetTrigger>
              <SheetContent side="top" className="h-auto max-h-[80vh] border-b border-border/60 px-6 pb-8 pt-6">
                <SheetHeader className="space-y-1 text-left">
                  <SheetTitle className="font-display text-xl tracking-display">Search products</SheetTitle>
                  <p className="text-sm font-normal text-muted-foreground">Find crystals and tools by name</p>
                </SheetHeader>
                <Input
                  placeholder="Type to search…"
                  value={q}
                  onChange={(e) => setQ(e.target.value)}
                  className="mt-6 rounded-full border-border/80 bg-muted/30"
                  autoFocus
                />
                <ul className="mt-6 max-h-64 space-y-1 overflow-auto">
                  {results.length === 0 && q.length >= 2 && (
                    <li className="px-2 py-6 text-center text-sm text-muted-foreground">No matches yet.</li>
                  )}
                  {results.map((p) => (
                    <li key={p.slug}>
                      <Link
                        href={`/shop/${p.slug}`}
                        className="flex items-center gap-4 rounded-2xl p-3 transition hover:bg-muted/60"
                        onClick={() => setSearchOpen(false)}
                      >
                        {p.images[0] && (
                          <Image
                            src={p.images[0]}
                            alt=""
                            width={48}
                            height={48}
                            className="rounded-dense border border-border/50 object-cover"
                          />
                        )}
                        <span className="text-sm font-medium text-foreground">{p.name}</span>
                      </Link>
                    </li>
                  ))}
                </ul>
              </SheetContent>
            </Sheet>

            <Button variant="ghost" size="icon" className="rounded-full text-foreground/90" asChild>
              <MotionLink href="/wishlist" aria-label="Wishlist" whileHover={{ scale: 1.05 }} whileTap={{ scale: 0.94 }}>
                <Heart className="h-[1.25rem] w-[1.25rem] stroke-[1.5]" />
              </MotionLink>
            </Button>

            <Sheet open={cartOpen} onOpenChange={setCartOpen}>
              <SheetTrigger asChild>
                <MotionButton
                  variant="ghost"
                  size="icon"
                  className="relative rounded-full text-foreground/90"
                  aria-label="Cart"
                  whileHover={{ scale: 1.05 }}
                  whileTap={{ scale: 0.94 }}
                >
                  <ShoppingBag className="h-[1.25rem] w-[1.25rem] stroke-[1.5]" />
                  {itemCount > 0 && (
                    <span className="absolute -right-0.5 -top-0.5 flex h-4 min-w-4 items-center justify-center rounded-full bg-metal px-1 text-[10px] font-semibold text-metal-foreground ring-1 ring-metal/40">
                      {itemCount}
                    </span>
                  )}
                </MotionButton>
              </SheetTrigger>
              <SheetContent className="flex w-full flex-col rounded-l-3xl border-l border-border/60 px-6 pb-8 pt-6 sm:max-w-md">
                <SheetHeader className="space-y-1 text-left">
                  <SheetTitle className="font-display text-xl tracking-display">Your cart</SheetTitle>
                  <p className="text-sm font-normal text-muted-foreground">
                    {itemCount > 0 ? `${itemCount} item${itemCount === 1 ? "" : "s"}` : "Ready when you are"}
                  </p>
                </SheetHeader>
                <div className="mt-8 flex flex-1 flex-col gap-6 overflow-hidden">
                  {(cart?.items?.length ?? 0) === 0 ? (
                    <p className="text-sm leading-relaxed text-muted-foreground">
                      Your bag is empty. Explore the shop for healing crystals and session bookings.
                    </p>
                  ) : (
                    <ul className="max-h-[min(50vh,24rem)] space-y-4 overflow-auto pr-1">
                      {cart!.items.map((line) => {
                        const thumb = line.product.images?.[0];
                        return (
                          <li key={line.id} className="flex gap-3 border-b border-border/50 pb-4 last:border-0">
                            <Link
                              href={`/shop/${line.product.slug}`}
                              className="relative h-16 w-16 shrink-0 overflow-hidden rounded-dense border border-border/60 bg-muted"
                              onClick={() => setCartOpen(false)}
                            >
                              {thumb ? (
                                <Image src={thumb} alt="" fill className="object-cover" sizes="64px" />
                              ) : null}
                            </Link>
                            <div className="min-w-0 flex-1">
                              <Link
                                href={`/shop/${line.product.slug}`}
                                className="line-clamp-2 text-sm font-medium hover:text-primary"
                                onClick={() => setCartOpen(false)}
                              >
                                {line.product.name}
                              </Link>
                              <p className="mt-1 text-xs text-muted-foreground">Qty {line.quantity}</p>
                            </div>
                          </li>
                        );
                      })}
                    </ul>
                  )}
                  <div className="mt-auto space-y-4 border-t border-border/60 pt-6">
                    <div className="flex items-baseline justify-between text-sm">
                      <span className="text-muted-foreground">Total</span>
                      <span className="font-display text-lg font-semibold text-foreground">
                        {formatINR(cart?.summary?.totalPaise ?? 0)}
                      </span>
                    </div>
                    <Button className="w-full rounded-full" asChild>
                      <Link href="/checkout" onClick={() => setCartOpen(false)}>
                        Checkout
                      </Link>
                    </Button>
                    <Button variant="outline" className="w-full rounded-full border-border/80" asChild>
                      <Link href="/cart" onClick={() => setCartOpen(false)}>
                        View cart
                      </Link>
                    </Button>
                  </div>
                </div>
              </SheetContent>
            </Sheet>

            <Sheet open={authOpen} onOpenChange={setAuthOpen}>
              <SheetTrigger asChild>
                <MotionButton
                  variant="ghost"
                  size="icon"
                  className="rounded-full text-foreground/90"
                  aria-label="Account"
                  whileHover={{ scale: 1.05 }}
                  whileTap={{ scale: 0.94 }}
                >
                  <User className="h-[1.25rem] w-[1.25rem] stroke-[1.5]" />
                </MotionButton>
              </SheetTrigger>
              <SheetContent className="rounded-l-3xl border-l border-border/60 px-6 pb-8 pt-6 sm:max-w-md">
                <SheetHeader className="space-y-1 text-left">
                  <SheetTitle className="font-display text-xl tracking-display">
                    {status === "authenticated" ? "Account" : "Sign in"}
                  </SheetTitle>
                  <p className="text-sm font-normal text-muted-foreground">
                    {status === "authenticated" ? "Manage orders and profile" : "Access your saved details"}
                  </p>
                </SheetHeader>
                {status === "authenticated" ? (
                  <div className="mt-8 space-y-4">
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
                    className="mt-8 space-y-4"
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
                    <Button variant="link" className="px-0 text-metal-muted" asChild>
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
