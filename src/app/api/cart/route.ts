import { NextResponse } from "next/server";
import { getServerSession } from "next-auth";
import { authOptions } from "@/lib/auth";
import { strapiFetch } from "@/lib/strapi";
import { attachCartCookie, CART_COOKIE, newCartSessionId } from "@/lib/cart-session";
import { loadCartItems } from "@/lib/cart-query";
import { effectiveUnitPrice, buildPromoSummary, type CartLine } from "@/lib/promo-engine";
import { computeShippingForPhysicalItems, cartHasPhysical } from "@/lib/shipping";
import { findProductByDocumentId, findProductBySlug } from "@/lib/strapi-queries";
import { normalizeDoc } from "@/lib/strapi";

async function getOwner(req: Request) {
  const session = await getServerSession(authOptions);
  if (session?.user?.id) return { kind: "user" as const, userId: session.user.id };
  const cookieHeader = req.headers.get("cookie") ?? "";
  const match = cookieHeader.match(new RegExp(`${CART_COOKIE}=([^;]+)`));
  const sid = match?.[1];
  if (sid) return { kind: "guest" as const, sessionId: decodeURIComponent(sid) };
  return { kind: "guest" as const, sessionId: null as string | null };
}

function json(data: unknown, init?: ResponseInit, setSid?: string) {
  const res = NextResponse.json(data, init);
  if (setSid) attachCartCookie(res, setSid);
  return res;
}

export async function GET(req: Request) {
  const owner = await getOwner(req);
  if (owner.kind === "guest" && !owner.sessionId) {
    return json({ items: [], summary: emptySummary() });
  }
  const items = await loadCartItems(
    owner.kind === "user" ? { kind: "user", userId: owner.userId } : { kind: "guest", sessionId: owner.sessionId! }
  );
  const summary = await summarizeCart(items);
  return json({ items: serializeItems(items), summary });
}

function emptySummary() {
  return {
    subtotalPaise: 0,
    promoDiscountPaise: 0,
    shippingPaise: 0,
    taxPaise: 0,
    totalPaise: 0,
    giftLines: [] as { productId: string; name: string }[],
  };
}

async function summarizeCart(
  items: Awaited<ReturnType<typeof loadCartItems>>
) {
  if (items.length === 0) return emptySummary();
  const giftProduct = await findProductBySlug("money-potli-gift");
  const threshold = 149900; // ₹1499
  const lines: CartLine[] = items.map((i) => ({
    productId: i.productId,
    slug: i.product.slug,
    quantity: i.quantity,
    unitPricePaise: effectiveUnitPrice(i.product),
    productType: i.product.productType,
  }));
  const promo = buildPromoSummary(lines, {
    thresholdPaise: threshold,
    giftProductId: giftProduct?.id ?? "",
    giftUnitPricePaise: giftProduct ? effectiveUnitPrice(giftProduct) : 0,
  });
  const subAfterPromo = promo.subtotalPaise - promo.buyXGetYDiscountPaise;
  const shipping = computeShippingForPhysicalItems(items, subAfterPromo);
  const hasPhysical = cartHasPhysical(items);
  const ship = hasPhysical ? shipping : 0;
  const taxable = subAfterPromo + ship;
  const tax = Math.round((taxable * 300) / 10000); // simplified 3% GST demo — real per-line in checkout
  const total = taxable + tax;
  return {
    subtotalPaise: promo.subtotalPaise,
    promoDiscountPaise: promo.buyXGetYDiscountPaise,
    shippingPaise: ship,
    taxPaise: tax,
    totalPaise: total,
    giftLines: promo.giftLines.map((g) => ({
      productId: g.productId,
      name: giftProduct?.name ?? "Gift",
    })),
  };
}

function serializeItems(items: Awaited<ReturnType<typeof loadCartItems>>) {
  return items.map((i) => ({
    id: i.id,
    productId: i.productId,
    quantity: i.quantity,
    variantSelection: i.variantSelection,
    product: {
      name: i.product.name,
      slug: i.product.slug,
      images: i.product.images,
      price: i.product.price,
      salePrice: i.product.salePrice,
      productType: i.product.productType,
      stock: i.product.stock,
    },
  }));
}

async function findExistingCartItem(opts: {
  userId: string | null;
  sessionId: string | null;
  productDocumentId: string;
}): Promise<{ documentId: string; quantity: number } | null> {
  const { userId, sessionId, productDocumentId } = opts;
  const filter = userId
    ? `filters[user][documentId][$eq]=${encodeURIComponent(userId)}&filters[product][documentId][$eq]=${encodeURIComponent(productDocumentId)}`
    : `filters[sessionId][$eq]=${encodeURIComponent(sessionId!)}&filters[product][documentId][$eq]=${encodeURIComponent(productDocumentId)}`;
  const j = await strapiFetch<{ data?: unknown[] }>(`/api/cart-items?${filter}&pagination[pageSize]=1`);
  const first = j.data?.[0];
  if (!first) return null;
  const d = normalizeDoc(first);
  return { documentId: String(d.documentId ?? d.id), quantity: Number(d.quantity ?? 1) };
}

