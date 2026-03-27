import { NextResponse } from "next/server";
import { findLegalPageBySlug } from "@/lib/strapi-queries";

export async function GET(_req: Request, { params }: { params: Promise<{ slug: string }> }) {
  const { slug } = await params;
  const page = await findLegalPageBySlug(slug);
  if (!page) return NextResponse.json({ error: "Not found" }, { status: 404 });
  return NextResponse.json(page);
}
