"use client";

import { useState } from "react";
import { useRouter } from "next/navigation";
import Link from "next/link";
import { Button } from "@/components/ui/button";
import { Input } from "@/components/ui/input";
import { Label } from "@/components/ui/label";
import { Textarea } from "@/components/ui/textarea";
import { cn } from "@/lib/utils";

export type ProductFormInitial = {
  id: string;
  name: string;
  slug: string;
  description: string;
  categoryId: string;
  productType: "PHYSICAL" | "DIGITAL";
  priceRupees: number;
  salePriceRupees: number | null;
  stock: number;
  images: string[];
  healingProperties: string | null;
  wearHand: string | null;
  shippingClassId: string | null;
  hsnCode: string | null;
  gstRateBps: number;
  isActive: boolean;
};

type Props = {
  categories: { id: string; name: string }[];
  shippingClasses: { id: string; name: string }[];
  initial?: ProductFormInitial;
};

export function ProductForm({ categories, shippingClasses, initial }: Props) {
  const router = useRouter();
  const isEdit = Boolean(initial);
  const [err, setErr] = useState("");
  const [saving, setSaving] = useState(false);

  const [name, setName] = useState(initial?.name ?? "");
  const [slug, setSlug] = useState(initial?.slug ?? "");
  const [description, setDescription] = useState(initial?.description ?? "");
  const [categoryId, setCategoryId] = useState(initial?.categoryId ?? categories[0]?.id ?? "");
  const [productType, setProductType] = useState<"PHYSICAL" | "DIGITAL">(initial?.productType ?? "PHYSICAL");
  const [priceRupees, setPriceRupees] = useState(initial ? String(initial.priceRupees) : "");
  const [salePriceRupees, setSalePriceRupees] = useState(
    initial?.salePriceRupees != null ? String(initial.salePriceRupees) : ""
  );
  const [stock, setStock] = useState(initial ? String(initial.stock) : "0");
  const [images, setImages] = useState(initial?.images.join("\n") ?? "/assets/products/placeholder.svg");
  const [healingProperties, setHealingProperties] = useState(initial?.healingProperties ?? "");
  const [wearHand, setWearHand] = useState(initial?.wearHand ?? "");
  const [shippingClassId, setShippingClassId] = useState(initial?.shippingClassId ?? "");
  const [hsnCode, setHsnCode] = useState(initial?.hsnCode ?? "");
  const [gstRateBps, setGstRateBps] = useState(initial ? String(initial.gstRateBps) : "1800");
  const [isActive, setIsActive] = useState(initial?.isActive ?? true);

  async function submit(e: React.FormEvent) {
    e.preventDefault();
    setErr("");
    const pr = Number.parseInt(priceRupees, 10);
    const st = Number.parseInt(stock, 10);
    if (Number.isNaN(pr) || pr < 0) {
      setErr("Enter a valid price (whole rupees).");
      return;
    }
    if (Number.isNaN(st) || st < 0) {
      setErr("Enter a valid stock count.");
      return;
    }
    let salePayload: number | null | undefined = undefined;
    if (salePriceRupees.trim() === "") {
      salePayload = isEdit ? null : undefined;
    } else {
      const s = Number.parseInt(salePriceRupees, 10);
      if (Number.isNaN(s) || s < 0) {
        setErr("Enter a valid sale price or leave empty.");
        return;
      }
      salePayload = s === 0 ? null : s;
    }
    const gst = Number.parseInt(gstRateBps, 10);
    if (Number.isNaN(gst)) {
      setErr("Enter a valid GST (basis points, e.g. 1800 for 18%).");
      return;
    }

    const imageList = images
      .split(/\r?\n/)
      .map((s) => s.trim())
      .filter(Boolean);

    const body: Record<string, unknown> = {
      name,
      slug: slug.trim() || undefined,
      description,
      categoryId,
      productType,
      priceRupees: pr,
      stock: st,
      images: imageList,
      healingProperties: healingProperties.trim() || null,
      wearHand: wearHand.trim() || null,
      shippingClassId: shippingClassId || null,
      hsnCode: hsnCode.trim() || null,
      gstRateBps: gst,
      isActive,
    };
    if (salePayload !== undefined) body.salePriceRupees = salePayload;

    setSaving(true);
    try {
      const url = isEdit ? `/api/admin/products/${initial!.id}` : "/api/admin/products";
      const res = await fetch(url, {
        method: isEdit ? "PATCH" : "POST",
        headers: { "Content-Type": "application/json" },
        body: JSON.stringify(body),
      });
      const data = (await res.json()) as { error?: unknown; product?: { id: string; slug: string } };
      if (!res.ok) {
        setErr(typeof data.error === "string" ? data.error : "Save failed");
        return;
      }
      router.push("/admin/products");
      router.refresh();
    } catch {
      setErr("Network error");
    } finally {
      setSaving(false);
    }
  }

  return (
    <form onSubmit={(e) => void submit(e)} className="mx-auto max-w-2xl space-y-5">
      {err && <p className="rounded-lg border border-destructive/50 bg-destructive/10 px-3 py-2 text-sm text-destructive">{err}</p>}

      <div>
        <Label htmlFor="name">Name</Label>
        <Input id="name" value={name} onChange={(e) => setName(e.target.value)} required className="mt-1" />
      </div>
      <div>
        <Label htmlFor="slug">Slug (optional — auto from name if empty)</Label>
        <Input id="slug" value={slug} onChange={(e) => setSlug(e.target.value)} placeholder="my-product-slug" className="mt-1 font-mono text-sm" />
      </div>
      <div>
        <Label htmlFor="description">Description</Label>
        <Textarea id="description" value={description} onChange={(e) => setDescription(e.target.value)} required rows={5} className="mt-1" />
      </div>
      <div className="grid gap-4 sm:grid-cols-2">
        <div>
          <Label htmlFor="categoryId">Category</Label>
          <select
            id="categoryId"
            value={categoryId}
            onChange={(e) => setCategoryId(e.target.value)}
            className={cn(
              "mt-1 flex h-10 w-full rounded-full border border-input bg-background px-3 py-2 text-sm ring-offset-background focus-visible:outline-none focus-visible:ring-2 focus-visible:ring-ring"
            )}
            required
          >
            {categories.map((c) => (
              <option key={c.id} value={c.id}>
                {c.name}
              </option>
            ))}
          </select>
        </div>
        <div>
          <Label htmlFor="productType">Product type</Label>
          <select
            id="productType"
            value={productType}
            onChange={(e) => setProductType(e.target.value as "PHYSICAL" | "DIGITAL")}
            className="mt-1 flex h-10 w-full rounded-full border border-input bg-background px-3 py-2 text-sm focus-visible:outline-none focus-visible:ring-2 focus-visible:ring-ring"
          >
            <option value="PHYSICAL">Physical</option>
            <option value="DIGITAL">Digital</option>
          </select>
        </div>
      </div>
      <div className="grid gap-4 sm:grid-cols-3">
        <div>
          <Label htmlFor="price">Price (₹, whole rupees)</Label>
          <Input id="price" inputMode="numeric" value={priceRupees} onChange={(e) => setPriceRupees(e.target.value)} required className="mt-1" />
        </div>
        <div>
          <Label htmlFor="sale">Sale price (optional)</Label>
          <Input
            id="sale"
            inputMode="numeric"
            value={salePriceRupees}
            onChange={(e) => setSalePriceRupees(e.target.value)}
            placeholder="Leave empty for no discount"
            className="mt-1"
          />
        </div>
        <div>
          <Label htmlFor="stock">Stock</Label>
          <Input id="stock" inputMode="numeric" value={stock} onChange={(e) => setStock(e.target.value)} required className="mt-1" />
        </div>
      </div>
      <div>
        <Label htmlFor="images">Image URLs (one per line)</Label>
        <Textarea id="images" value={images} onChange={(e) => setImages(e.target.value)} rows={4} className="mt-1 font-mono text-xs" />
      </div>
      <div>
        <Label htmlFor="healing">Healing properties (optional)</Label>
        <Textarea id="healing" value={healingProperties} onChange={(e) => setHealingProperties(e.target.value)} rows={3} className="mt-1" />
      </div>
      <div>
        <Label htmlFor="wearHand">Wear hand (optional)</Label>
        <Input id="wearHand" value={wearHand} onChange={(e) => setWearHand(e.target.value)} className="mt-1" />
      </div>
      <div className="grid gap-4 sm:grid-cols-2">
        <div>
          <Label htmlFor="ship">Shipping class (optional)</Label>
          <select
            id="ship"
            value={shippingClassId}
            onChange={(e) => setShippingClassId(e.target.value)}
            className="mt-1 flex h-10 w-full rounded-full border border-input bg-background px-3 py-2 text-sm"
          >
            <option value="">— None —</option>
            {shippingClasses.map((s) => (
              <option key={s.id} value={s.id}>
                {s.name}
              </option>
            ))}
          </select>
        </div>
        <div>
          <Label htmlFor="hsn">HSN code (optional)</Label>
          <Input id="hsn" value={hsnCode} onChange={(e) => setHsnCode(e.target.value)} className="mt-1" />
        </div>
      </div>
      <div>
        <Label htmlFor="gst">GST rate (basis points, e.g. 1800 = 18%)</Label>
        <Input id="gst" inputMode="numeric" value={gstRateBps} onChange={(e) => setGstRateBps(e.target.value)} className="mt-1" />
      </div>
      <div className="flex items-center gap-2">
        <input
          type="checkbox"
          id="active"
          checked={isActive}
          onChange={(e) => setIsActive(e.target.checked)}
          className="h-4 w-4 rounded border-input"
        />
        <Label htmlFor="active" className="font-normal">
          Active (visible in shop)
        </Label>
      </div>
      <div className="flex flex-wrap gap-3 pt-2">
        <Button type="submit" disabled={saving}>
          {saving ? "Saving…" : isEdit ? "Save changes" : "Create product"}
        </Button>
        <Button type="button" variant="outline" asChild>
          <Link href="/admin/products">Cancel</Link>
        </Button>
      </div>
    </form>
  );
}

function paiseToRupees(paise: number) {
  return Math.round(paise / 100);
}

export function productToFormInitial(p: {
  id: string;
  name: string;
  slug: string;
  description: string;
  categoryId: string;
  productType: "PHYSICAL" | "DIGITAL";
  price: number;
  salePrice: number | null;
  stock: number;
  images: string[];
  healingProperties: string | null;
  wearHand: string | null;
  shippingClassId: string | null;
  hsnCode: string | null;
  gstRateBps: number;
  isActive: boolean;
}): ProductFormInitial {
  return {
    id: p.id,
    name: p.name,
    slug: p.slug,
    description: p.description,
    categoryId: p.categoryId,
    productType: p.productType,
    priceRupees: paiseToRupees(p.price),
    salePriceRupees: p.salePrice != null ? paiseToRupees(p.salePrice) : null,
    stock: p.stock,
    images: p.images,
    healingProperties: p.healingProperties,
    wearHand: p.wearHand,
    shippingClassId: p.shippingClassId,
    hsnCode: p.hsnCode,
    gstRateBps: p.gstRateBps,
    isActive: p.isActive,
  };
}
