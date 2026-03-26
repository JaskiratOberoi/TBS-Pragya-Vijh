import { NextResponse } from "next/server";
import { getServerSession } from "next-auth";
import { authOptions } from "@/lib/auth";
import { prisma } from "@/lib/prisma";
import { CART_COOKIE } from "@/lib/cart-session";

export async function POST(req: Request) {
  const session = await getServerSession(authOptions);
  if (!session?.user?.id) return NextResponse.json({ error: "Unauthorized" }, { status: 401 });
  const cookieHeader = req.headers.get("cookie") ?? "";
  const match = cookieHeader.match(new RegExp(`${CART_COOKIE}=([^;]+)`));
  const sessionId = match?.[1] ? decodeURIComponent(match[1]) : null;
  if (!sessionId) return NextResponse.json({ ok: true });

  const guestItems = await prisma.cartItem.findMany({ where: { sessionId } });
  for (const g of guestItems) {
    const existing = await prisma.cartItem.findFirst({
      where: { userId: session.user.id, productId: g.productId },
    });
    if (existing) {
      await prisma.cartItem.update({
        where: { id: existing.id },
        data: { quantity: existing.quantity + g.quantity },
      });
      await prisma.cartItem.delete({ where: { id: g.id } });
    } else {
      await prisma.cartItem.update({
        where: { id: g.id },
        data: { userId: session.user.id, sessionId: null },
      });
    }
  }

  const res = NextResponse.json({ ok: true });
  res.cookies.set(CART_COOKIE, "", { maxAge: 0, path: "/" });
  return res;
}
