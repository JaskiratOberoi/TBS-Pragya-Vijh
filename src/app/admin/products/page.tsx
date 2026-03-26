import Link from "next/link";
import { prisma } from "@/lib/prisma";
import { formatINR } from "@/lib/utils";
import { effectiveUnitPrice } from "@/lib/promo-engine";

export default async function AdminProductsPage() {
  const products = await prisma.product.findMany({
    orderBy: { updatedAt: "desc" },
    take: 100,
    include: { category: true },
  });
  return (
    <div>
      <h1 className="font-serif text-2xl font-bold text-primary">Products</h1>
      <p className="mt-2 text-sm text-muted-foreground">Full CRUD UI can extend this table — data is in PostgreSQL via Prisma.</p>
      <table className="mt-6 w-full text-left text-sm">
        <thead>
          <tr className="border-b">
            <th className="py-2">Name</th>
            <th className="py-2">Category</th>
            <th className="py-2">Price</th>
            <th className="py-2">Stock</th>
            <th className="py-2">Active</th>
          </tr>
        </thead>
        <tbody>
          {products.map((p) => (
            <tr key={p.id} className="border-b">
              <td className="py-2">
                <Link href={`/shop/${p.slug}`} className="text-primary hover:underline">
                  {p.name}
                </Link>
              </td>
              <td className="py-2">{p.category.name}</td>
              <td className="py-2">{formatINR(effectiveUnitPrice(p))}</td>
              <td className="py-2">{p.stock}</td>
              <td className="py-2">{p.isActive ? "yes" : "no"}</td>
            </tr>
          ))}
        </tbody>
      </table>
    </div>
  );
}
