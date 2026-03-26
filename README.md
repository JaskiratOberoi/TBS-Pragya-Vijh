# The Blissful Soul — Next.js full-stack

Standalone e-commerce + bookings app (Next.js 14, Prisma, PostgreSQL, Razorpay, NextAuth).

## Prerequisites

- Node 20+
- Docker Desktop (optional, for Compose stack)

## Setup

```bash
cd blissful-soul
npm install
cp .env.example .env
# Edit .env: DATABASE_URL, NEXTAUTH_SECRET, Razorpay keys, SMTP, etc.
npx prisma migrate dev --name init
npx prisma db seed
npm run dev
```

Open [http://localhost:3000](http://localhost:3000).

**Default admin (from seed):** `admin@theblissfulsoul.com` / `ChangeMe123!`

## Docker

```bash
docker compose -f docker-compose.yml -f docker-compose.dev.yml up --build
```

Then run migrations/seed inside the app container (see plan).

## Environment variables

See `.env.example` for `DATABASE_URL`, `NEXTAUTH_URL`, `NEXTAUTH_SECRET`, Razorpay, SMTP, `ADMIN_EMAIL`, optional `NEXT_PUBLIC_FB_PIXEL_ID`, `CRON_SECRET` for `/api/cron/send-reminders`.

## Project notes

- Guest cart uses HTTP-only cookie `bs_cart_sid`; logged-in users merge on first session load.
- Checkout and bookings require a signed-in user (schema uses `userId` on orders/bookings).
- Google Calendar, PDF invoices, and full admin CRUD can be extended per the product plan; core APIs and flows are scaffolded.

## Scripts

- `npm run dev` — development server
- `npm run build` — production build (runs `prisma generate`)
- `npm run db:migrate` / `npm run db:seed` / `npm run db:studio`
