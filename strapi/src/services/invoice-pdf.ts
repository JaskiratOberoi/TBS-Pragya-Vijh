/**
 * Invoice PDF generation placeholder — extend with @react-pdf/renderer document
 * matching your invoice layout, then call from a commerce route e.g. GET /invoice-pdf/:orderId
 */
export async function renderInvoicePdfHtml(_orderDocumentId: string): Promise<Buffer> {
  throw new Error("Invoice PDF not implemented — wire react-pdf in invoice-pdf.ts and commerce controller");
}
