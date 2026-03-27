import { NextResponse } from "next/server";
import crypto from "crypto";
import { strapiFetch, unwrapList } from "@/lib/strapi";

export async function POST(req: Request) {
  const secret = process.env.RAZORPAY_WEBHOOK_SECRET;
  const body = await req.text();
  const sig = req.headers.get("x-razorpay-signature");
  if (!secret || !sig) return NextResponse.json({ error: "Unauthorized" }, { status: 401 });
  const expected = crypto.createHmac("sha256", secret).update(body).digest("hex");
  if (expected !== sig) return NextResponse.json({ error: "Bad signature" }, { status: 400 });

  const event = JSON.parse(body) as {
    event?: string;
    payload?: { payment?: { entity?: { id?: string; order_id?: string; status?: string } } };
  };
  if (event.event === "payment.captured" && event.payload?.payment?.entity) {
    const p = event.payload.payment.entity;
    const rzpOrderId = p.order_id;
    if (rzpOrderId) {
      try {
        const json = await strapiFetch<{ data?: unknown[] }>(
          `/api/orders?filters[rzpOrderId][$eq]=${encodeURIComponent(rzpOrderId)}&filters[paymentStatus][$eq]=PENDING&pagination[pageSize]=1`
        );
        const rows = unwrapList(json);
        const doc = rows[0] as { documentId?: string } | undefined;
        if (doc?.documentId) {
          await strapiFetch(`/api/orders/${doc.documentId}`, {
            method: "PUT",
            body: JSON.stringify({
              data: {
                paymentStatus: "PAID",
                status: "PROCESSING",
                rzpPaymentId: p.id,
              },
            }),
          });
        }
      } catch {
        /* ignore */
      }
    }
  }
  return NextResponse.json({ received: true });
}
