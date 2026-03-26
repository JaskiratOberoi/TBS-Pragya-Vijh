import { prisma } from "@/lib/prisma";
import { formatINR } from "@/lib/utils";
import Link from "next/link";

export default async function AdminHomePage() {
  const start = new Date();
  start.setHours(0, 0, 0, 0);
  const [todayRev, ordersToday, pendingBookings, recentOrders] = await Promise.all([
    prisma.order.aggregate({
      where: { createdAt: { gte: start }, paymentStatus: "PAID" },
      _sum: { total: true },
    }),
    prisma.order.count({ where: { createdAt: { gte: start } } }),
    prisma.booking.count({ where: { status: "PENDING" } }),
    prisma.order.findMany({
      orderBy: { createdAt: "desc" },
      take: 8,
      include: { user: { select: { email: true, name: true } } },
    }),
  ]);

  return (
    <div>
      <h1 className="font-serif text-2xl font-bold text-primary">Dashboard</h1>
      <div className="mt-8 grid gap-4 sm:grid-cols-3">
        <div className="rounded-lg border p-4">
          <p className="text-sm text-muted-foreground">Today revenue (paid)</p>
          <p className="text-2xl font-semibold text-primary">{formatINR(todayRev._sum.total ?? 0)}</p>
        </div>
        <div className="rounded-lg border p-4">
          <p className="text-sm text-muted-foreground">Orders today</p>
          <p className="text-2xl font-semibold">{ordersToday}</p>
        </div>
        <div className="rounded-lg border p-4">
          <p className="text-sm text-muted-foreground">Pending bookings</p>
          <p className="text-2xl font-semibold">{pendingBookings}</p>
        </div>
      </div>
      <h2 className="mt-10 font-semibold">Recent orders</h2>
      <ul className="mt-4 divide-y rounded-lg border">
        {recentOrders.map((o) => (
          <li key={o.id} className="flex flex-wrap justify-between gap-2 px-4 py-3 text-sm">
            <span className="font-mono text-xs">{o.id.slice(0, 10)}…</span>
            <span>
              {o.user ? (o.user.name ?? o.user.email) : [o.guestName, o.guestEmail].filter(Boolean).join(" · ") || "—"}
            </span>
            <span>{o.paymentStatus}</span>
            <span>{formatINR(o.total)}</span>
            <Link href={`/admin/orders/${o.id}`} className="text-primary hover:underline">
              View
            </Link>
          </li>
        ))}
      </ul>
    </div>
  );
}
