import { prisma } from "@/lib/prisma";
import type { Metadata } from "next";

export const metadata: Metadata = { title: "Refund Policy" };

export default async function RefundPage() {
  const page = await prisma.legalPage.findUnique({ where: { slug: "refund-policy" } });
  return (
    <article
      className="mx-auto max-w-3xl px-4 py-10 text-sm leading-relaxed text-muted-foreground [&_p]:mt-3"
      dangerouslySetInnerHTML={{ __html: page?.content ?? "<p>Content loading…</p>" }}
    />
  );
}
