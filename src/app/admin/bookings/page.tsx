import { prisma } from "@/lib/prisma";
import { formatINR } from "@/lib/utils";

export default async function AdminBookingsPage() {
  const bookings = await prisma.booking.findMany({
    orderBy: { scheduledAt: "desc" },
    take: 50,
    include: { user: { select: { email: true, name: true } }, service: true },
  });
  return (
    <div>
      <h1 className="font-serif text-2xl font-bold text-primary">Bookings</h1>
      <table className="mt-6 w-full text-left text-sm">
        <thead>
          <tr className="border-b">
            <th className="py-2">When</th>
            <th className="py-2">Service</th>
            <th className="py-2">Customer</th>
            <th className="py-2">Status</th>
            <th className="py-2">Paid</th>
          </tr>
        </thead>
        <tbody>
          {bookings.map((b) => (
            <tr key={b.id} className="border-b">
              <td className="py-2">{new Date(b.scheduledAt).toLocaleString("en-IN")}</td>
              <td className="py-2">{b.service.name}</td>
              <td className="py-2">
                {b.user ? (b.user.name ?? b.user.email) : [b.guestName, b.guestEmail].filter(Boolean).join(" · ") || "—"}
              </td>
              <td className="py-2">{b.status}</td>
              <td className="py-2">{formatINR(b.amountPaid)}</td>
            </tr>
          ))}
        </tbody>
      </table>
    </div>
  );
}
