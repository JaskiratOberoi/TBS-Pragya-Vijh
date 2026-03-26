import { NextResponse } from "next/server";
import bcrypt from "bcryptjs";
import { prisma } from "@/lib/prisma";

export async function POST(req: Request) {
  const body = (await req.json()) as { token?: string; password?: string };
  if (!body.token || !body.password || body.password.length < 8) {
    return NextResponse.json({ error: "Invalid request" }, { status: 400 });
  }
  const row = await prisma.passwordResetToken.findUnique({ where: { token: body.token } });
  if (!row || row.expiresAt < new Date()) {
    return NextResponse.json({ error: "Invalid or expired token" }, { status: 400 });
  }
  const passwordHash = await bcrypt.hash(body.password, 12);
  await prisma.user.update({ where: { id: row.userId }, data: { passwordHash } });
  await prisma.passwordResetToken.delete({ where: { id: row.id } });
  return NextResponse.json({ ok: true });
}
