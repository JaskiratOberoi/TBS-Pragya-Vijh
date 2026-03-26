import { prisma } from "@/lib/prisma";
import type { Booking, Service } from "@prisma/client";

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

export async function getAvailableSlots(params: {
  date: Date; // calendar date (local)
  service: Service;
}): Promise<TimeSlot[]> {
  const { date, service } = params;
  const settings = await prisma.bookingSettings.findUnique({ where: { id: "singleton" } });
  const day = date.getDay();
  const rules = await prisma.availabilityRule.findMany({ where: { dayOfWeek: day, isActive: true } });
  if (rules.length === 0) return [];

  const duration = service.durationMinutes + (service.bufferMinutes ?? 0) + (settings?.bufferBetweenSlots ?? 0);
  const slotStep = Math.max(service.durationMinutes + (settings?.bufferBetweenSlots ?? 0), 15);

  const minAdvanceMs = (settings?.minAdvanceBookingHours ?? 2) * 60 * 60 * 1000;
  const now = Date.now();

  const dayStart = new Date(date);
  dayStart.setHours(0, 0, 0, 0);
  const dayEnd = new Date(date);
  dayEnd.setHours(23, 59, 59, 999);

  const bookings = await prisma.booking.findMany({
    where: {
      scheduledAt: { gte: dayStart, lte: dayEnd },
      status: { not: "CANCELLED" },
    },
  });

  const blocked = await prisma.blockedSlot.findMany({
    where: { date: dayStart },
  });

  const slots: TimeSlot[] = [];

  for (const rule of rules) {
    let cursor = parseHM(date, rule.startTime);
    const windowEnd = parseHM(date, rule.endTime);
    while (cursor.getTime() + duration * 60 * 1000 <= windowEnd.getTime()) {
      const start = new Date(cursor);
      const end = new Date(cursor.getTime() + service.durationMinutes * 60 * 1000);

      if (start.getTime() < now + minAdvanceMs) {
        cursor = new Date(cursor.getTime() + slotStep * 60 * 1000);
        continue;
      }

      let busy = false;
      for (const b of bookings) {
        if (overlaps(start, end, b.scheduledAt, b.endAt)) {
          busy = true;
          break;
        }
      }
      if (!busy) {
        for (const bl of blocked) {
          if (!bl.startTime || !bl.endTime) {
            busy = true;
            break;
          }
          const bs = parseHM(date, bl.startTime);
          const be = parseHM(date, bl.endTime);
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
  bookings: Pick<Booking, "scheduledAt" | "endAt" | "status">[]
) {
  for (const b of bookings) {
    if (b.status === "CANCELLED") continue;
    if (overlaps(start, end, b.scheduledAt, b.endAt)) return false;
  }
  return true;
}