export async function POST(req: Request) {
  const body = (await req.json()) as { productId?: string; quantity?: number; variantSelection?: unknown };
  if (!body.productId || !body.quantity || body.quantity < 1) {
    return NextResponse.json({ error: "Invalid body" }, { status: 400 });
  }
  const session = await getServerSession(authOptions);
  let sessionId: string | null = null;
  let userId: string | null = session?.user?.id ?? null;
  if (!userId) {
    const cookieHeader = req.headers.get("cookie") ?? "";
    const match = cookieHeader.match(new RegExp(`${CART_COOKIE}=([^;]+)`));
    sessionId = match?.[1] ? decodeURIComponent(match[1]) : null;
    if (!sessionId) sessionId = newCartSessionId();
  }

  const product = await findProductByDocumentId(body.productId);
  if (!product || product.isActive === false) return NextResponse.json({ error: "Product not found" }, { status: 404 });
  if ((product.stock ?? 0) < body.quantity && product.productType === "PHYSICAL") {
    return NextResponse.json({ error: "Insufficient stock" }, { status: 400 });
  }

  const existing = await findExistingCartItem({
    userId,
    sessionId: userId ? null : sessionId,
    productDocumentId: body.productId,
  });

  if (existing) {
    await strapiFetch(`/api/cart-items/${existing.documentId}`, {
      method: "PUT",
      body: JSON.stringify({
        data: {
          quantity: existing.quantity + body.quantity,
          variantSelection: body.variantSelection ?? null,
        },
      }),
    });
  } else {
    const data: Record<string, unknown> = {
      quantity: body.quantity,
      variantSelection: body.variantSelection ?? null,
      product: { connect: [body.productId] },
    };
    if (userId) data.user = { connect: [userId] };
    else data.sessionId = sessionId;
    await strapiFetch(`/api/cart-items`, {
      method: "POST",
      body: JSON.stringify({ data }),
    });
  }

  const owner = userId
    ? { kind: "user" as const, userId }
    : { kind: "guest" as const, sessionId: sessionId! };
  const items = await loadCartItems(owner);
  const summary = await summarizeCart(items);
  return json({ items: serializeItems(items), summary }, undefined, userId ? undefined : sessionId!);
}

export async function PATCH(req: Request) {
  const body = (await req.json()) as { itemId?: string; quantity?: number };
  if (!body.itemId || body.quantity == null) return NextResponse.json({ error: "Invalid" }, { status: 400 });
  const session = await getServerSession(authOptions);
  const cookieHeader = req.headers.get("cookie") ?? "";
  const match = cookieHeader.match(new RegExp(`${CART_COOKIE}=([^;]+)`));
  const sessionId = match?.[1] ? decodeURIComponent(match[1]) : null;
  const userId = session?.user?.id ?? null;

  const itemRes = await strapiFetch<{ data?: unknown }>(`/api/cart-items/${body.itemId}?populate=user`);
  const item = itemRes.data ? normalizeDoc(itemRes.data) : null;
  if (!item) return NextResponse.json({ error: "Not found" }, { status: 404 });

  const itemUser = item.user as { documentId?: string } | undefined;
  const itemSession = item.sessionId as string | undefined;
  if (userId && itemUser?.documentId !== userId) return NextResponse.json({ error: "Forbidden" }, { status: 403 });
  if (!userId && itemSession !== sessionId) return NextResponse.json({ error: "Forbidden" }, { status: 403 });

  if (body.quantity <= 0) {
    await strapiFetch(`/api/cart-items/${body.itemId}`, { method: "DELETE" });
  } else {
    await strapiFetch(`/api/cart-items/${body.itemId}`, {
      method: "PUT",
      body: JSON.stringify({ data: { quantity: body.quantity } }),
    });
  }

  const owner = userId
    ? { kind: "user" as const, userId }
    : { kind: "guest" as const, sessionId: sessionId! };
  const items = await loadCartItems(owner);
  const summary = await summarizeCart(items);
  return json({ items: serializeItems(items), summary });
}

export async function DELETE(req: Request) {
  const { searchParams } = new URL(req.url);
  const itemId = searchParams.get("itemId");
  if (!itemId) return NextResponse.json({ error: "itemId required" }, { status: 400 });
  const session = await getServerSession(authOptions);
  const cookieHeader = req.headers.get("cookie") ?? "";
  const match = cookieHeader.match(new RegExp(`${CART_COOKIE}=([^;]+)`));
  const sessionId = match?.[1] ? decodeURIComponent(match[1]) : null;
  const userId = session?.user?.id ?? null;

  const itemRes = await strapiFetch<{ data?: unknown }>(`/api/cart-items/${itemId}?populate=user`);
  const item = itemRes.data ? normalizeDoc(itemRes.data) : null;
  if (!item) return NextResponse.json({ error: "Not found" }, { status: 404 });
  const itemUser = item.user as { documentId?: string } | undefined;
  const itemSession = item.sessionId as string | undefined;
  if (userId && itemUser?.documentId !== userId) return NextResponse.json({ error: "Forbidden" }, { status: 403 });
  if (!userId && itemSession !== sessionId) return NextResponse.json({ error: "Forbidden" }, { status: 403 });

  await strapiFetch(`/api/cart-items/${itemId}`, { method: "DELETE" });
  const owner = userId
    ? { kind: "user" as const, userId }
    : { kind: "guest" as const, sessionId: sessionId! };
  const items = await loadCartItems(owner);
  const summary = await summarizeCart(items);
  return json({ items: serializeItems(items), summary });
}
