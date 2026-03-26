/**
 * One-off: crawl live site for wp-content/uploads URLs, resolve files from local
 * WordPress uploads tree or download from LIVE_ORIGIN. Writes public/assets/wp-mirror/*
 * and prisma/data/media-manifest.json (idempotent).
 *
 * Env:
 *   LIVE_ORIGIN          default https://bm3.bad.myftpupload.com
 *   LOCAL_UPLOADS_ROOT   optional absolute path to .../wp-content/uploads (copy-first)
 *
 * Run: node scripts/sync-media-from-live.mjs
 */
import fs from "fs";
import path from "path";
import { fileURLToPath } from "url";

const __dirname = path.dirname(fileURLToPath(import.meta.url));
const ROOT = path.resolve(__dirname, "..");
const OUT_MIRROR = path.join(ROOT, "public", "assets", "wp-mirror");
const OUT_INSTAGRAM = path.join(ROOT, "public", "assets", "instagram");
const MANIFEST_PATH = path.join(ROOT, "prisma", "data", "media-manifest.json");

const LIVE_ORIGIN = (process.env.LIVE_ORIGIN || "https://bm3.bad.myftpupload.com").replace(/\/$/, "");
const LOCAL_ROOT = process.env.LOCAL_UPLOADS_ROOT || "";

const PRODUCT_SLUGS = [
  "money-magnet",
  "genie-bracelet",
  "crystal-charger-selenite-plate",
  "healing-sea-salt",
  "money-pyramid",
  "amethyst-natural-bracelet",
  "rose-quartz-natural-bracelet",
  "black-obsidian-tumbles-negativity-evil-eye",
];

const START_URLS = [
  `${LIVE_ORIGIN}/`,
  `${LIVE_ORIGIN}/shop/`,
  ...PRODUCT_SLUGS.map((s) => `${LIVE_ORIGIN}/product/${s}/`),
];

