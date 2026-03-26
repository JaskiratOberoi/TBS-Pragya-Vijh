import { NextResponse } from "next/server";
import { requireAdmin } from "@/lib/api-auth";
import { prisma } from "@/lib/prisma";

export async function GET() {
  const gate = await requireAdmin();
  if ("error" in gate) return gate.error;

  const start = new Date();
  start.setHours(0, 0, 0, 0);

  const [todayOrders, customers, pendingBookings, revenueAgg] = await Promise.all([
    prisma.order.count({ where: { createdAt: { gte: start }, paymentStatus: "PAID" } }),
    prisma.user.count({ where: { role: "USER" } }),
    prisma.booking.count({ where: { status: "PENDING" } }),
    prisma.order.aggregate({
      where: { createdAt: { gte: start }, paymentStatus: "PAID" },
      _sum: { total: true },
    }),
  ]);

  return NextResponse.json({
    todayOrders,
    customers,
    pendingBookings,
    todayRevenuePaise: revenueAgg._sum.total ?? 0,
  });
}
