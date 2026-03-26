import Link from "next/link";
import Image from "next/image";
import { prisma } from "@/lib/prisma";
import { formatINR } from "@/lib/utils";
import { effectiveUnitPrice } from "@/lib/promo-engine";

export default async function SearchPage({ searchParams }: { searchParams: Promise<{ q?: string }> }) {
  const { q } = await searchParams;
  const query = q?.trim() ?? "";
  const products =
    query.length > 1
      ? await prisma.product.findMany({
          where: {
            isActive: true,
            OR: [
              { name: { contains: query, mode: "insensitive" } },
              { description: { contains: query, mode: "insensitive" } },
            ],
          },
          take: 48,
          include: { category: true },
        })
      : [];

  return (
    <div className="mx-auto max-w-5xl px-4 py-10">
      <h1 className="font-serif text-2xl font-bold text-primary">Search</h1>
      {query.length < 2 ? (
        <p className="mt-4 text-muted-foreground">Enter a search query (min 2 characters).</p>
      ) : (
        <p className="mt-4 text-sm text-muted-foreground">
          {products.length} result(s) for &ldquo;{query}&rdquo;
        </p>
      )}
      <ul className="mt-8 grid gap-4 sm:grid-cols-2 lg:grid-cols-3">
        {products.map((p) => (
          <li key={p.id} className="flex gap-4 rounded-lg border p-3">
            <Link href={`/shop/${p.slug}`} className="relative h-24 w-24 shrink-0 overflow-hidden rounded-md bg-muted">
              <Image src={p.images[0] ?? "/assets/products/placeholder.svg"} alt="" fill className="object-cover" />
            </Link>
            <div>
              <Link href={`/shop/${p.slug}`} className="font-medium hover:underline">
                {p.name}
              </Link>
              <p className="text-sm text-muted-foreground">{p.category.name}</p>
              <p className="text-sm text-primary">{formatINR(effectiveUnitPrice(p))}</p>
            </div>
          </li>
        ))}
      </ul>
    </div>
  );
}
