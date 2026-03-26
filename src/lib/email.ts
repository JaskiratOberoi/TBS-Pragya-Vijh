import nodemailer from "nodemailer";
import { prisma } from "@/lib/prisma";

function getTransport() {
  const host = process.env.SMTP_HOST;
  const port = process.env.SMTP_PORT ? Number(process.env.SMTP_PORT) : 587;
  const user = process.env.SMTP_USER;
  const pass = process.env.SMTP_PASSWORD;
  if (!host || !user || !pass) return null;
  return nodemailer.createTransport({ host, port, secure: port === 465, auth: { user, pass } });
}

export async function sendRawEmail(opts: { to: string; subject: string; html: string; templateName: string; relatedType?: "ORDER" | "BOOKING" | "CONTACT" | "REFUND"; relatedId?: string }) {
  const from = process.env.EMAIL_FROM ?? process.env.SMTP_USER;
  const transport = getTransport();
  try {
    if (!transport || !from) {
      await prisma.emailLog.create({
        data: {
          to: opts.to,
          subject: opts.subject,
          templateName: opts.templateName,
          status: "FAILED",
          relatedType: opts.relatedType,
          relatedId: opts.relatedId,
          error: "SMTP not configured",
        },
      });
      return { ok: false as const };
    }
    await transport.sendMail({ from, to: opts.to, subject: opts.subject, html: opts.html });
    await prisma.emailLog.create({
      data: {
        to: opts.to,
        subject: opts.subject,
        templateName: opts.templateName,
        status: "SENT",
        relatedType: opts.relatedType,
        relatedId: opts.relatedId,
      },
    });
    return { ok: true as const };
  } catch (e) {
    const err = e instanceof Error ? e.message : String(e);
    await prisma.emailLog.create({
      data: {
        to: opts.to,
        subject: opts.subject,
        templateName: opts.templateName,
        status: "FAILED",
        relatedType: opts.relatedType,
        relatedId: opts.relatedId,
        error: err,
      },
    });
    return { ok: false as const, error: err };
  }
}
