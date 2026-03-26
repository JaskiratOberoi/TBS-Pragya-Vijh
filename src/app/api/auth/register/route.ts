import { NextResponse } from "next/server";
import bcrypt from "bcryptjs";
import { prisma } from "@/lib/prisma";
import { sendRawEmail } from "@/lib/email";

export async function POST(req: Request) {
  const body = (await req.json()) as { name?: string; email?: string; password?: string; phone?: string };
  if (!body.email || !body.password || body.password.length < 8) {
    return NextResponse.json({ error: "Valid email and password (8+ chars) required" }, { status: 400 });
  }
  const exists = await prisma.user.findUnique({ where: { email: body.email.toLowerCase() } });
  if (exists) return NextResponse.json({ error: "Email already registered" }, { status: 400 });
  const passwordHash = await bcrypt.hash(body.password, 12);
  await prisma.user.create({
    data: {
      email: body.email.toLowerCase(),
      name: body.name,
      phone: body.phone,
      passwordHash,
      role: "USER",
    },
  });
  await sendRawEmail({
    to: body.email.toLowerCase(),
    subject: "Welcome to The Blissful Soul",
    html: `<p>Welcome${body.name ? `, ${body.name}` : ""}! You can now sign in at your account page.</p>`,
    templateName: "WelcomeEmail",
  });
  return NextResponse.json({ ok: true });
}
