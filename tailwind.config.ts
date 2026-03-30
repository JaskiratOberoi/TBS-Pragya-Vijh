import type { Config } from "tailwindcss";

const config: Config = {
  darkMode: ["class"],
  content: [
    "./src/pages/**/*.{js,ts,jsx,tsx,mdx}",
    "./src/components/**/*.{js,ts,jsx,tsx,mdx}",
    "./src/app/**/*.{js,ts,jsx,tsx,mdx}",
  ],
  theme: {
    extend: {
      fontFamily: {
        sans: ["var(--font-sans)", "system-ui", "sans-serif"],
        serif: ["var(--font-serif)", "Georgia", "serif"],
        display: ["var(--font-display)", "var(--font-serif)", "Georgia", "serif"],
      },
      letterSpacing: {
        display: "var(--tracking-display)",
        luxury: "var(--tracking-wide)",
      },
      colors: {
        border: "hsl(var(--border))",
        input: "hsl(var(--input))",
        ring: "hsl(var(--ring))",
        background: "hsl(var(--background))",
        foreground: "hsl(var(--foreground))",
        primary: {
          DEFAULT: "hsl(var(--primary))",
          foreground: "hsl(var(--primary-foreground))",
        },
        secondary: {
          DEFAULT: "hsl(var(--secondary))",
          foreground: "hsl(var(--secondary-foreground))",
        },
        muted: {
          DEFAULT: "hsl(var(--muted))",
          foreground: "hsl(var(--muted-foreground))",
        },
        accent: {
          DEFAULT: "hsl(var(--accent))",
          foreground: "hsl(var(--accent-foreground))",
        },
        destructive: {
          DEFAULT: "hsl(var(--destructive))",
          foreground: "hsl(var(--destructive-foreground))",
        },
        card: {
          DEFAULT: "hsl(var(--card))",
          foreground: "hsl(var(--card-foreground))",
        },
        metal: {
          DEFAULT: "hsl(var(--metal))",
          foreground: "hsl(var(--metal-foreground))",
          muted: "hsl(var(--metal-muted))",
        },
        inverse: {
          DEFAULT: "hsl(var(--surface-inverse))",
          foreground: "hsl(var(--surface-inverse-foreground))",
          muted: "hsl(var(--surface-inverse-muted))",
        },
        elevated: "hsl(var(--surface-elevated))",
        bento: {
          mint: "hsl(var(--bento-mint))",
          peach: "hsl(var(--bento-peach))",
          cream: "hsl(var(--bento-cream))",
          canvas: "hsl(var(--bento-canvas))",
        },
      },
      borderRadius: {
        lg: "var(--radius)",
        md: "calc(var(--radius) - 2px)",
        sm: "calc(var(--radius) - 4px)",
        dense: "0.75rem",
        "3xl": "1.5rem",
        "4xl": "2rem",
      },
      boxShadow: {
        bento: "0 4px 24px -4px hsl(270 28% 8% / 0.07), 0 2px 8px -2px hsl(270 28% 8% / 0.05)",
        "bento-sm": "0 2px 12px -2px hsl(270 28% 8% / 0.06)",
        "elevation-rest": "0 1px 2px hsl(270 28% 8% / 0.04), 0 4px 16px -4px hsl(270 28% 8% / 0.08)",
        "elevation-hover": "0 8px 28px -6px hsl(270 28% 8% / 0.12), 0 2px 8px -2px hsl(270 28% 8% / 0.06)",
        "elevation-float": "0 24px 48px -12px hsl(270 28% 8% / 0.18), 0 8px 16px -6px hsl(270 28% 8% / 0.08)",
        header: "0 1px 0 hsl(270 8% 88% / 0.9), 0 8px 32px -8px hsl(270 28% 8% / 0.06)",
      },
    },
  },
  plugins: [require("tailwindcss-animate")],
};

export default config;
