import { NextResponse } from "next/server";
import { sendRawEmail } from "@/lib/email";

export async function POST(req: Request) {
  const body = (await req.json()) as { name?: string; email?: string; password?: string; phone?: string };
  if (!body.email || !body.password || body.password.length < 8) {
    return NextResponse.json({ error: "Valid email and password (8+ chars) required" }, { status: 400 });
  }
  const email = body.email.toLowerCase().trim();
  const base = process.env.STRAPI_API_URL ?? process.env.NEXT_PUBLIC_STRAPI_URL ?? "http://localhost:1337";
  const res = await fetch(`${base.replace(/\/$/, "")}/api/auth/local/register`, {
    method: "POST",
    headers: { "Content-Type": "application/json" },
    body: JSON.stringify({
      username: email,
      email,
      password: body.password,
    }),
  });
  const data = (await res.json()) as { error?: { message?: string }; user?: { documentId?: string } };
  if (!res.ok) {
    const msg = data.error?.message ?? "Registration failed";
    return NextResponse.json({ error: msg }, { status: res.status === 400 ? 400 : 500 });
  }

  if (body.phone && data.user?.documentId && process.env.STRAPI_API_TOKEN) {
    try {
      await fetch(`${base.replace(/\/$/, "")}/api/users/${data.user.documentId}`, {
        method: "PUT",
        headers: {
          "Content-Type": "application/json",
          Authorization: `Bearer ${process.env.STRAPI_API_TOKEN}`,
        },
        body: JSON.stringify({ phone: body.phone }),
      });
    } catch {
      /* ignore */
    }
  }

  await sendRawEmail({
    to: email,
    subject: "Welcome to The Blissful Soul",
    html: `<p>Welcome${body.name ? `, ${body.name}` : ""}! You can now sign in at your account page.</p>`,
    templateName: "WelcomeEmail",
  });
  return NextResponse.json({ ok: true });
}
