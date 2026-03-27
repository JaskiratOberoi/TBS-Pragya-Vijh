import { prisma } from "@/lib/prisma";
import { ProductForm } from "@/components/admin/ProductForm";

export default async function NewProductPage() {
  const [categories, shippingClasses] = await Promise.all([
    prisma.productCategory.findMany({ orderBy: { sortOrder: "asc" } }),
    prisma.shippingClass.findMany({ orderBy: { name: "asc" } }),
  ]);

  const cat = categories.map((c) => ({ id: c.id, name: c.name }));
  const ship = shippingClasses.map((s) => ({ id: s.id, name: s.name }));

  return (
    <div>
      <h1 className="font-serif text-2xl font-bold text-primary">New product</h1>
      <p className="mt-2 text-sm text-muted-foreground">Add a product to the catalog.</p>
      <div className="mt-8">
        <ProductForm categories={cat} shippingClasses={ship} />
      </div>
    </div>
  );
}
