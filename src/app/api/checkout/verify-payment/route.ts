import { NextResponse } from "next/server";
import { cookies } from "next/headers";
import { commerceVerifyPayment } from "@/lib/strapi";
import { CART_COOKIE } from "@/lib/cart-session";

export async function POST(req: Request) {
  const body = (await req.json()) as {
    orderId?: string;
    rzpOrderId?: string;
    rzpPaymentId?: string;
    rzpSignature?: string;
  };
  if (!body.orderId || !body.rzpOrderId || !body.rzpPaymentId || !body.rzpSignature) {
    return NextResponse.json({ error: "Missing fields" }, { status: 400 });
  }

  const cookieStore = cookies();
  const rawSid = cookieStore.get(CART_COOKIE)?.value;
  const sessionId = rawSid ? decodeURIComponent(rawSid) : undefined;

  try {
    const result = await commerceVerifyPayment({
      orderId: body.orderId,
      rzpOrderId: body.rzpOrderId,
      rzpPaymentId: body.rzpPaymentId,
      rzpSignature: body.rzpSignature,
      sessionId,
    });
    return NextResponse.json(result);
  } catch (e) {
    const msg = e instanceof Error ? e.message : "Verification failed";
    const low = msg.toLowerCase();
    const status =
      low.includes("401") || low.includes("unauthorized")
        ? 401
        : low.includes("404") || low.includes("not found")
          ? 404
          : low.includes("400") || low.includes("invalid") || low.includes("mismatch") || low.includes("missing")
            ? 400
            : 500;
    return NextResponse.json({ error: msg }, { status });
  }
}
