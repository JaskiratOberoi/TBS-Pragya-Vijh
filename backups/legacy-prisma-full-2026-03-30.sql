--
-- PostgreSQL database dump
--

\restrict T0Rqr9kvrU5O07pmFegUJ23ZopfKFXEHtmoOLHkULCjO1OaT9aLwgphL5sBGTEy

-- Dumped from database version 16.13
-- Dumped by pg_dump version 16.13

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SELECT pg_catalog.set_config('search_path', '', false);
SET check_function_bodies = false;
SET xmloption = content;
SET client_min_messages = warning;
SET row_security = off;

--
-- Name: BannerPosition; Type: TYPE; Schema: public; Owner: -
--

CREATE TYPE public."BannerPosition" AS ENUM (
    'HOME_HERO',
    'HOME_SALE',
    'SHOP_TOP'
);


--
-- Name: BookingStatus; Type: TYPE; Schema: public; Owner: -
--

CREATE TYPE public."BookingStatus" AS ENUM (
    'PENDING',
    'CONFIRMED',
    'COMPLETED',
    'CANCELLED',
    'RESCHEDULED',
    'NO_SHOW'
);


--
-- Name: DigitalAssetType; Type: TYPE; Schema: public; Owner: -
--

CREATE TYPE public."DigitalAssetType" AS ENUM (
    'YOUTUBE_LINK',
    'PDF',
    'EBOOK'
);


--
-- Name: DiscountType; Type: TYPE; Schema: public; Owner: -
--

CREATE TYPE public."DiscountType" AS ENUM (
    'PERCENTAGE',
    'FLAT',
    'BUY_X_GET_Y',
    'FREE_SHIPPING'
);


--
-- Name: EmailLogStatus; Type: TYPE; Schema: public; Owner: -
--

CREATE TYPE public."EmailLogStatus" AS ENUM (
    'SENT',
    'FAILED'
);


--
-- Name: EmailRelatedType; Type: TYPE; Schema: public; Owner: -
--

CREATE TYPE public."EmailRelatedType" AS ENUM (
    'ORDER',
    'BOOKING',
    'CONTACT',
    'REFUND'
);


--
-- Name: OrderStatus; Type: TYPE; Schema: public; Owner: -
--

CREATE TYPE public."OrderStatus" AS ENUM (
    'PENDING',
    'PROCESSING',
    'SHIPPED',
    'DELIVERED',
    'CANCELLED',
    'REFUNDED'
);


--
-- Name: PaymentStatus; Type: TYPE; Schema: public; Owner: -
--

CREATE TYPE public."PaymentStatus" AS ENUM (
    'PENDING',
    'PAID',
    'FAILED',
    'REFUNDED'
);


--
-- Name: PopupFrequency; Type: TYPE; Schema: public; Owner: -
--

CREATE TYPE public."PopupFrequency" AS ENUM (
    'ONCE',
    'SESSION',
    'ALWAYS'
);


--
-- Name: PopupTrigger; Type: TYPE; Schema: public; Owner: -
--

CREATE TYPE public."PopupTrigger" AS ENUM (
    'PAGE_LOAD',
    'EXIT_INTENT',
    'SCROLL_DEPTH',
    'TIMED'
);


--
-- Name: ProductType; Type: TYPE; Schema: public; Owner: -
--

CREATE TYPE public."ProductType" AS ENUM (
    'PHYSICAL',
    'DIGITAL'
);


--
-- Name: PromoRuleType; Type: TYPE; Schema: public; Owner: -
--

CREATE TYPE public."PromoRuleType" AS ENUM (
    'BUY_X_GET_Y',
    'FREE_GIFT_THRESHOLD'
);


--
-- Name: ReminderType; Type: TYPE; Schema: public; Owner: -
--

CREATE TYPE public."ReminderType" AS ENUM (
    'SESSION_REMINDER_24H',
    'SESSION_REMINDER_1H'
);


--
-- Name: ServiceType; Type: TYPE; Schema: public; Owner: -
--

CREATE TYPE public."ServiceType" AS ENUM (
    'AUDIO',
    'VIDEO'
);


--
-- Name: UserRole; Type: TYPE; Schema: public; Owner: -
--

CREATE TYPE public."UserRole" AS ENUM (
    'USER',
    'ADMIN'
);


SET default_tablespace = '';

SET default_table_access_method = heap;

--
-- Name: AvailabilityRule; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public."AvailabilityRule" (
    id text NOT NULL,
    "dayOfWeek" integer NOT NULL,
    "startTime" text NOT NULL,
    "endTime" text NOT NULL,
    "isActive" boolean DEFAULT true NOT NULL
);


--
-- Name: Banner; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public."Banner" (
    id text NOT NULL,
    title text NOT NULL,
    "imageUrl" text NOT NULL,
    "linkUrl" text,
    "position" public."BannerPosition" NOT NULL,
    "startDate" timestamp(3) without time zone,
    "endDate" timestamp(3) without time zone,
    "isActive" boolean DEFAULT true NOT NULL,
    "sortOrder" integer DEFAULT 0 NOT NULL,
    "createdAt" timestamp(3) without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL
);


--
-- Name: BlockedSlot; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public."BlockedSlot" (
    id text NOT NULL,
    date date NOT NULL,
    "startTime" text,
    "endTime" text,
    reason text
);


--
-- Name: Booking; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public."Booking" (
    id text NOT NULL,
    "userId" text,
    "serviceId" text NOT NULL,
    "scheduledAt" timestamp(3) without time zone NOT NULL,
    "endAt" timestamp(3) without time zone NOT NULL,
    status public."BookingStatus" DEFAULT 'PENDING'::public."BookingStatus" NOT NULL,
    "paymentStatus" public."PaymentStatus" DEFAULT 'PENDING'::public."PaymentStatus" NOT NULL,
    "rzpOrderId" text,
    "rzpPaymentId" text,
    "rzpSignature" text,
    "amountPaid" integer DEFAULT 0 NOT NULL,
    "gcalEventId" text,
    "customerNotes" text,
    "adminNotes" text,
    "cancelledAt" timestamp(3) without time zone,
    "cancelReason" text,
    "rescheduledFrom" timestamp(3) without time zone,
    "createdAt" timestamp(3) without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    "guestName" text,
    "guestEmail" text,
    "guestPhone" text
);


--
-- Name: BookingSettings; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public."BookingSettings" (
    id text DEFAULT 'singleton'::text NOT NULL,
    "slotDurationMinutes" integer DEFAULT 30 NOT NULL,
    "bufferBetweenSlots" integer DEFAULT 15 NOT NULL,
    "maxAdvanceBookingDays" integer DEFAULT 60 NOT NULL,
    "minAdvanceBookingHours" integer DEFAULT 2 NOT NULL,
    "cancellationPolicyHours" integer DEFAULT 24 NOT NULL,
    "gcalCalendarId" text,
    "gcalSyncEnabled" boolean DEFAULT false NOT NULL,
    "gcalRefreshToken" text,
    "autoConfirm" boolean DEFAULT true NOT NULL
);


--
-- Name: BusinessSettings; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public."BusinessSettings" (
    id text DEFAULT 'singleton'::text NOT NULL,
    "businessName" text NOT NULL,
    gstin text,
    pan text,
    address text NOT NULL,
    state text NOT NULL,
    "stateCode" text NOT NULL,
    phone text NOT NULL,
    email text NOT NULL,
    "logoUrl" text,
    "bankName" text,
    "bankAccount" text,
    "bankIfsc" text,
    "invoicePrefix" text DEFAULT 'TBS'::text NOT NULL,
    "nextInvoiceNumber" integer DEFAULT 1 NOT NULL,
    "fbPixelId" text,
    "fbPixelEnabled" boolean DEFAULT false NOT NULL
);


--
-- Name: CartItem; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public."CartItem" (
    id text NOT NULL,
    "userId" text,
    "sessionId" text,
    "productId" text NOT NULL,
    quantity integer DEFAULT 1 NOT NULL,
    "variantSelection" jsonb
);


--
-- Name: ContactMessage; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public."ContactMessage" (
    id text NOT NULL,
    name text NOT NULL,
    email text NOT NULL,
    phone text,
    company text,
    message text NOT NULL,
    "isRead" boolean DEFAULT false NOT NULL,
    "createdAt" timestamp(3) without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL
);


