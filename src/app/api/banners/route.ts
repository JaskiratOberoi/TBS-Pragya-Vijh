import { NextResponse } from "next/server";
import { prisma } from "@/lib/prisma";
import type { BannerPosition } from "@prisma/client";

export async function GET(req: Request) {
  const position = new URL(req.url).searchParams.get("position");
  const now = new Date();
  const banners = await prisma.banner.findMany({
    where: {
      isActive: true,
      AND: [
        { OR: [{ startDate: null }, { startDate: { lte: now } }] },
        { OR: [{ endDate: null }, { endDate: { gte: now } }] },
      ],
      ...(position ? { position: position as BannerPosition } : {}),
    },
    orderBy: { sortOrder: "asc" },
  });
  return NextResponse.json({ banners });
}
