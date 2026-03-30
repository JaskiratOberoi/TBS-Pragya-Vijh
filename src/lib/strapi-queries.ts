import { strapiFetch, strapiFetchPublicList, strapiFetchPublicSingle, unwrapList, normalizeDoc } from "@/lib/strapi";
import type { CouponCodeLike, ProductLike } from "@/lib/types/commerce";

const POP_PRODUCT_DEEP =
  "populate[category]=true&populate[shippingClass]=true&populate[variants]=true&populate[digitalAssets]=true";

export async function getBusinessSettings() {
  const j = await strapiFetchPublicSingle<{ data?: unknown }>(`/api/business-setting`, { next: { revalidate: 60 } });
  if (!j?.data) return null;
  return normalizeDoc(j.data) as Record<string, unknown>;
}

export async function getBookingSettings() {
  const j = await strapiFetchPublicSingle<{ data?: unknown }>(`/api/booking-setting`, { next: { revalidate: 60 } });
  if (!j?.data) return null;
  return normalizeDoc(j.data) as Record<string, unknown>;
}

export async function findProductBySlug(slug: string) {
  const j = await strapiFetchPublicList<{ data?: unknown[] }>(
    `/api/products?filters[slug][$eq]=${encodeURIComponent(slug)}&${POP_PRODUCT_DEEP}&pagination[pageSize]=1`,
    { next: { revalidate: 60 } }
  );
  const list = unwrapList(j);
  return (list[0] as ProductLike | undefined) ?? null;
}

/** Full product document for PDP (category, shipping, variants, assets). */
export async function findProductBySlugFull(slug: string) {
  const j = await strapiFetchPublicList<{ data?: unknown[] }>(
    `/api/products?filters[slug][$eq]=${encodeURIComponent(slug)}&${POP_PRODUCT_DEEP}&pagination[pageSize]=1`,
    { next: { revalidate: 60 } }
  );
  const list = unwrapList(j);
  return (list[0] as Record<string, unknown> | undefined) ?? null;
}

export async function findProductByDocumentId(documentId: string) {
  const j = await strapiFetch<{ data?: unknown[] }>(
    `/api/products?filters[documentId][$eq]=${encodeURIComponent(documentId)}&${POP_PRODUCT_DEEP}&pagination[pageSize]=1`,
    { cache: "no-store" }
  );
  const list = unwrapList(j);
  return (list[0] as ProductLike | undefined) ?? null;
}

export async function findCouponByCode(code: string) {
  const j = await strapiFetch<{ data?: unknown[] }>(
    `/api/coupon-codes?filters[code][$eq]=${encodeURIComponent(code)}&pagination[pageSize]=1`,
    { cache: "no-store" }
  );
  const list = unwrapList(j);
  return (list[0] as unknown as CouponCodeLike | undefined) ?? null;
}

export async function countCouponUsagesForUser(couponDocumentId: string, userDocumentId: string) {
  const j = await strapiFetch<{ meta?: { pagination?: { total?: number } } }>(
    `/api/coupon-usages?filters[coupon][documentId][$eq]=${encodeURIComponent(couponDocumentId)}&filters[user][documentId][$eq]=${encodeURIComponent(userDocumentId)}&pagination[pageSize]=1`
  );
  return j.meta?.pagination?.total ?? 0;
}

export async function countCouponUsagesForGuest(couponDocumentId: string, guestEmail: string) {
  const j = await strapiFetch<{ meta?: { pagination?: { total?: number } } }>(
    `/api/coupon-usages?filters[coupon][documentId][$eq]=${encodeURIComponent(couponDocumentId)}&filters[guestEmail][$eq]=${encodeURIComponent(guestEmail)}&pagination[pageSize]=1`
  );
  return j.meta?.pagination?.total ?? 0;
}

export async function findLegalPageBySlug(slug: string) {
  const j = await strapiFetchPublicList<{ data?: unknown[] }>(
    `/api/legal-pages?filters[slug][$eq]=${encodeURIComponent(slug)}&pagination[pageSize]=1`,
    { next: { revalidate: 300 } }
  );
  const list = unwrapList(j);
  return (list[0] as { title?: string; content?: string; slug?: string } | undefined) ?? null;
}
