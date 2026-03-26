import { cookies } from "next/headers";
import { randomUUID } from "crypto";
import type { NextResponse } from "next/server";

export const CART_COOKIE = "bs_cart_sid";

export function getCartSessionIdFromCookies(): string | undefined {
  return cookies().get(CART_COOKIE)?.value;
}

export function attachCartCookie(res: NextResponse, sessionId: string) {
  res.cookies.set(CART_COOKIE, sessionId, {
    httpOnly: true,
    sameSite: "lax",
    secure: process.env.NODE_ENV === "production",
    path: "/",
    maxAge: 60 * 60 * 24 * 365,
  });
}

export function newCartSessionId() {
  return randomUUID();
}