const RE_PATH = /\/wp-content\/uploads\/[^\s"'<>)]+/gi;
const RE_DIM = /-(\d+)x(\d+)(\.[^.]+)$/i;

function sleep(ms) {
  return new Promise((r) => setTimeout(r, ms));
}

function normalizePath(u) {
  const s = u.replace(/^https?:\/\/[^/]+/i, "").split("?")[0];
  if (!s.startsWith("/wp-content/uploads/")) return null;
  if (s.includes("*")) return null;
  return s.slice(1); // wp-content/uploads/...
}

function parseDims(relPath) {
  const base = path.basename(relPath);
  const m = base.match(RE_DIM);
  if (!m) return { relPath, w: 99999, h: 99999 };
  return {
    relPath,
    w: parseInt(m[1], 10),
    h: parseInt(m[2], 10),
  };
}

/** Group variants (same logical file); pick largest under maxW. */
function pickBestVariant(paths, maxW = 1200) {
  const parsed = paths.map(parseDims).filter((p) => p.w <= maxW && p.h <= maxW * 2);
  if (parsed.length === 0) {
    const fallback = paths.map(parseDims).sort((a, b) => b.w * b.h - a.w * a.h);
    return fallback[0]?.relPath ?? paths[0];
  }
  parsed.sort((a, b) => b.w * b.h - a.w * a.h);
  return parsed[0].relPath;
}

function baseKey(relPath) {
  const base = path.basename(relPath);
  return base.replace(RE_DIM, "$3");
}

async function fetchText(url) {
  const res = await fetch(url, { redirect: "follow" });
  if (!res.ok) throw new Error(`GET ${url} ${res.status}`);
  return res.text();
}

async function fetchBinary(url) {
  const res = await fetch(url, { redirect: "follow" });
  if (!res.ok) throw new Error(`GET ${url} ${res.status}`);
  return Buffer.from(await res.arrayBuffer());
}

const IMAGE_EXT = /\.(avif|webp|jpe?g|png|gif|svg)(\?|$)/i;

function collectUrls(html) {
  const set = new Set();
  let m;
  const re = new RegExp(RE_PATH.source, "gi");
  while ((m = re.exec(html)) !== null) {
    const n = normalizePath(m[0]);
    if (n && IMAGE_EXT.test(n)) set.add(n);
  }
  return [...set];
}

function diskRelFromUpload(relPath) {
  return relPath.replace(/^wp-content\/uploads\//, "");
}

async function ensureFile(relPath) {
  const diskRel = diskRelFromUpload(relPath);
  const dest = path.join(OUT_MIRROR, diskRel);
  const dir = path.dirname(dest);
  fs.mkdirSync(dir, { recursive: true });

  const localSrc = LOCAL_ROOT ? path.join(LOCAL_ROOT, diskRel) : "";
  if (localSrc && fs.existsSync(localSrc)) {
    fs.copyFileSync(localSrc, dest);
    return { relPath, source: "local", dest };
  }

  const url = `${LIVE_ORIGIN}/${relPath}`;
  const buf = await fetchBinary(url);
  fs.writeFileSync(dest, buf);
  await sleep(150);
  return { relPath, source: "remote", dest };
}

function logicalAliases() {
  /** After mirror exists, map stable keys for app/seed. */
  return [
    { logicalKey: "logo:main", mirrorRel: "wp-content/uploads/2025/08/Bliss-Soul-Logo.png", usedOn: ["nav", "footer"] },
    {
      logicalKey: "hero:pragya",
      mirrorRel: "wp-content/uploads/2025/09/WhatsApp-Image-2025-08-30-at-2.03.56-PM-1-scaled-e1756997216538.jpeg",
      usedOn: ["home"],
    },
    {
      logicalKey: "banner:home-sale",
      mirrorRel: "wp-content/uploads/2025/09/Banner_20250909_094209_0000-1300x390.png",
      usedOn: ["home"],
    },
  ];
}

function mirrorToPublicPath(mirrorRel) {
  return `/assets/wp-mirror/${mirrorRel.replace(/^wp-content\/uploads\//, "")}`;
}

async function copyInstagramTiles() {
  fs.mkdirSync(OUT_INSTAGRAM, { recursive: true });
  const entries = [];
  for (let i = 1; i <= 12; i++) {
    const rel = `wp-content/uploads/2025/08/basic-inst-${i}.jpg`;
    const dest = path.join(OUT_INSTAGRAM, `${String(i).padStart(2, "0")}.jpg`);
    const fullRel = rel;
    const srcMirror = path.join(OUT_MIRROR, diskRelFromUpload(fullRel));
    if (!fs.existsSync(srcMirror)) {
      await ensureFile(fullRel);
    }
    fs.copyFileSync(srcMirror, dest);
    entries.push({
      logicalKey: `instagram:${String(i).padStart(2, "0")}`,
      sourceUrl: `${LIVE_ORIGIN}/${fullRel}`,
      localPath: `/assets/instagram/${String(i).padStart(2, "0")}.jpg`,
      usedOn: ["home:instagram"],
    });
  }
  return entries;
}

async function main() {
  fs.mkdirSync(path.dirname(MANIFEST_PATH), { recursive: true });
  fs.mkdirSync(OUT_MIRROR, { recursive: true });

  const allHtmlUrls = new Set();
  for (const url of START_URLS) {
    try {
      const html = await fetchText(url);
      for (const p of collectUrls(html)) allHtmlUrls.add(p);
      await sleep(200);
    } catch (e) {
      console.warn("Skip URL", url, e.message);
    }
  }

  const byBase = new Map();
  for (const rel of allHtmlUrls) {
    const key = path.join(path.dirname(rel), baseKey(rel));
    if (!byBase.has(key)) byBase.set(key, []);
    byBase.get(key).push(rel);
  }

  const chosen = [];
  for (const [, variants] of byBase) {
    chosen.push(pickBestVariant(variants));
  }

  const manifestEntries = [];
  const copied = new Set();

  for (const relPath of chosen) {
    if (copied.has(relPath)) continue;
    copied.add(relPath);
    try {
      const { source } = await ensureFile(relPath);
      manifestEntries.push({
        logicalKey: `crawl:${relPath}`,
        sourceUrl: `${LIVE_ORIGIN}/${relPath}`,
        localPath: mirrorToPublicPath(relPath),
        usedOn: ["crawl"],
        resolvedFrom: source,
      });
    } catch (e) {
      console.warn("Failed file", relPath, e.message);
    }
  }

  for (const alias of logicalAliases()) {
    if (!copied.has(alias.mirrorRel)) {
      try {
        const { source } = await ensureFile(alias.mirrorRel);
        copied.add(alias.mirrorRel);
        manifestEntries.push({
          logicalKey: `crawl:${alias.mirrorRel}`,
          sourceUrl: `${LIVE_ORIGIN}/${alias.mirrorRel}`,
          localPath: mirrorToPublicPath(alias.mirrorRel),
          usedOn: ["crawl"],
          resolvedFrom: source,
        });
      } catch (e) {
        console.warn("Alias fetch", alias.mirrorRel, e.message);
      }
    }
    manifestEntries.push({
      logicalKey: alias.logicalKey,
      sourceUrl: `${LIVE_ORIGIN}/${alias.mirrorRel}`,
      localPath: mirrorToPublicPath(alias.mirrorRel),
      usedOn: alias.usedOn,
    });
  }

  const ig = await copyInstagramTiles();
  manifestEntries.push(...ig);

  const manifest = {
    generatedAt: new Date().toISOString(),
    liveOrigin: LIVE_ORIGIN,
    localUploadsRoot: LOCAL_ROOT || null,
    entries: manifestEntries,
  };
  fs.writeFileSync(MANIFEST_PATH, JSON.stringify(manifest, null, 2), "utf8");
  console.log("Wrote", MANIFEST_PATH, "entries:", manifestEntries.length);
}

main().catch((e) => {
  console.error(e);
  process.exit(1);
});
