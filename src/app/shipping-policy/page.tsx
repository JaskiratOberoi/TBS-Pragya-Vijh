import { findLegalPageBySlug } from "@/lib/strapi-queries";
import type { Metadata } from "next";

export const metadata: Metadata = { title: "Shipping Policy" };

export default async function ShippingPolicyPage() {
  const page = await findLegalPageBySlug("shipping-policy");
  return (
    <article
      className="mx-auto max-w-3xl px-4 py-10 text-sm leading-relaxed text-muted-foreground [&_h1]:text-foreground [&_p]:mt-3"
      dangerouslySetInnerHTML={{ __html: page?.content ?? "<p>Content loading…</p>" }}
    />
  );
}
