import { NextResponse } from "next/server";
import { strapiFetch, normalizeDoc } from "@/lib/strapi";
import { getAvailableSlots } from "@/lib/slot-availability";

export async function GET(req: Request) {
  const { searchParams } = new URL(req.url);
  const serviceId = searchParams.get("serviceId");
  const dateStr = searchParams.get("date");
  if (!serviceId || !dateStr) return NextResponse.json({ error: "serviceId and date required" }, { status: 400 });
  const svcRes = await strapiFetch<{ data?: unknown[] }>(
    `/api/services?filters[documentId][$eq]=${encodeURIComponent(serviceId)}&pagination[pageSize]=1`
  );
  const raw = svcRes.data?.[0];
  if (!raw) return NextResponse.json({ error: "Service not found" }, { status: 404 });
  const service = normalizeDoc(raw) as {
    durationMinutes: number;
    bufferMinutes?: number | null;
  };
  const date = new Date(dateStr);
  if (Number.isNaN(date.getTime())) return NextResponse.json({ error: "Invalid date" }, { status: 400 });
  const slots = await getAvailableSlots({ date, service });
  return NextResponse.json({
    slots: slots.map((s) => ({ start: s.start.toISOString(), end: s.end.toISOString(), label: s.label })),
  });
}
