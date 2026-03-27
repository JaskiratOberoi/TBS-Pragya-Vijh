import { Document, Page, Text, View, StyleSheet } from "@react-pdf/renderer";

const styles = StyleSheet.create({
  page: { padding: 40, fontSize: 10, fontFamily: "Helvetica" },
  h1: { fontSize: 18, marginBottom: 8 },
  muted: { color: "#444", marginBottom: 4 },
  row: { flexDirection: "row", justifyContent: "space-between", marginTop: 4 },
  tableHeader: { flexDirection: "row", borderBottomWidth: 1, borderBottomColor: "#000", paddingBottom: 4, marginTop: 12 },
  tableRow: { flexDirection: "row", paddingVertical: 6, borderBottomWidth: 0.5, borderBottomColor: "#ccc" },
  col1: { width: "42%" },
  col2: { width: "12%", textAlign: "right" },
  col3: { width: "12%", textAlign: "right" },
  col4: { width: "17%", textAlign: "right" },
  totals: { marginTop: 16, alignSelf: "flex-end", width: "45%" },
});

function formatMoney(paise: number) {
  return `₹${(paise / 100).toFixed(2)}`;
}

type InvoiceLine = {
  quantity?: number;
  unitPrice?: number;
  product?: { name?: string };
  hsnCode?: string | null;
};

export function InvoicePdfDocument(props: {
  invoiceNumber: string;
  invoiceDate: string;
  sellerName: string;
  sellerAddress: string;
  sellerGstin?: string | null;
  buyerName: string;
  buyerState: string;
  buyerGstin?: string | null;
  placeOfSupply: string;
  items: InvoiceLine[];
  subtotal: number;
  cgst: number;
  sgst: number;
  igst: number;
  totalTax: number;
  grandTotal: number;
}) {
  return (
    <Document>
      <Page size="A4" style={styles.page}>
        <Text style={styles.h1}>Tax Invoice</Text>
        <Text style={styles.muted}>{props.sellerName}</Text>
        <Text style={styles.muted}>{props.sellerAddress}</Text>
        {props.sellerGstin ? <Text style={styles.muted}>GSTIN: {props.sellerGstin}</Text> : null}
        <View style={{ marginTop: 16 }}>
          <Text>Invoice #{props.invoiceNumber}</Text>
          <Text style={styles.muted}>Date: {props.invoiceDate}</Text>
        </View>
        <View style={{ marginTop: 12 }}>
          <Text style={{ fontWeight: "bold" }}>Bill to</Text>
          <Text>{props.buyerName}</Text>
          <Text style={styles.muted}>State: {props.buyerState}</Text>
          {props.buyerGstin ? <Text style={styles.muted}>GSTIN: {props.buyerGstin}</Text> : null}
          <Text style={styles.muted}>Place of supply: {props.placeOfSupply}</Text>
        </View>
        <View style={styles.tableHeader}>
          <Text style={styles.col1}>Item</Text>
          <Text style={styles.col2}>Qty</Text>
          <Text style={styles.col3}>Rate</Text>
          <Text style={styles.col4}>Amount</Text>
        </View>
        {props.items.map((line, i) => {
          const name = line.product?.name ?? "Item";
          const qty = line.quantity ?? 0;
          const unit = line.unitPrice ?? 0;
          return (
            <View key={i} style={styles.tableRow} wrap={false}>
              <Text style={styles.col1}>{name}</Text>
              <Text style={styles.col2}>{String(qty)}</Text>
              <Text style={styles.col3}>{formatMoney(unit)}</Text>
              <Text style={styles.col4}>{formatMoney(unit * qty)}</Text>
            </View>
          );
        })}
        <View style={styles.totals}>
          <View style={styles.row}>
            <Text>Subtotal</Text>
            <Text>{formatMoney(props.subtotal)}</Text>
          </View>
          <View style={styles.row}>
            <Text>CGST</Text>
            <Text>{formatMoney(props.cgst)}</Text>
          </View>
          <View style={styles.row}>
            <Text>SGST</Text>
            <Text>{formatMoney(props.sgst)}</Text>
          </View>
          <View style={styles.row}>
            <Text>IGST</Text>
            <Text>{formatMoney(props.igst)}</Text>
          </View>
          <View style={styles.row}>
            <Text>Total tax</Text>
            <Text>{formatMoney(props.totalTax)}</Text>
          </View>
          <View style={[styles.row, { marginTop: 8, fontSize: 12 }]}>
            <Text style={{ fontWeight: "bold" }}>Grand total</Text>
            <Text style={{ fontWeight: "bold" }}>{formatMoney(props.grandTotal)}</Text>
          </View>
        </View>
      </Page>
    </Document>
  );
}
