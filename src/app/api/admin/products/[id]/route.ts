import type { Prisma } from "@prisma/client";
import { NextResponse } from "next/server";
import { revalidatePath } from "next/cache";
import { requireAdmin } from "@/lib/api-auth";
import { prisma } from "@/lib/prisma";
import { adminProductBodySchema } from "@/lib/admin-product";

const patchSchema = adminProductBodySchema.partial();

function rupeesToPaise(r: number) {
  return Math.round(r * 100);
}

export async function PATCH(req: Request, { params }: { params: Promise<{ id: string }> }) {
  const gate = await requireAdmin();
  if ("error" in gate) return gate.error;

  const { id } = await params;
  const existing = await prisma.product.findUnique({ where: { id } });
  if (!existing) return NextResponse.json({ error: "Not found" }, { status: 404 });

  let json: unknown;
  try {
    json = await req.json();
  } catch {
    return NextResponse.json({ error: "Invalid JSON" }, { status: 400 });
  }

  const parsed = patchSchema.safeParse(json);
  if (!parsed.success) {
    return NextResponse.json({ error: parsed.error.flatten() }, { status: 400 });
  }

  const p = parsed.data;
  const data: Prisma.ProductUpdateInput = {};

  if (p.name !== undefined) data.name = p.name.trim();
  if (p.description !== undefined) data.description = p.description.trim();
  if (p.categoryId !== undefined) data.category = { connect: { id: p.categoryId } };
  if (p.productType !== undefined) data.productType = p.productType;
  if (p.stock !== undefined) data.stock = p.stock;
  if (p.healingProperties !== undefined) data.healingProperties = p.healingProperties?.trim() || null;
  if (p.wearHand !== undefined) data.wearHand = p.wearHand?.trim() || null;
  if (p.shippingClassId !== undefined) {
    data.shippingClass = p.shippingClassId
      ? { connect: { id: p.shippingClassId } }
      : { disconnect: true };
  }
  if (p.hsnCode !== undefined) data.hsnCode = p.hsnCode?.trim() || null;
  if (p.gstRateBps !== undefined) data.gstRateBps = p.gstRateBps;
  if (p.isActive !== undefined) data.isActive = p.isActive;

  if (p.slug !== undefined && p.slug.trim()) {
    const nextSlug = p.slug.trim();
    const clash = await prisma.product.findFirst({ where: { slug: nextSlug, NOT: { id } } });
    if (clash) return NextResponse.json({ error: "Slug already in use" }, { status: 400 });
    data.slug = nextSlug;
  }

  if (p.priceRupees !== undefined) data.price = rupeesToPaise(p.priceRupees);

  if (p.salePriceRupees !== undefined) {
    if (p.salePriceRupees === null || p.salePriceRupees === 0) {
      data.salePrice = null;
    } else {
      const pricePaise =
        p.priceRupees !== undefined ? rupeesToPaise(p.priceRupees) : existing.price;
      const sale = rupeesToPaise(p.salePriceRupees);
      if (sale >= pricePaise) {
        return NextResponse.json({ error: "Sale price must be less than regular price" }, { status: 400 });
      }
      data.salePrice = sale;
    }
  }

  if (p.images !== undefined) {
    data.images =
      p.images.length > 0 ? p.images : ["/assets/products/placeholder.svg"];
  }

  if (Object.keys(data).length === 0) {
    return NextResponse.json({ error: "No fields to update" }, { status: 400 });
  }

  try {
    const product = await prisma.product.update({
      where: { id },
      data,
    });
    revalidatePath("/shop");
    revalidatePath(`/shop/${product.slug}`);
    revalidatePath("/admin/products");
    return NextResponse.json({ product });
  } catch (e) {
    const msg = e instanceof Error ? e.message : "Update failed";
    return NextResponse.json({ error: msg }, { status: 400 });
  }
}

export async function DELETE(_req: Request, { params }: { params: Promise<{ id: string }> }) {
  const gate = await requireAdmin();
  if ("error" in gate) return gate.error;

  const { id } = await params;
  const existing = await prisma.product.findUnique({
    where: { id },
    include: { _count: { select: { orderItems: true } } },
  });
  if (!existing) return NextResponse.json({ error: "Not found" }, { status: 404 });

  if (existing._count.orderItems > 0) {
    await prisma.product.update({ where: { id }, data: { isActive: false } });
    revalidatePath("/shop");
    revalidatePath("/admin/products");
    return NextResponse.json({
      ok: true,
      softDeleted: true,
      message: "Product has orders — it was hidden from the storefront instead of being deleted.",
    });
  }

  await prisma.$transaction([
    prisma.review.deleteMany({ where: { productId: id } }),
    prisma.product.delete({ where: { id } }),
  ]);
  revalidatePath("/shop");
  revalidatePath("/admin/products");
  return NextResponse.json({ ok: true, softDeleted: false });
}
