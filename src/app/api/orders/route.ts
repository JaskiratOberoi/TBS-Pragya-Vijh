import { NextResponse } from "next/server";
import { getServerSession } from "next-auth";
import { authOptions } from "@/lib/auth";
import { strapiFetch, normalizeDoc } from "@/lib/strapi";

export async function GET() {
  const session = await getServerSession(authOptions);
  if (!session?.user?.id) return NextResponse.json({ error: "Unauthorized" }, { status: 401 });
  const j = await strapiFetch<{ data?: unknown[] }>(
    `/api/orders?filters[user][documentId][$eq]=${encodeURIComponent(session.user.id)}&populate[items][populate][product]=true&populate[invoice]=true&sort[0]=createdAt:desc&pagination[pageSize]=50`
  );
  const orders = (j.data ?? []).map((x) => normalizeDoc(x)) as Array<{
    documentId?: string;
    id?: string;
    status?: string;
    paymentStatus?: string;
    total?: number;
    createdAt?: string;
    items?: Array<{ quantity?: number; product?: { name?: string }; unitPrice?: number }>;
    invoice?: { invoiceNumber?: string };
  }>;
  return NextResponse.json({
    orders: orders.map((o) => ({
      id: String(o.documentId ?? o.id),
      status: o.status,
      paymentStatus: o.paymentStatus,
      total: o.total,
      createdAt: o.createdAt,
      items: (o.items ?? []).map((i) => ({
        name: i.product?.name ?? "",
        quantity: i.quantity,
        unitPrice: i.unitPrice,
      })),
      invoiceNumber: o.invoice?.invoiceNumber,
    })),
  });
}
