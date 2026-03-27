/**
 * Custom commerce actions (orders, payments). Uses Document Service API (Strapi 5).
 */
import { verifyRzpSignature, fetchPaymentDetails } from "../../../services/razorpay";
import { sendOrderEmails } from "../../../services/email";

type StrapiWithDocs = {
  documents: (uid: string) => {
    findOne: (p: Record<string, unknown>) => Promise<Record<string, unknown> | null>;
    findFirst: (p: Record<string, unknown>) => Promise<Record<string, unknown> | null>;
    findMany: (p: Record<string, unknown>) => Promise<Record<string, unknown>[]>;
    create: (p: Record<string, unknown>) => Promise<Record<string, unknown>>;
    update: (p: Record<string, unknown>) => Promise<Record<string, unknown>>;
    delete: (p: Record<string, unknown>) => Promise<Record<string, unknown>>;
  };
};

function getStrapi(ctx: { state?: { strapi?: StrapiWithDocs }; strapi?: StrapiWithDocs }): StrapiWithDocs {
  const s = ctx.state?.strapi ?? ctx.strapi;
  if (!s) throw new Error("strapi missing on context");
  return s;
}

function assertCommerceSecret(ctx: unknown): boolean {
  if (typeof ctx !== "object" || ctx === null) return false;
  const c = ctx as {
    get?: (k: string) => string | undefined;
    request?: { header?: Record<string, string> };
  };
  const raw = c.get?.("x-commerce-secret") ?? c.request?.header?.["x-commerce-secret"];
  const expected = process.env.COMMERCE_INTERNAL_SECRET;
  return Boolean(expected && raw === expected);
}

