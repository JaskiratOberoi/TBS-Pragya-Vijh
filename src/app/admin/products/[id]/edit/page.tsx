import { notFound } from "next/navigation";
import { prisma } from "@/lib/prisma";
import { productToFormInitial } from "@/lib/product-form-initial";
import { ProductForm } from "@/components/admin/ProductForm";

export default async function EditProductPage({ params }: { params: Promise<{ id: string }> }) {
  const { id } = await params;
  const [product, categories, shippingClasses] = await Promise.all([
    prisma.product.findUnique({ where: { id } }),
    prisma.productCategory.findMany({ orderBy: { sortOrder: "asc" } }),
    prisma.shippingClass.findMany({ orderBy: { name: "asc" } }),
  ]);

  if (!product) notFound();

  const cat = categories.map((c) => ({ id: c.id, name: c.name }));
  const ship = shippingClasses.map((s) => ({ id: s.id, name: s.name }));

  return (
    <div>
      <h1 className="font-serif text-2xl font-bold text-primary">Edit product</h1>
      <p className="mt-2 text-sm text-muted-foreground">Update details for {product.name}.</p>
      <div className="mt-8">
        <ProductForm categories={cat} shippingClasses={ship} initial={productToFormInitial(product)} />
      </div>
    </div>
  );
}
