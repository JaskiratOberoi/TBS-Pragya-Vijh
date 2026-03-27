# Strapi 5 — multi-stage production image
FROM node:20-alpine AS deps
WORKDIR /opt/app
COPY package.json package-lock.json* ./
RUN if [ -f package-lock.json ]; then npm ci; else npm install; fi

FROM node:20-alpine AS builder
WORKDIR /opt/app
COPY --from=deps /opt/app/node_modules ./node_modules
COPY . .
ENV NODE_ENV=production
RUN npm run build
# TS projects load config from distDir/config (see @strapi/strapi start.js + loadConfiguration)
RUN cp -r config dist/config

FROM node:20-alpine AS runner
WORKDIR /opt/app
ENV NODE_ENV=production
RUN addgroup --system --gid 1001 strapi && adduser --system --uid 1001 strapi
COPY --from=builder --chown=strapi:strapi /opt/app ./
USER root
RUN mkdir -p /opt/app/database/migrations && chown -R strapi:strapi /opt/app/database
USER strapi
EXPOSE 1337
CMD ["npm", "run", "start"]
