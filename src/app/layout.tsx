import type { Metadata } from "next";
import { Inter, Lora } from "next/font/google";
import "./globals.css";
import { Providers } from "@/components/providers";
import { PromoBanner } from "@/components/layout/PromoBanner";
import { SiteChrome } from "@/components/layout/SiteChrome";
import { Footer } from "@/components/layout/Footer";
import { MobileNav } from "@/components/layout/MobileNav";
import { WhatsAppButton } from "@/components/layout/WhatsAppButton";
import { CartMergeOnLogin } from "@/components/shared/CartMergeOnLogin";
import { FbPixel } from "@/components/shared/FbPixel";
import { getFacebookPixelIdForSite } from "@/lib/pixel-config";

const inter = Inter({ subsets: ["latin"], variable: "--font-sans" });
const lora = Lora({ subsets: ["latin"], variable: "--font-serif" });

/** Strapi is not available during `next build` in Docker; avoid static prerender that would fetch CMS. */
export const dynamic = "force-dynamic";

export const metadata: Metadata = {
  title: { default: "The Blissful Soul — Healing Crystals & Sessions", template: "%s | The Blissful Soul" },
  description:
    "Shop healing crystals, bracelets, pyramids, and book audio/video sessions with Master Pragya Vijh. Delhi, India.",
  openGraph: {
    title: "The Blissful Soul",
    description: "Healing crystals, tarot, kundali, therapy sessions.",
    type: "website",
  },
};

export default async function RootLayout({ children }: { children: React.ReactNode }) {
  const fbPixelId = await getFacebookPixelIdForSite();
  return (
    <html lang="en" className={`${inter.variable} ${lora.variable}`}>
      <body className="min-h-screen bg-bento-canvas font-sans antialiased pb-16 md:pb-0">
        <Providers>
          <CartMergeOnLogin />
          <FbPixel pixelId={fbPixelId} />
          <PromoBanner />
          <SiteChrome />
          <main className="min-h-[60vh]">{children}</main>
          <Footer />
          <MobileNav />
          <WhatsAppButton />
        </Providers>
      </body>
    </html>
  );
}
