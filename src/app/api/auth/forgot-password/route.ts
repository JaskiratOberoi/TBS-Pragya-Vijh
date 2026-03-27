import { NextResponse } from "next/server";
import { randomBytes } from "crypto";
import { strapiFetch, normalizeDoc } from "@/lib/strapi";
import { sendRawEmail } from "@/lib/email";

export async function POST(req: Request) {
  const body = (await req.json()) as { email?: string };
  if (!body.email) return NextResponse.json({ ok: true });
  const email = body.email.toLowerCase().trim();
  const usersRes = await strapiFetch<{ data?: unknown[] }>(
    `/api/users?filters[email][$eq]=${encodeURIComponent(email)}&pagination[pageSize]=1`
  );
  const uRaw = usersRes.data?.[0];
  if (!uRaw) return NextResponse.json({ ok: true });
  const user = normalizeDoc(uRaw) as { documentId?: string; id?: string; email?: string };
  const userDocId = String(user.documentId ?? user.id);

  const existing = await strapiFetch<{ data?: unknown[] }>(
    `/api/password-reset-tokens?filters[user][documentId][$eq]=${encodeURIComponent(userDocId)}&pagination[pageSize]=50`
  );
  for (const x of existing.data ?? []) {
    const d = normalizeDoc(x);
    await strapiFetch(`/api/password-reset-tokens/${String(d.documentId ?? d.id)}`, { method: "DELETE" });
  }

  const token = randomBytes(32).toString("hex");
  const expiresAt = new Date(Date.now() + 60 * 60 * 1000).toISOString();
  await strapiFetch(`/api/password-reset-tokens`, {
    method: "POST",
    body: JSON.stringify({
      data: {
        token,
        expiresAt,
        user: { connect: [userDocId] },
      },
    }),
  });
  const base = process.env.NEXTAUTH_URL ?? "http://localhost:3000";
  const link = `${base}/account/reset-password?token=${token}`;
  await sendRawEmail({
    to: user.email ?? email,
    subject: "Reset your password",
    html: `<p>Click to reset: <a href="${link}">${link}</a> (expires in 1 hour)</p>`,
    templateName: "PasswordReset",
  });
  return NextResponse.json({ ok: true });
}
