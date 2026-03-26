import Razorpay from "razorpay";
import crypto from "crypto";

function getClient() {
  const key_id = process.env.RAZORPAY_KEY_ID;
  const key_secret = process.env.RAZORPAY_KEY_SECRET;
  if (!key_id || !key_secret) return null;
  return new Razorpay({ key_id, key_secret });
}

export function createRzpOrder(amountPaise: number, receipt: string, notes?: Record<string, string>) {
  const rzp = getClient();
  if (!rzp) throw new Error("Razorpay not configured");
  return rzp.orders.create({
    amount: amountPaise,
    currency: "INR",
    receipt: receipt.slice(0, 40),
    notes: notes ?? {},
  });
}

export function verifySignature(orderId: string, paymentId: string, signature: string) {
  const secret = process.env.RAZORPAY_KEY_SECRET;
  if (!secret) return false;
  const body = `${orderId}|${paymentId}`;
  const expected = crypto.createHmac("sha256", secret).update(body).digest("hex");
  return expected === signature;
}

export async function fetchPaymentDetails(paymentId: string) {
  const rzp = getClient();
  if (!rzp) return null;
  return rzp.payments.fetch(paymentId);
}

export async function initiateRefund(paymentId: string, amountPaise?: number) {
  const rzp = getClient();
  if (!rzp) throw new Error("Razorpay not configured");
  const payload = amountPaise != null ? { amount: amountPaise } : {};
  return rzp.payments.refund(paymentId, payload);
}
