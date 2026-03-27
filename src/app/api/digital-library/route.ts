import { NextResponse } from "next/server";
import { getServerSession } from "next-auth";
import { authOptions } from "@/lib/auth";
import { prisma } from "@/lib/prisma";

export async function GET() {
  const session = await getServerSession(authOptions);
  if (!session?.user?.id) return NextResponse.json({ items: [] });
  const items = await prisma.digitalPurchase.findMany({
    where: { userId: session.user.id },
    include: { asset: { include: { product: true } } },
    orderBy: { accessGrantedAt: "desc" },
  });
  return NextResponse.json({
    items: items.map((i) => ({
      id: i.id,
      productName: i.asset.product.name,
      assetType: i.asset.assetType,
      url: i.accessUrl ?? i.asset.url,
      instructions: i.asset.accessInstructions,
    })),
  });
}
