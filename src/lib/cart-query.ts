import { getServerSession } from "next-auth";
import { authOptions } from "@/lib/auth";
import { getCartSessionIdFromCookies } from "@/lib/cart-session";
import { strapiFetch, unwrapList, normalizeDoc } from "@/lib/strapi";
import type { ProductLike } from "@/lib/types/commerce";

export type CartOwner =
  | { kind: "user"; userId: string }
  | { kind: "guest"; sessionId: string };

export type CartRow = {
  id: string;
  productId: string;
  quantity: number;
  variantSelection: unknown;
  product: ProductLike & {
    category?: { name?: string; slug?: string };
    images?: unknown;
    variants?: unknown[];
  };
};

const POP =
  "populate[product][populate][category]=true&populate[product][populate][shippingClass]=true&populate[product][populate][variants]=true";

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

export async function loadCartItems(owner: CartOwner): Promise<CartRow[]> {
  const filter =
    owner.kind === "user"
      ? `filters[user][documentId][$eq]=${encodeURIComponent(owner.userId)}`
      : `filters[sessionId][$eq]=${encodeURIComponent(owner.sessionId)}`;
  const j = await strapiFetch<{ data?: unknown[] }>(`/api/cart-items?${filter}&${POP}&pagination[pageSize]=100&sort=id:asc`);
  const rows = unwrapList(j) as Record<string, unknown>[];
  return rows.map((row) => {
    const rawP = row.product as Record<string, unknown> | undefined;
    const prod =
      rawP && "data" in rawP && rawP.data
        ? normalizeDoc(rawP.data)
        : rawP
          ? normalizeDoc(rawP)
          : {};
    const p = prod as CartRow["product"];
    const pid = String(p.id ?? p.documentId ?? row.productId ?? "");
    return {
      id: String(row.id ?? row.documentId),
      productId: pid,
      quantity: Number(row.quantity ?? 1),
      variantSelection: row.variantSelection,
      product: p,
    };
  });
}
