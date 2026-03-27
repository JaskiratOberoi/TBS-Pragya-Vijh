import Link from "next/link";
import { prisma } from "@/lib/prisma";
import { effectiveUnitPrice } from "@/lib/promo-engine";
import { Button } from "@/components/ui/button";
import { AdminProductsTable, type AdminProductRow } from "@/components/admin/AdminProductsTable";

export default async function AdminProductsPage() {
  const products = await prisma.product.findMany({
    orderBy: { updatedAt: "desc" },
    take: 200,
    include: { category: true },
  });

  const rows: AdminProductRow[] = products.map((p) => ({
    id: p.id,
    name: p.name,
    slug: p.slug,
    categoryName: p.category.name,
    displayPricePaise: effectiveUnitPrice(p),
    stock: p.stock,
    isActive: p.isActive,
  }));

  return (
    <div>
      <div className="flex flex-wrap items-center justify-between gap-4">
        <div>
          <h1 className="font-serif text-2xl font-bold text-primary">Products</h1>
          <p className="mt-2 text-sm text-muted-foreground">
            Create, edit, hide, or delete products. Prices are in ₹ (stored as paise). Deleting a product that has
            orders will hide it instead.
          </p>
        </div>
        <Button asChild>
          <Link href="/admin/products/new">Add product</Link>
        </Button>
      </div>
      <AdminProductsTable products={rows} />
    </div>
  );
}