--
-- Name: CouponCode; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public."CouponCode" (
    id text NOT NULL,
    code text NOT NULL,
    description text,
    "discountType" public."DiscountType" NOT NULL,
    "discountValue" integer NOT NULL,
    "minCartTotal" integer,
    "maxDiscount" integer,
    "maxUses" integer,
    "usedCount" integer DEFAULT 0 NOT NULL,
    "perUserLimit" integer DEFAULT 1 NOT NULL,
    "validFrom" timestamp(3) without time zone,
    "validUntil" timestamp(3) without time zone,
    "isActive" boolean DEFAULT true NOT NULL,
    "applicableCategoryIds" text[],
    "applicableProductIds" text[],
    "createdAt" timestamp(3) without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL
);


--
-- Name: CouponUsage; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public."CouponUsage" (
    id text NOT NULL,
    "couponId" text NOT NULL,
    "userId" text,
    "orderId" text,
    "discountAmount" integer NOT NULL,
    "usedAt" timestamp(3) without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    "guestEmail" text
);


--
-- Name: DigitalAsset; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public."DigitalAsset" (
    id text NOT NULL,
    "productId" text NOT NULL,
    "assetType" public."DigitalAssetType" NOT NULL,
    url text NOT NULL,
    "fileName" text,
    "fileSize" integer,
    "accessInstructions" text,
    "createdAt" timestamp(3) without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL
);


--
-- Name: DigitalPurchase; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public."DigitalPurchase" (
    id text NOT NULL,
    "userId" text,
    "orderId" text NOT NULL,
    "productId" text NOT NULL,
    "digitalAssetId" text NOT NULL,
    "accessGrantedAt" timestamp(3) without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    "accessUrl" text,
    "expiresAt" timestamp(3) without time zone,
    "guestEmail" text
);


--
-- Name: EmailLog; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public."EmailLog" (
    id text NOT NULL,
    "to" text NOT NULL,
    subject text NOT NULL,
    "templateName" text NOT NULL,
    status public."EmailLogStatus" NOT NULL,
    "relatedType" public."EmailRelatedType",
    "relatedId" text,
    error text,
    "sentAt" timestamp(3) without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL
);


--
-- Name: Invoice; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public."Invoice" (
    id text NOT NULL,
    "invoiceNumber" text NOT NULL,
    "orderId" text NOT NULL,
    "invoiceDate" timestamp(3) without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    "buyerName" text NOT NULL,
    "buyerAddress" jsonb NOT NULL,
    "buyerGstin" text,
    "buyerState" text NOT NULL,
    "buyerStateCode" text NOT NULL,
    items jsonb NOT NULL,
    subtotal integer NOT NULL,
    cgst integer NOT NULL,
    sgst integer NOT NULL,
    igst integer NOT NULL,
    "totalTax" integer NOT NULL,
    "grandTotal" integer NOT NULL,
    "placeOfSupply" text NOT NULL,
    "isInterState" boolean NOT NULL,
    "pdfUrl" text,
    "createdAt" timestamp(3) without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL
);


--
-- Name: LegalPage; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public."LegalPage" (
    id text NOT NULL,
    slug text NOT NULL,
    title text NOT NULL,
    content text NOT NULL,
    "updatedAt" timestamp(3) without time zone NOT NULL
);


--
-- Name: Order; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public."Order" (
    id text NOT NULL,
    "userId" text,
    status public."OrderStatus" DEFAULT 'PENDING'::public."OrderStatus" NOT NULL,
    subtotal integer NOT NULL,
    discount integer DEFAULT 0 NOT NULL,
    "couponId" text,
    tax integer DEFAULT 0 NOT NULL,
    "shippingAmount" integer DEFAULT 0 NOT NULL,
    total integer NOT NULL,
    "rzpOrderId" text,
    "rzpPaymentId" text,
    "rzpSignature" text,
    "paymentStatus" public."PaymentStatus" DEFAULT 'PENDING'::public."PaymentStatus" NOT NULL,
    "paymentMethod" text,
    "refundId" text,
    "refundStatus" text,
    "refundAmount" integer,
    "shippingAddress" jsonb,
    "billingAddress" jsonb,
    notes text,
    "createdAt" timestamp(3) without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    "updatedAt" timestamp(3) without time zone NOT NULL,
    "guestName" text,
    "guestEmail" text,
    "guestPhone" text
);


--
-- Name: OrderItem; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public."OrderItem" (
    id text NOT NULL,
    "orderId" text NOT NULL,
    "productId" text NOT NULL,
    "variantSelection" jsonb,
    quantity integer NOT NULL,
    "unitPrice" integer NOT NULL,
    "gstRateBps" integer DEFAULT 1800 NOT NULL,
    "hsnCode" text
);


--
-- Name: OrderShipment; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public."OrderShipment" (
    id text NOT NULL,
    "orderId" text NOT NULL,
    "courierName" text,
    "trackingNumber" text,
    "trackingUrl" text,
    "shippedAt" timestamp(3) without time zone,
    "deliveredAt" timestamp(3) without time zone,
    notes text
);


--
-- Name: PasswordResetToken; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public."PasswordResetToken" (
    id text NOT NULL,
    token text NOT NULL,
    "userId" text NOT NULL,
    "expiresAt" timestamp(3) without time zone NOT NULL,
    "createdAt" timestamp(3) without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL
);


--
-- Name: Popup; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public."Popup" (
    id text NOT NULL,
    title text NOT NULL,
    content text NOT NULL,
    "imageUrl" text,
    "linkUrl" text,
    "triggerType" public."PopupTrigger" NOT NULL,
    "triggerValue" integer,
    "showOnPages" text[],
    frequency public."PopupFrequency" DEFAULT 'SESSION'::public."PopupFrequency" NOT NULL,
    "startDate" timestamp(3) without time zone,
    "endDate" timestamp(3) without time zone,
    "isActive" boolean DEFAULT true NOT NULL,
    "createdAt" timestamp(3) without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL
);


--
-- Name: Product; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public."Product" (
    id text NOT NULL,
    name text NOT NULL,
    slug text NOT NULL,
    description text NOT NULL,
    "categoryId" text NOT NULL,
    "productType" public."ProductType" DEFAULT 'PHYSICAL'::public."ProductType" NOT NULL,
    price integer NOT NULL,
    "salePrice" integer,
    stock integer DEFAULT 0 NOT NULL,
    images text[],
    "healingProperties" text,
    "wearHand" text,
    "shippingClassId" text,
    "hsnCode" text,
    "gstRateBps" integer DEFAULT 1800 NOT NULL,
    "isActive" boolean DEFAULT true NOT NULL,
    "createdAt" timestamp(3) without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    "updatedAt" timestamp(3) without time zone NOT NULL
);


--
-- Name: ProductCategory; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public."ProductCategory" (
    id text NOT NULL,
    name text NOT NULL,
    slug text NOT NULL,
    "sortOrder" integer DEFAULT 0 NOT NULL
);


--
-- Name: ProductVariant; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public."ProductVariant" (
    id text NOT NULL,
    "productId" text NOT NULL,
    name text NOT NULL,
    options jsonb NOT NULL
);


--
-- Name: PromoRule; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public."PromoRule" (
    id text NOT NULL,
    type public."PromoRuleType" NOT NULL,
    config jsonb NOT NULL,
    "isActive" boolean DEFAULT true NOT NULL
);


--
-- Name: Review; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public."Review" (
    id text NOT NULL,
    "userId" text NOT NULL,
    "productId" text NOT NULL,
    rating integer NOT NULL,
    comment text NOT NULL,
    "createdAt" timestamp(3) without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL
);


--
-- Name: ScheduledReminder; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public."ScheduledReminder" (
    id text NOT NULL,
    "bookingId" text NOT NULL,
    "reminderType" public."ReminderType" NOT NULL,
    "scheduledFor" timestamp(3) without time zone NOT NULL,
    sent boolean DEFAULT false NOT NULL,
    "sentAt" timestamp(3) without time zone
);


