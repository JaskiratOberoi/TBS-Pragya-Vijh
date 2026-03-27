import { NextResponse } from "next/server";
import { getServerSession } from "next-auth";
import { authOptions } from "@/lib/auth";
import { strapiFetch, normalizeDoc } from "@/lib/strapi";

export async function GET() {
  const session = await getServerSession(authOptions);
  if (!session?.user?.id) return NextResponse.json({ items: [] });
  const j = await strapiFetch<{ data?: unknown[] }>(
    `/api/digital-purchases?filters[user][documentId][$eq]=${encodeURIComponent(session.user.id)}&populate[asset][populate][product]=true&pagination[pageSize]=100`
  );
  const rows = (j.data ?? []).map((x) => normalizeDoc(x));
  return NextResponse.json({
    items: rows.map((row) => {
      const r = row as Record<string, unknown>;
      const asset = r.asset as
        | {
            assetType?: string;
            url?: string;
            accessInstructions?: string;
            product?: { name?: string };
          }
        | undefined;
      return {
        id: String(r.documentId ?? r.id ?? ""),
        productName: asset?.product?.name ?? "Product",
        assetType: asset?.assetType ?? "",
        url: String(r.accessUrl ?? asset?.url ?? ""),
        instructions: asset?.accessInstructions,
      };
    }),
  });
}
