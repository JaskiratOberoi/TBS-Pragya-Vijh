"use client";

import Script from "next/script";
import { usePathname } from "next/navigation";
import { useEffect } from "react";

declare global {
  interface Window {
    fbq?: (...args: unknown[]) => void;
  }
}

type Props = { pixelId?: string | null };

export function FbPixel({ pixelId: pixelIdProp }: Props) {
  const id = pixelIdProp ?? process.env.NEXT_PUBLIC_FB_PIXEL_ID ?? null;
  const pathname = usePathname();

  useEffect(() => {
    if (!id || typeof window === "undefined" || !window.fbq) return;
    window.fbq("track", "PageView");
  }, [pathname, id]);

  if (!id) return null;

  return (
    <>
      <Script id="fb-pixel" strategy="afterInteractive">
        {`
          !function(f,b,e,v,n,t,s){if(f.fbq)return;n=f.fbq=function(){n.callMethod?
          n.callMethod.apply(n,arguments):n.queue.push(arguments)};if(!f._fbq)f._fbq=n;
          n.push=n;n.loaded=!0;n.version='2.0';n.queue=[];t=b.createElement(e);t.async=!0;
          t.src=v;s=b.getElementsByTagName(e)[0];s.parentNode.insertBefore(t,s)}(window,
          document,'script','https://connect.facebook.net/en_US/fbevents.js');
          fbq('init', '${id}');
        `}
      </Script>
    </>
  );
}
