import { NextResponse } from "next/server";
import { prisma } from "@/lib/prisma";
import { sendRawEmail } from "@/lib/email";

export async function POST(req: Request) {
  const body = (await req.json()) as {
    name?: string;
    email?: string;
    phone?: string;
    company?: string;
    message?: string;
  };
  if (!body.name || !body.email || !body.message) {
    return NextResponse.json({ error: "Name, email, message required" }, { status: 400 });
  }
  const msg = await prisma.contactMessage.create({
    data: {
      name: body.name,
      email: body.email,
      phone: body.phone,
      company: body.company,
      message: body.message,
    },
  });
  await sendRawEmail({
    to: body.email,
    subject: "We received your message — The Blissful Soul",
    html: `<p>Hi ${body.name}, we will get back to you shortly.</p>`,
    templateName: "ContactAutoReply",
    relatedType: "CONTACT",
    relatedId: msg.id,
  });
  const admin = process.env.ADMIN_EMAIL;
  if (admin) {
    await sendRawEmail({
      to: admin,
      subject: `Contact: ${body.name}`,
      html: `<p>${body.message}</p><p>${body.email} ${body.phone ?? ""} ${body.company ?? ""}</p>`,
      templateName: "AdminContactMessage",
      relatedType: "CONTACT",
      relatedId: msg.id,
    });
  }
  return NextResponse.json({ ok: true });
}
