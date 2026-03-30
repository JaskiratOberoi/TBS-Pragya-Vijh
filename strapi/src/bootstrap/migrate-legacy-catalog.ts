import type { Core } from "@strapi/types";
import pg from "pg";

type LegacyShipping = { id: string; name: string; rate: number; freeAbove: number | null; description: string | null };
type LegacyCategory = { id: string; name: string; slug: string; sortOrder: number | null };
type LegacyProduct = {
  id: string;
  name: string;
  slug: string;
  description: string | null;
  categoryId: string | null;
  productType: string;
  price: number;
  salePrice: number | null;
  stock: number | null;
  images: string[] | null;
  healingProperties: string | null;
  wearHand: string | null;
  shippingClassId: string | null;
  hsnCode: string | null;
  gstRateBps: number | null;
  isActive: boolean | null;
};
type LegacyVariant = { id: string; productId: string; name: string; options: unknown };
type LegacyService = {
  id: string;
  name: string;
  type: string;
  price: number;
  durationMinutes: number;
  staffId: string | null;
  bufferMinutes: number | null;
  isActive: boolean | null;
  description: string | null;
};

function legacyUrlOrNull(): string | null {
  const u = process.env.LEGACY_DATABASE_URL?.trim();
  if (u) return u;
  if (process.env.IMPORT_LEGACY_USE_COMPOSE_DB === "true" || process.env.IMPORT_LEGACY_USE_COMPOSE_DB === "1") {
    return "postgresql://blissful:blissful_dev@db:5432/blissful_soul";
  }
  return null;
}

function importEnabled(): boolean {
  const v = process.env.IMPORT_LEGACY_CATALOG?.trim().toLowerCase();
  return v === "true" || v === "1" || v === "yes";
}

function forceImport(): boolean {
  const v = process.env.IMPORT_LEGACY_FORCE?.trim().toLowerCase();
  return v === "true" || v === "1";
}

/**
 * Copy catalog (shipping classes, categories, products, variants, services) from the legacy Prisma DB
 * into Strapi via the Document Service. Safe to run multiple times: skips rows that already exist (by slug / name).
 */
