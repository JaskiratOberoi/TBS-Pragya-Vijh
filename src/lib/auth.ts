import type { NextAuthOptions } from "next-auth";
import CredentialsProvider from "next-auth/providers/credentials";
export const authOptions: NextAuthOptions = {
  secret: process.env.NEXTAUTH_SECRET,
  session: { strategy: "jwt", maxAge: 30 * 24 * 60 * 60 },
  pages: { signIn: "/account" },
  providers: [
    CredentialsProvider({
      name: "credentials",
      credentials: {
        email: { label: "Email", type: "email" },
        password: { label: "Password", type: "password" },
      },
      async authorize(credentials) {
        if (!credentials?.email || !credentials?.password) return null;
        const base = process.env.STRAPI_API_URL ?? process.env.NEXT_PUBLIC_STRAPI_URL ?? "http://localhost:1337";
        const res = await fetch(`${base.replace(/\/$/, "")}/api/auth/local`, {
          method: "POST",
          headers: { "Content-Type": "application/json" },
          body: JSON.stringify({
            identifier: credentials.email.toLowerCase().trim(),
            password: credentials.password,
          }),
        });
        const data = (await res.json()) as {
          jwt?: string;
          user?: {
            id?: number;
            documentId?: string;
            email?: string;
            username?: string;
            appRole?: string;
          };
          error?: { message?: string };
        };
        if (!res.ok || !data.user) return null;
        const u = data.user;
        return {
          id: String(u.documentId ?? u.id),
          email: u.email ?? credentials.email,
          name: u.username ?? u.email ?? "",
          role: u.appRole ?? "USER",
        };
      },
    }),
  ],
  callbacks: {
    async jwt({ token, user }) {
      if (user) {
        token.id = user.id;
        token.role = (user as { role?: string }).role;
      }
      return token;
    },
    async session({ session, token }) {
      if (session.user) {
        session.user.id = token.id as string;
        session.user.role = token.role as string;
      }
      return session;
    },
  },
};
