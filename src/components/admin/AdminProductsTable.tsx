"use client";

import { useState } from "react";
import Link from "next/link";
import { useRouter } from "next/navigation";
import { Button } from "@/components/ui/button";
import { formatINR } from "@/lib/utils";

export type AdminProductRow = {
  id: string;
  name: string;
  slug: string;
  categoryName: string;
  displayPricePaise: number;
  stock: number;
  isActive: boolean;
};

export function AdminProductsTable({ products }: { products: AdminProductRow[] }) {
  const router = useRouter();
  const [busyId, setBusyId] = useState<string | null>(null);

  async function toggleActive(p: AdminProductRow) {
    setBusyId(p.id);
    try {
      const res = await fetch(`/api/admin/products/${p.id}`, {
        method: "PATCH",
        headers: { "Content-Type": "application/json" },
        body: JSON.stringify({ isActive: !p.isActive }),
      });
      if (!res.ok) {
        const d = (await res.json()) as { error?: string };
        alert(d.error ?? "Could not update");
        return;
      }
      router.refresh();
    } finally {
      setBusyId(null);
    }
  }

  async function removeProduct(p: AdminProductRow) {
    const ok = window.confirm(
      `Delete “${p.name}”? If it has orders, it will be hidden instead of removed.`
    );
    if (!ok) return;
    setBusyId(p.id);
    try {
      const res = await fetch(`/api/admin/products/${p.id}`, { method: "DELETE" });
      const d = (await res.json()) as { softDeleted?: boolean; message?: string };
      if (!res.ok) {
        alert((d as { error?: string }).error ?? "Delete failed");
        return;
      }
      if (d.softDeleted && d.message) alert(d.message);
      router.refresh();
    } finally {
      setBusyId(null);
    }
  }

  return (
    <div className="mt-6 overflow-x-auto">
      <table className="w-full min-w-[640px] text-left text-sm">
        <thead>
          <tr className="border-b">
            <th className="py-2">Name</th>
            <th className="py-2">Category</th>
            <th className="py-2">Price</th>
            <th className="py-2">Stock</th>
            <th className="py-2">Active</th>
            <th className="py-2 text-right">Actions</th>
          </tr>
        </thead>
        <tbody>
          {products.map((p) => (
            <tr key={p.id} className="border-b">
              <td className="py-2">
                <Link href={`/shop/${p.slug}`} className="text-primary hover:underline" target="_blank" rel="noreferrer">
                  {p.name}
                </Link>
              </td>
              <td className="py-2">{p.categoryName}</td>
              <td className="py-2">{formatINR(p.displayPricePaise)}</td>
              <td className="py-2">{p.stock}</td>
              <td className="py-2">{p.isActive ? "yes" : "no"}</td>
              <td className="py-2 text-right">
                <div className="flex flex-wrap justify-end gap-1">
                  <Button variant="outline" size="sm" className="h-8" asChild>
                    <Link href={`/admin/products/${p.id}/edit`}>Edit</Link>
                  </Button>
                  <Button
                    variant="secondary"
                    size="sm"
                    className="h-8"
                    disabled={busyId === p.id}
                    onClick={() => void toggleActive(p)}
                  >
                    {p.isActive ? "Hide" : "Show"}
                  </Button>
                  <Button
                    variant="destructive"
                    size="sm"
                    className="h-8"
                    disabled={busyId === p.id}
                    onClick={() => void removeProduct(p)}
                  >
                    Delete
                  </Button>
                </div>
              </td>
            </tr>
          ))}
        </tbody>
      </table>
    </div>
  );
}
