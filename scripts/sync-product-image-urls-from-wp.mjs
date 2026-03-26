/**
 * Regenerate prisma/data/product-image-urls.json from WooCommerce Store API
 * (canonical primary image per product). Run: node scripts/sync-product-image-urls-from-wp.mjs
 *
 * money-potli-gift uses live slug free-money-portly (WP product title matches).
 */
import fs from "fs";
import path from "path";
import { fileURLToPath } from "url";

const __dirname = path.dirname(fileURLToPath(import.meta.url));
const ROOT = path.resolve(__dirname, "..");
const OUT = path.join(ROOT, "prisma/data/product-image-urls.json");

const ORIGIN = "https://bm3.bad.myftpupload.com";

/** Our Prisma slug -> WooCommerce product slug (when different). */
const SLUG_MAP = {
  "money-potli-gift": "free-money-portly",
};

const U = "https://bm3.bad.myftpupload.com/wp-content/uploads/2025/09";

/**
 * Featured image on a few WP products is shared (same media id) or wrong; set a better first image.
 * Full gallery from the API is kept after these.
 */
const PRIMARY_OVERRIDE = {
  "money-pyramid-selenite-charging-plate-combo": `${U}/1-3-800x800.webp`,
  "money-pyramid": `${U}/1-12-768x768.webp`,
  /** WP featured is a locket; gallery[1] is the salt product photo. */
  "healing-sea-salt": `${U}/2-18.webp`,
};

const SLUGS = [
  "money-pyramid-selenite-charging-plate-combo",
  "pyrite-money-keychain-1-piece-assorted",
  "money-pyramid",
  "amethyst-natural-bracelet",
  "rose-quartz-natural-bracelet",
  "money-magnet",
  "crystal-charger-selenite-plate",
  "rose-quartz-pyramid",
  "black-obsidian-tumbles-negativity-evil-eye",
  "amethyst-tumbles-peace-and-anxiety",
  "rose-quartz-tumbles-love-relationships",
  "riche-rich",
  "pyrite-natural-bracelet",
  "sage-sticks-negativity-removal",
  "masters-wish-box-manifest-all-desires",
  "genie-bracelet",
  "rose-quartz-pencil-locketself-love-and-relationship",
  "red-jasper-natural-bracelet",
  "pregnancy-health-bracelet",
  "black-obsidian-pencil-locketevil-eye-and-nazar",
  "black-obsidian-natural-bracelet",
  "7-chakra-locketoverall-health",
  "black-obsidian-pyramid",
  "healing-sea-salt",
  "tiger-eye-locketself-esteem-and-confidence",
  "tiger-eye-natural-bracelet",
  "citrine-braceletmoney-and-growth",
  "money-potli-gift",
];

async function fetchProduct(slug) {
  const wpSlug = SLUG_MAP[slug] ?? slug;
  const url = `${ORIGIN}/wp-json/wc/store/v1/products?slug=${encodeURIComponent(wpSlug)}`;
  const res = await fetch(url);
  if (!res.ok) throw new Error(`GET ${url} ${res.status}`);
  const data = await res.json();
  if (!Array.isArray(data) || data.length === 0) {
    throw new Error(`No product for slug ${wpSlug} (prisma: ${slug})`);
  }
  return data[0];
}

function dedupe(urls) {
  const seen = new Set();
  return urls.filter((u) => (seen.has(u) ? false : (seen.add(u), true)));
}

async function main() {
  const out = {};
  for (const slug of SLUGS) {
    const p = await fetchProduct(slug);
    let imgs = (p.images || []).map((i) => i.src).filter(Boolean);
    if (imgs.length === 0) {
      throw new Error(`No images for ${slug}`);
    }
    const override = PRIMARY_OVERRIDE[slug];
    if (override) {
      imgs = dedupe([override, ...imgs.filter((u) => u !== override)]);
    }
    out[slug] = imgs;
    console.error(slug, "->", imgs[0]);
  }
  fs.writeFileSync(OUT, JSON.stringify(out, null, 2) + "\n", "utf8");
  console.error("Wrote", OUT);
}

main().catch((e) => {
  console.error(e);
  process.exit(1);
});
