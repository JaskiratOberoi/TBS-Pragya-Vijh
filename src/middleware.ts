import { withAuth } from "next-auth/middleware";

export default withAuth({
  callbacks: {
    authorized: ({ token, req }) => {
      if (!req.nextUrl.pathname.startsWith("/admin")) return true;
      return token?.role === "ADMIN";
    },
  },
  pages: { signIn: "/account" },
});

export const config = {
  matcher: ["/admin/:path*"],
};
