import { NextResponse } from "next/server";
import { prisma } from "@/lib/prisma";

export async function GET(_req: Request, { params }: { params: Promise<{ slug: string }> }) {
  const { slug } = await params;
  const product = await prisma.product.findUnique({
    where: { slug },
    include: { category: true, shippingClass: true, variants: true, digitalAssets: true },
  });
  if (!product || !product.isActive) return NextResponse.json({ error: "Not found" }, { status: 404 });

  const related = await prisma.product.findMany({
    where: { isActive: true, categoryId: product.categoryId, NOT: { id: product.id } },
    take: 8,
    include: { category: true },
  });

  return NextResponse.json({ product, related });
}
