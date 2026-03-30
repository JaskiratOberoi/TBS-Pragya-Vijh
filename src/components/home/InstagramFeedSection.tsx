import { Instagram } from "lucide-react";
import { Button } from "@/components/ui/button";
import { fetchInstagramRecentMedia } from "@/lib/instagram-feed";
import { INSTAGRAM_HANDLE, INSTAGRAM_PROFILE_URL } from "@/lib/instagram-profile";
import { cn } from "@/lib/utils";

const WIDGET_SRC = process.env.NEXT_PUBLIC_INSTAGRAM_WIDGET_SRC?.trim();

function captionAlt(caption: string | null, index: number): string {
  if (!caption) return `Instagram post ${index + 1} from ${INSTAGRAM_HANDLE}`;
  const line = caption.split("\n")[0]?.trim() ?? caption;
  return line.length > 120 ? `${line.slice(0, 117)}…` : line;
}

export async function InstagramFeedSection() {
  if (WIDGET_SRC) {
    return (
      <section className="section-cream-glow border-t border-border/60 bg-bento-cream/50 py-16 md:py-24">
        <div className="mx-auto max-w-7xl px-4">
          <p className="text-center text-xs font-medium uppercase tracking-luxury text-muted-foreground">Social</p>
          <h2 className="mt-2 text-center font-display text-2xl font-semibold tracking-display text-foreground md:text-3xl">
            Instagram
          </h2>
          <p className="mx-auto mt-2 max-w-lg text-center text-sm text-muted-foreground">
            Latest from {INSTAGRAM_HANDLE}
          </p>
          <div className="mx-auto mt-10 max-w-3xl overflow-hidden rounded-2xl border border-border/50 bg-card shadow-elevation-rest">
            <div className="relative aspect-[4/5] w-full sm:aspect-[16/10]">
              <iframe
                title="Instagram feed"
                src={WIDGET_SRC}
                className="absolute inset-0 h-full w-full border-0"
                loading="lazy"
                allowTransparency
              />
            </div>
          </div>
          <div className="mt-8 text-center">
            <Button asChild variant="outline" className="rounded-full border-border/80">
              <a href={INSTAGRAM_PROFILE_URL} target="_blank" rel="noopener noreferrer">
                Open {INSTAGRAM_HANDLE}
              </a>
            </Button>
          </div>
        </div>
      </section>
    );
  }

  const items = await fetchInstagramRecentMedia(9);

  return (
    <section className="section-cream-glow border-t border-border/60 bg-bento-cream/50 py-16 md:py-24">
      <div className="mx-auto max-w-7xl px-4">
        <p className="text-center text-xs font-medium uppercase tracking-luxury text-muted-foreground">Social</p>
        <h2 className="mt-2 text-center font-display text-2xl font-semibold tracking-display text-foreground md:text-3xl">
          Follow the practice
        </h2>
        <p className="mx-auto mt-2 max-w-lg text-center text-sm text-muted-foreground">
          Daily guidance and behind-the-scenes on Instagram — {INSTAGRAM_HANDLE.replace("@", "")}
        </p>

        {items.length > 0 ? (
          <div className="mx-auto mt-10 grid max-w-4xl grid-cols-2 gap-3 sm:grid-cols-3 sm:gap-4">
            {items.map((item, i) => (
              <a
                key={item.id}
                href={item.permalink}
                target="_blank"
                rel="noopener noreferrer"
                className={cn(
                  "group relative aspect-[4/5] overflow-hidden rounded-2xl border border-border/50 bg-muted shadow-elevation-rest",
                  "transition-shadow duration-300 hover:shadow-elevation-hover"
                )}
              >
                {/* eslint-disable-next-line @next/next/no-img-element -- Instagram CDN hostnames vary; avoid brittle remotePatterns */}
                <img
                  src={item.imageUrl}
                  alt={captionAlt(item.caption, i)}
                  className="h-full w-full object-cover transition-transform duration-500 group-hover:scale-[1.04]"
                  loading={i < 3 ? "eager" : "lazy"}
                  sizes="(max-width: 640px) 50vw, 33vw"
                />
                <span className="absolute inset-0 flex items-center justify-center bg-inverse/0 opacity-0 transition-all duration-300 group-hover:bg-inverse/35 group-hover:opacity-100">
                  <Instagram className="h-10 w-10 text-inverse-foreground drop-shadow-md" aria-hidden />
                  <span className="sr-only">View on Instagram</span>
                </span>
              </a>
            ))}
          </div>
        ) : (
          <div className="mx-auto mt-10 max-w-xl rounded-2xl border border-dashed border-border/70 bg-card/50 px-6 py-10 text-center shadow-elevation-rest">
            <Instagram className="mx-auto h-12 w-12 text-metal-muted" aria-hidden />
            <p className="mt-4 text-sm leading-relaxed text-muted-foreground">
              Visit {INSTAGRAM_HANDLE} on Instagram for daily guidance, sessions, and new arrivals. A live grid appears
              here once the feed is connected for this site.
            </p>
            {process.env.NODE_ENV === "development" && (
              <p className="mt-3 text-xs text-muted-foreground/80">
                Dev: set <span className="font-mono">INSTAGRAM_ACCESS_TOKEN</span> +{" "}
                <span className="font-mono">INSTAGRAM_USER_ID</span>, or{" "}
                <span className="font-mono">NEXT_PUBLIC_INSTAGRAM_WIDGET_SRC</span> — see .env.example.
              </p>
            )}
            <Button asChild className="mt-6 rounded-full">
              <a href={INSTAGRAM_PROFILE_URL} target="_blank" rel="noopener noreferrer">
                View {INSTAGRAM_HANDLE} on Instagram
              </a>
            </Button>
          </div>
        )}

        <div className="mt-10 text-center">
          <Button asChild variant="outline" className="rounded-full border-border/80">
            <a href={INSTAGRAM_PROFILE_URL} target="_blank" rel="noopener noreferrer">
              {INSTAGRAM_HANDLE}
            </a>
          </Button>
        </div>
      </div>
    </section>
  );
}
