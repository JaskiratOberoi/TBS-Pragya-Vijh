import { NextResponse } from "next/server";
import { prisma } from "@/lib/prisma";
import { getServerSession } from "next-auth";
import { authOptions } from "@/lib/auth";

export async function GET(_req: Request, { params }: { params: Promise<{ slug: string }> }) {
  const { slug } = await params;
  const product = await prisma.product.findUnique({ where: { slug } });
  if (!product) return NextResponse.json({ error: "Not found" }, { status: 404 });
  const reviews = await prisma.review.findMany({
    where: { productId: product.id },
    include: { user: { select: { name: true } } },
    orderBy: { createdAt: "desc" },
    take: 50,
  });
  return NextResponse.json({
    reviews: reviews.map((r) => ({
      id: r.id,
      rating: r.rating,
      comment: r.comment,
      createdAt: r.createdAt,
      author: r.user.name ?? "Customer",
    })),
  });
}

export async function POST(req: Request, { params }: { params: Promise<{ slug: string }> }) {
  const session = await getServerSession(authOptions);
  if (!session?.user?.id) return NextResponse.json({ error: "Login required" }, { status: 401 });
  const { slug } = await params;
  const product = await prisma.product.findUnique({ where: { slug } });
  if (!product) return NextResponse.json({ error: "Not found" }, { status: 404 });
  const body = (await req.json()) as { rating?: number; comment?: string };
  if (!body.rating || body.rating < 1 || body.rating > 5 || !body.comment) {
    return NextResponse.json({ error: "Invalid review" }, { status: 400 });
  }
  await prisma.review.create({
    data: {
      userId: session.user.id,
      productId: product.id,
      rating: body.rating,
      comment: body.comment,
    },
  });
  return NextResponse.json({ ok: true });
}