export default {
  async createOrder(ctx: {
    state?: { strapi?: StrapiWithDocs };
    strapi?: StrapiWithDocs;
    request: { body?: Record<string, unknown> };
    throw: (status: number, msg?: string) => never;
    status?: number;
    body?: unknown;
  }) {
    if (!assertCommerceSecret(ctx)) {
      return ctx.throw(401, "Unauthorized");
    }
    const strapi = getStrapi(ctx);
    const body = ctx.request.body ?? {};
    const lines = (body.lines as Array<Record<string, unknown>>) ?? [];
    const totals = body.totals as Record<string, number> | undefined;
    if (!totals || typeof totals.totalPaise !== "number") {
      return ctx.throw(400, "Invalid totals");
    }

    const userDocumentId = (body.userDocumentId as string | null | undefined) ?? null;
    const guestName = (body.guestName as string | null | undefined) ?? null;
    const guestEmail = (body.guestEmail as string | null | undefined) ?? null;
    const guestPhone = (body.guestPhone as string | null | undefined) ?? null;
    const shippingAddress = body.shippingAddress as Record<string, unknown> | undefined;
    const billingAddress = body.billingAddress as Record<string, unknown> | undefined;
    const couponDocumentId = (body.couponDocumentId as string | null | undefined) ?? null;

    const orderData: Record<string, unknown> = {
      total: totals.totalPaise,
      subtotal: totals.subtotalPaise ?? 0,
      discount: (totals.promoDiscountPaise ?? 0) + (totals.couponDiscountPaise ?? 0),
      tax: totals.taxPaise ?? 0,
      shippingAmount: totals.shippingPaise ?? 0,
      status: "PENDING",
      paymentStatus: "PENDING",
      shippingAddress: shippingAddress ?? null,
      billingAddress: billingAddress ?? shippingAddress ?? null,
      guestName,
      guestEmail,
      guestPhone,
    };
    if (userDocumentId) orderData.user = { connect: [userDocumentId] };
    if (couponDocumentId) orderData.coupon = { connect: [couponDocumentId] };

    let order: Record<string, unknown>;
    try {
      order = await strapi.documents("api::order.order").create({ data: orderData });
    } catch (e) {
      const msg = e instanceof Error ? e.message : String(e);
      return ctx.throw(500, msg);
    }

    const orderDocId = String(order.documentId);
    try {
      for (const line of lines) {
        const pid = line.productDocumentId as string;
        await strapi.documents("api::order-item.order-item").create({
          data: {
            order: { connect: [orderDocId] },
            product: { connect: [pid] },
            quantity: Number(line.quantity ?? 1),
            unitPrice: Number(line.unitPrice ?? 0),
            variantSelection: line.variantSelection ?? null,
            gstRateBps: line.gstRateBps != null ? Number(line.gstRateBps) : 1800,
            hsnCode: (line.hsnCode as string) ?? undefined,
          },
        });
      }
      const giftLine = body.giftLine as Record<string, unknown> | null | undefined;
      if (giftLine?.productDocumentId) {
        await strapi.documents("api::order-item.order-item").create({
          data: {
            order: { connect: [orderDocId] },
            product: { connect: [String(giftLine.productDocumentId)] },
            quantity: 1,
            unitPrice: 0,
            gstRateBps: giftLine.gstRateBps != null ? Number(giftLine.gstRateBps) : 1800,
            hsnCode: (giftLine.hsnCode as string) ?? undefined,
          },
        });
      }
    } catch (e) {
      try {
        await strapi.documents("api::order.order").delete({ documentId: orderDocId });
      } catch {
        /* ignore */
      }
      const msg = e instanceof Error ? e.message : String(e);
      return ctx.throw(500, msg);
    }

    ctx.status = 201;
    ctx.body = { orderId: orderDocId };
  },

  async verifyPayment(ctx: {
    state?: { strapi?: StrapiWithDocs };
    strapi?: StrapiWithDocs;
    request: { body?: Record<string, unknown> };
    throw: (status: number, msg?: string) => never;
    status?: number;
    body?: unknown;
  }) {
    if (!assertCommerceSecret(ctx)) {
      return ctx.throw(401, "Unauthorized");
    }
    const strapi = getStrapi(ctx);
    const body = ctx.request.body ?? {};
    const orderId = body.orderId as string | undefined;
    const rzpOrderId = body.rzpOrderId as string | undefined;
    const rzpPaymentId = body.rzpPaymentId as string | undefined;
    const rzpSignature = body.rzpSignature as string | undefined;
    const sessionId = body.sessionId as string | undefined;

    if (!orderId || !rzpOrderId || !rzpPaymentId || !rzpSignature) {
      return ctx.throw(400, "Missing fields");
    }
    if (!verifyRzpSignature(rzpOrderId, rzpPaymentId, rzpSignature)) {
      return ctx.throw(400, "Invalid signature");
    }

    let order =
      (await strapi.documents("api::order.order").findOne({
        documentId: orderId,
        populate: {
          items: { populate: { product: true } },
          user: true,
          coupon: true,
        },
      })) ??
      (await strapi.documents("api::order.order").findFirst({
        filters: { legacyId: { $eq: orderId } },
        populate: {
          items: { populate: { product: true } },
          user: true,
          coupon: true,
        },
      }));

    if (!order) return ctx.throw(404, "Order not found");

    const oRzp = order.rzpOrderId as string | undefined;
    if (oRzp !== rzpOrderId) return ctx.throw(400, "Order mismatch");
    if (order.paymentStatus === "PAID") {
      ctx.body = { ok: true, orderId: order.documentId ?? orderId };
      return;
    }

    const user = order.user as Record<string, unknown> | null | undefined;
    const userDocId = user?.documentId != null ? String(user.documentId) : null;
    const guestEmail = order.guestEmail as string | undefined;
    const customerEmail = (user?.email as string | undefined) ?? guestEmail;
    if (!customerEmail) return ctx.throw(400, "Order has no customer email");

    const payment = (await fetchPaymentDetails(rzpPaymentId)) as { amount?: number; method?: string } | null;
    const paidAmount = payment && typeof payment.amount === "number" ? Number(payment.amount) : 0;
    const orderTotal = Number(order.total ?? 0);
    if (paidAmount && paidAmount !== orderTotal) {
      return ctx.throw(400, "Amount mismatch");
    }

    const business = await strapi.documents("api::business-setting.business-setting").findFirst({});
    if (!business) return ctx.throw(500, "Business settings missing");

    const invoicePrefix = (business.invoicePrefix as string) ?? "TBS";
    const nextNum = Number(business.nextInvoiceNumber ?? 1);
    const invoiceNumber = `${invoicePrefix}-${nextNum}`;

    const orderDocId = String(order.documentId ?? orderId);
    const items = (order.items as Array<Record<string, unknown>>) ?? [];

    try {
      await strapi.documents("api::order.order").update({
        documentId: orderDocId,
        data: {
          paymentStatus: "PAID",
          status: "PROCESSING",
          rzpPaymentId,
          rzpSignature,
          paymentMethod: payment?.method ? String(payment.method) : undefined,
        },
      });

      for (const line of items) {
        const prod = line.product as Record<string, unknown> | undefined;
        if (!prod) continue;
        const slug = prod.slug as string | undefined;
        const ptype = prod.productType as string | undefined;
        const productDocId = String(prod.documentId ?? "");
        if (ptype === "PHYSICAL" && slug !== "money-potli-gift" && productDocId) {
          const stock = Number(prod.stock ?? 0);
          const qty = Number(line.quantity ?? 1);
          await strapi.documents("api::product.product").update({
            documentId: productDocId,
            data: { stock: Math.max(0, stock - qty) },
          });
        }
      }

      await strapi.documents("api::business-setting.business-setting").update({
        documentId: String(business.documentId),
        data: { nextInvoiceNumber: nextNum + 1 },
      });

      const ship = (order.shippingAddress as Record<string, string> | null) ?? {};
      const buyerName =
        (user?.username as string) ||
        (user?.email as string) ||
        (order.guestName as string) ||
        (order.guestEmail as string) ||
        "Customer";
      const state = business.state as string;
      const stateCode = business.stateCode as string;

      await strapi.documents("api::invoice.invoice").create({
        data: {
          invoiceNumber,
          buyerName,
          buyerAddress: (order.shippingAddress as object) ?? {},
          buyerState: ship.state ?? state,
          buyerStateCode: ship.stateCode ?? stateCode,
          items: items as unknown as object[],
          subtotal: order.subtotal as number,
          cgst: Math.round(Number(order.tax ?? 0) / 2),
          sgst: Number(order.tax ?? 0) - Math.round(Number(order.tax ?? 0) / 2),
          igst: 0,
          totalTax: order.tax as number,
          grandTotal: order.total as number,
          placeOfSupply: state,
          isInterState: false,
          order: { connect: [orderDocId] },
        },
      });

      for (const line of items) {
        const prod = line.product as Record<string, unknown> | undefined;
        if (!prod) continue;
        const productDocId = String(prod.documentId ?? "");
        const assets = await strapi.documents("api::digital-asset.digital-asset").findMany({
          filters: { product: { documentId: { $eq: productDocId } } },
        });
        for (const a of assets) {
          const ad = a as Record<string, unknown>;
          const assetDocId = String(ad.documentId ?? "");
          const dpData: Record<string, unknown> = {
            order: { connect: [orderDocId] },
            product: { connect: [productDocId] },
            asset: { connect: [assetDocId] },
            accessUrl: (ad.url as string) ?? "",
            guestEmail: userDocId ? null : (order.guestEmail as string)?.toLowerCase() ?? null,
          };
          if (userDocId) dpData.user = { connect: [userDocId] };
          await strapi.documents("api::digital-purchase.digital-purchase").create({ data: dpData });
        }
      }

      const coupon = order.coupon as Record<string, unknown> | null | undefined;
      const couponDocId = coupon?.documentId != null ? String(coupon.documentId) : null;
      if (couponDocId && coupon) {
        const used = Number(coupon.usedCount ?? 0);
        await strapi.documents("api::coupon-code.coupon-code").update({
          documentId: couponDocId,
          data: { usedCount: used + 1 },
        });
        const usageData: Record<string, unknown> = {
          coupon: { connect: [couponDocId] },
          order: { connect: [orderDocId] },
          discountAmount: order.discount as number,
          guestEmail: userDocId ? null : (order.guestEmail as string)?.toLowerCase() ?? null,
        };
        if (userDocId) usageData.user = { connect: [userDocId] };
        await strapi.documents("api::coupon-usage.coupon-usage").create({ data: usageData });
      }

      if (sessionId) {
        const guestCarts = await strapi.documents("api::cart-item.cart-item").findMany({
          filters: { sessionId: { $eq: sessionId } },
        });
        for (const c of guestCarts) {
          const cd = c as Record<string, unknown>;
          await strapi.documents("api::cart-item.cart-item").delete({ documentId: String(cd.documentId) });
        }
      }
      if (userDocId) {
        const userCarts = await strapi.documents("api::cart-item.cart-item").findMany({
          filters: { user: { documentId: { $eq: userDocId } } },
        });
        for (const c of userCarts) {
          const cd = c as Record<string, unknown>;
          await strapi.documents("api::cart-item.cart-item").delete({ documentId: String(cd.documentId) });
        }
      }
    } catch (e) {
      const msg = e instanceof Error ? e.message : String(e);
      return ctx.throw(500, msg);
    }

    await sendOrderEmails(strapi as never, customerEmail, orderDocId, orderTotal);

    ctx.body = { ok: true, orderId: orderDocId };
  },

  async salesReport(ctx: {
    strapi?: StrapiWithDocs;
    state?: { strapi?: StrapiWithDocs };
    query?: { days?: string };
    request?: { query?: { days?: string } };
    throw: (status: number, msg?: string) => never;
    body?: unknown;
  }) {
    if (!assertCommerceSecret(ctx)) return ctx.throw(401, "Unauthorized");
    const strapi = getStrapi(ctx);
    const days = Number(ctx.query?.days ?? ctx.request?.query?.days ?? 30);
    const since = Date.now() - days * 86400000;
    const all = await strapi.documents("api::order.order").findMany({
      filters: { paymentStatus: { $eq: "PAID" } },
      pagination: { pageSize: 5000 },
    });
    const arr = Array.isArray(all) ? all : [];
    const list = arr.filter((o: Record<string, unknown>) => {
      const c = o.createdAt ? new Date(String(o.createdAt)).getTime() : 0;
      return c >= since;
    });
    const totalPaise = list.reduce((s, o) => s + Number((o as Record<string, unknown>).total ?? 0), 0);
    ctx.body = { days, orderCount: list.length, totalPaise };
  },

  async refundOrder(ctx: {
    strapi?: StrapiWithDocs;
    state?: { strapi?: StrapiWithDocs };
    params?: { documentId?: string };
    throw: (status: number, msg?: string) => never;
    body?: unknown;
  }) {
    if (!assertCommerceSecret(ctx)) return ctx.throw(401, "Unauthorized");
    const documentId = ctx.params?.documentId;
    if (!documentId) return ctx.throw(400, "Missing order id");
    const strapi = getStrapi(ctx);
    const order = await strapi.documents("api::order.order").findOne({ documentId });
    if (!order) return ctx.throw(404, "Order not found");
    const o = order as Record<string, unknown>;
    const paymentId = o.rzpPaymentId as string | undefined;
    if (!paymentId) return ctx.throw(400, "No Razorpay payment on order");
    const amount = Number(o.total ?? 0);
    const Razorpay = (await import("razorpay")).default;
    const key = process.env.RAZORPAY_KEY_ID;
    const secret = process.env.RAZORPAY_KEY_SECRET;
    if (!key || !secret) return ctx.throw(500, "Razorpay not configured");
    const rzp = new Razorpay({ key_id: key, key_secret: secret });
    await rzp.payments.refund(paymentId, { amount });
    await strapi.documents("api::order.order").update({
      documentId,
      data: {
        paymentStatus: "REFUNDED",
        status: "REFUNDED",
        refundAmount: amount,
      },
    });
    ctx.body = { ok: true, documentId };
  },
};
