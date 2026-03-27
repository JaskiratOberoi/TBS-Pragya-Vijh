export default {
  routes: [
    {
      method: "POST",
      path: "/create-order",
      handler: "commerce.createOrder",
      config: { auth: false },
    },
    {
      method: "POST",
      path: "/verify-payment",
      handler: "commerce.verifyPayment",
      config: { auth: false },
    },
    {
      method: "GET",
      path: "/reports/sales",
      handler: "commerce.salesReport",
      config: { auth: false },
    },
    {
      method: "POST",
      path: "/orders/:documentId/refund",
      handler: "commerce.refundOrder",
      config: { auth: false },
    },
  ],
};
