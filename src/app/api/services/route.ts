import { NextResponse } from "next/server";
import { strapiFetch, normalizeDoc } from "@/lib/strapi";

export async function GET() {
  const j = await strapiFetch<{ data?: unknown[] }>(
    `/api/services?filters[isActive][$eq]=true&sort[0]=name:asc&pagination[pageSize]=200`
  );
  const services = (j.data ?? []).map((x) => normalizeDoc(x));
  return NextResponse.json({ services });
}
