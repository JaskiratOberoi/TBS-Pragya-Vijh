import { NextResponse } from "next/server";
import { revalidatePath } from "next/cache";
import { requireAdmin } from "@/lib/api-auth";
import { prisma } from "@/lib/prisma";
import { slugify } from "@/lib/slug";
import { adminProductBodySchema, bodyToPrismaData } from "@/lib/admin-product";

export async function POST(req: Request) {
  const gate = await requireAdmin();
  if ("error" in gate) return gate.error;

  let json: unknown;
  try {
    json = await req.json();
  } catch {
    return NextResponse.json({ error: "Invalid JSON" }, { status: 400 });
  }

  const parsed = adminProductBodySchema.safeParse(json);
  if (!parsed.success) {
    return NextResponse.json({ error: parsed.error.flatten() }, { status: 400 });
  }

  const baseSlug = parsed.data.slug?.trim() || slugify(parsed.data.name);
  let slug = baseSlug;
  let n = 0;
  while (await prisma.product.findUnique({ where: { slug } })) {
    n += 1;
    slug = `${baseSlug}-${n}`;
  }

  try {
    const data = bodyToPrismaData(parsed.data, slug);
    const product = await prisma.product.create({ data });
    revalidatePath("/shop");
    revalidatePath("/admin/products");
    return NextResponse.json({ product });
  } catch (e) {
    const msg = e instanceof Error ? e.message : "Create failed";
    return NextResponse.json({ error: msg }, { status: 400 });
  }
}
