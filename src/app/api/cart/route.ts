import { NextResponse } from "next/server";
import { getServerSession } from "next-auth";
import { authOptions } from "@/lib/auth";
import { prisma } from "@/lib/prisma";
import { attachCartCookie, CART_COOKIE, newCartSessionId } from "@/lib/cart-session";
import { loadCartItems } from "@/lib/cart-query";
import { effectiveUnitPrice, buildPromoSummary, type CartLine } from "@/lib/promo-engine";
import { computeShippingForPhysicalItems, cartHasPhysical } from "@/lib/shipping";

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
  const giftProduct = await prisma.product.findUnique({ where: { slug: "money-potli-gift" } });
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

  const product = await prisma.product.findUnique({ where: { id: body.productId } });
  if (!product || !product.isActive) return NextResponse.json({ error: "Product not found" }, { status: 404 });
  if (product.stock < body.quantity && product.productType === "PHYSICAL") {
    return NextResponse.json({ error: "Insufficient stock" }, { status: 400 });
  }

  const existing = await prisma.cartItem.findFirst({
    where: userId ? { userId, productId: body.productId } : { sessionId: sessionId!, productId: body.productId },
  });

  if (existing) {
    await prisma.cartItem.update({
      where: { id: existing.id },
      data: { quantity: existing.quantity + body.quantity, variantSelection: body.variantSelection as object | undefined },
    });
  } else {
    await prisma.cartItem.create({
      data: {
        userId: userId ?? undefined,
        sessionId: userId ? undefined : sessionId!,
        productId: body.productId,
        quantity: body.quantity,
        variantSelection: body.variantSelection as object | undefined,
      },
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

  const item = await prisma.cartItem.findUnique({ where: { id: body.itemId } });
  if (!item) return NextResponse.json({ error: "Not found" }, { status: 404 });
  if (userId && item.userId !== userId) return NextResponse.json({ error: "Forbidden" }, { status: 403 });
  if (!userId && item.sessionId !== sessionId) return NextResponse.json({ error: "Forbidden" }, { status: 403 });

  if (body.quantity <= 0) {
    await prisma.cartItem.delete({ where: { id: body.itemId } });
  } else {
    await prisma.cartItem.update({ where: { id: body.itemId }, data: { quantity: body.quantity } });
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
  const item = await prisma.cartItem.findUnique({ where: { id: itemId } });
  if (!item) return NextResponse.json({ error: "Not found" }, { status: 404 });
  if (userId && item.userId !== userId) return NextResponse.json({ error: "Forbidden" }, { status: 403 });
  if (!userId && item.sessionId !== sessionId) return NextResponse.json({ error: "Forbidden" }, { status: 403 });
  await prisma.cartItem.delete({ where: { id: itemId } });
  const owner = userId
    ? { kind: "user" as const, userId }
    : { kind: "guest" as const, sessionId: sessionId! };
  const items = await loadCartItems(owner);
  const summary = await summarizeCart(items);
  return json({ items: serializeItems(items), summary });
}
