"use client";

import { Tabs, TabsContent, TabsList, TabsTrigger } from "@/components/ui/tabs";
import { ReviewForm } from "@/components/shop/ReviewForm";

type Review = { id: string; rating: number; comment: string; author: string };

export function ProductDetailTabs({
  description,
  healing,
  wearHand,
  isDigital,
  slug,
  reviews,
}: {
  description: string;
  healing?: string | null;
  wearHand?: string | null;
  isDigital: boolean;
  slug: string;
  reviews: Review[];
}) {
  return (
    <Tabs defaultValue="desc" className="mt-10">
      <TabsList>
        <TabsTrigger value="desc">Description</TabsTrigger>
        <TabsTrigger value="ship">Shipping</TabsTrigger>
        <TabsTrigger value="reviews">Reviews</TabsTrigger>
      </TabsList>
      <TabsContent value="desc" className="mt-4 max-w-none text-sm text-muted-foreground">
        <p>{description}</p>
        {healing && <p className="mt-2">{healing}</p>}
        {wearHand && <p className="mt-2">Wear on: {wearHand}</p>}
      </TabsContent>
      <TabsContent value="ship" className="mt-4 text-sm text-muted-foreground">
        {isDigital ? (
          <p>Digital delivery after payment — access from your account.</p>
        ) : (
          <p>We ship across India. Rates depend on product category; shown at checkout.</p>
        )}
      </TabsContent>
      <TabsContent value="reviews" className="mt-4 space-y-4">
        <ReviewForm slug={slug} />
        <ul className="space-y-3">
          {reviews.length === 0 && <li className="text-sm text-muted-foreground">No reviews yet.</li>}
          {reviews.map((r) => (
            <li key={r.id} className="rounded-md border p-3 text-sm">
              <p className="font-medium">{r.author}</p>
              <p className="text-muted-foreground">{r.rating}★</p>
              <p className="mt-1">{r.comment}</p>
            </li>
          ))}
        </ul>
      </TabsContent>
    </Tabs>
  );
}
