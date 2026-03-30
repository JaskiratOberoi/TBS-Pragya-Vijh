import { strapiFetchPublicList, strapiFetchPublicSingle, strapiGetResponse, unwrapList, normalizeDoc } from "@/lib/strapi";

export type TimeSlot = { start: Date; end: Date; label: string };

function parseHM(d: Date, hm: string) {
  const [h, m] = hm.split(":").map(Number);
  const x = new Date(d);
  x.setHours(h, m, 0, 0);
  return x;
}

function overlaps(aStart: Date, aEnd: Date, bStart: Date, bEnd: Date) {
  return aStart < bEnd && bStart < aEnd;
}

export type ServiceSlotInput = {
  durationMinutes: number;
  bufferMinutes?: number | null;
};

export async function getAvailableSlots(params: {
  date: Date;
  service: ServiceSlotInput;
}): Promise<TimeSlot[]> {
  const { date, service } = params;
  const settingsJson = await strapiFetchPublicSingle<{ data?: unknown }>(`/api/booking-setting`, {
    next: { revalidate: 60 },
  });
  const settings = settingsJson?.data ? normalizeDoc(settingsJson.data) : null;
  const day = date.getDay();
  const rulesRes = await strapiFetchPublicList<{ data?: unknown[] }>(
    `/api/availability-rules?filters[dayOfWeek][$eq]=${day}&filters[isActive][$eq]=true&pagination[pageSize]=50`
  );
  const rules = unwrapList(rulesRes);
  if (rules.length === 0) return [];

  const bufferBetween = Number(settings?.bufferBetweenSlots ?? 15);
  const duration = service.durationMinutes + (service.bufferMinutes ?? 0) + bufferBetween;
  const slotStep = Math.max(service.durationMinutes + bufferBetween, 15);

  const minAdvanceMs = Number(settings?.minAdvanceBookingHours ?? 2) * 60 * 60 * 1000;
  const now = Date.now();

  const dayStart = new Date(date);
  dayStart.setHours(0, 0, 0, 0);
  const dayEnd = new Date(date);
  dayEnd.setHours(23, 59, 59, 999);

  const isoStart = dayStart.toISOString();
  const isoEnd = dayEnd.toISOString();
  const bookingsHttp = await strapiGetResponse(
    `/api/bookings?filters[scheduledAt][$gte]=${encodeURIComponent(isoStart)}&filters[scheduledAt][$lte]=${encodeURIComponent(isoEnd)}&pagination[pageSize]=200`
  );
  if (bookingsHttp.status === 403 || bookingsHttp.status === 404) return [];
  if (!bookingsHttp.ok) {
    const t = await bookingsHttp.text();
    throw new Error(`Strapi ${bookingsHttp.status}: ${t.slice(0, 500)}`);
  }
  const bookingsJson = (await bookingsHttp.json()) as { data?: unknown[] };
  const bookings = unwrapList(bookingsJson).map((b) => ({
    scheduledAt: new Date(String((b as { scheduledAt?: string }).scheduledAt)),
    endAt: new Date(String((b as { endAt?: string }).endAt)),
    status: String((b as { status?: string }).status ?? ""),
  }));

  const dateStr = dayStart.toISOString().slice(0, 10);
  const blockedHttp = await strapiGetResponse(
    `/api/blocked-slots?filters[date][$eq]=${dateStr}&pagination[pageSize]=100`
  );
  if (blockedHttp.status === 403 || blockedHttp.status === 404) return [];
  if (!blockedHttp.ok) {
    const t = await blockedHttp.text();
    throw new Error(`Strapi ${blockedHttp.status}: ${t.slice(0, 500)}`);
  }
  const blockedJson = (await blockedHttp.json()) as { data?: unknown[] };
  const blocked = unwrapList(blockedJson);

  const slots: TimeSlot[] = [];

  for (const rule of rules) {
    const r = rule as { startTime?: string; endTime?: string };
    if (!r.startTime || !r.endTime) continue;
    let cursor = parseHM(date, r.startTime);
    const windowEnd = parseHM(date, r.endTime);
    while (cursor.getTime() + duration * 60 * 1000 <= windowEnd.getTime()) {
      const start = new Date(cursor);
      const end = new Date(cursor.getTime() + service.durationMinutes * 60 * 1000);

      if (start.getTime() < now + minAdvanceMs) {
        cursor = new Date(cursor.getTime() + slotStep * 60 * 1000);
        continue;
      }

      let busy = false;
      for (const b of bookings) {
        if (b.status === "CANCELLED") continue;
        if (overlaps(start, end, b.scheduledAt, b.endAt)) {
          busy = true;
          break;
        }
      }
      if (!busy) {
        for (const bl of blocked) {
          const blo = bl as { startTime?: string | null; endTime?: string | null };
          if (!blo.startTime || !blo.endTime) {
            busy = true;
            break;
          }
          const bs = parseHM(date, blo.startTime);
          const be = parseHM(date, blo.endTime);
          if (overlaps(start, end, bs, be)) {
            busy = true;
            break;
          }
        }
      }

      if (!busy) {
        slots.push({
          start,
          end,
          label: start.toLocaleTimeString("en-IN", { hour: "2-digit", minute: "2-digit" }),
        });
      }

      cursor = new Date(cursor.getTime() + slotStep * 60 * 1000);
    }
  }

  return slots;
}

export function assertSlotStillAvailable(
  start: Date,
  end: Date,
  bookings: Pick<{ scheduledAt: Date; endAt: Date; status: string }, "scheduledAt" | "endAt" | "status">[]
) {
  for (const b of bookings) {
    if (b.status === "CANCELLED") continue;
    if (overlaps(start, end, b.scheduledAt, b.endAt)) return false;
  }
  return true;
}
