import Link from "next/link";
import { Instagram } from "lucide-react";
import { FooterNewsletter } from "@/components/layout/FooterNewsletter";
import { INSTAGRAM_PROFILE_URL } from "@/lib/instagram-profile";

export function Footer() {
  return (
    <footer className="border-t border-metal/20 bg-inverse text-inverse-foreground">
      <div className="mx-auto grid max-w-7xl gap-12 px-4 py-16 md:grid-cols-2 lg:grid-cols-12 lg:gap-10">
        <div className="lg:col-span-4">
          <p className="font-display text-2xl font-semibold tracking-display text-inverse-foreground">The Blissful Soul</p>
          <p className="mt-3 max-w-sm text-sm leading-relaxed text-inverse-muted">
            Healing crystals, sessions, and guidance — curated with care in Delhi and online.
          </p>
          <FooterNewsletter />
        </div>
        <div className="lg:col-span-3">
          <h3 className="text-xs font-medium uppercase tracking-luxury text-metal">Contact</h3>
          <ul className="mt-4 space-y-3 text-sm text-inverse-muted">
            <li>The Blissful Soul, Shakti Nagar, Delhi 110007</li>
            <li>
              <a href="tel:+919811611341" className="transition hover:text-inverse-foreground">
                +91 98116 11341
              </a>
            </li>
            <li>
              <a href="mailto:theblissfulsoul27@gmail.com" className="transition hover:text-inverse-foreground">
                theblissfulsoul27@gmail.com
              </a>
            </li>
          </ul>
        </div>
        <div className="lg:col-span-2">
          <h3 className="text-xs font-medium uppercase tracking-luxury text-metal">Explore</h3>
          <ul className="mt-4 space-y-2 text-sm">
            <li>
              <Link href="/about" className="text-inverse-muted transition hover:text-inverse-foreground">
                About Master
              </Link>
            </li>
            <li>
              <Link href="/services" className="text-inverse-muted transition hover:text-inverse-foreground">
                Book a session
              </Link>
            </li>
            <li>
              <Link href="/shop" className="text-inverse-muted transition hover:text-inverse-foreground">
                Shop crystals
              </Link>
            </li>
            <li>
              <Link href="/contact" className="text-inverse-muted transition hover:text-inverse-foreground">
                Contact
              </Link>
            </li>
          </ul>
        </div>
        <div className="lg:col-span-3">
          <h3 className="text-xs font-medium uppercase tracking-luxury text-metal">Legal</h3>
          <ul className="mt-4 space-y-2 text-sm">
            <li>
              <Link href="/terms" className="text-inverse-muted transition hover:text-inverse-foreground">
                Terms
              </Link>
            </li>
            <li>
              <Link href="/privacy-policy" className="text-inverse-muted transition hover:text-inverse-foreground">
                Privacy
              </Link>
            </li>
            <li>
              <Link href="/refund-policy" className="text-inverse-muted transition hover:text-inverse-foreground">
                Refund policy
              </Link>
            </li>
            <li>
              <Link href="/shipping-policy" className="text-inverse-muted transition hover:text-inverse-foreground">
                Shipping policy
              </Link>
            </li>
          </ul>
          <div className="mt-8 flex gap-3">
            <a
              href={INSTAGRAM_PROFILE_URL}
              target="_blank"
              rel="noopener noreferrer"
              className="inline-flex h-10 w-10 items-center justify-center rounded-full border border-inverse-muted/30 text-inverse-muted transition hover:border-metal/50 hover:text-metal"
              aria-label="Instagram"
            >
              <Instagram className="h-5 w-5" />
            </a>
          </div>
        </div>
      </div>
      <div className="border-t border-inverse-muted/20 py-5 text-center text-xs text-inverse-muted">
        © {new Date().getFullYear()} The Blissful Soul. All rights reserved.
      </div>
    </footer>
  );
}
