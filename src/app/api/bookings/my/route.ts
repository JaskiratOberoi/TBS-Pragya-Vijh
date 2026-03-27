import { NextResponse } from "next/server";
import { getServerSession } from "next-auth";
import { authOptions } from "@/lib/auth";
import { strapiFetch, normalizeDoc } from "@/lib/strapi";

export async function GET() {
  const session = await getServerSession(authOptions);
  if (!session?.user?.id) return NextResponse.json({ error: "Unauthorized" }, { status: 401 });
  const j = await strapiFetch<{ data?: unknown[] }>(
    `/api/bookings?filters[user][documentId][$eq]=${encodeURIComponent(session.user.id)}&populate[service]=true&sort[0]=scheduledAt:desc&pagination[pageSize]=50`
  );
  const bookings = (j.data ?? []).map((x) => normalizeDoc(x)) as Array<{
    documentId?: string;
    id?: string;
    status?: string;
    paymentStatus?: string;
    scheduledAt?: string;
    endAt?: string;
    amountPaid?: number;
    service?: { name?: string; type?: string };
  }>;
  return NextResponse.json({
    bookings: bookings.map((b) => ({
      id: String(b.documentId ?? b.id),
      status: b.status,
      paymentStatus: b.paymentStatus,
      scheduledAt: b.scheduledAt,
      endAt: b.endAt,
      service: { name: b.service?.name ?? "", type: b.service?.type ?? "" },
      amountPaid: b.amountPaid,
    })),
  });
}
