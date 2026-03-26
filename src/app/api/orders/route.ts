import { NextResponse } from "next/server";
import { getServerSession } from "next-auth";
import { authOptions } from "@/lib/auth";
import { prisma } from "@/lib/prisma";

export async function GET() {
  const session = await getServerSession(authOptions);
  if (!session?.user?.id) return NextResponse.json({ error: "Unauthorized" }, { status: 401 });
  const orders = await prisma.order.findMany({
    where: { userId: session.user.id },
    orderBy: { createdAt: "desc" },
    include: { items: { include: { product: true } }, invoice: true },
    take: 50,
  });
  return NextResponse.json({
    orders: orders.map((o) => ({
      id: o.id,
      status: o.status,
      paymentStatus: o.paymentStatus,
      total: o.total,
      createdAt: o.createdAt,
      items: o.items.map((i) => ({ name: i.product.name, quantity: i.quantity, unitPrice: i.unitPrice })),
      invoiceNumber: o.invoice?.invoiceNumber,
    })),
  });
}
