import { getServerSession } from "next-auth";
import { authOptions } from "@/lib/auth";
import { prisma } from "@/lib/prisma";
import { getCartSessionIdFromCookies } from "@/lib/cart-session";

export type CartOwner =
  | { kind: "user"; userId: string }
  | { kind: "guest"; sessionId: string };

export async function resolveCartOwner(): Promise<CartOwner | null> {
  const session = await getServerSession(authOptions);
  if (session?.user?.id) return { kind: "user", userId: session.user.id };
  const sid = getCartSessionIdFromCookies();
  if (sid) return { kind: "guest", sessionId: sid };
  return null;
}

export function cartWhere(owner: CartOwner) {
  if (owner.kind === "user") return { userId: owner.userId };
  return { sessionId: owner.sessionId };
}

export async function loadCartItems(owner: CartOwner) {
  return prisma.cartItem.findMany({
    where: cartWhere(owner),
    include: { product: { include: { category: true, shippingClass: true, variants: true } } },
    orderBy: { id: "asc" },
  });
}
