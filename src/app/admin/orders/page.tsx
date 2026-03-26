import Link from "next/link";
import { prisma } from "@/lib/prisma";
import { formatINR } from "@/lib/utils";

export default async function AdminOrdersPage() {
  const orders = await prisma.order.findMany({
    orderBy: { createdAt: "desc" },
    take: 50,
    include: { user: { select: { email: true, name: true } } },
  });
  return (
    <div>
      <h1 className="font-serif text-2xl font-bold text-primary">Orders</h1>
      <table className="mt-6 w-full text-left text-sm">
        <thead>
          <tr className="border-b">
            <th className="py-2">ID</th>
            <th className="py-2">Customer</th>
            <th className="py-2">Payment</th>
            <th className="py-2">Total</th>
            <th className="py-2" />
          </tr>
        </thead>
        <tbody>
          {orders.map((o) => (
            <tr key={o.id} className="border-b">
              <td className="py-2 font-mono text-xs">{o.id.slice(0, 12)}…</td>
              <td className="py-2">
                {o.user ? (o.user.name ?? o.user.email) : [o.guestName, o.guestEmail].filter(Boolean).join(" · ") || "—"}
              </td>
              <td className="py-2">{o.paymentStatus}</td>
              <td className="py-2">{formatINR(o.total)}</td>
              <td className="py-2">
                <Link href={`/admin/orders/${o.id}`} className="text-primary hover:underline">
                  Detail
                </Link>
              </td>
            </tr>
          ))}
        </tbody>
      </table>
    </div>
  );
}
