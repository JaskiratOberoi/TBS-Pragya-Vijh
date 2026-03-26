-- AlterTable
ALTER TABLE "Booking" DROP CONSTRAINT "Booking_userId_fkey";

ALTER TABLE "Booking" ALTER COLUMN "userId" DROP NOT NULL;
ALTER TABLE "Booking" ADD COLUMN "guestName" TEXT,
ADD COLUMN "guestEmail" TEXT,
ADD COLUMN "guestPhone" TEXT;

ALTER TABLE "Booking" ADD CONSTRAINT "Booking_userId_fkey" FOREIGN KEY ("userId") REFERENCES "User"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AlterTable
ALTER TABLE "Order" DROP CONSTRAINT "Order_userId_fkey";

ALTER TABLE "Order" ALTER COLUMN "userId" DROP NOT NULL;
ALTER TABLE "Order" ADD COLUMN "guestName" TEXT,
ADD COLUMN "guestEmail" TEXT,
ADD COLUMN "guestPhone" TEXT;

ALTER TABLE "Order" ADD CONSTRAINT "Order_userId_fkey" FOREIGN KEY ("userId") REFERENCES "User"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AlterTable
ALTER TABLE "DigitalPurchase" DROP CONSTRAINT "DigitalPurchase_userId_fkey";

ALTER TABLE "DigitalPurchase" ALTER COLUMN "userId" DROP NOT NULL;
ALTER TABLE "DigitalPurchase" ADD COLUMN "guestEmail" TEXT;

ALTER TABLE "DigitalPurchase" ADD CONSTRAINT "DigitalPurchase_userId_fkey" FOREIGN KEY ("userId") REFERENCES "User"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

CREATE INDEX "DigitalPurchase_guestEmail_idx" ON "DigitalPurchase"("guestEmail");

-- AlterTable
ALTER TABLE "CouponUsage" DROP CONSTRAINT "CouponUsage_userId_fkey";

ALTER TABLE "CouponUsage" ALTER COLUMN "userId" DROP NOT NULL;
ALTER TABLE "CouponUsage" ADD COLUMN "guestEmail" TEXT;

ALTER TABLE "CouponUsage" ADD CONSTRAINT "CouponUsage_userId_fkey" FOREIGN KEY ("userId") REFERENCES "User"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

CREATE INDEX "CouponUsage_guestEmail_idx" ON "CouponUsage"("guestEmail");
