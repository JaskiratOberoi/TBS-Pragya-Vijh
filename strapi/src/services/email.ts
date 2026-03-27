import nodemailer from "nodemailer";

function getTransport() {
  const host = process.env.SMTP_HOST;
  const port = process.env.SMTP_PORT ? Number(process.env.SMTP_PORT) : 587;
  const user = process.env.SMTP_USER;
  const pass = process.env.SMTP_PASSWORD;
  if (!host || !user || !pass) return null;
  return nodemailer.createTransport({ host, port, secure: port === 465, auth: { user, pass } });
}

export async function sendOrderEmails(
  strapi: { documents: (uid: string) => { create: (args: unknown) => Promise<unknown> } },
  to: string,
  orderDocId: string,
  totalPaise: number
) {
  const from = process.env.EMAIL_FROM ?? process.env.SMTP_USER;
  const transport = getTransport();
  const html = `<p>Thank you! Order <strong>${orderDocId.slice(0, 8)}</strong> is confirmed. Total ${(totalPaise / 100).toFixed(0)} INR.</p>`;
  try {
    if (transport && from) {
      await transport.sendMail({ from, to, subject: "Order confirmed — The Blissful Soul", html });
      await strapi.documents("api::email-log.email-log").create({
        data: {
          to,
          subject: "Order confirmed — The Blissful Soul",
          templateName: "OrderConfirmation",
          status: "SENT",
          relatedType: "ORDER",
          relatedId: orderDocId,
          sentAt: new Date(),
        },
      });
    } else {
      await strapi.documents("api::email-log.email-log").create({
        data: {
          to,
          subject: "Order confirmed — The Blissful Soul",
          templateName: "OrderConfirmation",
          status: "FAILED",
          relatedType: "ORDER",
          relatedId: orderDocId,
          error: "SMTP not configured",
          sentAt: new Date(),
        },
      });
    }
  } catch (e) {
    const err = e instanceof Error ? e.message : String(e);
    await strapi.documents("api::email-log.email-log").create({
      data: {
        to,
        subject: "Order confirmed — The Blissful Soul",
        templateName: "OrderConfirmation",
        status: "FAILED",
        relatedType: "ORDER",
        relatedId: orderDocId,
        error: err,
        sentAt: new Date(),
      },
    });
  }
  const admin = process.env.ADMIN_EMAIL;
  if (admin && transport && from) {
    await transport.sendMail({
      from,
      to: admin,
      subject: `New order ${orderDocId.slice(0, 8)}`,
      html: `<p>New paid order from ${to}</p>`,
    });
  }
}
