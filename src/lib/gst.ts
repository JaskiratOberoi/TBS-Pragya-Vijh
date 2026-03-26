/** Seller state code vs buyer state code → IGST else CGST+SGST split */

export type GstLine = {
  taxablePaise: number;
  gstRateBps: number;
};

export function splitGstForLine(
  line: GstLine,
  sellerStateCode: string,
  buyerStateCode: string
): { cgst: number; sgst: number; igst: number } {
  const taxTotal = Math.round((line.taxablePaise * line.gstRateBps) / 10000);
  const inter = sellerStateCode !== buyerStateCode;
  if (inter) {
    return { cgst: 0, sgst: 0, igst: taxTotal };
  }
  const half = Math.round(taxTotal / 2);
  const remainder = taxTotal - half * 2;
  return { cgst: half + remainder, sgst: half, igst: 0 };
}

export function aggregateOrderGst(
  lines: Array<GstLine & { sellerStateCode: string; buyerStateCode: string }>
) {
  let cgst = 0,
    sgst = 0,
    igst = 0;
  for (const l of lines) {
    const s = splitGstForLine(l, l.sellerStateCode, l.buyerStateCode);
    cgst += s.cgst;
    sgst += s.sgst;
    igst += s.igst;
  }
  return { cgst, sgst, igst, totalTax: cgst + sgst + igst };
}
