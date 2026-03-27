import { findLegalPageBySlug } from "@/lib/strapi-queries";
import type { Metadata } from "next";

export const metadata: Metadata = { title: "Privacy Policy" };

export default async function PrivacyPage() {
  const page = await findLegalPageBySlug("privacy-policy");
  return (
    <article
      className="mx-auto max-w-3xl px-4 py-10 text-sm leading-relaxed text-muted-foreground [&_h1]:text-foreground [&_p]:mt-3"
      dangerouslySetInnerHTML={{ __html: page?.content ?? "<p>Content loading…</p>" }}
    />
  );
}
