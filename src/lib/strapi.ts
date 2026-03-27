/**
 * Server-side Strapi REST client (Strapi 5). Uses STRAPI_API_URL + STRAPI_API_TOKEN.
 */

const STRAPI =
  process.env.STRAPI_API_URL ?? process.env.NEXT_PUBLIC_STRAPI_URL ?? "http://localhost:1337";
const TOKEN = process.env.STRAPI_API_TOKEN ?? "";

/** API segment for commerce custom routes (matches pluralName of commerce-placeholder). */
export const STRAPI_COMMERCE_PATH = "/api/commerce-placeholders";

export function strapiUrl(path: string) {
  const p = path.startsWith("/") ? path : `/${path}`;
  return `${STRAPI.replace(/\/$/, "")}${p}`;
}

export async function strapiFetch<T = unknown>(
  path: string,
  init: RequestInit & { next?: { revalidate?: number | false; tags?: string[] } } = {}
): Promise<T> {
  const headers = new Headers(init.headers);
  headers.set("Content-Type", headers.get("Content-Type") ?? "application/json");
  if (TOKEN) headers.set("Authorization", `Bearer ${TOKEN}`);

  const { next, ...rest } = init;
  const res = await fetch(strapiUrl(path), {
    ...rest,
    headers,
    ...(next !== undefined ? { next } : { cache: "no-store" }),
  });

  if (!res.ok) {
    const t = await res.text();
    throw new Error(`Strapi ${res.status}: ${t.slice(0, 500)}`);
  }
  if (res.status === 204) return undefined as T;
  return res.json() as Promise<T>;
}

/** Unwrap Strapi REST list response `data` array and normalize docs. */
export function unwrapList<T extends Record<string, unknown>>(json: { data?: unknown[] }): T[] {
  const raw = json.data ?? [];
  return raw.map((d) => normalizeDoc(d) as T);
}

/** Unwrap single resource. */
export function unwrapOne<T extends Record<string, unknown>>(json: { data?: unknown }): T | null {
  const d = json.data;
  if (d == null) return null;
  return normalizeDoc(d) as T;
}

/**
 * Flatten Strapi document: expose `id` as documentId for app code that expected Prisma `id`.
 */
export function normalizeDoc(raw: unknown): Record<string, unknown> {
  if (raw == null || typeof raw !== "object") return {};
  const d = raw as Record<string, unknown>;
  const attrs = (d.attributes as Record<string, unknown> | undefined) ?? {};
  const base = { ...d, ...attrs };
  delete base.attributes;
  const docId = (base.documentId as string) ?? (base.id as string | undefined);
  if (docId) base.id = docId;
  return base;
}

export async function commerceCreateOrder(body: Record<string, unknown>) {
  const secret = process.env.COMMERCE_INTERNAL_SECRET;
  if (!secret) throw new Error("COMMERCE_INTERNAL_SECRET is not set");
  return strapiFetch<{ orderId: string }>(`${STRAPI_COMMERCE_PATH}/create-order`, {
    method: "POST",
    body: JSON.stringify(body),
    headers: { "X-Commerce-Secret": secret },
  });
}

export async function commerceVerifyPayment(body: Record<string, unknown>) {
  const secret = process.env.COMMERCE_INTERNAL_SECRET;
  if (!secret) throw new Error("COMMERCE_INTERNAL_SECRET is not set");
  return strapiFetch<{ ok: boolean; orderId: string }>(`${STRAPI_COMMERCE_PATH}/verify-payment`, {
    method: "POST",
    body: JSON.stringify(body),
    headers: { "X-Commerce-Secret": secret },
  });
}

/** Build query string for Strapi filters (shallow). */
export function qs(params: Record<string, string | number | boolean | undefined>) {
  const u = new URLSearchParams();
  for (const [k, v] of Object.entries(params)) {
    if (v !== undefined) u.set(k, String(v));
  }
  const s = u.toString();
  return s ? `?${s}` : "";
}
