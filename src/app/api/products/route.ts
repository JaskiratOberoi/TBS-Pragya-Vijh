import { NextResponse } from "next/server";
import { prisma } from "@/lib/prisma";
import { Prisma } from "@prisma/client";

export async function GET(req: Request) {
  const { searchParams } = new URL(req.url);
  const page = Math.max(1, Number(searchParams.get("page") ?? "1"));
  const limit = Math.min(48, Math.max(1, Number(searchParams.get("limit") ?? "12")));
  const q = searchParams.get("q")?.trim();
  const category = searchParams.get("category");
  const type = searchParams.get("type") as "PHYSICAL" | "DIGITAL" | null;
  const sort = searchParams.get("sort") ?? "latest";

  const where: Prisma.ProductWhereInput = { isActive: true };
  if (q) {
    where.OR = [
      { name: { contains: q, mode: "insensitive" } },
      { description: { contains: q, mode: "insensitive" } },
    ];
  }
  if (category) {
    where.category = { slug: category };
  }
  if (type === "PHYSICAL" || type === "DIGITAL") {
    where.productType = type;
  }

  let orderBy: Prisma.ProductOrderByWithRelationInput[] = [{ createdAt: "desc" }];
  if (sort === "price_asc") orderBy = [{ price: "asc" }];
  if (sort === "price_desc") orderBy = [{ price: "desc" }];
  if (sort === "name") orderBy = [{ name: "asc" }];

  const [total, products] = await Promise.all([
    prisma.product.count({ where }),
    prisma.product.findMany({
      where,
      orderBy: orderBy[0],
      skip: (page - 1) * limit,
      take: limit,
      include: { category: true },
    }),
  ]);

  return NextResponse.json({
    products: products.map((p) => ({
      id: p.id,
      name: p.name,
      slug: p.slug,
      price: p.price,
      salePrice: p.salePrice,
      images: p.images,
      productType: p.productType,
      stock: p.stock,
      category: p.category,
    })),
    total,
    page,
    limit,
    totalPages: Math.ceil(total / limit),
  });
}
