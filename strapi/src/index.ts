import type { Core } from "@strapi/types";
import { ensureDefaultSingleTypes, grantStorefrontPublicPermissions } from "./bootstrap/storefront-access";
import { migrateLegacyCatalogIfEnabled } from "./bootstrap/migrate-legacy-catalog";

export default {
  register(/* { strapi } */) {},

  async bootstrap({ strapi }: { strapi: Core.Strapi }) {
    await ensureDefaultSingleTypes(strapi);
    await grantStorefrontPublicPermissions(strapi);
    await migrateLegacyCatalogIfEnabled(strapi);
  },
};
