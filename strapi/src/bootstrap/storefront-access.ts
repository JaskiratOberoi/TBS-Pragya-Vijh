import type { Core } from "@strapi/types";

/** Never expose these via the Public role (orders, carts, PII, internals). */
const DENY_PUBLIC_READ = new Set([
  "order",
  "order-item",
  "order-shipment",
  "invoice",
  "cart-item",
  "wishlist-item",
  "booking",
  "digital-purchase",
  "password-reset-token",
  "coupon-usage",
  "email-log",
  "scheduled-reminder",
]);

function shouldGrantPublicAction(
  apiFolder: string,
  controllerName: string,
  actionName: string
): boolean {
  if (DENY_PUBLIC_READ.has(controllerName)) return false;
  if (actionName === "find" || actionName === "findOne") return true;
  if (
    apiFolder === "commerce-placeholder" &&
    controllerName === "commerce" &&
    (actionName === "createOrder" || actionName === "verifyPayment")
  ) {
    return true;
  }
  if (controllerName === "contact-message" && actionName === "create") return true;
  return false;
}

export async function ensureDefaultSingleTypes(strapi: Core.Strapi) {
  const businessUid = "api::business-setting.business-setting" as const;
  const bookingUid = "api::booking-setting.booking-setting" as const;

  const existingBusiness = await strapi.documents(businessUid).findFirst({});
  if (!existingBusiness) {
    await strapi.documents(businessUid).create({
      data: {
        businessName: "The Blissful Soul",
        address: "Delhi, India",
        state: "Delhi",
        stateCode: "07",
        phone: "+910000000000",
        email: "contact@theblissfulsoul.com",
      },
    });
    strapi.log.info("[storefront-bootstrap] created default business-setting (edit in Admin)");
  }

  const existingBooking = await strapi.documents(bookingUid).findFirst({});
  if (!existingBooking) {
    await strapi.documents(bookingUid).create({ data: {} });
    strapi.log.info("[storefront-bootstrap] created default booking-setting (edit in Admin)");
  }
}

/**
 * Grant Public role read (and safe writes) needed by the Next.js storefront.
 * Idempotent: only creates missing permission rows.
 */
export async function grantStorefrontPublicPermissions(strapi: Core.Strapi) {
  const publicRole = await strapi.db
    .query("plugin::users-permissions.role")
    .findOne({ where: { type: "public" } });

  if (!publicRole) {
    strapi.log.warn("[storefront-bootstrap] public role missing; skip permissions");
    return;
  }

  const permDb = strapi.db.query("plugin::users-permissions.permission");
  const existingRows = await permDb.findMany({
    where: { role: { id: publicRole.id } },
  });
  const existing = new Set(existingRows.map((p: { action: string }) => p.action));

  const up = strapi.plugin("users-permissions").service("users-permissions") as {
    getActions: (opts?: { defaultEnable?: boolean }) => Record<string, { controllers?: Record<string, Record<string, unknown>> }>;
  };
  const tree = up.getActions({ defaultEnable: false });

  const toCreate: Array<{ action: string; role: number }> = [];

  for (const [typeKey, spec] of Object.entries(tree)) {
    if (!typeKey.startsWith("api::") || !spec.controllers) continue;
    const apiFolder = typeKey.slice("api::".length);

    for (const [controllerName, actions] of Object.entries(spec.controllers)) {
      for (const actionName of Object.keys(actions)) {
        if (!shouldGrantPublicAction(apiFolder, controllerName, actionName)) continue;
        const action = `${typeKey}.${controllerName}.${actionName}`;
        if (!existing.has(action)) {
          toCreate.push({ action, role: publicRole.id });
          existing.add(action);
        }
      }
    }
  }

  for (const row of toCreate) {
    await permDb.create({ data: row });
  }

  if (toCreate.length > 0) {
    strapi.log.info(`[storefront-bootstrap] granted ${toCreate.length} new Public permissions`);
  }
}
