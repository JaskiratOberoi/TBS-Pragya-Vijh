import { NextResponse } from "next/server";
import { strapiFetch, normalizeDoc } from "@/lib/strapi";
import { sendRawEmail } from "@/lib/email";

export async function POST(req: Request) {
  const auth = req.headers.get("authorization");
  if (process.env.CRON_SECRET && auth !== `Bearer ${process.env.CRON_SECRET}`) {
    return NextResponse.json({ error: "Unauthorized" }, { status: 401 });
  }
  const now = new Date();
  const j = await strapiFetch<{ data?: unknown[] }>(
    `/api/scheduled-reminders?filters[sent][$eq]=false&filters[scheduledFor][$lte]=${encodeURIComponent(now.toISOString())}&populate[booking][populate][service]=true&populate[booking][populate][user]=true&pagination[pageSize]=50`
  );
  const due = (j.data ?? []).map((x) => normalizeDoc(x));
  for (const raw of due) {
    const r = raw as Record<string, unknown>;
    const rDoc = String(r.documentId ?? r.id ?? "");
    const b = r.booking as
      | {
          scheduledAt?: string;
          guestEmail?: string;
          user?: { email?: string };
          service?: { name?: string };
        }
      | undefined;
    if (!b) {
      await strapiFetch(`/api/scheduled-reminders/${rDoc}`, {
        method: "PUT",
        body: JSON.stringify({ data: { sent: true, sentAt: now.toISOString() } }),
      });
      continue;
    }
    const when = b.scheduledAt ? new Date(b.scheduledAt).toLocaleString("en-IN") : "";
    const to = b.user?.email ?? b.guestEmail;
    const bookingId = (b as { documentId?: string }).documentId ?? "";
    if (!to) {
      await strapiFetch(`/api/scheduled-reminders/${rDoc}`, {
        method: "PUT",
        body: JSON.stringify({ data: { sent: true, sentAt: now.toISOString() } }),
      });
      continue;
    }
    await sendRawEmail({
      to,
      subject: r.reminderType === "SESSION_REMINDER_1H" ? "Session in 1 hour" : "Reminder: your session tomorrow",
      html: `<p>${b.service?.name ?? "Session"} — ${when}</p>`,
      templateName: "SessionReminder",
      relatedType: "BOOKING",
      relatedId: String(bookingId),
    });
    await strapiFetch(`/api/scheduled-reminders/${rDoc}`, {
      method: "PUT",
      body: JSON.stringify({ data: { sent: true, sentAt: now.toISOString() } }),
    });
  }
  return NextResponse.json({ processed: due.length });
}