--
-- Name: Service; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public."Service" (
    id text NOT NULL,
    name text NOT NULL,
    type public."ServiceType" NOT NULL,
    price integer NOT NULL,
    "durationMinutes" integer NOT NULL,
    "staffId" text,
    "bufferMinutes" integer DEFAULT 0 NOT NULL,
    "isActive" boolean DEFAULT true NOT NULL,
    description text
);


--
-- Name: ShippingClass; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public."ShippingClass" (
    id text NOT NULL,
    name text NOT NULL,
    rate integer DEFAULT 0 NOT NULL,
    "freeAbove" integer,
    description text
);


--
-- Name: Testimonial; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public."Testimonial" (
    id text NOT NULL,
    name text NOT NULL,
    text text NOT NULL,
    "sortOrder" integer DEFAULT 0 NOT NULL,
    "isActive" boolean DEFAULT true NOT NULL,
    "createdAt" timestamp(3) without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL
);


--
-- Name: User; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public."User" (
    id text NOT NULL,
    name text,
    email text NOT NULL,
    "passwordHash" text NOT NULL,
    phone text,
    role public."UserRole" DEFAULT 'USER'::public."UserRole" NOT NULL,
    "createdAt" timestamp(3) without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL
);


--
-- Name: WishlistItem; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public."WishlistItem" (
    id text NOT NULL,
    "userId" text NOT NULL,
    "productId" text NOT NULL
);


--
-- Name: _prisma_migrations; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public._prisma_migrations (
    id character varying(36) NOT NULL,
    checksum character varying(64) NOT NULL,
    finished_at timestamp with time zone,
    migration_name character varying(255) NOT NULL,
    logs text,
    rolled_back_at timestamp with time zone,
    started_at timestamp with time zone DEFAULT now() NOT NULL,
    applied_steps_count integer DEFAULT 0 NOT NULL
);


--
-- Data for Name: AvailabilityRule; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public."AvailabilityRule" (id, "dayOfWeek", "startTime", "endTime", "isActive") FROM stdin;
cmn7va1k5002cpb46cl4wnv2i	1	10:00	18:00	t
cmn7va1k8002dpb468m9byidr	2	10:00	18:00	t
cmn7va1ka002epb46qxcw68iy	3	10:00	18:00	t
cmn7va1kd002fpb46af006rjz	4	10:00	18:00	t
cmn7va1kg002gpb46avojfmcf	5	10:00	18:00	t
\.


--
-- Data for Name: Banner; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public."Banner" (id, title, "imageUrl", "linkUrl", "position", "startDate", "endDate", "isActive", "sortOrder", "createdAt") FROM stdin;
\.


--
-- Data for Name: BlockedSlot; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public."BlockedSlot" (id, date, "startTime", "endTime", reason) FROM stdin;
\.


--
-- Data for Name: Booking; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public."Booking" (id, "userId", "serviceId", "scheduledAt", "endAt", status, "paymentStatus", "rzpOrderId", "rzpPaymentId", "rzpSignature", "amountPaid", "gcalEventId", "customerNotes", "adminNotes", "cancelledAt", "cancelReason", "rescheduledFrom", "createdAt", "guestName", "guestEmail", "guestPhone") FROM stdin;
\.


--
-- Data for Name: BookingSettings; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public."BookingSettings" (id, "slotDurationMinutes", "bufferBetweenSlots", "maxAdvanceBookingDays", "minAdvanceBookingHours", "cancellationPolicyHours", "gcalCalendarId", "gcalSyncEnabled", "gcalRefreshToken", "autoConfirm") FROM stdin;
singleton	30	15	60	2	24	\N	f	\N	t
\.


--
-- Data for Name: BusinessSettings; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public."BusinessSettings" (id, "businessName", gstin, pan, address, state, "stateCode", phone, email, "logoUrl", "bankName", "bankAccount", "bankIfsc", "invoicePrefix", "nextInvoiceNumber", "fbPixelId", "fbPixelEnabled") FROM stdin;
singleton	The Blissful Soul			Shakti Nagar, Delhi 110007	Delhi	07	+919811611341	theblissfulsoul27@gmail.com	\N	\N	\N	\N	TBS	1	\N	f
\.


--
-- Data for Name: CartItem; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public."CartItem" (id, "userId", "sessionId", "productId", quantity, "variantSelection") FROM stdin;
cmn7un2jw0001pb0t77vvdtkk	cmn7stcrh0000o41m63xxplbv	\N	cmn7stcwh001mo41m7yp2rk9j	1	\N
\.


--
-- Data for Name: ContactMessage; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public."ContactMessage" (id, name, email, phone, company, message, "isRead", "createdAt") FROM stdin;
\.


--
-- Data for Name: CouponCode; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public."CouponCode" (id, code, description, "discountType", "discountValue", "minCartTotal", "maxDiscount", "maxUses", "usedCount", "perUserLimit", "validFrom", "validUntil", "isActive", "applicableCategoryIds", "applicableProductIds", "createdAt") FROM stdin;
\.


--
-- Data for Name: CouponUsage; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public."CouponUsage" (id, "couponId", "userId", "orderId", "discountAmount", "usedAt", "guestEmail") FROM stdin;
\.


--
-- Data for Name: DigitalAsset; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public."DigitalAsset" (id, "productId", "assetType", url, "fileName", "fileSize", "accessInstructions", "createdAt") FROM stdin;
\.


--
-- Data for Name: DigitalPurchase; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public."DigitalPurchase" (id, "userId", "orderId", "productId", "digitalAssetId", "accessGrantedAt", "accessUrl", "expiresAt", "guestEmail") FROM stdin;
\.


--
-- Data for Name: EmailLog; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public."EmailLog" (id, "to", subject, "templateName", status, "relatedType", "relatedId", error, "sentAt") FROM stdin;
\.


--
-- Data for Name: Invoice; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public."Invoice" (id, "invoiceNumber", "orderId", "invoiceDate", "buyerName", "buyerAddress", "buyerGstin", "buyerState", "buyerStateCode", items, subtotal, cgst, sgst, igst, "totalTax", "grandTotal", "placeOfSupply", "isInterState", "pdfUrl", "createdAt") FROM stdin;
\.


--
-- Data for Name: LegalPage; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public."LegalPage" (id, slug, title, content, "updatedAt") FROM stdin;
cmn7stcyn0028o41myh0ko4ox	terms	Terms and Conditions	<p>Placeholder terms. Replace in admin.</p>	2026-03-26 18:21:06.143
cmn7stcys0029o41mxrqlc5mn	refund-policy	Refund Policy	<p>Placeholder refund policy.</p>	2026-03-26 18:21:06.149
cmn7stcyx002ao41moqgu6ub9	privacy-policy	Privacy Policy	<p>Placeholder privacy policy.</p>	2026-03-26 18:21:06.153
cmn7stcz1002bo41m9lv1p2hz	shipping-policy	Shipping Policy	<p>Placeholder shipping policy.</p>	2026-03-26 18:21:06.157
\.


--
-- Data for Name: Order; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public."Order" (id, "userId", status, subtotal, discount, "couponId", tax, "shippingAmount", total, "rzpOrderId", "rzpPaymentId", "rzpSignature", "paymentStatus", "paymentMethod", "refundId", "refundStatus", "refundAmount", "shippingAddress", "billingAddress", notes, "createdAt", "updatedAt", "guestName", "guestEmail", "guestPhone") FROM stdin;
\.


--
-- Data for Name: OrderItem; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public."OrderItem" (id, "orderId", "productId", "variantSelection", quantity, "unitPrice", "gstRateBps", "hsnCode") FROM stdin;
\.


--
-- Data for Name: OrderShipment; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public."OrderShipment" (id, "orderId", "courierName", "trackingNumber", "trackingUrl", "shippedAt", "deliveredAt", notes) FROM stdin;
\.


--
-- Data for Name: PasswordResetToken; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public."PasswordResetToken" (id, token, "userId", "expiresAt", "createdAt") FROM stdin;
\.


--
-- Data for Name: Popup; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public."Popup" (id, title, content, "imageUrl", "linkUrl", "triggerType", "triggerValue", "showOnPages", frequency, "startDate", "endDate", "isActive", "createdAt") FROM stdin;
\.