export async function migrateLegacyCatalogIfEnabled(strapi: Core.Strapi) {
  if (!importEnabled()) return;

  const productsExisting = await strapi.documents("api::product.product").findMany({ limit: 1 });
  if (productsExisting.length > 0 && !forceImport()) {
    strapi.log.info("[legacy-import] Strapi already has products — skipping (set IMPORT_LEGACY_FORCE=true to re-run)");
    return;
  }

  const conn = legacyUrlOrNull();
  if (!conn) {
    strapi.log.warn(
      "[legacy-import] IMPORT_LEGACY_CATALOG is set but no LEGACY_DATABASE_URL (or IMPORT_LEGACY_USE_COMPOSE_DB=true) — skipping"
    );
    return;
  }

  const pool = new pg.Pool({ connectionString: conn });
  const client = await pool.connect();

  try {
    strapi.log.info("[legacy-import] connecting to legacy database…");

    const shippingLegacyToDoc = new Map<string, string>();
    const categoryLegacyToDoc = new Map<string, string>();
    const productLegacyToDoc = new Map<string, string>();

    const { rows: shippings } = await client.query<LegacyShipping>(`SELECT * FROM "ShippingClass" ORDER BY name`);
    for (const s of shippings) {
      try {
        const found = await strapi.documents("api::shipping-class.shipping-class").findFirst({
          filters: { name: { $eq: s.name } },
        });
        const docId = found?.documentId;
        if (docId) {
          shippingLegacyToDoc.set(s.id, docId);
          continue;
        }
        const created = await strapi.documents("api::shipping-class.shipping-class").create({
          data: {
            name: s.name,
            rate: s.rate,
            freeAbove: s.freeAbove ?? undefined,
            description: s.description ?? undefined,
          },
        });
        shippingLegacyToDoc.set(s.id, created.documentId);
      } catch (e) {
        strapi.log.warn(`[legacy-import] shipping class ${s.name}: ${(e as Error).message}`);
      }
    }

    const { rows: categories } = await client.query<LegacyCategory>(
      `SELECT * FROM "ProductCategory" ORDER BY "sortOrder" NULLS LAST, name`
    );
    for (const c of categories) {
      try {
        const found = await strapi.documents("api::product-category.product-category").findFirst({
          filters: { slug: { $eq: c.slug } },
        });
        const docId = found?.documentId;
        if (docId) {
          categoryLegacyToDoc.set(c.id, docId);
          continue;
        }
        const created = await strapi.documents("api::product-category.product-category").create({
          data: {
            name: c.name,
            slug: c.slug,
            sortOrder: c.sortOrder ?? 0,
          },
        });
        categoryLegacyToDoc.set(c.id, created.documentId);
      } catch (e) {
        strapi.log.warn(`[legacy-import] category ${c.slug}: ${(e as Error).message}`);
      }
    }

    const { rows: products } = await client.query<LegacyProduct>(`SELECT * FROM "Product" ORDER BY name`);
    for (const p of products) {
      try {
        const exists = await strapi.documents("api::product.product").findFirst({
          filters: { slug: { $eq: p.slug } },
        });
        if (exists?.documentId) {
          productLegacyToDoc.set(p.id, exists.documentId);
          continue;
        }

        const catDoc = p.categoryId ? categoryLegacyToDoc.get(p.categoryId) : undefined;
        const shipDoc = p.shippingClassId ? shippingLegacyToDoc.get(p.shippingClassId) : undefined;

        const imagesArr = Array.isArray(p.images) ? p.images : [];

        const data: Record<string, unknown> = {
          name: p.name,
          slug: p.slug,
          description: (p.description && p.description.trim()) || " ",
          productType: p.productType === "DIGITAL" ? "DIGITAL" : "PHYSICAL",
          price: p.price,
          salePrice: p.salePrice ?? undefined,
          stock: p.stock ?? 0,
          images: imagesArr,
          healingProperties: p.healingProperties ?? undefined,
          wearHand: p.wearHand ?? undefined,
          hsnCode: p.hsnCode ?? undefined,
          gstRateBps: p.gstRateBps ?? 1800,
          isActive: p.isActive !== false,
        };

        if (catDoc) data.category = { connect: [catDoc] };
        if (shipDoc) data.shippingClass = { connect: [shipDoc] };

        const created = await strapi.documents("api::product.product").create({ data: data as never });
        productLegacyToDoc.set(p.id, created.documentId);
      } catch (e) {
        strapi.log.warn(`[legacy-import] product ${p.slug}: ${(e as Error).message}`);
      }
    }

    const { rows: variants } = await client.query<LegacyVariant>(`SELECT * FROM "ProductVariant"`);
    for (const v of variants) {
      try {
        const productDocId = productLegacyToDoc.get(v.productId);
        if (!productDocId) continue;

        const dup = await strapi.documents("api::product-variant.product-variant").findMany({
          filters: {
            name: { $eq: v.name },
            product: { documentId: { $eq: productDocId } },
          },
          limit: 1,
        });
        if (dup.length > 0) continue;

        await strapi.documents("api::product-variant.product-variant").create({
          data: {
            name: v.name,
            options: (v.options ?? {}) as object,
            product: { connect: [productDocId] },
          },
        });
      } catch (e) {
        strapi.log.warn(`[legacy-import] variant ${v.name}: ${(e as Error).message}`);
      }
    }

    const { rows: services } = await client.query<LegacyService>(`SELECT * FROM "Service" ORDER BY name`);
    for (const s of services) {
      try {
        const dup = await strapi.documents("api::service.service").findFirst({
          filters: {
            $and: [
              { name: { $eq: s.name } },
              { price: { $eq: s.price } },
              { durationMinutes: { $eq: s.durationMinutes } },
            ],
          },
        });
        if (dup) continue;

        await strapi.documents("api::service.service").create({
          data: {
            name: s.name,
            type: s.type === "VIDEO" ? "VIDEO" : "AUDIO",
            price: s.price,
            durationMinutes: s.durationMinutes,
            staffId: s.staffId ?? undefined,
            bufferMinutes: s.bufferMinutes ?? 0,
            isActive: s.isActive !== false,
            description: s.description ?? undefined,
          },
        });
      } catch (e) {
        strapi.log.warn(`[legacy-import] service ${s.name}: ${(e as Error).message}`);
      }
    }

    strapi.log.info("[legacy-import] catalog import finished");
  } catch (e) {
    strapi.log.error(`[legacy-import] ${(e as Error).message}`);
  } finally {
    client.release();
    await pool.end();
  }
}
