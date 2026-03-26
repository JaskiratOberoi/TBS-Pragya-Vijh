import { NextResponse } from "next/server";
import { getServerSession } from "next-auth";
import { authOptions } from "@/lib/auth";
import { prisma } from "@/lib/prisma";

export async function GET() {
  const session = await getServerSession(authOptions);
  if (!session?.user?.id) return NextResponse.json({ items: [] });
  const items = await prisma.wishlistItem.findMany({
    where: { userId: session.user.id },
    include: { product: true },
  });
  return NextResponse.json({
    items: items.map((w) => ({
      id: w.id,
      product: {
        id: w.product.id,
        name: w.product.name,
        slug: w.product.slug,
        price: w.product.price,
        salePrice: w.product.salePrice,
        images: w.product.images,
        productType: w.product.productType,
      },
    })),
  });
}

export async function POST(req: Request) {
  const session = await getServerSession(authOptions);
  if (!session?.user?.id) return NextResponse.json({ error: "Login required" }, { status: 401 });
  const body = (await req.json()) as { productId?: string };
  if (!body.productId) return NextResponse.json({ error: "productId required" }, { status: 400 });
  await prisma.wishlistItem.upsert({
    where: { userId_productId: { userId: session.user.id, productId: body.productId } },
    create: { userId: session.user.id, productId: body.productId },
    update: {},
  });
  return NextResponse.json({ ok: true });
}

export async function DELETE(req: Request) {
  const session = await getServerSession(authOptions);
  if (!session?.user?.id) return NextResponse.json({ error: "Login required" }, { status: 401 });
  const id = new URL(req.url).searchParams.get("id");
  const productId = new URL(req.url).searchParams.get("productId");
  if (id) {
    const row = await prisma.wishlistItem.findUnique({ where: { id } });
    if (row?.userId !== session.user.id) return NextResponse.json({ error: "Forbidden" }, { status: 403 });
    await prisma.wishlistItem.delete({ where: { id } });
  } else if (productId) {
    await prisma.wishlistItem.deleteMany({ where: { userId: session.user.id, productId } });
  } else return NextResponse.json({ error: "id or productId" }, { status: 400 });
  return NextResponse.json({ ok: true });
}
