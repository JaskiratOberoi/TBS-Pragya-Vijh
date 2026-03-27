import Link from "next/link";
import Image from "next/image";
import { strapiFetch, normalizeDoc } from "@/lib/strapi";
import { formatINR } from "@/lib/utils";
import { effectiveUnitPrice } from "@/lib/promo-engine";

export default async function SearchPage({ searchParams }: { searchParams: Promise<{ q?: string }> }) {
  const { q } = await searchParams;
  const query = q?.trim() ?? "";
  let products: Array<Record<string, unknown>> = [];
  if (query.length > 1) {
    const j = await strapiFetch<{ data?: unknown[] }>(
      `/api/products?filters[isActive][$eq]=true&filters[$or][0][name][$containsi]=${encodeURIComponent(query)}&filters[$or][1][description][$containsi]=${encodeURIComponent(query)}&populate[category]=true&pagination[pageSize]=48`,
      { next: { revalidate: 60 } }
    );
    products = (j.data ?? []).map((x) => normalizeDoc(x));
  }

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
        {products.map((p) => {
          const cat = p.category as { name?: string } | undefined;
          const imgs = Array.isArray(p.images) ? p.images.map(String) : [];
          return (
            <li key={String(p.id)} className="flex gap-4 rounded-lg border p-3">
              <Link href={`/shop/${p.slug}`} className="relative h-24 w-24 shrink-0 overflow-hidden rounded-md bg-muted">
                <Image src={imgs[0] ?? "/assets/products/placeholder.svg"} alt="" fill className="object-cover" />
              </Link>
              <div>
                <Link href={`/shop/${p.slug}`} className="font-medium hover:underline">
                  {String(p.name)}
                </Link>
                <p className="text-sm text-muted-foreground">{cat?.name}</p>
                <p className="text-sm text-primary">
                  {formatINR(
                    effectiveUnitPrice({
                      price: Number(p.price ?? 0),
                      salePrice: p.salePrice != null ? Number(p.salePrice) : null,
                    })
                  )}
                </p>
              </div>
            </li>
          );
        })}
      </ul>
    </div>
  );
}
