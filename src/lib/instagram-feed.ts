/**
 * Fetches recent media for an Instagram professional (Business / Creator) account
 * via the Meta Instagram API (Page-linked token).
 *
 * Set in .env:
 * - INSTAGRAM_ACCESS_TOKEN — long-lived User or Page access token with instagram_basic
 *   (and the IG account linked to a Facebook Page you manage).
 * - INSTAGRAM_USER_ID — Instagram Business Account ID (numeric), from Meta App Dashboard
 *   or Graph API explorer (not the @username).
 *
 * @see https://developers.facebook.com/docs/instagram-platform/instagram-graph-api/reference/ig-user/media
 */

export type InstagramMediaItem = {
  id: string;
  permalink: string;
  imageUrl: string;
  caption: string | null;
};

type GraphEdge = { data?: Record<string, unknown>[] };
type GraphMedia = {
  id?: string;
  media_type?: string;
  media_url?: string;
  permalink?: string;
  thumbnail_url?: string;
  caption?: string;
  children?: GraphEdge;
};

function imageUrlFromMedia(m: GraphMedia): string | null {
  const type = m.media_type;
  if (type === "VIDEO") return (m.thumbnail_url as string | undefined) || (m.media_url as string | undefined) || null;
  if (type === "CAROUSEL_ALBUM") {
    const first = m.children?.data?.[0] as GraphMedia | undefined;
    if (!first) return null;
    return imageUrlFromMedia({ ...first, media_type: first.media_type || "IMAGE" });
  }
  return (m.media_url as string | undefined) || null;
}

function mapMedia(raw: GraphMedia): InstagramMediaItem | null {
  const imageUrl = imageUrlFromMedia(raw);
  const permalink = raw.permalink as string | undefined;
  if (!imageUrl || !permalink) return null;
  return {
    id: String(raw.id ?? permalink),
    permalink,
    imageUrl,
    caption: raw.caption != null ? String(raw.caption) : null,
  };
}

export async function fetchInstagramRecentMedia(limit = 9): Promise<InstagramMediaItem[]> {
  const token = process.env.INSTAGRAM_ACCESS_TOKEN?.trim();
  const userId = process.env.INSTAGRAM_USER_ID?.trim();
  if (!token || !userId) return [];

  const fields = [
    "id",
    "media_type",
    "media_url",
    "permalink",
    "thumbnail_url",
    "caption",
    "children{media_type,media_url,thumbnail_url}",
  ].join(",");

  const url = new URL(`https://graph.facebook.com/v21.0/${userId}/media`);
  url.searchParams.set("fields", fields);
  url.searchParams.set("limit", String(Math.min(limit, 25)));
  url.searchParams.set("access_token", token);

  try {
    const res = await fetch(url.toString(), { next: { revalidate: 1800 } });
    if (!res.ok) {
      const t = await res.text();
      console.error("[instagram-feed] Graph API error", res.status, t.slice(0, 300));
      return [];
    }
    const json = (await res.json()) as { data?: GraphMedia[] };
    const rows = json.data ?? [];
    return rows.map(mapMedia).filter((x): x is InstagramMediaItem => x != null).slice(0, limit);
  } catch (e) {
    console.error("[instagram-feed] fetch failed", e);
    return [];
  }
}
