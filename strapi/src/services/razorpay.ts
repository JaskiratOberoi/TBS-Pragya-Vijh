import crypto from "node:crypto";
import Razorpay from "razorpay";

export function verifyRzpSignature(orderId: string, paymentId: string, signature: string): boolean {
  const secret = process.env.RAZORPAY_KEY_SECRET;
  if (!secret) return false;
  const body = `${orderId}|${paymentId}`;
  const expected = crypto.createHmac("sha256", secret).update(body).digest("hex");
  return expected === signature;
}

export async function fetchPaymentDetails(paymentId: string): Promise<unknown | null> {
  const key = process.env.RAZORPAY_KEY_ID;
  const secret = process.env.RAZORPAY_KEY_SECRET;
  if (!key || !secret) return null;
  const rzp = new Razorpay({ key_id: key, key_secret: secret });
  return rzp.payments.fetch(paymentId);
}
