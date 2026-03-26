import { NextResponse } from "next/server";
import { prisma } from "@/lib/prisma";
import { sendRawEmail } from "@/lib/email";

export async function POST(req: Request) {
  const auth = req.headers.get("authorization");
  if (process.env.CRON_SECRET && auth !== `Bearer ${process.env.CRON_SECRET}`) {
    return NextResponse.json({ error: "Unauthorized" }, { status: 401 });
  }
  const now = new Date();
  const due = await prisma.scheduledReminder.findMany({
    where: { sent: false, scheduledFor: { lte: now } },
    include: { booking: { include: { service: true, user: true } } },
    take: 50,
  });
  for (const r of due) {
    const b = r.booking;
    const when = b.scheduledAt.toLocaleString("en-IN");
    const to = b.user?.email ?? b.guestEmail;
    if (!to) {
      await prisma.scheduledReminder.update({ where: { id: r.id }, data: { sent: true, sentAt: new Date() } });
      continue;
    }
    await sendRawEmail({
      to,
      subject: r.reminderType === "SESSION_REMINDER_1H" ? "Session in 1 hour" : "Reminder: your session tomorrow",
      html: `<p>${b.service.name} — ${when}</p>`,
      templateName: "SessionReminder",
      relatedType: "BOOKING",
      relatedId: b.id,
    });
    await prisma.scheduledReminder.update({ where: { id: r.id }, data: { sent: true, sentAt: new Date() } });
  }
  return NextResponse.json({ processed: due.length });
}
