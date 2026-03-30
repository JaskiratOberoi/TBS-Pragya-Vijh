# Database backups

Plain `pg_dump` SQL files (no owner/ACL) for restoring catalog data.

| File | Database | Contents |
|------|----------|----------|
| `strapi-full-*.sql` | `strapi` on `strapi-db` | Full Strapi CMS DB: products, services, categories, variants, shipping classes, settings, users-permissions, etc. |
| `legacy-prisma-full-*.sql` | `blissful_soul` on legacy `db` | Original Prisma schema and rows (source used for Strapi import). |

## Restore Strapi database (example)

```bash
# From host, with strapi-db container running:
docker exec -i blissful-soul-strapi-db-1 psql -U strapi -d strapi < backups/strapi-full-YYYY-MM-DD.sql
```

Use a fresh database or drop/recreate `strapi` first if you need a clean restore.

## Restore legacy Prisma database (example)

```bash
docker exec -i blissful-soul-db-1 psql -U blissful -d blissful_soul < backups/legacy-prisma-full-YYYY-MM-DD.sql
```

Regenerate backups after major catalog changes:

```bash
docker exec blissful-soul-strapi-db-1 pg_dump -U strapi --no-owner --no-acl strapi > backups/strapi-full-$(date +%F).sql
docker exec blissful-soul-db-1 pg_dump -U blissful --no-owner --no-acl blissful_soul > backups/legacy-prisma-full-$(date +%F).sql
```
