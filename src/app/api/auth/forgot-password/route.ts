import { NextResponse } from "next/server";
import { randomBytes } from "crypto";
import { prisma } from "@/lib/prisma";
import { sendRawEmail } from "@/lib/email";

export async function POST(req: Request) {
  const body = (await req.json()) as { email?: string };
  if (!body.email) return NextResponse.json({ ok: true });
  const user = await prisma.user.findUnique({ where: { email: body.email.toLowerCase() } });
  if (!user) return NextResponse.json({ ok: true });
  const token = randomBytes(32).toString("hex");
  const expiresAt = new Date(Date.now() + 60 * 60 * 1000);
  await prisma.passwordResetToken.deleteMany({ where: { userId: user.id } });
  await prisma.passwordResetToken.create({ data: { token, userId: user.id, expiresAt } });
  const base = process.env.NEXTAUTH_URL ?? "http://localhost:3000";
  const link = `${base}/account/reset-password?token=${token}`;
  await sendRawEmail({
    to: user.email,
    subject: "Reset your password",
    html: `<p>Click to reset: <a href="${link}">${link}</a> (expires in 1 hour)</p>`,
    templateName: "PasswordReset",
  });
  return NextResponse.json({ ok: true });
}
