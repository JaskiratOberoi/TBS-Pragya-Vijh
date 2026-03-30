import Link from "next/link";

export function PromoBanner() {
  return (
    <div className="relative border-b border-metal/25 bg-gradient-to-r from-inverse via-primary to-inverse py-2.5 text-inverse-foreground shadow-[inset_0_1px_0_0_hsl(var(--metal)/0.35)]">
      <div className="mx-auto flex max-w-7xl flex-col items-center justify-center gap-1 px-4 text-center sm:flex-row sm:gap-4 sm:text-left">
        <p className="text-xs font-medium tracking-luxury text-inverse-foreground/95 sm:text-sm">
          Free Money Potli on orders ₹1499+ · Buy any 3 products, get 1 free — applied in cart
        </p>
        <Link
          href="/shop"
          className="shrink-0 text-xs font-medium text-metal underline-offset-4 transition hover:text-metal/90 hover:underline sm:text-sm"
        >
          Shop crystals
        </Link>
      </div>
    </div>
  );
}
