import { NextResponse } from "next/server";
import { strapiFetch, normalizeDoc } from "@/lib/strapi";

export async function GET(req: Request) {
  const position = new URL(req.url).searchParams.get("position");
  const now = new Date().toISOString();
  const parts = ["filters[isActive][$eq]=true", "sort[0]=sortOrder:asc", "pagination[pageSize]=100"];
  if (position) parts.push(`filters[position][$eq]=${encodeURIComponent(position)}`);
  const j = await strapiFetch<{ data?: unknown[] }>(`/api/banners?${parts.join("&")}`);
  const rows = (j.data ?? []).map((x) => normalizeDoc(x)) as Array<{
    startDate?: string | null;
    endDate?: string | null;
    [k: string]: unknown;
  }>;
  const banners = rows.filter((b) => {
    if (b.startDate && new Date(b.startDate) > new Date(now)) return false;
    if (b.endDate && new Date(b.endDate) < new Date(now)) return false;
    return true;
  });
  return NextResponse.json({ banners });
}
