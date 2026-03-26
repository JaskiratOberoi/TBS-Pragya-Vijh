import { notFound } from "next/navigation";
import { prisma } from "@/lib/prisma";
import { formatINR } from "@/lib/utils";

export default async function AdminOrderDetailPage({ params }: { params: Promise<{ id: string }> }) {
  const { id } = await params;
  const order = await prisma.order.findUnique({
    where: { id },
    include: { items: { include: { product: true } }, user: true, invoice: true },
  });
  if (!order) notFound();

  return (
    <div>
      <h1 className="font-serif text-2xl font-bold text-primary">Order</h1>
      <p className="mt-2 font-mono text-xs text-muted-foreground">{order.id}</p>
      <p className="mt-4 text-sm">
        Customer:{" "}
        {order.user
          ? (order.user.name ?? order.user.email)
          : [order.guestName, order.guestEmail].filter(Boolean).join(" · ") || "Guest"}{" "}
        · {order.paymentStatus} · {order.status}
      </p>
      <p className="text-lg font-semibold text-primary">{formatINR(order.total)}</p>
      {order.invoice && <p className="text-sm text-muted-foreground">Invoice {order.invoice.invoiceNumber}</p>}
      <ul className="mt-6 space-y-2 text-sm">
        {order.items.map((i) => (
          <li key={i.id} className="flex justify-between border-b py-2">
            <span>
              {i.product.name} × {i.quantity}
            </span>
            <span>{formatINR(i.unitPrice * i.quantity)}</span>
          </li>
        ))}
      </ul>
    </div>
  );
}
