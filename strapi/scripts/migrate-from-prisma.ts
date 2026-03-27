/**
 * Outline migration: read rows from the legacy Prisma PostgreSQL database and POST to Strapi REST.
 *
 * Prerequisites:
 * - Strapi running with all content-types created and API token with create permissions
 * - Set LEGACY_DATABASE_URL and STRAPI_URL / STRAPI_API_TOKEN in env
 *
 * Run: npx tsx scripts/migrate-from-prisma.ts
 *
 * This script is intentionally minimal — extend per-table mappers for production use.
 */
import pg from "pg";

const LEGACY_URL = process.env.LEGACY_DATABASE_URL;
const STRAPI = process.env.STRAPI_URL ?? "http://localhost:1337";
const TOKEN = process.env.STRAPI_API_TOKEN ?? "";

async function post(path: string, body: unknown) {
  const res = await fetch(`${STRAPI.replace(/\/$/, "")}${path}`, {
    method: "POST",
    headers: {
      "Content-Type": "application/json",
      ...(TOKEN ? { Authorization: `Bearer ${TOKEN}` } : {}),
    },
    body: JSON.stringify(body),
  });
  if (!res.ok) {
    const t = await res.text();
    throw new Error(`${res.status}: ${t.slice(0, 400)}`);
  }
  return res.json();
}

async function main() {
  if (!LEGACY_URL) {
    console.error("Set LEGACY_DATABASE_URL to the old Prisma Postgres connection string.");
    process.exit(1);
  }
  const pool = new pg.Pool({ connectionString: LEGACY_URL });
  const client = await pool.connect();
  try {
    const { rows: categories } = await client.query(`SELECT * FROM "ProductCategory" ORDER BY "sortOrder"`);
    console.log(`Found ${categories.length} product categories — map and POST to /api/product-categories`);
    for (const c of categories) {
      await post("/api/product-categories", {
        data: {
          name: c.name,
          slug: c.slug,
          sortOrder: c.sortOrder,
          legacyId: c.id,
        },
      }).catch((e) => console.warn("category", c.slug, e.message));
    }
    console.log("Migration stub completed (categories). Extend for products, orders, users, etc.");
  } finally {
    client.release();
    await pool.end();
  }
}

main().catch((e) => {
  console.error(e);
  process.exit(1);
});