--
-- Data for Name: Product; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public."Product" (id, name, slug, description, "categoryId", "productType", price, "salePrice", stock, images, "healingProperties", "wearHand", "shippingClassId", "hsnCode", "gstRateBps", "isActive", "createdAt", "updatedAt") FROM stdin;
cmn7stcti000go41msgeze0b0	Rose Quartz Natural Bracelet	rose-quartz-natural-bracelet	Healing crystal product: Rose Quartz Natural Bracelet. From The Blissful Soul.	cmn7stcs20001o41mt3gr5gkn	PHYSICAL	199900	99900	60	{https://bm3.bad.myftpupload.com/wp-content/uploads/2025/09/2-22.webp,https://bm3.bad.myftpupload.com/wp-content/uploads/2025/09/1-26.webp,https://bm3.bad.myftpupload.com/wp-content/uploads/2025/09/4-11.webp,https://bm3.bad.myftpupload.com/wp-content/uploads/2025/09/5-4.webp}	\N	\N	ship-free	7117	300	t	2026-03-26 18:21:05.958	2026-03-26 19:30:03.568
cmn7stctz000mo41mvui2j5ki	Rose Quartz Pyramid	rose-quartz-pyramid	Healing crystal product: Rose Quartz Pyramid. From The Blissful Soul.	cmn7stcsb0003o41msks37smn	PHYSICAL	199900	99900	45	{https://bm3.bad.myftpupload.com/wp-content/uploads/2025/09/3-3.webp,https://bm3.bad.myftpupload.com/wp-content/uploads/2025/09/1-4.webp,https://bm3.bad.myftpupload.com/wp-content/uploads/2025/09/2-4.webp,https://bm3.bad.myftpupload.com/wp-content/uploads/2025/09/4-2.webp}	\N	\N	ship-free	7117	300	t	2026-03-26 18:21:05.975	2026-03-26 19:30:03.581
cmn7stcu3000oo41mmti6b9d2	Black Obsidian Tumbles	black-obsidian-tumbles-negativity-evil-eye	Healing crystal product: Black Obsidian Tumbles. From The Blissful Soul.	cmn7stcs70002o41m44a4zow6	PHYSICAL	99900	29900	120	{https://bm3.bad.myftpupload.com/wp-content/uploads/2025/09/1-5.webp,https://bm3.bad.myftpupload.com/wp-content/uploads/2025/09/2-5.webp,https://bm3.bad.myftpupload.com/wp-content/uploads/2025/09/3-5.webp,https://bm3.bad.myftpupload.com/wp-content/uploads/2025/09/4-3.webp}	\N	\N	ship-free	7117	300	t	2026-03-26 18:21:05.98	2026-03-26 19:30:03.585
cmn7stcu8000qo41mlbm1qqki	Amethyst Tumbles	amethyst-tumbles-peace-and-anxiety	Healing crystal product: Amethyst Tumbles. From The Blissful Soul.	cmn7stcs70002o41m44a4zow6	PHYSICAL	99900	29900	120	{https://bm3.bad.myftpupload.com/wp-content/uploads/2025/09/1-6.webp,https://bm3.bad.myftpupload.com/wp-content/uploads/2025/09/2-6.webp,https://bm3.bad.myftpupload.com/wp-content/uploads/2025/09/3-6.webp}	\N	\N	ship-free	7117	300	t	2026-03-26 18:21:05.985	2026-03-26 19:30:03.59
cmn7stcuj000uo41mmdypplvq	Riche Rich	riche-rich	Healing crystal product: Riche Rich. From The Blissful Soul.	cmn7stcs20001o41mt3gr5gkn	PHYSICAL	199900	149900	30	{https://bm3.bad.myftpupload.com/wp-content/uploads/2025/09/photo-4.png,https://bm3.bad.myftpupload.com/wp-content/uploads/2025/09/5-1.webp,https://bm3.bad.myftpupload.com/wp-content/uploads/2025/09/4-5.webp,https://bm3.bad.myftpupload.com/wp-content/uploads/2025/09/2-8.webp,https://bm3.bad.myftpupload.com/wp-content/uploads/2025/09/3-10.webp}	\N	\N	ship-free	7117	300	t	2026-03-26 18:21:05.995	2026-03-26 19:30:03.599
cmn7stcuu000yo41mr2f8495t	Sage Sticks	sage-sticks-negativity-removal	Healing crystal product: Sage Sticks. From The Blissful Soul.	cmn7stcsn0006o41mdjlcbcuh	PHYSICAL	99900	49900	200	{https://bm3.bad.myftpupload.com/wp-content/uploads/2025/09/1-10.webp,https://bm3.bad.myftpupload.com/wp-content/uploads/2025/09/2-9.webp,https://bm3.bad.myftpupload.com/wp-content/uploads/2025/09/3-11.webp,https://bm3.bad.myftpupload.com/wp-content/uploads/2025/09/4-6.webp,https://bm3.bad.myftpupload.com/wp-content/uploads/2025/09/5-2.webp}	\N	\N	ship-free	7117	300	t	2026-03-26 18:21:06.006	2026-03-26 19:30:03.608
cmn7stcv80014o41mkcduik4t	Rose Quartz Pencil Locket	rose-quartz-pencil-locketself-love-and-relationship	Healing crystal product: Rose Quartz Pencil Locket. From The Blissful Soul.	cmn7stcsf0004o41mi1ygvzm0	PHYSICAL	199900	69900	40	{https://bm3.bad.myftpupload.com/wp-content/uploads/2025/09/photo-5.png}	\N	\N	ship-free	7117	300	t	2026-03-26 18:21:06.02	2026-03-26 19:30:03.62
cmn7stcvd0016o41mrhn3xutf	Red Jasper Natural Bracelet	red-jasper-natural-bracelet	Healing crystal product: Red Jasper Natural Bracelet. From The Blissful Soul.	cmn7stcs20001o41mt3gr5gkn	PHYSICAL	199900	149900	40	{https://bm3.bad.myftpupload.com/wp-content/uploads/2025/09/1-14.webp,https://bm3.bad.myftpupload.com/wp-content/uploads/2025/09/2-12.webp,https://bm3.bad.myftpupload.com/wp-content/uploads/2025/09/3-14.webp}	\N	\N	ship-free	7117	300	t	2026-03-26 18:21:06.025	2026-03-26 19:30:03.624
cmn7stcvi0018o41m024xdn6q	Pregnancy & Health Bracelet	pregnancy-health-bracelet	Healing crystal product: Pregnancy & Health Bracelet. From The Blissful Soul.	cmn7stcs20001o41mt3gr5gkn	PHYSICAL	149900	\N	20	{https://bm3.bad.myftpupload.com/wp-content/uploads/2025/09/1-15.webp,https://bm3.bad.myftpupload.com/wp-content/uploads/2025/09/2-13.webp}	\N	\N	ship-free	7117	300	t	2026-03-26 18:21:06.03	2026-03-26 19:30:03.628
cmn7stcvo001ao41mz8ozl8md	Black Obsidian Pencil Locket	black-obsidian-pencil-locketevil-eye-and-nazar	Healing crystal product: Black Obsidian Pencil Locket. From The Blissful Soul.	cmn7stcsf0004o41mi1ygvzm0	PHYSICAL	199900	69900	40	{https://bm3.bad.myftpupload.com/wp-content/uploads/2025/09/2-14.webp,https://bm3.bad.myftpupload.com/wp-content/uploads/2025/09/1-17.webp}	\N	\N	ship-free	7117	300	t	2026-03-26 18:21:06.036	2026-03-26 19:30:03.632
cmn7stcvs001co41meewue23e	Black Obsidian Natural Bracelet	black-obsidian-natural-bracelet	Healing crystal product: Black Obsidian Natural Bracelet. From The Blissful Soul.	cmn7stcs20001o41mt3gr5gkn	PHYSICAL	199900	149900	50	{https://bm3.bad.myftpupload.com/wp-content/uploads/2025/09/1-18.webp,https://bm3.bad.myftpupload.com/wp-content/uploads/2025/09/2-15.webp,https://bm3.bad.myftpupload.com/wp-content/uploads/2025/09/3-15.webp,https://bm3.bad.myftpupload.com/wp-content/uploads/2025/09/4-8.webp}	\N	\N	ship-free	7117	300	t	2026-03-26 18:21:06.041	2026-03-26 19:30:03.636
cmn7stcw7001io41mizt60bcg	Healing sea salt	healing-sea-salt	Healing crystal product: Healing Sea Salt. From The Blissful Soul.	cmn7stcsn0006o41mdjlcbcuh	PHYSICAL	77700	29900	150	{https://bm3.bad.myftpupload.com/wp-content/uploads/2025/09/2-18.webp,https://bm3.bad.myftpupload.com/wp-content/uploads/2025/09/1-21-e1757325863584.webp,https://bm3.bad.myftpupload.com/wp-content/uploads/2025/09/3-18.webp}	\N	\N	ship-free	7117	300	t	2026-03-26 18:21:06.056	2026-03-26 19:30:03.648
cmn7stct0000ao41mpsnygabk	Pyrite Money Keychain (1 pc)	pyrite-money-keychain-1-piece-assorted	Healing crystal product: Pyrite Money Keychain (1 pc). From The Blissful Soul.	cmn7stcsn0006o41mdjlcbcuh	PHYSICAL	99900	45900	100	{https://bm3.bad.myftpupload.com/wp-content/uploads/2025/09/1-e1757322710183.webp,https://bm3.bad.myftpupload.com/wp-content/uploads/2025/09/2-e1757322736665.webp}	\N	\N	ship-free	7117	300	t	2026-03-26 18:21:05.941	2026-03-26 19:30:03.554
cmn7stctc000eo41m18dk97ow	Amethyst Natural Bracelet	amethyst-natural-bracelet	Healing crystal product: Amethyst Natural Bracelet. From The Blissful Soul.	cmn7stcs20001o41mt3gr5gkn	PHYSICAL	199900	99900	60	{https://bm3.bad.myftpupload.com/wp-content/uploads/2025/09/2-21.webp,https://bm3.bad.myftpupload.com/wp-content/uploads/2025/09/1-25.webp}	\N	\N	ship-free	7117	300	t	2026-03-26 18:21:05.952	2026-03-26 19:30:03.564
cmn7stcss0008o41m37zw7d58	Money Pyramid & Selenite Plate Combo	money-pyramid-selenite-charging-plate-combo	Healing crystal product: Money Pyramid & Selenite Plate Combo. From The Blissful Soul.	cmn7stcsj0005o41mxfewhbnk	PHYSICAL	599900	191900	50	{https://bm3.bad.myftpupload.com/wp-content/uploads/2025/09/1-3-800x800.webp,https://bm3.bad.myftpupload.com/wp-content/uploads/2025/09/4.webp}	\N	\N	ship-free	7117	300	t	2026-03-26 18:21:05.933	2026-03-26 19:30:03.547
cmn7stct6000co41maq62eil9	Money Pyramid	money-pyramid	Healing crystal product: Money Pyramid. From The Blissful Soul.	cmn7stcsb0003o41msks37smn	PHYSICAL	199900	99900	80	{https://bm3.bad.myftpupload.com/wp-content/uploads/2025/09/1-12-768x768.webp,https://bm3.bad.myftpupload.com/wp-content/uploads/2025/09/4.webp,https://bm3.bad.myftpupload.com/wp-content/uploads/2025/09/3.webp,https://bm3.bad.myftpupload.com/wp-content/uploads/2025/09/2-1.webp,https://bm3.bad.myftpupload.com/wp-content/uploads/2025/09/1-1.webp}	\N	\N	ship-free	7117	300	t	2026-03-26 18:21:05.946	2026-03-26 19:30:03.558
cmn7stctn000io41mpx8d0phd	Money Magnet	money-magnet	Healing crystal product: Money Magnet. From The Blissful Soul.	cmn7stcs20001o41mt3gr5gkn	PHYSICAL	199900	99900	100	{https://bm3.bad.myftpupload.com/wp-content/uploads/2025/09/2-3.webp,https://bm3.bad.myftpupload.com/wp-content/uploads/2025/09/5.webp,https://bm3.bad.myftpupload.com/wp-content/uploads/2025/09/4-1.webp,https://bm3.bad.myftpupload.com/wp-content/uploads/2025/09/3-2.webp,https://bm3.bad.myftpupload.com/wp-content/uploads/2025/09/1-3.webp}	\N	\N	ship-free	7117	300	t	2026-03-26 18:21:05.963	2026-03-26 19:30:03.572
cmn7stctt000ko41m54q3n5rq	Crystal Charger ÔÇô Selenite Plate	crystal-charger-selenite-plate	Healing crystal product: Crystal Charger ÔÇô Selenite Plate. From The Blissful Soul.	cmn7stcsn0006o41mdjlcbcuh	PHYSICAL	199900	59900	40	{https://bm3.bad.myftpupload.com/wp-content/uploads/2025/09/1-27.webp}	\N	\N	ship-free	7117	300	t	2026-03-26 18:21:05.969	2026-03-26 19:30:03.577
cmn7stcue000so41mybalqedh	Rose Quartz Tumbles	rose-quartz-tumbles-love-relationships	Healing crystal product: Rose Quartz Tumbles. From The Blissful Soul.	cmn7stcs70002o41m44a4zow6	PHYSICAL	99900	29900	120	{https://bm3.bad.myftpupload.com/wp-content/uploads/2025/09/1-7.webp,https://bm3.bad.myftpupload.com/wp-content/uploads/2025/09/2-7.webp,https://bm3.bad.myftpupload.com/wp-content/uploads/2025/09/3-7.webp}	\N	\N	ship-free	7117	300	t	2026-03-26 18:21:05.99	2026-03-26 19:30:03.595
cmn7stcuo000wo41mdczxva33	Pyrite Natural Bracelet	pyrite-natural-bracelet	Healing crystal product: Pyrite Natural Bracelet. From The Blissful Soul.	cmn7stcs20001o41mt3gr5gkn	PHYSICAL	199900	149900	35	{https://bm3.bad.myftpupload.com/wp-content/uploads/2025/09/3-8.webp,https://bm3.bad.myftpupload.com/wp-content/uploads/2025/09/1-8.webp,https://bm3.bad.myftpupload.com/wp-content/uploads/2025/09/3-9.webp,https://bm3.bad.myftpupload.com/wp-content/uploads/2025/09/4-4.webp}	\N	\N	ship-free	7117	300	t	2026-03-26 18:21:06	2026-03-26 19:30:03.603
cmn7stcuy0010o41m0aoh6my8	Master's Wish Box	masters-wish-box-manifest-all-desires	Healing crystal product: Master's Wish Box. From The Blissful Soul.	cmn7stcsn0006o41mdjlcbcuh	PHYSICAL	249900	149900	25	{https://bm3.bad.myftpupload.com/wp-content/uploads/2025/09/1-11.webp,https://bm3.bad.myftpupload.com/wp-content/uploads/2025/09/2-10.webp,https://bm3.bad.myftpupload.com/wp-content/uploads/2025/09/3-12.webp,https://bm3.bad.myftpupload.com/wp-content/uploads/2025/09/4-7.webp}	\N	\N	ship-free	7117	300	t	2026-03-26 18:21:06.011	2026-03-26 19:30:03.612
cmn7stcv30012o41mqlu6kp1s	Genie Bracelet	genie-bracelet	Healing crystal product: Genie Bracelet. From The Blissful Soul.	cmn7stcs20001o41mt3gr5gkn	PHYSICAL	99900	49900	90	{https://bm3.bad.myftpupload.com/wp-content/uploads/2025/09/1-12.webp,https://bm3.bad.myftpupload.com/wp-content/uploads/2025/09/2-11.webp,https://bm3.bad.myftpupload.com/wp-content/uploads/2025/09/3-13.webp}	\N	\N	ship-free	7117	300	t	2026-03-26 18:21:06.015	2026-03-26 19:30:03.616
cmn7stcvx001eo41mz8yev6pi	7 Chakra Locket	7-chakra-locketoverall-health	Healing crystal product: 7 Chakra Locket. From The Blissful Soul.	cmn7stcsf0004o41mi1ygvzm0	PHYSICAL	199900	119900	35	{https://bm3.bad.myftpupload.com/wp-content/uploads/2025/09/1-19.webp,https://bm3.bad.myftpupload.com/wp-content/uploads/2025/09/2-16.webp,https://bm3.bad.myftpupload.com/wp-content/uploads/2025/09/3-16.webp,https://bm3.bad.myftpupload.com/wp-content/uploads/2025/09/4-9.webp}	\N	\N	ship-free	7117	300	t	2026-03-26 18:21:06.045	2026-03-26 19:30:03.641
cmn7stcw2001go41m826sqwx1	Black Obsidian Pyramid	black-obsidian-pyramid	Healing crystal product: Black Obsidian Pyramid. From The Blissful Soul.	cmn7stcsb0003o41msks37smn	PHYSICAL	199900	99900	40	{https://bm3.bad.myftpupload.com/wp-content/uploads/2025/09/3-17.webp,https://bm3.bad.myftpupload.com/wp-content/uploads/2025/09/1-20.webp,https://bm3.bad.myftpupload.com/wp-content/uploads/2025/09/2-17.webp}	\N	\N	ship-free	7117	300	t	2026-03-26 18:21:06.05	2026-03-26 19:30:03.645
cmn7stcwh001mo41m7yp2rk9j	Tiger Eye Natural Bracelet	tiger-eye-natural-bracelet	Healing crystal product: Tiger Eye Natural Bracelet. From The Blissful Soul.	cmn7stcs20001o41mt3gr5gkn	PHYSICAL	199900	127900	35	{https://bm3.bad.myftpupload.com/wp-content/uploads/2025/09/5-3.webp,https://bm3.bad.myftpupload.com/wp-content/uploads/2025/09/1-23.webp,https://bm3.bad.myftpupload.com/wp-content/uploads/2025/09/2-19.webp,https://bm3.bad.myftpupload.com/wp-content/uploads/2025/09/3-19.webp,https://bm3.bad.myftpupload.com/wp-content/uploads/2025/09/4-10.webp,https://bm3.bad.myftpupload.com/wp-content/uploads/2025/09/6.webp}	\N	\N	ship-free	7117	300	t	2026-03-26 18:21:06.065	2026-03-26 19:30:03.657
cmn7stcwm001oo41m16mehlb8	Citrine Bracelet	citrine-braceletmoney-and-growth	Healing crystal product: Citrine Bracelet. From The Blissful Soul.	cmn7stcs20001o41mt3gr5gkn	PHYSICAL	199900	141900	40	{https://bm3.bad.myftpupload.com/wp-content/uploads/2025/09/1-24.webp,https://bm3.bad.myftpupload.com/wp-content/uploads/2025/09/2-20.webp,https://bm3.bad.myftpupload.com/wp-content/uploads/2025/09/3-20.webp}	\N	\N	ship-free	7117	300	t	2026-03-26 18:21:06.07	2026-03-26 19:30:03.661
cmn7stcy00025o41mpcwajbdt	Money Potli (Gift)	money-potli-gift	Complimentary gift on qualifying orders.	cmn7stcsn0006o41mdjlcbcuh	PHYSICAL	0	\N	9999	{https://bm3.bad.myftpupload.com/wp-content/uploads/2025/09/4.webp}	\N	\N	ship-free	7117	300	t	2026-03-26 18:21:06.121	2026-03-26 19:30:03.713
cmn7stcwc001ko41mdgk2e96l	Tiger Eye Locket	tiger-eye-locketself-esteem-and-confidence	Healing crystal product: Tiger Eye Locket. From The Blissful Soul.	cmn7stcsf0004o41mi1ygvzm0	PHYSICAL	199900	119900	30	{https://bm3.bad.myftpupload.com/wp-content/uploads/2025/09/1-22.webp}	\N	\N	ship-free	7117	300	t	2026-03-26 18:21:06.06	2026-03-26 19:30:03.652
\.


--
-- Data for Name: ProductCategory; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public."ProductCategory" (id, name, slug, "sortOrder") FROM stdin;
cmn7stcs20001o41mt3gr5gkn	Bracelet	bracelet	1
cmn7stcs70002o41m44a4zow6	Tumbles	tumbles	2
cmn7stcsb0003o41msks37smn	Pyramid	pyramid	3
cmn7stcsf0004o41mi1ygvzm0	Locket	locket	4
cmn7stcsj0005o41mxfewhbnk	Combo	combo	5
cmn7stcsn0006o41mdjlcbcuh	Other	other	6
\.


--
-- Data for Name: ProductVariant; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public."ProductVariant" (id, "productId", name, options) FROM stdin;
\.


--
-- Data for Name: PromoRule; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public."PromoRule" (id, type, config, "isActive") FROM stdin;
cmn7va1jc0026pb464rbbf7mt	BUY_X_GET_Y	{"buy": 3, "get": 1, "scope": "line_items"}	t
cmn7va1jc0027pb46r2n3u9qs	FREE_GIFT_THRESHOLD	{"thresholdPaise": 149900, "giftProductSlug": "money-potli-gift"}	t
\.


--
-- Data for Name: Review; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public."Review" (id, "userId", "productId", rating, comment, "createdAt") FROM stdin;
\.


--
-- Data for Name: ScheduledReminder; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public."ScheduledReminder" (id, "bookingId", "reminderType", "scheduledFor", sent, "sentAt") FROM stdin;
\.


--
-- Data for Name: Service; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public."Service" (id, name, type, price, "durationMinutes", "staffId", "bufferMinutes", "isActive", description) FROM stdin;
cmn7va1hx001ppb46r0tkwwfr	Tarot Reading	AUDIO	99900	20	\N	10	t	Tarot Reading ÔÇö AUDIO session
cmn7va1i1001qpb46lmrskan6	Tarot Reading	AUDIO	149900	30	\N	10	t	Tarot Reading ÔÇö AUDIO session
cmn7va1i3001rpb46len7pt1w	Kundali Session	AUDIO	149900	30	\N	10	t	Kundali Session ÔÇö AUDIO session
cmn7va1i6001spb46w4wc4pjl	Therapy & Counselling Sessions	AUDIO	99900	35	\N	10	t	Therapy & Counselling Sessions ÔÇö AUDIO session
cmn7va1i8001tpb46khr3etfa	All-in-1 Astrology	AUDIO	349900	40	\N	10	t	All-in-1 Astrology ÔÇö AUDIO session
cmn7va1ib001upb466jimxt9n	Tarot Reading	VIDEO	250000	30	\N	10	t	Tarot Reading ÔÇö VIDEO session
cmn7va1id001vpb46xxuxc5p9	Kundali Session	VIDEO	250000	30	\N	10	t	Kundali Session ÔÇö VIDEO session
cmn7va1ih001wpb46eaxak31a	Therapy & Counselling Sessions	VIDEO	129900	40	\N	10	t	Therapy & Counselling Sessions ÔÇö VIDEO session
cmn7va1ij001xpb46vn4l3mmw	All-in-1 Astrology	VIDEO	449900	40	\N	10	t	All-in-1 Astrology ÔÇö VIDEO session
\.


--
-- Data for Name: ShippingClass; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public."ShippingClass" (id, name, rate, "freeAbove", description) FROM stdin;
ship-free	Standard (Free)	0	\N	Free shipping
ship-paid	Standard (Paid)	9900	150000	Flat rate under order value
\.


--
-- Data for Name: Testimonial; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public."Testimonial" (id, name, text, "sortOrder", "isActive", "createdAt") FROM stdin;
cmn7va1ip001ypb46tnnw27xk	Tripti Jain	Vastu healing karwayi thi mam se aur uske baad mere ghar mein bohut changes hone lage hai. Thank you Pragya mam mere life se problems dur karne ke liye	0	t	2026-03-26 19:30:03.697
cmn7va1is001zpb464ocvk5uw	Sukh Kaur	I just had a really enlightening session with Pragya regarding my personal life. I must say it was a pleasure to talk to her and receive guidance. The solutions she gave were very simple and effective. Loved my time with her.	1	t	2026-03-26 19:30:03.7
cmn7va1iu0020pb46mmt0tipc	Ruhi Verma	The prediction done by Master Pragya was so appropriate that I was shocked.	2	t	2026-03-26 19:30:03.702
cmn7va1iw0021pb46jffsk685	Rohit Bagga	Thank you so much Pragya Mam. The ritual worked like magic for me.	3	t	2026-03-26 19:30:03.704
cmn7va1iz0022pb46jyw8cibi	Aashita Pandey	It was a great Tarot session that I had with Ma'am today.	4	t	2026-03-26 19:30:03.707
cmn7va1j20023pb46dnsfumua	Taruna Goyal	I am very thankful to Master Pragya for all the guidance that she gave me.	5	t	2026-03-26 19:30:03.71
\.


--
-- Data for Name: User; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public."User" (id, name, email, "passwordHash", phone, role, "createdAt") FROM stdin;
cmn7stcrh0000o41m63xxplbv	Admin	admin@theblissfulsoul.com	$2a$12$Sg7Q0ZsrLeEsYgwiD3VoqurdATs4jp.4gmIiwwWPXRISwYo4HE9dG	+919811611341	ADMIN	2026-03-26 18:21:05.886
\.


--
-- Data for Name: WishlistItem; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public."WishlistItem" (id, "userId", "productId") FROM stdin;
\.


--
-- Data for Name: _prisma_migrations; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public._prisma_migrations (id, checksum, finished_at, migration_name, logs, rolled_back_at, started_at, applied_steps_count) FROM stdin;
4684defa-5aed-4c20-b293-d7be47bb032b	ad95b1d6eec49ef6475d3bdc9e8295b9abf8bfc2c6709f3de118e738c7971879	2026-03-26 18:20:45.597094+00	20260326182045_init	\N	\N	2026-03-26 18:20:45.204007+00	1
5ab3a69f-415f-49d4-939d-d152f889ec7b	9824e3ac540cdf6837a395585345f2c97d0d9318893313c422fac288638e34f1	2026-03-26 18:59:13.499624+00	20260328130000_guest_checkout	\N	\N	2026-03-26 18:59:13.44256+00	1
\.


--
-- Name: AvailabilityRule AvailabilityRule_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."AvailabilityRule"
    ADD CONSTRAINT "AvailabilityRule_pkey" PRIMARY KEY (id);


--
-- Name: Banner Banner_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."Banner"
    ADD CONSTRAINT "Banner_pkey" PRIMARY KEY (id);


--
-- Name: BlockedSlot BlockedSlot_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."BlockedSlot"
    ADD CONSTRAINT "BlockedSlot_pkey" PRIMARY KEY (id);


--
-- Name: BookingSettings BookingSettings_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."BookingSettings"
    ADD CONSTRAINT "BookingSettings_pkey" PRIMARY KEY (id);


--
-- Name: Booking Booking_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."Booking"
    ADD CONSTRAINT "Booking_pkey" PRIMARY KEY (id);


--
-- Name: BusinessSettings BusinessSettings_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."BusinessSettings"
    ADD CONSTRAINT "BusinessSettings_pkey" PRIMARY KEY (id);


--
-- Name: CartItem CartItem_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."CartItem"
    ADD CONSTRAINT "CartItem_pkey" PRIMARY KEY (id);


--
-- Name: ContactMessage ContactMessage_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."ContactMessage"
    ADD CONSTRAINT "ContactMessage_pkey" PRIMARY KEY (id);


--
-- Name: CouponCode CouponCode_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."CouponCode"
    ADD CONSTRAINT "CouponCode_pkey" PRIMARY KEY (id);


--
-- Name: CouponUsage CouponUsage_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."CouponUsage"
    ADD CONSTRAINT "CouponUsage_pkey" PRIMARY KEY (id);


--
-- Name: DigitalAsset DigitalAsset_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."DigitalAsset"
    ADD CONSTRAINT "DigitalAsset_pkey" PRIMARY KEY (id);


--
-- Name: DigitalPurchase DigitalPurchase_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."DigitalPurchase"
    ADD CONSTRAINT "DigitalPurchase_pkey" PRIMARY KEY (id);


--
-- Name: EmailLog EmailLog_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."EmailLog"
    ADD CONSTRAINT "EmailLog_pkey" PRIMARY KEY (id);


--
-- Name: Invoice Invoice_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."Invoice"
    ADD CONSTRAINT "Invoice_pkey" PRIMARY KEY (id);


--
-- Name: LegalPage LegalPage_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."LegalPage"
    ADD CONSTRAINT "LegalPage_pkey" PRIMARY KEY (id);


--
-- Name: OrderItem OrderItem_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."OrderItem"
    ADD CONSTRAINT "OrderItem_pkey" PRIMARY KEY (id);


--
-- Name: OrderShipment OrderShipment_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."OrderShipment"
    ADD CONSTRAINT "OrderShipment_pkey" PRIMARY KEY (id);


--
-- Name: Order Order_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."Order"
    ADD CONSTRAINT "Order_pkey" PRIMARY KEY (id);


--
-- Name: PasswordResetToken PasswordResetToken_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."PasswordResetToken"
    ADD CONSTRAINT "PasswordResetToken_pkey" PRIMARY KEY (id);


--
-- Name: Popup Popup_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."Popup"
    ADD CONSTRAINT "Popup_pkey" PRIMARY KEY (id);


--
-- Name: ProductCategory ProductCategory_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."ProductCategory"
    ADD CONSTRAINT "ProductCategory_pkey" PRIMARY KEY (id);


--
-- Name: ProductVariant ProductVariant_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."ProductVariant"
    ADD CONSTRAINT "ProductVariant_pkey" PRIMARY KEY (id);


--
-- Name: Product Product_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."Product"
    ADD CONSTRAINT "Product_pkey" PRIMARY KEY (id);


--
-- Name: PromoRule PromoRule_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."PromoRule"
    ADD CONSTRAINT "PromoRule_pkey" PRIMARY KEY (id);


--
-- Name: Review Review_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."Review"
    ADD CONSTRAINT "Review_pkey" PRIMARY KEY (id);


--
-- Name: ScheduledReminder ScheduledReminder_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."ScheduledReminder"
    ADD CONSTRAINT "ScheduledReminder_pkey" PRIMARY KEY (id);


--
-- Name: Service Service_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."Service"
    ADD CONSTRAINT "Service_pkey" PRIMARY KEY (id);


--
-- Name: ShippingClass ShippingClass_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."ShippingClass"
    ADD CONSTRAINT "ShippingClass_pkey" PRIMARY KEY (id);


--
-- Name: Testimonial Testimonial_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."Testimonial"
    ADD CONSTRAINT "Testimonial_pkey" PRIMARY KEY (id);


--
-- Name: User User_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."User"
    ADD CONSTRAINT "User_pkey" PRIMARY KEY (id);


--
-- Name: WishlistItem WishlistItem_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."WishlistItem"
    ADD CONSTRAINT "WishlistItem_pkey" PRIMARY KEY (id);


--
-- Name: _prisma_migrations _prisma_migrations_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public._prisma_migrations
    ADD CONSTRAINT _prisma_migrations_pkey PRIMARY KEY (id);


--
-- Name: CartItem_sessionId_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX "CartItem_sessionId_idx" ON public."CartItem" USING btree ("sessionId");


--
-- Name: CartItem_userId_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX "CartItem_userId_idx" ON public."CartItem" USING btree ("userId");


--
-- Name: CouponCode_code_key; Type: INDEX; Schema: public; Owner: -
--

CREATE UNIQUE INDEX "CouponCode_code_key" ON public."CouponCode" USING btree (code);


--
-- Name: CouponUsage_guestEmail_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX "CouponUsage_guestEmail_idx" ON public."CouponUsage" USING btree ("guestEmail");


--
-- Name: DigitalPurchase_guestEmail_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX "DigitalPurchase_guestEmail_idx" ON public."DigitalPurchase" USING btree ("guestEmail");


--
-- Name: Invoice_invoiceNumber_key; Type: INDEX; Schema: public; Owner: -
--

CREATE UNIQUE INDEX "Invoice_invoiceNumber_key" ON public."Invoice" USING btree ("invoiceNumber");


--
-- Name: Invoice_orderId_key; Type: INDEX; Schema: public; Owner: -
--

CREATE UNIQUE INDEX "Invoice_orderId_key" ON public."Invoice" USING btree ("orderId");


--
-- Name: LegalPage_slug_key; Type: INDEX; Schema: public; Owner: -
--

CREATE UNIQUE INDEX "LegalPage_slug_key" ON public."LegalPage" USING btree (slug);


--
-- Name: OrderShipment_orderId_key; Type: INDEX; Schema: public; Owner: -
--

CREATE UNIQUE INDEX "OrderShipment_orderId_key" ON public."OrderShipment" USING btree ("orderId");


--
-- Name: PasswordResetToken_token_key; Type: INDEX; Schema: public; Owner: -
--

CREATE UNIQUE INDEX "PasswordResetToken_token_key" ON public."PasswordResetToken" USING btree (token);


--
-- Name: ProductCategory_slug_key; Type: INDEX; Schema: public; Owner: -
--

CREATE UNIQUE INDEX "ProductCategory_slug_key" ON public."ProductCategory" USING btree (slug);


--
-- Name: Product_slug_key; Type: INDEX; Schema: public; Owner: -
--

CREATE UNIQUE INDEX "Product_slug_key" ON public."Product" USING btree (slug);


--
-- Name: User_email_key; Type: INDEX; Schema: public; Owner: -
--

CREATE UNIQUE INDEX "User_email_key" ON public."User" USING btree (email);


--
-- Name: WishlistItem_userId_productId_key; Type: INDEX; Schema: public; Owner: -
--

CREATE UNIQUE INDEX "WishlistItem_userId_productId_key" ON public."WishlistItem" USING btree ("userId", "productId");


--
-- Name: Booking Booking_serviceId_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."Booking"
    ADD CONSTRAINT "Booking_serviceId_fkey" FOREIGN KEY ("serviceId") REFERENCES public."Service"(id) ON UPDATE CASCADE ON DELETE RESTRICT;


--
-- Name: Booking Booking_userId_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."Booking"
    ADD CONSTRAINT "Booking_userId_fkey" FOREIGN KEY ("userId") REFERENCES public."User"(id) ON UPDATE CASCADE ON DELETE RESTRICT;


--
-- Name: CartItem CartItem_productId_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."CartItem"
    ADD CONSTRAINT "CartItem_productId_fkey" FOREIGN KEY ("productId") REFERENCES public."Product"(id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: CartItem CartItem_userId_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."CartItem"
    ADD CONSTRAINT "CartItem_userId_fkey" FOREIGN KEY ("userId") REFERENCES public."User"(id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: CouponUsage CouponUsage_couponId_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."CouponUsage"
    ADD CONSTRAINT "CouponUsage_couponId_fkey" FOREIGN KEY ("couponId") REFERENCES public."CouponCode"(id) ON UPDATE CASCADE ON DELETE RESTRICT;


--
-- Name: CouponUsage CouponUsage_orderId_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."CouponUsage"
    ADD CONSTRAINT "CouponUsage_orderId_fkey" FOREIGN KEY ("orderId") REFERENCES public."Order"(id) ON UPDATE CASCADE ON DELETE SET NULL;


--
-- Name: CouponUsage CouponUsage_userId_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."CouponUsage"
    ADD CONSTRAINT "CouponUsage_userId_fkey" FOREIGN KEY ("userId") REFERENCES public."User"(id) ON UPDATE CASCADE ON DELETE RESTRICT;


--
-- Name: DigitalAsset DigitalAsset_productId_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."DigitalAsset"
    ADD CONSTRAINT "DigitalAsset_productId_fkey" FOREIGN KEY ("productId") REFERENCES public."Product"(id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: DigitalPurchase DigitalPurchase_digitalAssetId_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."DigitalPurchase"
    ADD CONSTRAINT "DigitalPurchase_digitalAssetId_fkey" FOREIGN KEY ("digitalAssetId") REFERENCES public."DigitalAsset"(id) ON UPDATE CASCADE ON DELETE RESTRICT;


--
-- Name: DigitalPurchase DigitalPurchase_orderId_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."DigitalPurchase"
    ADD CONSTRAINT "DigitalPurchase_orderId_fkey" FOREIGN KEY ("orderId") REFERENCES public."Order"(id) ON UPDATE CASCADE ON DELETE RESTRICT;


--
-- Name: DigitalPurchase DigitalPurchase_userId_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."DigitalPurchase"
    ADD CONSTRAINT "DigitalPurchase_userId_fkey" FOREIGN KEY ("userId") REFERENCES public."User"(id) ON UPDATE CASCADE ON DELETE RESTRICT;


--
-- Name: Invoice Invoice_orderId_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."Invoice"
    ADD CONSTRAINT "Invoice_orderId_fkey" FOREIGN KEY ("orderId") REFERENCES public."Order"(id) ON UPDATE CASCADE ON DELETE RESTRICT;


--
-- Name: OrderItem OrderItem_orderId_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."OrderItem"
    ADD CONSTRAINT "OrderItem_orderId_fkey" FOREIGN KEY ("orderId") REFERENCES public."Order"(id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: OrderItem OrderItem_productId_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."OrderItem"
    ADD CONSTRAINT "OrderItem_productId_fkey" FOREIGN KEY ("productId") REFERENCES public."Product"(id) ON UPDATE CASCADE ON DELETE RESTRICT;


--
-- Name: OrderShipment OrderShipment_orderId_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."OrderShipment"
    ADD CONSTRAINT "OrderShipment_orderId_fkey" FOREIGN KEY ("orderId") REFERENCES public."Order"(id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: Order Order_couponId_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."Order"
    ADD CONSTRAINT "Order_couponId_fkey" FOREIGN KEY ("couponId") REFERENCES public."CouponCode"(id) ON UPDATE CASCADE ON DELETE SET NULL;


--
-- Name: Order Order_userId_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."Order"
    ADD CONSTRAINT "Order_userId_fkey" FOREIGN KEY ("userId") REFERENCES public."User"(id) ON UPDATE CASCADE ON DELETE RESTRICT;


--
-- Name: PasswordResetToken PasswordResetToken_userId_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."PasswordResetToken"
    ADD CONSTRAINT "PasswordResetToken_userId_fkey" FOREIGN KEY ("userId") REFERENCES public."User"(id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: ProductVariant ProductVariant_productId_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."ProductVariant"
    ADD CONSTRAINT "ProductVariant_productId_fkey" FOREIGN KEY ("productId") REFERENCES public."Product"(id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: Product Product_categoryId_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."Product"
    ADD CONSTRAINT "Product_categoryId_fkey" FOREIGN KEY ("categoryId") REFERENCES public."ProductCategory"(id) ON UPDATE CASCADE ON DELETE RESTRICT;


--
-- Name: Product Product_shippingClassId_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."Product"
    ADD CONSTRAINT "Product_shippingClassId_fkey" FOREIGN KEY ("shippingClassId") REFERENCES public."ShippingClass"(id) ON UPDATE CASCADE ON DELETE SET NULL;


--
-- Name: Review Review_productId_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."Review"
    ADD CONSTRAINT "Review_productId_fkey" FOREIGN KEY ("productId") REFERENCES public."Product"(id) ON UPDATE CASCADE ON DELETE RESTRICT;


--
-- Name: Review Review_userId_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."Review"
    ADD CONSTRAINT "Review_userId_fkey" FOREIGN KEY ("userId") REFERENCES public."User"(id) ON UPDATE CASCADE ON DELETE RESTRICT;


--
-- Name: ScheduledReminder ScheduledReminder_bookingId_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."ScheduledReminder"
    ADD CONSTRAINT "ScheduledReminder_bookingId_fkey" FOREIGN KEY ("bookingId") REFERENCES public."Booking"(id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: WishlistItem WishlistItem_productId_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."WishlistItem"
    ADD CONSTRAINT "WishlistItem_productId_fkey" FOREIGN KEY ("productId") REFERENCES public."Product"(id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: WishlistItem WishlistItem_userId_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."WishlistItem"
    ADD CONSTRAINT "WishlistItem_userId_fkey" FOREIGN KEY ("userId") REFERENCES public."User"(id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- PostgreSQL database dump complete
--

\unrestrict T0Rqr9kvrU5O07pmFegUJ23ZopfKFXEHtmoOLHkULCjO1OaT9aLwgphL5sBGTEy

