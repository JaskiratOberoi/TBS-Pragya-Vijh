import { getBusinessSettings } from "@/lib/strapi-queries";

export async function getPixelConfig() {
  const s = await getBusinessSettings();
  if (!s) return { pixelId: null as string | null, enabled: false };
  return {
    pixelId: (s.fbPixelId as string) ?? null,
    enabled: Boolean(s.fbPixelEnabled),
  };
}

/** Returns pixel ID for layout when enabled, else null. */
export async function getFacebookPixelIdForSite() {
  const c = await getPixelConfig();
  return c.enabled && c.pixelId ? c.pixelId : null;
}
