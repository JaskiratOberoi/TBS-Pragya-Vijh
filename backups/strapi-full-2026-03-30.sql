--
-- PostgreSQL database dump
--

\restrict qjuOj8i7zNIuqefQ4njsyeOQemPe4MQp1oZD6BY1lKcv30JyGPlZHw5w6dOI9TU

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

SET default_tablespace = '';

SET default_table_access_method = heap;

--
-- Name: admin_permissions; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.admin_permissions (
    id integer NOT NULL,
    document_id character varying(255),
    action character varying(255),
    action_parameters jsonb,
    subject character varying(255),
    properties jsonb,
    conditions jsonb,
    created_at timestamp(6) without time zone,
    updated_at timestamp(6) without time zone,
    published_at timestamp(6) without time zone,
    created_by_id integer,
    updated_by_id integer,
    locale character varying(255)
);


--
-- Name: admin_permissions_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.admin_permissions_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: admin_permissions_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.admin_permissions_id_seq OWNED BY public.admin_permissions.id;


--
-- Name: admin_permissions_role_lnk; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.admin_permissions_role_lnk (
    id integer NOT NULL,
    permission_id integer,
    role_id integer,
    permission_ord double precision
);


--
-- Name: admin_permissions_role_lnk_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.admin_permissions_role_lnk_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: admin_permissions_role_lnk_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.admin_permissions_role_lnk_id_seq OWNED BY public.admin_permissions_role_lnk.id;


--
-- Name: admin_roles; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.admin_roles (
    id integer NOT NULL,
    document_id character varying(255),
    name character varying(255),
    code character varying(255),
    description character varying(255),
    created_at timestamp(6) without time zone,
    updated_at timestamp(6) without time zone,
    published_at timestamp(6) without time zone,
    created_by_id integer,
    updated_by_id integer,
    locale character varying(255)
);


--
-- Name: admin_roles_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.admin_roles_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: admin_roles_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.admin_roles_id_seq OWNED BY public.admin_roles.id;


--
-- Name: admin_users; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.admin_users (
    id integer NOT NULL,
    document_id character varying(255),
    firstname character varying(255),
    lastname character varying(255),
    username character varying(255),
    email character varying(255),
    password character varying(255),
    reset_password_token character varying(255),
    registration_token character varying(255),
    is_active boolean,
    blocked boolean,
    prefered_language character varying(255),
    created_at timestamp(6) without time zone,
    updated_at timestamp(6) without time zone,
    published_at timestamp(6) without time zone,
    created_by_id integer,
    updated_by_id integer,
    locale character varying(255)
);


--
-- Name: admin_users_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.admin_users_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: admin_users_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.admin_users_id_seq OWNED BY public.admin_users.id;


--
-- Name: admin_users_roles_lnk; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.admin_users_roles_lnk (
    id integer NOT NULL,
    user_id integer,
    role_id integer,
    role_ord double precision,
    user_ord double precision
);


--
-- Name: admin_users_roles_lnk_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.admin_users_roles_lnk_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: admin_users_roles_lnk_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.admin_users_roles_lnk_id_seq OWNED BY public.admin_users_roles_lnk.id;


--
-- Name: availability_rules; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.availability_rules (
    id integer NOT NULL,
    document_id character varying(255),
    day_of_week integer,
    start_time character varying(255),
    end_time character varying(255),
    is_active boolean,
    created_at timestamp(6) without time zone,
    updated_at timestamp(6) without time zone,
    published_at timestamp(6) without time zone,
    created_by_id integer,
    updated_by_id integer,
    locale character varying(255)
);


--
-- Name: availability_rules_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.availability_rules_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: availability_rules_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.availability_rules_id_seq OWNED BY public.availability_rules.id;


--
-- Name: banners; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.banners (
    id integer NOT NULL,
    document_id character varying(255),
    title character varying(255),
    image_url character varying(255),
    link_url character varying(255),
    "position" character varying(255),
    start_date timestamp(6) without time zone,
    end_date timestamp(6) without time zone,
    is_active boolean,
    sort_order integer,
    created_at timestamp(6) without time zone,
    updated_at timestamp(6) without time zone,
    published_at timestamp(6) without time zone,
    created_by_id integer,
    updated_by_id integer,
    locale character varying(255)
);


--
-- Name: banners_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.banners_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: banners_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.banners_id_seq OWNED BY public.banners.id;


--
-- Name: blocked_slots; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.blocked_slots (
    id integer NOT NULL,
    document_id character varying(255),
    date date,
    start_time character varying(255),
    end_time character varying(255),
    reason character varying(255),
    created_at timestamp(6) without time zone,
    updated_at timestamp(6) without time zone,
    published_at timestamp(6) without time zone,
    created_by_id integer,
    updated_by_id integer,
    locale character varying(255)
);


--
-- Name: blocked_slots_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.blocked_slots_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: blocked_slots_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.blocked_slots_id_seq OWNED BY public.blocked_slots.id;


--
-- Name: booking_setting; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.booking_setting (
    id integer NOT NULL,
    document_id character varying(255),
    slot_duration_minutes integer,
    buffer_between_slots integer,
    max_advance_booking_days integer,
    min_advance_booking_hours integer,
    cancellation_policy_hours integer,
    gcal_calendar_id character varying(255),
    gcal_sync_enabled boolean,
    gcal_refresh_token text,
    auto_confirm boolean,
    created_at timestamp(6) without time zone,
    updated_at timestamp(6) without time zone,
    published_at timestamp(6) without time zone,
    created_by_id integer,
    updated_by_id integer,
    locale character varying(255)
);


--
-- Name: booking_setting_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.booking_setting_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: booking_setting_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.booking_setting_id_seq OWNED BY public.booking_setting.id;


--
-- Name: bookings; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.bookings (
    id integer NOT NULL,
    document_id character varying(255),
    guest_name character varying(255),
    guest_email character varying(255),
    guest_phone character varying(255),
    scheduled_at timestamp(6) without time zone,
    end_at timestamp(6) without time zone,
    status character varying(255),
    payment_status character varying(255),
    rzp_order_id character varying(255),
    rzp_payment_id character varying(255),
    rzp_signature text,
    amount_paid integer,
    gcal_event_id character varying(255),
    customer_notes text,
    admin_notes text,
    cancelled_at timestamp(6) without time zone,
    cancel_reason text,
    rescheduled_from timestamp(6) without time zone,
    legacy_id character varying(255),
    created_at timestamp(6) without time zone,
    updated_at timestamp(6) without time zone,
    published_at timestamp(6) without time zone,
    created_by_id integer,
    updated_by_id integer,
    locale character varying(255)
);


--
-- Name: bookings_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.bookings_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: bookings_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.bookings_id_seq OWNED BY public.bookings.id;


--
-- Name: bookings_service_lnk; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.bookings_service_lnk (
    id integer NOT NULL,
    booking_id integer,
    service_id integer,
    booking_ord double precision
);


--
-- Name: bookings_service_lnk_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.bookings_service_lnk_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: bookings_service_lnk_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.bookings_service_lnk_id_seq OWNED BY public.bookings_service_lnk.id;


--
-- Name: bookings_user_lnk; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.bookings_user_lnk (
    id integer NOT NULL,
    booking_id integer,
    user_id integer,
    booking_ord double precision
);


--
-- Name: bookings_user_lnk_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.bookings_user_lnk_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: bookings_user_lnk_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.bookings_user_lnk_id_seq OWNED BY public.bookings_user_lnk.id;


--
-- Name: business_setting; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.business_setting (
    id integer NOT NULL,
    document_id character varying(255),
    business_name character varying(255),
    gstin character varying(255),
    pan character varying(255),
    address text,
    state character varying(255),
    state_code character varying(255),
    phone character varying(255),
    email character varying(255),
    logo_url character varying(255),
    bank_name character varying(255),
    bank_account character varying(255),
    bank_ifsc character varying(255),
    invoice_prefix character varying(255),
    next_invoice_number integer,
    fb_pixel_id character varying(255),
    fb_pixel_enabled boolean,
    created_at timestamp(6) without time zone,
    updated_at timestamp(6) without time zone,
    published_at timestamp(6) without time zone,
    created_by_id integer,
    updated_by_id integer,
    locale character varying(255)
);


--
-- Name: business_setting_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.business_setting_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: business_setting_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.business_setting_id_seq OWNED BY public.business_setting.id;


--
-- Name: cart_items; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.cart_items (
    id integer NOT NULL,
    document_id character varying(255),
    session_id character varying(255),
    quantity integer,
    variant_selection jsonb,
    created_at timestamp(6) without time zone,
    updated_at timestamp(6) without time zone,
    published_at timestamp(6) without time zone,
    created_by_id integer,
    updated_by_id integer,
    locale character varying(255)
);


--
-- Name: cart_items_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.cart_items_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: cart_items_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.cart_items_id_seq OWNED BY public.cart_items.id;


--
-- Name: cart_items_product_lnk; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.cart_items_product_lnk (
    id integer NOT NULL,
    cart_item_id integer,
    product_id integer,
    cart_item_ord double precision
);


--
-- Name: cart_items_product_lnk_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.cart_items_product_lnk_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: cart_items_product_lnk_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.cart_items_product_lnk_id_seq OWNED BY public.cart_items_product_lnk.id;


--
-- Name: cart_items_user_lnk; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.cart_items_user_lnk (
    id integer NOT NULL,
    cart_item_id integer,
    user_id integer,
    cart_item_ord double precision
);


--
-- Name: cart_items_user_lnk_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.cart_items_user_lnk_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: cart_items_user_lnk_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.cart_items_user_lnk_id_seq OWNED BY public.cart_items_user_lnk.id;


--
-- Name: commerce_placeholders; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.commerce_placeholders (
    id integer NOT NULL,
    document_id character varying(255),
    name character varying(255),
    created_at timestamp(6) without time zone,
    updated_at timestamp(6) without time zone,
    published_at timestamp(6) without time zone,
    created_by_id integer,
    updated_by_id integer,
    locale character varying(255)
);


--
-- Name: commerce_placeholders_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.commerce_placeholders_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: commerce_placeholders_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.commerce_placeholders_id_seq OWNED BY public.commerce_placeholders.id;


--
-- Name: contact_messages; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.contact_messages (
    id integer NOT NULL,
    document_id character varying(255),
    name character varying(255),
    email character varying(255),
    phone character varying(255),
    company character varying(255),
    message text,
    is_read boolean,
    created_at timestamp(6) without time zone,
    updated_at timestamp(6) without time zone,
    published_at timestamp(6) without time zone,
    created_by_id integer,
    updated_by_id integer,
    locale character varying(255)
);


--
-- Name: contact_messages_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.contact_messages_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: contact_messages_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.contact_messages_id_seq OWNED BY public.contact_messages.id;


--
-- Name: coupon_codes; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.coupon_codes (
    id integer NOT NULL,
    document_id character varying(255),
    code character varying(255),
    description text,
    discount_type character varying(255),
    discount_value integer,
    min_cart_total integer,
    max_discount integer,
    max_uses integer,
    used_count integer,
    per_user_limit integer,
    valid_from timestamp(6) without time zone,
    valid_until timestamp(6) without time zone,
    is_active boolean,
    applicable_category_ids jsonb,
    applicable_product_ids jsonb,
    created_at timestamp(6) without time zone,
    updated_at timestamp(6) without time zone,
    published_at timestamp(6) without time zone,
    created_by_id integer,
    updated_by_id integer,
    locale character varying(255)
);


--
-- Name: coupon_codes_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.coupon_codes_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: coupon_codes_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.coupon_codes_id_seq OWNED BY public.coupon_codes.id;


--
-- Name: coupon_usages; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.coupon_usages (
    id integer NOT NULL,
    document_id character varying(255),
    guest_email character varying(255),
    discount_amount integer,
    used_at timestamp(6) without time zone,
    created_at timestamp(6) without time zone,
    updated_at timestamp(6) without time zone,
    published_at timestamp(6) without time zone,
    created_by_id integer,
    updated_by_id integer,
    locale character varying(255)
);


--
-- Name: coupon_usages_coupon_lnk; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.coupon_usages_coupon_lnk (
    id integer NOT NULL,
    coupon_usage_id integer,
    coupon_code_id integer,
    coupon_usage_ord double precision
);


--
-- Name: coupon_usages_coupon_lnk_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.coupon_usages_coupon_lnk_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: coupon_usages_coupon_lnk_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.coupon_usages_coupon_lnk_id_seq OWNED BY public.coupon_usages_coupon_lnk.id;


--
-- Name: coupon_usages_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.coupon_usages_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: coupon_usages_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.coupon_usages_id_seq OWNED BY public.coupon_usages.id;


--
-- Name: coupon_usages_order_lnk; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.coupon_usages_order_lnk (
    id integer NOT NULL,
    coupon_usage_id integer,
    order_id integer,
    coupon_usage_ord double precision
);


--
-- Name: coupon_usages_order_lnk_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.coupon_usages_order_lnk_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: coupon_usages_order_lnk_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.coupon_usages_order_lnk_id_seq OWNED BY public.coupon_usages_order_lnk.id;


--
-- Name: coupon_usages_user_lnk; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.coupon_usages_user_lnk (
    id integer NOT NULL,
    coupon_usage_id integer,
    user_id integer,
    coupon_usage_ord double precision
);


--
-- Name: coupon_usages_user_lnk_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.coupon_usages_user_lnk_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: coupon_usages_user_lnk_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.coupon_usages_user_lnk_id_seq OWNED BY public.coupon_usages_user_lnk.id;


--
-- Name: digital_assets; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.digital_assets (
    id integer NOT NULL,
    document_id character varying(255),
    asset_type character varying(255),
    url character varying(255),
    file_name character varying(255),
    file_size integer,
    access_instructions text,
    created_at timestamp(6) without time zone,
    updated_at timestamp(6) without time zone,
    published_at timestamp(6) without time zone,
    created_by_id integer,
    updated_by_id integer,
    locale character varying(255)
);


--
-- Name: digital_assets_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.digital_assets_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: digital_assets_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.digital_assets_id_seq OWNED BY public.digital_assets.id;


--
-- Name: digital_assets_product_lnk; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.digital_assets_product_lnk (
    id integer NOT NULL,
    digital_asset_id integer,
    product_id integer,
    digital_asset_ord double precision
);


--
-- Name: digital_assets_product_lnk_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.digital_assets_product_lnk_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: digital_assets_product_lnk_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.digital_assets_product_lnk_id_seq OWNED BY public.digital_assets_product_lnk.id;


--
-- Name: digital_purchases; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.digital_purchases (
    id integer NOT NULL,
    document_id character varying(255),
    guest_email character varying(255),
    access_granted_at timestamp(6) without time zone,
    access_url character varying(255),
    expires_at timestamp(6) without time zone,
    created_at timestamp(6) without time zone,
    updated_at timestamp(6) without time zone,
    published_at timestamp(6) without time zone,
    created_by_id integer,
    updated_by_id integer,
    locale character varying(255)
);


--
-- Name: digital_purchases_asset_lnk; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.digital_purchases_asset_lnk (
    id integer NOT NULL,
    digital_purchase_id integer,
    digital_asset_id integer,
    digital_purchase_ord double precision
);


--
-- Name: digital_purchases_asset_lnk_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.digital_purchases_asset_lnk_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: digital_purchases_asset_lnk_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.digital_purchases_asset_lnk_id_seq OWNED BY public.digital_purchases_asset_lnk.id;


--
-- Name: digital_purchases_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.digital_purchases_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: digital_purchases_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.digital_purchases_id_seq OWNED BY public.digital_purchases.id;


--
-- Name: digital_purchases_order_lnk; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.digital_purchases_order_lnk (
    id integer NOT NULL,
    digital_purchase_id integer,
    order_id integer,
    digital_purchase_ord double precision
);


--
-- Name: digital_purchases_order_lnk_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.digital_purchases_order_lnk_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: digital_purchases_order_lnk_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.digital_purchases_order_lnk_id_seq OWNED BY public.digital_purchases_order_lnk.id;


--
-- Name: digital_purchases_product_lnk; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.digital_purchases_product_lnk (
    id integer NOT NULL,
    digital_purchase_id integer,
    product_id integer,
    digital_purchase_ord double precision
);


--
-- Name: digital_purchases_product_lnk_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.digital_purchases_product_lnk_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: digital_purchases_product_lnk_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.digital_purchases_product_lnk_id_seq OWNED BY public.digital_purchases_product_lnk.id;


--
-- Name: digital_purchases_user_lnk; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.digital_purchases_user_lnk (
    id integer NOT NULL,
    digital_purchase_id integer,
    user_id integer,
    digital_purchase_ord double precision
);


--
-- Name: digital_purchases_user_lnk_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.digital_purchases_user_lnk_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: digital_purchases_user_lnk_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.digital_purchases_user_lnk_id_seq OWNED BY public.digital_purchases_user_lnk.id;


--
-- Name: email_logs; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.email_logs (
    id integer NOT NULL,
    document_id character varying(255),
    "to" character varying(255),
    subject character varying(255),
    template_name character varying(255),
    status character varying(255),
    related_type character varying(255),
    related_id character varying(255),
    error text,
    sent_at timestamp(6) without time zone,
    created_at timestamp(6) without time zone,
    updated_at timestamp(6) without time zone,
    published_at timestamp(6) without time zone,
    created_by_id integer,
    updated_by_id integer,
    locale character varying(255)
);


--
-- Name: email_logs_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.email_logs_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: email_logs_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.email_logs_id_seq OWNED BY public.email_logs.id;


--
-- Name: files; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.files (
    id integer NOT NULL,
    document_id character varying(255),
    name character varying(255),
    alternative_text text,
    caption text,
    focal_point jsonb,
    width integer,
    height integer,
    formats jsonb,
    hash character varying(255),
    ext character varying(255),
    mime character varying(255),
    size numeric(10,2),
    url text,
    preview_url text,
    provider character varying(255),
    provider_metadata jsonb,
    folder_path character varying(255),
    created_at timestamp(6) without time zone,
    updated_at timestamp(6) without time zone,
    published_at timestamp(6) without time zone,
    created_by_id integer,
    updated_by_id integer,
    locale character varying(255)
);


--
-- Name: files_folder_lnk; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.files_folder_lnk (
    id integer NOT NULL,
    file_id integer,
    folder_id integer,
    file_ord double precision
);


--
-- Name: files_folder_lnk_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.files_folder_lnk_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: files_folder_lnk_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.files_folder_lnk_id_seq OWNED BY public.files_folder_lnk.id;


--
-- Name: files_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.files_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: files_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.files_id_seq OWNED BY public.files.id;


--
-- Name: files_related_mph; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.files_related_mph (
    id integer NOT NULL,
    file_id integer,
    related_id integer,
    related_type character varying(255),
    field character varying(255),
    "order" double precision
);


--
-- Name: files_related_mph_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.files_related_mph_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: files_related_mph_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.files_related_mph_id_seq OWNED BY public.files_related_mph.id;


--
-- Name: i18n_locale; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.i18n_locale (
    id integer NOT NULL,
    document_id character varying(255),
    name character varying(255),
    code character varying(255),
    created_at timestamp(6) without time zone,
    updated_at timestamp(6) without time zone,
    published_at timestamp(6) without time zone,
    created_by_id integer,
    updated_by_id integer,
    locale character varying(255)
);


--
-- Name: i18n_locale_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.i18n_locale_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: i18n_locale_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.i18n_locale_id_seq OWNED BY public.i18n_locale.id;


--
-- Name: invoices; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.invoices (
    id integer NOT NULL,
    document_id character varying(255),
    invoice_number character varying(255),
    invoice_date timestamp(6) without time zone,
    buyer_name character varying(255),
    buyer_address jsonb,
    buyer_gstin character varying(255),
    buyer_state character varying(255),
    buyer_state_code character varying(255),
    items jsonb,
    subtotal integer,
    cgst integer,
    sgst integer,
    igst integer,
    total_tax integer,
    grand_total integer,
    place_of_supply character varying(255),
    is_inter_state boolean,
    pdf_url character varying(255),
    created_at timestamp(6) without time zone,
    updated_at timestamp(6) without time zone,
    published_at timestamp(6) without time zone,
    created_by_id integer,
    updated_by_id integer,
    locale character varying(255)
);


--
-- Name: invoices_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.invoices_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: invoices_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.invoices_id_seq OWNED BY public.invoices.id;


--
-- Name: invoices_order_lnk; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.invoices_order_lnk (
    id integer NOT NULL,
    invoice_id integer,
    order_id integer
);


--
-- Name: invoices_order_lnk_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.invoices_order_lnk_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: invoices_order_lnk_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.invoices_order_lnk_id_seq OWNED BY public.invoices_order_lnk.id;


--
-- Name: legal_pages; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.legal_pages (
    id integer NOT NULL,
    document_id character varying(255),
    slug character varying(255),
    title character varying(255),
    content text,
    created_at timestamp(6) without time zone,
    updated_at timestamp(6) without time zone,
    published_at timestamp(6) without time zone,
    created_by_id integer,
    updated_by_id integer,
    locale character varying(255)
);


--
-- Name: legal_pages_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.legal_pages_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: legal_pages_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.legal_pages_id_seq OWNED BY public.legal_pages.id;


--
-- Name: order_items; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.order_items (
    id integer NOT NULL,
    document_id character varying(255),
    variant_selection jsonb,
    quantity integer,
    unit_price integer,
    gst_rate_bps integer,
    hsn_code character varying(255),
    created_at timestamp(6) without time zone,
    updated_at timestamp(6) without time zone,
    published_at timestamp(6) without time zone,
    created_by_id integer,
    updated_by_id integer,
    locale character varying(255)
);


--
-- Name: order_items_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.order_items_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: order_items_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.order_items_id_seq OWNED BY public.order_items.id;


--
-- Name: order_items_order_lnk; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.order_items_order_lnk (
    id integer NOT NULL,
    order_item_id integer,
    order_id integer,
    order_item_ord double precision
);


--
-- Name: order_items_order_lnk_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.order_items_order_lnk_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: order_items_order_lnk_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.order_items_order_lnk_id_seq OWNED BY public.order_items_order_lnk.id;


--
-- Name: order_items_product_lnk; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.order_items_product_lnk (
    id integer NOT NULL,
    order_item_id integer,
    product_id integer,
    order_item_ord double precision
);


--
-- Name: order_items_product_lnk_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.order_items_product_lnk_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: order_items_product_lnk_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.order_items_product_lnk_id_seq OWNED BY public.order_items_product_lnk.id;


--
-- Name: order_shipments; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.order_shipments (
    id integer NOT NULL,
    document_id character varying(255),
    courier_name character varying(255),
    tracking_number character varying(255),
    tracking_url character varying(255),
    shipped_at timestamp(6) without time zone,
    delivered_at timestamp(6) without time zone,
    notes text,
    created_at timestamp(6) without time zone,
    updated_at timestamp(6) without time zone,
    published_at timestamp(6) without time zone,
    created_by_id integer,
    updated_by_id integer,
    locale character varying(255)
);


--
-- Name: order_shipments_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.order_shipments_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: order_shipments_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.order_shipments_id_seq OWNED BY public.order_shipments.id;


--
-- Name: order_shipments_order_lnk; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.order_shipments_order_lnk (
    id integer NOT NULL,
    order_shipment_id integer,
    order_id integer
);


--
-- Name: order_shipments_order_lnk_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.order_shipments_order_lnk_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: order_shipments_order_lnk_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.order_shipments_order_lnk_id_seq OWNED BY public.order_shipments_order_lnk.id;


--
-- Name: orders; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.orders (
    id integer NOT NULL,
    document_id character varying(255),
    guest_name character varying(255),
    guest_email character varying(255),
    guest_phone character varying(255),
    status character varying(255),
    subtotal integer,
    discount integer,
    tax integer,
    shipping_amount integer,
    total integer,
    rzp_order_id character varying(255),
    rzp_payment_id character varying(255),
    rzp_signature text,
    payment_status character varying(255),
    payment_method character varying(255),
    refund_id character varying(255),
    refund_status character varying(255),
    refund_amount integer,
    shipping_address jsonb,
    billing_address jsonb,
    notes text,
    legacy_id character varying(255),
    created_at timestamp(6) without time zone,
    updated_at timestamp(6) without time zone,
    published_at timestamp(6) without time zone,
    created_by_id integer,
    updated_by_id integer,
    locale character varying(255)
);


--
-- Name: orders_coupon_lnk; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.orders_coupon_lnk (
    id integer NOT NULL,
    order_id integer,
    coupon_code_id integer,
    order_ord double precision
);


--
-- Name: orders_coupon_lnk_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.orders_coupon_lnk_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: orders_coupon_lnk_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.orders_coupon_lnk_id_seq OWNED BY public.orders_coupon_lnk.id;


--
-- Name: orders_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.orders_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: orders_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.orders_id_seq OWNED BY public.orders.id;


--
-- Name: orders_user_lnk; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.orders_user_lnk (
    id integer NOT NULL,
    order_id integer,
    user_id integer,
    order_ord double precision
);


--
-- Name: orders_user_lnk_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.orders_user_lnk_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: orders_user_lnk_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.orders_user_lnk_id_seq OWNED BY public.orders_user_lnk.id;


--
-- Name: password_reset_tokens; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.password_reset_tokens (
    id integer NOT NULL,
    document_id character varying(255),
    token character varying(255),
    expires_at timestamp(6) without time zone,
    created_at timestamp(6) without time zone,
    updated_at timestamp(6) without time zone,
    published_at timestamp(6) without time zone,
    created_by_id integer,
    updated_by_id integer,
    locale character varying(255)
);


--
-- Name: password_reset_tokens_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.password_reset_tokens_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: password_reset_tokens_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.password_reset_tokens_id_seq OWNED BY public.password_reset_tokens.id;


--
-- Name: password_reset_tokens_user_lnk; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.password_reset_tokens_user_lnk (
    id integer NOT NULL,
    password_reset_token_id integer,
    user_id integer,
    password_reset_token_ord double precision
);


--
-- Name: password_reset_tokens_user_lnk_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.password_reset_tokens_user_lnk_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: password_reset_tokens_user_lnk_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.password_reset_tokens_user_lnk_id_seq OWNED BY public.password_reset_tokens_user_lnk.id;


--
-- Name: popups; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.popups (
    id integer NOT NULL,
    document_id character varying(255),
    title character varying(255),
    content text,
    image_url character varying(255),
    link_url character varying(255),
    trigger_type character varying(255),
    trigger_value integer,
    show_on_pages jsonb,
    frequency character varying(255),
    start_date timestamp(6) without time zone,
    end_date timestamp(6) without time zone,
    is_active boolean,
    created_at timestamp(6) without time zone,
    updated_at timestamp(6) without time zone,
    published_at timestamp(6) without time zone,
    created_by_id integer,
    updated_by_id integer,
    locale character varying(255)
);


--
-- Name: popups_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.popups_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: popups_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.popups_id_seq OWNED BY public.popups.id;


--
-- Name: product_categories; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.product_categories (
    id integer NOT NULL,
    document_id character varying(255),
    name character varying(255),
    slug character varying(255),
    sort_order integer,
    created_at timestamp(6) without time zone,
    updated_at timestamp(6) without time zone,
    published_at timestamp(6) without time zone,
    created_by_id integer,
    updated_by_id integer,
    locale character varying(255)
);


--
-- Name: product_categories_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.product_categories_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: product_categories_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.product_categories_id_seq OWNED BY public.product_categories.id;


--
-- Name: product_variants; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.product_variants (
    id integer NOT NULL,
    document_id character varying(255),
    name character varying(255),
    options jsonb,
    created_at timestamp(6) without time zone,
    updated_at timestamp(6) without time zone,
    published_at timestamp(6) without time zone,
    created_by_id integer,
    updated_by_id integer,
    locale character varying(255)
);


--
-- Name: product_variants_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.product_variants_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: product_variants_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.product_variants_id_seq OWNED BY public.product_variants.id;


--
-- Name: product_variants_product_lnk; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.product_variants_product_lnk (
    id integer NOT NULL,
    product_variant_id integer,
    product_id integer,
    product_variant_ord double precision
);


--
-- Name: product_variants_product_lnk_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.product_variants_product_lnk_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: product_variants_product_lnk_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.product_variants_product_lnk_id_seq OWNED BY public.product_variants_product_lnk.id;


--
-- Name: products; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.products (
    id integer NOT NULL,
    document_id character varying(255),
    name character varying(255),
    slug character varying(255),
    description text,
    product_type character varying(255),
    price integer,
    sale_price integer,
    stock integer,
    images jsonb,
    healing_properties text,
    wear_hand character varying(255),
    hsn_code character varying(255),
    gst_rate_bps integer,
    is_active boolean,
    created_at timestamp(6) without time zone,
    updated_at timestamp(6) without time zone,
    published_at timestamp(6) without time zone,
    created_by_id integer,
    updated_by_id integer,
    locale character varying(255)
);


--
-- Name: products_category_lnk; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.products_category_lnk (
    id integer NOT NULL,
    product_id integer,
    product_category_id integer,
    product_ord double precision
);


--
-- Name: products_category_lnk_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.products_category_lnk_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: products_category_lnk_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.products_category_lnk_id_seq OWNED BY public.products_category_lnk.id;


--
-- Name: products_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.products_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: products_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.products_id_seq OWNED BY public.products.id;


--
-- Name: products_shipping_class_lnk; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.products_shipping_class_lnk (
    id integer NOT NULL,
    product_id integer,
    shipping_class_id integer,
    product_ord double precision
);


--
-- Name: products_shipping_class_lnk_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.products_shipping_class_lnk_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: products_shipping_class_lnk_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.products_shipping_class_lnk_id_seq OWNED BY public.products_shipping_class_lnk.id;


--
-- Name: promo_rules; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.promo_rules (
    id integer NOT NULL,
    document_id character varying(255),
    type character varying(255),
    config jsonb,
    is_active boolean,
    created_at timestamp(6) without time zone,
    updated_at timestamp(6) without time zone,
    published_at timestamp(6) without time zone,
    created_by_id integer,
    updated_by_id integer,
    locale character varying(255)
);


--
-- Name: promo_rules_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.promo_rules_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: promo_rules_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.promo_rules_id_seq OWNED BY public.promo_rules.id;


--
-- Name: reviews; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.reviews (
    id integer NOT NULL,
    document_id character varying(255),
    rating integer,
    comment text,
    created_at timestamp(6) without time zone,
    updated_at timestamp(6) without time zone,
    published_at timestamp(6) without time zone,
    created_by_id integer,
    updated_by_id integer,
    locale character varying(255)
);


--
-- Name: reviews_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.reviews_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: reviews_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.reviews_id_seq OWNED BY public.reviews.id;


--
-- Name: reviews_product_lnk; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.reviews_product_lnk (
    id integer NOT NULL,
    review_id integer,
    product_id integer,
    review_ord double precision
);


--
-- Name: reviews_product_lnk_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.reviews_product_lnk_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: reviews_product_lnk_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.reviews_product_lnk_id_seq OWNED BY public.reviews_product_lnk.id;


--
-- Name: reviews_user_lnk; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.reviews_user_lnk (
    id integer NOT NULL,
    review_id integer,
    user_id integer,
    review_ord double precision
);


--
-- Name: reviews_user_lnk_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.reviews_user_lnk_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: reviews_user_lnk_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.reviews_user_lnk_id_seq OWNED BY public.reviews_user_lnk.id;


--
-- Name: scheduled_reminders; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.scheduled_reminders (
    id integer NOT NULL,
    document_id character varying(255),
    reminder_type character varying(255),
    scheduled_for timestamp(6) without time zone,
    sent boolean,
    sent_at timestamp(6) without time zone,
    created_at timestamp(6) without time zone,
    updated_at timestamp(6) without time zone,
    published_at timestamp(6) without time zone,
    created_by_id integer,
    updated_by_id integer,
    locale character varying(255)
);


--
-- Name: scheduled_reminders_booking_lnk; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.scheduled_reminders_booking_lnk (
    id integer NOT NULL,
    scheduled_reminder_id integer,
    booking_id integer,
    scheduled_reminder_ord double precision
);


--
-- Name: scheduled_reminders_booking_lnk_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.scheduled_reminders_booking_lnk_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: scheduled_reminders_booking_lnk_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.scheduled_reminders_booking_lnk_id_seq OWNED BY public.scheduled_reminders_booking_lnk.id;


--
-- Name: scheduled_reminders_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.scheduled_reminders_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: scheduled_reminders_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.scheduled_reminders_id_seq OWNED BY public.scheduled_reminders.id;


--
-- Name: services; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.services (
    id integer NOT NULL,
    document_id character varying(255),
    name character varying(255),
    type character varying(255),
    price integer,
    duration_minutes integer,
    staff_id character varying(255),
    buffer_minutes integer,
    is_active boolean,
    description text,
    created_at timestamp(6) without time zone,
    updated_at timestamp(6) without time zone,
    published_at timestamp(6) without time zone,
    created_by_id integer,
    updated_by_id integer,
    locale character varying(255)
);


--
-- Name: services_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.services_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: services_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.services_id_seq OWNED BY public.services.id;


--
-- Name: shipping_classes; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.shipping_classes (
    id integer NOT NULL,
    document_id character varying(255),
    name character varying(255),
    rate integer,
    free_above integer,
    description text,
    created_at timestamp(6) without time zone,
    updated_at timestamp(6) without time zone,
    published_at timestamp(6) without time zone,
    created_by_id integer,
    updated_by_id integer,
    locale character varying(255)
);


--
-- Name: shipping_classes_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.shipping_classes_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: shipping_classes_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.shipping_classes_id_seq OWNED BY public.shipping_classes.id;


--
-- Name: strapi_ai_localization_jobs; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.strapi_ai_localization_jobs (
    id integer NOT NULL,
    content_type character varying(255) NOT NULL,
    related_document_id character varying(255) NOT NULL,
    source_locale character varying(255) NOT NULL,
    target_locales jsonb NOT NULL,
    status character varying(255) NOT NULL,
    created_at timestamp(6) without time zone,
    updated_at timestamp(6) without time zone
);


--
-- Name: strapi_ai_localization_jobs_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.strapi_ai_localization_jobs_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: strapi_ai_localization_jobs_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.strapi_ai_localization_jobs_id_seq OWNED BY public.strapi_ai_localization_jobs.id;


--
-- Name: strapi_ai_metadata_jobs; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.strapi_ai_metadata_jobs (
    id integer NOT NULL,
    status character varying(255) NOT NULL,
    created_at timestamp(6) without time zone,
    completed_at timestamp(6) without time zone
);


--
-- Name: strapi_ai_metadata_jobs_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.strapi_ai_metadata_jobs_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: strapi_ai_metadata_jobs_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.strapi_ai_metadata_jobs_id_seq OWNED BY public.strapi_ai_metadata_jobs.id;


--
-- Name: strapi_api_token_permissions; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.strapi_api_token_permissions (
    id integer NOT NULL,
    document_id character varying(255),
    action character varying(255),
    created_at timestamp(6) without time zone,
    updated_at timestamp(6) without time zone,
    published_at timestamp(6) without time zone,
    created_by_id integer,
    updated_by_id integer,
    locale character varying(255)
);


--
-- Name: strapi_api_token_permissions_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.strapi_api_token_permissions_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: strapi_api_token_permissions_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.strapi_api_token_permissions_id_seq OWNED BY public.strapi_api_token_permissions.id;


--
-- Name: strapi_api_token_permissions_token_lnk; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.strapi_api_token_permissions_token_lnk (
    id integer NOT NULL,
    api_token_permission_id integer,
    api_token_id integer,
    api_token_permission_ord double precision
);


--
-- Name: strapi_api_token_permissions_token_lnk_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.strapi_api_token_permissions_token_lnk_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: strapi_api_token_permissions_token_lnk_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.strapi_api_token_permissions_token_lnk_id_seq OWNED BY public.strapi_api_token_permissions_token_lnk.id;


--
-- Name: strapi_api_tokens; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.strapi_api_tokens (
    id integer NOT NULL,
    document_id character varying(255),
    name character varying(255),
    description character varying(255),
    type character varying(255),
    access_key character varying(255),
    encrypted_key text,
    last_used_at timestamp(6) without time zone,
    expires_at timestamp(6) without time zone,
    lifespan bigint,
    created_at timestamp(6) without time zone,
    updated_at timestamp(6) without time zone,
    published_at timestamp(6) without time zone,
    created_by_id integer,
    updated_by_id integer,
    locale character varying(255)
);


--
-- Name: strapi_api_tokens_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.strapi_api_tokens_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: strapi_api_tokens_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.strapi_api_tokens_id_seq OWNED BY public.strapi_api_tokens.id;


--
-- Name: strapi_core_store_settings; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.strapi_core_store_settings (
    id integer NOT NULL,
    key character varying(255),
    value text,
    type character varying(255),
    environment character varying(255),
    tag character varying(255)
);


--
-- Name: strapi_core_store_settings_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.strapi_core_store_settings_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: strapi_core_store_settings_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.strapi_core_store_settings_id_seq OWNED BY public.strapi_core_store_settings.id;


--
-- Name: strapi_database_schema; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.strapi_database_schema (
    id integer NOT NULL,
    schema json,
    "time" timestamp without time zone,
    hash character varying(255)
);


--
-- Name: strapi_database_schema_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.strapi_database_schema_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: strapi_database_schema_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.strapi_database_schema_id_seq OWNED BY public.strapi_database_schema.id;


--
-- Name: strapi_history_versions; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.strapi_history_versions (
    id integer NOT NULL,
    content_type character varying(255) NOT NULL,
    related_document_id character varying(255),
    locale character varying(255),
    status character varying(255),
    data jsonb,
    schema jsonb,
    created_at timestamp(6) without time zone,
    created_by_id integer
);


--
-- Name: strapi_history_versions_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.strapi_history_versions_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: strapi_history_versions_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.strapi_history_versions_id_seq OWNED BY public.strapi_history_versions.id;


--
-- Name: strapi_migrations; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.strapi_migrations (
    id integer NOT NULL,
    name character varying(255),
    "time" timestamp without time zone
);


--
-- Name: strapi_migrations_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.strapi_migrations_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: strapi_migrations_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.strapi_migrations_id_seq OWNED BY public.strapi_migrations.id;


--
-- Name: strapi_migrations_internal; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.strapi_migrations_internal (
    id integer NOT NULL,
    name character varying(255),
    "time" timestamp without time zone
);


--
-- Name: strapi_migrations_internal_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.strapi_migrations_internal_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: strapi_migrations_internal_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.strapi_migrations_internal_id_seq OWNED BY public.strapi_migrations_internal.id;


--
-- Name: strapi_release_actions; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.strapi_release_actions (
    id integer NOT NULL,
    document_id character varying(255),
    type character varying(255),
    content_type character varying(255),
    entry_document_id character varying(255),
    locale character varying(255),
    is_entry_valid boolean,
    created_at timestamp(6) without time zone,
    updated_at timestamp(6) without time zone,
    published_at timestamp(6) without time zone,
    created_by_id integer,
    updated_by_id integer
);


--
-- Name: strapi_release_actions_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.strapi_release_actions_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: strapi_release_actions_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.strapi_release_actions_id_seq OWNED BY public.strapi_release_actions.id;


--
-- Name: strapi_release_actions_release_lnk; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.strapi_release_actions_release_lnk (
    id integer NOT NULL,
    release_action_id integer,
    release_id integer,
    release_action_ord double precision
);


--
-- Name: strapi_release_actions_release_lnk_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.strapi_release_actions_release_lnk_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: strapi_release_actions_release_lnk_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.strapi_release_actions_release_lnk_id_seq OWNED BY public.strapi_release_actions_release_lnk.id;


--
-- Name: strapi_releases; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.strapi_releases (
    id integer NOT NULL,
    document_id character varying(255),
    name character varying(255),
    released_at timestamp(6) without time zone,
    scheduled_at timestamp(6) without time zone,
    timezone character varying(255),
    status character varying(255),
    created_at timestamp(6) without time zone,
    updated_at timestamp(6) without time zone,
    published_at timestamp(6) without time zone,
    created_by_id integer,
    updated_by_id integer,
    locale character varying(255)
);


--
-- Name: strapi_releases_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.strapi_releases_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: strapi_releases_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.strapi_releases_id_seq OWNED BY public.strapi_releases.id;


--
-- Name: strapi_sessions; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.strapi_sessions (
    id integer NOT NULL,
    document_id character varying(255),
    user_id character varying(255),
    session_id character varying(255),
    child_id character varying(255),
    device_id character varying(255),
    origin character varying(255),
    expires_at timestamp(6) without time zone,
    absolute_expires_at timestamp(6) without time zone,
    status character varying(255),
    type character varying(255),
    created_at timestamp(6) without time zone,
    updated_at timestamp(6) without time zone,
    published_at timestamp(6) without time zone,
    created_by_id integer,
    updated_by_id integer,
    locale character varying(255)
);


--
-- Name: strapi_sessions_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.strapi_sessions_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: strapi_sessions_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.strapi_sessions_id_seq OWNED BY public.strapi_sessions.id;


--
-- Name: strapi_transfer_token_permissions; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.strapi_transfer_token_permissions (
    id integer NOT NULL,
    document_id character varying(255),
    action character varying(255),
    created_at timestamp(6) without time zone,
    updated_at timestamp(6) without time zone,
    published_at timestamp(6) without time zone,
    created_by_id integer,
    updated_by_id integer,
    locale character varying(255)
);


--
-- Name: strapi_transfer_token_permissions_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.strapi_transfer_token_permissions_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: strapi_transfer_token_permissions_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.strapi_transfer_token_permissions_id_seq OWNED BY public.strapi_transfer_token_permissions.id;


--
-- Name: strapi_transfer_token_permissions_token_lnk; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.strapi_transfer_token_permissions_token_lnk (
    id integer NOT NULL,
    transfer_token_permission_id integer,
    transfer_token_id integer,
    transfer_token_permission_ord double precision
);


--
-- Name: strapi_transfer_token_permissions_token_lnk_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.strapi_transfer_token_permissions_token_lnk_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: strapi_transfer_token_permissions_token_lnk_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.strapi_transfer_token_permissions_token_lnk_id_seq OWNED BY public.strapi_transfer_token_permissions_token_lnk.id;


--
-- Name: strapi_transfer_tokens; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.strapi_transfer_tokens (
    id integer NOT NULL,
    document_id character varying(255),
    name character varying(255),
    description character varying(255),
    access_key character varying(255),
    last_used_at timestamp(6) without time zone,
    expires_at timestamp(6) without time zone,
    lifespan bigint,
    created_at timestamp(6) without time zone,
    updated_at timestamp(6) without time zone,
    published_at timestamp(6) without time zone,
    created_by_id integer,
    updated_by_id integer,
    locale character varying(255)
);


--
-- Name: strapi_transfer_tokens_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.strapi_transfer_tokens_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: strapi_transfer_tokens_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.strapi_transfer_tokens_id_seq OWNED BY public.strapi_transfer_tokens.id;


--
-- Name: strapi_webhooks; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.strapi_webhooks (
    id integer NOT NULL,
    name character varying(255),
    url text,
    headers jsonb,
    events jsonb,
    enabled boolean
);


--
-- Name: strapi_webhooks_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.strapi_webhooks_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: strapi_webhooks_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.strapi_webhooks_id_seq OWNED BY public.strapi_webhooks.id;


--
-- Name: strapi_workflows; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.strapi_workflows (
    id integer NOT NULL,
    document_id character varying(255),
    name character varying(255),
    content_types jsonb,
    created_at timestamp(6) without time zone,
    updated_at timestamp(6) without time zone,
    published_at timestamp(6) without time zone,
    created_by_id integer,
    updated_by_id integer,
    locale character varying(255)
);


--
-- Name: strapi_workflows_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.strapi_workflows_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: strapi_workflows_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.strapi_workflows_id_seq OWNED BY public.strapi_workflows.id;


--
-- Name: strapi_workflows_stage_required_to_publish_lnk; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.strapi_workflows_stage_required_to_publish_lnk (
    id integer NOT NULL,
    workflow_id integer,
    workflow_stage_id integer
);


--
-- Name: strapi_workflows_stage_required_to_publish_lnk_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.strapi_workflows_stage_required_to_publish_lnk_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: strapi_workflows_stage_required_to_publish_lnk_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.strapi_workflows_stage_required_to_publish_lnk_id_seq OWNED BY public.strapi_workflows_stage_required_to_publish_lnk.id;


--
-- Name: strapi_workflows_stages; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.strapi_workflows_stages (
    id integer NOT NULL,
    document_id character varying(255),
    name character varying(255),
    color character varying(255),
    created_at timestamp(6) without time zone,
    updated_at timestamp(6) without time zone,
    published_at timestamp(6) without time zone,
    created_by_id integer,
    updated_by_id integer,
    locale character varying(255)
);


--
-- Name: strapi_workflows_stages_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.strapi_workflows_stages_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: strapi_workflows_stages_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.strapi_workflows_stages_id_seq OWNED BY public.strapi_workflows_stages.id;


--
-- Name: strapi_workflows_stages_permissions_lnk; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.strapi_workflows_stages_permissions_lnk (
    id integer NOT NULL,
    workflow_stage_id integer,
    permission_id integer,
    permission_ord double precision
);


--
-- Name: strapi_workflows_stages_permissions_lnk_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.strapi_workflows_stages_permissions_lnk_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: strapi_workflows_stages_permissions_lnk_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.strapi_workflows_stages_permissions_lnk_id_seq OWNED BY public.strapi_workflows_stages_permissions_lnk.id;


--
-- Name: strapi_workflows_stages_workflow_lnk; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.strapi_workflows_stages_workflow_lnk (
    id integer NOT NULL,
    workflow_stage_id integer,
    workflow_id integer,
    workflow_stage_ord double precision
);


--
-- Name: strapi_workflows_stages_workflow_lnk_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.strapi_workflows_stages_workflow_lnk_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: strapi_workflows_stages_workflow_lnk_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.strapi_workflows_stages_workflow_lnk_id_seq OWNED BY public.strapi_workflows_stages_workflow_lnk.id;


--
-- Name: testimonials; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.testimonials (
    id integer NOT NULL,
    document_id character varying(255),
    name character varying(255),
    text text,
    sort_order integer,
    is_active boolean,
    created_at timestamp(6) without time zone,
    updated_at timestamp(6) without time zone,
    published_at timestamp(6) without time zone,
    created_by_id integer,
    updated_by_id integer,
    locale character varying(255)
);


--
-- Name: testimonials_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.testimonials_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: testimonials_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.testimonials_id_seq OWNED BY public.testimonials.id;


--
-- Name: up_permissions; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.up_permissions (
    id integer NOT NULL,
    document_id character varying(255),
    action character varying(255),
    created_at timestamp(6) without time zone,
    updated_at timestamp(6) without time zone,
    published_at timestamp(6) without time zone,
    created_by_id integer,
    updated_by_id integer,
    locale character varying(255)
);


--
-- Name: up_permissions_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.up_permissions_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: up_permissions_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.up_permissions_id_seq OWNED BY public.up_permissions.id;


--
-- Name: up_permissions_role_lnk; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.up_permissions_role_lnk (
    id integer NOT NULL,
    permission_id integer,
    role_id integer,
    permission_ord double precision
);


--
-- Name: up_permissions_role_lnk_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.up_permissions_role_lnk_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: up_permissions_role_lnk_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.up_permissions_role_lnk_id_seq OWNED BY public.up_permissions_role_lnk.id;


--
-- Name: up_roles; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.up_roles (
    id integer NOT NULL,
    document_id character varying(255),
    name character varying(255),
    description character varying(255),
    type character varying(255),
    created_at timestamp(6) without time zone,
    updated_at timestamp(6) without time zone,
    published_at timestamp(6) without time zone,
    created_by_id integer,
    updated_by_id integer,
    locale character varying(255)
);


--
-- Name: up_roles_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.up_roles_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: up_roles_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.up_roles_id_seq OWNED BY public.up_roles.id;


--
-- Name: up_users; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.up_users (
    id integer NOT NULL,
    document_id character varying(255),
    created_at timestamp(6) without time zone,
    updated_at timestamp(6) without time zone,
    published_at timestamp(6) without time zone,
    created_by_id integer,
    updated_by_id integer,
    locale character varying(255),
    phone character varying(255),
    app_role character varying(255)
);


--
-- Name: up_users_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.up_users_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: up_users_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.up_users_id_seq OWNED BY public.up_users.id;


--
-- Name: upload_folders; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.upload_folders (
    id integer NOT NULL,
    document_id character varying(255),
    name character varying(255),
    path_id integer,
    path character varying(255),
    created_at timestamp(6) without time zone,
    updated_at timestamp(6) without time zone,
    published_at timestamp(6) without time zone,
    created_by_id integer,
    updated_by_id integer,
    locale character varying(255)
);


--
-- Name: upload_folders_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.upload_folders_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: upload_folders_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.upload_folders_id_seq OWNED BY public.upload_folders.id;


--
-- Name: upload_folders_parent_lnk; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.upload_folders_parent_lnk (
    id integer NOT NULL,
    folder_id integer,
    inv_folder_id integer,
    folder_ord double precision
);


--
-- Name: upload_folders_parent_lnk_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.upload_folders_parent_lnk_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: upload_folders_parent_lnk_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.upload_folders_parent_lnk_id_seq OWNED BY public.upload_folders_parent_lnk.id;


--
-- Name: wishlist_items; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.wishlist_items (
    id integer NOT NULL,
    document_id character varying(255),
    created_at timestamp(6) without time zone,
    updated_at timestamp(6) without time zone,
    published_at timestamp(6) without time zone,
    created_by_id integer,
    updated_by_id integer,
    locale character varying(255)
);


--
-- Name: wishlist_items_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.wishlist_items_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: wishlist_items_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.wishlist_items_id_seq OWNED BY public.wishlist_items.id;


--
-- Name: wishlist_items_product_lnk; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.wishlist_items_product_lnk (
    id integer NOT NULL,
    wishlist_item_id integer,
    product_id integer,
    wishlist_item_ord double precision
);


--
-- Name: wishlist_items_product_lnk_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.wishlist_items_product_lnk_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: wishlist_items_product_lnk_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.wishlist_items_product_lnk_id_seq OWNED BY public.wishlist_items_product_lnk.id;


--
-- Name: wishlist_items_user_lnk; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.wishlist_items_user_lnk (
    id integer NOT NULL,
    wishlist_item_id integer,
    user_id integer,
    wishlist_item_ord double precision
);


--
-- Name: wishlist_items_user_lnk_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.wishlist_items_user_lnk_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: wishlist_items_user_lnk_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.wishlist_items_user_lnk_id_seq OWNED BY public.wishlist_items_user_lnk.id;


--
-- Name: admin_permissions id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.admin_permissions ALTER COLUMN id SET DEFAULT nextval('public.admin_permissions_id_seq'::regclass);


--
-- Name: admin_permissions_role_lnk id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.admin_permissions_role_lnk ALTER COLUMN id SET DEFAULT nextval('public.admin_permissions_role_lnk_id_seq'::regclass);


--
-- Name: admin_roles id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.admin_roles ALTER COLUMN id SET DEFAULT nextval('public.admin_roles_id_seq'::regclass);


--
-- Name: admin_users id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.admin_users ALTER COLUMN id SET DEFAULT nextval('public.admin_users_id_seq'::regclass);


--
-- Name: admin_users_roles_lnk id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.admin_users_roles_lnk ALTER COLUMN id SET DEFAULT nextval('public.admin_users_roles_lnk_id_seq'::regclass);


--
-- Name: availability_rules id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.availability_rules ALTER COLUMN id SET DEFAULT nextval('public.availability_rules_id_seq'::regclass);


--
-- Name: banners id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.banners ALTER COLUMN id SET DEFAULT nextval('public.banners_id_seq'::regclass);


--
-- Name: blocked_slots id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.blocked_slots ALTER COLUMN id SET DEFAULT nextval('public.blocked_slots_id_seq'::regclass);


--
-- Name: booking_setting id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.booking_setting ALTER COLUMN id SET DEFAULT nextval('public.booking_setting_id_seq'::regclass);


--
-- Name: bookings id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.bookings ALTER COLUMN id SET DEFAULT nextval('public.bookings_id_seq'::regclass);


--
-- Name: bookings_service_lnk id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.bookings_service_lnk ALTER COLUMN id SET DEFAULT nextval('public.bookings_service_lnk_id_seq'::regclass);


--
-- Name: bookings_user_lnk id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.bookings_user_lnk ALTER COLUMN id SET DEFAULT nextval('public.bookings_user_lnk_id_seq'::regclass);


--
-- Name: business_setting id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.business_setting ALTER COLUMN id SET DEFAULT nextval('public.business_setting_id_seq'::regclass);


--
-- Name: cart_items id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.cart_items ALTER COLUMN id SET DEFAULT nextval('public.cart_items_id_seq'::regclass);


--
-- Name: cart_items_product_lnk id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.cart_items_product_lnk ALTER COLUMN id SET DEFAULT nextval('public.cart_items_product_lnk_id_seq'::regclass);


--
-- Name: cart_items_user_lnk id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.cart_items_user_lnk ALTER COLUMN id SET DEFAULT nextval('public.cart_items_user_lnk_id_seq'::regclass);


--
-- Name: commerce_placeholders id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.commerce_placeholders ALTER COLUMN id SET DEFAULT nextval('public.commerce_placeholders_id_seq'::regclass);


--
-- Name: contact_messages id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.contact_messages ALTER COLUMN id SET DEFAULT nextval('public.contact_messages_id_seq'::regclass);


--
-- Name: coupon_codes id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.coupon_codes ALTER COLUMN id SET DEFAULT nextval('public.coupon_codes_id_seq'::regclass);


--
-- Name: coupon_usages id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.coupon_usages ALTER COLUMN id SET DEFAULT nextval('public.coupon_usages_id_seq'::regclass);


--
-- Name: coupon_usages_coupon_lnk id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.coupon_usages_coupon_lnk ALTER COLUMN id SET DEFAULT nextval('public.coupon_usages_coupon_lnk_id_seq'::regclass);


--
-- Name: coupon_usages_order_lnk id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.coupon_usages_order_lnk ALTER COLUMN id SET DEFAULT nextval('public.coupon_usages_order_lnk_id_seq'::regclass);


--
-- Name: coupon_usages_user_lnk id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.coupon_usages_user_lnk ALTER COLUMN id SET DEFAULT nextval('public.coupon_usages_user_lnk_id_seq'::regclass);


--
-- Name: digital_assets id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.digital_assets ALTER COLUMN id SET DEFAULT nextval('public.digital_assets_id_seq'::regclass);


--
-- Name: digital_assets_product_lnk id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.digital_assets_product_lnk ALTER COLUMN id SET DEFAULT nextval('public.digital_assets_product_lnk_id_seq'::regclass);


--
-- Name: digital_purchases id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.digital_purchases ALTER COLUMN id SET DEFAULT nextval('public.digital_purchases_id_seq'::regclass);


--
-- Name: digital_purchases_asset_lnk id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.digital_purchases_asset_lnk ALTER COLUMN id SET DEFAULT nextval('public.digital_purchases_asset_lnk_id_seq'::regclass);


--
-- Name: digital_purchases_order_lnk id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.digital_purchases_order_lnk ALTER COLUMN id SET DEFAULT nextval('public.digital_purchases_order_lnk_id_seq'::regclass);


--
-- Name: digital_purchases_product_lnk id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.digital_purchases_product_lnk ALTER COLUMN id SET DEFAULT nextval('public.digital_purchases_product_lnk_id_seq'::regclass);


--
-- Name: digital_purchases_user_lnk id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.digital_purchases_user_lnk ALTER COLUMN id SET DEFAULT nextval('public.digital_purchases_user_lnk_id_seq'::regclass);


--
-- Name: email_logs id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.email_logs ALTER COLUMN id SET DEFAULT nextval('public.email_logs_id_seq'::regclass);


--
-- Name: files id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.files ALTER COLUMN id SET DEFAULT nextval('public.files_id_seq'::regclass);


--
-- Name: files_folder_lnk id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.files_folder_lnk ALTER COLUMN id SET DEFAULT nextval('public.files_folder_lnk_id_seq'::regclass);


--
-- Name: files_related_mph id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.files_related_mph ALTER COLUMN id SET DEFAULT nextval('public.files_related_mph_id_seq'::regclass);


--
-- Name: i18n_locale id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.i18n_locale ALTER COLUMN id SET DEFAULT nextval('public.i18n_locale_id_seq'::regclass);


--
-- Name: invoices id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.invoices ALTER COLUMN id SET DEFAULT nextval('public.invoices_id_seq'::regclass);


--
-- Name: invoices_order_lnk id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.invoices_order_lnk ALTER COLUMN id SET DEFAULT nextval('public.invoices_order_lnk_id_seq'::regclass);


--
-- Name: legal_pages id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.legal_pages ALTER COLUMN id SET DEFAULT nextval('public.legal_pages_id_seq'::regclass);


--
-- Name: order_items id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.order_items ALTER COLUMN id SET DEFAULT nextval('public.order_items_id_seq'::regclass);


--
-- Name: order_items_order_lnk id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.order_items_order_lnk ALTER COLUMN id SET DEFAULT nextval('public.order_items_order_lnk_id_seq'::regclass);


--
-- Name: order_items_product_lnk id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.order_items_product_lnk ALTER COLUMN id SET DEFAULT nextval('public.order_items_product_lnk_id_seq'::regclass);


--
-- Name: order_shipments id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.order_shipments ALTER COLUMN id SET DEFAULT nextval('public.order_shipments_id_seq'::regclass);


--
-- Name: order_shipments_order_lnk id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.order_shipments_order_lnk ALTER COLUMN id SET DEFAULT nextval('public.order_shipments_order_lnk_id_seq'::regclass);


--
-- Name: orders id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.orders ALTER COLUMN id SET DEFAULT nextval('public.orders_id_seq'::regclass);


--
-- Name: orders_coupon_lnk id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.orders_coupon_lnk ALTER COLUMN id SET DEFAULT nextval('public.orders_coupon_lnk_id_seq'::regclass);


--
-- Name: orders_user_lnk id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.orders_user_lnk ALTER COLUMN id SET DEFAULT nextval('public.orders_user_lnk_id_seq'::regclass);


--
-- Name: password_reset_tokens id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.password_reset_tokens ALTER COLUMN id SET DEFAULT nextval('public.password_reset_tokens_id_seq'::regclass);


--
-- Name: password_reset_tokens_user_lnk id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.password_reset_tokens_user_lnk ALTER COLUMN id SET DEFAULT nextval('public.password_reset_tokens_user_lnk_id_seq'::regclass);


--
-- Name: popups id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.popups ALTER COLUMN id SET DEFAULT nextval('public.popups_id_seq'::regclass);


--
-- Name: product_categories id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.product_categories ALTER COLUMN id SET DEFAULT nextval('public.product_categories_id_seq'::regclass);


--
-- Name: product_variants id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.product_variants ALTER COLUMN id SET DEFAULT nextval('public.product_variants_id_seq'::regclass);


--
-- Name: product_variants_product_lnk id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.product_variants_product_lnk ALTER COLUMN id SET DEFAULT nextval('public.product_variants_product_lnk_id_seq'::regclass);


--
-- Name: products id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.products ALTER COLUMN id SET DEFAULT nextval('public.products_id_seq'::regclass);


--
-- Name: products_category_lnk id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.products_category_lnk ALTER COLUMN id SET DEFAULT nextval('public.products_category_lnk_id_seq'::regclass);


--
-- Name: products_shipping_class_lnk id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.products_shipping_class_lnk ALTER COLUMN id SET DEFAULT nextval('public.products_shipping_class_lnk_id_seq'::regclass);


--
-- Name: promo_rules id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.promo_rules ALTER COLUMN id SET DEFAULT nextval('public.promo_rules_id_seq'::regclass);


--
-- Name: reviews id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.reviews ALTER COLUMN id SET DEFAULT nextval('public.reviews_id_seq'::regclass);


--
-- Name: reviews_product_lnk id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.reviews_product_lnk ALTER COLUMN id SET DEFAULT nextval('public.reviews_product_lnk_id_seq'::regclass);


--
-- Name: reviews_user_lnk id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.reviews_user_lnk ALTER COLUMN id SET DEFAULT nextval('public.reviews_user_lnk_id_seq'::regclass);


--
-- Name: scheduled_reminders id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.scheduled_reminders ALTER COLUMN id SET DEFAULT nextval('public.scheduled_reminders_id_seq'::regclass);


--
-- Name: scheduled_reminders_booking_lnk id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.scheduled_reminders_booking_lnk ALTER COLUMN id SET DEFAULT nextval('public.scheduled_reminders_booking_lnk_id_seq'::regclass);


--
-- Name: services id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.services ALTER COLUMN id SET DEFAULT nextval('public.services_id_seq'::regclass);


--
-- Name: shipping_classes id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.shipping_classes ALTER COLUMN id SET DEFAULT nextval('public.shipping_classes_id_seq'::regclass);


--
-- Name: strapi_ai_localization_jobs id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.strapi_ai_localization_jobs ALTER COLUMN id SET DEFAULT nextval('public.strapi_ai_localization_jobs_id_seq'::regclass);


--
-- Name: strapi_ai_metadata_jobs id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.strapi_ai_metadata_jobs ALTER COLUMN id SET DEFAULT nextval('public.strapi_ai_metadata_jobs_id_seq'::regclass);


--
-- Name: strapi_api_token_permissions id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.strapi_api_token_permissions ALTER COLUMN id SET DEFAULT nextval('public.strapi_api_token_permissions_id_seq'::regclass);


--
-- Name: strapi_api_token_permissions_token_lnk id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.strapi_api_token_permissions_token_lnk ALTER COLUMN id SET DEFAULT nextval('public.strapi_api_token_permissions_token_lnk_id_seq'::regclass);


--
-- Name: strapi_api_tokens id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.strapi_api_tokens ALTER COLUMN id SET DEFAULT nextval('public.strapi_api_tokens_id_seq'::regclass);


--
-- Name: strapi_core_store_settings id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.strapi_core_store_settings ALTER COLUMN id SET DEFAULT nextval('public.strapi_core_store_settings_id_seq'::regclass);


--
-- Name: strapi_database_schema id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.strapi_database_schema ALTER COLUMN id SET DEFAULT nextval('public.strapi_database_schema_id_seq'::regclass);


--
-- Name: strapi_history_versions id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.strapi_history_versions ALTER COLUMN id SET DEFAULT nextval('public.strapi_history_versions_id_seq'::regclass);


--
-- Name: strapi_migrations id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.strapi_migrations ALTER COLUMN id SET DEFAULT nextval('public.strapi_migrations_id_seq'::regclass);


--
-- Name: strapi_migrations_internal id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.strapi_migrations_internal ALTER COLUMN id SET DEFAULT nextval('public.strapi_migrations_internal_id_seq'::regclass);


--
-- Name: strapi_release_actions id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.strapi_release_actions ALTER COLUMN id SET DEFAULT nextval('public.strapi_release_actions_id_seq'::regclass);


--
-- Name: strapi_release_actions_release_lnk id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.strapi_release_actions_release_lnk ALTER COLUMN id SET DEFAULT nextval('public.strapi_release_actions_release_lnk_id_seq'::regclass);


--
-- Name: strapi_releases id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.strapi_releases ALTER COLUMN id SET DEFAULT nextval('public.strapi_releases_id_seq'::regclass);


--
-- Name: strapi_sessions id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.strapi_sessions ALTER COLUMN id SET DEFAULT nextval('public.strapi_sessions_id_seq'::regclass);


--
-- Name: strapi_transfer_token_permissions id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.strapi_transfer_token_permissions ALTER COLUMN id SET DEFAULT nextval('public.strapi_transfer_token_permissions_id_seq'::regclass);


--
-- Name: strapi_transfer_token_permissions_token_lnk id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.strapi_transfer_token_permissions_token_lnk ALTER COLUMN id SET DEFAULT nextval('public.strapi_transfer_token_permissions_token_lnk_id_seq'::regclass);


--
-- Name: strapi_transfer_tokens id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.strapi_transfer_tokens ALTER COLUMN id SET DEFAULT nextval('public.strapi_transfer_tokens_id_seq'::regclass);


--
-- Name: strapi_webhooks id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.strapi_webhooks ALTER COLUMN id SET DEFAULT nextval('public.strapi_webhooks_id_seq'::regclass);


--
-- Name: strapi_workflows id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.strapi_workflows ALTER COLUMN id SET DEFAULT nextval('public.strapi_workflows_id_seq'::regclass);


--
-- Name: strapi_workflows_stage_required_to_publish_lnk id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.strapi_workflows_stage_required_to_publish_lnk ALTER COLUMN id SET DEFAULT nextval('public.strapi_workflows_stage_required_to_publish_lnk_id_seq'::regclass);


--
-- Name: strapi_workflows_stages id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.strapi_workflows_stages ALTER COLUMN id SET DEFAULT nextval('public.strapi_workflows_stages_id_seq'::regclass);


--
-- Name: strapi_workflows_stages_permissions_lnk id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.strapi_workflows_stages_permissions_lnk ALTER COLUMN id SET DEFAULT nextval('public.strapi_workflows_stages_permissions_lnk_id_seq'::regclass);


--
-- Name: strapi_workflows_stages_workflow_lnk id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.strapi_workflows_stages_workflow_lnk ALTER COLUMN id SET DEFAULT nextval('public.strapi_workflows_stages_workflow_lnk_id_seq'::regclass);


--
-- Name: testimonials id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.testimonials ALTER COLUMN id SET DEFAULT nextval('public.testimonials_id_seq'::regclass);


--
-- Name: up_permissions id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.up_permissions ALTER COLUMN id SET DEFAULT nextval('public.up_permissions_id_seq'::regclass);


--
-- Name: up_permissions_role_lnk id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.up_permissions_role_lnk ALTER COLUMN id SET DEFAULT nextval('public.up_permissions_role_lnk_id_seq'::regclass);


--
-- Name: up_roles id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.up_roles ALTER COLUMN id SET DEFAULT nextval('public.up_roles_id_seq'::regclass);


--
-- Name: up_users id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.up_users ALTER COLUMN id SET DEFAULT nextval('public.up_users_id_seq'::regclass);


--
-- Name: upload_folders id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.upload_folders ALTER COLUMN id SET DEFAULT nextval('public.upload_folders_id_seq'::regclass);


--
-- Name: upload_folders_parent_lnk id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.upload_folders_parent_lnk ALTER COLUMN id SET DEFAULT nextval('public.upload_folders_parent_lnk_id_seq'::regclass);


--
-- Name: wishlist_items id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.wishlist_items ALTER COLUMN id SET DEFAULT nextval('public.wishlist_items_id_seq'::regclass);


--
-- Name: wishlist_items_product_lnk id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.wishlist_items_product_lnk ALTER COLUMN id SET DEFAULT nextval('public.wishlist_items_product_lnk_id_seq'::regclass);


--
-- Name: wishlist_items_user_lnk id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.wishlist_items_user_lnk ALTER COLUMN id SET DEFAULT nextval('public.wishlist_items_user_lnk_id_seq'::regclass);


--
-- Data for Name: admin_permissions; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.admin_permissions (id, document_id, action, action_parameters, subject, properties, conditions, created_at, updated_at, published_at, created_by_id, updated_by_id, locale) FROM stdin;
1	pro8v233h7zlvpwm4h1z4s53	plugin::upload.read	{}	\N	{}	[]	2026-03-27 06:07:52.429	2026-03-27 06:07:52.429	2026-03-27 06:07:52.429	\N	\N	\N
2	x05hhgm91lm3egij303r1xqo	plugin::upload.configure-view	{}	\N	{}	[]	2026-03-27 06:07:52.44	2026-03-27 06:07:52.44	2026-03-27 06:07:52.44	\N	\N	\N
3	wmk1rbntm5v58ejc1o6xmlkn	plugin::upload.assets.create	{}	\N	{}	[]	2026-03-27 06:07:52.447	2026-03-27 06:07:52.447	2026-03-27 06:07:52.447	\N	\N	\N
4	vgrl6ilwtvkw5nlho6yur70b	plugin::upload.assets.update	{}	\N	{}	[]	2026-03-27 06:07:52.455	2026-03-27 06:07:52.455	2026-03-27 06:07:52.456	\N	\N	\N
5	t4l5q62mjp25444upl3kbkyh	plugin::upload.assets.download	{}	\N	{}	[]	2026-03-27 06:07:52.463	2026-03-27 06:07:52.463	2026-03-27 06:07:52.463	\N	\N	\N
6	fq0kmlpnj17nkyu5txrfka9a	plugin::upload.assets.copy-link	{}	\N	{}	[]	2026-03-27 06:07:52.471	2026-03-27 06:07:52.471	2026-03-27 06:07:52.471	\N	\N	\N
7	su1xvuw4wssktfwn09dexoiu	plugin::upload.read	{}	\N	{}	["admin::is-creator"]	2026-03-27 06:07:52.481	2026-03-27 06:07:52.481	2026-03-27 06:07:52.481	\N	\N	\N
8	cidy726pdjf64q8we9mhz5rg	plugin::upload.configure-view	{}	\N	{}	[]	2026-03-27 06:07:52.49	2026-03-27 06:07:52.49	2026-03-27 06:07:52.491	\N	\N	\N
9	oc241zmoejrl13m8equ7geuv	plugin::upload.assets.create	{}	\N	{}	[]	2026-03-27 06:07:52.499	2026-03-27 06:07:52.499	2026-03-27 06:07:52.499	\N	\N	\N
10	xb4d5guqkautayji3wg0ie7j	plugin::upload.assets.update	{}	\N	{}	["admin::is-creator"]	2026-03-27 06:07:52.505	2026-03-27 06:07:52.505	2026-03-27 06:07:52.505	\N	\N	\N
11	o8qrt7qmyprlewam0kt107yz	plugin::upload.assets.download	{}	\N	{}	[]	2026-03-27 06:07:52.512	2026-03-27 06:07:52.512	2026-03-27 06:07:52.512	\N	\N	\N
12	ujgolvjby2rijck6mekviysb	plugin::upload.assets.copy-link	{}	\N	{}	[]	2026-03-27 06:07:52.519	2026-03-27 06:07:52.519	2026-03-27 06:07:52.519	\N	\N	\N
16	thpvxgbfdgsx13176u9xyysb	plugin::content-manager.explorer.delete	{}	plugin::users-permissions.user	{}	[]	2026-03-27 06:07:52.592	2026-03-27 06:07:52.592	2026-03-27 06:07:52.592	\N	\N	\N
17	lr26y7ti0s75961iawa62qm8	plugin::content-manager.explorer.publish	{}	plugin::users-permissions.user	{}	[]	2026-03-27 06:07:52.599	2026-03-27 06:07:52.599	2026-03-27 06:07:52.599	\N	\N	\N
18	y8b8u46d2nmao9v6p4udydpq	plugin::content-manager.single-types.configure-view	{}	\N	{}	[]	2026-03-27 06:07:52.606	2026-03-27 06:07:52.606	2026-03-27 06:07:52.606	\N	\N	\N
19	mzqw6503ejfydqbsl621pnaa	plugin::content-manager.collection-types.configure-view	{}	\N	{}	[]	2026-03-27 06:07:52.613	2026-03-27 06:07:52.613	2026-03-27 06:07:52.613	\N	\N	\N
20	hpj6i917c4gq5uc7h8bqwcu7	plugin::content-manager.components.configure-layout	{}	\N	{}	[]	2026-03-27 06:07:52.619	2026-03-27 06:07:52.619	2026-03-27 06:07:52.62	\N	\N	\N
21	n5z0uu9u90tlfpoix9pfmiia	plugin::content-type-builder.read	{}	\N	{}	[]	2026-03-27 06:07:52.627	2026-03-27 06:07:52.627	2026-03-27 06:07:52.627	\N	\N	\N
22	f6fo72zul0z98w6ogf65acgj	plugin::email.settings.read	{}	\N	{}	[]	2026-03-27 06:07:52.653	2026-03-27 06:07:52.653	2026-03-27 06:07:52.653	\N	\N	\N
23	oltdvmfurz0v54mbnmbpbbhj	plugin::upload.read	{}	\N	{}	[]	2026-03-27 06:07:52.666	2026-03-27 06:07:52.666	2026-03-27 06:07:52.666	\N	\N	\N
24	d756yl5bia74aa97endspyu8	plugin::upload.assets.create	{}	\N	{}	[]	2026-03-27 06:07:52.675	2026-03-27 06:07:52.675	2026-03-27 06:07:52.675	\N	\N	\N
25	w9ht00l7mo0ttb1957elzv7e	plugin::upload.assets.update	{}	\N	{}	[]	2026-03-27 06:07:52.684	2026-03-27 06:07:52.684	2026-03-27 06:07:52.685	\N	\N	\N
26	eq8hjd0tx5g2tn9ttmyeq2nc	plugin::upload.assets.download	{}	\N	{}	[]	2026-03-27 06:07:52.694	2026-03-27 06:07:52.694	2026-03-27 06:07:52.695	\N	\N	\N
27	qoxbov0fx8gy6icyixtg7hey	plugin::upload.assets.copy-link	{}	\N	{}	[]	2026-03-27 06:07:52.702	2026-03-27 06:07:52.702	2026-03-27 06:07:52.703	\N	\N	\N
28	gdj0g5suj7fnhda7909zvfcd	plugin::upload.configure-view	{}	\N	{}	[]	2026-03-27 06:07:52.71	2026-03-27 06:07:52.71	2026-03-27 06:07:52.71	\N	\N	\N
29	plt0jxq8trharci33geddc3c	plugin::upload.settings.read	{}	\N	{}	[]	2026-03-27 06:07:52.72	2026-03-27 06:07:52.72	2026-03-27 06:07:52.72	\N	\N	\N
30	xm0t1ek2r54we44mtvogcu43	plugin::i18n.locale.create	{}	\N	{}	[]	2026-03-27 06:07:52.727	2026-03-27 06:07:52.727	2026-03-27 06:07:52.727	\N	\N	\N
31	wh22fc4bbkgiwcmpr0wbvvtq	plugin::i18n.locale.read	{}	\N	{}	[]	2026-03-27 06:07:52.735	2026-03-27 06:07:52.735	2026-03-27 06:07:52.735	\N	\N	\N
32	g0xyvy0lucyc8z6iphjzkdhc	plugin::i18n.locale.update	{}	\N	{}	[]	2026-03-27 06:07:52.742	2026-03-27 06:07:52.742	2026-03-27 06:07:52.742	\N	\N	\N
33	p08urgpjdzyw23gamygbhn63	plugin::i18n.locale.delete	{}	\N	{}	[]	2026-03-27 06:07:52.749	2026-03-27 06:07:52.749	2026-03-27 06:07:52.749	\N	\N	\N
34	lemkw2wsubvilrbb25a2dcnn	plugin::users-permissions.roles.create	{}	\N	{}	[]	2026-03-27 06:07:52.755	2026-03-27 06:07:52.755	2026-03-27 06:07:52.755	\N	\N	\N
35	nw8bskqjqhb1vrpr3k8a579g	plugin::users-permissions.roles.read	{}	\N	{}	[]	2026-03-27 06:07:52.761	2026-03-27 06:07:52.761	2026-03-27 06:07:52.762	\N	\N	\N
36	bmnci405nc9aufrji400i5vx	plugin::users-permissions.roles.update	{}	\N	{}	[]	2026-03-27 06:07:52.769	2026-03-27 06:07:52.769	2026-03-27 06:07:52.769	\N	\N	\N
37	te2slceh99mld77ccge3cd2m	plugin::users-permissions.roles.delete	{}	\N	{}	[]	2026-03-27 06:07:52.776	2026-03-27 06:07:52.776	2026-03-27 06:07:52.776	\N	\N	\N
38	y5x9pv6504wi3t2xdl6v82ug	plugin::users-permissions.providers.read	{}	\N	{}	[]	2026-03-27 06:07:52.783	2026-03-27 06:07:52.783	2026-03-27 06:07:52.783	\N	\N	\N
39	wozywnxt1q86bnjsy85u2x9m	plugin::users-permissions.providers.update	{}	\N	{}	[]	2026-03-27 06:07:52.789	2026-03-27 06:07:52.789	2026-03-27 06:07:52.79	\N	\N	\N
40	icrv7clblriy0ulz1jxobya4	plugin::users-permissions.email-templates.read	{}	\N	{}	[]	2026-03-27 06:07:52.798	2026-03-27 06:07:52.798	2026-03-27 06:07:52.798	\N	\N	\N
41	gsvixbzp0nb5vg41z946ug6y	plugin::users-permissions.email-templates.update	{}	\N	{}	[]	2026-03-27 06:07:52.805	2026-03-27 06:07:52.805	2026-03-27 06:07:52.805	\N	\N	\N
42	ckw6r8bxj5a6moa01ewyssmg	plugin::users-permissions.advanced-settings.read	{}	\N	{}	[]	2026-03-27 06:07:52.812	2026-03-27 06:07:52.812	2026-03-27 06:07:52.812	\N	\N	\N
43	tshmiqdktcft9ja6qr6b8dg2	plugin::users-permissions.advanced-settings.update	{}	\N	{}	[]	2026-03-27 06:07:52.828	2026-03-27 06:07:52.828	2026-03-27 06:07:52.828	\N	\N	\N
44	ns1wrumj1saqyzmo4ar7kexo	admin::marketplace.read	{}	\N	{}	[]	2026-03-27 06:07:52.836	2026-03-27 06:07:52.836	2026-03-27 06:07:52.836	\N	\N	\N
45	dgmokmzjf85soq0vokth3hg6	admin::webhooks.create	{}	\N	{}	[]	2026-03-27 06:07:52.844	2026-03-27 06:07:52.844	2026-03-27 06:07:52.844	\N	\N	\N
46	avt13ts1ryx33l1kwrv5fy6m	admin::webhooks.read	{}	\N	{}	[]	2026-03-27 06:07:52.852	2026-03-27 06:07:52.852	2026-03-27 06:07:52.852	\N	\N	\N
47	xbacm75vu0nr7mojm8yknqwz	admin::webhooks.update	{}	\N	{}	[]	2026-03-27 06:07:52.859	2026-03-27 06:07:52.859	2026-03-27 06:07:52.859	\N	\N	\N
48	kf8gt6tg2ty8ehiht6vo60a9	admin::webhooks.delete	{}	\N	{}	[]	2026-03-27 06:07:52.866	2026-03-27 06:07:52.866	2026-03-27 06:07:52.867	\N	\N	\N
49	u74k4edad7c4wi39ov32rd75	admin::users.create	{}	\N	{}	[]	2026-03-27 06:07:52.874	2026-03-27 06:07:52.874	2026-03-27 06:07:52.874	\N	\N	\N
50	y9okka8fcq3zv9yw3rbji0u2	admin::users.read	{}	\N	{}	[]	2026-03-27 06:07:52.881	2026-03-27 06:07:52.881	2026-03-27 06:07:52.881	\N	\N	\N
51	aank9qpqhbi1zpbi2kvdux2e	admin::users.update	{}	\N	{}	[]	2026-03-27 06:07:52.888	2026-03-27 06:07:52.888	2026-03-27 06:07:52.888	\N	\N	\N
52	qwngdgx6kum98310covv3ooa	admin::users.delete	{}	\N	{}	[]	2026-03-27 06:07:52.894	2026-03-27 06:07:52.894	2026-03-27 06:07:52.894	\N	\N	\N
53	wu86xea43cu89pcaduhb31of	admin::roles.create	{}	\N	{}	[]	2026-03-27 06:07:52.902	2026-03-27 06:07:52.902	2026-03-27 06:07:52.902	\N	\N	\N
54	rlrbu1f9r6e39nuf2aheplzn	admin::roles.read	{}	\N	{}	[]	2026-03-27 06:07:52.915	2026-03-27 06:07:52.915	2026-03-27 06:07:52.915	\N	\N	\N
55	aubkwqimcj7q3ceny2799115	admin::roles.update	{}	\N	{}	[]	2026-03-27 06:07:52.929	2026-03-27 06:07:52.929	2026-03-27 06:07:52.93	\N	\N	\N
56	jksj4qwhy0dfyyg5jclnqnee	admin::roles.delete	{}	\N	{}	[]	2026-03-27 06:07:52.943	2026-03-27 06:07:52.943	2026-03-27 06:07:52.943	\N	\N	\N
57	jhxgip2s0qhcryxa8r9b93un	admin::api-tokens.access	{}	\N	{}	[]	2026-03-27 06:07:52.956	2026-03-27 06:07:52.956	2026-03-27 06:07:52.956	\N	\N	\N
58	iv3xf3ysfut5r7ghmlqkh29g	admin::api-tokens.create	{}	\N	{}	[]	2026-03-27 06:07:52.966	2026-03-27 06:07:52.966	2026-03-27 06:07:52.966	\N	\N	\N
59	w6fo64637jhbsc1z95c5z2q2	admin::api-tokens.read	{}	\N	{}	[]	2026-03-27 06:07:52.973	2026-03-27 06:07:52.973	2026-03-27 06:07:52.973	\N	\N	\N
60	c7ldhall0ze111v4ol3qljv4	admin::api-tokens.update	{}	\N	{}	[]	2026-03-27 06:07:52.98	2026-03-27 06:07:52.98	2026-03-27 06:07:52.98	\N	\N	\N
61	hy5m2uos39supy228xa07ruz	admin::api-tokens.regenerate	{}	\N	{}	[]	2026-03-27 06:07:52.988	2026-03-27 06:07:52.988	2026-03-27 06:07:52.988	\N	\N	\N
62	snm56mq4th6nhk8wo2b0drg1	admin::api-tokens.delete	{}	\N	{}	[]	2026-03-27 06:07:52.995	2026-03-27 06:07:52.995	2026-03-27 06:07:52.995	\N	\N	\N
63	hbnojt8s7bpr47kgjcv8jbbj	admin::project-settings.update	{}	\N	{}	[]	2026-03-27 06:07:53.004	2026-03-27 06:07:53.004	2026-03-27 06:07:53.004	\N	\N	\N
64	i0amphrajk3poddx03ox1lcf	admin::project-settings.read	{}	\N	{}	[]	2026-03-27 06:07:53.014	2026-03-27 06:07:53.014	2026-03-27 06:07:53.014	\N	\N	\N
65	qce3mhtuo8pfi1o9gnoswk0g	admin::transfer.tokens.access	{}	\N	{}	[]	2026-03-27 06:07:53.022	2026-03-27 06:07:53.022	2026-03-27 06:07:53.022	\N	\N	\N
66	ygp7f8pepltejqmah9jhwzf4	admin::transfer.tokens.create	{}	\N	{}	[]	2026-03-27 06:07:53.029	2026-03-27 06:07:53.029	2026-03-27 06:07:53.029	\N	\N	\N
67	l3szygndpwq7trkunslqzlua	admin::transfer.tokens.read	{}	\N	{}	[]	2026-03-27 06:07:53.038	2026-03-27 06:07:53.038	2026-03-27 06:07:53.038	\N	\N	\N
68	dt730pz5mmhwi9ifvcmske1u	admin::transfer.tokens.update	{}	\N	{}	[]	2026-03-27 06:07:53.046	2026-03-27 06:07:53.046	2026-03-27 06:07:53.046	\N	\N	\N
69	t6cpo0kq7qzgpxatz7czafeu	admin::transfer.tokens.regenerate	{}	\N	{}	[]	2026-03-27 06:07:53.054	2026-03-27 06:07:53.054	2026-03-27 06:07:53.054	\N	\N	\N
70	yl4682iazpwn86ph8qlr9leu	admin::transfer.tokens.delete	{}	\N	{}	[]	2026-03-27 06:07:53.062	2026-03-27 06:07:53.062	2026-03-27 06:07:53.062	\N	\N	\N
71	u1blvnwayc5z4g5zlhdgxoyi	plugin::content-manager.explorer.create	{}	plugin::users-permissions.user	{"fields": ["phone", "appRole", "orders", "bookings", "cartItems", "wishlistItems", "reviews", "couponUsages", "digitalPurchases", "passwordResetTokens"]}	[]	2026-03-30 16:27:30.321	2026-03-30 16:27:30.321	2026-03-30 16:27:30.323	\N	\N	\N
72	ne8ql7qzmf31t2tgpvse7wli	plugin::content-manager.explorer.create	{}	api::availability-rule.availability-rule	{"fields": ["dayOfWeek", "startTime", "endTime", "isActive"]}	[]	2026-03-30 16:27:30.34	2026-03-30 16:27:30.34	2026-03-30 16:27:30.341	\N	\N	\N
73	wg4xqd6oq6ubz3cs9u5w6dw7	plugin::content-manager.explorer.create	{}	api::banner.banner	{"fields": ["title", "imageUrl", "linkUrl", "position", "startDate", "endDate", "isActive", "sortOrder"]}	[]	2026-03-30 16:27:30.347	2026-03-30 16:27:30.347	2026-03-30 16:27:30.347	\N	\N	\N
74	kknd1u1vqwvsplq0q103m1u9	plugin::content-manager.explorer.create	{}	api::blocked-slot.blocked-slot	{"fields": ["date", "startTime", "endTime", "reason"]}	[]	2026-03-30 16:27:30.354	2026-03-30 16:27:30.354	2026-03-30 16:27:30.355	\N	\N	\N
75	yt7n8pe01fmfhvmzwqyh8177	plugin::content-manager.explorer.create	{}	api::booking.booking	{"fields": ["guestName", "guestEmail", "guestPhone", "scheduledAt", "endAt", "status", "paymentStatus", "rzpOrderId", "rzpPaymentId", "rzpSignature", "amountPaid", "gcalEventId", "customerNotes", "adminNotes", "cancelledAt", "cancelReason", "rescheduledFrom", "legacyId", "user", "service", "reminders"]}	[]	2026-03-30 16:27:30.361	2026-03-30 16:27:30.361	2026-03-30 16:27:30.361	\N	\N	\N
76	s5ezj1xu1sgp4lima2jz3n83	plugin::content-manager.explorer.create	{}	api::booking-setting.booking-setting	{"fields": ["slotDurationMinutes", "bufferBetweenSlots", "maxAdvanceBookingDays", "minAdvanceBookingHours", "cancellationPolicyHours", "gcalCalendarId", "gcalSyncEnabled", "gcalRefreshToken", "autoConfirm"]}	[]	2026-03-30 16:27:30.368	2026-03-30 16:27:30.368	2026-03-30 16:27:30.368	\N	\N	\N
77	q09t11fzmzy8b6sctnnk4l1y	plugin::content-manager.explorer.create	{}	api::business-setting.business-setting	{"fields": ["businessName", "gstin", "pan", "address", "state", "stateCode", "phone", "email", "logoUrl", "bankName", "bankAccount", "bankIfsc", "invoicePrefix", "nextInvoiceNumber", "fbPixelId", "fbPixelEnabled"]}	[]	2026-03-30 16:27:30.374	2026-03-30 16:27:30.374	2026-03-30 16:27:30.374	\N	\N	\N
78	n2d9xjs7cesrwk1lhzkmtrhj	plugin::content-manager.explorer.create	{}	api::cart-item.cart-item	{"fields": ["sessionId", "quantity", "variantSelection", "user", "product"]}	[]	2026-03-30 16:27:30.381	2026-03-30 16:27:30.381	2026-03-30 16:27:30.381	\N	\N	\N
79	qeeetuy5dnov3vjx0xzio0by	plugin::content-manager.explorer.create	{}	api::commerce-placeholder.commerce-placeholder	{"fields": ["name"]}	[]	2026-03-30 16:27:30.388	2026-03-30 16:27:30.388	2026-03-30 16:27:30.388	\N	\N	\N
80	nz7pj76wr8x9wtxbljblvtqz	plugin::content-manager.explorer.create	{}	api::contact-message.contact-message	{"fields": ["name", "email", "phone", "company", "message", "isRead"]}	[]	2026-03-30 16:27:30.395	2026-03-30 16:27:30.395	2026-03-30 16:27:30.395	\N	\N	\N
81	miayu7c8y4ec06l265eokoxi	plugin::content-manager.explorer.create	{}	api::coupon-code.coupon-code	{"fields": ["code", "description", "discountType", "discountValue", "minCartTotal", "maxDiscount", "maxUses", "usedCount", "perUserLimit", "validFrom", "validUntil", "isActive", "applicableCategoryIds", "applicableProductIds", "usages", "orders"]}	[]	2026-03-30 16:27:30.403	2026-03-30 16:27:30.403	2026-03-30 16:27:30.403	\N	\N	\N
82	mg1397xtzaronj97z97r9gyx	plugin::content-manager.explorer.create	{}	api::coupon-usage.coupon-usage	{"fields": ["guestEmail", "discountAmount", "usedAt", "coupon", "user", "order"]}	[]	2026-03-30 16:27:30.411	2026-03-30 16:27:30.411	2026-03-30 16:27:30.411	\N	\N	\N
83	zl86icu677ead0yrfce3sjno	plugin::content-manager.explorer.create	{}	api::digital-asset.digital-asset	{"fields": ["assetType", "url", "fileName", "fileSize", "accessInstructions", "product", "purchases"]}	[]	2026-03-30 16:27:30.419	2026-03-30 16:27:30.419	2026-03-30 16:27:30.419	\N	\N	\N
84	b63njdhqb72or2ta103dvhek	plugin::content-manager.explorer.create	{}	api::digital-purchase.digital-purchase	{"fields": ["guestEmail", "accessGrantedAt", "accessUrl", "expiresAt", "user", "order", "product", "asset"]}	[]	2026-03-30 16:27:30.425	2026-03-30 16:27:30.425	2026-03-30 16:27:30.425	\N	\N	\N
85	w82wdwa6kv9flmj89xi0qqpa	plugin::content-manager.explorer.create	{}	api::email-log.email-log	{"fields": ["to", "subject", "templateName", "status", "relatedType", "relatedId", "error", "sentAt"]}	[]	2026-03-30 16:27:30.432	2026-03-30 16:27:30.432	2026-03-30 16:27:30.433	\N	\N	\N
86	e7f016y4txglvvjfa2xyjnyj	plugin::content-manager.explorer.create	{}	api::invoice.invoice	{"fields": ["invoiceNumber", "invoiceDate", "buyerName", "buyerAddress", "buyerGstin", "buyerState", "buyerStateCode", "items", "subtotal", "cgst", "sgst", "igst", "totalTax", "grandTotal", "placeOfSupply", "isInterState", "pdfUrl", "order"]}	[]	2026-03-30 16:27:30.439	2026-03-30 16:27:30.439	2026-03-30 16:27:30.44	\N	\N	\N
87	zujx007tl8f1nsh9ffx1t9yr	plugin::content-manager.explorer.create	{}	api::legal-page.legal-page	{"fields": ["slug", "title", "content"]}	[]	2026-03-30 16:27:30.449	2026-03-30 16:27:30.449	2026-03-30 16:27:30.449	\N	\N	\N
114	dwjlbsxuc89oi283koecz80d	plugin::content-manager.explorer.read	{}	api::coupon-usage.coupon-usage	{"fields": ["guestEmail", "discountAmount", "usedAt", "coupon", "user", "order"]}	[]	2026-03-30 16:27:30.684	2026-03-30 16:27:30.684	2026-03-30 16:27:30.684	\N	\N	\N
170	syofbq3y80mob8c5satzi0jq	plugin::content-manager.explorer.delete	{}	api::booking.booking	{}	[]	2026-03-30 16:27:31.08	2026-03-30 16:27:31.08	2026-03-30 16:27:31.08	\N	\N	\N
88	jsinxvbmesxwh7sgu5aiqxc9	plugin::content-manager.explorer.create	{}	api::order.order	{"fields": ["guestName", "guestEmail", "guestPhone", "status", "subtotal", "discount", "tax", "shippingAmount", "total", "rzpOrderId", "rzpPaymentId", "rzpSignature", "paymentStatus", "paymentMethod", "refundId", "refundStatus", "refundAmount", "shippingAddress", "billingAddress", "notes", "legacyId", "user", "coupon", "items", "invoice", "shipment", "digitalPurchases", "couponUsages"]}	[]	2026-03-30 16:27:30.456	2026-03-30 16:27:30.456	2026-03-30 16:27:30.456	\N	\N	\N
89	t9gsboqg3s6h228u16jzn5in	plugin::content-manager.explorer.create	{}	api::order-item.order-item	{"fields": ["variantSelection", "quantity", "unitPrice", "gstRateBps", "hsnCode", "order", "product"]}	[]	2026-03-30 16:27:30.463	2026-03-30 16:27:30.463	2026-03-30 16:27:30.463	\N	\N	\N
90	u2km3vxwpzip94sioqs389g2	plugin::content-manager.explorer.create	{}	api::order-shipment.order-shipment	{"fields": ["courierName", "trackingNumber", "trackingUrl", "shippedAt", "deliveredAt", "notes", "order"]}	[]	2026-03-30 16:27:30.47	2026-03-30 16:27:30.47	2026-03-30 16:27:30.47	\N	\N	\N
91	vtf7f7eic3502jwefdben4vl	plugin::content-manager.explorer.create	{}	api::password-reset-token.password-reset-token	{"fields": ["token", "expiresAt", "user"]}	[]	2026-03-30 16:27:30.478	2026-03-30 16:27:30.478	2026-03-30 16:27:30.478	\N	\N	\N
92	d86kylopc4gteml1k806li4g	plugin::content-manager.explorer.create	{}	api::popup.popup	{"fields": ["title", "content", "imageUrl", "linkUrl", "triggerType", "triggerValue", "showOnPages", "frequency", "startDate", "endDate", "isActive"]}	[]	2026-03-30 16:27:30.487	2026-03-30 16:27:30.487	2026-03-30 16:27:30.487	\N	\N	\N
93	cqf9u5k0k86zfrgqd2abvkus	plugin::content-manager.explorer.create	{}	api::product.product	{"fields": ["name", "slug", "description", "productType", "price", "salePrice", "stock", "images", "healingProperties", "wearHand", "hsnCode", "gstRateBps", "isActive", "category", "shippingClass", "variants", "digitalAssets", "cartItems", "wishlistItems", "orderItems", "reviews", "digitalPurchases"]}	[]	2026-03-30 16:27:30.494	2026-03-30 16:27:30.494	2026-03-30 16:27:30.494	\N	\N	\N
94	nlikcz9outh6alpornedetd5	plugin::content-manager.explorer.create	{}	api::product-category.product-category	{"fields": ["name", "slug", "sortOrder", "products"]}	[]	2026-03-30 16:27:30.503	2026-03-30 16:27:30.503	2026-03-30 16:27:30.503	\N	\N	\N
95	twm3bgaek44lr4x3p1y5nuhr	plugin::content-manager.explorer.create	{}	api::product-variant.product-variant	{"fields": ["name", "options", "product"]}	[]	2026-03-30 16:27:30.509	2026-03-30 16:27:30.509	2026-03-30 16:27:30.509	\N	\N	\N
96	kdb89ydlzbyibo4jqgh2o6kq	plugin::content-manager.explorer.create	{}	api::promo-rule.promo-rule	{"fields": ["type", "config", "isActive"]}	[]	2026-03-30 16:27:30.517	2026-03-30 16:27:30.517	2026-03-30 16:27:30.517	\N	\N	\N
97	dt5pcqrxobcbvqwu8id1b7mh	plugin::content-manager.explorer.create	{}	api::review.review	{"fields": ["rating", "comment", "user", "product"]}	[]	2026-03-30 16:27:30.535	2026-03-30 16:27:30.535	2026-03-30 16:27:30.535	\N	\N	\N
98	k1xywlngewddfqqrviv58g2t	plugin::content-manager.explorer.create	{}	api::scheduled-reminder.scheduled-reminder	{"fields": ["reminderType", "scheduledFor", "sent", "sentAt", "booking"]}	[]	2026-03-30 16:27:30.545	2026-03-30 16:27:30.545	2026-03-30 16:27:30.546	\N	\N	\N
99	seacl3vxla06jwngr51zjpk9	plugin::content-manager.explorer.create	{}	api::service.service	{"fields": ["name", "type", "price", "durationMinutes", "staffId", "bufferMinutes", "isActive", "description", "bookings"]}	[]	2026-03-30 16:27:30.567	2026-03-30 16:27:30.567	2026-03-30 16:27:30.567	\N	\N	\N
100	zgt2khdiek2ezbbrly9oxlfg	plugin::content-manager.explorer.create	{}	api::shipping-class.shipping-class	{"fields": ["name", "rate", "freeAbove", "description", "products"]}	[]	2026-03-30 16:27:30.578	2026-03-30 16:27:30.578	2026-03-30 16:27:30.578	\N	\N	\N
101	xh8b2ztk8zhils2hm2lpcvia	plugin::content-manager.explorer.create	{}	api::testimonial.testimonial	{"fields": ["name", "text", "sortOrder", "isActive"]}	[]	2026-03-30 16:27:30.587	2026-03-30 16:27:30.587	2026-03-30 16:27:30.588	\N	\N	\N
102	imrv31sho6pym6jibyxfccgs	plugin::content-manager.explorer.create	{}	api::wishlist-item.wishlist-item	{"fields": ["user", "product"]}	[]	2026-03-30 16:27:30.594	2026-03-30 16:27:30.594	2026-03-30 16:27:30.594	\N	\N	\N
103	l85ufh0r86p7a8wf48vh4dgj	plugin::content-manager.explorer.read	{}	plugin::users-permissions.user	{"fields": ["phone", "appRole", "orders", "bookings", "cartItems", "wishlistItems", "reviews", "couponUsages", "digitalPurchases", "passwordResetTokens"]}	[]	2026-03-30 16:27:30.601	2026-03-30 16:27:30.601	2026-03-30 16:27:30.601	\N	\N	\N
104	c6l7q6obrl6pgjbi5wlymbz0	plugin::content-manager.explorer.read	{}	api::availability-rule.availability-rule	{"fields": ["dayOfWeek", "startTime", "endTime", "isActive"]}	[]	2026-03-30 16:27:30.609	2026-03-30 16:27:30.609	2026-03-30 16:27:30.61	\N	\N	\N
105	h07eyzn457n5w8zjwba13m6l	plugin::content-manager.explorer.read	{}	api::banner.banner	{"fields": ["title", "imageUrl", "linkUrl", "position", "startDate", "endDate", "isActive", "sortOrder"]}	[]	2026-03-30 16:27:30.617	2026-03-30 16:27:30.617	2026-03-30 16:27:30.617	\N	\N	\N
106	eamm59cqr7gh6lgm85pa4xe9	plugin::content-manager.explorer.read	{}	api::blocked-slot.blocked-slot	{"fields": ["date", "startTime", "endTime", "reason"]}	[]	2026-03-30 16:27:30.626	2026-03-30 16:27:30.626	2026-03-30 16:27:30.626	\N	\N	\N
107	g75dwwa87lo5p5ojw5xd652m	plugin::content-manager.explorer.read	{}	api::booking.booking	{"fields": ["guestName", "guestEmail", "guestPhone", "scheduledAt", "endAt", "status", "paymentStatus", "rzpOrderId", "rzpPaymentId", "rzpSignature", "amountPaid", "gcalEventId", "customerNotes", "adminNotes", "cancelledAt", "cancelReason", "rescheduledFrom", "legacyId", "user", "service", "reminders"]}	[]	2026-03-30 16:27:30.634	2026-03-30 16:27:30.634	2026-03-30 16:27:30.634	\N	\N	\N
108	dfb1dunu2ve9fdh6qlr9tly1	plugin::content-manager.explorer.read	{}	api::booking-setting.booking-setting	{"fields": ["slotDurationMinutes", "bufferBetweenSlots", "maxAdvanceBookingDays", "minAdvanceBookingHours", "cancellationPolicyHours", "gcalCalendarId", "gcalSyncEnabled", "gcalRefreshToken", "autoConfirm"]}	[]	2026-03-30 16:27:30.642	2026-03-30 16:27:30.642	2026-03-30 16:27:30.642	\N	\N	\N
109	nrjpli2hciof6415ru6k6g5f	plugin::content-manager.explorer.read	{}	api::business-setting.business-setting	{"fields": ["businessName", "gstin", "pan", "address", "state", "stateCode", "phone", "email", "logoUrl", "bankName", "bankAccount", "bankIfsc", "invoicePrefix", "nextInvoiceNumber", "fbPixelId", "fbPixelEnabled"]}	[]	2026-03-30 16:27:30.649	2026-03-30 16:27:30.649	2026-03-30 16:27:30.649	\N	\N	\N
110	d04alut9aogfhr6e06gyld03	plugin::content-manager.explorer.read	{}	api::cart-item.cart-item	{"fields": ["sessionId", "quantity", "variantSelection", "user", "product"]}	[]	2026-03-30 16:27:30.656	2026-03-30 16:27:30.656	2026-03-30 16:27:30.656	\N	\N	\N
111	dpngergcpcb06jwhhy2xr78f	plugin::content-manager.explorer.read	{}	api::commerce-placeholder.commerce-placeholder	{"fields": ["name"]}	[]	2026-03-30 16:27:30.661	2026-03-30 16:27:30.661	2026-03-30 16:27:30.661	\N	\N	\N
112	jed9g4z2n40z6psl0gkc0cci	plugin::content-manager.explorer.read	{}	api::contact-message.contact-message	{"fields": ["name", "email", "phone", "company", "message", "isRead"]}	[]	2026-03-30 16:27:30.671	2026-03-30 16:27:30.671	2026-03-30 16:27:30.671	\N	\N	\N
113	n2ojrku93kdcqr0t47gkut2o	plugin::content-manager.explorer.read	{}	api::coupon-code.coupon-code	{"fields": ["code", "description", "discountType", "discountValue", "minCartTotal", "maxDiscount", "maxUses", "usedCount", "perUserLimit", "validFrom", "validUntil", "isActive", "applicableCategoryIds", "applicableProductIds", "usages", "orders"]}	[]	2026-03-30 16:27:30.677	2026-03-30 16:27:30.677	2026-03-30 16:27:30.677	\N	\N	\N
115	jw8ouv13h51cvv60jz24uhwe	plugin::content-manager.explorer.read	{}	api::digital-asset.digital-asset	{"fields": ["assetType", "url", "fileName", "fileSize", "accessInstructions", "product", "purchases"]}	[]	2026-03-30 16:27:30.69	2026-03-30 16:27:30.69	2026-03-30 16:27:30.69	\N	\N	\N
116	kd0a1pmwp5np0utmxw0soebd	plugin::content-manager.explorer.read	{}	api::digital-purchase.digital-purchase	{"fields": ["guestEmail", "accessGrantedAt", "accessUrl", "expiresAt", "user", "order", "product", "asset"]}	[]	2026-03-30 16:27:30.696	2026-03-30 16:27:30.696	2026-03-30 16:27:30.696	\N	\N	\N
117	pvcrwoslf6ah09xeoa5sz4uf	plugin::content-manager.explorer.read	{}	api::email-log.email-log	{"fields": ["to", "subject", "templateName", "status", "relatedType", "relatedId", "error", "sentAt"]}	[]	2026-03-30 16:27:30.703	2026-03-30 16:27:30.703	2026-03-30 16:27:30.704	\N	\N	\N
118	wavyb7jsnhh7f5twjhwwxz2c	plugin::content-manager.explorer.read	{}	api::invoice.invoice	{"fields": ["invoiceNumber", "invoiceDate", "buyerName", "buyerAddress", "buyerGstin", "buyerState", "buyerStateCode", "items", "subtotal", "cgst", "sgst", "igst", "totalTax", "grandTotal", "placeOfSupply", "isInterState", "pdfUrl", "order"]}	[]	2026-03-30 16:27:30.709	2026-03-30 16:27:30.709	2026-03-30 16:27:30.709	\N	\N	\N
119	chzsdw1upklghs2d8dng191e	plugin::content-manager.explorer.read	{}	api::legal-page.legal-page	{"fields": ["slug", "title", "content"]}	[]	2026-03-30 16:27:30.716	2026-03-30 16:27:30.716	2026-03-30 16:27:30.716	\N	\N	\N
120	oqem6u0lnotfq4t4ig0zf3ay	plugin::content-manager.explorer.read	{}	api::order.order	{"fields": ["guestName", "guestEmail", "guestPhone", "status", "subtotal", "discount", "tax", "shippingAmount", "total", "rzpOrderId", "rzpPaymentId", "rzpSignature", "paymentStatus", "paymentMethod", "refundId", "refundStatus", "refundAmount", "shippingAddress", "billingAddress", "notes", "legacyId", "user", "coupon", "items", "invoice", "shipment", "digitalPurchases", "couponUsages"]}	[]	2026-03-30 16:27:30.735	2026-03-30 16:27:30.735	2026-03-30 16:27:30.735	\N	\N	\N
121	hl2s3njqdxp933op3cwv9kib	plugin::content-manager.explorer.read	{}	api::order-item.order-item	{"fields": ["variantSelection", "quantity", "unitPrice", "gstRateBps", "hsnCode", "order", "product"]}	[]	2026-03-30 16:27:30.743	2026-03-30 16:27:30.743	2026-03-30 16:27:30.743	\N	\N	\N
122	tbi7fvx8ytmsvniq5zmm9aqu	plugin::content-manager.explorer.read	{}	api::order-shipment.order-shipment	{"fields": ["courierName", "trackingNumber", "trackingUrl", "shippedAt", "deliveredAt", "notes", "order"]}	[]	2026-03-30 16:27:30.751	2026-03-30 16:27:30.751	2026-03-30 16:27:30.751	\N	\N	\N
123	b5g7gpdhv8fxi4lh2o4byfml	plugin::content-manager.explorer.read	{}	api::password-reset-token.password-reset-token	{"fields": ["token", "expiresAt", "user"]}	[]	2026-03-30 16:27:30.759	2026-03-30 16:27:30.759	2026-03-30 16:27:30.759	\N	\N	\N
124	lsm1sgdsuijuxr3emppl1iow	plugin::content-manager.explorer.read	{}	api::popup.popup	{"fields": ["title", "content", "imageUrl", "linkUrl", "triggerType", "triggerValue", "showOnPages", "frequency", "startDate", "endDate", "isActive"]}	[]	2026-03-30 16:27:30.767	2026-03-30 16:27:30.767	2026-03-30 16:27:30.767	\N	\N	\N
125	whyanirpn7zajpslhcurij4l	plugin::content-manager.explorer.read	{}	api::product.product	{"fields": ["name", "slug", "description", "productType", "price", "salePrice", "stock", "images", "healingProperties", "wearHand", "hsnCode", "gstRateBps", "isActive", "category", "shippingClass", "variants", "digitalAssets", "cartItems", "wishlistItems", "orderItems", "reviews", "digitalPurchases"]}	[]	2026-03-30 16:27:30.775	2026-03-30 16:27:30.775	2026-03-30 16:27:30.775	\N	\N	\N
126	j2ko0rsi3u27pcxbe6y1t0np	plugin::content-manager.explorer.read	{}	api::product-category.product-category	{"fields": ["name", "slug", "sortOrder", "products"]}	[]	2026-03-30 16:27:30.783	2026-03-30 16:27:30.783	2026-03-30 16:27:30.783	\N	\N	\N
127	b1qn04fr5q3qaghb3os9fgte	plugin::content-manager.explorer.read	{}	api::product-variant.product-variant	{"fields": ["name", "options", "product"]}	[]	2026-03-30 16:27:30.79	2026-03-30 16:27:30.79	2026-03-30 16:27:30.79	\N	\N	\N
128	qw5ptew08xpwnekvi9supo5s	plugin::content-manager.explorer.read	{}	api::promo-rule.promo-rule	{"fields": ["type", "config", "isActive"]}	[]	2026-03-30 16:27:30.798	2026-03-30 16:27:30.798	2026-03-30 16:27:30.798	\N	\N	\N
129	dmn7y857bilp65j6jzmkxjsv	plugin::content-manager.explorer.read	{}	api::review.review	{"fields": ["rating", "comment", "user", "product"]}	[]	2026-03-30 16:27:30.805	2026-03-30 16:27:30.805	2026-03-30 16:27:30.805	\N	\N	\N
130	osq5ssfcsgy23vl1c7gakkam	plugin::content-manager.explorer.read	{}	api::scheduled-reminder.scheduled-reminder	{"fields": ["reminderType", "scheduledFor", "sent", "sentAt", "booking"]}	[]	2026-03-30 16:27:30.812	2026-03-30 16:27:30.812	2026-03-30 16:27:30.812	\N	\N	\N
131	lpd8da7ujos0diyryz008lvf	plugin::content-manager.explorer.read	{}	api::service.service	{"fields": ["name", "type", "price", "durationMinutes", "staffId", "bufferMinutes", "isActive", "description", "bookings"]}	[]	2026-03-30 16:27:30.819	2026-03-30 16:27:30.819	2026-03-30 16:27:30.82	\N	\N	\N
132	vcjte538i98h9w0a1ku36rgz	plugin::content-manager.explorer.read	{}	api::shipping-class.shipping-class	{"fields": ["name", "rate", "freeAbove", "description", "products"]}	[]	2026-03-30 16:27:30.827	2026-03-30 16:27:30.827	2026-03-30 16:27:30.827	\N	\N	\N
133	kidzbpse8vyeqink0oey8908	plugin::content-manager.explorer.read	{}	api::testimonial.testimonial	{"fields": ["name", "text", "sortOrder", "isActive"]}	[]	2026-03-30 16:27:30.839	2026-03-30 16:27:30.839	2026-03-30 16:27:30.839	\N	\N	\N
134	d4v88kff0yn5tw89qntuaih5	plugin::content-manager.explorer.read	{}	api::wishlist-item.wishlist-item	{"fields": ["user", "product"]}	[]	2026-03-30 16:27:30.845	2026-03-30 16:27:30.845	2026-03-30 16:27:30.845	\N	\N	\N
135	pc0r5urmdneum25doxzssqt5	plugin::content-manager.explorer.update	{}	plugin::users-permissions.user	{"fields": ["phone", "appRole", "orders", "bookings", "cartItems", "wishlistItems", "reviews", "couponUsages", "digitalPurchases", "passwordResetTokens"]}	[]	2026-03-30 16:27:30.853	2026-03-30 16:27:30.853	2026-03-30 16:27:30.853	\N	\N	\N
136	s45pqk1rm7f45qwsyntzitnn	plugin::content-manager.explorer.update	{}	api::availability-rule.availability-rule	{"fields": ["dayOfWeek", "startTime", "endTime", "isActive"]}	[]	2026-03-30 16:27:30.86	2026-03-30 16:27:30.86	2026-03-30 16:27:30.86	\N	\N	\N
137	gcmcn3mfvrwmqqzo9ggi4gv0	plugin::content-manager.explorer.update	{}	api::banner.banner	{"fields": ["title", "imageUrl", "linkUrl", "position", "startDate", "endDate", "isActive", "sortOrder"]}	[]	2026-03-30 16:27:30.866	2026-03-30 16:27:30.866	2026-03-30 16:27:30.866	\N	\N	\N
138	qtfifqscm0smios2n88t5ar0	plugin::content-manager.explorer.update	{}	api::blocked-slot.blocked-slot	{"fields": ["date", "startTime", "endTime", "reason"]}	[]	2026-03-30 16:27:30.872	2026-03-30 16:27:30.872	2026-03-30 16:27:30.872	\N	\N	\N
139	g0wbvo9v1y5e8xutuz8mkwha	plugin::content-manager.explorer.update	{}	api::booking.booking	{"fields": ["guestName", "guestEmail", "guestPhone", "scheduledAt", "endAt", "status", "paymentStatus", "rzpOrderId", "rzpPaymentId", "rzpSignature", "amountPaid", "gcalEventId", "customerNotes", "adminNotes", "cancelledAt", "cancelReason", "rescheduledFrom", "legacyId", "user", "service", "reminders"]}	[]	2026-03-30 16:27:30.878	2026-03-30 16:27:30.878	2026-03-30 16:27:30.878	\N	\N	\N
140	osuy894moytjmyzxlcuuel4m	plugin::content-manager.explorer.update	{}	api::booking-setting.booking-setting	{"fields": ["slotDurationMinutes", "bufferBetweenSlots", "maxAdvanceBookingDays", "minAdvanceBookingHours", "cancellationPolicyHours", "gcalCalendarId", "gcalSyncEnabled", "gcalRefreshToken", "autoConfirm"]}	[]	2026-03-30 16:27:30.886	2026-03-30 16:27:30.886	2026-03-30 16:27:30.886	\N	\N	\N
169	ps8w83pbo7ytj0qisxty8zkr	plugin::content-manager.explorer.delete	{}	api::blocked-slot.blocked-slot	{}	[]	2026-03-30 16:27:31.074	2026-03-30 16:27:31.074	2026-03-30 16:27:31.074	\N	\N	\N
141	efg36e0w57l2ale5x6y283ne	plugin::content-manager.explorer.update	{}	api::business-setting.business-setting	{"fields": ["businessName", "gstin", "pan", "address", "state", "stateCode", "phone", "email", "logoUrl", "bankName", "bankAccount", "bankIfsc", "invoicePrefix", "nextInvoiceNumber", "fbPixelId", "fbPixelEnabled"]}	[]	2026-03-30 16:27:30.893	2026-03-30 16:27:30.893	2026-03-30 16:27:30.893	\N	\N	\N
142	i9wfdvkbgfvcevcjsbjjxzdf	plugin::content-manager.explorer.update	{}	api::cart-item.cart-item	{"fields": ["sessionId", "quantity", "variantSelection", "user", "product"]}	[]	2026-03-30 16:27:30.9	2026-03-30 16:27:30.9	2026-03-30 16:27:30.9	\N	\N	\N
143	lknkotwky8g1z0nf0qn2wvtk	plugin::content-manager.explorer.update	{}	api::commerce-placeholder.commerce-placeholder	{"fields": ["name"]}	[]	2026-03-30 16:27:30.906	2026-03-30 16:27:30.906	2026-03-30 16:27:30.906	\N	\N	\N
144	inqpkgpdvu1h0246msa6bpwf	plugin::content-manager.explorer.update	{}	api::contact-message.contact-message	{"fields": ["name", "email", "phone", "company", "message", "isRead"]}	[]	2026-03-30 16:27:30.913	2026-03-30 16:27:30.913	2026-03-30 16:27:30.913	\N	\N	\N
145	rwgrwampnk1jler8fz4giqk8	plugin::content-manager.explorer.update	{}	api::coupon-code.coupon-code	{"fields": ["code", "description", "discountType", "discountValue", "minCartTotal", "maxDiscount", "maxUses", "usedCount", "perUserLimit", "validFrom", "validUntil", "isActive", "applicableCategoryIds", "applicableProductIds", "usages", "orders"]}	[]	2026-03-30 16:27:30.92	2026-03-30 16:27:30.92	2026-03-30 16:27:30.921	\N	\N	\N
146	cf6lgykohxcf4n9htd6clmy8	plugin::content-manager.explorer.update	{}	api::coupon-usage.coupon-usage	{"fields": ["guestEmail", "discountAmount", "usedAt", "coupon", "user", "order"]}	[]	2026-03-30 16:27:30.926	2026-03-30 16:27:30.926	2026-03-30 16:27:30.926	\N	\N	\N
147	ufi2ix2s6pqkinkckjr4o37r	plugin::content-manager.explorer.update	{}	api::digital-asset.digital-asset	{"fields": ["assetType", "url", "fileName", "fileSize", "accessInstructions", "product", "purchases"]}	[]	2026-03-30 16:27:30.933	2026-03-30 16:27:30.933	2026-03-30 16:27:30.933	\N	\N	\N
148	xsimwbiaibxfxlb5b87ms9jn	plugin::content-manager.explorer.update	{}	api::digital-purchase.digital-purchase	{"fields": ["guestEmail", "accessGrantedAt", "accessUrl", "expiresAt", "user", "order", "product", "asset"]}	[]	2026-03-30 16:27:30.939	2026-03-30 16:27:30.939	2026-03-30 16:27:30.939	\N	\N	\N
149	ngm4u9vlz8esgy9ic45twsld	plugin::content-manager.explorer.update	{}	api::email-log.email-log	{"fields": ["to", "subject", "templateName", "status", "relatedType", "relatedId", "error", "sentAt"]}	[]	2026-03-30 16:27:30.946	2026-03-30 16:27:30.946	2026-03-30 16:27:30.946	\N	\N	\N
150	nwgds25vxmxzwhxpok6bwxft	plugin::content-manager.explorer.update	{}	api::invoice.invoice	{"fields": ["invoiceNumber", "invoiceDate", "buyerName", "buyerAddress", "buyerGstin", "buyerState", "buyerStateCode", "items", "subtotal", "cgst", "sgst", "igst", "totalTax", "grandTotal", "placeOfSupply", "isInterState", "pdfUrl", "order"]}	[]	2026-03-30 16:27:30.954	2026-03-30 16:27:30.954	2026-03-30 16:27:30.954	\N	\N	\N
151	xz4k38on3fjm15513oo17ttk	plugin::content-manager.explorer.update	{}	api::legal-page.legal-page	{"fields": ["slug", "title", "content"]}	[]	2026-03-30 16:27:30.959	2026-03-30 16:27:30.959	2026-03-30 16:27:30.959	\N	\N	\N
152	eu52uwz2lzlgfmimdzqjeau4	plugin::content-manager.explorer.update	{}	api::order.order	{"fields": ["guestName", "guestEmail", "guestPhone", "status", "subtotal", "discount", "tax", "shippingAmount", "total", "rzpOrderId", "rzpPaymentId", "rzpSignature", "paymentStatus", "paymentMethod", "refundId", "refundStatus", "refundAmount", "shippingAddress", "billingAddress", "notes", "legacyId", "user", "coupon", "items", "invoice", "shipment", "digitalPurchases", "couponUsages"]}	[]	2026-03-30 16:27:30.965	2026-03-30 16:27:30.965	2026-03-30 16:27:30.966	\N	\N	\N
153	hu2spj470s8btg6t07qtqzvc	plugin::content-manager.explorer.update	{}	api::order-item.order-item	{"fields": ["variantSelection", "quantity", "unitPrice", "gstRateBps", "hsnCode", "order", "product"]}	[]	2026-03-30 16:27:30.971	2026-03-30 16:27:30.971	2026-03-30 16:27:30.972	\N	\N	\N
154	djvi4euckmrvrjgmrt26zkhj	plugin::content-manager.explorer.update	{}	api::order-shipment.order-shipment	{"fields": ["courierName", "trackingNumber", "trackingUrl", "shippedAt", "deliveredAt", "notes", "order"]}	[]	2026-03-30 16:27:30.977	2026-03-30 16:27:30.977	2026-03-30 16:27:30.978	\N	\N	\N
155	f5q1kq8iyq8a7k62pucq1rmp	plugin::content-manager.explorer.update	{}	api::password-reset-token.password-reset-token	{"fields": ["token", "expiresAt", "user"]}	[]	2026-03-30 16:27:30.984	2026-03-30 16:27:30.984	2026-03-30 16:27:30.984	\N	\N	\N
156	sc3t13v8p6ubq803r18jnf7s	plugin::content-manager.explorer.update	{}	api::popup.popup	{"fields": ["title", "content", "imageUrl", "linkUrl", "triggerType", "triggerValue", "showOnPages", "frequency", "startDate", "endDate", "isActive"]}	[]	2026-03-30 16:27:30.99	2026-03-30 16:27:30.99	2026-03-30 16:27:30.99	\N	\N	\N
157	bmq9zwfldwqoo1pujyhf8hqz	plugin::content-manager.explorer.update	{}	api::product.product	{"fields": ["name", "slug", "description", "productType", "price", "salePrice", "stock", "images", "healingProperties", "wearHand", "hsnCode", "gstRateBps", "isActive", "category", "shippingClass", "variants", "digitalAssets", "cartItems", "wishlistItems", "orderItems", "reviews", "digitalPurchases"]}	[]	2026-03-30 16:27:30.996	2026-03-30 16:27:30.996	2026-03-30 16:27:30.996	\N	\N	\N
158	fhw3u0iwfltunu7iu8s0y178	plugin::content-manager.explorer.update	{}	api::product-category.product-category	{"fields": ["name", "slug", "sortOrder", "products"]}	[]	2026-03-30 16:27:31.003	2026-03-30 16:27:31.003	2026-03-30 16:27:31.003	\N	\N	\N
159	v8j7cdanpqppy91q3ewxezkq	plugin::content-manager.explorer.update	{}	api::product-variant.product-variant	{"fields": ["name", "options", "product"]}	[]	2026-03-30 16:27:31.009	2026-03-30 16:27:31.009	2026-03-30 16:27:31.009	\N	\N	\N
160	zgwykg69sewkbsxu43tf1fka	plugin::content-manager.explorer.update	{}	api::promo-rule.promo-rule	{"fields": ["type", "config", "isActive"]}	[]	2026-03-30 16:27:31.015	2026-03-30 16:27:31.015	2026-03-30 16:27:31.015	\N	\N	\N
161	ac0qs0zh1dgjunbu40aw4eit	plugin::content-manager.explorer.update	{}	api::review.review	{"fields": ["rating", "comment", "user", "product"]}	[]	2026-03-30 16:27:31.024	2026-03-30 16:27:31.024	2026-03-30 16:27:31.024	\N	\N	\N
162	j4o41dd6e3ayxeik41g4axk2	plugin::content-manager.explorer.update	{}	api::scheduled-reminder.scheduled-reminder	{"fields": ["reminderType", "scheduledFor", "sent", "sentAt", "booking"]}	[]	2026-03-30 16:27:31.031	2026-03-30 16:27:31.031	2026-03-30 16:27:31.031	\N	\N	\N
163	anidjuinl38h2lie2t8v0e82	plugin::content-manager.explorer.update	{}	api::service.service	{"fields": ["name", "type", "price", "durationMinutes", "staffId", "bufferMinutes", "isActive", "description", "bookings"]}	[]	2026-03-30 16:27:31.037	2026-03-30 16:27:31.037	2026-03-30 16:27:31.037	\N	\N	\N
164	x1cwsehx8umkd5zjdonkkcer	plugin::content-manager.explorer.update	{}	api::shipping-class.shipping-class	{"fields": ["name", "rate", "freeAbove", "description", "products"]}	[]	2026-03-30 16:27:31.043	2026-03-30 16:27:31.043	2026-03-30 16:27:31.043	\N	\N	\N
165	k3m42hsmro7yl8kkwl9uz2s9	plugin::content-manager.explorer.update	{}	api::testimonial.testimonial	{"fields": ["name", "text", "sortOrder", "isActive"]}	[]	2026-03-30 16:27:31.049	2026-03-30 16:27:31.049	2026-03-30 16:27:31.049	\N	\N	\N
166	ttthng7mfwl55a9q8kbl5q47	plugin::content-manager.explorer.update	{}	api::wishlist-item.wishlist-item	{"fields": ["user", "product"]}	[]	2026-03-30 16:27:31.055	2026-03-30 16:27:31.055	2026-03-30 16:27:31.055	\N	\N	\N
167	tzb11gxxyoqjxup1woiu5o4b	plugin::content-manager.explorer.delete	{}	api::availability-rule.availability-rule	{}	[]	2026-03-30 16:27:31.06	2026-03-30 16:27:31.06	2026-03-30 16:27:31.06	\N	\N	\N
168	mckhrinkem610gm9vghehnzt	plugin::content-manager.explorer.delete	{}	api::banner.banner	{}	[]	2026-03-30 16:27:31.067	2026-03-30 16:27:31.067	2026-03-30 16:27:31.067	\N	\N	\N
171	t2hpiw9wq8n19a30ej08mhrt	plugin::content-manager.explorer.delete	{}	api::booking-setting.booking-setting	{}	[]	2026-03-30 16:27:31.087	2026-03-30 16:27:31.087	2026-03-30 16:27:31.087	\N	\N	\N
172	vahkcqwc9vbs45ilsuvdirco	plugin::content-manager.explorer.delete	{}	api::business-setting.business-setting	{}	[]	2026-03-30 16:27:31.093	2026-03-30 16:27:31.093	2026-03-30 16:27:31.093	\N	\N	\N
173	nfh7zoxvlqf9eza1aahfj4mp	plugin::content-manager.explorer.delete	{}	api::cart-item.cart-item	{}	[]	2026-03-30 16:27:31.1	2026-03-30 16:27:31.1	2026-03-30 16:27:31.1	\N	\N	\N
174	gvytydrikfc3fbb7p1cdl6o4	plugin::content-manager.explorer.delete	{}	api::commerce-placeholder.commerce-placeholder	{}	[]	2026-03-30 16:27:31.107	2026-03-30 16:27:31.107	2026-03-30 16:27:31.107	\N	\N	\N
175	aq4h8whyo64rp079sghpt6hc	plugin::content-manager.explorer.delete	{}	api::contact-message.contact-message	{}	[]	2026-03-30 16:27:31.114	2026-03-30 16:27:31.114	2026-03-30 16:27:31.114	\N	\N	\N
176	yq2ygjmq72j1bjjlsfiarqz7	plugin::content-manager.explorer.delete	{}	api::coupon-code.coupon-code	{}	[]	2026-03-30 16:27:31.122	2026-03-30 16:27:31.122	2026-03-30 16:27:31.122	\N	\N	\N
177	dgr3yrmgexgufj72ycaio898	plugin::content-manager.explorer.delete	{}	api::coupon-usage.coupon-usage	{}	[]	2026-03-30 16:27:31.129	2026-03-30 16:27:31.129	2026-03-30 16:27:31.129	\N	\N	\N
178	ymrq6q7nzzjwu5kxctvt17qm	plugin::content-manager.explorer.delete	{}	api::digital-asset.digital-asset	{}	[]	2026-03-30 16:27:31.137	2026-03-30 16:27:31.137	2026-03-30 16:27:31.137	\N	\N	\N
179	i9eeaa1llgtm9wphrce6y4gf	plugin::content-manager.explorer.delete	{}	api::digital-purchase.digital-purchase	{}	[]	2026-03-30 16:27:31.143	2026-03-30 16:27:31.143	2026-03-30 16:27:31.143	\N	\N	\N
180	aceg3cgha5jbnjbn8qzy2plc	plugin::content-manager.explorer.delete	{}	api::email-log.email-log	{}	[]	2026-03-30 16:27:31.156	2026-03-30 16:27:31.156	2026-03-30 16:27:31.156	\N	\N	\N
181	at4d85n2ag0wvse0m2ln5baj	plugin::content-manager.explorer.delete	{}	api::invoice.invoice	{}	[]	2026-03-30 16:27:31.166	2026-03-30 16:27:31.166	2026-03-30 16:27:31.167	\N	\N	\N
182	nr2uq95k1abpojs5jnhd7akl	plugin::content-manager.explorer.delete	{}	api::legal-page.legal-page	{}	[]	2026-03-30 16:27:31.174	2026-03-30 16:27:31.174	2026-03-30 16:27:31.175	\N	\N	\N
183	h3sjnuvjm0xvowsi9acls9bm	plugin::content-manager.explorer.delete	{}	api::order.order	{}	[]	2026-03-30 16:27:31.18	2026-03-30 16:27:31.18	2026-03-30 16:27:31.18	\N	\N	\N
184	nnhq8js7xqtbn0zy4rrj9udr	plugin::content-manager.explorer.delete	{}	api::order-item.order-item	{}	[]	2026-03-30 16:27:31.188	2026-03-30 16:27:31.188	2026-03-30 16:27:31.188	\N	\N	\N
185	pjxkdapl1rcpr6lnkf4jmpjw	plugin::content-manager.explorer.delete	{}	api::order-shipment.order-shipment	{}	[]	2026-03-30 16:27:31.194	2026-03-30 16:27:31.194	2026-03-30 16:27:31.194	\N	\N	\N
186	ikd13ct5nomj9x68q4okxtca	plugin::content-manager.explorer.delete	{}	api::password-reset-token.password-reset-token	{}	[]	2026-03-30 16:27:31.201	2026-03-30 16:27:31.201	2026-03-30 16:27:31.201	\N	\N	\N
187	rwmphb35mzcswyjwjgufwovf	plugin::content-manager.explorer.delete	{}	api::popup.popup	{}	[]	2026-03-30 16:27:31.207	2026-03-30 16:27:31.207	2026-03-30 16:27:31.207	\N	\N	\N
188	j39fqje2aedslnexi6pbqw3c	plugin::content-manager.explorer.delete	{}	api::product.product	{}	[]	2026-03-30 16:27:31.212	2026-03-30 16:27:31.212	2026-03-30 16:27:31.212	\N	\N	\N
189	pgzjefsd45oywgothhdkglv0	plugin::content-manager.explorer.delete	{}	api::product-category.product-category	{}	[]	2026-03-30 16:27:31.219	2026-03-30 16:27:31.219	2026-03-30 16:27:31.219	\N	\N	\N
190	gy0pejjcmqycw1uk7ntcneje	plugin::content-manager.explorer.delete	{}	api::product-variant.product-variant	{}	[]	2026-03-30 16:27:31.225	2026-03-30 16:27:31.225	2026-03-30 16:27:31.225	\N	\N	\N
191	k9z8r8zxlvfx0qscsp3mmsqu	plugin::content-manager.explorer.delete	{}	api::promo-rule.promo-rule	{}	[]	2026-03-30 16:27:31.233	2026-03-30 16:27:31.233	2026-03-30 16:27:31.233	\N	\N	\N
192	cvp27nnwvthal15dhpdys04q	plugin::content-manager.explorer.delete	{}	api::review.review	{}	[]	2026-03-30 16:27:31.241	2026-03-30 16:27:31.241	2026-03-30 16:27:31.241	\N	\N	\N
193	lqopzv7gfag2q88puyug2ky1	plugin::content-manager.explorer.delete	{}	api::scheduled-reminder.scheduled-reminder	{}	[]	2026-03-30 16:27:31.246	2026-03-30 16:27:31.246	2026-03-30 16:27:31.247	\N	\N	\N
194	ug6h5pke8oreo8zm602r90f0	plugin::content-manager.explorer.delete	{}	api::service.service	{}	[]	2026-03-30 16:27:31.254	2026-03-30 16:27:31.254	2026-03-30 16:27:31.254	\N	\N	\N
195	muqp066dp0242d8yew3jm14b	plugin::content-manager.explorer.delete	{}	api::shipping-class.shipping-class	{}	[]	2026-03-30 16:27:31.26	2026-03-30 16:27:31.26	2026-03-30 16:27:31.26	\N	\N	\N
196	njkh8qpwrmm6lmvdm446lok1	plugin::content-manager.explorer.delete	{}	api::testimonial.testimonial	{}	[]	2026-03-30 16:27:31.266	2026-03-30 16:27:31.266	2026-03-30 16:27:31.266	\N	\N	\N
197	n7ebkl71zkuvto48osdo2u4d	plugin::content-manager.explorer.delete	{}	api::wishlist-item.wishlist-item	{}	[]	2026-03-30 16:27:31.272	2026-03-30 16:27:31.272	2026-03-30 16:27:31.272	\N	\N	\N
198	luvos4opn7ah5tsnbpzmo9rn	plugin::content-manager.explorer.publish	{}	api::availability-rule.availability-rule	{}	[]	2026-03-30 16:27:31.278	2026-03-30 16:27:31.278	2026-03-30 16:27:31.278	\N	\N	\N
199	xzdjm7a39vy5pceei6zu6eaq	plugin::content-manager.explorer.publish	{}	api::banner.banner	{}	[]	2026-03-30 16:27:31.285	2026-03-30 16:27:31.285	2026-03-30 16:27:31.285	\N	\N	\N
200	xjycfjuvbygn1waeb3nb0v67	plugin::content-manager.explorer.publish	{}	api::blocked-slot.blocked-slot	{}	[]	2026-03-30 16:27:31.295	2026-03-30 16:27:31.295	2026-03-30 16:27:31.295	\N	\N	\N
201	pau4y316lpq8js237g185pmb	plugin::content-manager.explorer.publish	{}	api::booking.booking	{}	[]	2026-03-30 16:27:31.303	2026-03-30 16:27:31.303	2026-03-30 16:27:31.303	\N	\N	\N
202	dnsz9tuhfnrdx3sc1fify3yx	plugin::content-manager.explorer.publish	{}	api::booking-setting.booking-setting	{}	[]	2026-03-30 16:27:31.31	2026-03-30 16:27:31.31	2026-03-30 16:27:31.311	\N	\N	\N
203	vqj52uu9vod2x6tqzj1e24j1	plugin::content-manager.explorer.publish	{}	api::business-setting.business-setting	{}	[]	2026-03-30 16:27:31.317	2026-03-30 16:27:31.317	2026-03-30 16:27:31.318	\N	\N	\N
204	wf4hde8c5k82pvjuyi92q5k7	plugin::content-manager.explorer.publish	{}	api::cart-item.cart-item	{}	[]	2026-03-30 16:27:31.323	2026-03-30 16:27:31.323	2026-03-30 16:27:31.323	\N	\N	\N
205	gxsspso20sjxdsqanzz7pto1	plugin::content-manager.explorer.publish	{}	api::commerce-placeholder.commerce-placeholder	{}	[]	2026-03-30 16:27:31.328	2026-03-30 16:27:31.328	2026-03-30 16:27:31.329	\N	\N	\N
206	x31w95xsri569u9ud8l0wier	plugin::content-manager.explorer.publish	{}	api::contact-message.contact-message	{}	[]	2026-03-30 16:27:31.335	2026-03-30 16:27:31.335	2026-03-30 16:27:31.335	\N	\N	\N
207	dcy4jqmyot9esp6wki4gh3il	plugin::content-manager.explorer.publish	{}	api::coupon-code.coupon-code	{}	[]	2026-03-30 16:27:31.341	2026-03-30 16:27:31.341	2026-03-30 16:27:31.341	\N	\N	\N
208	aeyklydp3d6f5ggv3o12rkqc	plugin::content-manager.explorer.publish	{}	api::coupon-usage.coupon-usage	{}	[]	2026-03-30 16:27:31.349	2026-03-30 16:27:31.349	2026-03-30 16:27:31.349	\N	\N	\N
209	rtznvgsensz9gy9riz7koora	plugin::content-manager.explorer.publish	{}	api::digital-asset.digital-asset	{}	[]	2026-03-30 16:27:31.355	2026-03-30 16:27:31.355	2026-03-30 16:27:31.355	\N	\N	\N
210	qla0e799hjwdj0x8keyc7ihi	plugin::content-manager.explorer.publish	{}	api::digital-purchase.digital-purchase	{}	[]	2026-03-30 16:27:31.361	2026-03-30 16:27:31.361	2026-03-30 16:27:31.361	\N	\N	\N
211	gwafgl51ftnprt67on33yqz6	plugin::content-manager.explorer.publish	{}	api::email-log.email-log	{}	[]	2026-03-30 16:27:31.369	2026-03-30 16:27:31.369	2026-03-30 16:27:31.369	\N	\N	\N
212	p1aghhdg7tus9u8kpia5jk50	plugin::content-manager.explorer.publish	{}	api::invoice.invoice	{}	[]	2026-03-30 16:27:31.375	2026-03-30 16:27:31.375	2026-03-30 16:27:31.376	\N	\N	\N
213	adnymlhrgcniuhsaqi87dw3w	plugin::content-manager.explorer.publish	{}	api::legal-page.legal-page	{}	[]	2026-03-30 16:27:31.383	2026-03-30 16:27:31.383	2026-03-30 16:27:31.383	\N	\N	\N
214	eipznn2qtvnl23fwbq3l924l	plugin::content-manager.explorer.publish	{}	api::order.order	{}	[]	2026-03-30 16:27:31.39	2026-03-30 16:27:31.39	2026-03-30 16:27:31.39	\N	\N	\N
215	ltulxy48azwosraytlzeai3d	plugin::content-manager.explorer.publish	{}	api::order-item.order-item	{}	[]	2026-03-30 16:27:31.395	2026-03-30 16:27:31.395	2026-03-30 16:27:31.395	\N	\N	\N
216	b3yptu3obcs8shdlm6wiq2ht	plugin::content-manager.explorer.publish	{}	api::order-shipment.order-shipment	{}	[]	2026-03-30 16:27:31.402	2026-03-30 16:27:31.402	2026-03-30 16:27:31.402	\N	\N	\N
217	v7p7z7yzroco3bboo55x72xq	plugin::content-manager.explorer.publish	{}	api::password-reset-token.password-reset-token	{}	[]	2026-03-30 16:27:31.407	2026-03-30 16:27:31.407	2026-03-30 16:27:31.408	\N	\N	\N
218	oj31f2m02xvpkcwvzafvhaqq	plugin::content-manager.explorer.publish	{}	api::popup.popup	{}	[]	2026-03-30 16:27:31.413	2026-03-30 16:27:31.413	2026-03-30 16:27:31.413	\N	\N	\N
219	dn7jlhum85006f0ixk2rmtnn	plugin::content-manager.explorer.publish	{}	api::product.product	{}	[]	2026-03-30 16:27:31.42	2026-03-30 16:27:31.42	2026-03-30 16:27:31.42	\N	\N	\N
220	c581s1scydxppzm0fcee61oq	plugin::content-manager.explorer.publish	{}	api::product-category.product-category	{}	[]	2026-03-30 16:27:31.427	2026-03-30 16:27:31.427	2026-03-30 16:27:31.427	\N	\N	\N
221	diuf9bu07wfgd2eacsoj6yxx	plugin::content-manager.explorer.publish	{}	api::product-variant.product-variant	{}	[]	2026-03-30 16:27:31.435	2026-03-30 16:27:31.435	2026-03-30 16:27:31.435	\N	\N	\N
222	t8uhdm7f7s7ab62vo3nnupxf	plugin::content-manager.explorer.publish	{}	api::promo-rule.promo-rule	{}	[]	2026-03-30 16:27:31.442	2026-03-30 16:27:31.442	2026-03-30 16:27:31.442	\N	\N	\N
223	humrdxo3dimfwgcyfeqm33oh	plugin::content-manager.explorer.publish	{}	api::review.review	{}	[]	2026-03-30 16:27:31.45	2026-03-30 16:27:31.45	2026-03-30 16:27:31.45	\N	\N	\N
224	ee3ylwei00anwzdrgs5lcrt8	plugin::content-manager.explorer.publish	{}	api::scheduled-reminder.scheduled-reminder	{}	[]	2026-03-30 16:27:31.456	2026-03-30 16:27:31.456	2026-03-30 16:27:31.456	\N	\N	\N
225	vrne1tld1a9r7cdpxqovqx8w	plugin::content-manager.explorer.publish	{}	api::service.service	{}	[]	2026-03-30 16:27:31.462	2026-03-30 16:27:31.462	2026-03-30 16:27:31.462	\N	\N	\N
226	w3qd628bej0ya856ayjutn60	plugin::content-manager.explorer.publish	{}	api::shipping-class.shipping-class	{}	[]	2026-03-30 16:27:31.468	2026-03-30 16:27:31.468	2026-03-30 16:27:31.468	\N	\N	\N
227	sozxu4j89rdci8ropzj1g2ku	plugin::content-manager.explorer.publish	{}	api::testimonial.testimonial	{}	[]	2026-03-30 16:27:31.474	2026-03-30 16:27:31.474	2026-03-30 16:27:31.475	\N	\N	\N
228	s9gyea6e5okr1ct31y1ylivg	plugin::content-manager.explorer.publish	{}	api::wishlist-item.wishlist-item	{}	[]	2026-03-30 16:27:31.481	2026-03-30 16:27:31.481	2026-03-30 16:27:31.481	\N	\N	\N
\.


--
-- Data for Name: admin_permissions_role_lnk; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.admin_permissions_role_lnk (id, permission_id, role_id, permission_ord) FROM stdin;
1	1	2	1
2	2	2	2
3	3	2	3
4	4	2	4
5	5	2	5
6	6	2	6
7	7	3	1
8	8	3	2
9	9	3	3
10	10	3	4
11	11	3	5
12	12	3	6
16	16	1	4
17	17	1	5
18	18	1	6
19	19	1	7
20	20	1	8
21	21	1	9
22	22	1	10
23	23	1	11
24	24	1	12
25	25	1	13
26	26	1	14
27	27	1	15
28	28	1	16
29	29	1	17
30	30	1	18
31	31	1	19
32	32	1	20
33	33	1	21
34	34	1	22
35	35	1	23
36	36	1	24
37	37	1	25
38	38	1	26
39	39	1	27
40	40	1	28
41	41	1	29
42	42	1	30
43	43	1	31
44	44	1	32
45	45	1	33
46	46	1	34
47	47	1	35
48	48	1	36
49	49	1	37
50	50	1	38
51	51	1	39
52	52	1	40
53	53	1	41
54	54	1	42
55	55	1	43
56	56	1	44
57	57	1	45
58	58	1	46
59	59	1	47
60	60	1	48
61	61	1	49
62	62	1	50
63	63	1	51
64	64	1	52
65	65	1	53
66	66	1	54
67	67	1	55
68	68	1	56
69	69	1	57
70	70	1	58
71	71	1	59
72	72	1	60
73	73	1	61
74	74	1	62
75	75	1	63
76	76	1	64
77	77	1	65
78	78	1	66
79	79	1	67
80	80	1	68
81	81	1	69
82	82	1	70
83	83	1	71
84	84	1	72
85	85	1	73
86	86	1	74
87	87	1	75
88	88	1	76
89	89	1	77
90	90	1	78
91	91	1	79
92	92	1	80
93	93	1	81
94	94	1	82
95	95	1	83
96	96	1	84
97	97	1	85
98	98	1	86
99	99	1	87
100	100	1	88
101	101	1	89
102	102	1	90
103	103	1	91
104	104	1	92
105	105	1	93
106	106	1	94
107	107	1	95
108	108	1	96
109	109	1	97
110	110	1	98
111	111	1	99
112	112	1	100
113	113	1	101
114	114	1	102
115	115	1	103
116	116	1	104
117	117	1	105
118	118	1	106
119	119	1	107
120	120	1	108
121	121	1	109
122	122	1	110
123	123	1	111
124	124	1	112
125	125	1	113
126	126	1	114
127	127	1	115
128	128	1	116
129	129	1	117
130	130	1	118
131	131	1	119
132	132	1	120
133	133	1	121
134	134	1	122
135	135	1	123
136	136	1	124
137	137	1	125
138	138	1	126
139	139	1	127
140	140	1	128
141	141	1	129
142	142	1	130
143	143	1	131
144	144	1	132
145	145	1	133
146	146	1	134
147	147	1	135
148	148	1	136
149	149	1	137
150	150	1	138
151	151	1	139
152	152	1	140
153	153	1	141
154	154	1	142
155	155	1	143
156	156	1	144
157	157	1	145
158	158	1	146
159	159	1	147
160	160	1	148
161	161	1	149
162	162	1	150
163	163	1	151
164	164	1	152
165	165	1	153
166	166	1	154
167	167	1	155
168	168	1	156
169	169	1	157
170	170	1	158
171	171	1	159
172	172	1	160
173	173	1	161
174	174	1	162
175	175	1	163
176	176	1	164
177	177	1	165
178	178	1	166
179	179	1	167
180	180	1	168
181	181	1	169
182	182	1	170
183	183	1	171
184	184	1	172
185	185	1	173
186	186	1	174
187	187	1	175
188	188	1	176
189	189	1	177
190	190	1	178
191	191	1	179
192	192	1	180
193	193	1	181
194	194	1	182
195	195	1	183
196	196	1	184
197	197	1	185
198	198	1	186
199	199	1	187
200	200	1	188
201	201	1	189
202	202	1	190
203	203	1	191
204	204	1	192
205	205	1	193
206	206	1	194
207	207	1	195
208	208	1	196
209	209	1	197
210	210	1	198
211	211	1	199
212	212	1	200
213	213	1	201
214	214	1	202
215	215	1	203
216	216	1	204
217	217	1	205
218	218	1	206
219	219	1	207
220	220	1	208
221	221	1	209
222	222	1	210
223	223	1	211
224	224	1	212
225	225	1	213
226	226	1	214
227	227	1	215
228	228	1	216
\.


--
-- Data for Name: admin_roles; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.admin_roles (id, document_id, name, code, description, created_at, updated_at, published_at, created_by_id, updated_by_id, locale) FROM stdin;
1	qsodi8knc4m63rz8gj1zeuwd	Super Admin	strapi-super-admin	Super Admins can access and manage all features and settings.	2026-03-27 06:07:52.405	2026-03-27 06:07:52.405	2026-03-27 06:07:52.405	\N	\N	\N
2	wfk30kt12doiy1w63lu2ovvv	Editor	strapi-editor	Editors can manage and publish contents including those of other users.	2026-03-27 06:07:52.418	2026-03-27 06:07:52.418	2026-03-27 06:07:52.418	\N	\N	\N
3	dfoqu80c7bwtrzustrcuq859	Author	strapi-author	Authors can manage the content they have created.	2026-03-27 06:07:52.422	2026-03-27 06:07:52.422	2026-03-27 06:07:52.422	\N	\N	\N
\.


--
-- Data for Name: admin_users; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.admin_users (id, document_id, firstname, lastname, username, email, password, reset_password_token, registration_token, is_active, blocked, prefered_language, created_at, updated_at, published_at, created_by_id, updated_by_id, locale) FROM stdin;
1	mv9jtagsnb05utl4qmresgrm	Pragya	Vijh	\N	jso101196@gmail.com	$2a$10$M/z3MXW79tRi.UJ.G5qvA.K2qwJsNGk4aGVzS95j.Rnk/WSHKZnOe	\N	\N	t	f	\N	2026-03-27 16:38:18.697	2026-03-27 16:38:18.697	2026-03-27 16:38:18.698	\N	\N	\N
\.


--
-- Data for Name: admin_users_roles_lnk; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.admin_users_roles_lnk (id, user_id, role_id, role_ord, user_ord) FROM stdin;
1	1	1	1	1
\.


--
-- Data for Name: availability_rules; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.availability_rules (id, document_id, day_of_week, start_time, end_time, is_active, created_at, updated_at, published_at, created_by_id, updated_by_id, locale) FROM stdin;
\.


--
-- Data for Name: banners; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.banners (id, document_id, title, image_url, link_url, "position", start_date, end_date, is_active, sort_order, created_at, updated_at, published_at, created_by_id, updated_by_id, locale) FROM stdin;
\.


--
-- Data for Name: blocked_slots; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.blocked_slots (id, document_id, date, start_time, end_time, reason, created_at, updated_at, published_at, created_by_id, updated_by_id, locale) FROM stdin;
\.


--
-- Data for Name: booking_setting; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.booking_setting (id, document_id, slot_duration_minutes, buffer_between_slots, max_advance_booking_days, min_advance_booking_hours, cancellation_policy_hours, gcal_calendar_id, gcal_sync_enabled, gcal_refresh_token, auto_confirm, created_at, updated_at, published_at, created_by_id, updated_by_id, locale) FROM stdin;
1	ypmd44jwnse16qd025l0jikz	30	15	60	2	24	\N	f	\N	t	2026-03-30 17:08:53.359	2026-03-30 17:08:53.359	2026-03-30 17:08:53.357	\N	\N	\N
\.


--
-- Data for Name: bookings; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.bookings (id, document_id, guest_name, guest_email, guest_phone, scheduled_at, end_at, status, payment_status, rzp_order_id, rzp_payment_id, rzp_signature, amount_paid, gcal_event_id, customer_notes, admin_notes, cancelled_at, cancel_reason, rescheduled_from, legacy_id, created_at, updated_at, published_at, created_by_id, updated_by_id, locale) FROM stdin;
\.


--
-- Data for Name: bookings_service_lnk; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.bookings_service_lnk (id, booking_id, service_id, booking_ord) FROM stdin;
\.


--
-- Data for Name: bookings_user_lnk; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.bookings_user_lnk (id, booking_id, user_id, booking_ord) FROM stdin;
\.


--
-- Data for Name: business_setting; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.business_setting (id, document_id, business_name, gstin, pan, address, state, state_code, phone, email, logo_url, bank_name, bank_account, bank_ifsc, invoice_prefix, next_invoice_number, fb_pixel_id, fb_pixel_enabled, created_at, updated_at, published_at, created_by_id, updated_by_id, locale) FROM stdin;
1	bqoatizhilllgkkqbzuc4kjf	The Blissful Soul	\N	\N	Delhi, India	Delhi	07	+910000000000	contact@theblissfulsoul.com	\N	\N	\N	\N	TBS	1	\N	f	2026-03-30 17:08:53.335	2026-03-30 17:08:53.335	2026-03-30 17:08:53.319	\N	\N	\N
\.


--
-- Data for Name: cart_items; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.cart_items (id, document_id, session_id, quantity, variant_selection, created_at, updated_at, published_at, created_by_id, updated_by_id, locale) FROM stdin;
\.


--
-- Data for Name: cart_items_product_lnk; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.cart_items_product_lnk (id, cart_item_id, product_id, cart_item_ord) FROM stdin;
\.


--
-- Data for Name: cart_items_user_lnk; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.cart_items_user_lnk (id, cart_item_id, user_id, cart_item_ord) FROM stdin;
\.


--
-- Data for Name: commerce_placeholders; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.commerce_placeholders (id, document_id, name, created_at, updated_at, published_at, created_by_id, updated_by_id, locale) FROM stdin;
\.


--
-- Data for Name: contact_messages; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.contact_messages (id, document_id, name, email, phone, company, message, is_read, created_at, updated_at, published_at, created_by_id, updated_by_id, locale) FROM stdin;
\.


--
-- Data for Name: coupon_codes; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.coupon_codes (id, document_id, code, description, discount_type, discount_value, min_cart_total, max_discount, max_uses, used_count, per_user_limit, valid_from, valid_until, is_active, applicable_category_ids, applicable_product_ids, created_at, updated_at, published_at, created_by_id, updated_by_id, locale) FROM stdin;
\.


--
-- Data for Name: coupon_usages; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.coupon_usages (id, document_id, guest_email, discount_amount, used_at, created_at, updated_at, published_at, created_by_id, updated_by_id, locale) FROM stdin;
\.


--
-- Data for Name: coupon_usages_coupon_lnk; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.coupon_usages_coupon_lnk (id, coupon_usage_id, coupon_code_id, coupon_usage_ord) FROM stdin;
\.


--
-- Data for Name: coupon_usages_order_lnk; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.coupon_usages_order_lnk (id, coupon_usage_id, order_id, coupon_usage_ord) FROM stdin;
\.


--
-- Data for Name: coupon_usages_user_lnk; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.coupon_usages_user_lnk (id, coupon_usage_id, user_id, coupon_usage_ord) FROM stdin;
\.


--
-- Data for Name: digital_assets; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.digital_assets (id, document_id, asset_type, url, file_name, file_size, access_instructions, created_at, updated_at, published_at, created_by_id, updated_by_id, locale) FROM stdin;
\.


--
-- Data for Name: digital_assets_product_lnk; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.digital_assets_product_lnk (id, digital_asset_id, product_id, digital_asset_ord) FROM stdin;
\.


--
-- Data for Name: digital_purchases; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.digital_purchases (id, document_id, guest_email, access_granted_at, access_url, expires_at, created_at, updated_at, published_at, created_by_id, updated_by_id, locale) FROM stdin;
\.


--
-- Data for Name: digital_purchases_asset_lnk; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.digital_purchases_asset_lnk (id, digital_purchase_id, digital_asset_id, digital_purchase_ord) FROM stdin;
\.


--
-- Data for Name: digital_purchases_order_lnk; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.digital_purchases_order_lnk (id, digital_purchase_id, order_id, digital_purchase_ord) FROM stdin;
\.


--
-- Data for Name: digital_purchases_product_lnk; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.digital_purchases_product_lnk (id, digital_purchase_id, product_id, digital_purchase_ord) FROM stdin;
\.


--
-- Data for Name: digital_purchases_user_lnk; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.digital_purchases_user_lnk (id, digital_purchase_id, user_id, digital_purchase_ord) FROM stdin;
\.


--
-- Data for Name: email_logs; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.email_logs (id, document_id, "to", subject, template_name, status, related_type, related_id, error, sent_at, created_at, updated_at, published_at, created_by_id, updated_by_id, locale) FROM stdin;
\.


--
-- Data for Name: files; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.files (id, document_id, name, alternative_text, caption, focal_point, width, height, formats, hash, ext, mime, size, url, preview_url, provider, provider_metadata, folder_path, created_at, updated_at, published_at, created_by_id, updated_by_id, locale) FROM stdin;
\.


--
-- Data for Name: files_folder_lnk; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.files_folder_lnk (id, file_id, folder_id, file_ord) FROM stdin;
\.


--
-- Data for Name: files_related_mph; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.files_related_mph (id, file_id, related_id, related_type, field, "order") FROM stdin;
\.


--
-- Data for Name: i18n_locale; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.i18n_locale (id, document_id, name, code, created_at, updated_at, published_at, created_by_id, updated_by_id, locale) FROM stdin;
1	brm23av9zmo033zw7nd521oq	English (en)	en	2026-03-27 06:07:52.262	2026-03-27 06:07:52.262	2026-03-27 06:07:52.263	\N	\N	\N
\.


--
-- Data for Name: invoices; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.invoices (id, document_id, invoice_number, invoice_date, buyer_name, buyer_address, buyer_gstin, buyer_state, buyer_state_code, items, subtotal, cgst, sgst, igst, total_tax, grand_total, place_of_supply, is_inter_state, pdf_url, created_at, updated_at, published_at, created_by_id, updated_by_id, locale) FROM stdin;
\.


--
-- Data for Name: invoices_order_lnk; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.invoices_order_lnk (id, invoice_id, order_id) FROM stdin;
\.


--
-- Data for Name: legal_pages; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.legal_pages (id, document_id, slug, title, content, created_at, updated_at, published_at, created_by_id, updated_by_id, locale) FROM stdin;
\.


--
-- Data for Name: order_items; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.order_items (id, document_id, variant_selection, quantity, unit_price, gst_rate_bps, hsn_code, created_at, updated_at, published_at, created_by_id, updated_by_id, locale) FROM stdin;
\.


--
-- Data for Name: order_items_order_lnk; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.order_items_order_lnk (id, order_item_id, order_id, order_item_ord) FROM stdin;
\.


--
-- Data for Name: order_items_product_lnk; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.order_items_product_lnk (id, order_item_id, product_id, order_item_ord) FROM stdin;
\.


--
-- Data for Name: order_shipments; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.order_shipments (id, document_id, courier_name, tracking_number, tracking_url, shipped_at, delivered_at, notes, created_at, updated_at, published_at, created_by_id, updated_by_id, locale) FROM stdin;
\.


--
-- Data for Name: order_shipments_order_lnk; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.order_shipments_order_lnk (id, order_shipment_id, order_id) FROM stdin;
\.


--
-- Data for Name: orders; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.orders (id, document_id, guest_name, guest_email, guest_phone, status, subtotal, discount, tax, shipping_amount, total, rzp_order_id, rzp_payment_id, rzp_signature, payment_status, payment_method, refund_id, refund_status, refund_amount, shipping_address, billing_address, notes, legacy_id, created_at, updated_at, published_at, created_by_id, updated_by_id, locale) FROM stdin;
\.


--
-- Data for Name: orders_coupon_lnk; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.orders_coupon_lnk (id, order_id, coupon_code_id, order_ord) FROM stdin;
\.


--
-- Data for Name: orders_user_lnk; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.orders_user_lnk (id, order_id, user_id, order_ord) FROM stdin;
\.


--
-- Data for Name: password_reset_tokens; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.password_reset_tokens (id, document_id, token, expires_at, created_at, updated_at, published_at, created_by_id, updated_by_id, locale) FROM stdin;
\.


--
-- Data for Name: password_reset_tokens_user_lnk; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.password_reset_tokens_user_lnk (id, password_reset_token_id, user_id, password_reset_token_ord) FROM stdin;
\.


--
-- Data for Name: popups; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.popups (id, document_id, title, content, image_url, link_url, trigger_type, trigger_value, show_on_pages, frequency, start_date, end_date, is_active, created_at, updated_at, published_at, created_by_id, updated_by_id, locale) FROM stdin;
\.


--
-- Data for Name: product_categories; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.product_categories (id, document_id, name, slug, sort_order, created_at, updated_at, published_at, created_by_id, updated_by_id, locale) FROM stdin;
1	unty0kbhyt96njggwda8e7dr	Bracelet	bracelet	1	2026-03-30 17:21:59.816	2026-03-30 17:21:59.816	2026-03-30 17:21:59.812	\N	\N	\N
2	cjp4cqkv4rzx4qw963uor2i2	Tumbles	tumbles	2	2026-03-30 17:21:59.834	2026-03-30 17:21:59.834	2026-03-30 17:21:59.831	\N	\N	\N
3	boolu5z95lw07krdmwq2i42r	Pyramid	pyramid	3	2026-03-30 17:21:59.846	2026-03-30 17:21:59.846	2026-03-30 17:21:59.843	\N	\N	\N
4	ayrsqlt31yjlm3xsl41eth2m	Locket	locket	4	2026-03-30 17:21:59.855	2026-03-30 17:21:59.855	2026-03-30 17:21:59.854	\N	\N	\N
5	vvwui3mybavy17ynrqw5q1mb	Combo	combo	5	2026-03-30 17:21:59.868	2026-03-30 17:21:59.868	2026-03-30 17:21:59.865	\N	\N	\N
6	mo2pb2xrcq8n793fwlfgmjtu	Other	other	6	2026-03-30 17:21:59.879	2026-03-30 17:21:59.879	2026-03-30 17:21:59.877	\N	\N	\N
\.


--
-- Data for Name: product_variants; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.product_variants (id, document_id, name, options, created_at, updated_at, published_at, created_by_id, updated_by_id, locale) FROM stdin;
\.


--
-- Data for Name: product_variants_product_lnk; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.product_variants_product_lnk (id, product_variant_id, product_id, product_variant_ord) FROM stdin;
\.


--
-- Data for Name: products; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.products (id, document_id, name, slug, description, product_type, price, sale_price, stock, images, healing_properties, wear_hand, hsn_code, gst_rate_bps, is_active, created_at, updated_at, published_at, created_by_id, updated_by_id, locale) FROM stdin;
1	saw9yojk2ayswm18dlz1cfmt	7 Chakra Locket	7-chakra-locketoverall-health	Healing crystal product: 7 Chakra Locket. From The Blissful Soul.	PHYSICAL	199900	119900	35	["https://bm3.bad.myftpupload.com/wp-content/uploads/2025/09/1-19.webp", "https://bm3.bad.myftpupload.com/wp-content/uploads/2025/09/2-16.webp", "https://bm3.bad.myftpupload.com/wp-content/uploads/2025/09/3-16.webp", "https://bm3.bad.myftpupload.com/wp-content/uploads/2025/09/4-9.webp"]	\N	\N	7117	300	t	2026-03-30 17:21:59.914	2026-03-30 17:21:59.914	2026-03-30 17:21:59.899	\N	\N	\N
2	ovze42mb922ltrr9g8ie0lcz	Amethyst Natural Bracelet	amethyst-natural-bracelet	Healing crystal product: Amethyst Natural Bracelet. From The Blissful Soul.	PHYSICAL	199900	99900	60	["https://bm3.bad.myftpupload.com/wp-content/uploads/2025/09/2-21.webp", "https://bm3.bad.myftpupload.com/wp-content/uploads/2025/09/1-25.webp"]	\N	\N	7117	300	t	2026-03-30 17:21:59.964	2026-03-30 17:21:59.964	2026-03-30 17:21:59.946	\N	\N	\N
3	vmwgu9eaxmhjwmsuhd3nc5xc	Amethyst Tumbles	amethyst-tumbles-peace-and-anxiety	Healing crystal product: Amethyst Tumbles. From The Blissful Soul.	PHYSICAL	99900	29900	120	["https://bm3.bad.myftpupload.com/wp-content/uploads/2025/09/1-6.webp", "https://bm3.bad.myftpupload.com/wp-content/uploads/2025/09/2-6.webp", "https://bm3.bad.myftpupload.com/wp-content/uploads/2025/09/3-6.webp"]	\N	\N	7117	300	t	2026-03-30 17:21:59.999	2026-03-30 17:21:59.999	2026-03-30 17:21:59.987	\N	\N	\N
4	ohnxriikjj6iai5abaelxha5	Black Obsidian Natural Bracelet	black-obsidian-natural-bracelet	Healing crystal product: Black Obsidian Natural Bracelet. From The Blissful Soul.	PHYSICAL	199900	149900	50	["https://bm3.bad.myftpupload.com/wp-content/uploads/2025/09/1-18.webp", "https://bm3.bad.myftpupload.com/wp-content/uploads/2025/09/2-15.webp", "https://bm3.bad.myftpupload.com/wp-content/uploads/2025/09/3-15.webp", "https://bm3.bad.myftpupload.com/wp-content/uploads/2025/09/4-8.webp"]	\N	\N	7117	300	t	2026-03-30 17:22:00.041	2026-03-30 17:22:00.041	2026-03-30 17:22:00.026	\N	\N	\N
5	frimm59a5kfdojgngnrg1tyz	Black Obsidian Pencil Locket	black-obsidian-pencil-locketevil-eye-and-nazar	Healing crystal product: Black Obsidian Pencil Locket. From The Blissful Soul.	PHYSICAL	199900	69900	40	["https://bm3.bad.myftpupload.com/wp-content/uploads/2025/09/2-14.webp", "https://bm3.bad.myftpupload.com/wp-content/uploads/2025/09/1-17.webp"]	\N	\N	7117	300	t	2026-03-30 17:22:00.078	2026-03-30 17:22:00.078	2026-03-30 17:22:00.068	\N	\N	\N
6	pqn8ebmfovhycdve409eifl1	Black Obsidian Pyramid	black-obsidian-pyramid	Healing crystal product: Black Obsidian Pyramid. From The Blissful Soul.	PHYSICAL	199900	99900	40	["https://bm3.bad.myftpupload.com/wp-content/uploads/2025/09/3-17.webp", "https://bm3.bad.myftpupload.com/wp-content/uploads/2025/09/1-20.webp", "https://bm3.bad.myftpupload.com/wp-content/uploads/2025/09/2-17.webp"]	\N	\N	7117	300	t	2026-03-30 17:22:00.108	2026-03-30 17:22:00.108	2026-03-30 17:22:00.095	\N	\N	\N
7	mjs9b0hr9ap2hw2tw1tha04z	Black Obsidian Tumbles	black-obsidian-tumbles-negativity-evil-eye	Healing crystal product: Black Obsidian Tumbles. From The Blissful Soul.	PHYSICAL	99900	29900	120	["https://bm3.bad.myftpupload.com/wp-content/uploads/2025/09/1-5.webp", "https://bm3.bad.myftpupload.com/wp-content/uploads/2025/09/2-5.webp", "https://bm3.bad.myftpupload.com/wp-content/uploads/2025/09/3-5.webp", "https://bm3.bad.myftpupload.com/wp-content/uploads/2025/09/4-3.webp"]	\N	\N	7117	300	t	2026-03-30 17:22:00.141	2026-03-30 17:22:00.141	2026-03-30 17:22:00.13	\N	\N	\N
8	x68n63yxcwcsof9z2iyx8mlf	Citrine Bracelet	citrine-braceletmoney-and-growth	Healing crystal product: Citrine Bracelet. From The Blissful Soul.	PHYSICAL	199900	141900	40	["https://bm3.bad.myftpupload.com/wp-content/uploads/2025/09/1-24.webp", "https://bm3.bad.myftpupload.com/wp-content/uploads/2025/09/2-20.webp", "https://bm3.bad.myftpupload.com/wp-content/uploads/2025/09/3-20.webp"]	\N	\N	7117	300	t	2026-03-30 17:22:00.18	2026-03-30 17:22:00.18	2026-03-30 17:22:00.166	\N	\N	\N
9	zxqli2kdh61wn6l1o1nq3blw	Crystal Charger ÔÇô Selenite Plate	crystal-charger-selenite-plate	Healing crystal product: Crystal Charger ÔÇô Selenite Plate. From The Blissful Soul.	PHYSICAL	199900	59900	40	["https://bm3.bad.myftpupload.com/wp-content/uploads/2025/09/1-27.webp"]	\N	\N	7117	300	t	2026-03-30 17:22:00.206	2026-03-30 17:22:00.206	2026-03-30 17:22:00.199	\N	\N	\N
10	l0g3fx8qod4lxcax2r2qe9tu	Genie Bracelet	genie-bracelet	Healing crystal product: Genie Bracelet. From The Blissful Soul.	PHYSICAL	99900	49900	90	["https://bm3.bad.myftpupload.com/wp-content/uploads/2025/09/1-12.webp", "https://bm3.bad.myftpupload.com/wp-content/uploads/2025/09/2-11.webp", "https://bm3.bad.myftpupload.com/wp-content/uploads/2025/09/3-13.webp"]	\N	\N	7117	300	t	2026-03-30 17:22:00.235	2026-03-30 17:22:00.235	2026-03-30 17:22:00.222	\N	\N	\N
11	bjikaau6c8ek0aiiorcf2a4f	Healing sea salt	healing-sea-salt	Healing crystal product: Healing Sea Salt. From The Blissful Soul.	PHYSICAL	77700	29900	150	["https://bm3.bad.myftpupload.com/wp-content/uploads/2025/09/2-18.webp", "https://bm3.bad.myftpupload.com/wp-content/uploads/2025/09/1-21-e1757325863584.webp", "https://bm3.bad.myftpupload.com/wp-content/uploads/2025/09/3-18.webp"]	\N	\N	7117	300	t	2026-03-30 17:22:00.262	2026-03-30 17:22:00.262	2026-03-30 17:22:00.251	\N	\N	\N
12	r76luqubvbb1dpkmeyhh8mk9	Master's Wish Box	masters-wish-box-manifest-all-desires	Healing crystal product: Master's Wish Box. From The Blissful Soul.	PHYSICAL	249900	149900	25	["https://bm3.bad.myftpupload.com/wp-content/uploads/2025/09/1-11.webp", "https://bm3.bad.myftpupload.com/wp-content/uploads/2025/09/2-10.webp", "https://bm3.bad.myftpupload.com/wp-content/uploads/2025/09/3-12.webp", "https://bm3.bad.myftpupload.com/wp-content/uploads/2025/09/4-7.webp"]	\N	\N	7117	300	t	2026-03-30 17:22:00.287	2026-03-30 17:22:00.287	2026-03-30 17:22:00.277	\N	\N	\N
13	iu3hawnt9m88g5nga3ox2445	Money Magnet	money-magnet	Healing crystal product: Money Magnet. From The Blissful Soul.	PHYSICAL	199900	99900	100	["https://bm3.bad.myftpupload.com/wp-content/uploads/2025/09/2-3.webp", "https://bm3.bad.myftpupload.com/wp-content/uploads/2025/09/5.webp", "https://bm3.bad.myftpupload.com/wp-content/uploads/2025/09/4-1.webp", "https://bm3.bad.myftpupload.com/wp-content/uploads/2025/09/3-2.webp", "https://bm3.bad.myftpupload.com/wp-content/uploads/2025/09/1-3.webp"]	\N	\N	7117	300	t	2026-03-30 17:22:00.319	2026-03-30 17:22:00.319	2026-03-30 17:22:00.307	\N	\N	\N
14	rksn9tgxcxvthzec76u63mil	Money Potli (Gift)	money-potli-gift	Complimentary gift on qualifying orders.	PHYSICAL	0	\N	9999	["https://bm3.bad.myftpupload.com/wp-content/uploads/2025/09/4.webp"]	\N	\N	7117	300	t	2026-03-30 17:22:00.348	2026-03-30 17:22:00.348	2026-03-30 17:22:00.338	\N	\N	\N
15	e2568a1bmkg59s5mmx3440wm	Money Pyramid	money-pyramid	Healing crystal product: Money Pyramid. From The Blissful Soul.	PHYSICAL	199900	99900	80	["https://bm3.bad.myftpupload.com/wp-content/uploads/2025/09/1-12-768x768.webp", "https://bm3.bad.myftpupload.com/wp-content/uploads/2025/09/4.webp", "https://bm3.bad.myftpupload.com/wp-content/uploads/2025/09/3.webp", "https://bm3.bad.myftpupload.com/wp-content/uploads/2025/09/2-1.webp", "https://bm3.bad.myftpupload.com/wp-content/uploads/2025/09/1-1.webp"]	\N	\N	7117	300	t	2026-03-30 17:22:00.374	2026-03-30 17:22:00.374	2026-03-30 17:22:00.363	\N	\N	\N
16	ih1yjjdoja4wkihstygmeylt	Money Pyramid & Selenite Plate Combo	money-pyramid-selenite-charging-plate-combo	Healing crystal product: Money Pyramid & Selenite Plate Combo. From The Blissful Soul.	PHYSICAL	599900	191900	50	["https://bm3.bad.myftpupload.com/wp-content/uploads/2025/09/1-3-800x800.webp", "https://bm3.bad.myftpupload.com/wp-content/uploads/2025/09/4.webp"]	\N	\N	7117	300	t	2026-03-30 17:22:00.403	2026-03-30 17:22:00.403	2026-03-30 17:22:00.395	\N	\N	\N
17	z4r70gzfpfadp5vh7bz71ek9	Pregnancy & Health Bracelet	pregnancy-health-bracelet	Healing crystal product: Pregnancy & Health Bracelet. From The Blissful Soul.	PHYSICAL	149900	\N	20	["https://bm3.bad.myftpupload.com/wp-content/uploads/2025/09/1-15.webp", "https://bm3.bad.myftpupload.com/wp-content/uploads/2025/09/2-13.webp"]	\N	\N	7117	300	t	2026-03-30 17:22:00.426	2026-03-30 17:22:00.426	2026-03-30 17:22:00.418	\N	\N	\N
18	kbsjk8bygo3fi4rqbh3ydlsp	Pyrite Money Keychain (1 pc)	pyrite-money-keychain-1-piece-assorted	Healing crystal product: Pyrite Money Keychain (1 pc). From The Blissful Soul.	PHYSICAL	99900	45900	100	["https://bm3.bad.myftpupload.com/wp-content/uploads/2025/09/1-e1757322710183.webp", "https://bm3.bad.myftpupload.com/wp-content/uploads/2025/09/2-e1757322736665.webp"]	\N	\N	7117	300	t	2026-03-30 17:22:00.451	2026-03-30 17:22:00.451	2026-03-30 17:22:00.441	\N	\N	\N
21	mxz5xbjaqea26obajit5ely0	Riche Rich	riche-rich	Healing crystal product: Riche Rich. From The Blissful Soul.	PHYSICAL	199900	149900	30	["https://bm3.bad.myftpupload.com/wp-content/uploads/2025/09/photo-4.png", "https://bm3.bad.myftpupload.com/wp-content/uploads/2025/09/5-1.webp", "https://bm3.bad.myftpupload.com/wp-content/uploads/2025/09/4-5.webp", "https://bm3.bad.myftpupload.com/wp-content/uploads/2025/09/2-8.webp", "https://bm3.bad.myftpupload.com/wp-content/uploads/2025/09/3-10.webp"]	\N	\N	7117	300	t	2026-03-30 17:22:00.517	2026-03-30 17:22:00.517	2026-03-30 17:22:00.508	\N	\N	\N
24	ouzeeqfvv6onxmhhbx084mjj	Rose Quartz Pyramid	rose-quartz-pyramid	Healing crystal product: Rose Quartz Pyramid. From The Blissful Soul.	PHYSICAL	199900	99900	45	["https://bm3.bad.myftpupload.com/wp-content/uploads/2025/09/3-3.webp", "https://bm3.bad.myftpupload.com/wp-content/uploads/2025/09/1-4.webp", "https://bm3.bad.myftpupload.com/wp-content/uploads/2025/09/2-4.webp", "https://bm3.bad.myftpupload.com/wp-content/uploads/2025/09/4-2.webp"]	\N	\N	7117	300	t	2026-03-30 17:22:00.586	2026-03-30 17:22:00.586	2026-03-30 17:22:00.578	\N	\N	\N
27	uqrliw147gl0kr1qp6hjfm4g	Tiger Eye Locket	tiger-eye-locketself-esteem-and-confidence	Healing crystal product: Tiger Eye Locket. From The Blissful Soul.	PHYSICAL	199900	119900	30	["https://bm3.bad.myftpupload.com/wp-content/uploads/2025/09/1-22.webp"]	\N	\N	7117	300	t	2026-03-30 17:22:00.665	2026-03-30 17:22:00.665	2026-03-30 17:22:00.656	\N	\N	\N
19	dvojy9pe0egr68bn2v1icx0n	Pyrite Natural Bracelet	pyrite-natural-bracelet	Healing crystal product: Pyrite Natural Bracelet. From The Blissful Soul.	PHYSICAL	199900	149900	35	["https://bm3.bad.myftpupload.com/wp-content/uploads/2025/09/3-8.webp", "https://bm3.bad.myftpupload.com/wp-content/uploads/2025/09/1-8.webp", "https://bm3.bad.myftpupload.com/wp-content/uploads/2025/09/3-9.webp", "https://bm3.bad.myftpupload.com/wp-content/uploads/2025/09/4-4.webp"]	\N	\N	7117	300	t	2026-03-30 17:22:00.474	2026-03-30 17:22:00.474	2026-03-30 17:22:00.465	\N	\N	\N
22	oyf1qcwtjiqqm6mqamr8lh5l	Rose Quartz Natural Bracelet	rose-quartz-natural-bracelet	Healing crystal product: Rose Quartz Natural Bracelet. From The Blissful Soul.	PHYSICAL	199900	99900	60	["https://bm3.bad.myftpupload.com/wp-content/uploads/2025/09/2-22.webp", "https://bm3.bad.myftpupload.com/wp-content/uploads/2025/09/1-26.webp", "https://bm3.bad.myftpupload.com/wp-content/uploads/2025/09/4-11.webp", "https://bm3.bad.myftpupload.com/wp-content/uploads/2025/09/5-4.webp"]	\N	\N	7117	300	t	2026-03-30 17:22:00.541	2026-03-30 17:22:00.541	2026-03-30 17:22:00.534	\N	\N	\N
25	jzn3vgmtxezgddiwss43n5kb	Rose Quartz Tumbles	rose-quartz-tumbles-love-relationships	Healing crystal product: Rose Quartz Tumbles. From The Blissful Soul.	PHYSICAL	99900	29900	120	["https://bm3.bad.myftpupload.com/wp-content/uploads/2025/09/1-7.webp", "https://bm3.bad.myftpupload.com/wp-content/uploads/2025/09/2-7.webp", "https://bm3.bad.myftpupload.com/wp-content/uploads/2025/09/3-7.webp"]	\N	\N	7117	300	t	2026-03-30 17:22:00.608	2026-03-30 17:22:00.608	2026-03-30 17:22:00.599	\N	\N	\N
28	a6lx3o2w1mt5pe4kg06s1hng	Tiger Eye Natural Bracelet	tiger-eye-natural-bracelet	Healing crystal product: Tiger Eye Natural Bracelet. From The Blissful Soul.	PHYSICAL	199900	127900	35	["https://bm3.bad.myftpupload.com/wp-content/uploads/2025/09/5-3.webp", "https://bm3.bad.myftpupload.com/wp-content/uploads/2025/09/1-23.webp", "https://bm3.bad.myftpupload.com/wp-content/uploads/2025/09/2-19.webp", "https://bm3.bad.myftpupload.com/wp-content/uploads/2025/09/3-19.webp", "https://bm3.bad.myftpupload.com/wp-content/uploads/2025/09/4-10.webp", "https://bm3.bad.myftpupload.com/wp-content/uploads/2025/09/6.webp"]	\N	\N	7117	300	t	2026-03-30 17:22:00.688	2026-03-30 17:22:00.688	2026-03-30 17:22:00.679	\N	\N	\N
20	dj8zinoav9nhixoon7y8opxc	Red Jasper Natural Bracelet	red-jasper-natural-bracelet	Healing crystal product: Red Jasper Natural Bracelet. From The Blissful Soul.	PHYSICAL	199900	149900	40	["https://bm3.bad.myftpupload.com/wp-content/uploads/2025/09/1-14.webp", "https://bm3.bad.myftpupload.com/wp-content/uploads/2025/09/2-12.webp", "https://bm3.bad.myftpupload.com/wp-content/uploads/2025/09/3-14.webp"]	\N	\N	7117	300	t	2026-03-30 17:22:00.495	2026-03-30 17:22:00.495	2026-03-30 17:22:00.488	\N	\N	\N
23	urnngf3cwuuiqqb3iflr4n67	Rose Quartz Pencil Locket	rose-quartz-pencil-locketself-love-and-relationship	Healing crystal product: Rose Quartz Pencil Locket. From The Blissful Soul.	PHYSICAL	199900	69900	40	["https://bm3.bad.myftpupload.com/wp-content/uploads/2025/09/photo-5.png"]	\N	\N	7117	300	t	2026-03-30 17:22:00.563	2026-03-30 17:22:00.563	2026-03-30 17:22:00.555	\N	\N	\N
26	cj7vot5x9l9g88zavejvtrie	Sage Sticks	sage-sticks-negativity-removal	Healing crystal product: Sage Sticks. From The Blissful Soul.	PHYSICAL	99900	49900	200	["https://bm3.bad.myftpupload.com/wp-content/uploads/2025/09/1-10.webp", "https://bm3.bad.myftpupload.com/wp-content/uploads/2025/09/2-9.webp", "https://bm3.bad.myftpupload.com/wp-content/uploads/2025/09/3-11.webp", "https://bm3.bad.myftpupload.com/wp-content/uploads/2025/09/4-6.webp", "https://bm3.bad.myftpupload.com/wp-content/uploads/2025/09/5-2.webp"]	\N	\N	7117	300	t	2026-03-30 17:22:00.637	2026-03-30 17:22:00.637	2026-03-30 17:22:00.628	\N	\N	\N
\.


--
-- Data for Name: products_category_lnk; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.products_category_lnk (id, product_id, product_category_id, product_ord) FROM stdin;
1	1	4	1
2	2	1	1
3	3	2	1
4	4	1	2
5	5	4	2
6	6	3	1
7	7	2	2
8	8	1	3
9	9	6	1
10	10	1	4
11	11	6	2
12	12	6	3
13	13	1	5
14	14	6	4
15	15	3	2
16	16	5	1
17	17	1	6
18	18	6	5
19	19	1	7
20	20	1	8
21	21	1	9
22	22	1	10
23	23	4	3
24	24	3	3
25	25	2	3
26	26	6	6
27	27	4	4
28	28	1	11
\.


--
-- Data for Name: products_shipping_class_lnk; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.products_shipping_class_lnk (id, product_id, shipping_class_id, product_ord) FROM stdin;
1	1	1	1
2	2	1	2
3	3	1	3
4	4	1	4
5	5	1	5
6	6	1	6
7	7	1	7
8	8	1	8
9	9	1	9
10	10	1	10
11	11	1	11
12	12	1	12
13	13	1	13
14	14	1	14
15	15	1	15
16	16	1	16
17	17	1	17
18	18	1	18
19	19	1	19
20	20	1	20
21	21	1	21
22	22	1	22
23	23	1	23
24	24	1	24
25	25	1	25
26	26	1	26
27	27	1	27
28	28	1	28
\.


--
-- Data for Name: promo_rules; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.promo_rules (id, document_id, type, config, is_active, created_at, updated_at, published_at, created_by_id, updated_by_id, locale) FROM stdin;
\.


--
-- Data for Name: reviews; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.reviews (id, document_id, rating, comment, created_at, updated_at, published_at, created_by_id, updated_by_id, locale) FROM stdin;
\.


--
-- Data for Name: reviews_product_lnk; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.reviews_product_lnk (id, review_id, product_id, review_ord) FROM stdin;
\.


--
-- Data for Name: reviews_user_lnk; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.reviews_user_lnk (id, review_id, user_id, review_ord) FROM stdin;
\.


--
-- Data for Name: scheduled_reminders; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.scheduled_reminders (id, document_id, reminder_type, scheduled_for, sent, sent_at, created_at, updated_at, published_at, created_by_id, updated_by_id, locale) FROM stdin;
\.


--
-- Data for Name: scheduled_reminders_booking_lnk; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.scheduled_reminders_booking_lnk (id, scheduled_reminder_id, booking_id, scheduled_reminder_ord) FROM stdin;
\.


--
-- Data for Name: services; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.services (id, document_id, name, type, price, duration_minutes, staff_id, buffer_minutes, is_active, description, created_at, updated_at, published_at, created_by_id, updated_by_id, locale) FROM stdin;
1	zqfne4m0n5946p99v74qbq3x	All-in-1 Astrology	VIDEO	449900	40	\N	10	t	All-in-1 Astrology ÔÇö VIDEO session	2026-03-30 17:22:00.707	2026-03-30 17:22:00.707	2026-03-30 17:22:00.706	\N	\N	\N
2	s7axjz1yaiixve8tqnk3wnhg	All-in-1 Astrology	AUDIO	349900	40	\N	10	t	All-in-1 Astrology ÔÇö AUDIO session	2026-03-30 17:22:00.718	2026-03-30 17:22:00.718	2026-03-30 17:22:00.716	\N	\N	\N
3	a9hl0e4fpu367nayuecwgyym	Kundali Session	VIDEO	250000	30	\N	10	t	Kundali Session ÔÇö VIDEO session	2026-03-30 17:22:00.728	2026-03-30 17:22:00.728	2026-03-30 17:22:00.726	\N	\N	\N
4	hlbi58vlyyi4lrwdvtzy97we	Kundali Session	AUDIO	149900	30	\N	10	t	Kundali Session ÔÇö AUDIO session	2026-03-30 17:22:00.737	2026-03-30 17:22:00.737	2026-03-30 17:22:00.736	\N	\N	\N
5	tsvwgf50rjlh2qs9zwvo3d4u	Tarot Reading	VIDEO	250000	30	\N	10	t	Tarot Reading ÔÇö VIDEO session	2026-03-30 17:22:00.748	2026-03-30 17:22:00.748	2026-03-30 17:22:00.747	\N	\N	\N
6	rekmlss9759uwt4za6wby5fa	Tarot Reading	AUDIO	99900	20	\N	10	t	Tarot Reading ÔÇö AUDIO session	2026-03-30 17:22:00.757	2026-03-30 17:22:00.757	2026-03-30 17:22:00.756	\N	\N	\N
7	jc3qao72v1llw36za15qzj6x	Tarot Reading	AUDIO	149900	30	\N	10	t	Tarot Reading ÔÇö AUDIO session	2026-03-30 17:22:00.767	2026-03-30 17:22:00.767	2026-03-30 17:22:00.766	\N	\N	\N
8	u7211ebslvj09e4s3ykwqgj4	Therapy & Counselling Sessions	VIDEO	129900	40	\N	10	t	Therapy & Counselling Sessions ÔÇö VIDEO session	2026-03-30 17:22:00.776	2026-03-30 17:22:00.776	2026-03-30 17:22:00.775	\N	\N	\N
9	u183h1ba52ilh5ppazwoli74	Therapy & Counselling Sessions	AUDIO	99900	35	\N	10	t	Therapy & Counselling Sessions ÔÇö AUDIO session	2026-03-30 17:22:00.786	2026-03-30 17:22:00.786	2026-03-30 17:22:00.785	\N	\N	\N
\.


--
-- Data for Name: shipping_classes; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.shipping_classes (id, document_id, name, rate, free_above, description, created_at, updated_at, published_at, created_by_id, updated_by_id, locale) FROM stdin;
1	dn4h5cny7wd0il4gqy5kmt91	Standard (Free)	0	\N	Free shipping	2026-03-30 17:21:59.772	2026-03-30 17:21:59.772	2026-03-30 17:21:59.758	\N	\N	\N
2	h0uuannrc6iidjck98y8lmjg	Standard (Paid)	9900	150000	Flat rate under order value	2026-03-30 17:21:59.796	2026-03-30 17:21:59.796	2026-03-30 17:21:59.794	\N	\N	\N
\.


--
-- Data for Name: strapi_ai_localization_jobs; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.strapi_ai_localization_jobs (id, content_type, related_document_id, source_locale, target_locales, status, created_at, updated_at) FROM stdin;
\.


--
-- Data for Name: strapi_ai_metadata_jobs; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.strapi_ai_metadata_jobs (id, status, created_at, completed_at) FROM stdin;
\.


--
-- Data for Name: strapi_api_token_permissions; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.strapi_api_token_permissions (id, document_id, action, created_at, updated_at, published_at, created_by_id, updated_by_id, locale) FROM stdin;
\.


--
-- Data for Name: strapi_api_token_permissions_token_lnk; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.strapi_api_token_permissions_token_lnk (id, api_token_permission_id, api_token_id, api_token_permission_ord) FROM stdin;
\.


--
-- Data for Name: strapi_api_tokens; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.strapi_api_tokens (id, document_id, name, description, type, access_key, encrypted_key, last_used_at, expires_at, lifespan, created_at, updated_at, published_at, created_by_id, updated_by_id, locale) FROM stdin;
1	ftzpam27zbfxgvtv3holw93e	Read Only	A default API token with read-only permissions, only used for accessing resources	read-only	dd93252f1743a57ba0184ef67cf3366532f587b9ce612e4933c9828c57f14e00c0cf3e8330d97894bbf7eb34309b950cb9b459a7d482023db1e10d180ac531a8	\N	\N	\N	\N	2026-03-27 06:07:53.129	2026-03-27 06:07:53.129	2026-03-27 06:07:53.129	\N	\N	\N
2	u0rks8cyiuo8lhergmf2pgbv	Full Access	A default API token with full access permissions, used for accessing or modifying resources	full-access	20ec4d95f948bf019a3e6753aeab3eb6379e7df5fa13c6ff30d1ad86d664f1d376cd3695a5d901b4abcbe99aaf2207d2d9527940780b4dde26f9d051fee5412e	\N	\N	\N	\N	2026-03-27 06:07:53.139	2026-03-27 06:07:53.139	2026-03-27 06:07:53.139	\N	\N	\N
\.


--
-- Data for Name: strapi_core_store_settings; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.strapi_core_store_settings (id, key, value, type, environment, tag) FROM stdin;
1	strapi_unidirectional-join-table-repair-ran	true	boolean	\N	\N
3	plugin_content_manager_configuration_content_types::plugin::upload.file	{"settings":{"bulkable":true,"filterable":true,"searchable":true,"pageSize":10,"relationOpenMode":"modal","mainField":"name","defaultSortBy":"name","defaultSortOrder":"ASC"},"metadatas":{"id":{"edit":{},"list":{"label":"id","searchable":true,"sortable":true}},"name":{"edit":{"label":"name","description":"","placeholder":"","visible":true,"editable":true},"list":{"label":"name","searchable":true,"sortable":true}},"alternativeText":{"edit":{"label":"alternativeText","description":"","placeholder":"","visible":true,"editable":true},"list":{"label":"alternativeText","searchable":true,"sortable":true}},"caption":{"edit":{"label":"caption","description":"","placeholder":"","visible":true,"editable":true},"list":{"label":"caption","searchable":true,"sortable":true}},"focalPoint":{"edit":{"label":"focalPoint","description":"","placeholder":"","visible":true,"editable":true},"list":{"label":"focalPoint","searchable":false,"sortable":false}},"width":{"edit":{"label":"width","description":"","placeholder":"","visible":true,"editable":true},"list":{"label":"width","searchable":true,"sortable":true}},"height":{"edit":{"label":"height","description":"","placeholder":"","visible":true,"editable":true},"list":{"label":"height","searchable":true,"sortable":true}},"formats":{"edit":{"label":"formats","description":"","placeholder":"","visible":true,"editable":true},"list":{"label":"formats","searchable":false,"sortable":false}},"hash":{"edit":{"label":"hash","description":"","placeholder":"","visible":true,"editable":true},"list":{"label":"hash","searchable":true,"sortable":true}},"ext":{"edit":{"label":"ext","description":"","placeholder":"","visible":true,"editable":true},"list":{"label":"ext","searchable":true,"sortable":true}},"mime":{"edit":{"label":"mime","description":"","placeholder":"","visible":true,"editable":true},"list":{"label":"mime","searchable":true,"sortable":true}},"size":{"edit":{"label":"size","description":"","placeholder":"","visible":true,"editable":true},"list":{"label":"size","searchable":true,"sortable":true}},"url":{"edit":{"label":"url","description":"","placeholder":"","visible":true,"editable":true},"list":{"label":"url","searchable":true,"sortable":true}},"previewUrl":{"edit":{"label":"previewUrl","description":"","placeholder":"","visible":true,"editable":true},"list":{"label":"previewUrl","searchable":true,"sortable":true}},"provider":{"edit":{"label":"provider","description":"","placeholder":"","visible":true,"editable":true},"list":{"label":"provider","searchable":true,"sortable":true}},"provider_metadata":{"edit":{"label":"provider_metadata","description":"","placeholder":"","visible":true,"editable":true},"list":{"label":"provider_metadata","searchable":false,"sortable":false}},"folder":{"edit":{"label":"folder","description":"","placeholder":"","visible":true,"editable":true,"mainField":"name"},"list":{"label":"folder","searchable":true,"sortable":true}},"folderPath":{"edit":{"label":"folderPath","description":"","placeholder":"","visible":true,"editable":true},"list":{"label":"folderPath","searchable":true,"sortable":true}},"createdAt":{"edit":{"label":"createdAt","description":"","placeholder":"","visible":false,"editable":true},"list":{"label":"createdAt","searchable":true,"sortable":true}},"updatedAt":{"edit":{"label":"updatedAt","description":"","placeholder":"","visible":false,"editable":true},"list":{"label":"updatedAt","searchable":true,"sortable":true}},"createdBy":{"edit":{"label":"createdBy","description":"","placeholder":"","visible":false,"editable":true,"mainField":"firstname"},"list":{"label":"createdBy","searchable":true,"sortable":true}},"updatedBy":{"edit":{"label":"updatedBy","description":"","placeholder":"","visible":false,"editable":true,"mainField":"firstname"},"list":{"label":"updatedBy","searchable":true,"sortable":true}},"documentId":{"edit":{},"list":{"label":"documentId","searchable":true,"sortable":true}}},"layouts":{"list":["id","name","alternativeText","caption"],"edit":[[{"name":"name","size":6},{"name":"alternativeText","size":6}],[{"name":"caption","size":6}],[{"name":"focalPoint","size":12}],[{"name":"width","size":4},{"name":"height","size":4}],[{"name":"formats","size":12}],[{"name":"hash","size":6},{"name":"ext","size":6}],[{"name":"mime","size":6},{"name":"size","size":4}],[{"name":"url","size":6},{"name":"previewUrl","size":6}],[{"name":"provider","size":6}],[{"name":"provider_metadata","size":12}],[{"name":"folder","size":6},{"name":"folderPath","size":6}]]},"uid":"plugin::upload.file"}	object	\N	\N
4	plugin_content_manager_configuration_content_types::plugin::i18n.locale	{"settings":{"bulkable":true,"filterable":true,"searchable":true,"pageSize":10,"relationOpenMode":"modal","mainField":"name","defaultSortBy":"name","defaultSortOrder":"ASC"},"metadatas":{"id":{"edit":{},"list":{"label":"id","searchable":true,"sortable":true}},"name":{"edit":{"label":"name","description":"","placeholder":"","visible":true,"editable":true},"list":{"label":"name","searchable":true,"sortable":true}},"code":{"edit":{"label":"code","description":"","placeholder":"","visible":true,"editable":true},"list":{"label":"code","searchable":true,"sortable":true}},"createdAt":{"edit":{"label":"createdAt","description":"","placeholder":"","visible":false,"editable":true},"list":{"label":"createdAt","searchable":true,"sortable":true}},"updatedAt":{"edit":{"label":"updatedAt","description":"","placeholder":"","visible":false,"editable":true},"list":{"label":"updatedAt","searchable":true,"sortable":true}},"createdBy":{"edit":{"label":"createdBy","description":"","placeholder":"","visible":false,"editable":true,"mainField":"firstname"},"list":{"label":"createdBy","searchable":true,"sortable":true}},"updatedBy":{"edit":{"label":"updatedBy","description":"","placeholder":"","visible":false,"editable":true,"mainField":"firstname"},"list":{"label":"updatedBy","searchable":true,"sortable":true}},"documentId":{"edit":{},"list":{"label":"documentId","searchable":true,"sortable":true}}},"layouts":{"list":["id","name","code","createdAt"],"edit":[[{"name":"name","size":6},{"name":"code","size":6}]]},"uid":"plugin::i18n.locale"}	object	\N	\N
5	plugin_content_manager_configuration_content_types::plugin::content-releases.release	{"settings":{"bulkable":true,"filterable":true,"searchable":true,"pageSize":10,"relationOpenMode":"modal","mainField":"name","defaultSortBy":"name","defaultSortOrder":"ASC"},"metadatas":{"id":{"edit":{},"list":{"label":"id","searchable":true,"sortable":true}},"name":{"edit":{"label":"name","description":"","placeholder":"","visible":true,"editable":true},"list":{"label":"name","searchable":true,"sortable":true}},"releasedAt":{"edit":{"label":"releasedAt","description":"","placeholder":"","visible":true,"editable":true},"list":{"label":"releasedAt","searchable":true,"sortable":true}},"scheduledAt":{"edit":{"label":"scheduledAt","description":"","placeholder":"","visible":true,"editable":true},"list":{"label":"scheduledAt","searchable":true,"sortable":true}},"timezone":{"edit":{"label":"timezone","description":"","placeholder":"","visible":true,"editable":true},"list":{"label":"timezone","searchable":true,"sortable":true}},"status":{"edit":{"label":"status","description":"","placeholder":"","visible":true,"editable":true},"list":{"label":"status","searchable":true,"sortable":true}},"actions":{"edit":{"label":"actions","description":"","placeholder":"","visible":true,"editable":true,"mainField":"contentType"},"list":{"label":"actions","searchable":false,"sortable":false}},"createdAt":{"edit":{"label":"createdAt","description":"","placeholder":"","visible":false,"editable":true},"list":{"label":"createdAt","searchable":true,"sortable":true}},"updatedAt":{"edit":{"label":"updatedAt","description":"","placeholder":"","visible":false,"editable":true},"list":{"label":"updatedAt","searchable":true,"sortable":true}},"createdBy":{"edit":{"label":"createdBy","description":"","placeholder":"","visible":false,"editable":true,"mainField":"firstname"},"list":{"label":"createdBy","searchable":true,"sortable":true}},"updatedBy":{"edit":{"label":"updatedBy","description":"","placeholder":"","visible":false,"editable":true,"mainField":"firstname"},"list":{"label":"updatedBy","searchable":true,"sortable":true}},"documentId":{"edit":{},"list":{"label":"documentId","searchable":true,"sortable":true}}},"layouts":{"list":["id","name","releasedAt","scheduledAt"],"edit":[[{"name":"name","size":6},{"name":"releasedAt","size":6}],[{"name":"scheduledAt","size":6},{"name":"timezone","size":6}],[{"name":"status","size":6},{"name":"actions","size":6}]]},"uid":"plugin::content-releases.release"}	object	\N	\N
6	plugin_content_manager_configuration_content_types::plugin::content-releases.release-action	{"settings":{"bulkable":true,"filterable":true,"searchable":true,"pageSize":10,"relationOpenMode":"modal","mainField":"contentType","defaultSortBy":"contentType","defaultSortOrder":"ASC"},"metadatas":{"id":{"edit":{},"list":{"label":"id","searchable":true,"sortable":true}},"type":{"edit":{"label":"type","description":"","placeholder":"","visible":true,"editable":true},"list":{"label":"type","searchable":true,"sortable":true}},"contentType":{"edit":{"label":"contentType","description":"","placeholder":"","visible":true,"editable":true},"list":{"label":"contentType","searchable":true,"sortable":true}},"entryDocumentId":{"edit":{"label":"entryDocumentId","description":"","placeholder":"","visible":true,"editable":true},"list":{"label":"entryDocumentId","searchable":true,"sortable":true}},"release":{"edit":{"label":"release","description":"","placeholder":"","visible":true,"editable":true,"mainField":"name"},"list":{"label":"release","searchable":true,"sortable":true}},"isEntryValid":{"edit":{"label":"isEntryValid","description":"","placeholder":"","visible":true,"editable":true},"list":{"label":"isEntryValid","searchable":true,"sortable":true}},"createdAt":{"edit":{"label":"createdAt","description":"","placeholder":"","visible":false,"editable":true},"list":{"label":"createdAt","searchable":true,"sortable":true}},"updatedAt":{"edit":{"label":"updatedAt","description":"","placeholder":"","visible":false,"editable":true},"list":{"label":"updatedAt","searchable":true,"sortable":true}},"createdBy":{"edit":{"label":"createdBy","description":"","placeholder":"","visible":false,"editable":true,"mainField":"firstname"},"list":{"label":"createdBy","searchable":true,"sortable":true}},"updatedBy":{"edit":{"label":"updatedBy","description":"","placeholder":"","visible":false,"editable":true,"mainField":"firstname"},"list":{"label":"updatedBy","searchable":true,"sortable":true}},"documentId":{"edit":{},"list":{"label":"documentId","searchable":true,"sortable":true}}},"layouts":{"list":["id","type","contentType","entryDocumentId"],"edit":[[{"name":"type","size":6},{"name":"contentType","size":6}],[{"name":"entryDocumentId","size":6},{"name":"release","size":6}],[{"name":"isEntryValid","size":4}]]},"uid":"plugin::content-releases.release-action"}	object	\N	\N
7	plugin_content_manager_configuration_content_types::plugin::review-workflows.workflow	{"settings":{"bulkable":true,"filterable":true,"searchable":true,"pageSize":10,"relationOpenMode":"modal","mainField":"name","defaultSortBy":"name","defaultSortOrder":"ASC"},"metadatas":{"id":{"edit":{},"list":{"label":"id","searchable":true,"sortable":true}},"name":{"edit":{"label":"name","description":"","placeholder":"","visible":true,"editable":true},"list":{"label":"name","searchable":true,"sortable":true}},"stages":{"edit":{"label":"stages","description":"","placeholder":"","visible":true,"editable":true,"mainField":"name"},"list":{"label":"stages","searchable":false,"sortable":false}},"stageRequiredToPublish":{"edit":{"label":"stageRequiredToPublish","description":"","placeholder":"","visible":true,"editable":true,"mainField":"name"},"list":{"label":"stageRequiredToPublish","searchable":true,"sortable":true}},"contentTypes":{"edit":{"label":"contentTypes","description":"","placeholder":"","visible":true,"editable":true},"list":{"label":"contentTypes","searchable":false,"sortable":false}},"createdAt":{"edit":{"label":"createdAt","description":"","placeholder":"","visible":false,"editable":true},"list":{"label":"createdAt","searchable":true,"sortable":true}},"updatedAt":{"edit":{"label":"updatedAt","description":"","placeholder":"","visible":false,"editable":true},"list":{"label":"updatedAt","searchable":true,"sortable":true}},"createdBy":{"edit":{"label":"createdBy","description":"","placeholder":"","visible":false,"editable":true,"mainField":"firstname"},"list":{"label":"createdBy","searchable":true,"sortable":true}},"updatedBy":{"edit":{"label":"updatedBy","description":"","placeholder":"","visible":false,"editable":true,"mainField":"firstname"},"list":{"label":"updatedBy","searchable":true,"sortable":true}},"documentId":{"edit":{},"list":{"label":"documentId","searchable":true,"sortable":true}}},"layouts":{"list":["id","name","stages","stageRequiredToPublish"],"edit":[[{"name":"name","size":6},{"name":"stages","size":6}],[{"name":"stageRequiredToPublish","size":6}],[{"name":"contentTypes","size":12}]]},"uid":"plugin::review-workflows.workflow"}	object	\N	\N
8	plugin_content_manager_configuration_content_types::plugin::upload.folder	{"settings":{"bulkable":true,"filterable":true,"searchable":true,"pageSize":10,"relationOpenMode":"modal","mainField":"name","defaultSortBy":"name","defaultSortOrder":"ASC"},"metadatas":{"id":{"edit":{},"list":{"label":"id","searchable":true,"sortable":true}},"name":{"edit":{"label":"name","description":"","placeholder":"","visible":true,"editable":true},"list":{"label":"name","searchable":true,"sortable":true}},"pathId":{"edit":{"label":"pathId","description":"","placeholder":"","visible":true,"editable":true},"list":{"label":"pathId","searchable":true,"sortable":true}},"parent":{"edit":{"label":"parent","description":"","placeholder":"","visible":true,"editable":true,"mainField":"name"},"list":{"label":"parent","searchable":true,"sortable":true}},"children":{"edit":{"label":"children","description":"","placeholder":"","visible":true,"editable":true,"mainField":"name"},"list":{"label":"children","searchable":false,"sortable":false}},"files":{"edit":{"label":"files","description":"","placeholder":"","visible":true,"editable":true,"mainField":"name"},"list":{"label":"files","searchable":false,"sortable":false}},"path":{"edit":{"label":"path","description":"","placeholder":"","visible":true,"editable":true},"list":{"label":"path","searchable":true,"sortable":true}},"createdAt":{"edit":{"label":"createdAt","description":"","placeholder":"","visible":false,"editable":true},"list":{"label":"createdAt","searchable":true,"sortable":true}},"updatedAt":{"edit":{"label":"updatedAt","description":"","placeholder":"","visible":false,"editable":true},"list":{"label":"updatedAt","searchable":true,"sortable":true}},"createdBy":{"edit":{"label":"createdBy","description":"","placeholder":"","visible":false,"editable":true,"mainField":"firstname"},"list":{"label":"createdBy","searchable":true,"sortable":true}},"updatedBy":{"edit":{"label":"updatedBy","description":"","placeholder":"","visible":false,"editable":true,"mainField":"firstname"},"list":{"label":"updatedBy","searchable":true,"sortable":true}},"documentId":{"edit":{},"list":{"label":"documentId","searchable":true,"sortable":true}}},"layouts":{"list":["id","name","pathId","parent"],"edit":[[{"name":"name","size":6},{"name":"pathId","size":4}],[{"name":"parent","size":6},{"name":"children","size":6}],[{"name":"files","size":6},{"name":"path","size":6}]]},"uid":"plugin::upload.folder"}	object	\N	\N
9	plugin_content_manager_configuration_content_types::plugin::review-workflows.workflow-stage	{"settings":{"bulkable":true,"filterable":true,"searchable":true,"pageSize":10,"relationOpenMode":"modal","mainField":"name","defaultSortBy":"name","defaultSortOrder":"ASC"},"metadatas":{"id":{"edit":{},"list":{"label":"id","searchable":true,"sortable":true}},"name":{"edit":{"label":"name","description":"","placeholder":"","visible":true,"editable":true},"list":{"label":"name","searchable":true,"sortable":true}},"color":{"edit":{"label":"color","description":"","placeholder":"","visible":true,"editable":true},"list":{"label":"color","searchable":true,"sortable":true}},"workflow":{"edit":{"label":"workflow","description":"","placeholder":"","visible":true,"editable":true,"mainField":"name"},"list":{"label":"workflow","searchable":true,"sortable":true}},"permissions":{"edit":{"label":"permissions","description":"","placeholder":"","visible":true,"editable":true,"mainField":"action"},"list":{"label":"permissions","searchable":false,"sortable":false}},"createdAt":{"edit":{"label":"createdAt","description":"","placeholder":"","visible":false,"editable":true},"list":{"label":"createdAt","searchable":true,"sortable":true}},"updatedAt":{"edit":{"label":"updatedAt","description":"","placeholder":"","visible":false,"editable":true},"list":{"label":"updatedAt","searchable":true,"sortable":true}},"createdBy":{"edit":{"label":"createdBy","description":"","placeholder":"","visible":false,"editable":true,"mainField":"firstname"},"list":{"label":"createdBy","searchable":true,"sortable":true}},"updatedBy":{"edit":{"label":"updatedBy","description":"","placeholder":"","visible":false,"editable":true,"mainField":"firstname"},"list":{"label":"updatedBy","searchable":true,"sortable":true}},"documentId":{"edit":{},"list":{"label":"documentId","searchable":true,"sortable":true}}},"layouts":{"list":["id","name","color","workflow"],"edit":[[{"name":"name","size":6},{"name":"color","size":6}],[{"name":"workflow","size":6},{"name":"permissions","size":6}]]},"uid":"plugin::review-workflows.workflow-stage"}	object	\N	\N
14	plugin_content_manager_configuration_content_types::admin::role	{"settings":{"bulkable":true,"filterable":true,"searchable":true,"pageSize":10,"relationOpenMode":"modal","mainField":"name","defaultSortBy":"name","defaultSortOrder":"ASC"},"metadatas":{"id":{"edit":{},"list":{"label":"id","searchable":true,"sortable":true}},"name":{"edit":{"label":"name","description":"","placeholder":"","visible":true,"editable":true},"list":{"label":"name","searchable":true,"sortable":true}},"code":{"edit":{"label":"code","description":"","placeholder":"","visible":true,"editable":true},"list":{"label":"code","searchable":true,"sortable":true}},"description":{"edit":{"label":"description","description":"","placeholder":"","visible":true,"editable":true},"list":{"label":"description","searchable":true,"sortable":true}},"users":{"edit":{"label":"users","description":"","placeholder":"","visible":true,"editable":true,"mainField":"firstname"},"list":{"label":"users","searchable":false,"sortable":false}},"permissions":{"edit":{"label":"permissions","description":"","placeholder":"","visible":true,"editable":true,"mainField":"action"},"list":{"label":"permissions","searchable":false,"sortable":false}},"createdAt":{"edit":{"label":"createdAt","description":"","placeholder":"","visible":false,"editable":true},"list":{"label":"createdAt","searchable":true,"sortable":true}},"updatedAt":{"edit":{"label":"updatedAt","description":"","placeholder":"","visible":false,"editable":true},"list":{"label":"updatedAt","searchable":true,"sortable":true}},"createdBy":{"edit":{"label":"createdBy","description":"","placeholder":"","visible":false,"editable":true,"mainField":"firstname"},"list":{"label":"createdBy","searchable":true,"sortable":true}},"updatedBy":{"edit":{"label":"updatedBy","description":"","placeholder":"","visible":false,"editable":true,"mainField":"firstname"},"list":{"label":"updatedBy","searchable":true,"sortable":true}},"documentId":{"edit":{},"list":{"label":"documentId","searchable":true,"sortable":true}}},"layouts":{"list":["id","name","code","description"],"edit":[[{"name":"name","size":6},{"name":"code","size":6}],[{"name":"description","size":6},{"name":"users","size":6}],[{"name":"permissions","size":6}]]},"uid":"admin::role"}	object	\N	\N
2	strapi_content_types_schema	{"plugin::upload.file":{"collectionName":"files","info":{"singularName":"file","pluralName":"files","displayName":"File","description":""},"options":{"draftAndPublish":false},"pluginOptions":{"content-manager":{"visible":false},"content-type-builder":{"visible":false}},"attributes":{"name":{"type":"string","configurable":false,"required":true},"alternativeText":{"type":"text","configurable":false},"caption":{"type":"text","configurable":false},"focalPoint":{"type":"json","configurable":false},"width":{"type":"integer","configurable":false},"height":{"type":"integer","configurable":false},"formats":{"type":"json","configurable":false},"hash":{"type":"string","configurable":false,"required":true},"ext":{"type":"string","configurable":false},"mime":{"type":"string","configurable":false,"required":true},"size":{"type":"decimal","configurable":false,"required":true},"url":{"type":"text","configurable":false,"required":true},"previewUrl":{"type":"text","configurable":false},"provider":{"type":"string","configurable":false,"required":true},"provider_metadata":{"type":"json","configurable":false},"related":{"type":"relation","relation":"morphToMany","configurable":false},"folder":{"type":"relation","relation":"manyToOne","target":"plugin::upload.folder","inversedBy":"files","private":true},"folderPath":{"type":"string","minLength":1,"required":true,"private":true,"searchable":false},"createdAt":{"type":"datetime"},"updatedAt":{"type":"datetime"},"publishedAt":{"type":"datetime","configurable":false,"writable":true,"visible":true},"createdBy":{"type":"relation","relation":"oneToOne","target":"admin::user","configurable":false,"writable":false,"visible":false,"useJoinTable":false,"private":true},"updatedBy":{"type":"relation","relation":"oneToOne","target":"admin::user","configurable":false,"writable":false,"visible":false,"useJoinTable":false,"private":true},"locale":{"writable":true,"private":true,"configurable":false,"visible":false,"type":"string"},"localizations":{"type":"relation","relation":"oneToMany","target":"plugin::upload.file","writable":false,"private":true,"configurable":false,"visible":false,"unstable_virtual":true,"joinColumn":{"name":"document_id","referencedColumn":"document_id","referencedTable":"files"}}},"indexes":[{"name":"upload_files_folder_path_index","columns":["folder_path"],"type":null},{"name":"upload_files_created_at_index","columns":["created_at"],"type":null},{"name":"upload_files_updated_at_index","columns":["updated_at"],"type":null},{"name":"upload_files_name_index","columns":["name"],"type":null},{"name":"upload_files_size_index","columns":["size"],"type":null},{"name":"upload_files_ext_index","columns":["ext"],"type":null}],"plugin":"upload","globalId":"UploadFile","uid":"plugin::upload.file","modelType":"contentType","kind":"collectionType","__schema__":{"collectionName":"files","info":{"singularName":"file","pluralName":"files","displayName":"File","description":""},"options":{},"pluginOptions":{"content-manager":{"visible":false},"content-type-builder":{"visible":false}},"attributes":{"name":{"type":"string","configurable":false,"required":true},"alternativeText":{"type":"text","configurable":false},"caption":{"type":"text","configurable":false},"focalPoint":{"type":"json","configurable":false},"width":{"type":"integer","configurable":false},"height":{"type":"integer","configurable":false},"formats":{"type":"json","configurable":false},"hash":{"type":"string","configurable":false,"required":true},"ext":{"type":"string","configurable":false},"mime":{"type":"string","configurable":false,"required":true},"size":{"type":"decimal","configurable":false,"required":true},"url":{"type":"text","configurable":false,"required":true},"previewUrl":{"type":"text","configurable":false},"provider":{"type":"string","configurable":false,"required":true},"provider_metadata":{"type":"json","configurable":false},"related":{"type":"relation","relation":"morphToMany","configurable":false},"folder":{"type":"relation","relation":"manyToOne","target":"plugin::upload.folder","inversedBy":"files","private":true},"folderPath":{"type":"string","minLength":1,"required":true,"private":true,"searchable":false}},"kind":"collectionType"},"modelName":"file"},"plugin::upload.folder":{"collectionName":"upload_folders","info":{"singularName":"folder","pluralName":"folders","displayName":"Folder"},"options":{"draftAndPublish":false},"pluginOptions":{"content-manager":{"visible":false},"content-type-builder":{"visible":false}},"attributes":{"name":{"type":"string","minLength":1,"required":true},"pathId":{"type":"integer","unique":true,"required":true},"parent":{"type":"relation","relation":"manyToOne","target":"plugin::upload.folder","inversedBy":"children"},"children":{"type":"relation","relation":"oneToMany","target":"plugin::upload.folder","mappedBy":"parent"},"files":{"type":"relation","relation":"oneToMany","target":"plugin::upload.file","mappedBy":"folder"},"path":{"type":"string","minLength":1,"required":true},"createdAt":{"type":"datetime"},"updatedAt":{"type":"datetime"},"publishedAt":{"type":"datetime","configurable":false,"writable":true,"visible":true},"createdBy":{"type":"relation","relation":"oneToOne","target":"admin::user","configurable":false,"writable":false,"visible":false,"useJoinTable":false,"private":true},"updatedBy":{"type":"relation","relation":"oneToOne","target":"admin::user","configurable":false,"writable":false,"visible":false,"useJoinTable":false,"private":true},"locale":{"writable":true,"private":true,"configurable":false,"visible":false,"type":"string"},"localizations":{"type":"relation","relation":"oneToMany","target":"plugin::upload.folder","writable":false,"private":true,"configurable":false,"visible":false,"unstable_virtual":true,"joinColumn":{"name":"document_id","referencedColumn":"document_id","referencedTable":"upload_folders"}}},"indexes":[{"name":"upload_folders_path_id_index","columns":["path_id"],"type":"unique"},{"name":"upload_folders_path_index","columns":["path"],"type":"unique"}],"plugin":"upload","globalId":"UploadFolder","uid":"plugin::upload.folder","modelType":"contentType","kind":"collectionType","__schema__":{"collectionName":"upload_folders","info":{"singularName":"folder","pluralName":"folders","displayName":"Folder"},"options":{},"pluginOptions":{"content-manager":{"visible":false},"content-type-builder":{"visible":false}},"attributes":{"name":{"type":"string","minLength":1,"required":true},"pathId":{"type":"integer","unique":true,"required":true},"parent":{"type":"relation","relation":"manyToOne","target":"plugin::upload.folder","inversedBy":"children"},"children":{"type":"relation","relation":"oneToMany","target":"plugin::upload.folder","mappedBy":"parent"},"files":{"type":"relation","relation":"oneToMany","target":"plugin::upload.file","mappedBy":"folder"},"path":{"type":"string","minLength":1,"required":true}},"kind":"collectionType"},"modelName":"folder"},"plugin::i18n.locale":{"info":{"singularName":"locale","pluralName":"locales","collectionName":"locales","displayName":"Locale","description":""},"options":{"draftAndPublish":false},"pluginOptions":{"content-manager":{"visible":false},"content-type-builder":{"visible":false}},"attributes":{"name":{"type":"string","min":1,"max":50,"configurable":false},"code":{"type":"string","unique":true,"configurable":false},"createdAt":{"type":"datetime"},"updatedAt":{"type":"datetime"},"publishedAt":{"type":"datetime","configurable":false,"writable":true,"visible":true},"createdBy":{"type":"relation","relation":"oneToOne","target":"admin::user","configurable":false,"writable":false,"visible":false,"useJoinTable":false,"private":true},"updatedBy":{"type":"relation","relation":"oneToOne","target":"admin::user","configurable":false,"writable":false,"visible":false,"useJoinTable":false,"private":true},"locale":{"writable":true,"private":true,"configurable":false,"visible":false,"type":"string"},"localizations":{"type":"relation","relation":"oneToMany","target":"plugin::i18n.locale","writable":false,"private":true,"configurable":false,"visible":false,"unstable_virtual":true,"joinColumn":{"name":"document_id","referencedColumn":"document_id","referencedTable":"i18n_locale"}}},"plugin":"i18n","collectionName":"i18n_locale","globalId":"I18NLocale","uid":"plugin::i18n.locale","modelType":"contentType","kind":"collectionType","__schema__":{"collectionName":"i18n_locale","info":{"singularName":"locale","pluralName":"locales","collectionName":"locales","displayName":"Locale","description":""},"options":{},"pluginOptions":{"content-manager":{"visible":false},"content-type-builder":{"visible":false}},"attributes":{"name":{"type":"string","min":1,"max":50,"configurable":false},"code":{"type":"string","unique":true,"configurable":false}},"kind":"collectionType"},"modelName":"locale"},"plugin::content-releases.release":{"collectionName":"strapi_releases","info":{"singularName":"release","pluralName":"releases","displayName":"Release"},"options":{"draftAndPublish":false},"pluginOptions":{"content-manager":{"visible":false},"content-type-builder":{"visible":false}},"attributes":{"name":{"type":"string","required":true},"releasedAt":{"type":"datetime"},"scheduledAt":{"type":"datetime"},"timezone":{"type":"string"},"status":{"type":"enumeration","enum":["ready","blocked","failed","done","empty"],"required":true},"actions":{"type":"relation","relation":"oneToMany","target":"plugin::content-releases.release-action","mappedBy":"release"},"createdAt":{"type":"datetime"},"updatedAt":{"type":"datetime"},"publishedAt":{"type":"datetime","configurable":false,"writable":true,"visible":true},"createdBy":{"type":"relation","relation":"oneToOne","target":"admin::user","configurable":false,"writable":false,"visible":false,"useJoinTable":false,"private":true},"updatedBy":{"type":"relation","relation":"oneToOne","target":"admin::user","configurable":false,"writable":false,"visible":false,"useJoinTable":false,"private":true},"locale":{"writable":true,"private":true,"configurable":false,"visible":false,"type":"string"},"localizations":{"type":"relation","relation":"oneToMany","target":"plugin::content-releases.release","writable":false,"private":true,"configurable":false,"visible":false,"unstable_virtual":true,"joinColumn":{"name":"document_id","referencedColumn":"document_id","referencedTable":"strapi_releases"}}},"plugin":"content-releases","globalId":"ContentReleasesRelease","uid":"plugin::content-releases.release","modelType":"contentType","kind":"collectionType","__schema__":{"collectionName":"strapi_releases","info":{"singularName":"release","pluralName":"releases","displayName":"Release"},"options":{"draftAndPublish":false},"pluginOptions":{"content-manager":{"visible":false},"content-type-builder":{"visible":false}},"attributes":{"name":{"type":"string","required":true},"releasedAt":{"type":"datetime"},"scheduledAt":{"type":"datetime"},"timezone":{"type":"string"},"status":{"type":"enumeration","enum":["ready","blocked","failed","done","empty"],"required":true},"actions":{"type":"relation","relation":"oneToMany","target":"plugin::content-releases.release-action","mappedBy":"release"}},"kind":"collectionType"},"modelName":"release"},"plugin::content-releases.release-action":{"collectionName":"strapi_release_actions","info":{"singularName":"release-action","pluralName":"release-actions","displayName":"Release Action"},"options":{"draftAndPublish":false},"pluginOptions":{"content-manager":{"visible":false},"content-type-builder":{"visible":false}},"attributes":{"type":{"type":"enumeration","enum":["publish","unpublish"],"required":true},"contentType":{"type":"string","required":true},"entryDocumentId":{"type":"string"},"locale":{"writable":true,"private":true,"configurable":false,"visible":false,"type":"string"},"release":{"type":"relation","relation":"manyToOne","target":"plugin::content-releases.release","inversedBy":"actions"},"isEntryValid":{"type":"boolean"},"createdAt":{"type":"datetime"},"updatedAt":{"type":"datetime"},"publishedAt":{"type":"datetime","configurable":false,"writable":true,"visible":true},"createdBy":{"type":"relation","relation":"oneToOne","target":"admin::user","configurable":false,"writable":false,"visible":false,"useJoinTable":false,"private":true},"updatedBy":{"type":"relation","relation":"oneToOne","target":"admin::user","configurable":false,"writable":false,"visible":false,"useJoinTable":false,"private":true},"localizations":{"type":"relation","relation":"oneToMany","target":"plugin::content-releases.release-action","writable":false,"private":true,"configurable":false,"visible":false,"unstable_virtual":true,"joinColumn":{"name":"document_id","referencedColumn":"document_id","referencedTable":"strapi_release_actions"}}},"plugin":"content-releases","globalId":"ContentReleasesReleaseAction","uid":"plugin::content-releases.release-action","modelType":"contentType","kind":"collectionType","__schema__":{"collectionName":"strapi_release_actions","info":{"singularName":"release-action","pluralName":"release-actions","displayName":"Release Action"},"options":{"draftAndPublish":false},"pluginOptions":{"content-manager":{"visible":false},"content-type-builder":{"visible":false}},"attributes":{"type":{"type":"enumeration","enum":["publish","unpublish"],"required":true},"contentType":{"type":"string","required":true},"entryDocumentId":{"type":"string"},"locale":{"type":"string"},"release":{"type":"relation","relation":"manyToOne","target":"plugin::content-releases.release","inversedBy":"actions"},"isEntryValid":{"type":"boolean"}},"kind":"collectionType"},"modelName":"release-action"},"plugin::review-workflows.workflow":{"collectionName":"strapi_workflows","info":{"name":"Workflow","description":"","singularName":"workflow","pluralName":"workflows","displayName":"Workflow"},"options":{"draftAndPublish":false},"pluginOptions":{"content-manager":{"visible":false},"content-type-builder":{"visible":false}},"attributes":{"name":{"type":"string","required":true,"unique":true},"stages":{"type":"relation","target":"plugin::review-workflows.workflow-stage","relation":"oneToMany","mappedBy":"workflow"},"stageRequiredToPublish":{"type":"relation","target":"plugin::review-workflows.workflow-stage","relation":"oneToOne","required":false},"contentTypes":{"type":"json","required":true,"default":"[]"},"createdAt":{"type":"datetime"},"updatedAt":{"type":"datetime"},"publishedAt":{"type":"datetime","configurable":false,"writable":true,"visible":true},"createdBy":{"type":"relation","relation":"oneToOne","target":"admin::user","configurable":false,"writable":false,"visible":false,"useJoinTable":false,"private":true},"updatedBy":{"type":"relation","relation":"oneToOne","target":"admin::user","configurable":false,"writable":false,"visible":false,"useJoinTable":false,"private":true},"locale":{"writable":true,"private":true,"configurable":false,"visible":false,"type":"string"},"localizations":{"type":"relation","relation":"oneToMany","target":"plugin::review-workflows.workflow","writable":false,"private":true,"configurable":false,"visible":false,"unstable_virtual":true,"joinColumn":{"name":"document_id","referencedColumn":"document_id","referencedTable":"strapi_workflows"}}},"plugin":"review-workflows","globalId":"ReviewWorkflowsWorkflow","uid":"plugin::review-workflows.workflow","modelType":"contentType","kind":"collectionType","__schema__":{"collectionName":"strapi_workflows","info":{"name":"Workflow","description":"","singularName":"workflow","pluralName":"workflows","displayName":"Workflow"},"options":{},"pluginOptions":{"content-manager":{"visible":false},"content-type-builder":{"visible":false}},"attributes":{"name":{"type":"string","required":true,"unique":true},"stages":{"type":"relation","target":"plugin::review-workflows.workflow-stage","relation":"oneToMany","mappedBy":"workflow"},"stageRequiredToPublish":{"type":"relation","target":"plugin::review-workflows.workflow-stage","relation":"oneToOne","required":false},"contentTypes":{"type":"json","required":true,"default":"[]"}},"kind":"collectionType"},"modelName":"workflow"},"plugin::review-workflows.workflow-stage":{"collectionName":"strapi_workflows_stages","info":{"name":"Workflow Stage","description":"","singularName":"workflow-stage","pluralName":"workflow-stages","displayName":"Stages"},"options":{"version":"1.1.0","draftAndPublish":false},"pluginOptions":{"content-manager":{"visible":false},"content-type-builder":{"visible":false}},"attributes":{"name":{"type":"string","configurable":false},"color":{"type":"string","configurable":false,"default":"#4945FF"},"workflow":{"type":"relation","target":"plugin::review-workflows.workflow","relation":"manyToOne","inversedBy":"stages","configurable":false},"permissions":{"type":"relation","target":"admin::permission","relation":"manyToMany","configurable":false},"createdAt":{"type":"datetime"},"updatedAt":{"type":"datetime"},"publishedAt":{"type":"datetime","configurable":false,"writable":true,"visible":true},"createdBy":{"type":"relation","relation":"oneToOne","target":"admin::user","configurable":false,"writable":false,"visible":false,"useJoinTable":false,"private":true},"updatedBy":{"type":"relation","relation":"oneToOne","target":"admin::user","configurable":false,"writable":false,"visible":false,"useJoinTable":false,"private":true},"locale":{"writable":true,"private":true,"configurable":false,"visible":false,"type":"string"},"localizations":{"type":"relation","relation":"oneToMany","target":"plugin::review-workflows.workflow-stage","writable":false,"private":true,"configurable":false,"visible":false,"unstable_virtual":true,"joinColumn":{"name":"document_id","referencedColumn":"document_id","referencedTable":"strapi_workflows_stages"}}},"plugin":"review-workflows","globalId":"ReviewWorkflowsWorkflowStage","uid":"plugin::review-workflows.workflow-stage","modelType":"contentType","kind":"collectionType","__schema__":{"collectionName":"strapi_workflows_stages","info":{"name":"Workflow Stage","description":"","singularName":"workflow-stage","pluralName":"workflow-stages","displayName":"Stages"},"options":{"version":"1.1.0"},"pluginOptions":{"content-manager":{"visible":false},"content-type-builder":{"visible":false}},"attributes":{"name":{"type":"string","configurable":false},"color":{"type":"string","configurable":false,"default":"#4945FF"},"workflow":{"type":"relation","target":"plugin::review-workflows.workflow","relation":"manyToOne","inversedBy":"stages","configurable":false},"permissions":{"type":"relation","target":"admin::permission","relation":"manyToMany","configurable":false}},"kind":"collectionType"},"modelName":"workflow-stage"},"plugin::users-permissions.permission":{"collectionName":"up_permissions","info":{"name":"permission","description":"","singularName":"permission","pluralName":"permissions","displayName":"Permission"},"pluginOptions":{"content-manager":{"visible":false},"content-type-builder":{"visible":false}},"attributes":{"action":{"type":"string","required":true,"configurable":false},"role":{"type":"relation","relation":"manyToOne","target":"plugin::users-permissions.role","inversedBy":"permissions","configurable":false},"createdAt":{"type":"datetime"},"updatedAt":{"type":"datetime"},"publishedAt":{"type":"datetime","configurable":false,"writable":true,"visible":true},"createdBy":{"type":"relation","relation":"oneToOne","target":"admin::user","configurable":false,"writable":false,"visible":false,"useJoinTable":false,"private":true},"updatedBy":{"type":"relation","relation":"oneToOne","target":"admin::user","configurable":false,"writable":false,"visible":false,"useJoinTable":false,"private":true},"locale":{"writable":true,"private":true,"configurable":false,"visible":false,"type":"string"},"localizations":{"type":"relation","relation":"oneToMany","target":"plugin::users-permissions.permission","writable":false,"private":true,"configurable":false,"visible":false,"unstable_virtual":true,"joinColumn":{"name":"document_id","referencedColumn":"document_id","referencedTable":"up_permissions"}}},"plugin":"users-permissions","globalId":"UsersPermissionsPermission","uid":"plugin::users-permissions.permission","modelType":"contentType","kind":"collectionType","__schema__":{"collectionName":"up_permissions","info":{"name":"permission","description":"","singularName":"permission","pluralName":"permissions","displayName":"Permission"},"pluginOptions":{"content-manager":{"visible":false},"content-type-builder":{"visible":false}},"attributes":{"action":{"type":"string","required":true,"configurable":false},"role":{"type":"relation","relation":"manyToOne","target":"plugin::users-permissions.role","inversedBy":"permissions","configurable":false}},"kind":"collectionType"},"modelName":"permission","options":{"draftAndPublish":false}},"plugin::users-permissions.role":{"collectionName":"up_roles","info":{"name":"role","description":"","singularName":"role","pluralName":"roles","displayName":"Role"},"pluginOptions":{"content-manager":{"visible":false},"content-type-builder":{"visible":false}},"attributes":{"name":{"type":"string","minLength":3,"required":true,"configurable":false},"description":{"type":"string","configurable":false},"type":{"type":"string","unique":true,"configurable":false},"permissions":{"type":"relation","relation":"oneToMany","target":"plugin::users-permissions.permission","mappedBy":"role","configurable":false},"users":{"type":"relation","relation":"oneToMany","target":"plugin::users-permissions.user","mappedBy":"role","configurable":false},"createdAt":{"type":"datetime"},"updatedAt":{"type":"datetime"},"publishedAt":{"type":"datetime","configurable":false,"writable":true,"visible":true},"createdBy":{"type":"relation","relation":"oneToOne","target":"admin::user","configurable":false,"writable":false,"visible":false,"useJoinTable":false,"private":true},"updatedBy":{"type":"relation","relation":"oneToOne","target":"admin::user","configurable":false,"writable":false,"visible":false,"useJoinTable":false,"private":true},"locale":{"writable":true,"private":true,"configurable":false,"visible":false,"type":"string"},"localizations":{"type":"relation","relation":"oneToMany","target":"plugin::users-permissions.role","writable":false,"private":true,"configurable":false,"visible":false,"unstable_virtual":true,"joinColumn":{"name":"document_id","referencedColumn":"document_id","referencedTable":"up_roles"}}},"plugin":"users-permissions","globalId":"UsersPermissionsRole","uid":"plugin::users-permissions.role","modelType":"contentType","kind":"collectionType","__schema__":{"collectionName":"up_roles","info":{"name":"role","description":"","singularName":"role","pluralName":"roles","displayName":"Role"},"pluginOptions":{"content-manager":{"visible":false},"content-type-builder":{"visible":false}},"attributes":{"name":{"type":"string","minLength":3,"required":true,"configurable":false},"description":{"type":"string","configurable":false},"type":{"type":"string","unique":true,"configurable":false},"permissions":{"type":"relation","relation":"oneToMany","target":"plugin::users-permissions.permission","mappedBy":"role","configurable":false},"users":{"type":"relation","relation":"oneToMany","target":"plugin::users-permissions.user","mappedBy":"role","configurable":false}},"kind":"collectionType"},"modelName":"role","options":{"draftAndPublish":false}},"plugin::users-permissions.user":{"collectionName":"up_users","info":{"name":"user","description":"","singularName":"user","pluralName":"users","displayName":"User"},"options":{"timestamps":true,"draftAndPublish":false},"attributes":{"phone":{"type":"string"},"appRole":{"type":"enumeration","enum":["USER","ADMIN"],"default":"USER"},"orders":{"type":"relation","relation":"oneToMany","target":"api::order.order","mappedBy":"user"},"bookings":{"type":"relation","relation":"oneToMany","target":"api::booking.booking","mappedBy":"user"},"cartItems":{"type":"relation","relation":"oneToMany","target":"api::cart-item.cart-item","mappedBy":"user"},"wishlistItems":{"type":"relation","relation":"oneToMany","target":"api::wishlist-item.wishlist-item","mappedBy":"user"},"reviews":{"type":"relation","relation":"oneToMany","target":"api::review.review","mappedBy":"user"},"couponUsages":{"type":"relation","relation":"oneToMany","target":"api::coupon-usage.coupon-usage","mappedBy":"user"},"digitalPurchases":{"type":"relation","relation":"oneToMany","target":"api::digital-purchase.digital-purchase","mappedBy":"user"},"passwordResetTokens":{"type":"relation","relation":"oneToMany","target":"api::password-reset-token.password-reset-token","mappedBy":"user"},"createdAt":{"type":"datetime"},"updatedAt":{"type":"datetime"},"publishedAt":{"type":"datetime","configurable":false,"writable":true,"visible":true},"createdBy":{"type":"relation","relation":"oneToOne","target":"admin::user","configurable":false,"writable":false,"visible":false,"useJoinTable":false,"private":true},"updatedBy":{"type":"relation","relation":"oneToOne","target":"admin::user","configurable":false,"writable":false,"visible":false,"useJoinTable":false,"private":true},"locale":{"writable":true,"private":true,"configurable":false,"visible":false,"type":"string"},"localizations":{"type":"relation","relation":"oneToMany","target":"plugin::users-permissions.user","writable":false,"private":true,"configurable":false,"visible":false,"unstable_virtual":true,"joinColumn":{"name":"document_id","referencedColumn":"document_id","referencedTable":"up_users"}}},"config":{"attributes":{"resetPasswordToken":{"hidden":true},"confirmationToken":{"hidden":true},"provider":{"hidden":true}}},"plugin":"users-permissions","globalId":"UsersPermissionsUser","__filename__":"schema.json","uid":"plugin::users-permissions.user","modelType":"contentType","kind":"collectionType","__schema__":{"collectionName":"up_users","info":{"name":"user","description":"","singularName":"user","pluralName":"users","displayName":"User"},"options":{"timestamps":true},"attributes":{"phone":{"type":"string"},"appRole":{"type":"enumeration","enum":["USER","ADMIN"],"default":"USER"},"orders":{"type":"relation","relation":"oneToMany","target":"api::order.order","mappedBy":"user"},"bookings":{"type":"relation","relation":"oneToMany","target":"api::booking.booking","mappedBy":"user"},"cartItems":{"type":"relation","relation":"oneToMany","target":"api::cart-item.cart-item","mappedBy":"user"},"wishlistItems":{"type":"relation","relation":"oneToMany","target":"api::wishlist-item.wishlist-item","mappedBy":"user"},"reviews":{"type":"relation","relation":"oneToMany","target":"api::review.review","mappedBy":"user"},"couponUsages":{"type":"relation","relation":"oneToMany","target":"api::coupon-usage.coupon-usage","mappedBy":"user"},"digitalPurchases":{"type":"relation","relation":"oneToMany","target":"api::digital-purchase.digital-purchase","mappedBy":"user"},"passwordResetTokens":{"type":"relation","relation":"oneToMany","target":"api::password-reset-token.password-reset-token","mappedBy":"user"}},"kind":"collectionType"},"modelName":"user"},"api::availability-rule.availability-rule":{"kind":"collectionType","collectionName":"availability_rules","info":{"singularName":"availability-rule","pluralName":"availability-rules","displayName":"Availability Rule"},"options":{"draftAndPublish":false},"attributes":{"dayOfWeek":{"type":"integer","required":true,"min":0,"max":6},"startTime":{"type":"string","required":true},"endTime":{"type":"string","required":true},"isActive":{"type":"boolean","default":true},"createdAt":{"type":"datetime"},"updatedAt":{"type":"datetime"},"publishedAt":{"type":"datetime","configurable":false,"writable":true,"visible":true},"createdBy":{"type":"relation","relation":"oneToOne","target":"admin::user","configurable":false,"writable":false,"visible":false,"useJoinTable":false,"private":true},"updatedBy":{"type":"relation","relation":"oneToOne","target":"admin::user","configurable":false,"writable":false,"visible":false,"useJoinTable":false,"private":true},"locale":{"writable":true,"private":true,"configurable":false,"visible":false,"type":"string"},"localizations":{"type":"relation","relation":"oneToMany","target":"api::availability-rule.availability-rule","writable":false,"private":true,"configurable":false,"visible":false,"unstable_virtual":true,"joinColumn":{"name":"document_id","referencedColumn":"document_id","referencedTable":"availability_rules"}}},"apiName":"availability-rule","globalId":"AvailabilityRule","uid":"api::availability-rule.availability-rule","modelType":"contentType","__schema__":{"collectionName":"availability_rules","info":{"singularName":"availability-rule","pluralName":"availability-rules","displayName":"Availability Rule"},"options":{"draftAndPublish":false},"attributes":{"dayOfWeek":{"type":"integer","required":true,"min":0,"max":6},"startTime":{"type":"string","required":true},"endTime":{"type":"string","required":true},"isActive":{"type":"boolean","default":true}},"kind":"collectionType"},"modelName":"availability-rule","actions":{},"lifecycles":{}},"api::banner.banner":{"kind":"collectionType","collectionName":"banners","info":{"singularName":"banner","pluralName":"banners","displayName":"Banner"},"options":{"draftAndPublish":false},"attributes":{"title":{"type":"string","required":true},"imageUrl":{"type":"string","required":true},"linkUrl":{"type":"string"},"position":{"type":"enumeration","enum":["HOME_HERO","HOME_SALE","SHOP_TOP"],"required":true},"startDate":{"type":"datetime"},"endDate":{"type":"datetime"},"isActive":{"type":"boolean","default":true},"sortOrder":{"type":"integer","default":0},"createdAt":{"type":"datetime"},"updatedAt":{"type":"datetime"},"publishedAt":{"type":"datetime","configurable":false,"writable":true,"visible":true},"createdBy":{"type":"relation","relation":"oneToOne","target":"admin::user","configurable":false,"writable":false,"visible":false,"useJoinTable":false,"private":true},"updatedBy":{"type":"relation","relation":"oneToOne","target":"admin::user","configurable":false,"writable":false,"visible":false,"useJoinTable":false,"private":true},"locale":{"writable":true,"private":true,"configurable":false,"visible":false,"type":"string"},"localizations":{"type":"relation","relation":"oneToMany","target":"api::banner.banner","writable":false,"private":true,"configurable":false,"visible":false,"unstable_virtual":true,"joinColumn":{"name":"document_id","referencedColumn":"document_id","referencedTable":"banners"}}},"apiName":"banner","globalId":"Banner","uid":"api::banner.banner","modelType":"contentType","__schema__":{"collectionName":"banners","info":{"singularName":"banner","pluralName":"banners","displayName":"Banner"},"options":{"draftAndPublish":false},"attributes":{"title":{"type":"string","required":true},"imageUrl":{"type":"string","required":true},"linkUrl":{"type":"string"},"position":{"type":"enumeration","enum":["HOME_HERO","HOME_SALE","SHOP_TOP"],"required":true},"startDate":{"type":"datetime"},"endDate":{"type":"datetime"},"isActive":{"type":"boolean","default":true},"sortOrder":{"type":"integer","default":0}},"kind":"collectionType"},"modelName":"banner","actions":{},"lifecycles":{}},"api::blocked-slot.blocked-slot":{"kind":"collectionType","collectionName":"blocked_slots","info":{"singularName":"blocked-slot","pluralName":"blocked-slots","displayName":"Blocked Slot"},"options":{"draftAndPublish":false},"attributes":{"date":{"type":"date","required":true},"startTime":{"type":"string"},"endTime":{"type":"string"},"reason":{"type":"string"},"createdAt":{"type":"datetime"},"updatedAt":{"type":"datetime"},"publishedAt":{"type":"datetime","configurable":false,"writable":true,"visible":true},"createdBy":{"type":"relation","relation":"oneToOne","target":"admin::user","configurable":false,"writable":false,"visible":false,"useJoinTable":false,"private":true},"updatedBy":{"type":"relation","relation":"oneToOne","target":"admin::user","configurable":false,"writable":false,"visible":false,"useJoinTable":false,"private":true},"locale":{"writable":true,"private":true,"configurable":false,"visible":false,"type":"string"},"localizations":{"type":"relation","relation":"oneToMany","target":"api::blocked-slot.blocked-slot","writable":false,"private":true,"configurable":false,"visible":false,"unstable_virtual":true,"joinColumn":{"name":"document_id","referencedColumn":"document_id","referencedTable":"blocked_slots"}}},"apiName":"blocked-slot","globalId":"BlockedSlot","uid":"api::blocked-slot.blocked-slot","modelType":"contentType","__schema__":{"collectionName":"blocked_slots","info":{"singularName":"blocked-slot","pluralName":"blocked-slots","displayName":"Blocked Slot"},"options":{"draftAndPublish":false},"attributes":{"date":{"type":"date","required":true},"startTime":{"type":"string"},"endTime":{"type":"string"},"reason":{"type":"string"}},"kind":"collectionType"},"modelName":"blocked-slot","actions":{},"lifecycles":{}},"api::booking.booking":{"kind":"collectionType","collectionName":"bookings","info":{"singularName":"booking","pluralName":"bookings","displayName":"Booking"},"options":{"draftAndPublish":false},"attributes":{"guestName":{"type":"string"},"guestEmail":{"type":"email"},"guestPhone":{"type":"string"},"scheduledAt":{"type":"datetime","required":true},"endAt":{"type":"datetime","required":true},"status":{"type":"enumeration","enum":["PENDING","CONFIRMED","COMPLETED","CANCELLED","RESCHEDULED","NO_SHOW"],"default":"PENDING"},"paymentStatus":{"type":"enumeration","enum":["PENDING","PAID","FAILED","REFUNDED"],"default":"PENDING"},"rzpOrderId":{"type":"string"},"rzpPaymentId":{"type":"string"},"rzpSignature":{"type":"text"},"amountPaid":{"type":"integer","default":0},"gcalEventId":{"type":"string"},"customerNotes":{"type":"text"},"adminNotes":{"type":"text"},"cancelledAt":{"type":"datetime"},"cancelReason":{"type":"text"},"rescheduledFrom":{"type":"datetime"},"legacyId":{"type":"string"},"user":{"type":"relation","relation":"manyToOne","target":"plugin::users-permissions.user","inversedBy":"bookings"},"service":{"type":"relation","relation":"manyToOne","target":"api::service.service","inversedBy":"bookings"},"reminders":{"type":"relation","relation":"oneToMany","target":"api::scheduled-reminder.scheduled-reminder","mappedBy":"booking"},"createdAt":{"type":"datetime"},"updatedAt":{"type":"datetime"},"publishedAt":{"type":"datetime","configurable":false,"writable":true,"visible":true},"createdBy":{"type":"relation","relation":"oneToOne","target":"admin::user","configurable":false,"writable":false,"visible":false,"useJoinTable":false,"private":true},"updatedBy":{"type":"relation","relation":"oneToOne","target":"admin::user","configurable":false,"writable":false,"visible":false,"useJoinTable":false,"private":true},"locale":{"writable":true,"private":true,"configurable":false,"visible":false,"type":"string"},"localizations":{"type":"relation","relation":"oneToMany","target":"api::booking.booking","writable":false,"private":true,"configurable":false,"visible":false,"unstable_virtual":true,"joinColumn":{"name":"document_id","referencedColumn":"document_id","referencedTable":"bookings"}}},"apiName":"booking","globalId":"Booking","uid":"api::booking.booking","modelType":"contentType","__schema__":{"collectionName":"bookings","info":{"singularName":"booking","pluralName":"bookings","displayName":"Booking"},"options":{"draftAndPublish":false},"attributes":{"guestName":{"type":"string"},"guestEmail":{"type":"email"},"guestPhone":{"type":"string"},"scheduledAt":{"type":"datetime","required":true},"endAt":{"type":"datetime","required":true},"status":{"type":"enumeration","enum":["PENDING","CONFIRMED","COMPLETED","CANCELLED","RESCHEDULED","NO_SHOW"],"default":"PENDING"},"paymentStatus":{"type":"enumeration","enum":["PENDING","PAID","FAILED","REFUNDED"],"default":"PENDING"},"rzpOrderId":{"type":"string"},"rzpPaymentId":{"type":"string"},"rzpSignature":{"type":"text"},"amountPaid":{"type":"integer","default":0},"gcalEventId":{"type":"string"},"customerNotes":{"type":"text"},"adminNotes":{"type":"text"},"cancelledAt":{"type":"datetime"},"cancelReason":{"type":"text"},"rescheduledFrom":{"type":"datetime"},"legacyId":{"type":"string"},"user":{"type":"relation","relation":"manyToOne","target":"plugin::users-permissions.user","inversedBy":"bookings"},"service":{"type":"relation","relation":"manyToOne","target":"api::service.service","inversedBy":"bookings"},"reminders":{"type":"relation","relation":"oneToMany","target":"api::scheduled-reminder.scheduled-reminder","mappedBy":"booking"}},"kind":"collectionType"},"modelName":"booking","actions":{},"lifecycles":{}},"api::booking-setting.booking-setting":{"kind":"singleType","collectionName":"booking_setting","info":{"singularName":"booking-setting","pluralName":"booking-settings","displayName":"Booking Settings"},"options":{"draftAndPublish":false},"attributes":{"slotDurationMinutes":{"type":"integer","default":30},"bufferBetweenSlots":{"type":"integer","default":15},"maxAdvanceBookingDays":{"type":"integer","default":60},"minAdvanceBookingHours":{"type":"integer","default":2},"cancellationPolicyHours":{"type":"integer","default":24},"gcalCalendarId":{"type":"string"},"gcalSyncEnabled":{"type":"boolean","default":false},"gcalRefreshToken":{"type":"text"},"autoConfirm":{"type":"boolean","default":true},"createdAt":{"type":"datetime"},"updatedAt":{"type":"datetime"},"publishedAt":{"type":"datetime","configurable":false,"writable":true,"visible":true},"createdBy":{"type":"relation","relation":"oneToOne","target":"admin::user","configurable":false,"writable":false,"visible":false,"useJoinTable":false,"private":true},"updatedBy":{"type":"relation","relation":"oneToOne","target":"admin::user","configurable":false,"writable":false,"visible":false,"useJoinTable":false,"private":true},"locale":{"writable":true,"private":true,"configurable":false,"visible":false,"type":"string"},"localizations":{"type":"relation","relation":"oneToMany","target":"api::booking-setting.booking-setting","writable":false,"private":true,"configurable":false,"visible":false,"unstable_virtual":true,"joinColumn":{"name":"document_id","referencedColumn":"document_id","referencedTable":"booking_setting"}}},"apiName":"booking-setting","globalId":"BookingSetting","uid":"api::booking-setting.booking-setting","modelType":"contentType","__schema__":{"collectionName":"booking_setting","info":{"singularName":"booking-setting","pluralName":"booking-settings","displayName":"Booking Settings"},"options":{"draftAndPublish":false},"attributes":{"slotDurationMinutes":{"type":"integer","default":30},"bufferBetweenSlots":{"type":"integer","default":15},"maxAdvanceBookingDays":{"type":"integer","default":60},"minAdvanceBookingHours":{"type":"integer","default":2},"cancellationPolicyHours":{"type":"integer","default":24},"gcalCalendarId":{"type":"string"},"gcalSyncEnabled":{"type":"boolean","default":false},"gcalRefreshToken":{"type":"text"},"autoConfirm":{"type":"boolean","default":true}},"kind":"singleType"},"modelName":"booking-setting","actions":{},"lifecycles":{}},"api::business-setting.business-setting":{"kind":"singleType","collectionName":"business_setting","info":{"singularName":"business-setting","pluralName":"business-settings","displayName":"Business Settings"},"options":{"draftAndPublish":false},"attributes":{"businessName":{"type":"string","required":true},"gstin":{"type":"string"},"pan":{"type":"string"},"address":{"type":"text","required":true},"state":{"type":"string","required":true},"stateCode":{"type":"string","required":true},"phone":{"type":"string","required":true},"email":{"type":"email","required":true},"logoUrl":{"type":"string"},"bankName":{"type":"string"},"bankAccount":{"type":"string"},"bankIfsc":{"type":"string"},"invoicePrefix":{"type":"string","default":"TBS"},"nextInvoiceNumber":{"type":"integer","default":1},"fbPixelId":{"type":"string"},"fbPixelEnabled":{"type":"boolean","default":false},"createdAt":{"type":"datetime"},"updatedAt":{"type":"datetime"},"publishedAt":{"type":"datetime","configurable":false,"writable":true,"visible":true},"createdBy":{"type":"relation","relation":"oneToOne","target":"admin::user","configurable":false,"writable":false,"visible":false,"useJoinTable":false,"private":true},"updatedBy":{"type":"relation","relation":"oneToOne","target":"admin::user","configurable":false,"writable":false,"visible":false,"useJoinTable":false,"private":true},"locale":{"writable":true,"private":true,"configurable":false,"visible":false,"type":"string"},"localizations":{"type":"relation","relation":"oneToMany","target":"api::business-setting.business-setting","writable":false,"private":true,"configurable":false,"visible":false,"unstable_virtual":true,"joinColumn":{"name":"document_id","referencedColumn":"document_id","referencedTable":"business_setting"}}},"apiName":"business-setting","globalId":"BusinessSetting","uid":"api::business-setting.business-setting","modelType":"contentType","__schema__":{"collectionName":"business_setting","info":{"singularName":"business-setting","pluralName":"business-settings","displayName":"Business Settings"},"options":{"draftAndPublish":false},"attributes":{"businessName":{"type":"string","required":true},"gstin":{"type":"string"},"pan":{"type":"string"},"address":{"type":"text","required":true},"state":{"type":"string","required":true},"stateCode":{"type":"string","required":true},"phone":{"type":"string","required":true},"email":{"type":"email","required":true},"logoUrl":{"type":"string"},"bankName":{"type":"string"},"bankAccount":{"type":"string"},"bankIfsc":{"type":"string"},"invoicePrefix":{"type":"string","default":"TBS"},"nextInvoiceNumber":{"type":"integer","default":1},"fbPixelId":{"type":"string"},"fbPixelEnabled":{"type":"boolean","default":false}},"kind":"singleType"},"modelName":"business-setting","actions":{},"lifecycles":{}},"api::cart-item.cart-item":{"kind":"collectionType","collectionName":"cart_items","info":{"singularName":"cart-item","pluralName":"cart-items","displayName":"Cart Item"},"options":{"draftAndPublish":false},"attributes":{"sessionId":{"type":"string"},"quantity":{"type":"integer","default":1},"variantSelection":{"type":"json"},"user":{"type":"relation","relation":"manyToOne","target":"plugin::users-permissions.user","inversedBy":"cartItems"},"product":{"type":"relation","relation":"manyToOne","target":"api::product.product","inversedBy":"cartItems"},"createdAt":{"type":"datetime"},"updatedAt":{"type":"datetime"},"publishedAt":{"type":"datetime","configurable":false,"writable":true,"visible":true},"createdBy":{"type":"relation","relation":"oneToOne","target":"admin::user","configurable":false,"writable":false,"visible":false,"useJoinTable":false,"private":true},"updatedBy":{"type":"relation","relation":"oneToOne","target":"admin::user","configurable":false,"writable":false,"visible":false,"useJoinTable":false,"private":true},"locale":{"writable":true,"private":true,"configurable":false,"visible":false,"type":"string"},"localizations":{"type":"relation","relation":"oneToMany","target":"api::cart-item.cart-item","writable":false,"private":true,"configurable":false,"visible":false,"unstable_virtual":true,"joinColumn":{"name":"document_id","referencedColumn":"document_id","referencedTable":"cart_items"}}},"apiName":"cart-item","globalId":"CartItem","uid":"api::cart-item.cart-item","modelType":"contentType","__schema__":{"collectionName":"cart_items","info":{"singularName":"cart-item","pluralName":"cart-items","displayName":"Cart Item"},"options":{"draftAndPublish":false},"attributes":{"sessionId":{"type":"string"},"quantity":{"type":"integer","default":1},"variantSelection":{"type":"json"},"user":{"type":"relation","relation":"manyToOne","target":"plugin::users-permissions.user","inversedBy":"cartItems"},"product":{"type":"relation","relation":"manyToOne","target":"api::product.product","inversedBy":"cartItems"}},"kind":"collectionType"},"modelName":"cart-item","actions":{},"lifecycles":{}},"api::commerce-placeholder.commerce-placeholder":{"kind":"collectionType","collectionName":"commerce_placeholders","info":{"singularName":"commerce-placeholder","pluralName":"commerce-placeholders","displayName":"Commerce Placeholder"},"options":{"draftAndPublish":false},"attributes":{"name":{"type":"string"},"createdAt":{"type":"datetime"},"updatedAt":{"type":"datetime"},"publishedAt":{"type":"datetime","configurable":false,"writable":true,"visible":true},"createdBy":{"type":"relation","relation":"oneToOne","target":"admin::user","configurable":false,"writable":false,"visible":false,"useJoinTable":false,"private":true},"updatedBy":{"type":"relation","relation":"oneToOne","target":"admin::user","configurable":false,"writable":false,"visible":false,"useJoinTable":false,"private":true},"locale":{"writable":true,"private":true,"configurable":false,"visible":false,"type":"string"},"localizations":{"type":"relation","relation":"oneToMany","target":"api::commerce-placeholder.commerce-placeholder","writable":false,"private":true,"configurable":false,"visible":false,"unstable_virtual":true,"joinColumn":{"name":"document_id","referencedColumn":"document_id","referencedTable":"commerce_placeholders"}}},"apiName":"commerce-placeholder","globalId":"CommercePlaceholder","uid":"api::commerce-placeholder.commerce-placeholder","modelType":"contentType","__schema__":{"collectionName":"commerce_placeholders","info":{"singularName":"commerce-placeholder","pluralName":"commerce-placeholders","displayName":"Commerce Placeholder"},"options":{"draftAndPublish":false},"attributes":{"name":{"type":"string"}},"kind":"collectionType"},"modelName":"commerce-placeholder","actions":{},"lifecycles":{}},"api::contact-message.contact-message":{"kind":"collectionType","collectionName":"contact_messages","info":{"singularName":"contact-message","pluralName":"contact-messages","displayName":"Contact Message"},"options":{"draftAndPublish":false},"attributes":{"name":{"type":"string","required":true},"email":{"type":"email","required":true},"phone":{"type":"string"},"company":{"type":"string"},"message":{"type":"text","required":true},"isRead":{"type":"boolean","default":false},"createdAt":{"type":"datetime"},"updatedAt":{"type":"datetime"},"publishedAt":{"type":"datetime","configurable":false,"writable":true,"visible":true},"createdBy":{"type":"relation","relation":"oneToOne","target":"admin::user","configurable":false,"writable":false,"visible":false,"useJoinTable":false,"private":true},"updatedBy":{"type":"relation","relation":"oneToOne","target":"admin::user","configurable":false,"writable":false,"visible":false,"useJoinTable":false,"private":true},"locale":{"writable":true,"private":true,"configurable":false,"visible":false,"type":"string"},"localizations":{"type":"relation","relation":"oneToMany","target":"api::contact-message.contact-message","writable":false,"private":true,"configurable":false,"visible":false,"unstable_virtual":true,"joinColumn":{"name":"document_id","referencedColumn":"document_id","referencedTable":"contact_messages"}}},"apiName":"contact-message","globalId":"ContactMessage","uid":"api::contact-message.contact-message","modelType":"contentType","__schema__":{"collectionName":"contact_messages","info":{"singularName":"contact-message","pluralName":"contact-messages","displayName":"Contact Message"},"options":{"draftAndPublish":false},"attributes":{"name":{"type":"string","required":true},"email":{"type":"email","required":true},"phone":{"type":"string"},"company":{"type":"string"},"message":{"type":"text","required":true},"isRead":{"type":"boolean","default":false}},"kind":"collectionType"},"modelName":"contact-message","actions":{},"lifecycles":{}},"api::coupon-code.coupon-code":{"kind":"collectionType","collectionName":"coupon_codes","info":{"singularName":"coupon-code","pluralName":"coupon-codes","displayName":"Coupon Code"},"options":{"draftAndPublish":false},"attributes":{"code":{"type":"string","required":true,"unique":true},"description":{"type":"text"},"discountType":{"type":"enumeration","enum":["PERCENTAGE","FLAT","BUY_X_GET_Y","FREE_SHIPPING"],"required":true},"discountValue":{"type":"integer","required":true},"minCartTotal":{"type":"integer"},"maxDiscount":{"type":"integer"},"maxUses":{"type":"integer"},"usedCount":{"type":"integer","default":0},"perUserLimit":{"type":"integer","default":1},"validFrom":{"type":"datetime"},"validUntil":{"type":"datetime"},"isActive":{"type":"boolean","default":true},"applicableCategoryIds":{"type":"json"},"applicableProductIds":{"type":"json"},"usages":{"type":"relation","relation":"oneToMany","target":"api::coupon-usage.coupon-usage","mappedBy":"coupon"},"orders":{"type":"relation","relation":"oneToMany","target":"api::order.order","mappedBy":"coupon"},"createdAt":{"type":"datetime"},"updatedAt":{"type":"datetime"},"publishedAt":{"type":"datetime","configurable":false,"writable":true,"visible":true},"createdBy":{"type":"relation","relation":"oneToOne","target":"admin::user","configurable":false,"writable":false,"visible":false,"useJoinTable":false,"private":true},"updatedBy":{"type":"relation","relation":"oneToOne","target":"admin::user","configurable":false,"writable":false,"visible":false,"useJoinTable":false,"private":true},"locale":{"writable":true,"private":true,"configurable":false,"visible":false,"type":"string"},"localizations":{"type":"relation","relation":"oneToMany","target":"api::coupon-code.coupon-code","writable":false,"private":true,"configurable":false,"visible":false,"unstable_virtual":true,"joinColumn":{"name":"document_id","referencedColumn":"document_id","referencedTable":"coupon_codes"}}},"apiName":"coupon-code","globalId":"CouponCode","uid":"api::coupon-code.coupon-code","modelType":"contentType","__schema__":{"collectionName":"coupon_codes","info":{"singularName":"coupon-code","pluralName":"coupon-codes","displayName":"Coupon Code"},"options":{"draftAndPublish":false},"attributes":{"code":{"type":"string","required":true,"unique":true},"description":{"type":"text"},"discountType":{"type":"enumeration","enum":["PERCENTAGE","FLAT","BUY_X_GET_Y","FREE_SHIPPING"],"required":true},"discountValue":{"type":"integer","required":true},"minCartTotal":{"type":"integer"},"maxDiscount":{"type":"integer"},"maxUses":{"type":"integer"},"usedCount":{"type":"integer","default":0},"perUserLimit":{"type":"integer","default":1},"validFrom":{"type":"datetime"},"validUntil":{"type":"datetime"},"isActive":{"type":"boolean","default":true},"applicableCategoryIds":{"type":"json"},"applicableProductIds":{"type":"json"},"usages":{"type":"relation","relation":"oneToMany","target":"api::coupon-usage.coupon-usage","mappedBy":"coupon"},"orders":{"type":"relation","relation":"oneToMany","target":"api::order.order","mappedBy":"coupon"}},"kind":"collectionType"},"modelName":"coupon-code","actions":{},"lifecycles":{}},"api::coupon-usage.coupon-usage":{"kind":"collectionType","collectionName":"coupon_usages","info":{"singularName":"coupon-usage","pluralName":"coupon-usages","displayName":"Coupon Usage"},"options":{"draftAndPublish":false},"attributes":{"guestEmail":{"type":"email"},"discountAmount":{"type":"integer","required":true},"usedAt":{"type":"datetime"},"coupon":{"type":"relation","relation":"manyToOne","target":"api::coupon-code.coupon-code","inversedBy":"usages"},"user":{"type":"relation","relation":"manyToOne","target":"plugin::users-permissions.user","inversedBy":"couponUsages"},"order":{"type":"relation","relation":"manyToOne","target":"api::order.order","inversedBy":"couponUsages"},"createdAt":{"type":"datetime"},"updatedAt":{"type":"datetime"},"publishedAt":{"type":"datetime","configurable":false,"writable":true,"visible":true},"createdBy":{"type":"relation","relation":"oneToOne","target":"admin::user","configurable":false,"writable":false,"visible":false,"useJoinTable":false,"private":true},"updatedBy":{"type":"relation","relation":"oneToOne","target":"admin::user","configurable":false,"writable":false,"visible":false,"useJoinTable":false,"private":true},"locale":{"writable":true,"private":true,"configurable":false,"visible":false,"type":"string"},"localizations":{"type":"relation","relation":"oneToMany","target":"api::coupon-usage.coupon-usage","writable":false,"private":true,"configurable":false,"visible":false,"unstable_virtual":true,"joinColumn":{"name":"document_id","referencedColumn":"document_id","referencedTable":"coupon_usages"}}},"apiName":"coupon-usage","globalId":"CouponUsage","uid":"api::coupon-usage.coupon-usage","modelType":"contentType","__schema__":{"collectionName":"coupon_usages","info":{"singularName":"coupon-usage","pluralName":"coupon-usages","displayName":"Coupon Usage"},"options":{"draftAndPublish":false},"attributes":{"guestEmail":{"type":"email"},"discountAmount":{"type":"integer","required":true},"usedAt":{"type":"datetime"},"coupon":{"type":"relation","relation":"manyToOne","target":"api::coupon-code.coupon-code","inversedBy":"usages"},"user":{"type":"relation","relation":"manyToOne","target":"plugin::users-permissions.user","inversedBy":"couponUsages"},"order":{"type":"relation","relation":"manyToOne","target":"api::order.order","inversedBy":"couponUsages"}},"kind":"collectionType"},"modelName":"coupon-usage","actions":{},"lifecycles":{}},"api::digital-asset.digital-asset":{"kind":"collectionType","collectionName":"digital_assets","info":{"singularName":"digital-asset","pluralName":"digital-assets","displayName":"Digital Asset"},"options":{"draftAndPublish":false},"attributes":{"assetType":{"type":"enumeration","enum":["YOUTUBE_LINK","PDF","EBOOK"],"required":true},"url":{"type":"string","required":true},"fileName":{"type":"string"},"fileSize":{"type":"integer"},"accessInstructions":{"type":"text"},"product":{"type":"relation","relation":"manyToOne","target":"api::product.product","inversedBy":"digitalAssets"},"purchases":{"type":"relation","relation":"oneToMany","target":"api::digital-purchase.digital-purchase","mappedBy":"asset"},"createdAt":{"type":"datetime"},"updatedAt":{"type":"datetime"},"publishedAt":{"type":"datetime","configurable":false,"writable":true,"visible":true},"createdBy":{"type":"relation","relation":"oneToOne","target":"admin::user","configurable":false,"writable":false,"visible":false,"useJoinTable":false,"private":true},"updatedBy":{"type":"relation","relation":"oneToOne","target":"admin::user","configurable":false,"writable":false,"visible":false,"useJoinTable":false,"private":true},"locale":{"writable":true,"private":true,"configurable":false,"visible":false,"type":"string"},"localizations":{"type":"relation","relation":"oneToMany","target":"api::digital-asset.digital-asset","writable":false,"private":true,"configurable":false,"visible":false,"unstable_virtual":true,"joinColumn":{"name":"document_id","referencedColumn":"document_id","referencedTable":"digital_assets"}}},"apiName":"digital-asset","globalId":"DigitalAsset","uid":"api::digital-asset.digital-asset","modelType":"contentType","__schema__":{"collectionName":"digital_assets","info":{"singularName":"digital-asset","pluralName":"digital-assets","displayName":"Digital Asset"},"options":{"draftAndPublish":false},"attributes":{"assetType":{"type":"enumeration","enum":["YOUTUBE_LINK","PDF","EBOOK"],"required":true},"url":{"type":"string","required":true},"fileName":{"type":"string"},"fileSize":{"type":"integer"},"accessInstructions":{"type":"text"},"product":{"type":"relation","relation":"manyToOne","target":"api::product.product","inversedBy":"digitalAssets"},"purchases":{"type":"relation","relation":"oneToMany","target":"api::digital-purchase.digital-purchase","mappedBy":"asset"}},"kind":"collectionType"},"modelName":"digital-asset","actions":{},"lifecycles":{}},"api::digital-purchase.digital-purchase":{"kind":"collectionType","collectionName":"digital_purchases","info":{"singularName":"digital-purchase","pluralName":"digital-purchases","displayName":"Digital Purchase"},"options":{"draftAndPublish":false},"attributes":{"guestEmail":{"type":"email"},"accessGrantedAt":{"type":"datetime"},"accessUrl":{"type":"string"},"expiresAt":{"type":"datetime"},"user":{"type":"relation","relation":"manyToOne","target":"plugin::users-permissions.user","inversedBy":"digitalPurchases"},"order":{"type":"relation","relation":"manyToOne","target":"api::order.order","inversedBy":"digitalPurchases"},"product":{"type":"relation","relation":"manyToOne","target":"api::product.product","inversedBy":"digitalPurchases"},"asset":{"type":"relation","relation":"manyToOne","target":"api::digital-asset.digital-asset","inversedBy":"purchases"},"createdAt":{"type":"datetime"},"updatedAt":{"type":"datetime"},"publishedAt":{"type":"datetime","configurable":false,"writable":true,"visible":true},"createdBy":{"type":"relation","relation":"oneToOne","target":"admin::user","configurable":false,"writable":false,"visible":false,"useJoinTable":false,"private":true},"updatedBy":{"type":"relation","relation":"oneToOne","target":"admin::user","configurable":false,"writable":false,"visible":false,"useJoinTable":false,"private":true},"locale":{"writable":true,"private":true,"configurable":false,"visible":false,"type":"string"},"localizations":{"type":"relation","relation":"oneToMany","target":"api::digital-purchase.digital-purchase","writable":false,"private":true,"configurable":false,"visible":false,"unstable_virtual":true,"joinColumn":{"name":"document_id","referencedColumn":"document_id","referencedTable":"digital_purchases"}}},"apiName":"digital-purchase","globalId":"DigitalPurchase","uid":"api::digital-purchase.digital-purchase","modelType":"contentType","__schema__":{"collectionName":"digital_purchases","info":{"singularName":"digital-purchase","pluralName":"digital-purchases","displayName":"Digital Purchase"},"options":{"draftAndPublish":false},"attributes":{"guestEmail":{"type":"email"},"accessGrantedAt":{"type":"datetime"},"accessUrl":{"type":"string"},"expiresAt":{"type":"datetime"},"user":{"type":"relation","relation":"manyToOne","target":"plugin::users-permissions.user","inversedBy":"digitalPurchases"},"order":{"type":"relation","relation":"manyToOne","target":"api::order.order","inversedBy":"digitalPurchases"},"product":{"type":"relation","relation":"manyToOne","target":"api::product.product","inversedBy":"digitalPurchases"},"asset":{"type":"relation","relation":"manyToOne","target":"api::digital-asset.digital-asset","inversedBy":"purchases"}},"kind":"collectionType"},"modelName":"digital-purchase","actions":{},"lifecycles":{}},"api::email-log.email-log":{"kind":"collectionType","collectionName":"email_logs","info":{"singularName":"email-log","pluralName":"email-logs","displayName":"Email Log"},"options":{"draftAndPublish":false},"attributes":{"to":{"type":"string","required":true},"subject":{"type":"string","required":true},"templateName":{"type":"string","required":true},"status":{"type":"enumeration","enum":["SENT","FAILED"],"required":true},"relatedType":{"type":"enumeration","enum":["ORDER","BOOKING","CONTACT","REFUND"]},"relatedId":{"type":"string"},"error":{"type":"text"},"sentAt":{"type":"datetime"},"createdAt":{"type":"datetime"},"updatedAt":{"type":"datetime"},"publishedAt":{"type":"datetime","configurable":false,"writable":true,"visible":true},"createdBy":{"type":"relation","relation":"oneToOne","target":"admin::user","configurable":false,"writable":false,"visible":false,"useJoinTable":false,"private":true},"updatedBy":{"type":"relation","relation":"oneToOne","target":"admin::user","configurable":false,"writable":false,"visible":false,"useJoinTable":false,"private":true},"locale":{"writable":true,"private":true,"configurable":false,"visible":false,"type":"string"},"localizations":{"type":"relation","relation":"oneToMany","target":"api::email-log.email-log","writable":false,"private":true,"configurable":false,"visible":false,"unstable_virtual":true,"joinColumn":{"name":"document_id","referencedColumn":"document_id","referencedTable":"email_logs"}}},"apiName":"email-log","globalId":"EmailLog","uid":"api::email-log.email-log","modelType":"contentType","__schema__":{"collectionName":"email_logs","info":{"singularName":"email-log","pluralName":"email-logs","displayName":"Email Log"},"options":{"draftAndPublish":false},"attributes":{"to":{"type":"string","required":true},"subject":{"type":"string","required":true},"templateName":{"type":"string","required":true},"status":{"type":"enumeration","enum":["SENT","FAILED"],"required":true},"relatedType":{"type":"enumeration","enum":["ORDER","BOOKING","CONTACT","REFUND"]},"relatedId":{"type":"string"},"error":{"type":"text"},"sentAt":{"type":"datetime"}},"kind":"collectionType"},"modelName":"email-log","actions":{},"lifecycles":{}},"api::invoice.invoice":{"kind":"collectionType","collectionName":"invoices","info":{"singularName":"invoice","pluralName":"invoices","displayName":"Invoice"},"options":{"draftAndPublish":false},"attributes":{"invoiceNumber":{"type":"string","required":true,"unique":true},"invoiceDate":{"type":"datetime"},"buyerName":{"type":"string","required":true},"buyerAddress":{"type":"json","required":true},"buyerGstin":{"type":"string"},"buyerState":{"type":"string","required":true},"buyerStateCode":{"type":"string","required":true},"items":{"type":"json","required":true},"subtotal":{"type":"integer","required":true},"cgst":{"type":"integer","required":true},"sgst":{"type":"integer","required":true},"igst":{"type":"integer","required":true},"totalTax":{"type":"integer","required":true},"grandTotal":{"type":"integer","required":true},"placeOfSupply":{"type":"string","required":true},"isInterState":{"type":"boolean","required":true},"pdfUrl":{"type":"string"},"order":{"type":"relation","relation":"oneToOne","target":"api::order.order","inversedBy":"invoice"},"createdAt":{"type":"datetime"},"updatedAt":{"type":"datetime"},"publishedAt":{"type":"datetime","configurable":false,"writable":true,"visible":true},"createdBy":{"type":"relation","relation":"oneToOne","target":"admin::user","configurable":false,"writable":false,"visible":false,"useJoinTable":false,"private":true},"updatedBy":{"type":"relation","relation":"oneToOne","target":"admin::user","configurable":false,"writable":false,"visible":false,"useJoinTable":false,"private":true},"locale":{"writable":true,"private":true,"configurable":false,"visible":false,"type":"string"},"localizations":{"type":"relation","relation":"oneToMany","target":"api::invoice.invoice","writable":false,"private":true,"configurable":false,"visible":false,"unstable_virtual":true,"joinColumn":{"name":"document_id","referencedColumn":"document_id","referencedTable":"invoices"}}},"apiName":"invoice","globalId":"Invoice","uid":"api::invoice.invoice","modelType":"contentType","__schema__":{"collectionName":"invoices","info":{"singularName":"invoice","pluralName":"invoices","displayName":"Invoice"},"options":{"draftAndPublish":false},"attributes":{"invoiceNumber":{"type":"string","required":true,"unique":true},"invoiceDate":{"type":"datetime"},"buyerName":{"type":"string","required":true},"buyerAddress":{"type":"json","required":true},"buyerGstin":{"type":"string"},"buyerState":{"type":"string","required":true},"buyerStateCode":{"type":"string","required":true},"items":{"type":"json","required":true},"subtotal":{"type":"integer","required":true},"cgst":{"type":"integer","required":true},"sgst":{"type":"integer","required":true},"igst":{"type":"integer","required":true},"totalTax":{"type":"integer","required":true},"grandTotal":{"type":"integer","required":true},"placeOfSupply":{"type":"string","required":true},"isInterState":{"type":"boolean","required":true},"pdfUrl":{"type":"string"},"order":{"type":"relation","relation":"oneToOne","target":"api::order.order","inversedBy":"invoice"}},"kind":"collectionType"},"modelName":"invoice","actions":{},"lifecycles":{}},"api::legal-page.legal-page":{"kind":"collectionType","collectionName":"legal_pages","info":{"singularName":"legal-page","pluralName":"legal-pages","displayName":"Legal Page"},"options":{"draftAndPublish":false},"attributes":{"slug":{"type":"string","required":true,"unique":true},"title":{"type":"string","required":true},"content":{"type":"text","required":true},"createdAt":{"type":"datetime"},"updatedAt":{"type":"datetime"},"publishedAt":{"type":"datetime","configurable":false,"writable":true,"visible":true},"createdBy":{"type":"relation","relation":"oneToOne","target":"admin::user","configurable":false,"writable":false,"visible":false,"useJoinTable":false,"private":true},"updatedBy":{"type":"relation","relation":"oneToOne","target":"admin::user","configurable":false,"writable":false,"visible":false,"useJoinTable":false,"private":true},"locale":{"writable":true,"private":true,"configurable":false,"visible":false,"type":"string"},"localizations":{"type":"relation","relation":"oneToMany","target":"api::legal-page.legal-page","writable":false,"private":true,"configurable":false,"visible":false,"unstable_virtual":true,"joinColumn":{"name":"document_id","referencedColumn":"document_id","referencedTable":"legal_pages"}}},"apiName":"legal-page","globalId":"LegalPage","uid":"api::legal-page.legal-page","modelType":"contentType","__schema__":{"collectionName":"legal_pages","info":{"singularName":"legal-page","pluralName":"legal-pages","displayName":"Legal Page"},"options":{"draftAndPublish":false},"attributes":{"slug":{"type":"string","required":true,"unique":true},"title":{"type":"string","required":true},"content":{"type":"text","required":true}},"kind":"collectionType"},"modelName":"legal-page","actions":{},"lifecycles":{}},"api::order.order":{"kind":"collectionType","collectionName":"orders","info":{"singularName":"order","pluralName":"orders","displayName":"Order"},"options":{"draftAndPublish":false},"attributes":{"guestName":{"type":"string"},"guestEmail":{"type":"email"},"guestPhone":{"type":"string"},"status":{"type":"enumeration","enum":["PENDING","PROCESSING","SHIPPED","DELIVERED","CANCELLED","REFUNDED"],"default":"PENDING"},"subtotal":{"type":"integer","required":true},"discount":{"type":"integer","default":0},"tax":{"type":"integer","default":0},"shippingAmount":{"type":"integer","default":0},"total":{"type":"integer","required":true},"rzpOrderId":{"type":"string"},"rzpPaymentId":{"type":"string"},"rzpSignature":{"type":"text"},"paymentStatus":{"type":"enumeration","enum":["PENDING","PAID","FAILED","REFUNDED"],"default":"PENDING"},"paymentMethod":{"type":"string"},"refundId":{"type":"string"},"refundStatus":{"type":"string"},"refundAmount":{"type":"integer"},"shippingAddress":{"type":"json"},"billingAddress":{"type":"json"},"notes":{"type":"text"},"legacyId":{"type":"string"},"user":{"type":"relation","relation":"manyToOne","target":"plugin::users-permissions.user","inversedBy":"orders"},"coupon":{"type":"relation","relation":"manyToOne","target":"api::coupon-code.coupon-code","inversedBy":"orders"},"items":{"type":"relation","relation":"oneToMany","target":"api::order-item.order-item","mappedBy":"order"},"invoice":{"type":"relation","relation":"oneToOne","target":"api::invoice.invoice","mappedBy":"order"},"shipment":{"type":"relation","relation":"oneToOne","target":"api::order-shipment.order-shipment","mappedBy":"order"},"digitalPurchases":{"type":"relation","relation":"oneToMany","target":"api::digital-purchase.digital-purchase","mappedBy":"order"},"couponUsages":{"type":"relation","relation":"oneToMany","target":"api::coupon-usage.coupon-usage","mappedBy":"order"},"createdAt":{"type":"datetime"},"updatedAt":{"type":"datetime"},"publishedAt":{"type":"datetime","configurable":false,"writable":true,"visible":true},"createdBy":{"type":"relation","relation":"oneToOne","target":"admin::user","configurable":false,"writable":false,"visible":false,"useJoinTable":false,"private":true},"updatedBy":{"type":"relation","relation":"oneToOne","target":"admin::user","configurable":false,"writable":false,"visible":false,"useJoinTable":false,"private":true},"locale":{"writable":true,"private":true,"configurable":false,"visible":false,"type":"string"},"localizations":{"type":"relation","relation":"oneToMany","target":"api::order.order","writable":false,"private":true,"configurable":false,"visible":false,"unstable_virtual":true,"joinColumn":{"name":"document_id","referencedColumn":"document_id","referencedTable":"orders"}}},"apiName":"order","globalId":"Order","uid":"api::order.order","modelType":"contentType","__schema__":{"collectionName":"orders","info":{"singularName":"order","pluralName":"orders","displayName":"Order"},"options":{"draftAndPublish":false},"attributes":{"guestName":{"type":"string"},"guestEmail":{"type":"email"},"guestPhone":{"type":"string"},"status":{"type":"enumeration","enum":["PENDING","PROCESSING","SHIPPED","DELIVERED","CANCELLED","REFUNDED"],"default":"PENDING"},"subtotal":{"type":"integer","required":true},"discount":{"type":"integer","default":0},"tax":{"type":"integer","default":0},"shippingAmount":{"type":"integer","default":0},"total":{"type":"integer","required":true},"rzpOrderId":{"type":"string"},"rzpPaymentId":{"type":"string"},"rzpSignature":{"type":"text"},"paymentStatus":{"type":"enumeration","enum":["PENDING","PAID","FAILED","REFUNDED"],"default":"PENDING"},"paymentMethod":{"type":"string"},"refundId":{"type":"string"},"refundStatus":{"type":"string"},"refundAmount":{"type":"integer"},"shippingAddress":{"type":"json"},"billingAddress":{"type":"json"},"notes":{"type":"text"},"legacyId":{"type":"string"},"user":{"type":"relation","relation":"manyToOne","target":"plugin::users-permissions.user","inversedBy":"orders"},"coupon":{"type":"relation","relation":"manyToOne","target":"api::coupon-code.coupon-code","inversedBy":"orders"},"items":{"type":"relation","relation":"oneToMany","target":"api::order-item.order-item","mappedBy":"order"},"invoice":{"type":"relation","relation":"oneToOne","target":"api::invoice.invoice","mappedBy":"order"},"shipment":{"type":"relation","relation":"oneToOne","target":"api::order-shipment.order-shipment","mappedBy":"order"},"digitalPurchases":{"type":"relation","relation":"oneToMany","target":"api::digital-purchase.digital-purchase","mappedBy":"order"},"couponUsages":{"type":"relation","relation":"oneToMany","target":"api::coupon-usage.coupon-usage","mappedBy":"order"}},"kind":"collectionType"},"modelName":"order","actions":{},"lifecycles":{}},"api::order-item.order-item":{"kind":"collectionType","collectionName":"order_items","info":{"singularName":"order-item","pluralName":"order-items","displayName":"Order Item"},"options":{"draftAndPublish":false},"attributes":{"variantSelection":{"type":"json"},"quantity":{"type":"integer","required":true},"unitPrice":{"type":"integer","required":true},"gstRateBps":{"type":"integer","default":1800},"hsnCode":{"type":"string"},"order":{"type":"relation","relation":"manyToOne","target":"api::order.order","inversedBy":"items"},"product":{"type":"relation","relation":"manyToOne","target":"api::product.product","inversedBy":"orderItems"},"createdAt":{"type":"datetime"},"updatedAt":{"type":"datetime"},"publishedAt":{"type":"datetime","configurable":false,"writable":true,"visible":true},"createdBy":{"type":"relation","relation":"oneToOne","target":"admin::user","configurable":false,"writable":false,"visible":false,"useJoinTable":false,"private":true},"updatedBy":{"type":"relation","relation":"oneToOne","target":"admin::user","configurable":false,"writable":false,"visible":false,"useJoinTable":false,"private":true},"locale":{"writable":true,"private":true,"configurable":false,"visible":false,"type":"string"},"localizations":{"type":"relation","relation":"oneToMany","target":"api::order-item.order-item","writable":false,"private":true,"configurable":false,"visible":false,"unstable_virtual":true,"joinColumn":{"name":"document_id","referencedColumn":"document_id","referencedTable":"order_items"}}},"apiName":"order-item","globalId":"OrderItem","uid":"api::order-item.order-item","modelType":"contentType","__schema__":{"collectionName":"order_items","info":{"singularName":"order-item","pluralName":"order-items","displayName":"Order Item"},"options":{"draftAndPublish":false},"attributes":{"variantSelection":{"type":"json"},"quantity":{"type":"integer","required":true},"unitPrice":{"type":"integer","required":true},"gstRateBps":{"type":"integer","default":1800},"hsnCode":{"type":"string"},"order":{"type":"relation","relation":"manyToOne","target":"api::order.order","inversedBy":"items"},"product":{"type":"relation","relation":"manyToOne","target":"api::product.product","inversedBy":"orderItems"}},"kind":"collectionType"},"modelName":"order-item","actions":{},"lifecycles":{}},"api::order-shipment.order-shipment":{"kind":"collectionType","collectionName":"order_shipments","info":{"singularName":"order-shipment","pluralName":"order-shipments","displayName":"Order Shipment"},"options":{"draftAndPublish":false},"attributes":{"courierName":{"type":"string"},"trackingNumber":{"type":"string"},"trackingUrl":{"type":"string"},"shippedAt":{"type":"datetime"},"deliveredAt":{"type":"datetime"},"notes":{"type":"text"},"order":{"type":"relation","relation":"oneToOne","target":"api::order.order","inversedBy":"shipment"},"createdAt":{"type":"datetime"},"updatedAt":{"type":"datetime"},"publishedAt":{"type":"datetime","configurable":false,"writable":true,"visible":true},"createdBy":{"type":"relation","relation":"oneToOne","target":"admin::user","configurable":false,"writable":false,"visible":false,"useJoinTable":false,"private":true},"updatedBy":{"type":"relation","relation":"oneToOne","target":"admin::user","configurable":false,"writable":false,"visible":false,"useJoinTable":false,"private":true},"locale":{"writable":true,"private":true,"configurable":false,"visible":false,"type":"string"},"localizations":{"type":"relation","relation":"oneToMany","target":"api::order-shipment.order-shipment","writable":false,"private":true,"configurable":false,"visible":false,"unstable_virtual":true,"joinColumn":{"name":"document_id","referencedColumn":"document_id","referencedTable":"order_shipments"}}},"apiName":"order-shipment","globalId":"OrderShipment","uid":"api::order-shipment.order-shipment","modelType":"contentType","__schema__":{"collectionName":"order_shipments","info":{"singularName":"order-shipment","pluralName":"order-shipments","displayName":"Order Shipment"},"options":{"draftAndPublish":false},"attributes":{"courierName":{"type":"string"},"trackingNumber":{"type":"string"},"trackingUrl":{"type":"string"},"shippedAt":{"type":"datetime"},"deliveredAt":{"type":"datetime"},"notes":{"type":"text"},"order":{"type":"relation","relation":"oneToOne","target":"api::order.order","inversedBy":"shipment"}},"kind":"collectionType"},"modelName":"order-shipment","actions":{},"lifecycles":{}},"api::password-reset-token.password-reset-token":{"kind":"collectionType","collectionName":"password_reset_tokens","info":{"singularName":"password-reset-token","pluralName":"password-reset-tokens","displayName":"Password Reset Token"},"options":{"draftAndPublish":false},"attributes":{"token":{"type":"string","required":true,"unique":true},"expiresAt":{"type":"datetime","required":true},"user":{"type":"relation","relation":"manyToOne","target":"plugin::users-permissions.user","inversedBy":"passwordResetTokens"},"createdAt":{"type":"datetime"},"updatedAt":{"type":"datetime"},"publishedAt":{"type":"datetime","configurable":false,"writable":true,"visible":true},"createdBy":{"type":"relation","relation":"oneToOne","target":"admin::user","configurable":false,"writable":false,"visible":false,"useJoinTable":false,"private":true},"updatedBy":{"type":"relation","relation":"oneToOne","target":"admin::user","configurable":false,"writable":false,"visible":false,"useJoinTable":false,"private":true},"locale":{"writable":true,"private":true,"configurable":false,"visible":false,"type":"string"},"localizations":{"type":"relation","relation":"oneToMany","target":"api::password-reset-token.password-reset-token","writable":false,"private":true,"configurable":false,"visible":false,"unstable_virtual":true,"joinColumn":{"name":"document_id","referencedColumn":"document_id","referencedTable":"password_reset_tokens"}}},"apiName":"password-reset-token","globalId":"PasswordResetToken","uid":"api::password-reset-token.password-reset-token","modelType":"contentType","__schema__":{"collectionName":"password_reset_tokens","info":{"singularName":"password-reset-token","pluralName":"password-reset-tokens","displayName":"Password Reset Token"},"options":{"draftAndPublish":false},"attributes":{"token":{"type":"string","required":true,"unique":true},"expiresAt":{"type":"datetime","required":true},"user":{"type":"relation","relation":"manyToOne","target":"plugin::users-permissions.user","inversedBy":"passwordResetTokens"}},"kind":"collectionType"},"modelName":"password-reset-token","actions":{},"lifecycles":{}},"api::popup.popup":{"kind":"collectionType","collectionName":"popups","info":{"singularName":"popup","pluralName":"popups","displayName":"Popup"},"options":{"draftAndPublish":false},"attributes":{"title":{"type":"string","required":true},"content":{"type":"text","required":true},"imageUrl":{"type":"string"},"linkUrl":{"type":"string"},"triggerType":{"type":"enumeration","enum":["PAGE_LOAD","EXIT_INTENT","SCROLL_DEPTH","TIMED"],"required":true},"triggerValue":{"type":"integer"},"showOnPages":{"type":"json"},"frequency":{"type":"enumeration","enum":["ONCE","SESSION","ALWAYS"],"default":"SESSION"},"startDate":{"type":"datetime"},"endDate":{"type":"datetime"},"isActive":{"type":"boolean","default":true},"createdAt":{"type":"datetime"},"updatedAt":{"type":"datetime"},"publishedAt":{"type":"datetime","configurable":false,"writable":true,"visible":true},"createdBy":{"type":"relation","relation":"oneToOne","target":"admin::user","configurable":false,"writable":false,"visible":false,"useJoinTable":false,"private":true},"updatedBy":{"type":"relation","relation":"oneToOne","target":"admin::user","configurable":false,"writable":false,"visible":false,"useJoinTable":false,"private":true},"locale":{"writable":true,"private":true,"configurable":false,"visible":false,"type":"string"},"localizations":{"type":"relation","relation":"oneToMany","target":"api::popup.popup","writable":false,"private":true,"configurable":false,"visible":false,"unstable_virtual":true,"joinColumn":{"name":"document_id","referencedColumn":"document_id","referencedTable":"popups"}}},"apiName":"popup","globalId":"Popup","uid":"api::popup.popup","modelType":"contentType","__schema__":{"collectionName":"popups","info":{"singularName":"popup","pluralName":"popups","displayName":"Popup"},"options":{"draftAndPublish":false},"attributes":{"title":{"type":"string","required":true},"content":{"type":"text","required":true},"imageUrl":{"type":"string"},"linkUrl":{"type":"string"},"triggerType":{"type":"enumeration","enum":["PAGE_LOAD","EXIT_INTENT","SCROLL_DEPTH","TIMED"],"required":true},"triggerValue":{"type":"integer"},"showOnPages":{"type":"json"},"frequency":{"type":"enumeration","enum":["ONCE","SESSION","ALWAYS"],"default":"SESSION"},"startDate":{"type":"datetime"},"endDate":{"type":"datetime"},"isActive":{"type":"boolean","default":true}},"kind":"collectionType"},"modelName":"popup","actions":{},"lifecycles":{}},"api::product.product":{"kind":"collectionType","collectionName":"products","info":{"singularName":"product","pluralName":"products","displayName":"Product"},"options":{"draftAndPublish":false},"attributes":{"name":{"type":"string","required":true},"slug":{"type":"string","required":true,"unique":true},"description":{"type":"text","required":true},"productType":{"type":"enumeration","enum":["PHYSICAL","DIGITAL"],"default":"PHYSICAL","required":true},"price":{"type":"integer","required":true},"salePrice":{"type":"integer"},"stock":{"type":"integer","default":0},"images":{"type":"json"},"healingProperties":{"type":"text"},"wearHand":{"type":"string"},"hsnCode":{"type":"string"},"gstRateBps":{"type":"integer","default":1800},"isActive":{"type":"boolean","default":true},"category":{"type":"relation","relation":"manyToOne","target":"api::product-category.product-category","inversedBy":"products"},"shippingClass":{"type":"relation","relation":"manyToOne","target":"api::shipping-class.shipping-class","inversedBy":"products"},"variants":{"type":"relation","relation":"oneToMany","target":"api::product-variant.product-variant","mappedBy":"product"},"digitalAssets":{"type":"relation","relation":"oneToMany","target":"api::digital-asset.digital-asset","mappedBy":"product"},"cartItems":{"type":"relation","relation":"oneToMany","target":"api::cart-item.cart-item","mappedBy":"product"},"wishlistItems":{"type":"relation","relation":"oneToMany","target":"api::wishlist-item.wishlist-item","mappedBy":"product"},"orderItems":{"type":"relation","relation":"oneToMany","target":"api::order-item.order-item","mappedBy":"product"},"reviews":{"type":"relation","relation":"oneToMany","target":"api::review.review","mappedBy":"product"},"digitalPurchases":{"type":"relation","relation":"oneToMany","target":"api::digital-purchase.digital-purchase","mappedBy":"product"},"createdAt":{"type":"datetime"},"updatedAt":{"type":"datetime"},"publishedAt":{"type":"datetime","configurable":false,"writable":true,"visible":true},"createdBy":{"type":"relation","relation":"oneToOne","target":"admin::user","configurable":false,"writable":false,"visible":false,"useJoinTable":false,"private":true},"updatedBy":{"type":"relation","relation":"oneToOne","target":"admin::user","configurable":false,"writable":false,"visible":false,"useJoinTable":false,"private":true},"locale":{"writable":true,"private":true,"configurable":false,"visible":false,"type":"string"},"localizations":{"type":"relation","relation":"oneToMany","target":"api::product.product","writable":false,"private":true,"configurable":false,"visible":false,"unstable_virtual":true,"joinColumn":{"name":"document_id","referencedColumn":"document_id","referencedTable":"products"}}},"apiName":"product","globalId":"Product","uid":"api::product.product","modelType":"contentType","__schema__":{"collectionName":"products","info":{"singularName":"product","pluralName":"products","displayName":"Product"},"options":{"draftAndPublish":false},"attributes":{"name":{"type":"string","required":true},"slug":{"type":"string","required":true,"unique":true},"description":{"type":"text","required":true},"productType":{"type":"enumeration","enum":["PHYSICAL","DIGITAL"],"default":"PHYSICAL","required":true},"price":{"type":"integer","required":true},"salePrice":{"type":"integer"},"stock":{"type":"integer","default":0},"images":{"type":"json"},"healingProperties":{"type":"text"},"wearHand":{"type":"string"},"hsnCode":{"type":"string"},"gstRateBps":{"type":"integer","default":1800},"isActive":{"type":"boolean","default":true},"category":{"type":"relation","relation":"manyToOne","target":"api::product-category.product-category","inversedBy":"products"},"shippingClass":{"type":"relation","relation":"manyToOne","target":"api::shipping-class.shipping-class","inversedBy":"products"},"variants":{"type":"relation","relation":"oneToMany","target":"api::product-variant.product-variant","mappedBy":"product"},"digitalAssets":{"type":"relation","relation":"oneToMany","target":"api::digital-asset.digital-asset","mappedBy":"product"},"cartItems":{"type":"relation","relation":"oneToMany","target":"api::cart-item.cart-item","mappedBy":"product"},"wishlistItems":{"type":"relation","relation":"oneToMany","target":"api::wishlist-item.wishlist-item","mappedBy":"product"},"orderItems":{"type":"relation","relation":"oneToMany","target":"api::order-item.order-item","mappedBy":"product"},"reviews":{"type":"relation","relation":"oneToMany","target":"api::review.review","mappedBy":"product"},"digitalPurchases":{"type":"relation","relation":"oneToMany","target":"api::digital-purchase.digital-purchase","mappedBy":"product"}},"kind":"collectionType"},"modelName":"product","actions":{},"lifecycles":{}},"api::product-category.product-category":{"kind":"collectionType","collectionName":"product_categories","info":{"singularName":"product-category","pluralName":"product-categories","displayName":"Product Category"},"options":{"draftAndPublish":false},"attributes":{"name":{"type":"string","required":true},"slug":{"type":"string","required":true,"unique":true},"sortOrder":{"type":"integer","default":0},"products":{"type":"relation","relation":"oneToMany","target":"api::product.product","mappedBy":"category"},"createdAt":{"type":"datetime"},"updatedAt":{"type":"datetime"},"publishedAt":{"type":"datetime","configurable":false,"writable":true,"visible":true},"createdBy":{"type":"relation","relation":"oneToOne","target":"admin::user","configurable":false,"writable":false,"visible":false,"useJoinTable":false,"private":true},"updatedBy":{"type":"relation","relation":"oneToOne","target":"admin::user","configurable":false,"writable":false,"visible":false,"useJoinTable":false,"private":true},"locale":{"writable":true,"private":true,"configurable":false,"visible":false,"type":"string"},"localizations":{"type":"relation","relation":"oneToMany","target":"api::product-category.product-category","writable":false,"private":true,"configurable":false,"visible":false,"unstable_virtual":true,"joinColumn":{"name":"document_id","referencedColumn":"document_id","referencedTable":"product_categories"}}},"apiName":"product-category","globalId":"ProductCategory","uid":"api::product-category.product-category","modelType":"contentType","__schema__":{"collectionName":"product_categories","info":{"singularName":"product-category","pluralName":"product-categories","displayName":"Product Category"},"options":{"draftAndPublish":false},"attributes":{"name":{"type":"string","required":true},"slug":{"type":"string","required":true,"unique":true},"sortOrder":{"type":"integer","default":0},"products":{"type":"relation","relation":"oneToMany","target":"api::product.product","mappedBy":"category"}},"kind":"collectionType"},"modelName":"product-category","actions":{},"lifecycles":{}},"api::product-variant.product-variant":{"kind":"collectionType","collectionName":"product_variants","info":{"singularName":"product-variant","pluralName":"product-variants","displayName":"Product Variant"},"options":{"draftAndPublish":false},"attributes":{"name":{"type":"string","required":true},"options":{"type":"json","required":true},"product":{"type":"relation","relation":"manyToOne","target":"api::product.product","inversedBy":"variants"},"createdAt":{"type":"datetime"},"updatedAt":{"type":"datetime"},"publishedAt":{"type":"datetime","configurable":false,"writable":true,"visible":true},"createdBy":{"type":"relation","relation":"oneToOne","target":"admin::user","configurable":false,"writable":false,"visible":false,"useJoinTable":false,"private":true},"updatedBy":{"type":"relation","relation":"oneToOne","target":"admin::user","configurable":false,"writable":false,"visible":false,"useJoinTable":false,"private":true},"locale":{"writable":true,"private":true,"configurable":false,"visible":false,"type":"string"},"localizations":{"type":"relation","relation":"oneToMany","target":"api::product-variant.product-variant","writable":false,"private":true,"configurable":false,"visible":false,"unstable_virtual":true,"joinColumn":{"name":"document_id","referencedColumn":"document_id","referencedTable":"product_variants"}}},"apiName":"product-variant","globalId":"ProductVariant","uid":"api::product-variant.product-variant","modelType":"contentType","__schema__":{"collectionName":"product_variants","info":{"singularName":"product-variant","pluralName":"product-variants","displayName":"Product Variant"},"options":{"draftAndPublish":false},"attributes":{"name":{"type":"string","required":true},"options":{"type":"json","required":true},"product":{"type":"relation","relation":"manyToOne","target":"api::product.product","inversedBy":"variants"}},"kind":"collectionType"},"modelName":"product-variant","actions":{},"lifecycles":{}},"api::promo-rule.promo-rule":{"kind":"collectionType","collectionName":"promo_rules","info":{"singularName":"promo-rule","pluralName":"promo-rules","displayName":"Promo Rule"},"options":{"draftAndPublish":false},"attributes":{"type":{"type":"enumeration","enum":["BUY_X_GET_Y","FREE_GIFT_THRESHOLD"],"required":true},"config":{"type":"json","required":true},"isActive":{"type":"boolean","default":true},"createdAt":{"type":"datetime"},"updatedAt":{"type":"datetime"},"publishedAt":{"type":"datetime","configurable":false,"writable":true,"visible":true},"createdBy":{"type":"relation","relation":"oneToOne","target":"admin::user","configurable":false,"writable":false,"visible":false,"useJoinTable":false,"private":true},"updatedBy":{"type":"relation","relation":"oneToOne","target":"admin::user","configurable":false,"writable":false,"visible":false,"useJoinTable":false,"private":true},"locale":{"writable":true,"private":true,"configurable":false,"visible":false,"type":"string"},"localizations":{"type":"relation","relation":"oneToMany","target":"api::promo-rule.promo-rule","writable":false,"private":true,"configurable":false,"visible":false,"unstable_virtual":true,"joinColumn":{"name":"document_id","referencedColumn":"document_id","referencedTable":"promo_rules"}}},"apiName":"promo-rule","globalId":"PromoRule","uid":"api::promo-rule.promo-rule","modelType":"contentType","__schema__":{"collectionName":"promo_rules","info":{"singularName":"promo-rule","pluralName":"promo-rules","displayName":"Promo Rule"},"options":{"draftAndPublish":false},"attributes":{"type":{"type":"enumeration","enum":["BUY_X_GET_Y","FREE_GIFT_THRESHOLD"],"required":true},"config":{"type":"json","required":true},"isActive":{"type":"boolean","default":true}},"kind":"collectionType"},"modelName":"promo-rule","actions":{},"lifecycles":{}},"api::review.review":{"kind":"collectionType","collectionName":"reviews","info":{"singularName":"review","pluralName":"reviews","displayName":"Review"},"options":{"draftAndPublish":false},"attributes":{"rating":{"type":"integer","required":true,"min":1,"max":5},"comment":{"type":"text","required":true},"user":{"type":"relation","relation":"manyToOne","target":"plugin::users-permissions.user","inversedBy":"reviews"},"product":{"type":"relation","relation":"manyToOne","target":"api::product.product","inversedBy":"reviews"},"createdAt":{"type":"datetime"},"updatedAt":{"type":"datetime"},"publishedAt":{"type":"datetime","configurable":false,"writable":true,"visible":true},"createdBy":{"type":"relation","relation":"oneToOne","target":"admin::user","configurable":false,"writable":false,"visible":false,"useJoinTable":false,"private":true},"updatedBy":{"type":"relation","relation":"oneToOne","target":"admin::user","configurable":false,"writable":false,"visible":false,"useJoinTable":false,"private":true},"locale":{"writable":true,"private":true,"configurable":false,"visible":false,"type":"string"},"localizations":{"type":"relation","relation":"oneToMany","target":"api::review.review","writable":false,"private":true,"configurable":false,"visible":false,"unstable_virtual":true,"joinColumn":{"name":"document_id","referencedColumn":"document_id","referencedTable":"reviews"}}},"apiName":"review","globalId":"Review","uid":"api::review.review","modelType":"contentType","__schema__":{"collectionName":"reviews","info":{"singularName":"review","pluralName":"reviews","displayName":"Review"},"options":{"draftAndPublish":false},"attributes":{"rating":{"type":"integer","required":true,"min":1,"max":5},"comment":{"type":"text","required":true},"user":{"type":"relation","relation":"manyToOne","target":"plugin::users-permissions.user","inversedBy":"reviews"},"product":{"type":"relation","relation":"manyToOne","target":"api::product.product","inversedBy":"reviews"}},"kind":"collectionType"},"modelName":"review","actions":{},"lifecycles":{}},"api::scheduled-reminder.scheduled-reminder":{"kind":"collectionType","collectionName":"scheduled_reminders","info":{"singularName":"scheduled-reminder","pluralName":"scheduled-reminders","displayName":"Scheduled Reminder"},"options":{"draftAndPublish":false},"attributes":{"reminderType":{"type":"enumeration","enum":["SESSION_REMINDER_24H","SESSION_REMINDER_1H"],"required":true},"scheduledFor":{"type":"datetime","required":true},"sent":{"type":"boolean","default":false},"sentAt":{"type":"datetime"},"booking":{"type":"relation","relation":"manyToOne","target":"api::booking.booking","inversedBy":"reminders"},"createdAt":{"type":"datetime"},"updatedAt":{"type":"datetime"},"publishedAt":{"type":"datetime","configurable":false,"writable":true,"visible":true},"createdBy":{"type":"relation","relation":"oneToOne","target":"admin::user","configurable":false,"writable":false,"visible":false,"useJoinTable":false,"private":true},"updatedBy":{"type":"relation","relation":"oneToOne","target":"admin::user","configurable":false,"writable":false,"visible":false,"useJoinTable":false,"private":true},"locale":{"writable":true,"private":true,"configurable":false,"visible":false,"type":"string"},"localizations":{"type":"relation","relation":"oneToMany","target":"api::scheduled-reminder.scheduled-reminder","writable":false,"private":true,"configurable":false,"visible":false,"unstable_virtual":true,"joinColumn":{"name":"document_id","referencedColumn":"document_id","referencedTable":"scheduled_reminders"}}},"apiName":"scheduled-reminder","globalId":"ScheduledReminder","uid":"api::scheduled-reminder.scheduled-reminder","modelType":"contentType","__schema__":{"collectionName":"scheduled_reminders","info":{"singularName":"scheduled-reminder","pluralName":"scheduled-reminders","displayName":"Scheduled Reminder"},"options":{"draftAndPublish":false},"attributes":{"reminderType":{"type":"enumeration","enum":["SESSION_REMINDER_24H","SESSION_REMINDER_1H"],"required":true},"scheduledFor":{"type":"datetime","required":true},"sent":{"type":"boolean","default":false},"sentAt":{"type":"datetime"},"booking":{"type":"relation","relation":"manyToOne","target":"api::booking.booking","inversedBy":"reminders"}},"kind":"collectionType"},"modelName":"scheduled-reminder","actions":{},"lifecycles":{}},"api::service.service":{"kind":"collectionType","collectionName":"services","info":{"singularName":"service","pluralName":"services","displayName":"Service"},"options":{"draftAndPublish":false},"attributes":{"name":{"type":"string","required":true},"type":{"type":"enumeration","enum":["AUDIO","VIDEO"],"required":true},"price":{"type":"integer","required":true},"durationMinutes":{"type":"integer","required":true},"staffId":{"type":"string"},"bufferMinutes":{"type":"integer","default":0},"isActive":{"type":"boolean","default":true},"description":{"type":"text"},"bookings":{"type":"relation","relation":"oneToMany","target":"api::booking.booking","mappedBy":"service"},"createdAt":{"type":"datetime"},"updatedAt":{"type":"datetime"},"publishedAt":{"type":"datetime","configurable":false,"writable":true,"visible":true},"createdBy":{"type":"relation","relation":"oneToOne","target":"admin::user","configurable":false,"writable":false,"visible":false,"useJoinTable":false,"private":true},"updatedBy":{"type":"relation","relation":"oneToOne","target":"admin::user","configurable":false,"writable":false,"visible":false,"useJoinTable":false,"private":true},"locale":{"writable":true,"private":true,"configurable":false,"visible":false,"type":"string"},"localizations":{"type":"relation","relation":"oneToMany","target":"api::service.service","writable":false,"private":true,"configurable":false,"visible":false,"unstable_virtual":true,"joinColumn":{"name":"document_id","referencedColumn":"document_id","referencedTable":"services"}}},"apiName":"service","globalId":"Service","uid":"api::service.service","modelType":"contentType","__schema__":{"collectionName":"services","info":{"singularName":"service","pluralName":"services","displayName":"Service"},"options":{"draftAndPublish":false},"attributes":{"name":{"type":"string","required":true},"type":{"type":"enumeration","enum":["AUDIO","VIDEO"],"required":true},"price":{"type":"integer","required":true},"durationMinutes":{"type":"integer","required":true},"staffId":{"type":"string"},"bufferMinutes":{"type":"integer","default":0},"isActive":{"type":"boolean","default":true},"description":{"type":"text"},"bookings":{"type":"relation","relation":"oneToMany","target":"api::booking.booking","mappedBy":"service"}},"kind":"collectionType"},"modelName":"service","actions":{},"lifecycles":{}},"api::shipping-class.shipping-class":{"kind":"collectionType","collectionName":"shipping_classes","info":{"singularName":"shipping-class","pluralName":"shipping-classes","displayName":"Shipping Class"},"options":{"draftAndPublish":false},"attributes":{"name":{"type":"string","required":true},"rate":{"type":"integer","required":true,"default":0},"freeAbove":{"type":"integer"},"description":{"type":"text"},"products":{"type":"relation","relation":"oneToMany","target":"api::product.product","mappedBy":"shippingClass"},"createdAt":{"type":"datetime"},"updatedAt":{"type":"datetime"},"publishedAt":{"type":"datetime","configurable":false,"writable":true,"visible":true},"createdBy":{"type":"relation","relation":"oneToOne","target":"admin::user","configurable":false,"writable":false,"visible":false,"useJoinTable":false,"private":true},"updatedBy":{"type":"relation","relation":"oneToOne","target":"admin::user","configurable":false,"writable":false,"visible":false,"useJoinTable":false,"private":true},"locale":{"writable":true,"private":true,"configurable":false,"visible":false,"type":"string"},"localizations":{"type":"relation","relation":"oneToMany","target":"api::shipping-class.shipping-class","writable":false,"private":true,"configurable":false,"visible":false,"unstable_virtual":true,"joinColumn":{"name":"document_id","referencedColumn":"document_id","referencedTable":"shipping_classes"}}},"apiName":"shipping-class","globalId":"ShippingClass","uid":"api::shipping-class.shipping-class","modelType":"contentType","__schema__":{"collectionName":"shipping_classes","info":{"singularName":"shipping-class","pluralName":"shipping-classes","displayName":"Shipping Class"},"options":{"draftAndPublish":false},"attributes":{"name":{"type":"string","required":true},"rate":{"type":"integer","required":true,"default":0},"freeAbove":{"type":"integer"},"description":{"type":"text"},"products":{"type":"relation","relation":"oneToMany","target":"api::product.product","mappedBy":"shippingClass"}},"kind":"collectionType"},"modelName":"shipping-class","actions":{},"lifecycles":{}},"api::testimonial.testimonial":{"kind":"collectionType","collectionName":"testimonials","info":{"singularName":"testimonial","pluralName":"testimonials","displayName":"Testimonial"},"options":{"draftAndPublish":false},"attributes":{"name":{"type":"string","required":true},"text":{"type":"text","required":true},"sortOrder":{"type":"integer","default":0},"isActive":{"type":"boolean","default":true},"createdAt":{"type":"datetime"},"updatedAt":{"type":"datetime"},"publishedAt":{"type":"datetime","configurable":false,"writable":true,"visible":true},"createdBy":{"type":"relation","relation":"oneToOne","target":"admin::user","configurable":false,"writable":false,"visible":false,"useJoinTable":false,"private":true},"updatedBy":{"type":"relation","relation":"oneToOne","target":"admin::user","configurable":false,"writable":false,"visible":false,"useJoinTable":false,"private":true},"locale":{"writable":true,"private":true,"configurable":false,"visible":false,"type":"string"},"localizations":{"type":"relation","relation":"oneToMany","target":"api::testimonial.testimonial","writable":false,"private":true,"configurable":false,"visible":false,"unstable_virtual":true,"joinColumn":{"name":"document_id","referencedColumn":"document_id","referencedTable":"testimonials"}}},"apiName":"testimonial","globalId":"Testimonial","uid":"api::testimonial.testimonial","modelType":"contentType","__schema__":{"collectionName":"testimonials","info":{"singularName":"testimonial","pluralName":"testimonials","displayName":"Testimonial"},"options":{"draftAndPublish":false},"attributes":{"name":{"type":"string","required":true},"text":{"type":"text","required":true},"sortOrder":{"type":"integer","default":0},"isActive":{"type":"boolean","default":true}},"kind":"collectionType"},"modelName":"testimonial","actions":{},"lifecycles":{}},"api::wishlist-item.wishlist-item":{"kind":"collectionType","collectionName":"wishlist_items","info":{"singularName":"wishlist-item","pluralName":"wishlist-items","displayName":"Wishlist Item"},"options":{"draftAndPublish":false},"attributes":{"user":{"type":"relation","relation":"manyToOne","target":"plugin::users-permissions.user","inversedBy":"wishlistItems"},"product":{"type":"relation","relation":"manyToOne","target":"api::product.product","inversedBy":"wishlistItems"},"createdAt":{"type":"datetime"},"updatedAt":{"type":"datetime"},"publishedAt":{"type":"datetime","configurable":false,"writable":true,"visible":true},"createdBy":{"type":"relation","relation":"oneToOne","target":"admin::user","configurable":false,"writable":false,"visible":false,"useJoinTable":false,"private":true},"updatedBy":{"type":"relation","relation":"oneToOne","target":"admin::user","configurable":false,"writable":false,"visible":false,"useJoinTable":false,"private":true},"locale":{"writable":true,"private":true,"configurable":false,"visible":false,"type":"string"},"localizations":{"type":"relation","relation":"oneToMany","target":"api::wishlist-item.wishlist-item","writable":false,"private":true,"configurable":false,"visible":false,"unstable_virtual":true,"joinColumn":{"name":"document_id","referencedColumn":"document_id","referencedTable":"wishlist_items"}}},"apiName":"wishlist-item","globalId":"WishlistItem","uid":"api::wishlist-item.wishlist-item","modelType":"contentType","__schema__":{"collectionName":"wishlist_items","info":{"singularName":"wishlist-item","pluralName":"wishlist-items","displayName":"Wishlist Item"},"options":{"draftAndPublish":false},"attributes":{"user":{"type":"relation","relation":"manyToOne","target":"plugin::users-permissions.user","inversedBy":"wishlistItems"},"product":{"type":"relation","relation":"manyToOne","target":"api::product.product","inversedBy":"wishlistItems"}},"kind":"collectionType"},"modelName":"wishlist-item","actions":{},"lifecycles":{}},"admin::permission":{"collectionName":"admin_permissions","info":{"name":"Permission","description":"","singularName":"permission","pluralName":"permissions","displayName":"Permission"},"options":{"draftAndPublish":false},"pluginOptions":{"content-manager":{"visible":false},"content-type-builder":{"visible":false}},"attributes":{"action":{"type":"string","minLength":1,"configurable":false,"required":true},"actionParameters":{"type":"json","configurable":false,"required":false,"default":{}},"subject":{"type":"string","minLength":1,"configurable":false,"required":false},"properties":{"type":"json","configurable":false,"required":false,"default":{}},"conditions":{"type":"json","configurable":false,"required":false,"default":[]},"role":{"configurable":false,"type":"relation","relation":"manyToOne","inversedBy":"permissions","target":"admin::role"},"createdAt":{"type":"datetime"},"updatedAt":{"type":"datetime"},"publishedAt":{"type":"datetime","configurable":false,"writable":true,"visible":true},"createdBy":{"type":"relation","relation":"oneToOne","target":"admin::user","configurable":false,"writable":false,"visible":false,"useJoinTable":false,"private":true},"updatedBy":{"type":"relation","relation":"oneToOne","target":"admin::user","configurable":false,"writable":false,"visible":false,"useJoinTable":false,"private":true},"locale":{"writable":true,"private":true,"configurable":false,"visible":false,"type":"string"},"localizations":{"type":"relation","relation":"oneToMany","target":"admin::permission","writable":false,"private":true,"configurable":false,"visible":false,"unstable_virtual":true,"joinColumn":{"name":"document_id","referencedColumn":"document_id","referencedTable":"admin_permissions"}}},"plugin":"admin","globalId":"AdminPermission","uid":"admin::permission","modelType":"contentType","kind":"collectionType","__schema__":{"collectionName":"admin_permissions","info":{"name":"Permission","description":"","singularName":"permission","pluralName":"permissions","displayName":"Permission"},"options":{},"pluginOptions":{"content-manager":{"visible":false},"content-type-builder":{"visible":false}},"attributes":{"action":{"type":"string","minLength":1,"configurable":false,"required":true},"actionParameters":{"type":"json","configurable":false,"required":false,"default":{}},"subject":{"type":"string","minLength":1,"configurable":false,"required":false},"properties":{"type":"json","configurable":false,"required":false,"default":{}},"conditions":{"type":"json","configurable":false,"required":false,"default":[]},"role":{"configurable":false,"type":"relation","relation":"manyToOne","inversedBy":"permissions","target":"admin::role"}},"kind":"collectionType"},"modelName":"permission"},"admin::user":{"collectionName":"admin_users","info":{"name":"User","description":"","singularName":"user","pluralName":"users","displayName":"User"},"pluginOptions":{"content-manager":{"visible":false},"content-type-builder":{"visible":false}},"attributes":{"firstname":{"type":"string","unique":false,"minLength":1,"configurable":false,"required":false},"lastname":{"type":"string","unique":false,"minLength":1,"configurable":false,"required":false},"username":{"type":"string","unique":false,"configurable":false,"required":false},"email":{"type":"email","minLength":6,"configurable":false,"required":true,"unique":true,"private":true},"password":{"type":"password","minLength":6,"configurable":false,"required":false,"private":true,"searchable":false},"resetPasswordToken":{"type":"string","configurable":false,"private":true,"searchable":false},"registrationToken":{"type":"string","configurable":false,"private":true,"searchable":false},"isActive":{"type":"boolean","default":false,"configurable":false,"private":true},"roles":{"configurable":false,"private":true,"type":"relation","relation":"manyToMany","inversedBy":"users","target":"admin::role","collectionName":"strapi_users_roles"},"blocked":{"type":"boolean","default":false,"configurable":false,"private":true},"preferedLanguage":{"type":"string","configurable":false,"required":false,"searchable":false},"createdAt":{"type":"datetime"},"updatedAt":{"type":"datetime"},"publishedAt":{"type":"datetime","configurable":false,"writable":true,"visible":true},"createdBy":{"type":"relation","relation":"oneToOne","target":"admin::user","configurable":false,"writable":false,"visible":false,"useJoinTable":false,"private":true},"updatedBy":{"type":"relation","relation":"oneToOne","target":"admin::user","configurable":false,"writable":false,"visible":false,"useJoinTable":false,"private":true},"locale":{"writable":true,"private":true,"configurable":false,"visible":false,"type":"string"},"localizations":{"type":"relation","relation":"oneToMany","target":"admin::user","writable":false,"private":true,"configurable":false,"visible":false,"unstable_virtual":true,"joinColumn":{"name":"document_id","referencedColumn":"document_id","referencedTable":"admin_users"}}},"config":{"attributes":{"resetPasswordToken":{"hidden":true},"registrationToken":{"hidden":true}}},"plugin":"admin","globalId":"AdminUser","uid":"admin::user","modelType":"contentType","kind":"collectionType","__schema__":{"collectionName":"admin_users","info":{"name":"User","description":"","singularName":"user","pluralName":"users","displayName":"User"},"pluginOptions":{"content-manager":{"visible":false},"content-type-builder":{"visible":false}},"attributes":{"firstname":{"type":"string","unique":false,"minLength":1,"configurable":false,"required":false},"lastname":{"type":"string","unique":false,"minLength":1,"configurable":false,"required":false},"username":{"type":"string","unique":false,"configurable":false,"required":false},"email":{"type":"email","minLength":6,"configurable":false,"required":true,"unique":true,"private":true},"password":{"type":"password","minLength":6,"configurable":false,"required":false,"private":true,"searchable":false},"resetPasswordToken":{"type":"string","configurable":false,"private":true,"searchable":false},"registrationToken":{"type":"string","configurable":false,"private":true,"searchable":false},"isActive":{"type":"boolean","default":false,"configurable":false,"private":true},"roles":{"configurable":false,"private":true,"type":"relation","relation":"manyToMany","inversedBy":"users","target":"admin::role","collectionName":"strapi_users_roles"},"blocked":{"type":"boolean","default":false,"configurable":false,"private":true},"preferedLanguage":{"type":"string","configurable":false,"required":false,"searchable":false}},"kind":"collectionType"},"modelName":"user","options":{"draftAndPublish":false}},"admin::role":{"collectionName":"admin_roles","info":{"name":"Role","description":"","singularName":"role","pluralName":"roles","displayName":"Role"},"options":{"draftAndPublish":false},"pluginOptions":{"content-manager":{"visible":false},"content-type-builder":{"visible":false}},"attributes":{"name":{"type":"string","minLength":1,"unique":true,"configurable":false,"required":true},"code":{"type":"string","minLength":1,"unique":true,"configurable":false,"required":true},"description":{"type":"string","configurable":false},"users":{"configurable":false,"type":"relation","relation":"manyToMany","mappedBy":"roles","target":"admin::user"},"permissions":{"configurable":false,"type":"relation","relation":"oneToMany","mappedBy":"role","target":"admin::permission"},"createdAt":{"type":"datetime"},"updatedAt":{"type":"datetime"},"publishedAt":{"type":"datetime","configurable":false,"writable":true,"visible":true},"createdBy":{"type":"relation","relation":"oneToOne","target":"admin::user","configurable":false,"writable":false,"visible":false,"useJoinTable":false,"private":true},"updatedBy":{"type":"relation","relation":"oneToOne","target":"admin::user","configurable":false,"writable":false,"visible":false,"useJoinTable":false,"private":true},"locale":{"writable":true,"private":true,"configurable":false,"visible":false,"type":"string"},"localizations":{"type":"relation","relation":"oneToMany","target":"admin::role","writable":false,"private":true,"configurable":false,"visible":false,"unstable_virtual":true,"joinColumn":{"name":"document_id","referencedColumn":"document_id","referencedTable":"admin_roles"}}},"plugin":"admin","globalId":"AdminRole","uid":"admin::role","modelType":"contentType","kind":"collectionType","__schema__":{"collectionName":"admin_roles","info":{"name":"Role","description":"","singularName":"role","pluralName":"roles","displayName":"Role"},"options":{},"pluginOptions":{"content-manager":{"visible":false},"content-type-builder":{"visible":false}},"attributes":{"name":{"type":"string","minLength":1,"unique":true,"configurable":false,"required":true},"code":{"type":"string","minLength":1,"unique":true,"configurable":false,"required":true},"description":{"type":"string","configurable":false},"users":{"configurable":false,"type":"relation","relation":"manyToMany","mappedBy":"roles","target":"admin::user"},"permissions":{"configurable":false,"type":"relation","relation":"oneToMany","mappedBy":"role","target":"admin::permission"}},"kind":"collectionType"},"modelName":"role"},"admin::api-token":{"collectionName":"strapi_api_tokens","info":{"name":"Api Token","singularName":"api-token","pluralName":"api-tokens","displayName":"Api Token","description":""},"options":{"draftAndPublish":false},"pluginOptions":{"content-manager":{"visible":false},"content-type-builder":{"visible":false}},"attributes":{"name":{"type":"string","minLength":1,"configurable":false,"required":true,"unique":true},"description":{"type":"string","minLength":1,"configurable":false,"required":false,"default":""},"type":{"type":"enumeration","enum":["read-only","full-access","custom"],"configurable":false,"required":true,"default":"read-only"},"accessKey":{"type":"string","minLength":1,"configurable":false,"required":true,"searchable":false},"encryptedKey":{"type":"text","minLength":1,"configurable":false,"required":false,"searchable":false},"lastUsedAt":{"type":"datetime","configurable":false,"required":false},"permissions":{"type":"relation","target":"admin::api-token-permission","relation":"oneToMany","mappedBy":"token","configurable":false,"required":false},"expiresAt":{"type":"datetime","configurable":false,"required":false},"lifespan":{"type":"biginteger","configurable":false,"required":false},"createdAt":{"type":"datetime"},"updatedAt":{"type":"datetime"},"publishedAt":{"type":"datetime","configurable":false,"writable":true,"visible":true},"createdBy":{"type":"relation","relation":"oneToOne","target":"admin::user","configurable":false,"writable":false,"visible":false,"useJoinTable":false,"private":true},"updatedBy":{"type":"relation","relation":"oneToOne","target":"admin::user","configurable":false,"writable":false,"visible":false,"useJoinTable":false,"private":true},"locale":{"writable":true,"private":true,"configurable":false,"visible":false,"type":"string"},"localizations":{"type":"relation","relation":"oneToMany","target":"admin::api-token","writable":false,"private":true,"configurable":false,"visible":false,"unstable_virtual":true,"joinColumn":{"name":"document_id","referencedColumn":"document_id","referencedTable":"strapi_api_tokens"}}},"plugin":"admin","globalId":"AdminApiToken","uid":"admin::api-token","modelType":"contentType","kind":"collectionType","__schema__":{"collectionName":"strapi_api_tokens","info":{"name":"Api Token","singularName":"api-token","pluralName":"api-tokens","displayName":"Api Token","description":""},"options":{},"pluginOptions":{"content-manager":{"visible":false},"content-type-builder":{"visible":false}},"attributes":{"name":{"type":"string","minLength":1,"configurable":false,"required":true,"unique":true},"description":{"type":"string","minLength":1,"configurable":false,"required":false,"default":""},"type":{"type":"enumeration","enum":["read-only","full-access","custom"],"configurable":false,"required":true,"default":"read-only"},"accessKey":{"type":"string","minLength":1,"configurable":false,"required":true,"searchable":false},"encryptedKey":{"type":"text","minLength":1,"configurable":false,"required":false,"searchable":false},"lastUsedAt":{"type":"datetime","configurable":false,"required":false},"permissions":{"type":"relation","target":"admin::api-token-permission","relation":"oneToMany","mappedBy":"token","configurable":false,"required":false},"expiresAt":{"type":"datetime","configurable":false,"required":false},"lifespan":{"type":"biginteger","configurable":false,"required":false}},"kind":"collectionType"},"modelName":"api-token"},"admin::api-token-permission":{"collectionName":"strapi_api_token_permissions","info":{"name":"API Token Permission","description":"","singularName":"api-token-permission","pluralName":"api-token-permissions","displayName":"API Token Permission"},"options":{"draftAndPublish":false},"pluginOptions":{"content-manager":{"visible":false},"content-type-builder":{"visible":false}},"attributes":{"action":{"type":"string","minLength":1,"configurable":false,"required":true},"token":{"configurable":false,"type":"relation","relation":"manyToOne","inversedBy":"permissions","target":"admin::api-token"},"createdAt":{"type":"datetime"},"updatedAt":{"type":"datetime"},"publishedAt":{"type":"datetime","configurable":false,"writable":true,"visible":true},"createdBy":{"type":"relation","relation":"oneToOne","target":"admin::user","configurable":false,"writable":false,"visible":false,"useJoinTable":false,"private":true},"updatedBy":{"type":"relation","relation":"oneToOne","target":"admin::user","configurable":false,"writable":false,"visible":false,"useJoinTable":false,"private":true},"locale":{"writable":true,"private":true,"configurable":false,"visible":false,"type":"string"},"localizations":{"type":"relation","relation":"oneToMany","target":"admin::api-token-permission","writable":false,"private":true,"configurable":false,"visible":false,"unstable_virtual":true,"joinColumn":{"name":"document_id","referencedColumn":"document_id","referencedTable":"strapi_api_token_permissions"}}},"plugin":"admin","globalId":"AdminApiTokenPermission","uid":"admin::api-token-permission","modelType":"contentType","kind":"collectionType","__schema__":{"collectionName":"strapi_api_token_permissions","info":{"name":"API Token Permission","description":"","singularName":"api-token-permission","pluralName":"api-token-permissions","displayName":"API Token Permission"},"options":{},"pluginOptions":{"content-manager":{"visible":false},"content-type-builder":{"visible":false}},"attributes":{"action":{"type":"string","minLength":1,"configurable":false,"required":true},"token":{"configurable":false,"type":"relation","relation":"manyToOne","inversedBy":"permissions","target":"admin::api-token"}},"kind":"collectionType"},"modelName":"api-token-permission"},"admin::transfer-token":{"collectionName":"strapi_transfer_tokens","info":{"name":"Transfer Token","singularName":"transfer-token","pluralName":"transfer-tokens","displayName":"Transfer Token","description":""},"options":{"draftAndPublish":false},"pluginOptions":{"content-manager":{"visible":false},"content-type-builder":{"visible":false}},"attributes":{"name":{"type":"string","minLength":1,"configurable":false,"required":true,"unique":true},"description":{"type":"string","minLength":1,"configurable":false,"required":false,"default":""},"accessKey":{"type":"string","minLength":1,"configurable":false,"required":true},"lastUsedAt":{"type":"datetime","configurable":false,"required":false},"permissions":{"type":"relation","target":"admin::transfer-token-permission","relation":"oneToMany","mappedBy":"token","configurable":false,"required":false},"expiresAt":{"type":"datetime","configurable":false,"required":false},"lifespan":{"type":"biginteger","configurable":false,"required":false},"createdAt":{"type":"datetime"},"updatedAt":{"type":"datetime"},"publishedAt":{"type":"datetime","configurable":false,"writable":true,"visible":true},"createdBy":{"type":"relation","relation":"oneToOne","target":"admin::user","configurable":false,"writable":false,"visible":false,"useJoinTable":false,"private":true},"updatedBy":{"type":"relation","relation":"oneToOne","target":"admin::user","configurable":false,"writable":false,"visible":false,"useJoinTable":false,"private":true},"locale":{"writable":true,"private":true,"configurable":false,"visible":false,"type":"string"},"localizations":{"type":"relation","relation":"oneToMany","target":"admin::transfer-token","writable":false,"private":true,"configurable":false,"visible":false,"unstable_virtual":true,"joinColumn":{"name":"document_id","referencedColumn":"document_id","referencedTable":"strapi_transfer_tokens"}}},"plugin":"admin","globalId":"AdminTransferToken","uid":"admin::transfer-token","modelType":"contentType","kind":"collectionType","__schema__":{"collectionName":"strapi_transfer_tokens","info":{"name":"Transfer Token","singularName":"transfer-token","pluralName":"transfer-tokens","displayName":"Transfer Token","description":""},"options":{},"pluginOptions":{"content-manager":{"visible":false},"content-type-builder":{"visible":false}},"attributes":{"name":{"type":"string","minLength":1,"configurable":false,"required":true,"unique":true},"description":{"type":"string","minLength":1,"configurable":false,"required":false,"default":""},"accessKey":{"type":"string","minLength":1,"configurable":false,"required":true},"lastUsedAt":{"type":"datetime","configurable":false,"required":false},"permissions":{"type":"relation","target":"admin::transfer-token-permission","relation":"oneToMany","mappedBy":"token","configurable":false,"required":false},"expiresAt":{"type":"datetime","configurable":false,"required":false},"lifespan":{"type":"biginteger","configurable":false,"required":false}},"kind":"collectionType"},"modelName":"transfer-token"},"admin::transfer-token-permission":{"collectionName":"strapi_transfer_token_permissions","info":{"name":"Transfer Token Permission","description":"","singularName":"transfer-token-permission","pluralName":"transfer-token-permissions","displayName":"Transfer Token Permission"},"options":{"draftAndPublish":false},"pluginOptions":{"content-manager":{"visible":false},"content-type-builder":{"visible":false}},"attributes":{"action":{"type":"string","minLength":1,"configurable":false,"required":true},"token":{"configurable":false,"type":"relation","relation":"manyToOne","inversedBy":"permissions","target":"admin::transfer-token"},"createdAt":{"type":"datetime"},"updatedAt":{"type":"datetime"},"publishedAt":{"type":"datetime","configurable":false,"writable":true,"visible":true},"createdBy":{"type":"relation","relation":"oneToOne","target":"admin::user","configurable":false,"writable":false,"visible":false,"useJoinTable":false,"private":true},"updatedBy":{"type":"relation","relation":"oneToOne","target":"admin::user","configurable":false,"writable":false,"visible":false,"useJoinTable":false,"private":true},"locale":{"writable":true,"private":true,"configurable":false,"visible":false,"type":"string"},"localizations":{"type":"relation","relation":"oneToMany","target":"admin::transfer-token-permission","writable":false,"private":true,"configurable":false,"visible":false,"unstable_virtual":true,"joinColumn":{"name":"document_id","referencedColumn":"document_id","referencedTable":"strapi_transfer_token_permissions"}}},"plugin":"admin","globalId":"AdminTransferTokenPermission","uid":"admin::transfer-token-permission","modelType":"contentType","kind":"collectionType","__schema__":{"collectionName":"strapi_transfer_token_permissions","info":{"name":"Transfer Token Permission","description":"","singularName":"transfer-token-permission","pluralName":"transfer-token-permissions","displayName":"Transfer Token Permission"},"options":{},"pluginOptions":{"content-manager":{"visible":false},"content-type-builder":{"visible":false}},"attributes":{"action":{"type":"string","minLength":1,"configurable":false,"required":true},"token":{"configurable":false,"type":"relation","relation":"manyToOne","inversedBy":"permissions","target":"admin::transfer-token"}},"kind":"collectionType"},"modelName":"transfer-token-permission"},"admin::session":{"collectionName":"strapi_sessions","info":{"name":"Session","description":"Session Manager storage","singularName":"session","pluralName":"sessions","displayName":"Session"},"options":{"draftAndPublish":false},"pluginOptions":{"content-manager":{"visible":false},"content-type-builder":{"visible":false},"i18n":{"localized":false}},"attributes":{"userId":{"type":"string","required":true,"configurable":false,"private":true,"searchable":false},"sessionId":{"type":"string","unique":true,"required":true,"configurable":false,"private":true,"searchable":false},"childId":{"type":"string","configurable":false,"private":true,"searchable":false},"deviceId":{"type":"string","required":true,"configurable":false,"private":true,"searchable":false},"origin":{"type":"string","required":true,"configurable":false,"private":true,"searchable":false},"expiresAt":{"type":"datetime","required":true,"configurable":false,"private":true,"searchable":false},"absoluteExpiresAt":{"type":"datetime","configurable":false,"private":true,"searchable":false},"status":{"type":"string","configurable":false,"private":true,"searchable":false},"type":{"type":"string","configurable":false,"private":true,"searchable":false},"createdAt":{"type":"datetime"},"updatedAt":{"type":"datetime"},"publishedAt":{"type":"datetime","configurable":false,"writable":true,"visible":true},"createdBy":{"type":"relation","relation":"oneToOne","target":"admin::user","configurable":false,"writable":false,"visible":false,"useJoinTable":false,"private":true},"updatedBy":{"type":"relation","relation":"oneToOne","target":"admin::user","configurable":false,"writable":false,"visible":false,"useJoinTable":false,"private":true},"locale":{"writable":true,"private":true,"configurable":false,"visible":false,"type":"string"},"localizations":{"type":"relation","relation":"oneToMany","target":"admin::session","writable":false,"private":true,"configurable":false,"visible":false,"unstable_virtual":true,"joinColumn":{"name":"document_id","referencedColumn":"document_id","referencedTable":"strapi_sessions"}}},"plugin":"admin","globalId":"AdminSession","uid":"admin::session","modelType":"contentType","kind":"collectionType","__schema__":{"collectionName":"strapi_sessions","info":{"name":"Session","description":"Session Manager storage","singularName":"session","pluralName":"sessions","displayName":"Session"},"options":{"draftAndPublish":false},"pluginOptions":{"content-manager":{"visible":false},"content-type-builder":{"visible":false},"i18n":{"localized":false}},"attributes":{"userId":{"type":"string","required":true,"configurable":false,"private":true,"searchable":false},"sessionId":{"type":"string","unique":true,"required":true,"configurable":false,"private":true,"searchable":false},"childId":{"type":"string","configurable":false,"private":true,"searchable":false},"deviceId":{"type":"string","required":true,"configurable":false,"private":true,"searchable":false},"origin":{"type":"string","required":true,"configurable":false,"private":true,"searchable":false},"expiresAt":{"type":"datetime","required":true,"configurable":false,"private":true,"searchable":false},"absoluteExpiresAt":{"type":"datetime","configurable":false,"private":true,"searchable":false},"status":{"type":"string","configurable":false,"private":true,"searchable":false},"type":{"type":"string","configurable":false,"private":true,"searchable":false}},"kind":"collectionType"},"modelName":"session"}}	object	\N	\N
10	plugin_content_manager_configuration_content_types::plugin::users-permissions.permission	{"settings":{"bulkable":true,"filterable":true,"searchable":true,"pageSize":10,"relationOpenMode":"modal","mainField":"action","defaultSortBy":"action","defaultSortOrder":"ASC"},"metadatas":{"id":{"edit":{},"list":{"label":"id","searchable":true,"sortable":true}},"action":{"edit":{"label":"action","description":"","placeholder":"","visible":true,"editable":true},"list":{"label":"action","searchable":true,"sortable":true}},"role":{"edit":{"label":"role","description":"","placeholder":"","visible":true,"editable":true,"mainField":"name"},"list":{"label":"role","searchable":true,"sortable":true}},"createdAt":{"edit":{"label":"createdAt","description":"","placeholder":"","visible":false,"editable":true},"list":{"label":"createdAt","searchable":true,"sortable":true}},"updatedAt":{"edit":{"label":"updatedAt","description":"","placeholder":"","visible":false,"editable":true},"list":{"label":"updatedAt","searchable":true,"sortable":true}},"createdBy":{"edit":{"label":"createdBy","description":"","placeholder":"","visible":false,"editable":true,"mainField":"firstname"},"list":{"label":"createdBy","searchable":true,"sortable":true}},"updatedBy":{"edit":{"label":"updatedBy","description":"","placeholder":"","visible":false,"editable":true,"mainField":"firstname"},"list":{"label":"updatedBy","searchable":true,"sortable":true}},"documentId":{"edit":{},"list":{"label":"documentId","searchable":true,"sortable":true}}},"layouts":{"list":["id","action","role","createdAt"],"edit":[[{"name":"action","size":6},{"name":"role","size":6}]]},"uid":"plugin::users-permissions.permission"}	object	\N	\N
13	plugin_content_manager_configuration_content_types::admin::permission	{"settings":{"bulkable":true,"filterable":true,"searchable":true,"pageSize":10,"relationOpenMode":"modal","mainField":"action","defaultSortBy":"action","defaultSortOrder":"ASC"},"metadatas":{"id":{"edit":{},"list":{"label":"id","searchable":true,"sortable":true}},"action":{"edit":{"label":"action","description":"","placeholder":"","visible":true,"editable":true},"list":{"label":"action","searchable":true,"sortable":true}},"actionParameters":{"edit":{"label":"actionParameters","description":"","placeholder":"","visible":true,"editable":true},"list":{"label":"actionParameters","searchable":false,"sortable":false}},"subject":{"edit":{"label":"subject","description":"","placeholder":"","visible":true,"editable":true},"list":{"label":"subject","searchable":true,"sortable":true}},"properties":{"edit":{"label":"properties","description":"","placeholder":"","visible":true,"editable":true},"list":{"label":"properties","searchable":false,"sortable":false}},"conditions":{"edit":{"label":"conditions","description":"","placeholder":"","visible":true,"editable":true},"list":{"label":"conditions","searchable":false,"sortable":false}},"role":{"edit":{"label":"role","description":"","placeholder":"","visible":true,"editable":true,"mainField":"name"},"list":{"label":"role","searchable":true,"sortable":true}},"createdAt":{"edit":{"label":"createdAt","description":"","placeholder":"","visible":false,"editable":true},"list":{"label":"createdAt","searchable":true,"sortable":true}},"updatedAt":{"edit":{"label":"updatedAt","description":"","placeholder":"","visible":false,"editable":true},"list":{"label":"updatedAt","searchable":true,"sortable":true}},"createdBy":{"edit":{"label":"createdBy","description":"","placeholder":"","visible":false,"editable":true,"mainField":"firstname"},"list":{"label":"createdBy","searchable":true,"sortable":true}},"updatedBy":{"edit":{"label":"updatedBy","description":"","placeholder":"","visible":false,"editable":true,"mainField":"firstname"},"list":{"label":"updatedBy","searchable":true,"sortable":true}},"documentId":{"edit":{},"list":{"label":"documentId","searchable":true,"sortable":true}}},"layouts":{"list":["id","action","subject","role"],"edit":[[{"name":"action","size":6}],[{"name":"actionParameters","size":12}],[{"name":"subject","size":6}],[{"name":"properties","size":12}],[{"name":"conditions","size":12}],[{"name":"role","size":6}]]},"uid":"admin::permission"}	object	\N	\N
15	plugin_content_manager_configuration_content_types::admin::user	{"settings":{"bulkable":true,"filterable":true,"searchable":true,"pageSize":10,"relationOpenMode":"modal","mainField":"firstname","defaultSortBy":"firstname","defaultSortOrder":"ASC"},"metadatas":{"id":{"edit":{},"list":{"label":"id","searchable":true,"sortable":true}},"firstname":{"edit":{"label":"firstname","description":"","placeholder":"","visible":true,"editable":true},"list":{"label":"firstname","searchable":true,"sortable":true}},"lastname":{"edit":{"label":"lastname","description":"","placeholder":"","visible":true,"editable":true},"list":{"label":"lastname","searchable":true,"sortable":true}},"username":{"edit":{"label":"username","description":"","placeholder":"","visible":true,"editable":true},"list":{"label":"username","searchable":true,"sortable":true}},"email":{"edit":{"label":"email","description":"","placeholder":"","visible":true,"editable":true},"list":{"label":"email","searchable":true,"sortable":true}},"password":{"edit":{"label":"password","description":"","placeholder":"","visible":true,"editable":true},"list":{"label":"password","searchable":true,"sortable":true}},"resetPasswordToken":{"edit":{"label":"resetPasswordToken","description":"","placeholder":"","visible":false,"editable":true},"list":{"label":"resetPasswordToken","searchable":true,"sortable":true}},"registrationToken":{"edit":{"label":"registrationToken","description":"","placeholder":"","visible":false,"editable":true},"list":{"label":"registrationToken","searchable":true,"sortable":true}},"isActive":{"edit":{"label":"isActive","description":"","placeholder":"","visible":true,"editable":true},"list":{"label":"isActive","searchable":true,"sortable":true}},"roles":{"edit":{"label":"roles","description":"","placeholder":"","visible":true,"editable":true,"mainField":"name"},"list":{"label":"roles","searchable":false,"sortable":false}},"blocked":{"edit":{"label":"blocked","description":"","placeholder":"","visible":true,"editable":true},"list":{"label":"blocked","searchable":true,"sortable":true}},"preferedLanguage":{"edit":{"label":"preferedLanguage","description":"","placeholder":"","visible":true,"editable":true},"list":{"label":"preferedLanguage","searchable":true,"sortable":true}},"createdAt":{"edit":{"label":"createdAt","description":"","placeholder":"","visible":false,"editable":true},"list":{"label":"createdAt","searchable":true,"sortable":true}},"updatedAt":{"edit":{"label":"updatedAt","description":"","placeholder":"","visible":false,"editable":true},"list":{"label":"updatedAt","searchable":true,"sortable":true}},"createdBy":{"edit":{"label":"createdBy","description":"","placeholder":"","visible":false,"editable":true,"mainField":"firstname"},"list":{"label":"createdBy","searchable":true,"sortable":true}},"updatedBy":{"edit":{"label":"updatedBy","description":"","placeholder":"","visible":false,"editable":true,"mainField":"firstname"},"list":{"label":"updatedBy","searchable":true,"sortable":true}},"documentId":{"edit":{},"list":{"label":"documentId","searchable":true,"sortable":true}}},"layouts":{"list":["id","firstname","lastname","username"],"edit":[[{"name":"firstname","size":6},{"name":"lastname","size":6}],[{"name":"username","size":6},{"name":"email","size":6}],[{"name":"password","size":6},{"name":"isActive","size":4}],[{"name":"roles","size":6},{"name":"blocked","size":4}],[{"name":"preferedLanguage","size":6}]]},"uid":"admin::user"}	object	\N	\N
17	plugin_content_manager_configuration_content_types::admin::transfer-token	{"settings":{"bulkable":true,"filterable":true,"searchable":true,"pageSize":10,"relationOpenMode":"modal","mainField":"name","defaultSortBy":"name","defaultSortOrder":"ASC"},"metadatas":{"id":{"edit":{},"list":{"label":"id","searchable":true,"sortable":true}},"name":{"edit":{"label":"name","description":"","placeholder":"","visible":true,"editable":true},"list":{"label":"name","searchable":true,"sortable":true}},"description":{"edit":{"label":"description","description":"","placeholder":"","visible":true,"editable":true},"list":{"label":"description","searchable":true,"sortable":true}},"accessKey":{"edit":{"label":"accessKey","description":"","placeholder":"","visible":true,"editable":true},"list":{"label":"accessKey","searchable":true,"sortable":true}},"lastUsedAt":{"edit":{"label":"lastUsedAt","description":"","placeholder":"","visible":true,"editable":true},"list":{"label":"lastUsedAt","searchable":true,"sortable":true}},"permissions":{"edit":{"label":"permissions","description":"","placeholder":"","visible":true,"editable":true,"mainField":"action"},"list":{"label":"permissions","searchable":false,"sortable":false}},"expiresAt":{"edit":{"label":"expiresAt","description":"","placeholder":"","visible":true,"editable":true},"list":{"label":"expiresAt","searchable":true,"sortable":true}},"lifespan":{"edit":{"label":"lifespan","description":"","placeholder":"","visible":true,"editable":true},"list":{"label":"lifespan","searchable":true,"sortable":true}},"createdAt":{"edit":{"label":"createdAt","description":"","placeholder":"","visible":false,"editable":true},"list":{"label":"createdAt","searchable":true,"sortable":true}},"updatedAt":{"edit":{"label":"updatedAt","description":"","placeholder":"","visible":false,"editable":true},"list":{"label":"updatedAt","searchable":true,"sortable":true}},"createdBy":{"edit":{"label":"createdBy","description":"","placeholder":"","visible":false,"editable":true,"mainField":"firstname"},"list":{"label":"createdBy","searchable":true,"sortable":true}},"updatedBy":{"edit":{"label":"updatedBy","description":"","placeholder":"","visible":false,"editable":true,"mainField":"firstname"},"list":{"label":"updatedBy","searchable":true,"sortable":true}},"documentId":{"edit":{},"list":{"label":"documentId","searchable":true,"sortable":true}}},"layouts":{"list":["id","name","description","accessKey"],"edit":[[{"name":"name","size":6},{"name":"description","size":6}],[{"name":"accessKey","size":6},{"name":"lastUsedAt","size":6}],[{"name":"permissions","size":6},{"name":"expiresAt","size":6}],[{"name":"lifespan","size":4}]]},"uid":"admin::transfer-token"}	object	\N	\N
19	plugin_content_manager_configuration_content_types::admin::transfer-token-permission	{"settings":{"bulkable":true,"filterable":true,"searchable":true,"pageSize":10,"relationOpenMode":"modal","mainField":"action","defaultSortBy":"action","defaultSortOrder":"ASC"},"metadatas":{"id":{"edit":{},"list":{"label":"id","searchable":true,"sortable":true}},"action":{"edit":{"label":"action","description":"","placeholder":"","visible":true,"editable":true},"list":{"label":"action","searchable":true,"sortable":true}},"token":{"edit":{"label":"token","description":"","placeholder":"","visible":true,"editable":true,"mainField":"name"},"list":{"label":"token","searchable":true,"sortable":true}},"createdAt":{"edit":{"label":"createdAt","description":"","placeholder":"","visible":false,"editable":true},"list":{"label":"createdAt","searchable":true,"sortable":true}},"updatedAt":{"edit":{"label":"updatedAt","description":"","placeholder":"","visible":false,"editable":true},"list":{"label":"updatedAt","searchable":true,"sortable":true}},"createdBy":{"edit":{"label":"createdBy","description":"","placeholder":"","visible":false,"editable":true,"mainField":"firstname"},"list":{"label":"createdBy","searchable":true,"sortable":true}},"updatedBy":{"edit":{"label":"updatedBy","description":"","placeholder":"","visible":false,"editable":true,"mainField":"firstname"},"list":{"label":"updatedBy","searchable":true,"sortable":true}},"documentId":{"edit":{},"list":{"label":"documentId","searchable":true,"sortable":true}}},"layouts":{"list":["id","action","token","createdAt"],"edit":[[{"name":"action","size":6},{"name":"token","size":6}]]},"uid":"admin::transfer-token-permission"}	object	\N	\N
21	plugin_upload_settings	{"sizeOptimization":true,"responsiveDimensions":true,"autoOrientation":false,"aiMetadata":true}	object	\N	\N
22	plugin_upload_view_configuration	{"pageSize":10,"sort":"createdAt:DESC"}	object	\N	\N
24	plugin_i18n_default_locale	"en"	string	\N	\N
25	plugin_users-permissions_grant	{"email":{"icon":"envelope","enabled":true},"discord":{"icon":"discord","enabled":false,"key":"","secret":"","callbackUrl":"http://localhost:1337/api/auth/discord/callback","scope":["identify","email"]},"facebook":{"icon":"facebook-square","enabled":false,"key":"","secret":"","callbackUrl":"http://localhost:1337/api/auth/facebook/callback","scope":["email"]},"google":{"icon":"google","enabled":false,"key":"","secret":"","callbackUrl":"http://localhost:1337/api/auth/google/callback","scope":["email"]},"github":{"icon":"github","enabled":false,"key":"","secret":"","callbackUrl":"http://localhost:1337/api/auth/github/callback","scope":["user","user:email"]},"microsoft":{"icon":"windows","enabled":false,"key":"","secret":"","callbackUrl":"http://localhost:1337/api/auth/microsoft/callback","scope":["user.read"]},"twitter":{"icon":"twitter","enabled":false,"key":"","secret":"","callbackUrl":"http://localhost:1337/api/auth/twitter/callback"},"instagram":{"icon":"instagram","enabled":false,"key":"","secret":"","callbackUrl":"http://localhost:1337/api/auth/instagram/callback","scope":["user_profile"]},"vk":{"icon":"vk","enabled":false,"key":"","secret":"","callbackUrl":"http://localhost:1337/api/auth/vk/callback","scope":["email"]},"twitch":{"icon":"twitch","enabled":false,"key":"","secret":"","callbackUrl":"http://localhost:1337/api/auth/twitch/callback","scope":["user:read:email"]},"linkedin":{"icon":"linkedin","enabled":false,"key":"","secret":"","callbackUrl":"http://localhost:1337/api/auth/linkedin/callback","scope":["r_liteprofile","r_emailaddress"]},"cognito":{"icon":"aws","enabled":false,"key":"","secret":"","subdomain":"my.subdomain.com","callback":"http://localhost:1337/api/auth/cognito/callback","scope":["email","openid","profile"]},"reddit":{"icon":"reddit","enabled":false,"key":"","secret":"","callback":"http://localhost:1337/api/auth/reddit/callback","scope":["identity"]},"auth0":{"icon":"","enabled":false,"key":"","secret":"","subdomain":"my-tenant.eu","callback":"http://localhost:1337/api/auth/auth0/callback","scope":["openid","email","profile"]},"cas":{"icon":"book","enabled":false,"key":"","secret":"","callback":"http://localhost:1337/api/auth/cas/callback","scope":["openid email"],"subdomain":"my.subdomain.com/cas"},"patreon":{"icon":"","enabled":false,"key":"","secret":"","callback":"http://localhost:1337/api/auth/patreon/callback","scope":["identity","identity[email]"]},"keycloak":{"icon":"","enabled":false,"key":"","secret":"","subdomain":"myKeycloakProvider.com/realms/myrealm","callback":"http://localhost:1337/api/auth/keycloak/callback","scope":["openid","email","profile"]}}	object	\N	\N
23	plugin_upload_metrics	{"weeklySchedule":"7 8 6 * * 5","lastWeeklyUpdate":1774591687622}	object	\N	\N
28	core_admin_auth	{"providers":{"autoRegister":false,"defaultRole":null,"ssoLockedRoles":null}}	object	\N	\N
16	plugin_content_manager_configuration_content_types::admin::api-token	{"settings":{"bulkable":true,"filterable":true,"searchable":true,"pageSize":10,"relationOpenMode":"modal","mainField":"name","defaultSortBy":"name","defaultSortOrder":"ASC"},"metadatas":{"id":{"edit":{},"list":{"label":"id","searchable":true,"sortable":true}},"name":{"edit":{"label":"name","description":"","placeholder":"","visible":true,"editable":true},"list":{"label":"name","searchable":true,"sortable":true}},"description":{"edit":{"label":"description","description":"","placeholder":"","visible":true,"editable":true},"list":{"label":"description","searchable":true,"sortable":true}},"type":{"edit":{"label":"type","description":"","placeholder":"","visible":true,"editable":true},"list":{"label":"type","searchable":true,"sortable":true}},"accessKey":{"edit":{"label":"accessKey","description":"","placeholder":"","visible":true,"editable":true},"list":{"label":"accessKey","searchable":true,"sortable":true}},"encryptedKey":{"edit":{"label":"encryptedKey","description":"","placeholder":"","visible":true,"editable":true},"list":{"label":"encryptedKey","searchable":true,"sortable":true}},"lastUsedAt":{"edit":{"label":"lastUsedAt","description":"","placeholder":"","visible":true,"editable":true},"list":{"label":"lastUsedAt","searchable":true,"sortable":true}},"permissions":{"edit":{"label":"permissions","description":"","placeholder":"","visible":true,"editable":true,"mainField":"action"},"list":{"label":"permissions","searchable":false,"sortable":false}},"expiresAt":{"edit":{"label":"expiresAt","description":"","placeholder":"","visible":true,"editable":true},"list":{"label":"expiresAt","searchable":true,"sortable":true}},"lifespan":{"edit":{"label":"lifespan","description":"","placeholder":"","visible":true,"editable":true},"list":{"label":"lifespan","searchable":true,"sortable":true}},"createdAt":{"edit":{"label":"createdAt","description":"","placeholder":"","visible":false,"editable":true},"list":{"label":"createdAt","searchable":true,"sortable":true}},"updatedAt":{"edit":{"label":"updatedAt","description":"","placeholder":"","visible":false,"editable":true},"list":{"label":"updatedAt","searchable":true,"sortable":true}},"createdBy":{"edit":{"label":"createdBy","description":"","placeholder":"","visible":false,"editable":true,"mainField":"firstname"},"list":{"label":"createdBy","searchable":true,"sortable":true}},"updatedBy":{"edit":{"label":"updatedBy","description":"","placeholder":"","visible":false,"editable":true,"mainField":"firstname"},"list":{"label":"updatedBy","searchable":true,"sortable":true}},"documentId":{"edit":{},"list":{"label":"documentId","searchable":true,"sortable":true}}},"layouts":{"list":["id","name","description","type"],"edit":[[{"name":"name","size":6},{"name":"description","size":6}],[{"name":"type","size":6},{"name":"accessKey","size":6}],[{"name":"encryptedKey","size":6},{"name":"lastUsedAt","size":6}],[{"name":"permissions","size":6},{"name":"expiresAt","size":6}],[{"name":"lifespan","size":4}]]},"uid":"admin::api-token"}	object	\N	\N
18	plugin_content_manager_configuration_content_types::admin::api-token-permission	{"settings":{"bulkable":true,"filterable":true,"searchable":true,"pageSize":10,"relationOpenMode":"modal","mainField":"action","defaultSortBy":"action","defaultSortOrder":"ASC"},"metadatas":{"id":{"edit":{},"list":{"label":"id","searchable":true,"sortable":true}},"action":{"edit":{"label":"action","description":"","placeholder":"","visible":true,"editable":true},"list":{"label":"action","searchable":true,"sortable":true}},"token":{"edit":{"label":"token","description":"","placeholder":"","visible":true,"editable":true,"mainField":"name"},"list":{"label":"token","searchable":true,"sortable":true}},"createdAt":{"edit":{"label":"createdAt","description":"","placeholder":"","visible":false,"editable":true},"list":{"label":"createdAt","searchable":true,"sortable":true}},"updatedAt":{"edit":{"label":"updatedAt","description":"","placeholder":"","visible":false,"editable":true},"list":{"label":"updatedAt","searchable":true,"sortable":true}},"createdBy":{"edit":{"label":"createdBy","description":"","placeholder":"","visible":false,"editable":true,"mainField":"firstname"},"list":{"label":"createdBy","searchable":true,"sortable":true}},"updatedBy":{"edit":{"label":"updatedBy","description":"","placeholder":"","visible":false,"editable":true,"mainField":"firstname"},"list":{"label":"updatedBy","searchable":true,"sortable":true}},"documentId":{"edit":{},"list":{"label":"documentId","searchable":true,"sortable":true}}},"layouts":{"list":["id","action","token","createdAt"],"edit":[[{"name":"action","size":6},{"name":"token","size":6}]]},"uid":"admin::api-token-permission"}	object	\N	\N
20	plugin_content_manager_configuration_content_types::admin::session	{"settings":{"bulkable":true,"filterable":true,"searchable":true,"pageSize":10,"relationOpenMode":"modal","mainField":"userId","defaultSortBy":"userId","defaultSortOrder":"ASC"},"metadatas":{"id":{"edit":{},"list":{"label":"id","searchable":true,"sortable":true}},"userId":{"edit":{"label":"userId","description":"","placeholder":"","visible":true,"editable":true},"list":{"label":"userId","searchable":true,"sortable":true}},"sessionId":{"edit":{"label":"sessionId","description":"","placeholder":"","visible":true,"editable":true},"list":{"label":"sessionId","searchable":true,"sortable":true}},"childId":{"edit":{"label":"childId","description":"","placeholder":"","visible":true,"editable":true},"list":{"label":"childId","searchable":true,"sortable":true}},"deviceId":{"edit":{"label":"deviceId","description":"","placeholder":"","visible":true,"editable":true},"list":{"label":"deviceId","searchable":true,"sortable":true}},"origin":{"edit":{"label":"origin","description":"","placeholder":"","visible":true,"editable":true},"list":{"label":"origin","searchable":true,"sortable":true}},"expiresAt":{"edit":{"label":"expiresAt","description":"","placeholder":"","visible":true,"editable":true},"list":{"label":"expiresAt","searchable":true,"sortable":true}},"absoluteExpiresAt":{"edit":{"label":"absoluteExpiresAt","description":"","placeholder":"","visible":true,"editable":true},"list":{"label":"absoluteExpiresAt","searchable":true,"sortable":true}},"status":{"edit":{"label":"status","description":"","placeholder":"","visible":true,"editable":true},"list":{"label":"status","searchable":true,"sortable":true}},"type":{"edit":{"label":"type","description":"","placeholder":"","visible":true,"editable":true},"list":{"label":"type","searchable":true,"sortable":true}},"createdAt":{"edit":{"label":"createdAt","description":"","placeholder":"","visible":false,"editable":true},"list":{"label":"createdAt","searchable":true,"sortable":true}},"updatedAt":{"edit":{"label":"updatedAt","description":"","placeholder":"","visible":false,"editable":true},"list":{"label":"updatedAt","searchable":true,"sortable":true}},"createdBy":{"edit":{"label":"createdBy","description":"","placeholder":"","visible":false,"editable":true,"mainField":"firstname"},"list":{"label":"createdBy","searchable":true,"sortable":true}},"updatedBy":{"edit":{"label":"updatedBy","description":"","placeholder":"","visible":false,"editable":true,"mainField":"firstname"},"list":{"label":"updatedBy","searchable":true,"sortable":true}},"documentId":{"edit":{},"list":{"label":"documentId","searchable":true,"sortable":true}}},"layouts":{"list":["id","userId","sessionId","childId"],"edit":[[{"name":"userId","size":6},{"name":"sessionId","size":6}],[{"name":"childId","size":6},{"name":"deviceId","size":6}],[{"name":"origin","size":6},{"name":"expiresAt","size":6}],[{"name":"absoluteExpiresAt","size":6},{"name":"status","size":6}],[{"name":"type","size":6}]]},"uid":"admin::session"}	object	\N	\N
26	plugin_users-permissions_email	{"reset_password":{"display":"Email.template.reset_password","icon":"sync","options":{"from":{"name":"Administration Panel","email":"no-reply@strapi.io"},"response_email":"","object":"Reset password","message":"<p>We heard that you lost your password. Sorry about that!</p>\\n\\n<p>But donÔÇÖt worry! You can use the following link to reset your password:</p>\\n<p><%= URL %>?code=<%= TOKEN %></p>\\n\\n<p>Thanks.</p>"}},"email_confirmation":{"display":"Email.template.email_confirmation","icon":"check-square","options":{"from":{"name":"Administration Panel","email":"no-reply@strapi.io"},"response_email":"","object":"Account confirmation","message":"<p>Thank you for registering!</p>\\n\\n<p>You have to confirm your email address. Please click on the link below.</p>\\n\\n<p><%= URL %>?confirmation=<%= CODE %></p>\\n\\n<p>Thanks.</p>"}}}	object	\N	\N
27	plugin_users-permissions_advanced	{"unique_email":true,"allow_register":true,"email_confirmation":false,"email_reset_password":null,"email_confirmation_redirection":null,"default_role":"authenticated"}	object	\N	\N
31	plugin_content_manager_configuration_content_types::api::availability-rule.availability-rule	{"settings":{"bulkable":true,"filterable":true,"searchable":true,"pageSize":10,"relationOpenMode":"modal","mainField":"startTime","defaultSortBy":"startTime","defaultSortOrder":"ASC"},"metadatas":{"id":{"edit":{},"list":{"label":"id","searchable":true,"sortable":true}},"dayOfWeek":{"edit":{"label":"dayOfWeek","description":"","placeholder":"","visible":true,"editable":true},"list":{"label":"dayOfWeek","searchable":true,"sortable":true}},"startTime":{"edit":{"label":"startTime","description":"","placeholder":"","visible":true,"editable":true},"list":{"label":"startTime","searchable":true,"sortable":true}},"endTime":{"edit":{"label":"endTime","description":"","placeholder":"","visible":true,"editable":true},"list":{"label":"endTime","searchable":true,"sortable":true}},"isActive":{"edit":{"label":"isActive","description":"","placeholder":"","visible":true,"editable":true},"list":{"label":"isActive","searchable":true,"sortable":true}},"createdAt":{"edit":{"label":"createdAt","description":"","placeholder":"","visible":false,"editable":true},"list":{"label":"createdAt","searchable":true,"sortable":true}},"updatedAt":{"edit":{"label":"updatedAt","description":"","placeholder":"","visible":false,"editable":true},"list":{"label":"updatedAt","searchable":true,"sortable":true}},"createdBy":{"edit":{"label":"createdBy","description":"","placeholder":"","visible":false,"editable":true,"mainField":"firstname"},"list":{"label":"createdBy","searchable":true,"sortable":true}},"updatedBy":{"edit":{"label":"updatedBy","description":"","placeholder":"","visible":false,"editable":true,"mainField":"firstname"},"list":{"label":"updatedBy","searchable":true,"sortable":true}},"documentId":{"edit":{},"list":{"label":"documentId","searchable":true,"sortable":true}}},"layouts":{"list":["id","dayOfWeek","startTime","endTime"],"edit":[[{"name":"dayOfWeek","size":4},{"name":"startTime","size":6}],[{"name":"endTime","size":6},{"name":"isActive","size":4}]]},"uid":"api::availability-rule.availability-rule"}	object	\N	\N
33	plugin_content_manager_configuration_content_types::api::coupon-usage.coupon-usage	{"settings":{"bulkable":true,"filterable":true,"searchable":true,"pageSize":10,"relationOpenMode":"modal","mainField":"documentId","defaultSortBy":"documentId","defaultSortOrder":"ASC"},"metadatas":{"id":{"edit":{},"list":{"label":"id","searchable":true,"sortable":true}},"guestEmail":{"edit":{"label":"guestEmail","description":"","placeholder":"","visible":true,"editable":true},"list":{"label":"guestEmail","searchable":true,"sortable":true}},"discountAmount":{"edit":{"label":"discountAmount","description":"","placeholder":"","visible":true,"editable":true},"list":{"label":"discountAmount","searchable":true,"sortable":true}},"usedAt":{"edit":{"label":"usedAt","description":"","placeholder":"","visible":true,"editable":true},"list":{"label":"usedAt","searchable":true,"sortable":true}},"coupon":{"edit":{"label":"coupon","description":"","placeholder":"","visible":true,"editable":true,"mainField":"code"},"list":{"label":"coupon","searchable":true,"sortable":true}},"user":{"edit":{"label":"user","description":"","placeholder":"","visible":true,"editable":true,"mainField":"phone"},"list":{"label":"user","searchable":true,"sortable":true}},"order":{"edit":{"label":"order","description":"","placeholder":"","visible":true,"editable":true,"mainField":"guestName"},"list":{"label":"order","searchable":true,"sortable":true}},"createdAt":{"edit":{"label":"createdAt","description":"","placeholder":"","visible":false,"editable":true},"list":{"label":"createdAt","searchable":true,"sortable":true}},"updatedAt":{"edit":{"label":"updatedAt","description":"","placeholder":"","visible":false,"editable":true},"list":{"label":"updatedAt","searchable":true,"sortable":true}},"createdBy":{"edit":{"label":"createdBy","description":"","placeholder":"","visible":false,"editable":true,"mainField":"firstname"},"list":{"label":"createdBy","searchable":true,"sortable":true}},"updatedBy":{"edit":{"label":"updatedBy","description":"","placeholder":"","visible":false,"editable":true,"mainField":"firstname"},"list":{"label":"updatedBy","searchable":true,"sortable":true}},"documentId":{"edit":{},"list":{"label":"documentId","searchable":true,"sortable":true}}},"layouts":{"list":["id","guestEmail","discountAmount","usedAt"],"edit":[[{"name":"guestEmail","size":6},{"name":"discountAmount","size":4}],[{"name":"usedAt","size":6},{"name":"coupon","size":6}],[{"name":"user","size":6},{"name":"order","size":6}]]},"uid":"api::coupon-usage.coupon-usage"}	object	\N	\N
29	plugin_content_manager_configuration_content_types::api::digital-asset.digital-asset	{"settings":{"bulkable":true,"filterable":true,"searchable":true,"pageSize":10,"relationOpenMode":"modal","mainField":"url","defaultSortBy":"url","defaultSortOrder":"ASC"},"metadatas":{"id":{"edit":{},"list":{"label":"id","searchable":true,"sortable":true}},"assetType":{"edit":{"label":"assetType","description":"","placeholder":"","visible":true,"editable":true},"list":{"label":"assetType","searchable":true,"sortable":true}},"url":{"edit":{"label":"url","description":"","placeholder":"","visible":true,"editable":true},"list":{"label":"url","searchable":true,"sortable":true}},"fileName":{"edit":{"label":"fileName","description":"","placeholder":"","visible":true,"editable":true},"list":{"label":"fileName","searchable":true,"sortable":true}},"fileSize":{"edit":{"label":"fileSize","description":"","placeholder":"","visible":true,"editable":true},"list":{"label":"fileSize","searchable":true,"sortable":true}},"accessInstructions":{"edit":{"label":"accessInstructions","description":"","placeholder":"","visible":true,"editable":true},"list":{"label":"accessInstructions","searchable":true,"sortable":true}},"product":{"edit":{"label":"product","description":"","placeholder":"","visible":true,"editable":true,"mainField":"name"},"list":{"label":"product","searchable":true,"sortable":true}},"purchases":{"edit":{"label":"purchases","description":"","placeholder":"","visible":true,"editable":true,"mainField":"accessUrl"},"list":{"label":"purchases","searchable":false,"sortable":false}},"createdAt":{"edit":{"label":"createdAt","description":"","placeholder":"","visible":false,"editable":true},"list":{"label":"createdAt","searchable":true,"sortable":true}},"updatedAt":{"edit":{"label":"updatedAt","description":"","placeholder":"","visible":false,"editable":true},"list":{"label":"updatedAt","searchable":true,"sortable":true}},"createdBy":{"edit":{"label":"createdBy","description":"","placeholder":"","visible":false,"editable":true,"mainField":"firstname"},"list":{"label":"createdBy","searchable":true,"sortable":true}},"updatedBy":{"edit":{"label":"updatedBy","description":"","placeholder":"","visible":false,"editable":true,"mainField":"firstname"},"list":{"label":"updatedBy","searchable":true,"sortable":true}},"documentId":{"edit":{},"list":{"label":"documentId","searchable":true,"sortable":true}}},"layouts":{"list":["id","assetType","url","fileName"],"edit":[[{"name":"assetType","size":6},{"name":"url","size":6}],[{"name":"fileName","size":6},{"name":"fileSize","size":4}],[{"name":"accessInstructions","size":6},{"name":"product","size":6}],[{"name":"purchases","size":6}]]},"uid":"api::digital-asset.digital-asset"}	object	\N	\N
32	plugin_content_manager_configuration_content_types::api::business-setting.business-setting	{"settings":{"bulkable":true,"filterable":true,"searchable":true,"pageSize":10,"relationOpenMode":"modal","mainField":"businessName","defaultSortBy":"businessName","defaultSortOrder":"ASC"},"metadatas":{"id":{"edit":{},"list":{"label":"id","searchable":true,"sortable":true}},"businessName":{"edit":{"label":"businessName","description":"","placeholder":"","visible":true,"editable":true},"list":{"label":"businessName","searchable":true,"sortable":true}},"gstin":{"edit":{"label":"gstin","description":"","placeholder":"","visible":true,"editable":true},"list":{"label":"gstin","searchable":true,"sortable":true}},"pan":{"edit":{"label":"pan","description":"","placeholder":"","visible":true,"editable":true},"list":{"label":"pan","searchable":true,"sortable":true}},"address":{"edit":{"label":"address","description":"","placeholder":"","visible":true,"editable":true},"list":{"label":"address","searchable":true,"sortable":true}},"state":{"edit":{"label":"state","description":"","placeholder":"","visible":true,"editable":true},"list":{"label":"state","searchable":true,"sortable":true}},"stateCode":{"edit":{"label":"stateCode","description":"","placeholder":"","visible":true,"editable":true},"list":{"label":"stateCode","searchable":true,"sortable":true}},"phone":{"edit":{"label":"phone","description":"","placeholder":"","visible":true,"editable":true},"list":{"label":"phone","searchable":true,"sortable":true}},"email":{"edit":{"label":"email","description":"","placeholder":"","visible":true,"editable":true},"list":{"label":"email","searchable":true,"sortable":true}},"logoUrl":{"edit":{"label":"logoUrl","description":"","placeholder":"","visible":true,"editable":true},"list":{"label":"logoUrl","searchable":true,"sortable":true}},"bankName":{"edit":{"label":"bankName","description":"","placeholder":"","visible":true,"editable":true},"list":{"label":"bankName","searchable":true,"sortable":true}},"bankAccount":{"edit":{"label":"bankAccount","description":"","placeholder":"","visible":true,"editable":true},"list":{"label":"bankAccount","searchable":true,"sortable":true}},"bankIfsc":{"edit":{"label":"bankIfsc","description":"","placeholder":"","visible":true,"editable":true},"list":{"label":"bankIfsc","searchable":true,"sortable":true}},"invoicePrefix":{"edit":{"label":"invoicePrefix","description":"","placeholder":"","visible":true,"editable":true},"list":{"label":"invoicePrefix","searchable":true,"sortable":true}},"nextInvoiceNumber":{"edit":{"label":"nextInvoiceNumber","description":"","placeholder":"","visible":true,"editable":true},"list":{"label":"nextInvoiceNumber","searchable":true,"sortable":true}},"fbPixelId":{"edit":{"label":"fbPixelId","description":"","placeholder":"","visible":true,"editable":true},"list":{"label":"fbPixelId","searchable":true,"sortable":true}},"fbPixelEnabled":{"edit":{"label":"fbPixelEnabled","description":"","placeholder":"","visible":true,"editable":true},"list":{"label":"fbPixelEnabled","searchable":true,"sortable":true}},"createdAt":{"edit":{"label":"createdAt","description":"","placeholder":"","visible":false,"editable":true},"list":{"label":"createdAt","searchable":true,"sortable":true}},"updatedAt":{"edit":{"label":"updatedAt","description":"","placeholder":"","visible":false,"editable":true},"list":{"label":"updatedAt","searchable":true,"sortable":true}},"createdBy":{"edit":{"label":"createdBy","description":"","placeholder":"","visible":false,"editable":true,"mainField":"firstname"},"list":{"label":"createdBy","searchable":true,"sortable":true}},"updatedBy":{"edit":{"label":"updatedBy","description":"","placeholder":"","visible":false,"editable":true,"mainField":"firstname"},"list":{"label":"updatedBy","searchable":true,"sortable":true}},"documentId":{"edit":{},"list":{"label":"documentId","searchable":true,"sortable":true}}},"layouts":{"list":["id","businessName","gstin","pan"],"edit":[[{"name":"businessName","size":6},{"name":"gstin","size":6}],[{"name":"pan","size":6},{"name":"address","size":6}],[{"name":"state","size":6},{"name":"stateCode","size":6}],[{"name":"phone","size":6},{"name":"email","size":6}],[{"name":"logoUrl","size":6},{"name":"bankName","size":6}],[{"name":"bankAccount","size":6},{"name":"bankIfsc","size":6}],[{"name":"invoicePrefix","size":6},{"name":"nextInvoiceNumber","size":4}],[{"name":"fbPixelId","size":6},{"name":"fbPixelEnabled","size":4}]]},"uid":"api::business-setting.business-setting"}	object	\N	\N
30	plugin_content_manager_configuration_content_types::api::booking.booking	{"settings":{"bulkable":true,"filterable":true,"searchable":true,"pageSize":10,"relationOpenMode":"modal","mainField":"guestName","defaultSortBy":"guestName","defaultSortOrder":"ASC"},"metadatas":{"id":{"edit":{},"list":{"label":"id","searchable":true,"sortable":true}},"guestName":{"edit":{"label":"guestName","description":"","placeholder":"","visible":true,"editable":true},"list":{"label":"guestName","searchable":true,"sortable":true}},"guestEmail":{"edit":{"label":"guestEmail","description":"","placeholder":"","visible":true,"editable":true},"list":{"label":"guestEmail","searchable":true,"sortable":true}},"guestPhone":{"edit":{"label":"guestPhone","description":"","placeholder":"","visible":true,"editable":true},"list":{"label":"guestPhone","searchable":true,"sortable":true}},"scheduledAt":{"edit":{"label":"scheduledAt","description":"","placeholder":"","visible":true,"editable":true},"list":{"label":"scheduledAt","searchable":true,"sortable":true}},"endAt":{"edit":{"label":"endAt","description":"","placeholder":"","visible":true,"editable":true},"list":{"label":"endAt","searchable":true,"sortable":true}},"status":{"edit":{"label":"status","description":"","placeholder":"","visible":true,"editable":true},"list":{"label":"status","searchable":true,"sortable":true}},"paymentStatus":{"edit":{"label":"paymentStatus","description":"","placeholder":"","visible":true,"editable":true},"list":{"label":"paymentStatus","searchable":true,"sortable":true}},"rzpOrderId":{"edit":{"label":"rzpOrderId","description":"","placeholder":"","visible":true,"editable":true},"list":{"label":"rzpOrderId","searchable":true,"sortable":true}},"rzpPaymentId":{"edit":{"label":"rzpPaymentId","description":"","placeholder":"","visible":true,"editable":true},"list":{"label":"rzpPaymentId","searchable":true,"sortable":true}},"rzpSignature":{"edit":{"label":"rzpSignature","description":"","placeholder":"","visible":true,"editable":true},"list":{"label":"rzpSignature","searchable":true,"sortable":true}},"amountPaid":{"edit":{"label":"amountPaid","description":"","placeholder":"","visible":true,"editable":true},"list":{"label":"amountPaid","searchable":true,"sortable":true}},"gcalEventId":{"edit":{"label":"gcalEventId","description":"","placeholder":"","visible":true,"editable":true},"list":{"label":"gcalEventId","searchable":true,"sortable":true}},"customerNotes":{"edit":{"label":"customerNotes","description":"","placeholder":"","visible":true,"editable":true},"list":{"label":"customerNotes","searchable":true,"sortable":true}},"adminNotes":{"edit":{"label":"adminNotes","description":"","placeholder":"","visible":true,"editable":true},"list":{"label":"adminNotes","searchable":true,"sortable":true}},"cancelledAt":{"edit":{"label":"cancelledAt","description":"","placeholder":"","visible":true,"editable":true},"list":{"label":"cancelledAt","searchable":true,"sortable":true}},"cancelReason":{"edit":{"label":"cancelReason","description":"","placeholder":"","visible":true,"editable":true},"list":{"label":"cancelReason","searchable":true,"sortable":true}},"rescheduledFrom":{"edit":{"label":"rescheduledFrom","description":"","placeholder":"","visible":true,"editable":true},"list":{"label":"rescheduledFrom","searchable":true,"sortable":true}},"legacyId":{"edit":{"label":"legacyId","description":"","placeholder":"","visible":true,"editable":true},"list":{"label":"legacyId","searchable":true,"sortable":true}},"user":{"edit":{"label":"user","description":"","placeholder":"","visible":true,"editable":true,"mainField":"phone"},"list":{"label":"user","searchable":true,"sortable":true}},"service":{"edit":{"label":"service","description":"","placeholder":"","visible":true,"editable":true,"mainField":"name"},"list":{"label":"service","searchable":true,"sortable":true}},"reminders":{"edit":{"label":"reminders","description":"","placeholder":"","visible":true,"editable":true,"mainField":"documentId"},"list":{"label":"reminders","searchable":false,"sortable":false}},"createdAt":{"edit":{"label":"createdAt","description":"","placeholder":"","visible":false,"editable":true},"list":{"label":"createdAt","searchable":true,"sortable":true}},"updatedAt":{"edit":{"label":"updatedAt","description":"","placeholder":"","visible":false,"editable":true},"list":{"label":"updatedAt","searchable":true,"sortable":true}},"createdBy":{"edit":{"label":"createdBy","description":"","placeholder":"","visible":false,"editable":true,"mainField":"firstname"},"list":{"label":"createdBy","searchable":true,"sortable":true}},"updatedBy":{"edit":{"label":"updatedBy","description":"","placeholder":"","visible":false,"editable":true,"mainField":"firstname"},"list":{"label":"updatedBy","searchable":true,"sortable":true}},"documentId":{"edit":{},"list":{"label":"documentId","searchable":true,"sortable":true}}},"layouts":{"list":["id","guestName","guestEmail","guestPhone"],"edit":[[{"name":"guestName","size":6},{"name":"guestEmail","size":6}],[{"name":"guestPhone","size":6},{"name":"scheduledAt","size":6}],[{"name":"endAt","size":6},{"name":"status","size":6}],[{"name":"paymentStatus","size":6},{"name":"rzpOrderId","size":6}],[{"name":"rzpPaymentId","size":6},{"name":"rzpSignature","size":6}],[{"name":"amountPaid","size":4},{"name":"gcalEventId","size":6}],[{"name":"customerNotes","size":6},{"name":"adminNotes","size":6}],[{"name":"cancelledAt","size":6},{"name":"cancelReason","size":6}],[{"name":"rescheduledFrom","size":6},{"name":"legacyId","size":6}],[{"name":"user","size":6},{"name":"service","size":6}],[{"name":"reminders","size":6}]]},"uid":"api::booking.booking"}	object	\N	\N
34	plugin_content_manager_configuration_content_types::api::commerce-placeholder.commerce-placeholder	{"settings":{"bulkable":true,"filterable":true,"searchable":true,"pageSize":10,"relationOpenMode":"modal","mainField":"name","defaultSortBy":"name","defaultSortOrder":"ASC"},"metadatas":{"id":{"edit":{},"list":{"label":"id","searchable":true,"sortable":true}},"name":{"edit":{"label":"name","description":"","placeholder":"","visible":true,"editable":true},"list":{"label":"name","searchable":true,"sortable":true}},"createdAt":{"edit":{"label":"createdAt","description":"","placeholder":"","visible":false,"editable":true},"list":{"label":"createdAt","searchable":true,"sortable":true}},"updatedAt":{"edit":{"label":"updatedAt","description":"","placeholder":"","visible":false,"editable":true},"list":{"label":"updatedAt","searchable":true,"sortable":true}},"createdBy":{"edit":{"label":"createdBy","description":"","placeholder":"","visible":false,"editable":true,"mainField":"firstname"},"list":{"label":"createdBy","searchable":true,"sortable":true}},"updatedBy":{"edit":{"label":"updatedBy","description":"","placeholder":"","visible":false,"editable":true,"mainField":"firstname"},"list":{"label":"updatedBy","searchable":true,"sortable":true}},"documentId":{"edit":{},"list":{"label":"documentId","searchable":true,"sortable":true}}},"layouts":{"list":["id","name","createdAt","updatedAt"],"edit":[[{"name":"name","size":6}]]},"uid":"api::commerce-placeholder.commerce-placeholder"}	object	\N	\N
35	plugin_content_manager_configuration_content_types::api::email-log.email-log	{"settings":{"bulkable":true,"filterable":true,"searchable":true,"pageSize":10,"relationOpenMode":"modal","mainField":"to","defaultSortBy":"to","defaultSortOrder":"ASC"},"metadatas":{"id":{"edit":{},"list":{"label":"id","searchable":true,"sortable":true}},"to":{"edit":{"label":"to","description":"","placeholder":"","visible":true,"editable":true},"list":{"label":"to","searchable":true,"sortable":true}},"subject":{"edit":{"label":"subject","description":"","placeholder":"","visible":true,"editable":true},"list":{"label":"subject","searchable":true,"sortable":true}},"templateName":{"edit":{"label":"templateName","description":"","placeholder":"","visible":true,"editable":true},"list":{"label":"templateName","searchable":true,"sortable":true}},"status":{"edit":{"label":"status","description":"","placeholder":"","visible":true,"editable":true},"list":{"label":"status","searchable":true,"sortable":true}},"relatedType":{"edit":{"label":"relatedType","description":"","placeholder":"","visible":true,"editable":true},"list":{"label":"relatedType","searchable":true,"sortable":true}},"relatedId":{"edit":{"label":"relatedId","description":"","placeholder":"","visible":true,"editable":true},"list":{"label":"relatedId","searchable":true,"sortable":true}},"error":{"edit":{"label":"error","description":"","placeholder":"","visible":true,"editable":true},"list":{"label":"error","searchable":true,"sortable":true}},"sentAt":{"edit":{"label":"sentAt","description":"","placeholder":"","visible":true,"editable":true},"list":{"label":"sentAt","searchable":true,"sortable":true}},"createdAt":{"edit":{"label":"createdAt","description":"","placeholder":"","visible":false,"editable":true},"list":{"label":"createdAt","searchable":true,"sortable":true}},"updatedAt":{"edit":{"label":"updatedAt","description":"","placeholder":"","visible":false,"editable":true},"list":{"label":"updatedAt","searchable":true,"sortable":true}},"createdBy":{"edit":{"label":"createdBy","description":"","placeholder":"","visible":false,"editable":true,"mainField":"firstname"},"list":{"label":"createdBy","searchable":true,"sortable":true}},"updatedBy":{"edit":{"label":"updatedBy","description":"","placeholder":"","visible":false,"editable":true,"mainField":"firstname"},"list":{"label":"updatedBy","searchable":true,"sortable":true}},"documentId":{"edit":{},"list":{"label":"documentId","searchable":true,"sortable":true}}},"layouts":{"list":["id","to","subject","templateName"],"edit":[[{"name":"to","size":6},{"name":"subject","size":6}],[{"name":"templateName","size":6},{"name":"status","size":6}],[{"name":"relatedType","size":6},{"name":"relatedId","size":6}],[{"name":"error","size":6},{"name":"sentAt","size":6}]]},"uid":"api::email-log.email-log"}	object	\N	\N
36	plugin_content_manager_configuration_content_types::api::invoice.invoice	{"settings":{"bulkable":true,"filterable":true,"searchable":true,"pageSize":10,"relationOpenMode":"modal","mainField":"invoiceNumber","defaultSortBy":"invoiceNumber","defaultSortOrder":"ASC"},"metadatas":{"id":{"edit":{},"list":{"label":"id","searchable":true,"sortable":true}},"invoiceNumber":{"edit":{"label":"invoiceNumber","description":"","placeholder":"","visible":true,"editable":true},"list":{"label":"invoiceNumber","searchable":true,"sortable":true}},"invoiceDate":{"edit":{"label":"invoiceDate","description":"","placeholder":"","visible":true,"editable":true},"list":{"label":"invoiceDate","searchable":true,"sortable":true}},"buyerName":{"edit":{"label":"buyerName","description":"","placeholder":"","visible":true,"editable":true},"list":{"label":"buyerName","searchable":true,"sortable":true}},"buyerAddress":{"edit":{"label":"buyerAddress","description":"","placeholder":"","visible":true,"editable":true},"list":{"label":"buyerAddress","searchable":false,"sortable":false}},"buyerGstin":{"edit":{"label":"buyerGstin","description":"","placeholder":"","visible":true,"editable":true},"list":{"label":"buyerGstin","searchable":true,"sortable":true}},"buyerState":{"edit":{"label":"buyerState","description":"","placeholder":"","visible":true,"editable":true},"list":{"label":"buyerState","searchable":true,"sortable":true}},"buyerStateCode":{"edit":{"label":"buyerStateCode","description":"","placeholder":"","visible":true,"editable":true},"list":{"label":"buyerStateCode","searchable":true,"sortable":true}},"items":{"edit":{"label":"items","description":"","placeholder":"","visible":true,"editable":true},"list":{"label":"items","searchable":false,"sortable":false}},"subtotal":{"edit":{"label":"subtotal","description":"","placeholder":"","visible":true,"editable":true},"list":{"label":"subtotal","searchable":true,"sortable":true}},"cgst":{"edit":{"label":"cgst","description":"","placeholder":"","visible":true,"editable":true},"list":{"label":"cgst","searchable":true,"sortable":true}},"sgst":{"edit":{"label":"sgst","description":"","placeholder":"","visible":true,"editable":true},"list":{"label":"sgst","searchable":true,"sortable":true}},"igst":{"edit":{"label":"igst","description":"","placeholder":"","visible":true,"editable":true},"list":{"label":"igst","searchable":true,"sortable":true}},"totalTax":{"edit":{"label":"totalTax","description":"","placeholder":"","visible":true,"editable":true},"list":{"label":"totalTax","searchable":true,"sortable":true}},"grandTotal":{"edit":{"label":"grandTotal","description":"","placeholder":"","visible":true,"editable":true},"list":{"label":"grandTotal","searchable":true,"sortable":true}},"placeOfSupply":{"edit":{"label":"placeOfSupply","description":"","placeholder":"","visible":true,"editable":true},"list":{"label":"placeOfSupply","searchable":true,"sortable":true}},"isInterState":{"edit":{"label":"isInterState","description":"","placeholder":"","visible":true,"editable":true},"list":{"label":"isInterState","searchable":true,"sortable":true}},"pdfUrl":{"edit":{"label":"pdfUrl","description":"","placeholder":"","visible":true,"editable":true},"list":{"label":"pdfUrl","searchable":true,"sortable":true}},"order":{"edit":{"label":"order","description":"","placeholder":"","visible":true,"editable":true,"mainField":"guestName"},"list":{"label":"order","searchable":true,"sortable":true}},"createdAt":{"edit":{"label":"createdAt","description":"","placeholder":"","visible":false,"editable":true},"list":{"label":"createdAt","searchable":true,"sortable":true}},"updatedAt":{"edit":{"label":"updatedAt","description":"","placeholder":"","visible":false,"editable":true},"list":{"label":"updatedAt","searchable":true,"sortable":true}},"createdBy":{"edit":{"label":"createdBy","description":"","placeholder":"","visible":false,"editable":true,"mainField":"firstname"},"list":{"label":"createdBy","searchable":true,"sortable":true}},"updatedBy":{"edit":{"label":"updatedBy","description":"","placeholder":"","visible":false,"editable":true,"mainField":"firstname"},"list":{"label":"updatedBy","searchable":true,"sortable":true}},"documentId":{"edit":{},"list":{"label":"documentId","searchable":true,"sortable":true}}},"layouts":{"list":["id","invoiceNumber","invoiceDate","buyerName"],"edit":[[{"name":"invoiceNumber","size":6},{"name":"invoiceDate","size":6}],[{"name":"buyerName","size":6}],[{"name":"buyerAddress","size":12}],[{"name":"buyerGstin","size":6},{"name":"buyerState","size":6}],[{"name":"buyerStateCode","size":6}],[{"name":"items","size":12}],[{"name":"subtotal","size":4},{"name":"cgst","size":4},{"name":"sgst","size":4}],[{"name":"igst","size":4},{"name":"totalTax","size":4},{"name":"grandTotal","size":4}],[{"name":"placeOfSupply","size":6},{"name":"isInterState","size":4}],[{"name":"pdfUrl","size":6},{"name":"order","size":6}]]},"uid":"api::invoice.invoice"}	object	\N	\N
48	plugin_content_manager_configuration_content_types::api::contact-message.contact-message	{"settings":{"bulkable":true,"filterable":true,"searchable":true,"pageSize":10,"relationOpenMode":"modal","mainField":"name","defaultSortBy":"name","defaultSortOrder":"ASC"},"metadatas":{"id":{"edit":{},"list":{"label":"id","searchable":true,"sortable":true}},"name":{"edit":{"label":"name","description":"","placeholder":"","visible":true,"editable":true},"list":{"label":"name","searchable":true,"sortable":true}},"email":{"edit":{"label":"email","description":"","placeholder":"","visible":true,"editable":true},"list":{"label":"email","searchable":true,"sortable":true}},"phone":{"edit":{"label":"phone","description":"","placeholder":"","visible":true,"editable":true},"list":{"label":"phone","searchable":true,"sortable":true}},"company":{"edit":{"label":"company","description":"","placeholder":"","visible":true,"editable":true},"list":{"label":"company","searchable":true,"sortable":true}},"message":{"edit":{"label":"message","description":"","placeholder":"","visible":true,"editable":true},"list":{"label":"message","searchable":true,"sortable":true}},"isRead":{"edit":{"label":"isRead","description":"","placeholder":"","visible":true,"editable":true},"list":{"label":"isRead","searchable":true,"sortable":true}},"createdAt":{"edit":{"label":"createdAt","description":"","placeholder":"","visible":false,"editable":true},"list":{"label":"createdAt","searchable":true,"sortable":true}},"updatedAt":{"edit":{"label":"updatedAt","description":"","placeholder":"","visible":false,"editable":true},"list":{"label":"updatedAt","searchable":true,"sortable":true}},"createdBy":{"edit":{"label":"createdBy","description":"","placeholder":"","visible":false,"editable":true,"mainField":"firstname"},"list":{"label":"createdBy","searchable":true,"sortable":true}},"updatedBy":{"edit":{"label":"updatedBy","description":"","placeholder":"","visible":false,"editable":true,"mainField":"firstname"},"list":{"label":"updatedBy","searchable":true,"sortable":true}},"documentId":{"edit":{},"list":{"label":"documentId","searchable":true,"sortable":true}}},"layouts":{"list":["id","name","email","phone"],"edit":[[{"name":"name","size":6},{"name":"email","size":6}],[{"name":"phone","size":6},{"name":"company","size":6}],[{"name":"message","size":6},{"name":"isRead","size":4}]]},"uid":"api::contact-message.contact-message"}	object	\N	\N
38	plugin_content_manager_configuration_content_types::api::digital-purchase.digital-purchase	{"settings":{"bulkable":true,"filterable":true,"searchable":true,"pageSize":10,"relationOpenMode":"modal","mainField":"accessUrl","defaultSortBy":"accessUrl","defaultSortOrder":"ASC"},"metadatas":{"id":{"edit":{},"list":{"label":"id","searchable":true,"sortable":true}},"guestEmail":{"edit":{"label":"guestEmail","description":"","placeholder":"","visible":true,"editable":true},"list":{"label":"guestEmail","searchable":true,"sortable":true}},"accessGrantedAt":{"edit":{"label":"accessGrantedAt","description":"","placeholder":"","visible":true,"editable":true},"list":{"label":"accessGrantedAt","searchable":true,"sortable":true}},"accessUrl":{"edit":{"label":"accessUrl","description":"","placeholder":"","visible":true,"editable":true},"list":{"label":"accessUrl","searchable":true,"sortable":true}},"expiresAt":{"edit":{"label":"expiresAt","description":"","placeholder":"","visible":true,"editable":true},"list":{"label":"expiresAt","searchable":true,"sortable":true}},"user":{"edit":{"label":"user","description":"","placeholder":"","visible":true,"editable":true,"mainField":"phone"},"list":{"label":"user","searchable":true,"sortable":true}},"order":{"edit":{"label":"order","description":"","placeholder":"","visible":true,"editable":true,"mainField":"guestName"},"list":{"label":"order","searchable":true,"sortable":true}},"product":{"edit":{"label":"product","description":"","placeholder":"","visible":true,"editable":true,"mainField":"name"},"list":{"label":"product","searchable":true,"sortable":true}},"asset":{"edit":{"label":"asset","description":"","placeholder":"","visible":true,"editable":true,"mainField":"url"},"list":{"label":"asset","searchable":true,"sortable":true}},"createdAt":{"edit":{"label":"createdAt","description":"","placeholder":"","visible":false,"editable":true},"list":{"label":"createdAt","searchable":true,"sortable":true}},"updatedAt":{"edit":{"label":"updatedAt","description":"","placeholder":"","visible":false,"editable":true},"list":{"label":"updatedAt","searchable":true,"sortable":true}},"createdBy":{"edit":{"label":"createdBy","description":"","placeholder":"","visible":false,"editable":true,"mainField":"firstname"},"list":{"label":"createdBy","searchable":true,"sortable":true}},"updatedBy":{"edit":{"label":"updatedBy","description":"","placeholder":"","visible":false,"editable":true,"mainField":"firstname"},"list":{"label":"updatedBy","searchable":true,"sortable":true}},"documentId":{"edit":{},"list":{"label":"documentId","searchable":true,"sortable":true}}},"layouts":{"list":["id","guestEmail","accessGrantedAt","accessUrl"],"edit":[[{"name":"guestEmail","size":6},{"name":"accessGrantedAt","size":6}],[{"name":"accessUrl","size":6},{"name":"expiresAt","size":6}],[{"name":"user","size":6},{"name":"order","size":6}],[{"name":"product","size":6},{"name":"asset","size":6}]]},"uid":"api::digital-purchase.digital-purchase"}	object	\N	\N
49	plugin_content_manager_configuration_content_types::api::coupon-code.coupon-code	{"settings":{"bulkable":true,"filterable":true,"searchable":true,"pageSize":10,"relationOpenMode":"modal","mainField":"code","defaultSortBy":"code","defaultSortOrder":"ASC"},"metadatas":{"id":{"edit":{},"list":{"label":"id","searchable":true,"sortable":true}},"code":{"edit":{"label":"code","description":"","placeholder":"","visible":true,"editable":true},"list":{"label":"code","searchable":true,"sortable":true}},"description":{"edit":{"label":"description","description":"","placeholder":"","visible":true,"editable":true},"list":{"label":"description","searchable":true,"sortable":true}},"discountType":{"edit":{"label":"discountType","description":"","placeholder":"","visible":true,"editable":true},"list":{"label":"discountType","searchable":true,"sortable":true}},"discountValue":{"edit":{"label":"discountValue","description":"","placeholder":"","visible":true,"editable":true},"list":{"label":"discountValue","searchable":true,"sortable":true}},"minCartTotal":{"edit":{"label":"minCartTotal","description":"","placeholder":"","visible":true,"editable":true},"list":{"label":"minCartTotal","searchable":true,"sortable":true}},"maxDiscount":{"edit":{"label":"maxDiscount","description":"","placeholder":"","visible":true,"editable":true},"list":{"label":"maxDiscount","searchable":true,"sortable":true}},"maxUses":{"edit":{"label":"maxUses","description":"","placeholder":"","visible":true,"editable":true},"list":{"label":"maxUses","searchable":true,"sortable":true}},"usedCount":{"edit":{"label":"usedCount","description":"","placeholder":"","visible":true,"editable":true},"list":{"label":"usedCount","searchable":true,"sortable":true}},"perUserLimit":{"edit":{"label":"perUserLimit","description":"","placeholder":"","visible":true,"editable":true},"list":{"label":"perUserLimit","searchable":true,"sortable":true}},"validFrom":{"edit":{"label":"validFrom","description":"","placeholder":"","visible":true,"editable":true},"list":{"label":"validFrom","searchable":true,"sortable":true}},"validUntil":{"edit":{"label":"validUntil","description":"","placeholder":"","visible":true,"editable":true},"list":{"label":"validUntil","searchable":true,"sortable":true}},"isActive":{"edit":{"label":"isActive","description":"","placeholder":"","visible":true,"editable":true},"list":{"label":"isActive","searchable":true,"sortable":true}},"applicableCategoryIds":{"edit":{"label":"applicableCategoryIds","description":"","placeholder":"","visible":true,"editable":true},"list":{"label":"applicableCategoryIds","searchable":false,"sortable":false}},"applicableProductIds":{"edit":{"label":"applicableProductIds","description":"","placeholder":"","visible":true,"editable":true},"list":{"label":"applicableProductIds","searchable":false,"sortable":false}},"usages":{"edit":{"label":"usages","description":"","placeholder":"","visible":true,"editable":true,"mainField":"documentId"},"list":{"label":"usages","searchable":false,"sortable":false}},"orders":{"edit":{"label":"orders","description":"","placeholder":"","visible":true,"editable":true,"mainField":"guestName"},"list":{"label":"orders","searchable":false,"sortable":false}},"createdAt":{"edit":{"label":"createdAt","description":"","placeholder":"","visible":false,"editable":true},"list":{"label":"createdAt","searchable":true,"sortable":true}},"updatedAt":{"edit":{"label":"updatedAt","description":"","placeholder":"","visible":false,"editable":true},"list":{"label":"updatedAt","searchable":true,"sortable":true}},"createdBy":{"edit":{"label":"createdBy","description":"","placeholder":"","visible":false,"editable":true,"mainField":"firstname"},"list":{"label":"createdBy","searchable":true,"sortable":true}},"updatedBy":{"edit":{"label":"updatedBy","description":"","placeholder":"","visible":false,"editable":true,"mainField":"firstname"},"list":{"label":"updatedBy","searchable":true,"sortable":true}},"documentId":{"edit":{},"list":{"label":"documentId","searchable":true,"sortable":true}}},"layouts":{"list":["id","code","description","discountType"],"edit":[[{"name":"code","size":6},{"name":"description","size":6}],[{"name":"discountType","size":6},{"name":"discountValue","size":4}],[{"name":"minCartTotal","size":4},{"name":"maxDiscount","size":4},{"name":"maxUses","size":4}],[{"name":"usedCount","size":4},{"name":"perUserLimit","size":4}],[{"name":"validFrom","size":6},{"name":"validUntil","size":6}],[{"name":"isActive","size":4}],[{"name":"applicableCategoryIds","size":12}],[{"name":"applicableProductIds","size":12}],[{"name":"usages","size":6},{"name":"orders","size":6}]]},"uid":"api::coupon-code.coupon-code"}	object	\N	\N
58	plugin_content_manager_configuration_content_types::api::shipping-class.shipping-class	{"settings":{"bulkable":true,"filterable":true,"searchable":true,"pageSize":10,"relationOpenMode":"modal","mainField":"name","defaultSortBy":"name","defaultSortOrder":"ASC"},"metadatas":{"id":{"edit":{},"list":{"label":"id","searchable":true,"sortable":true}},"name":{"edit":{"label":"name","description":"","placeholder":"","visible":true,"editable":true},"list":{"label":"name","searchable":true,"sortable":true}},"rate":{"edit":{"label":"rate","description":"","placeholder":"","visible":true,"editable":true},"list":{"label":"rate","searchable":true,"sortable":true}},"freeAbove":{"edit":{"label":"freeAbove","description":"","placeholder":"","visible":true,"editable":true},"list":{"label":"freeAbove","searchable":true,"sortable":true}},"description":{"edit":{"label":"description","description":"","placeholder":"","visible":true,"editable":true},"list":{"label":"description","searchable":true,"sortable":true}},"products":{"edit":{"label":"products","description":"","placeholder":"","visible":true,"editable":true,"mainField":"name"},"list":{"label":"products","searchable":false,"sortable":false}},"createdAt":{"edit":{"label":"createdAt","description":"","placeholder":"","visible":false,"editable":true},"list":{"label":"createdAt","searchable":true,"sortable":true}},"updatedAt":{"edit":{"label":"updatedAt","description":"","placeholder":"","visible":false,"editable":true},"list":{"label":"updatedAt","searchable":true,"sortable":true}},"createdBy":{"edit":{"label":"createdBy","description":"","placeholder":"","visible":false,"editable":true,"mainField":"firstname"},"list":{"label":"createdBy","searchable":true,"sortable":true}},"updatedBy":{"edit":{"label":"updatedBy","description":"","placeholder":"","visible":false,"editable":true,"mainField":"firstname"},"list":{"label":"updatedBy","searchable":true,"sortable":true}},"documentId":{"edit":{},"list":{"label":"documentId","searchable":true,"sortable":true}}},"layouts":{"list":["id","name","rate","freeAbove"],"edit":[[{"name":"name","size":6},{"name":"rate","size":4}],[{"name":"freeAbove","size":4},{"name":"description","size":6}],[{"name":"products","size":6}]]},"uid":"api::shipping-class.shipping-class"}	object	\N	\N
11	plugin_content_manager_configuration_content_types::plugin::users-permissions.role	{"settings":{"bulkable":true,"filterable":true,"searchable":true,"pageSize":10,"relationOpenMode":"modal","mainField":"name","defaultSortBy":"name","defaultSortOrder":"ASC"},"metadatas":{"id":{"edit":{},"list":{"label":"id","searchable":true,"sortable":true}},"name":{"edit":{"label":"name","description":"","placeholder":"","visible":true,"editable":true},"list":{"label":"name","searchable":true,"sortable":true}},"description":{"edit":{"label":"description","description":"","placeholder":"","visible":true,"editable":true},"list":{"label":"description","searchable":true,"sortable":true}},"type":{"edit":{"label":"type","description":"","placeholder":"","visible":true,"editable":true},"list":{"label":"type","searchable":true,"sortable":true}},"permissions":{"edit":{"label":"permissions","description":"","placeholder":"","visible":true,"editable":true,"mainField":"action"},"list":{"label":"permissions","searchable":false,"sortable":false}},"users":{"edit":{"label":"users","description":"","placeholder":"","visible":true,"editable":true,"mainField":"phone"},"list":{"label":"users","searchable":false,"sortable":false}},"createdAt":{"edit":{"label":"createdAt","description":"","placeholder":"","visible":false,"editable":true},"list":{"label":"createdAt","searchable":true,"sortable":true}},"updatedAt":{"edit":{"label":"updatedAt","description":"","placeholder":"","visible":false,"editable":true},"list":{"label":"updatedAt","searchable":true,"sortable":true}},"createdBy":{"edit":{"label":"createdBy","description":"","placeholder":"","visible":false,"editable":true,"mainField":"firstname"},"list":{"label":"createdBy","searchable":true,"sortable":true}},"updatedBy":{"edit":{"label":"updatedBy","description":"","placeholder":"","visible":false,"editable":true,"mainField":"firstname"},"list":{"label":"updatedBy","searchable":true,"sortable":true}},"documentId":{"edit":{},"list":{"label":"documentId","searchable":true,"sortable":true}}},"layouts":{"list":["id","name","description","type"],"edit":[[{"name":"name","size":6},{"name":"description","size":6}],[{"name":"type","size":6},{"name":"permissions","size":6}],[{"name":"users","size":6}]]},"uid":"plugin::users-permissions.role"}	object	\N	\N
40	plugin_content_manager_configuration_content_types::api::order.order	{"settings":{"bulkable":true,"filterable":true,"searchable":true,"pageSize":10,"relationOpenMode":"modal","mainField":"guestName","defaultSortBy":"guestName","defaultSortOrder":"ASC"},"metadatas":{"id":{"edit":{},"list":{"label":"id","searchable":true,"sortable":true}},"guestName":{"edit":{"label":"guestName","description":"","placeholder":"","visible":true,"editable":true},"list":{"label":"guestName","searchable":true,"sortable":true}},"guestEmail":{"edit":{"label":"guestEmail","description":"","placeholder":"","visible":true,"editable":true},"list":{"label":"guestEmail","searchable":true,"sortable":true}},"guestPhone":{"edit":{"label":"guestPhone","description":"","placeholder":"","visible":true,"editable":true},"list":{"label":"guestPhone","searchable":true,"sortable":true}},"status":{"edit":{"label":"status","description":"","placeholder":"","visible":true,"editable":true},"list":{"label":"status","searchable":true,"sortable":true}},"subtotal":{"edit":{"label":"subtotal","description":"","placeholder":"","visible":true,"editable":true},"list":{"label":"subtotal","searchable":true,"sortable":true}},"discount":{"edit":{"label":"discount","description":"","placeholder":"","visible":true,"editable":true},"list":{"label":"discount","searchable":true,"sortable":true}},"tax":{"edit":{"label":"tax","description":"","placeholder":"","visible":true,"editable":true},"list":{"label":"tax","searchable":true,"sortable":true}},"shippingAmount":{"edit":{"label":"shippingAmount","description":"","placeholder":"","visible":true,"editable":true},"list":{"label":"shippingAmount","searchable":true,"sortable":true}},"total":{"edit":{"label":"total","description":"","placeholder":"","visible":true,"editable":true},"list":{"label":"total","searchable":true,"sortable":true}},"rzpOrderId":{"edit":{"label":"rzpOrderId","description":"","placeholder":"","visible":true,"editable":true},"list":{"label":"rzpOrderId","searchable":true,"sortable":true}},"rzpPaymentId":{"edit":{"label":"rzpPaymentId","description":"","placeholder":"","visible":true,"editable":true},"list":{"label":"rzpPaymentId","searchable":true,"sortable":true}},"rzpSignature":{"edit":{"label":"rzpSignature","description":"","placeholder":"","visible":true,"editable":true},"list":{"label":"rzpSignature","searchable":true,"sortable":true}},"paymentStatus":{"edit":{"label":"paymentStatus","description":"","placeholder":"","visible":true,"editable":true},"list":{"label":"paymentStatus","searchable":true,"sortable":true}},"paymentMethod":{"edit":{"label":"paymentMethod","description":"","placeholder":"","visible":true,"editable":true},"list":{"label":"paymentMethod","searchable":true,"sortable":true}},"refundId":{"edit":{"label":"refundId","description":"","placeholder":"","visible":true,"editable":true},"list":{"label":"refundId","searchable":true,"sortable":true}},"refundStatus":{"edit":{"label":"refundStatus","description":"","placeholder":"","visible":true,"editable":true},"list":{"label":"refundStatus","searchable":true,"sortable":true}},"refundAmount":{"edit":{"label":"refundAmount","description":"","placeholder":"","visible":true,"editable":true},"list":{"label":"refundAmount","searchable":true,"sortable":true}},"shippingAddress":{"edit":{"label":"shippingAddress","description":"","placeholder":"","visible":true,"editable":true},"list":{"label":"shippingAddress","searchable":false,"sortable":false}},"billingAddress":{"edit":{"label":"billingAddress","description":"","placeholder":"","visible":true,"editable":true},"list":{"label":"billingAddress","searchable":false,"sortable":false}},"notes":{"edit":{"label":"notes","description":"","placeholder":"","visible":true,"editable":true},"list":{"label":"notes","searchable":true,"sortable":true}},"legacyId":{"edit":{"label":"legacyId","description":"","placeholder":"","visible":true,"editable":true},"list":{"label":"legacyId","searchable":true,"sortable":true}},"user":{"edit":{"label":"user","description":"","placeholder":"","visible":true,"editable":true,"mainField":"phone"},"list":{"label":"user","searchable":true,"sortable":true}},"coupon":{"edit":{"label":"coupon","description":"","placeholder":"","visible":true,"editable":true,"mainField":"code"},"list":{"label":"coupon","searchable":true,"sortable":true}},"items":{"edit":{"label":"items","description":"","placeholder":"","visible":true,"editable":true,"mainField":"hsnCode"},"list":{"label":"items","searchable":false,"sortable":false}},"invoice":{"edit":{"label":"invoice","description":"","placeholder":"","visible":true,"editable":true,"mainField":"invoiceNumber"},"list":{"label":"invoice","searchable":true,"sortable":true}},"shipment":{"edit":{"label":"shipment","description":"","placeholder":"","visible":true,"editable":true,"mainField":"courierName"},"list":{"label":"shipment","searchable":true,"sortable":true}},"digitalPurchases":{"edit":{"label":"digitalPurchases","description":"","placeholder":"","visible":true,"editable":true,"mainField":"accessUrl"},"list":{"label":"digitalPurchases","searchable":false,"sortable":false}},"couponUsages":{"edit":{"label":"couponUsages","description":"","placeholder":"","visible":true,"editable":true,"mainField":"documentId"},"list":{"label":"couponUsages","searchable":false,"sortable":false}},"createdAt":{"edit":{"label":"createdAt","description":"","placeholder":"","visible":false,"editable":true},"list":{"label":"createdAt","searchable":true,"sortable":true}},"updatedAt":{"edit":{"label":"updatedAt","description":"","placeholder":"","visible":false,"editable":true},"list":{"label":"updatedAt","searchable":true,"sortable":true}},"createdBy":{"edit":{"label":"createdBy","description":"","placeholder":"","visible":false,"editable":true,"mainField":"firstname"},"list":{"label":"createdBy","searchable":true,"sortable":true}},"updatedBy":{"edit":{"label":"updatedBy","description":"","placeholder":"","visible":false,"editable":true,"mainField":"firstname"},"list":{"label":"updatedBy","searchable":true,"sortable":true}},"documentId":{"edit":{},"list":{"label":"documentId","searchable":true,"sortable":true}}},"layouts":{"list":["id","guestName","guestEmail","guestPhone"],"edit":[[{"name":"guestName","size":6},{"name":"guestEmail","size":6}],[{"name":"guestPhone","size":6},{"name":"status","size":6}],[{"name":"subtotal","size":4},{"name":"discount","size":4},{"name":"tax","size":4}],[{"name":"shippingAmount","size":4},{"name":"total","size":4}],[{"name":"rzpOrderId","size":6},{"name":"rzpPaymentId","size":6}],[{"name":"rzpSignature","size":6},{"name":"paymentStatus","size":6}],[{"name":"paymentMethod","size":6},{"name":"refundId","size":6}],[{"name":"refundStatus","size":6},{"name":"refundAmount","size":4}],[{"name":"shippingAddress","size":12}],[{"name":"billingAddress","size":12}],[{"name":"notes","size":6},{"name":"legacyId","size":6}],[{"name":"user","size":6},{"name":"coupon","size":6}],[{"name":"items","size":6},{"name":"invoice","size":6}],[{"name":"shipment","size":6},{"name":"digitalPurchases","size":6}],[{"name":"couponUsages","size":6}]]},"uid":"api::order.order"}	object	\N	\N
42	plugin_content_manager_configuration_content_types::api::order-shipment.order-shipment	{"settings":{"bulkable":true,"filterable":true,"searchable":true,"pageSize":10,"relationOpenMode":"modal","mainField":"courierName","defaultSortBy":"courierName","defaultSortOrder":"ASC"},"metadatas":{"id":{"edit":{},"list":{"label":"id","searchable":true,"sortable":true}},"courierName":{"edit":{"label":"courierName","description":"","placeholder":"","visible":true,"editable":true},"list":{"label":"courierName","searchable":true,"sortable":true}},"trackingNumber":{"edit":{"label":"trackingNumber","description":"","placeholder":"","visible":true,"editable":true},"list":{"label":"trackingNumber","searchable":true,"sortable":true}},"trackingUrl":{"edit":{"label":"trackingUrl","description":"","placeholder":"","visible":true,"editable":true},"list":{"label":"trackingUrl","searchable":true,"sortable":true}},"shippedAt":{"edit":{"label":"shippedAt","description":"","placeholder":"","visible":true,"editable":true},"list":{"label":"shippedAt","searchable":true,"sortable":true}},"deliveredAt":{"edit":{"label":"deliveredAt","description":"","placeholder":"","visible":true,"editable":true},"list":{"label":"deliveredAt","searchable":true,"sortable":true}},"notes":{"edit":{"label":"notes","description":"","placeholder":"","visible":true,"editable":true},"list":{"label":"notes","searchable":true,"sortable":true}},"order":{"edit":{"label":"order","description":"","placeholder":"","visible":true,"editable":true,"mainField":"guestName"},"list":{"label":"order","searchable":true,"sortable":true}},"createdAt":{"edit":{"label":"createdAt","description":"","placeholder":"","visible":false,"editable":true},"list":{"label":"createdAt","searchable":true,"sortable":true}},"updatedAt":{"edit":{"label":"updatedAt","description":"","placeholder":"","visible":false,"editable":true},"list":{"label":"updatedAt","searchable":true,"sortable":true}},"createdBy":{"edit":{"label":"createdBy","description":"","placeholder":"","visible":false,"editable":true,"mainField":"firstname"},"list":{"label":"createdBy","searchable":true,"sortable":true}},"updatedBy":{"edit":{"label":"updatedBy","description":"","placeholder":"","visible":false,"editable":true,"mainField":"firstname"},"list":{"label":"updatedBy","searchable":true,"sortable":true}},"documentId":{"edit":{},"list":{"label":"documentId","searchable":true,"sortable":true}}},"layouts":{"list":["id","courierName","trackingNumber","trackingUrl"],"edit":[[{"name":"courierName","size":6},{"name":"trackingNumber","size":6}],[{"name":"trackingUrl","size":6},{"name":"shippedAt","size":6}],[{"name":"deliveredAt","size":6},{"name":"notes","size":6}],[{"name":"order","size":6}]]},"uid":"api::order-shipment.order-shipment"}	object	\N	\N
44	plugin_content_manager_configuration_content_types::api::popup.popup	{"settings":{"bulkable":true,"filterable":true,"searchable":true,"pageSize":10,"relationOpenMode":"modal","mainField":"title","defaultSortBy":"title","defaultSortOrder":"ASC"},"metadatas":{"id":{"edit":{},"list":{"label":"id","searchable":true,"sortable":true}},"title":{"edit":{"label":"title","description":"","placeholder":"","visible":true,"editable":true},"list":{"label":"title","searchable":true,"sortable":true}},"content":{"edit":{"label":"content","description":"","placeholder":"","visible":true,"editable":true},"list":{"label":"content","searchable":true,"sortable":true}},"imageUrl":{"edit":{"label":"imageUrl","description":"","placeholder":"","visible":true,"editable":true},"list":{"label":"imageUrl","searchable":true,"sortable":true}},"linkUrl":{"edit":{"label":"linkUrl","description":"","placeholder":"","visible":true,"editable":true},"list":{"label":"linkUrl","searchable":true,"sortable":true}},"triggerType":{"edit":{"label":"triggerType","description":"","placeholder":"","visible":true,"editable":true},"list":{"label":"triggerType","searchable":true,"sortable":true}},"triggerValue":{"edit":{"label":"triggerValue","description":"","placeholder":"","visible":true,"editable":true},"list":{"label":"triggerValue","searchable":true,"sortable":true}},"showOnPages":{"edit":{"label":"showOnPages","description":"","placeholder":"","visible":true,"editable":true},"list":{"label":"showOnPages","searchable":false,"sortable":false}},"frequency":{"edit":{"label":"frequency","description":"","placeholder":"","visible":true,"editable":true},"list":{"label":"frequency","searchable":true,"sortable":true}},"startDate":{"edit":{"label":"startDate","description":"","placeholder":"","visible":true,"editable":true},"list":{"label":"startDate","searchable":true,"sortable":true}},"endDate":{"edit":{"label":"endDate","description":"","placeholder":"","visible":true,"editable":true},"list":{"label":"endDate","searchable":true,"sortable":true}},"isActive":{"edit":{"label":"isActive","description":"","placeholder":"","visible":true,"editable":true},"list":{"label":"isActive","searchable":true,"sortable":true}},"createdAt":{"edit":{"label":"createdAt","description":"","placeholder":"","visible":false,"editable":true},"list":{"label":"createdAt","searchable":true,"sortable":true}},"updatedAt":{"edit":{"label":"updatedAt","description":"","placeholder":"","visible":false,"editable":true},"list":{"label":"updatedAt","searchable":true,"sortable":true}},"createdBy":{"edit":{"label":"createdBy","description":"","placeholder":"","visible":false,"editable":true,"mainField":"firstname"},"list":{"label":"createdBy","searchable":true,"sortable":true}},"updatedBy":{"edit":{"label":"updatedBy","description":"","placeholder":"","visible":false,"editable":true,"mainField":"firstname"},"list":{"label":"updatedBy","searchable":true,"sortable":true}},"documentId":{"edit":{},"list":{"label":"documentId","searchable":true,"sortable":true}}},"layouts":{"list":["id","title","content","imageUrl"],"edit":[[{"name":"title","size":6},{"name":"content","size":6}],[{"name":"imageUrl","size":6},{"name":"linkUrl","size":6}],[{"name":"triggerType","size":6},{"name":"triggerValue","size":4}],[{"name":"showOnPages","size":12}],[{"name":"frequency","size":6},{"name":"startDate","size":6}],[{"name":"endDate","size":6},{"name":"isActive","size":4}]]},"uid":"api::popup.popup"}	object	\N	\N
46	plugin_content_manager_configuration_content_types::api::banner.banner	{"settings":{"bulkable":true,"filterable":true,"searchable":true,"pageSize":10,"relationOpenMode":"modal","mainField":"title","defaultSortBy":"title","defaultSortOrder":"ASC"},"metadatas":{"id":{"edit":{},"list":{"label":"id","searchable":true,"sortable":true}},"title":{"edit":{"label":"title","description":"","placeholder":"","visible":true,"editable":true},"list":{"label":"title","searchable":true,"sortable":true}},"imageUrl":{"edit":{"label":"imageUrl","description":"","placeholder":"","visible":true,"editable":true},"list":{"label":"imageUrl","searchable":true,"sortable":true}},"linkUrl":{"edit":{"label":"linkUrl","description":"","placeholder":"","visible":true,"editable":true},"list":{"label":"linkUrl","searchable":true,"sortable":true}},"position":{"edit":{"label":"position","description":"","placeholder":"","visible":true,"editable":true},"list":{"label":"position","searchable":true,"sortable":true}},"startDate":{"edit":{"label":"startDate","description":"","placeholder":"","visible":true,"editable":true},"list":{"label":"startDate","searchable":true,"sortable":true}},"endDate":{"edit":{"label":"endDate","description":"","placeholder":"","visible":true,"editable":true},"list":{"label":"endDate","searchable":true,"sortable":true}},"isActive":{"edit":{"label":"isActive","description":"","placeholder":"","visible":true,"editable":true},"list":{"label":"isActive","searchable":true,"sortable":true}},"sortOrder":{"edit":{"label":"sortOrder","description":"","placeholder":"","visible":true,"editable":true},"list":{"label":"sortOrder","searchable":true,"sortable":true}},"createdAt":{"edit":{"label":"createdAt","description":"","placeholder":"","visible":false,"editable":true},"list":{"label":"createdAt","searchable":true,"sortable":true}},"updatedAt":{"edit":{"label":"updatedAt","description":"","placeholder":"","visible":false,"editable":true},"list":{"label":"updatedAt","searchable":true,"sortable":true}},"createdBy":{"edit":{"label":"createdBy","description":"","placeholder":"","visible":false,"editable":true,"mainField":"firstname"},"list":{"label":"createdBy","searchable":true,"sortable":true}},"updatedBy":{"edit":{"label":"updatedBy","description":"","placeholder":"","visible":false,"editable":true,"mainField":"firstname"},"list":{"label":"updatedBy","searchable":true,"sortable":true}},"documentId":{"edit":{},"list":{"label":"documentId","searchable":true,"sortable":true}}},"layouts":{"list":["id","title","imageUrl","linkUrl"],"edit":[[{"name":"title","size":6},{"name":"imageUrl","size":6}],[{"name":"linkUrl","size":6},{"name":"position","size":6}],[{"name":"startDate","size":6},{"name":"endDate","size":6}],[{"name":"isActive","size":4},{"name":"sortOrder","size":4}]]},"uid":"api::banner.banner"}	object	\N	\N
52	plugin_content_manager_configuration_content_types::api::product-variant.product-variant	{"settings":{"bulkable":true,"filterable":true,"searchable":true,"pageSize":10,"relationOpenMode":"modal","mainField":"name","defaultSortBy":"name","defaultSortOrder":"ASC"},"metadatas":{"id":{"edit":{},"list":{"label":"id","searchable":true,"sortable":true}},"name":{"edit":{"label":"name","description":"","placeholder":"","visible":true,"editable":true},"list":{"label":"name","searchable":true,"sortable":true}},"options":{"edit":{"label":"options","description":"","placeholder":"","visible":true,"editable":true},"list":{"label":"options","searchable":false,"sortable":false}},"product":{"edit":{"label":"product","description":"","placeholder":"","visible":true,"editable":true,"mainField":"name"},"list":{"label":"product","searchable":true,"sortable":true}},"createdAt":{"edit":{"label":"createdAt","description":"","placeholder":"","visible":false,"editable":true},"list":{"label":"createdAt","searchable":true,"sortable":true}},"updatedAt":{"edit":{"label":"updatedAt","description":"","placeholder":"","visible":false,"editable":true},"list":{"label":"updatedAt","searchable":true,"sortable":true}},"createdBy":{"edit":{"label":"createdBy","description":"","placeholder":"","visible":false,"editable":true,"mainField":"firstname"},"list":{"label":"createdBy","searchable":true,"sortable":true}},"updatedBy":{"edit":{"label":"updatedBy","description":"","placeholder":"","visible":false,"editable":true,"mainField":"firstname"},"list":{"label":"updatedBy","searchable":true,"sortable":true}},"documentId":{"edit":{},"list":{"label":"documentId","searchable":true,"sortable":true}}},"layouts":{"list":["id","name","product","createdAt"],"edit":[[{"name":"name","size":6}],[{"name":"options","size":12}],[{"name":"product","size":6}]]},"uid":"api::product-variant.product-variant"}	object	\N	\N
54	plugin_content_manager_configuration_content_types::api::review.review	{"settings":{"bulkable":true,"filterable":true,"searchable":true,"pageSize":10,"relationOpenMode":"modal","mainField":"documentId","defaultSortBy":"documentId","defaultSortOrder":"ASC"},"metadatas":{"id":{"edit":{},"list":{"label":"id","searchable":true,"sortable":true}},"rating":{"edit":{"label":"rating","description":"","placeholder":"","visible":true,"editable":true},"list":{"label":"rating","searchable":true,"sortable":true}},"comment":{"edit":{"label":"comment","description":"","placeholder":"","visible":true,"editable":true},"list":{"label":"comment","searchable":true,"sortable":true}},"user":{"edit":{"label":"user","description":"","placeholder":"","visible":true,"editable":true,"mainField":"phone"},"list":{"label":"user","searchable":true,"sortable":true}},"product":{"edit":{"label":"product","description":"","placeholder":"","visible":true,"editable":true,"mainField":"name"},"list":{"label":"product","searchable":true,"sortable":true}},"createdAt":{"edit":{"label":"createdAt","description":"","placeholder":"","visible":false,"editable":true},"list":{"label":"createdAt","searchable":true,"sortable":true}},"updatedAt":{"edit":{"label":"updatedAt","description":"","placeholder":"","visible":false,"editable":true},"list":{"label":"updatedAt","searchable":true,"sortable":true}},"createdBy":{"edit":{"label":"createdBy","description":"","placeholder":"","visible":false,"editable":true,"mainField":"firstname"},"list":{"label":"createdBy","searchable":true,"sortable":true}},"updatedBy":{"edit":{"label":"updatedBy","description":"","placeholder":"","visible":false,"editable":true,"mainField":"firstname"},"list":{"label":"updatedBy","searchable":true,"sortable":true}},"documentId":{"edit":{},"list":{"label":"documentId","searchable":true,"sortable":true}}},"layouts":{"list":["id","rating","comment","user"],"edit":[[{"name":"rating","size":4},{"name":"comment","size":6}],[{"name":"user","size":6},{"name":"product","size":6}]]},"uid":"api::review.review"}	object	\N	\N
55	plugin_content_manager_configuration_content_types::api::scheduled-reminder.scheduled-reminder	{"settings":{"bulkable":true,"filterable":true,"searchable":true,"pageSize":10,"relationOpenMode":"modal","mainField":"documentId","defaultSortBy":"documentId","defaultSortOrder":"ASC"},"metadatas":{"id":{"edit":{},"list":{"label":"id","searchable":true,"sortable":true}},"reminderType":{"edit":{"label":"reminderType","description":"","placeholder":"","visible":true,"editable":true},"list":{"label":"reminderType","searchable":true,"sortable":true}},"scheduledFor":{"edit":{"label":"scheduledFor","description":"","placeholder":"","visible":true,"editable":true},"list":{"label":"scheduledFor","searchable":true,"sortable":true}},"sent":{"edit":{"label":"sent","description":"","placeholder":"","visible":true,"editable":true},"list":{"label":"sent","searchable":true,"sortable":true}},"sentAt":{"edit":{"label":"sentAt","description":"","placeholder":"","visible":true,"editable":true},"list":{"label":"sentAt","searchable":true,"sortable":true}},"booking":{"edit":{"label":"booking","description":"","placeholder":"","visible":true,"editable":true,"mainField":"guestName"},"list":{"label":"booking","searchable":true,"sortable":true}},"createdAt":{"edit":{"label":"createdAt","description":"","placeholder":"","visible":false,"editable":true},"list":{"label":"createdAt","searchable":true,"sortable":true}},"updatedAt":{"edit":{"label":"updatedAt","description":"","placeholder":"","visible":false,"editable":true},"list":{"label":"updatedAt","searchable":true,"sortable":true}},"createdBy":{"edit":{"label":"createdBy","description":"","placeholder":"","visible":false,"editable":true,"mainField":"firstname"},"list":{"label":"createdBy","searchable":true,"sortable":true}},"updatedBy":{"edit":{"label":"updatedBy","description":"","placeholder":"","visible":false,"editable":true,"mainField":"firstname"},"list":{"label":"updatedBy","searchable":true,"sortable":true}},"documentId":{"edit":{},"list":{"label":"documentId","searchable":true,"sortable":true}}},"layouts":{"list":["id","reminderType","scheduledFor","sent"],"edit":[[{"name":"reminderType","size":6},{"name":"scheduledFor","size":6}],[{"name":"sent","size":4},{"name":"sentAt","size":6}],[{"name":"booking","size":6}]]},"uid":"api::scheduled-reminder.scheduled-reminder"}	object	\N	\N
56	plugin_content_manager_configuration_content_types::api::service.service	{"settings":{"bulkable":true,"filterable":true,"searchable":true,"pageSize":10,"relationOpenMode":"modal","mainField":"name","defaultSortBy":"name","defaultSortOrder":"ASC"},"metadatas":{"id":{"edit":{},"list":{"label":"id","searchable":true,"sortable":true}},"name":{"edit":{"label":"name","description":"","placeholder":"","visible":true,"editable":true},"list":{"label":"name","searchable":true,"sortable":true}},"type":{"edit":{"label":"type","description":"","placeholder":"","visible":true,"editable":true},"list":{"label":"type","searchable":true,"sortable":true}},"price":{"edit":{"label":"price","description":"","placeholder":"","visible":true,"editable":true},"list":{"label":"price","searchable":true,"sortable":true}},"durationMinutes":{"edit":{"label":"durationMinutes","description":"","placeholder":"","visible":true,"editable":true},"list":{"label":"durationMinutes","searchable":true,"sortable":true}},"staffId":{"edit":{"label":"staffId","description":"","placeholder":"","visible":true,"editable":true},"list":{"label":"staffId","searchable":true,"sortable":true}},"bufferMinutes":{"edit":{"label":"bufferMinutes","description":"","placeholder":"","visible":true,"editable":true},"list":{"label":"bufferMinutes","searchable":true,"sortable":true}},"isActive":{"edit":{"label":"isActive","description":"","placeholder":"","visible":true,"editable":true},"list":{"label":"isActive","searchable":true,"sortable":true}},"description":{"edit":{"label":"description","description":"","placeholder":"","visible":true,"editable":true},"list":{"label":"description","searchable":true,"sortable":true}},"bookings":{"edit":{"label":"bookings","description":"","placeholder":"","visible":true,"editable":true,"mainField":"guestName"},"list":{"label":"bookings","searchable":false,"sortable":false}},"createdAt":{"edit":{"label":"createdAt","description":"","placeholder":"","visible":false,"editable":true},"list":{"label":"createdAt","searchable":true,"sortable":true}},"updatedAt":{"edit":{"label":"updatedAt","description":"","placeholder":"","visible":false,"editable":true},"list":{"label":"updatedAt","searchable":true,"sortable":true}},"createdBy":{"edit":{"label":"createdBy","description":"","placeholder":"","visible":false,"editable":true,"mainField":"firstname"},"list":{"label":"createdBy","searchable":true,"sortable":true}},"updatedBy":{"edit":{"label":"updatedBy","description":"","placeholder":"","visible":false,"editable":true,"mainField":"firstname"},"list":{"label":"updatedBy","searchable":true,"sortable":true}},"documentId":{"edit":{},"list":{"label":"documentId","searchable":true,"sortable":true}}},"layouts":{"list":["id","name","type","price"],"edit":[[{"name":"name","size":6},{"name":"type","size":6}],[{"name":"price","size":4},{"name":"durationMinutes","size":4}],[{"name":"staffId","size":6},{"name":"bufferMinutes","size":4}],[{"name":"isActive","size":4},{"name":"description","size":6}],[{"name":"bookings","size":6}]]},"uid":"api::service.service"}	object	\N	\N
37	plugin_content_manager_configuration_content_types::api::legal-page.legal-page	{"settings":{"bulkable":true,"filterable":true,"searchable":true,"pageSize":10,"relationOpenMode":"modal","mainField":"slug","defaultSortBy":"slug","defaultSortOrder":"ASC"},"metadatas":{"id":{"edit":{},"list":{"label":"id","searchable":true,"sortable":true}},"slug":{"edit":{"label":"slug","description":"","placeholder":"","visible":true,"editable":true},"list":{"label":"slug","searchable":true,"sortable":true}},"title":{"edit":{"label":"title","description":"","placeholder":"","visible":true,"editable":true},"list":{"label":"title","searchable":true,"sortable":true}},"content":{"edit":{"label":"content","description":"","placeholder":"","visible":true,"editable":true},"list":{"label":"content","searchable":true,"sortable":true}},"createdAt":{"edit":{"label":"createdAt","description":"","placeholder":"","visible":false,"editable":true},"list":{"label":"createdAt","searchable":true,"sortable":true}},"updatedAt":{"edit":{"label":"updatedAt","description":"","placeholder":"","visible":false,"editable":true},"list":{"label":"updatedAt","searchable":true,"sortable":true}},"createdBy":{"edit":{"label":"createdBy","description":"","placeholder":"","visible":false,"editable":true,"mainField":"firstname"},"list":{"label":"createdBy","searchable":true,"sortable":true}},"updatedBy":{"edit":{"label":"updatedBy","description":"","placeholder":"","visible":false,"editable":true,"mainField":"firstname"},"list":{"label":"updatedBy","searchable":true,"sortable":true}},"documentId":{"edit":{},"list":{"label":"documentId","searchable":true,"sortable":true}}},"layouts":{"list":["id","slug","title","content"],"edit":[[{"name":"slug","size":6},{"name":"title","size":6}],[{"name":"content","size":6}]]},"uid":"api::legal-page.legal-page"}	object	\N	\N
51	plugin_content_manager_configuration_content_types::api::product-category.product-category	{"settings":{"bulkable":true,"filterable":true,"searchable":true,"pageSize":10,"relationOpenMode":"modal","mainField":"name","defaultSortBy":"name","defaultSortOrder":"ASC"},"metadatas":{"id":{"edit":{},"list":{"label":"id","searchable":true,"sortable":true}},"name":{"edit":{"label":"name","description":"","placeholder":"","visible":true,"editable":true},"list":{"label":"name","searchable":true,"sortable":true}},"slug":{"edit":{"label":"slug","description":"","placeholder":"","visible":true,"editable":true},"list":{"label":"slug","searchable":true,"sortable":true}},"sortOrder":{"edit":{"label":"sortOrder","description":"","placeholder":"","visible":true,"editable":true},"list":{"label":"sortOrder","searchable":true,"sortable":true}},"products":{"edit":{"label":"products","description":"","placeholder":"","visible":true,"editable":true,"mainField":"name"},"list":{"label":"products","searchable":false,"sortable":false}},"createdAt":{"edit":{"label":"createdAt","description":"","placeholder":"","visible":false,"editable":true},"list":{"label":"createdAt","searchable":true,"sortable":true}},"updatedAt":{"edit":{"label":"updatedAt","description":"","placeholder":"","visible":false,"editable":true},"list":{"label":"updatedAt","searchable":true,"sortable":true}},"createdBy":{"edit":{"label":"createdBy","description":"","placeholder":"","visible":false,"editable":true,"mainField":"firstname"},"list":{"label":"createdBy","searchable":true,"sortable":true}},"updatedBy":{"edit":{"label":"updatedBy","description":"","placeholder":"","visible":false,"editable":true,"mainField":"firstname"},"list":{"label":"updatedBy","searchable":true,"sortable":true}},"documentId":{"edit":{},"list":{"label":"documentId","searchable":true,"sortable":true}}},"layouts":{"list":["id","name","slug","sortOrder"],"edit":[[{"name":"name","size":6},{"name":"slug","size":6}],[{"name":"sortOrder","size":4},{"name":"products","size":6}]]},"uid":"api::product-category.product-category"}	object	\N	\N
39	plugin_content_manager_configuration_content_types::api::blocked-slot.blocked-slot	{"settings":{"bulkable":true,"filterable":true,"searchable":true,"pageSize":10,"relationOpenMode":"modal","mainField":"startTime","defaultSortBy":"startTime","defaultSortOrder":"ASC"},"metadatas":{"id":{"edit":{},"list":{"label":"id","searchable":true,"sortable":true}},"date":{"edit":{"label":"date","description":"","placeholder":"","visible":true,"editable":true},"list":{"label":"date","searchable":true,"sortable":true}},"startTime":{"edit":{"label":"startTime","description":"","placeholder":"","visible":true,"editable":true},"list":{"label":"startTime","searchable":true,"sortable":true}},"endTime":{"edit":{"label":"endTime","description":"","placeholder":"","visible":true,"editable":true},"list":{"label":"endTime","searchable":true,"sortable":true}},"reason":{"edit":{"label":"reason","description":"","placeholder":"","visible":true,"editable":true},"list":{"label":"reason","searchable":true,"sortable":true}},"createdAt":{"edit":{"label":"createdAt","description":"","placeholder":"","visible":false,"editable":true},"list":{"label":"createdAt","searchable":true,"sortable":true}},"updatedAt":{"edit":{"label":"updatedAt","description":"","placeholder":"","visible":false,"editable":true},"list":{"label":"updatedAt","searchable":true,"sortable":true}},"createdBy":{"edit":{"label":"createdBy","description":"","placeholder":"","visible":false,"editable":true,"mainField":"firstname"},"list":{"label":"createdBy","searchable":true,"sortable":true}},"updatedBy":{"edit":{"label":"updatedBy","description":"","placeholder":"","visible":false,"editable":true,"mainField":"firstname"},"list":{"label":"updatedBy","searchable":true,"sortable":true}},"documentId":{"edit":{},"list":{"label":"documentId","searchable":true,"sortable":true}}},"layouts":{"list":["id","date","startTime","endTime"],"edit":[[{"name":"date","size":4},{"name":"startTime","size":6}],[{"name":"endTime","size":6},{"name":"reason","size":6}]]},"uid":"api::blocked-slot.blocked-slot"}	object	\N	\N
41	plugin_content_manager_configuration_content_types::api::order-item.order-item	{"settings":{"bulkable":true,"filterable":true,"searchable":true,"pageSize":10,"relationOpenMode":"modal","mainField":"hsnCode","defaultSortBy":"hsnCode","defaultSortOrder":"ASC"},"metadatas":{"id":{"edit":{},"list":{"label":"id","searchable":true,"sortable":true}},"variantSelection":{"edit":{"label":"variantSelection","description":"","placeholder":"","visible":true,"editable":true},"list":{"label":"variantSelection","searchable":false,"sortable":false}},"quantity":{"edit":{"label":"quantity","description":"","placeholder":"","visible":true,"editable":true},"list":{"label":"quantity","searchable":true,"sortable":true}},"unitPrice":{"edit":{"label":"unitPrice","description":"","placeholder":"","visible":true,"editable":true},"list":{"label":"unitPrice","searchable":true,"sortable":true}},"gstRateBps":{"edit":{"label":"gstRateBps","description":"","placeholder":"","visible":true,"editable":true},"list":{"label":"gstRateBps","searchable":true,"sortable":true}},"hsnCode":{"edit":{"label":"hsnCode","description":"","placeholder":"","visible":true,"editable":true},"list":{"label":"hsnCode","searchable":true,"sortable":true}},"order":{"edit":{"label":"order","description":"","placeholder":"","visible":true,"editable":true,"mainField":"guestName"},"list":{"label":"order","searchable":true,"sortable":true}},"product":{"edit":{"label":"product","description":"","placeholder":"","visible":true,"editable":true,"mainField":"name"},"list":{"label":"product","searchable":true,"sortable":true}},"createdAt":{"edit":{"label":"createdAt","description":"","placeholder":"","visible":false,"editable":true},"list":{"label":"createdAt","searchable":true,"sortable":true}},"updatedAt":{"edit":{"label":"updatedAt","description":"","placeholder":"","visible":false,"editable":true},"list":{"label":"updatedAt","searchable":true,"sortable":true}},"createdBy":{"edit":{"label":"createdBy","description":"","placeholder":"","visible":false,"editable":true,"mainField":"firstname"},"list":{"label":"createdBy","searchable":true,"sortable":true}},"updatedBy":{"edit":{"label":"updatedBy","description":"","placeholder":"","visible":false,"editable":true,"mainField":"firstname"},"list":{"label":"updatedBy","searchable":true,"sortable":true}},"documentId":{"edit":{},"list":{"label":"documentId","searchable":true,"sortable":true}}},"layouts":{"list":["id","quantity","unitPrice","gstRateBps"],"edit":[[{"name":"variantSelection","size":12}],[{"name":"quantity","size":4},{"name":"unitPrice","size":4},{"name":"gstRateBps","size":4}],[{"name":"hsnCode","size":6},{"name":"order","size":6}],[{"name":"product","size":6}]]},"uid":"api::order-item.order-item"}	object	\N	\N
43	plugin_content_manager_configuration_content_types::api::password-reset-token.password-reset-token	{"settings":{"bulkable":true,"filterable":true,"searchable":true,"pageSize":10,"relationOpenMode":"modal","mainField":"token","defaultSortBy":"token","defaultSortOrder":"ASC"},"metadatas":{"id":{"edit":{},"list":{"label":"id","searchable":true,"sortable":true}},"token":{"edit":{"label":"token","description":"","placeholder":"","visible":true,"editable":true},"list":{"label":"token","searchable":true,"sortable":true}},"expiresAt":{"edit":{"label":"expiresAt","description":"","placeholder":"","visible":true,"editable":true},"list":{"label":"expiresAt","searchable":true,"sortable":true}},"user":{"edit":{"label":"user","description":"","placeholder":"","visible":true,"editable":true,"mainField":"phone"},"list":{"label":"user","searchable":true,"sortable":true}},"createdAt":{"edit":{"label":"createdAt","description":"","placeholder":"","visible":false,"editable":true},"list":{"label":"createdAt","searchable":true,"sortable":true}},"updatedAt":{"edit":{"label":"updatedAt","description":"","placeholder":"","visible":false,"editable":true},"list":{"label":"updatedAt","searchable":true,"sortable":true}},"createdBy":{"edit":{"label":"createdBy","description":"","placeholder":"","visible":false,"editable":true,"mainField":"firstname"},"list":{"label":"createdBy","searchable":true,"sortable":true}},"updatedBy":{"edit":{"label":"updatedBy","description":"","placeholder":"","visible":false,"editable":true,"mainField":"firstname"},"list":{"label":"updatedBy","searchable":true,"sortable":true}},"documentId":{"edit":{},"list":{"label":"documentId","searchable":true,"sortable":true}}},"layouts":{"list":["id","token","expiresAt","user"],"edit":[[{"name":"token","size":6},{"name":"expiresAt","size":6}],[{"name":"user","size":6}]]},"uid":"api::password-reset-token.password-reset-token"}	object	\N	\N
45	plugin_content_manager_configuration_content_types::api::booking-setting.booking-setting	{"settings":{"bulkable":true,"filterable":true,"searchable":true,"pageSize":10,"relationOpenMode":"modal","mainField":"gcalCalendarId","defaultSortBy":"gcalCalendarId","defaultSortOrder":"ASC"},"metadatas":{"id":{"edit":{},"list":{"label":"id","searchable":true,"sortable":true}},"slotDurationMinutes":{"edit":{"label":"slotDurationMinutes","description":"","placeholder":"","visible":true,"editable":true},"list":{"label":"slotDurationMinutes","searchable":true,"sortable":true}},"bufferBetweenSlots":{"edit":{"label":"bufferBetweenSlots","description":"","placeholder":"","visible":true,"editable":true},"list":{"label":"bufferBetweenSlots","searchable":true,"sortable":true}},"maxAdvanceBookingDays":{"edit":{"label":"maxAdvanceBookingDays","description":"","placeholder":"","visible":true,"editable":true},"list":{"label":"maxAdvanceBookingDays","searchable":true,"sortable":true}},"minAdvanceBookingHours":{"edit":{"label":"minAdvanceBookingHours","description":"","placeholder":"","visible":true,"editable":true},"list":{"label":"minAdvanceBookingHours","searchable":true,"sortable":true}},"cancellationPolicyHours":{"edit":{"label":"cancellationPolicyHours","description":"","placeholder":"","visible":true,"editable":true},"list":{"label":"cancellationPolicyHours","searchable":true,"sortable":true}},"gcalCalendarId":{"edit":{"label":"gcalCalendarId","description":"","placeholder":"","visible":true,"editable":true},"list":{"label":"gcalCalendarId","searchable":true,"sortable":true}},"gcalSyncEnabled":{"edit":{"label":"gcalSyncEnabled","description":"","placeholder":"","visible":true,"editable":true},"list":{"label":"gcalSyncEnabled","searchable":true,"sortable":true}},"gcalRefreshToken":{"edit":{"label":"gcalRefreshToken","description":"","placeholder":"","visible":true,"editable":true},"list":{"label":"gcalRefreshToken","searchable":true,"sortable":true}},"autoConfirm":{"edit":{"label":"autoConfirm","description":"","placeholder":"","visible":true,"editable":true},"list":{"label":"autoConfirm","searchable":true,"sortable":true}},"createdAt":{"edit":{"label":"createdAt","description":"","placeholder":"","visible":false,"editable":true},"list":{"label":"createdAt","searchable":true,"sortable":true}},"updatedAt":{"edit":{"label":"updatedAt","description":"","placeholder":"","visible":false,"editable":true},"list":{"label":"updatedAt","searchable":true,"sortable":true}},"createdBy":{"edit":{"label":"createdBy","description":"","placeholder":"","visible":false,"editable":true,"mainField":"firstname"},"list":{"label":"createdBy","searchable":true,"sortable":true}},"updatedBy":{"edit":{"label":"updatedBy","description":"","placeholder":"","visible":false,"editable":true,"mainField":"firstname"},"list":{"label":"updatedBy","searchable":true,"sortable":true}},"documentId":{"edit":{},"list":{"label":"documentId","searchable":true,"sortable":true}}},"layouts":{"list":["id","slotDurationMinutes","bufferBetweenSlots","maxAdvanceBookingDays"],"edit":[[{"name":"slotDurationMinutes","size":4},{"name":"bufferBetweenSlots","size":4},{"name":"maxAdvanceBookingDays","size":4}],[{"name":"minAdvanceBookingHours","size":4},{"name":"cancellationPolicyHours","size":4}],[{"name":"gcalCalendarId","size":6},{"name":"gcalSyncEnabled","size":4}],[{"name":"gcalRefreshToken","size":6},{"name":"autoConfirm","size":4}]]},"uid":"api::booking-setting.booking-setting"}	object	\N	\N
47	plugin_content_manager_configuration_content_types::api::cart-item.cart-item	{"settings":{"bulkable":true,"filterable":true,"searchable":true,"pageSize":10,"relationOpenMode":"modal","mainField":"sessionId","defaultSortBy":"sessionId","defaultSortOrder":"ASC"},"metadatas":{"id":{"edit":{},"list":{"label":"id","searchable":true,"sortable":true}},"sessionId":{"edit":{"label":"sessionId","description":"","placeholder":"","visible":true,"editable":true},"list":{"label":"sessionId","searchable":true,"sortable":true}},"quantity":{"edit":{"label":"quantity","description":"","placeholder":"","visible":true,"editable":true},"list":{"label":"quantity","searchable":true,"sortable":true}},"variantSelection":{"edit":{"label":"variantSelection","description":"","placeholder":"","visible":true,"editable":true},"list":{"label":"variantSelection","searchable":false,"sortable":false}},"user":{"edit":{"label":"user","description":"","placeholder":"","visible":true,"editable":true,"mainField":"phone"},"list":{"label":"user","searchable":true,"sortable":true}},"product":{"edit":{"label":"product","description":"","placeholder":"","visible":true,"editable":true,"mainField":"name"},"list":{"label":"product","searchable":true,"sortable":true}},"createdAt":{"edit":{"label":"createdAt","description":"","placeholder":"","visible":false,"editable":true},"list":{"label":"createdAt","searchable":true,"sortable":true}},"updatedAt":{"edit":{"label":"updatedAt","description":"","placeholder":"","visible":false,"editable":true},"list":{"label":"updatedAt","searchable":true,"sortable":true}},"createdBy":{"edit":{"label":"createdBy","description":"","placeholder":"","visible":false,"editable":true,"mainField":"firstname"},"list":{"label":"createdBy","searchable":true,"sortable":true}},"updatedBy":{"edit":{"label":"updatedBy","description":"","placeholder":"","visible":false,"editable":true,"mainField":"firstname"},"list":{"label":"updatedBy","searchable":true,"sortable":true}},"documentId":{"edit":{},"list":{"label":"documentId","searchable":true,"sortable":true}}},"layouts":{"list":["id","sessionId","quantity","user"],"edit":[[{"name":"sessionId","size":6},{"name":"quantity","size":4}],[{"name":"variantSelection","size":12}],[{"name":"user","size":6},{"name":"product","size":6}]]},"uid":"api::cart-item.cart-item"}	object	\N	\N
50	plugin_content_manager_configuration_content_types::api::product.product	{"settings":{"bulkable":true,"filterable":true,"searchable":true,"pageSize":10,"relationOpenMode":"modal","mainField":"name","defaultSortBy":"name","defaultSortOrder":"ASC"},"metadatas":{"id":{"edit":{},"list":{"label":"id","searchable":true,"sortable":true}},"name":{"edit":{"label":"name","description":"","placeholder":"","visible":true,"editable":true},"list":{"label":"name","searchable":true,"sortable":true}},"slug":{"edit":{"label":"slug","description":"","placeholder":"","visible":true,"editable":true},"list":{"label":"slug","searchable":true,"sortable":true}},"description":{"edit":{"label":"description","description":"","placeholder":"","visible":true,"editable":true},"list":{"label":"description","searchable":true,"sortable":true}},"productType":{"edit":{"label":"productType","description":"","placeholder":"","visible":true,"editable":true},"list":{"label":"productType","searchable":true,"sortable":true}},"price":{"edit":{"label":"price","description":"","placeholder":"","visible":true,"editable":true},"list":{"label":"price","searchable":true,"sortable":true}},"salePrice":{"edit":{"label":"salePrice","description":"","placeholder":"","visible":true,"editable":true},"list":{"label":"salePrice","searchable":true,"sortable":true}},"stock":{"edit":{"label":"stock","description":"","placeholder":"","visible":true,"editable":true},"list":{"label":"stock","searchable":true,"sortable":true}},"images":{"edit":{"label":"images","description":"","placeholder":"","visible":true,"editable":true},"list":{"label":"images","searchable":false,"sortable":false}},"healingProperties":{"edit":{"label":"healingProperties","description":"","placeholder":"","visible":true,"editable":true},"list":{"label":"healingProperties","searchable":true,"sortable":true}},"wearHand":{"edit":{"label":"wearHand","description":"","placeholder":"","visible":true,"editable":true},"list":{"label":"wearHand","searchable":true,"sortable":true}},"hsnCode":{"edit":{"label":"hsnCode","description":"","placeholder":"","visible":true,"editable":true},"list":{"label":"hsnCode","searchable":true,"sortable":true}},"gstRateBps":{"edit":{"label":"gstRateBps","description":"","placeholder":"","visible":true,"editable":true},"list":{"label":"gstRateBps","searchable":true,"sortable":true}},"isActive":{"edit":{"label":"isActive","description":"","placeholder":"","visible":true,"editable":true},"list":{"label":"isActive","searchable":true,"sortable":true}},"category":{"edit":{"label":"category","description":"","placeholder":"","visible":true,"editable":true,"mainField":"name"},"list":{"label":"category","searchable":true,"sortable":true}},"shippingClass":{"edit":{"label":"shippingClass","description":"","placeholder":"","visible":true,"editable":true,"mainField":"name"},"list":{"label":"shippingClass","searchable":true,"sortable":true}},"variants":{"edit":{"label":"variants","description":"","placeholder":"","visible":true,"editable":true,"mainField":"name"},"list":{"label":"variants","searchable":false,"sortable":false}},"digitalAssets":{"edit":{"label":"digitalAssets","description":"","placeholder":"","visible":true,"editable":true,"mainField":"url"},"list":{"label":"digitalAssets","searchable":false,"sortable":false}},"cartItems":{"edit":{"label":"cartItems","description":"","placeholder":"","visible":true,"editable":true,"mainField":"sessionId"},"list":{"label":"cartItems","searchable":false,"sortable":false}},"wishlistItems":{"edit":{"label":"wishlistItems","description":"","placeholder":"","visible":true,"editable":true,"mainField":"documentId"},"list":{"label":"wishlistItems","searchable":false,"sortable":false}},"orderItems":{"edit":{"label":"orderItems","description":"","placeholder":"","visible":true,"editable":true,"mainField":"hsnCode"},"list":{"label":"orderItems","searchable":false,"sortable":false}},"reviews":{"edit":{"label":"reviews","description":"","placeholder":"","visible":true,"editable":true,"mainField":"documentId"},"list":{"label":"reviews","searchable":false,"sortable":false}},"digitalPurchases":{"edit":{"label":"digitalPurchases","description":"","placeholder":"","visible":true,"editable":true,"mainField":"accessUrl"},"list":{"label":"digitalPurchases","searchable":false,"sortable":false}},"createdAt":{"edit":{"label":"createdAt","description":"","placeholder":"","visible":false,"editable":true},"list":{"label":"createdAt","searchable":true,"sortable":true}},"updatedAt":{"edit":{"label":"updatedAt","description":"","placeholder":"","visible":false,"editable":true},"list":{"label":"updatedAt","searchable":true,"sortable":true}},"createdBy":{"edit":{"label":"createdBy","description":"","placeholder":"","visible":false,"editable":true,"mainField":"firstname"},"list":{"label":"createdBy","searchable":true,"sortable":true}},"updatedBy":{"edit":{"label":"updatedBy","description":"","placeholder":"","visible":false,"editable":true,"mainField":"firstname"},"list":{"label":"updatedBy","searchable":true,"sortable":true}},"documentId":{"edit":{},"list":{"label":"documentId","searchable":true,"sortable":true}}},"layouts":{"list":["id","name","slug","description"],"edit":[[{"name":"name","size":6},{"name":"slug","size":6}],[{"name":"description","size":6},{"name":"productType","size":6}],[{"name":"price","size":4},{"name":"salePrice","size":4},{"name":"stock","size":4}],[{"name":"images","size":12}],[{"name":"healingProperties","size":6},{"name":"wearHand","size":6}],[{"name":"hsnCode","size":6},{"name":"gstRateBps","size":4}],[{"name":"isActive","size":4},{"name":"category","size":6}],[{"name":"shippingClass","size":6},{"name":"variants","size":6}],[{"name":"digitalAssets","size":6},{"name":"cartItems","size":6}],[{"name":"wishlistItems","size":6},{"name":"orderItems","size":6}],[{"name":"reviews","size":6},{"name":"digitalPurchases","size":6}]]},"uid":"api::product.product"}	object	\N	\N
53	plugin_content_manager_configuration_content_types::api::promo-rule.promo-rule	{"settings":{"bulkable":true,"filterable":true,"searchable":true,"pageSize":10,"relationOpenMode":"modal","mainField":"documentId","defaultSortBy":"documentId","defaultSortOrder":"ASC"},"metadatas":{"id":{"edit":{},"list":{"label":"id","searchable":true,"sortable":true}},"type":{"edit":{"label":"type","description":"","placeholder":"","visible":true,"editable":true},"list":{"label":"type","searchable":true,"sortable":true}},"config":{"edit":{"label":"config","description":"","placeholder":"","visible":true,"editable":true},"list":{"label":"config","searchable":false,"sortable":false}},"isActive":{"edit":{"label":"isActive","description":"","placeholder":"","visible":true,"editable":true},"list":{"label":"isActive","searchable":true,"sortable":true}},"createdAt":{"edit":{"label":"createdAt","description":"","placeholder":"","visible":false,"editable":true},"list":{"label":"createdAt","searchable":true,"sortable":true}},"updatedAt":{"edit":{"label":"updatedAt","description":"","placeholder":"","visible":false,"editable":true},"list":{"label":"updatedAt","searchable":true,"sortable":true}},"createdBy":{"edit":{"label":"createdBy","description":"","placeholder":"","visible":false,"editable":true,"mainField":"firstname"},"list":{"label":"createdBy","searchable":true,"sortable":true}},"updatedBy":{"edit":{"label":"updatedBy","description":"","placeholder":"","visible":false,"editable":true,"mainField":"firstname"},"list":{"label":"updatedBy","searchable":true,"sortable":true}},"documentId":{"edit":{},"list":{"label":"documentId","searchable":true,"sortable":true}}},"layouts":{"list":["id","type","isActive","createdAt"],"edit":[[{"name":"type","size":6}],[{"name":"config","size":12}],[{"name":"isActive","size":4}]]},"uid":"api::promo-rule.promo-rule"}	object	\N	\N
57	plugin_content_manager_configuration_content_types::api::testimonial.testimonial	{"settings":{"bulkable":true,"filterable":true,"searchable":true,"pageSize":10,"relationOpenMode":"modal","mainField":"name","defaultSortBy":"name","defaultSortOrder":"ASC"},"metadatas":{"id":{"edit":{},"list":{"label":"id","searchable":true,"sortable":true}},"name":{"edit":{"label":"name","description":"","placeholder":"","visible":true,"editable":true},"list":{"label":"name","searchable":true,"sortable":true}},"text":{"edit":{"label":"text","description":"","placeholder":"","visible":true,"editable":true},"list":{"label":"text","searchable":true,"sortable":true}},"sortOrder":{"edit":{"label":"sortOrder","description":"","placeholder":"","visible":true,"editable":true},"list":{"label":"sortOrder","searchable":true,"sortable":true}},"isActive":{"edit":{"label":"isActive","description":"","placeholder":"","visible":true,"editable":true},"list":{"label":"isActive","searchable":true,"sortable":true}},"createdAt":{"edit":{"label":"createdAt","description":"","placeholder":"","visible":false,"editable":true},"list":{"label":"createdAt","searchable":true,"sortable":true}},"updatedAt":{"edit":{"label":"updatedAt","description":"","placeholder":"","visible":false,"editable":true},"list":{"label":"updatedAt","searchable":true,"sortable":true}},"createdBy":{"edit":{"label":"createdBy","description":"","placeholder":"","visible":false,"editable":true,"mainField":"firstname"},"list":{"label":"createdBy","searchable":true,"sortable":true}},"updatedBy":{"edit":{"label":"updatedBy","description":"","placeholder":"","visible":false,"editable":true,"mainField":"firstname"},"list":{"label":"updatedBy","searchable":true,"sortable":true}},"documentId":{"edit":{},"list":{"label":"documentId","searchable":true,"sortable":true}}},"layouts":{"list":["id","name","text","sortOrder"],"edit":[[{"name":"name","size":6},{"name":"text","size":6}],[{"name":"sortOrder","size":4},{"name":"isActive","size":4}]]},"uid":"api::testimonial.testimonial"}	object	\N	\N
59	plugin_content_manager_configuration_content_types::api::wishlist-item.wishlist-item	{"settings":{"bulkable":true,"filterable":true,"searchable":true,"pageSize":10,"relationOpenMode":"modal","mainField":"documentId","defaultSortBy":"documentId","defaultSortOrder":"ASC"},"metadatas":{"id":{"edit":{},"list":{"label":"id","searchable":true,"sortable":true}},"user":{"edit":{"label":"user","description":"","placeholder":"","visible":true,"editable":true,"mainField":"phone"},"list":{"label":"user","searchable":true,"sortable":true}},"product":{"edit":{"label":"product","description":"","placeholder":"","visible":true,"editable":true,"mainField":"name"},"list":{"label":"product","searchable":true,"sortable":true}},"createdAt":{"edit":{"label":"createdAt","description":"","placeholder":"","visible":false,"editable":true},"list":{"label":"createdAt","searchable":true,"sortable":true}},"updatedAt":{"edit":{"label":"updatedAt","description":"","placeholder":"","visible":false,"editable":true},"list":{"label":"updatedAt","searchable":true,"sortable":true}},"createdBy":{"edit":{"label":"createdBy","description":"","placeholder":"","visible":false,"editable":true,"mainField":"firstname"},"list":{"label":"createdBy","searchable":true,"sortable":true}},"updatedBy":{"edit":{"label":"updatedBy","description":"","placeholder":"","visible":false,"editable":true,"mainField":"firstname"},"list":{"label":"updatedBy","searchable":true,"sortable":true}},"documentId":{"edit":{},"list":{"label":"documentId","searchable":true,"sortable":true}}},"layouts":{"list":["id","user","product","createdAt"],"edit":[[{"name":"user","size":6},{"name":"product","size":6}]]},"uid":"api::wishlist-item.wishlist-item"}	object	\N	\N
12	plugin_content_manager_configuration_content_types::plugin::users-permissions.user	{"settings":{"bulkable":true,"filterable":true,"searchable":true,"pageSize":10,"relationOpenMode":"modal","mainField":"phone","defaultSortBy":"phone","defaultSortOrder":"ASC"},"metadatas":{"id":{"edit":{},"list":{"label":"id","searchable":true,"sortable":true}},"phone":{"edit":{"label":"phone","description":"","placeholder":"","visible":true,"editable":true},"list":{"label":"phone","searchable":true,"sortable":true}},"appRole":{"edit":{"label":"appRole","description":"","placeholder":"","visible":true,"editable":true},"list":{"label":"appRole","searchable":true,"sortable":true}},"orders":{"edit":{"label":"orders","description":"","placeholder":"","visible":true,"editable":true,"mainField":"guestName"},"list":{"label":"orders","searchable":false,"sortable":false}},"bookings":{"edit":{"label":"bookings","description":"","placeholder":"","visible":true,"editable":true,"mainField":"guestName"},"list":{"label":"bookings","searchable":false,"sortable":false}},"cartItems":{"edit":{"label":"cartItems","description":"","placeholder":"","visible":true,"editable":true,"mainField":"sessionId"},"list":{"label":"cartItems","searchable":false,"sortable":false}},"wishlistItems":{"edit":{"label":"wishlistItems","description":"","placeholder":"","visible":true,"editable":true,"mainField":"documentId"},"list":{"label":"wishlistItems","searchable":false,"sortable":false}},"reviews":{"edit":{"label":"reviews","description":"","placeholder":"","visible":true,"editable":true,"mainField":"documentId"},"list":{"label":"reviews","searchable":false,"sortable":false}},"couponUsages":{"edit":{"label":"couponUsages","description":"","placeholder":"","visible":true,"editable":true,"mainField":"documentId"},"list":{"label":"couponUsages","searchable":false,"sortable":false}},"digitalPurchases":{"edit":{"label":"digitalPurchases","description":"","placeholder":"","visible":true,"editable":true,"mainField":"accessUrl"},"list":{"label":"digitalPurchases","searchable":false,"sortable":false}},"passwordResetTokens":{"edit":{"label":"passwordResetTokens","description":"","placeholder":"","visible":true,"editable":true,"mainField":"token"},"list":{"label":"passwordResetTokens","searchable":false,"sortable":false}},"createdAt":{"edit":{"label":"createdAt","description":"","placeholder":"","visible":false,"editable":true},"list":{"label":"createdAt","searchable":true,"sortable":true}},"updatedAt":{"edit":{"label":"updatedAt","description":"","placeholder":"","visible":false,"editable":true},"list":{"label":"updatedAt","searchable":true,"sortable":true}},"createdBy":{"edit":{"label":"createdBy","description":"","placeholder":"","visible":false,"editable":true,"mainField":"firstname"},"list":{"label":"createdBy","searchable":true,"sortable":true}},"updatedBy":{"edit":{"label":"updatedBy","description":"","placeholder":"","visible":false,"editable":true,"mainField":"firstname"},"list":{"label":"updatedBy","searchable":true,"sortable":true}},"documentId":{"edit":{},"list":{"label":"documentId","searchable":true,"sortable":true}}},"layouts":{"list":["id","phone","appRole","orders"],"edit":[[{"name":"phone","size":6},{"name":"appRole","size":6}],[{"name":"orders","size":6},{"name":"bookings","size":6}],[{"name":"cartItems","size":6},{"name":"wishlistItems","size":6}],[{"name":"reviews","size":6},{"name":"couponUsages","size":6}],[{"name":"digitalPurchases","size":6},{"name":"passwordResetTokens","size":6}]]},"uid":"plugin::users-permissions.user"}	object	\N	\N
\.


--
-- Data for Name: strapi_database_schema; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.strapi_database_schema (id, schema, "time", hash) FROM stdin;
3	{"tables":[{"name":"files","indexes":[{"name":"upload_files_folder_path_index","columns":["folder_path"],"type":null},{"name":"upload_files_created_at_index","columns":["created_at"],"type":null},{"name":"upload_files_updated_at_index","columns":["updated_at"],"type":null},{"name":"upload_files_name_index","columns":["name"],"type":null},{"name":"upload_files_size_index","columns":["size"],"type":null},{"name":"upload_files_ext_index","columns":["ext"],"type":null},{"name":"files_documents_idx","columns":["document_id","locale","published_at"]},{"name":"files_created_by_id_fk","columns":["created_by_id"]},{"name":"files_updated_by_id_fk","columns":["updated_by_id"]}],"foreignKeys":[{"name":"files_created_by_id_fk","columns":["created_by_id"],"referencedTable":"admin_users","referencedColumns":["id"],"onDelete":"SET NULL"},{"name":"files_updated_by_id_fk","columns":["updated_by_id"],"referencedTable":"admin_users","referencedColumns":["id"],"onDelete":"SET NULL"}],"columns":[{"name":"id","type":"increments","args":[{"primary":true,"primaryKey":true}],"defaultTo":null,"notNullable":true,"unsigned":false},{"name":"document_id","type":"string","args":[],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"name","type":"string","args":[],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"alternative_text","type":"text","args":["longtext"],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"caption","type":"text","args":["longtext"],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"focal_point","type":"jsonb","args":[],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"width","type":"integer","args":[],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"height","type":"integer","args":[],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"formats","type":"jsonb","args":[],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"hash","type":"string","args":[],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"ext","type":"string","args":[],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"mime","type":"string","args":[],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"size","type":"decimal","args":[10,2],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"url","type":"text","args":["longtext"],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"preview_url","type":"text","args":["longtext"],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"provider","type":"string","args":[],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"provider_metadata","type":"jsonb","args":[],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"folder_path","type":"string","args":[],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"created_at","type":"datetime","args":[{"useTz":false,"precision":6}],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"updated_at","type":"datetime","args":[{"useTz":false,"precision":6}],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"published_at","type":"datetime","args":[{"useTz":false,"precision":6}],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"created_by_id","type":"integer","args":[],"defaultTo":null,"notNullable":false,"unsigned":true},{"name":"updated_by_id","type":"integer","args":[],"defaultTo":null,"notNullable":false,"unsigned":true},{"name":"locale","type":"string","args":[],"defaultTo":null,"notNullable":false,"unsigned":false}]},{"name":"upload_folders","indexes":[{"name":"upload_folders_path_id_index","columns":["path_id"],"type":"unique"},{"name":"upload_folders_path_index","columns":["path"],"type":"unique"},{"name":"upload_folders_documents_idx","columns":["document_id","locale","published_at"]},{"name":"upload_folders_created_by_id_fk","columns":["created_by_id"]},{"name":"upload_folders_updated_by_id_fk","columns":["updated_by_id"]}],"foreignKeys":[{"name":"upload_folders_created_by_id_fk","columns":["created_by_id"],"referencedTable":"admin_users","referencedColumns":["id"],"onDelete":"SET NULL"},{"name":"upload_folders_updated_by_id_fk","columns":["updated_by_id"],"referencedTable":"admin_users","referencedColumns":["id"],"onDelete":"SET NULL"}],"columns":[{"name":"id","type":"increments","args":[{"primary":true,"primaryKey":true}],"defaultTo":null,"notNullable":true,"unsigned":false},{"name":"document_id","type":"string","args":[],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"name","type":"string","args":[],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"path_id","type":"integer","args":[],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"path","type":"string","args":[],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"created_at","type":"datetime","args":[{"useTz":false,"precision":6}],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"updated_at","type":"datetime","args":[{"useTz":false,"precision":6}],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"published_at","type":"datetime","args":[{"useTz":false,"precision":6}],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"created_by_id","type":"integer","args":[],"defaultTo":null,"notNullable":false,"unsigned":true},{"name":"updated_by_id","type":"integer","args":[],"defaultTo":null,"notNullable":false,"unsigned":true},{"name":"locale","type":"string","args":[],"defaultTo":null,"notNullable":false,"unsigned":false}]},{"name":"i18n_locale","indexes":[{"name":"i18n_locale_documents_idx","columns":["document_id","locale","published_at"]},{"name":"i18n_locale_created_by_id_fk","columns":["created_by_id"]},{"name":"i18n_locale_updated_by_id_fk","columns":["updated_by_id"]}],"foreignKeys":[{"name":"i18n_locale_created_by_id_fk","columns":["created_by_id"],"referencedTable":"admin_users","referencedColumns":["id"],"onDelete":"SET NULL"},{"name":"i18n_locale_updated_by_id_fk","columns":["updated_by_id"],"referencedTable":"admin_users","referencedColumns":["id"],"onDelete":"SET NULL"}],"columns":[{"name":"id","type":"increments","args":[{"primary":true,"primaryKey":true}],"defaultTo":null,"notNullable":true,"unsigned":false},{"name":"document_id","type":"string","args":[],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"name","type":"string","args":[],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"code","type":"string","args":[],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"created_at","type":"datetime","args":[{"useTz":false,"precision":6}],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"updated_at","type":"datetime","args":[{"useTz":false,"precision":6}],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"published_at","type":"datetime","args":[{"useTz":false,"precision":6}],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"created_by_id","type":"integer","args":[],"defaultTo":null,"notNullable":false,"unsigned":true},{"name":"updated_by_id","type":"integer","args":[],"defaultTo":null,"notNullable":false,"unsigned":true},{"name":"locale","type":"string","args":[],"defaultTo":null,"notNullable":false,"unsigned":false}]},{"name":"strapi_releases","indexes":[{"name":"strapi_releases_documents_idx","columns":["document_id","locale","published_at"]},{"name":"strapi_releases_created_by_id_fk","columns":["created_by_id"]},{"name":"strapi_releases_updated_by_id_fk","columns":["updated_by_id"]}],"foreignKeys":[{"name":"strapi_releases_created_by_id_fk","columns":["created_by_id"],"referencedTable":"admin_users","referencedColumns":["id"],"onDelete":"SET NULL"},{"name":"strapi_releases_updated_by_id_fk","columns":["updated_by_id"],"referencedTable":"admin_users","referencedColumns":["id"],"onDelete":"SET NULL"}],"columns":[{"name":"id","type":"increments","args":[{"primary":true,"primaryKey":true}],"defaultTo":null,"notNullable":true,"unsigned":false},{"name":"document_id","type":"string","args":[],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"name","type":"string","args":[],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"released_at","type":"datetime","args":[{"useTz":false,"precision":6}],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"scheduled_at","type":"datetime","args":[{"useTz":false,"precision":6}],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"timezone","type":"string","args":[],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"status","type":"string","args":[],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"created_at","type":"datetime","args":[{"useTz":false,"precision":6}],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"updated_at","type":"datetime","args":[{"useTz":false,"precision":6}],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"published_at","type":"datetime","args":[{"useTz":false,"precision":6}],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"created_by_id","type":"integer","args":[],"defaultTo":null,"notNullable":false,"unsigned":true},{"name":"updated_by_id","type":"integer","args":[],"defaultTo":null,"notNullable":false,"unsigned":true},{"name":"locale","type":"string","args":[],"defaultTo":null,"notNullable":false,"unsigned":false}]},{"name":"strapi_release_actions","indexes":[{"name":"strapi_release_actions_documents_idx","columns":["document_id","locale","published_at"]},{"name":"strapi_release_actions_created_by_id_fk","columns":["created_by_id"]},{"name":"strapi_release_actions_updated_by_id_fk","columns":["updated_by_id"]}],"foreignKeys":[{"name":"strapi_release_actions_created_by_id_fk","columns":["created_by_id"],"referencedTable":"admin_users","referencedColumns":["id"],"onDelete":"SET NULL"},{"name":"strapi_release_actions_updated_by_id_fk","columns":["updated_by_id"],"referencedTable":"admin_users","referencedColumns":["id"],"onDelete":"SET NULL"}],"columns":[{"name":"id","type":"increments","args":[{"primary":true,"primaryKey":true}],"defaultTo":null,"notNullable":true,"unsigned":false},{"name":"document_id","type":"string","args":[],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"type","type":"string","args":[],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"content_type","type":"string","args":[],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"entry_document_id","type":"string","args":[],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"locale","type":"string","args":[],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"is_entry_valid","type":"boolean","args":[],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"created_at","type":"datetime","args":[{"useTz":false,"precision":6}],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"updated_at","type":"datetime","args":[{"useTz":false,"precision":6}],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"published_at","type":"datetime","args":[{"useTz":false,"precision":6}],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"created_by_id","type":"integer","args":[],"defaultTo":null,"notNullable":false,"unsigned":true},{"name":"updated_by_id","type":"integer","args":[],"defaultTo":null,"notNullable":false,"unsigned":true}]},{"name":"strapi_workflows","indexes":[{"name":"strapi_workflows_documents_idx","columns":["document_id","locale","published_at"]},{"name":"strapi_workflows_created_by_id_fk","columns":["created_by_id"]},{"name":"strapi_workflows_updated_by_id_fk","columns":["updated_by_id"]}],"foreignKeys":[{"name":"strapi_workflows_created_by_id_fk","columns":["created_by_id"],"referencedTable":"admin_users","referencedColumns":["id"],"onDelete":"SET NULL"},{"name":"strapi_workflows_updated_by_id_fk","columns":["updated_by_id"],"referencedTable":"admin_users","referencedColumns":["id"],"onDelete":"SET NULL"}],"columns":[{"name":"id","type":"increments","args":[{"primary":true,"primaryKey":true}],"defaultTo":null,"notNullable":true,"unsigned":false},{"name":"document_id","type":"string","args":[],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"name","type":"string","args":[],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"content_types","type":"jsonb","args":[],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"created_at","type":"datetime","args":[{"useTz":false,"precision":6}],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"updated_at","type":"datetime","args":[{"useTz":false,"precision":6}],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"published_at","type":"datetime","args":[{"useTz":false,"precision":6}],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"created_by_id","type":"integer","args":[],"defaultTo":null,"notNullable":false,"unsigned":true},{"name":"updated_by_id","type":"integer","args":[],"defaultTo":null,"notNullable":false,"unsigned":true},{"name":"locale","type":"string","args":[],"defaultTo":null,"notNullable":false,"unsigned":false}]},{"name":"strapi_workflows_stages","indexes":[{"name":"strapi_workflows_stages_documents_idx","columns":["document_id","locale","published_at"]},{"name":"strapi_workflows_stages_created_by_id_fk","columns":["created_by_id"]},{"name":"strapi_workflows_stages_updated_by_id_fk","columns":["updated_by_id"]}],"foreignKeys":[{"name":"strapi_workflows_stages_created_by_id_fk","columns":["created_by_id"],"referencedTable":"admin_users","referencedColumns":["id"],"onDelete":"SET NULL"},{"name":"strapi_workflows_stages_updated_by_id_fk","columns":["updated_by_id"],"referencedTable":"admin_users","referencedColumns":["id"],"onDelete":"SET NULL"}],"columns":[{"name":"id","type":"increments","args":[{"primary":true,"primaryKey":true}],"defaultTo":null,"notNullable":true,"unsigned":false},{"name":"document_id","type":"string","args":[],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"name","type":"string","args":[],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"color","type":"string","args":[],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"created_at","type":"datetime","args":[{"useTz":false,"precision":6}],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"updated_at","type":"datetime","args":[{"useTz":false,"precision":6}],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"published_at","type":"datetime","args":[{"useTz":false,"precision":6}],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"created_by_id","type":"integer","args":[],"defaultTo":null,"notNullable":false,"unsigned":true},{"name":"updated_by_id","type":"integer","args":[],"defaultTo":null,"notNullable":false,"unsigned":true},{"name":"locale","type":"string","args":[],"defaultTo":null,"notNullable":false,"unsigned":false}]},{"name":"up_permissions","indexes":[{"name":"up_permissions_documents_idx","columns":["document_id","locale","published_at"]},{"name":"up_permissions_created_by_id_fk","columns":["created_by_id"]},{"name":"up_permissions_updated_by_id_fk","columns":["updated_by_id"]}],"foreignKeys":[{"name":"up_permissions_created_by_id_fk","columns":["created_by_id"],"referencedTable":"admin_users","referencedColumns":["id"],"onDelete":"SET NULL"},{"name":"up_permissions_updated_by_id_fk","columns":["updated_by_id"],"referencedTable":"admin_users","referencedColumns":["id"],"onDelete":"SET NULL"}],"columns":[{"name":"id","type":"increments","args":[{"primary":true,"primaryKey":true}],"defaultTo":null,"notNullable":true,"unsigned":false},{"name":"document_id","type":"string","args":[],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"action","type":"string","args":[],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"created_at","type":"datetime","args":[{"useTz":false,"precision":6}],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"updated_at","type":"datetime","args":[{"useTz":false,"precision":6}],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"published_at","type":"datetime","args":[{"useTz":false,"precision":6}],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"created_by_id","type":"integer","args":[],"defaultTo":null,"notNullable":false,"unsigned":true},{"name":"updated_by_id","type":"integer","args":[],"defaultTo":null,"notNullable":false,"unsigned":true},{"name":"locale","type":"string","args":[],"defaultTo":null,"notNullable":false,"unsigned":false}]},{"name":"up_roles","indexes":[{"name":"up_roles_documents_idx","columns":["document_id","locale","published_at"]},{"name":"up_roles_created_by_id_fk","columns":["created_by_id"]},{"name":"up_roles_updated_by_id_fk","columns":["updated_by_id"]}],"foreignKeys":[{"name":"up_roles_created_by_id_fk","columns":["created_by_id"],"referencedTable":"admin_users","referencedColumns":["id"],"onDelete":"SET NULL"},{"name":"up_roles_updated_by_id_fk","columns":["updated_by_id"],"referencedTable":"admin_users","referencedColumns":["id"],"onDelete":"SET NULL"}],"columns":[{"name":"id","type":"increments","args":[{"primary":true,"primaryKey":true}],"defaultTo":null,"notNullable":true,"unsigned":false},{"name":"document_id","type":"string","args":[],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"name","type":"string","args":[],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"description","type":"string","args":[],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"type","type":"string","args":[],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"created_at","type":"datetime","args":[{"useTz":false,"precision":6}],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"updated_at","type":"datetime","args":[{"useTz":false,"precision":6}],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"published_at","type":"datetime","args":[{"useTz":false,"precision":6}],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"created_by_id","type":"integer","args":[],"defaultTo":null,"notNullable":false,"unsigned":true},{"name":"updated_by_id","type":"integer","args":[],"defaultTo":null,"notNullable":false,"unsigned":true},{"name":"locale","type":"string","args":[],"defaultTo":null,"notNullable":false,"unsigned":false}]},{"name":"up_users","indexes":[{"name":"up_users_documents_idx","columns":["document_id","locale","published_at"]},{"name":"up_users_created_by_id_fk","columns":["created_by_id"]},{"name":"up_users_updated_by_id_fk","columns":["updated_by_id"]}],"foreignKeys":[{"name":"up_users_created_by_id_fk","columns":["created_by_id"],"referencedTable":"admin_users","referencedColumns":["id"],"onDelete":"SET NULL"},{"name":"up_users_updated_by_id_fk","columns":["updated_by_id"],"referencedTable":"admin_users","referencedColumns":["id"],"onDelete":"SET NULL"}],"columns":[{"name":"id","type":"increments","args":[{"primary":true,"primaryKey":true}],"defaultTo":null,"notNullable":true,"unsigned":false},{"name":"document_id","type":"string","args":[],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"phone","type":"string","args":[],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"app_role","type":"string","args":[],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"created_at","type":"datetime","args":[{"useTz":false,"precision":6}],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"updated_at","type":"datetime","args":[{"useTz":false,"precision":6}],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"published_at","type":"datetime","args":[{"useTz":false,"precision":6}],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"created_by_id","type":"integer","args":[],"defaultTo":null,"notNullable":false,"unsigned":true},{"name":"updated_by_id","type":"integer","args":[],"defaultTo":null,"notNullable":false,"unsigned":true},{"name":"locale","type":"string","args":[],"defaultTo":null,"notNullable":false,"unsigned":false}]},{"name":"availability_rules","indexes":[{"name":"availability_rules_documents_idx","columns":["document_id","locale","published_at"]},{"name":"availability_rules_created_by_id_fk","columns":["created_by_id"]},{"name":"availability_rules_updated_by_id_fk","columns":["updated_by_id"]}],"foreignKeys":[{"name":"availability_rules_created_by_id_fk","columns":["created_by_id"],"referencedTable":"admin_users","referencedColumns":["id"],"onDelete":"SET NULL"},{"name":"availability_rules_updated_by_id_fk","columns":["updated_by_id"],"referencedTable":"admin_users","referencedColumns":["id"],"onDelete":"SET NULL"}],"columns":[{"name":"id","type":"increments","args":[{"primary":true,"primaryKey":true}],"defaultTo":null,"notNullable":true,"unsigned":false},{"name":"document_id","type":"string","args":[],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"day_of_week","type":"integer","args":[],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"start_time","type":"string","args":[],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"end_time","type":"string","args":[],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"is_active","type":"boolean","args":[],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"created_at","type":"datetime","args":[{"useTz":false,"precision":6}],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"updated_at","type":"datetime","args":[{"useTz":false,"precision":6}],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"published_at","type":"datetime","args":[{"useTz":false,"precision":6}],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"created_by_id","type":"integer","args":[],"defaultTo":null,"notNullable":false,"unsigned":true},{"name":"updated_by_id","type":"integer","args":[],"defaultTo":null,"notNullable":false,"unsigned":true},{"name":"locale","type":"string","args":[],"defaultTo":null,"notNullable":false,"unsigned":false}]},{"name":"banners","indexes":[{"name":"banners_documents_idx","columns":["document_id","locale","published_at"]},{"name":"banners_created_by_id_fk","columns":["created_by_id"]},{"name":"banners_updated_by_id_fk","columns":["updated_by_id"]}],"foreignKeys":[{"name":"banners_created_by_id_fk","columns":["created_by_id"],"referencedTable":"admin_users","referencedColumns":["id"],"onDelete":"SET NULL"},{"name":"banners_updated_by_id_fk","columns":["updated_by_id"],"referencedTable":"admin_users","referencedColumns":["id"],"onDelete":"SET NULL"}],"columns":[{"name":"id","type":"increments","args":[{"primary":true,"primaryKey":true}],"defaultTo":null,"notNullable":true,"unsigned":false},{"name":"document_id","type":"string","args":[],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"title","type":"string","args":[],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"image_url","type":"string","args":[],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"link_url","type":"string","args":[],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"position","type":"string","args":[],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"start_date","type":"datetime","args":[{"useTz":false,"precision":6}],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"end_date","type":"datetime","args":[{"useTz":false,"precision":6}],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"is_active","type":"boolean","args":[],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"sort_order","type":"integer","args":[],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"created_at","type":"datetime","args":[{"useTz":false,"precision":6}],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"updated_at","type":"datetime","args":[{"useTz":false,"precision":6}],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"published_at","type":"datetime","args":[{"useTz":false,"precision":6}],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"created_by_id","type":"integer","args":[],"defaultTo":null,"notNullable":false,"unsigned":true},{"name":"updated_by_id","type":"integer","args":[],"defaultTo":null,"notNullable":false,"unsigned":true},{"name":"locale","type":"string","args":[],"defaultTo":null,"notNullable":false,"unsigned":false}]},{"name":"blocked_slots","indexes":[{"name":"blocked_slots_documents_idx","columns":["document_id","locale","published_at"]},{"name":"blocked_slots_created_by_id_fk","columns":["created_by_id"]},{"name":"blocked_slots_updated_by_id_fk","columns":["updated_by_id"]}],"foreignKeys":[{"name":"blocked_slots_created_by_id_fk","columns":["created_by_id"],"referencedTable":"admin_users","referencedColumns":["id"],"onDelete":"SET NULL"},{"name":"blocked_slots_updated_by_id_fk","columns":["updated_by_id"],"referencedTable":"admin_users","referencedColumns":["id"],"onDelete":"SET NULL"}],"columns":[{"name":"id","type":"increments","args":[{"primary":true,"primaryKey":true}],"defaultTo":null,"notNullable":true,"unsigned":false},{"name":"document_id","type":"string","args":[],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"date","type":"date","args":[],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"start_time","type":"string","args":[],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"end_time","type":"string","args":[],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"reason","type":"string","args":[],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"created_at","type":"datetime","args":[{"useTz":false,"precision":6}],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"updated_at","type":"datetime","args":[{"useTz":false,"precision":6}],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"published_at","type":"datetime","args":[{"useTz":false,"precision":6}],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"created_by_id","type":"integer","args":[],"defaultTo":null,"notNullable":false,"unsigned":true},{"name":"updated_by_id","type":"integer","args":[],"defaultTo":null,"notNullable":false,"unsigned":true},{"name":"locale","type":"string","args":[],"defaultTo":null,"notNullable":false,"unsigned":false}]},{"name":"bookings","indexes":[{"name":"bookings_documents_idx","columns":["document_id","locale","published_at"]},{"name":"bookings_created_by_id_fk","columns":["created_by_id"]},{"name":"bookings_updated_by_id_fk","columns":["updated_by_id"]}],"foreignKeys":[{"name":"bookings_created_by_id_fk","columns":["created_by_id"],"referencedTable":"admin_users","referencedColumns":["id"],"onDelete":"SET NULL"},{"name":"bookings_updated_by_id_fk","columns":["updated_by_id"],"referencedTable":"admin_users","referencedColumns":["id"],"onDelete":"SET NULL"}],"columns":[{"name":"id","type":"increments","args":[{"primary":true,"primaryKey":true}],"defaultTo":null,"notNullable":true,"unsigned":false},{"name":"document_id","type":"string","args":[],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"guest_name","type":"string","args":[],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"guest_email","type":"string","args":[],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"guest_phone","type":"string","args":[],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"scheduled_at","type":"datetime","args":[{"useTz":false,"precision":6}],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"end_at","type":"datetime","args":[{"useTz":false,"precision":6}],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"status","type":"string","args":[],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"payment_status","type":"string","args":[],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"rzp_order_id","type":"string","args":[],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"rzp_payment_id","type":"string","args":[],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"rzp_signature","type":"text","args":["longtext"],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"amount_paid","type":"integer","args":[],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"gcal_event_id","type":"string","args":[],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"customer_notes","type":"text","args":["longtext"],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"admin_notes","type":"text","args":["longtext"],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"cancelled_at","type":"datetime","args":[{"useTz":false,"precision":6}],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"cancel_reason","type":"text","args":["longtext"],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"rescheduled_from","type":"datetime","args":[{"useTz":false,"precision":6}],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"legacy_id","type":"string","args":[],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"created_at","type":"datetime","args":[{"useTz":false,"precision":6}],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"updated_at","type":"datetime","args":[{"useTz":false,"precision":6}],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"published_at","type":"datetime","args":[{"useTz":false,"precision":6}],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"created_by_id","type":"integer","args":[],"defaultTo":null,"notNullable":false,"unsigned":true},{"name":"updated_by_id","type":"integer","args":[],"defaultTo":null,"notNullable":false,"unsigned":true},{"name":"locale","type":"string","args":[],"defaultTo":null,"notNullable":false,"unsigned":false}]},{"name":"booking_setting","indexes":[{"name":"booking_setting_documents_idx","columns":["document_id","locale","published_at"]},{"name":"booking_setting_created_by_id_fk","columns":["created_by_id"]},{"name":"booking_setting_updated_by_id_fk","columns":["updated_by_id"]}],"foreignKeys":[{"name":"booking_setting_created_by_id_fk","columns":["created_by_id"],"referencedTable":"admin_users","referencedColumns":["id"],"onDelete":"SET NULL"},{"name":"booking_setting_updated_by_id_fk","columns":["updated_by_id"],"referencedTable":"admin_users","referencedColumns":["id"],"onDelete":"SET NULL"}],"columns":[{"name":"id","type":"increments","args":[{"primary":true,"primaryKey":true}],"defaultTo":null,"notNullable":true,"unsigned":false},{"name":"document_id","type":"string","args":[],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"slot_duration_minutes","type":"integer","args":[],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"buffer_between_slots","type":"integer","args":[],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"max_advance_booking_days","type":"integer","args":[],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"min_advance_booking_hours","type":"integer","args":[],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"cancellation_policy_hours","type":"integer","args":[],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"gcal_calendar_id","type":"string","args":[],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"gcal_sync_enabled","type":"boolean","args":[],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"gcal_refresh_token","type":"text","args":["longtext"],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"auto_confirm","type":"boolean","args":[],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"created_at","type":"datetime","args":[{"useTz":false,"precision":6}],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"updated_at","type":"datetime","args":[{"useTz":false,"precision":6}],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"published_at","type":"datetime","args":[{"useTz":false,"precision":6}],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"created_by_id","type":"integer","args":[],"defaultTo":null,"notNullable":false,"unsigned":true},{"name":"updated_by_id","type":"integer","args":[],"defaultTo":null,"notNullable":false,"unsigned":true},{"name":"locale","type":"string","args":[],"defaultTo":null,"notNullable":false,"unsigned":false}]},{"name":"business_setting","indexes":[{"name":"business_setting_documents_idx","columns":["document_id","locale","published_at"]},{"name":"business_setting_created_by_id_fk","columns":["created_by_id"]},{"name":"business_setting_updated_by_id_fk","columns":["updated_by_id"]}],"foreignKeys":[{"name":"business_setting_created_by_id_fk","columns":["created_by_id"],"referencedTable":"admin_users","referencedColumns":["id"],"onDelete":"SET NULL"},{"name":"business_setting_updated_by_id_fk","columns":["updated_by_id"],"referencedTable":"admin_users","referencedColumns":["id"],"onDelete":"SET NULL"}],"columns":[{"name":"id","type":"increments","args":[{"primary":true,"primaryKey":true}],"defaultTo":null,"notNullable":true,"unsigned":false},{"name":"document_id","type":"string","args":[],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"business_name","type":"string","args":[],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"gstin","type":"string","args":[],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"pan","type":"string","args":[],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"address","type":"text","args":["longtext"],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"state","type":"string","args":[],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"state_code","type":"string","args":[],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"phone","type":"string","args":[],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"email","type":"string","args":[],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"logo_url","type":"string","args":[],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"bank_name","type":"string","args":[],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"bank_account","type":"string","args":[],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"bank_ifsc","type":"string","args":[],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"invoice_prefix","type":"string","args":[],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"next_invoice_number","type":"integer","args":[],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"fb_pixel_id","type":"string","args":[],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"fb_pixel_enabled","type":"boolean","args":[],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"created_at","type":"datetime","args":[{"useTz":false,"precision":6}],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"updated_at","type":"datetime","args":[{"useTz":false,"precision":6}],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"published_at","type":"datetime","args":[{"useTz":false,"precision":6}],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"created_by_id","type":"integer","args":[],"defaultTo":null,"notNullable":false,"unsigned":true},{"name":"updated_by_id","type":"integer","args":[],"defaultTo":null,"notNullable":false,"unsigned":true},{"name":"locale","type":"string","args":[],"defaultTo":null,"notNullable":false,"unsigned":false}]},{"name":"cart_items","indexes":[{"name":"cart_items_documents_idx","columns":["document_id","locale","published_at"]},{"name":"cart_items_created_by_id_fk","columns":["created_by_id"]},{"name":"cart_items_updated_by_id_fk","columns":["updated_by_id"]}],"foreignKeys":[{"name":"cart_items_created_by_id_fk","columns":["created_by_id"],"referencedTable":"admin_users","referencedColumns":["id"],"onDelete":"SET NULL"},{"name":"cart_items_updated_by_id_fk","columns":["updated_by_id"],"referencedTable":"admin_users","referencedColumns":["id"],"onDelete":"SET NULL"}],"columns":[{"name":"id","type":"increments","args":[{"primary":true,"primaryKey":true}],"defaultTo":null,"notNullable":true,"unsigned":false},{"name":"document_id","type":"string","args":[],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"session_id","type":"string","args":[],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"quantity","type":"integer","args":[],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"variant_selection","type":"jsonb","args":[],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"created_at","type":"datetime","args":[{"useTz":false,"precision":6}],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"updated_at","type":"datetime","args":[{"useTz":false,"precision":6}],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"published_at","type":"datetime","args":[{"useTz":false,"precision":6}],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"created_by_id","type":"integer","args":[],"defaultTo":null,"notNullable":false,"unsigned":true},{"name":"updated_by_id","type":"integer","args":[],"defaultTo":null,"notNullable":false,"unsigned":true},{"name":"locale","type":"string","args":[],"defaultTo":null,"notNullable":false,"unsigned":false}]},{"name":"commerce_placeholders","indexes":[{"name":"commerce_placeholders_documents_idx","columns":["document_id","locale","published_at"]},{"name":"commerce_placeholders_created_by_id_fk","columns":["created_by_id"]},{"name":"commerce_placeholders_updated_by_id_fk","columns":["updated_by_id"]}],"foreignKeys":[{"name":"commerce_placeholders_created_by_id_fk","columns":["created_by_id"],"referencedTable":"admin_users","referencedColumns":["id"],"onDelete":"SET NULL"},{"name":"commerce_placeholders_updated_by_id_fk","columns":["updated_by_id"],"referencedTable":"admin_users","referencedColumns":["id"],"onDelete":"SET NULL"}],"columns":[{"name":"id","type":"increments","args":[{"primary":true,"primaryKey":true}],"defaultTo":null,"notNullable":true,"unsigned":false},{"name":"document_id","type":"string","args":[],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"name","type":"string","args":[],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"created_at","type":"datetime","args":[{"useTz":false,"precision":6}],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"updated_at","type":"datetime","args":[{"useTz":false,"precision":6}],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"published_at","type":"datetime","args":[{"useTz":false,"precision":6}],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"created_by_id","type":"integer","args":[],"defaultTo":null,"notNullable":false,"unsigned":true},{"name":"updated_by_id","type":"integer","args":[],"defaultTo":null,"notNullable":false,"unsigned":true},{"name":"locale","type":"string","args":[],"defaultTo":null,"notNullable":false,"unsigned":false}]},{"name":"contact_messages","indexes":[{"name":"contact_messages_documents_idx","columns":["document_id","locale","published_at"]},{"name":"contact_messages_created_by_id_fk","columns":["created_by_id"]},{"name":"contact_messages_updated_by_id_fk","columns":["updated_by_id"]}],"foreignKeys":[{"name":"contact_messages_created_by_id_fk","columns":["created_by_id"],"referencedTable":"admin_users","referencedColumns":["id"],"onDelete":"SET NULL"},{"name":"contact_messages_updated_by_id_fk","columns":["updated_by_id"],"referencedTable":"admin_users","referencedColumns":["id"],"onDelete":"SET NULL"}],"columns":[{"name":"id","type":"increments","args":[{"primary":true,"primaryKey":true}],"defaultTo":null,"notNullable":true,"unsigned":false},{"name":"document_id","type":"string","args":[],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"name","type":"string","args":[],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"email","type":"string","args":[],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"phone","type":"string","args":[],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"company","type":"string","args":[],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"message","type":"text","args":["longtext"],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"is_read","type":"boolean","args":[],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"created_at","type":"datetime","args":[{"useTz":false,"precision":6}],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"updated_at","type":"datetime","args":[{"useTz":false,"precision":6}],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"published_at","type":"datetime","args":[{"useTz":false,"precision":6}],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"created_by_id","type":"integer","args":[],"defaultTo":null,"notNullable":false,"unsigned":true},{"name":"updated_by_id","type":"integer","args":[],"defaultTo":null,"notNullable":false,"unsigned":true},{"name":"locale","type":"string","args":[],"defaultTo":null,"notNullable":false,"unsigned":false}]},{"name":"coupon_codes","indexes":[{"name":"coupon_codes_documents_idx","columns":["document_id","locale","published_at"]},{"name":"coupon_codes_created_by_id_fk","columns":["created_by_id"]},{"name":"coupon_codes_updated_by_id_fk","columns":["updated_by_id"]}],"foreignKeys":[{"name":"coupon_codes_created_by_id_fk","columns":["created_by_id"],"referencedTable":"admin_users","referencedColumns":["id"],"onDelete":"SET NULL"},{"name":"coupon_codes_updated_by_id_fk","columns":["updated_by_id"],"referencedTable":"admin_users","referencedColumns":["id"],"onDelete":"SET NULL"}],"columns":[{"name":"id","type":"increments","args":[{"primary":true,"primaryKey":true}],"defaultTo":null,"notNullable":true,"unsigned":false},{"name":"document_id","type":"string","args":[],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"code","type":"string","args":[],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"description","type":"text","args":["longtext"],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"discount_type","type":"string","args":[],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"discount_value","type":"integer","args":[],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"min_cart_total","type":"integer","args":[],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"max_discount","type":"integer","args":[],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"max_uses","type":"integer","args":[],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"used_count","type":"integer","args":[],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"per_user_limit","type":"integer","args":[],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"valid_from","type":"datetime","args":[{"useTz":false,"precision":6}],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"valid_until","type":"datetime","args":[{"useTz":false,"precision":6}],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"is_active","type":"boolean","args":[],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"applicable_category_ids","type":"jsonb","args":[],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"applicable_product_ids","type":"jsonb","args":[],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"created_at","type":"datetime","args":[{"useTz":false,"precision":6}],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"updated_at","type":"datetime","args":[{"useTz":false,"precision":6}],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"published_at","type":"datetime","args":[{"useTz":false,"precision":6}],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"created_by_id","type":"integer","args":[],"defaultTo":null,"notNullable":false,"unsigned":true},{"name":"updated_by_id","type":"integer","args":[],"defaultTo":null,"notNullable":false,"unsigned":true},{"name":"locale","type":"string","args":[],"defaultTo":null,"notNullable":false,"unsigned":false}]},{"name":"coupon_usages","indexes":[{"name":"coupon_usages_documents_idx","columns":["document_id","locale","published_at"]},{"name":"coupon_usages_created_by_id_fk","columns":["created_by_id"]},{"name":"coupon_usages_updated_by_id_fk","columns":["updated_by_id"]}],"foreignKeys":[{"name":"coupon_usages_created_by_id_fk","columns":["created_by_id"],"referencedTable":"admin_users","referencedColumns":["id"],"onDelete":"SET NULL"},{"name":"coupon_usages_updated_by_id_fk","columns":["updated_by_id"],"referencedTable":"admin_users","referencedColumns":["id"],"onDelete":"SET NULL"}],"columns":[{"name":"id","type":"increments","args":[{"primary":true,"primaryKey":true}],"defaultTo":null,"notNullable":true,"unsigned":false},{"name":"document_id","type":"string","args":[],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"guest_email","type":"string","args":[],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"discount_amount","type":"integer","args":[],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"used_at","type":"datetime","args":[{"useTz":false,"precision":6}],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"created_at","type":"datetime","args":[{"useTz":false,"precision":6}],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"updated_at","type":"datetime","args":[{"useTz":false,"precision":6}],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"published_at","type":"datetime","args":[{"useTz":false,"precision":6}],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"created_by_id","type":"integer","args":[],"defaultTo":null,"notNullable":false,"unsigned":true},{"name":"updated_by_id","type":"integer","args":[],"defaultTo":null,"notNullable":false,"unsigned":true},{"name":"locale","type":"string","args":[],"defaultTo":null,"notNullable":false,"unsigned":false}]},{"name":"digital_assets","indexes":[{"name":"digital_assets_documents_idx","columns":["document_id","locale","published_at"]},{"name":"digital_assets_created_by_id_fk","columns":["created_by_id"]},{"name":"digital_assets_updated_by_id_fk","columns":["updated_by_id"]}],"foreignKeys":[{"name":"digital_assets_created_by_id_fk","columns":["created_by_id"],"referencedTable":"admin_users","referencedColumns":["id"],"onDelete":"SET NULL"},{"name":"digital_assets_updated_by_id_fk","columns":["updated_by_id"],"referencedTable":"admin_users","referencedColumns":["id"],"onDelete":"SET NULL"}],"columns":[{"name":"id","type":"increments","args":[{"primary":true,"primaryKey":true}],"defaultTo":null,"notNullable":true,"unsigned":false},{"name":"document_id","type":"string","args":[],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"asset_type","type":"string","args":[],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"url","type":"string","args":[],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"file_name","type":"string","args":[],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"file_size","type":"integer","args":[],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"access_instructions","type":"text","args":["longtext"],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"created_at","type":"datetime","args":[{"useTz":false,"precision":6}],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"updated_at","type":"datetime","args":[{"useTz":false,"precision":6}],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"published_at","type":"datetime","args":[{"useTz":false,"precision":6}],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"created_by_id","type":"integer","args":[],"defaultTo":null,"notNullable":false,"unsigned":true},{"name":"updated_by_id","type":"integer","args":[],"defaultTo":null,"notNullable":false,"unsigned":true},{"name":"locale","type":"string","args":[],"defaultTo":null,"notNullable":false,"unsigned":false}]},{"name":"digital_purchases","indexes":[{"name":"digital_purchases_documents_idx","columns":["document_id","locale","published_at"]},{"name":"digital_purchases_created_by_id_fk","columns":["created_by_id"]},{"name":"digital_purchases_updated_by_id_fk","columns":["updated_by_id"]}],"foreignKeys":[{"name":"digital_purchases_created_by_id_fk","columns":["created_by_id"],"referencedTable":"admin_users","referencedColumns":["id"],"onDelete":"SET NULL"},{"name":"digital_purchases_updated_by_id_fk","columns":["updated_by_id"],"referencedTable":"admin_users","referencedColumns":["id"],"onDelete":"SET NULL"}],"columns":[{"name":"id","type":"increments","args":[{"primary":true,"primaryKey":true}],"defaultTo":null,"notNullable":true,"unsigned":false},{"name":"document_id","type":"string","args":[],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"guest_email","type":"string","args":[],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"access_granted_at","type":"datetime","args":[{"useTz":false,"precision":6}],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"access_url","type":"string","args":[],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"expires_at","type":"datetime","args":[{"useTz":false,"precision":6}],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"created_at","type":"datetime","args":[{"useTz":false,"precision":6}],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"updated_at","type":"datetime","args":[{"useTz":false,"precision":6}],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"published_at","type":"datetime","args":[{"useTz":false,"precision":6}],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"created_by_id","type":"integer","args":[],"defaultTo":null,"notNullable":false,"unsigned":true},{"name":"updated_by_id","type":"integer","args":[],"defaultTo":null,"notNullable":false,"unsigned":true},{"name":"locale","type":"string","args":[],"defaultTo":null,"notNullable":false,"unsigned":false}]},{"name":"email_logs","indexes":[{"name":"email_logs_documents_idx","columns":["document_id","locale","published_at"]},{"name":"email_logs_created_by_id_fk","columns":["created_by_id"]},{"name":"email_logs_updated_by_id_fk","columns":["updated_by_id"]}],"foreignKeys":[{"name":"email_logs_created_by_id_fk","columns":["created_by_id"],"referencedTable":"admin_users","referencedColumns":["id"],"onDelete":"SET NULL"},{"name":"email_logs_updated_by_id_fk","columns":["updated_by_id"],"referencedTable":"admin_users","referencedColumns":["id"],"onDelete":"SET NULL"}],"columns":[{"name":"id","type":"increments","args":[{"primary":true,"primaryKey":true}],"defaultTo":null,"notNullable":true,"unsigned":false},{"name":"document_id","type":"string","args":[],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"to","type":"string","args":[],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"subject","type":"string","args":[],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"template_name","type":"string","args":[],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"status","type":"string","args":[],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"related_type","type":"string","args":[],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"related_id","type":"string","args":[],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"error","type":"text","args":["longtext"],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"sent_at","type":"datetime","args":[{"useTz":false,"precision":6}],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"created_at","type":"datetime","args":[{"useTz":false,"precision":6}],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"updated_at","type":"datetime","args":[{"useTz":false,"precision":6}],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"published_at","type":"datetime","args":[{"useTz":false,"precision":6}],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"created_by_id","type":"integer","args":[],"defaultTo":null,"notNullable":false,"unsigned":true},{"name":"updated_by_id","type":"integer","args":[],"defaultTo":null,"notNullable":false,"unsigned":true},{"name":"locale","type":"string","args":[],"defaultTo":null,"notNullable":false,"unsigned":false}]},{"name":"invoices","indexes":[{"name":"invoices_documents_idx","columns":["document_id","locale","published_at"]},{"name":"invoices_created_by_id_fk","columns":["created_by_id"]},{"name":"invoices_updated_by_id_fk","columns":["updated_by_id"]}],"foreignKeys":[{"name":"invoices_created_by_id_fk","columns":["created_by_id"],"referencedTable":"admin_users","referencedColumns":["id"],"onDelete":"SET NULL"},{"name":"invoices_updated_by_id_fk","columns":["updated_by_id"],"referencedTable":"admin_users","referencedColumns":["id"],"onDelete":"SET NULL"}],"columns":[{"name":"id","type":"increments","args":[{"primary":true,"primaryKey":true}],"defaultTo":null,"notNullable":true,"unsigned":false},{"name":"document_id","type":"string","args":[],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"invoice_number","type":"string","args":[],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"invoice_date","type":"datetime","args":[{"useTz":false,"precision":6}],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"buyer_name","type":"string","args":[],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"buyer_address","type":"jsonb","args":[],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"buyer_gstin","type":"string","args":[],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"buyer_state","type":"string","args":[],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"buyer_state_code","type":"string","args":[],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"items","type":"jsonb","args":[],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"subtotal","type":"integer","args":[],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"cgst","type":"integer","args":[],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"sgst","type":"integer","args":[],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"igst","type":"integer","args":[],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"total_tax","type":"integer","args":[],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"grand_total","type":"integer","args":[],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"place_of_supply","type":"string","args":[],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"is_inter_state","type":"boolean","args":[],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"pdf_url","type":"string","args":[],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"created_at","type":"datetime","args":[{"useTz":false,"precision":6}],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"updated_at","type":"datetime","args":[{"useTz":false,"precision":6}],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"published_at","type":"datetime","args":[{"useTz":false,"precision":6}],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"created_by_id","type":"integer","args":[],"defaultTo":null,"notNullable":false,"unsigned":true},{"name":"updated_by_id","type":"integer","args":[],"defaultTo":null,"notNullable":false,"unsigned":true},{"name":"locale","type":"string","args":[],"defaultTo":null,"notNullable":false,"unsigned":false}]},{"name":"legal_pages","indexes":[{"name":"legal_pages_documents_idx","columns":["document_id","locale","published_at"]},{"name":"legal_pages_created_by_id_fk","columns":["created_by_id"]},{"name":"legal_pages_updated_by_id_fk","columns":["updated_by_id"]}],"foreignKeys":[{"name":"legal_pages_created_by_id_fk","columns":["created_by_id"],"referencedTable":"admin_users","referencedColumns":["id"],"onDelete":"SET NULL"},{"name":"legal_pages_updated_by_id_fk","columns":["updated_by_id"],"referencedTable":"admin_users","referencedColumns":["id"],"onDelete":"SET NULL"}],"columns":[{"name":"id","type":"increments","args":[{"primary":true,"primaryKey":true}],"defaultTo":null,"notNullable":true,"unsigned":false},{"name":"document_id","type":"string","args":[],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"slug","type":"string","args":[],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"title","type":"string","args":[],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"content","type":"text","args":["longtext"],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"created_at","type":"datetime","args":[{"useTz":false,"precision":6}],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"updated_at","type":"datetime","args":[{"useTz":false,"precision":6}],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"published_at","type":"datetime","args":[{"useTz":false,"precision":6}],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"created_by_id","type":"integer","args":[],"defaultTo":null,"notNullable":false,"unsigned":true},{"name":"updated_by_id","type":"integer","args":[],"defaultTo":null,"notNullable":false,"unsigned":true},{"name":"locale","type":"string","args":[],"defaultTo":null,"notNullable":false,"unsigned":false}]},{"name":"orders","indexes":[{"name":"orders_documents_idx","columns":["document_id","locale","published_at"]},{"name":"orders_created_by_id_fk","columns":["created_by_id"]},{"name":"orders_updated_by_id_fk","columns":["updated_by_id"]}],"foreignKeys":[{"name":"orders_created_by_id_fk","columns":["created_by_id"],"referencedTable":"admin_users","referencedColumns":["id"],"onDelete":"SET NULL"},{"name":"orders_updated_by_id_fk","columns":["updated_by_id"],"referencedTable":"admin_users","referencedColumns":["id"],"onDelete":"SET NULL"}],"columns":[{"name":"id","type":"increments","args":[{"primary":true,"primaryKey":true}],"defaultTo":null,"notNullable":true,"unsigned":false},{"name":"document_id","type":"string","args":[],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"guest_name","type":"string","args":[],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"guest_email","type":"string","args":[],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"guest_phone","type":"string","args":[],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"status","type":"string","args":[],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"subtotal","type":"integer","args":[],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"discount","type":"integer","args":[],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"tax","type":"integer","args":[],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"shipping_amount","type":"integer","args":[],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"total","type":"integer","args":[],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"rzp_order_id","type":"string","args":[],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"rzp_payment_id","type":"string","args":[],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"rzp_signature","type":"text","args":["longtext"],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"payment_status","type":"string","args":[],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"payment_method","type":"string","args":[],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"refund_id","type":"string","args":[],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"refund_status","type":"string","args":[],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"refund_amount","type":"integer","args":[],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"shipping_address","type":"jsonb","args":[],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"billing_address","type":"jsonb","args":[],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"notes","type":"text","args":["longtext"],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"legacy_id","type":"string","args":[],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"created_at","type":"datetime","args":[{"useTz":false,"precision":6}],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"updated_at","type":"datetime","args":[{"useTz":false,"precision":6}],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"published_at","type":"datetime","args":[{"useTz":false,"precision":6}],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"created_by_id","type":"integer","args":[],"defaultTo":null,"notNullable":false,"unsigned":true},{"name":"updated_by_id","type":"integer","args":[],"defaultTo":null,"notNullable":false,"unsigned":true},{"name":"locale","type":"string","args":[],"defaultTo":null,"notNullable":false,"unsigned":false}]},{"name":"order_items","indexes":[{"name":"order_items_documents_idx","columns":["document_id","locale","published_at"]},{"name":"order_items_created_by_id_fk","columns":["created_by_id"]},{"name":"order_items_updated_by_id_fk","columns":["updated_by_id"]}],"foreignKeys":[{"name":"order_items_created_by_id_fk","columns":["created_by_id"],"referencedTable":"admin_users","referencedColumns":["id"],"onDelete":"SET NULL"},{"name":"order_items_updated_by_id_fk","columns":["updated_by_id"],"referencedTable":"admin_users","referencedColumns":["id"],"onDelete":"SET NULL"}],"columns":[{"name":"id","type":"increments","args":[{"primary":true,"primaryKey":true}],"defaultTo":null,"notNullable":true,"unsigned":false},{"name":"document_id","type":"string","args":[],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"variant_selection","type":"jsonb","args":[],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"quantity","type":"integer","args":[],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"unit_price","type":"integer","args":[],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"gst_rate_bps","type":"integer","args":[],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"hsn_code","type":"string","args":[],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"created_at","type":"datetime","args":[{"useTz":false,"precision":6}],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"updated_at","type":"datetime","args":[{"useTz":false,"precision":6}],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"published_at","type":"datetime","args":[{"useTz":false,"precision":6}],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"created_by_id","type":"integer","args":[],"defaultTo":null,"notNullable":false,"unsigned":true},{"name":"updated_by_id","type":"integer","args":[],"defaultTo":null,"notNullable":false,"unsigned":true},{"name":"locale","type":"string","args":[],"defaultTo":null,"notNullable":false,"unsigned":false}]},{"name":"order_shipments","indexes":[{"name":"order_shipments_documents_idx","columns":["document_id","locale","published_at"]},{"name":"order_shipments_created_by_id_fk","columns":["created_by_id"]},{"name":"order_shipments_updated_by_id_fk","columns":["updated_by_id"]}],"foreignKeys":[{"name":"order_shipments_created_by_id_fk","columns":["created_by_id"],"referencedTable":"admin_users","referencedColumns":["id"],"onDelete":"SET NULL"},{"name":"order_shipments_updated_by_id_fk","columns":["updated_by_id"],"referencedTable":"admin_users","referencedColumns":["id"],"onDelete":"SET NULL"}],"columns":[{"name":"id","type":"increments","args":[{"primary":true,"primaryKey":true}],"defaultTo":null,"notNullable":true,"unsigned":false},{"name":"document_id","type":"string","args":[],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"courier_name","type":"string","args":[],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"tracking_number","type":"string","args":[],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"tracking_url","type":"string","args":[],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"shipped_at","type":"datetime","args":[{"useTz":false,"precision":6}],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"delivered_at","type":"datetime","args":[{"useTz":false,"precision":6}],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"notes","type":"text","args":["longtext"],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"created_at","type":"datetime","args":[{"useTz":false,"precision":6}],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"updated_at","type":"datetime","args":[{"useTz":false,"precision":6}],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"published_at","type":"datetime","args":[{"useTz":false,"precision":6}],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"created_by_id","type":"integer","args":[],"defaultTo":null,"notNullable":false,"unsigned":true},{"name":"updated_by_id","type":"integer","args":[],"defaultTo":null,"notNullable":false,"unsigned":true},{"name":"locale","type":"string","args":[],"defaultTo":null,"notNullable":false,"unsigned":false}]},{"name":"password_reset_tokens","indexes":[{"name":"password_reset_tokens_documents_idx","columns":["document_id","locale","published_at"]},{"name":"password_reset_tokens_created_by_id_fk","columns":["created_by_id"]},{"name":"password_reset_tokens_updated_by_id_fk","columns":["updated_by_id"]}],"foreignKeys":[{"name":"password_reset_tokens_created_by_id_fk","columns":["created_by_id"],"referencedTable":"admin_users","referencedColumns":["id"],"onDelete":"SET NULL"},{"name":"password_reset_tokens_updated_by_id_fk","columns":["updated_by_id"],"referencedTable":"admin_users","referencedColumns":["id"],"onDelete":"SET NULL"}],"columns":[{"name":"id","type":"increments","args":[{"primary":true,"primaryKey":true}],"defaultTo":null,"notNullable":true,"unsigned":false},{"name":"document_id","type":"string","args":[],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"token","type":"string","args":[],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"expires_at","type":"datetime","args":[{"useTz":false,"precision":6}],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"created_at","type":"datetime","args":[{"useTz":false,"precision":6}],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"updated_at","type":"datetime","args":[{"useTz":false,"precision":6}],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"published_at","type":"datetime","args":[{"useTz":false,"precision":6}],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"created_by_id","type":"integer","args":[],"defaultTo":null,"notNullable":false,"unsigned":true},{"name":"updated_by_id","type":"integer","args":[],"defaultTo":null,"notNullable":false,"unsigned":true},{"name":"locale","type":"string","args":[],"defaultTo":null,"notNullable":false,"unsigned":false}]},{"name":"popups","indexes":[{"name":"popups_documents_idx","columns":["document_id","locale","published_at"]},{"name":"popups_created_by_id_fk","columns":["created_by_id"]},{"name":"popups_updated_by_id_fk","columns":["updated_by_id"]}],"foreignKeys":[{"name":"popups_created_by_id_fk","columns":["created_by_id"],"referencedTable":"admin_users","referencedColumns":["id"],"onDelete":"SET NULL"},{"name":"popups_updated_by_id_fk","columns":["updated_by_id"],"referencedTable":"admin_users","referencedColumns":["id"],"onDelete":"SET NULL"}],"columns":[{"name":"id","type":"increments","args":[{"primary":true,"primaryKey":true}],"defaultTo":null,"notNullable":true,"unsigned":false},{"name":"document_id","type":"string","args":[],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"title","type":"string","args":[],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"content","type":"text","args":["longtext"],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"image_url","type":"string","args":[],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"link_url","type":"string","args":[],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"trigger_type","type":"string","args":[],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"trigger_value","type":"integer","args":[],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"show_on_pages","type":"jsonb","args":[],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"frequency","type":"string","args":[],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"start_date","type":"datetime","args":[{"useTz":false,"precision":6}],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"end_date","type":"datetime","args":[{"useTz":false,"precision":6}],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"is_active","type":"boolean","args":[],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"created_at","type":"datetime","args":[{"useTz":false,"precision":6}],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"updated_at","type":"datetime","args":[{"useTz":false,"precision":6}],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"published_at","type":"datetime","args":[{"useTz":false,"precision":6}],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"created_by_id","type":"integer","args":[],"defaultTo":null,"notNullable":false,"unsigned":true},{"name":"updated_by_id","type":"integer","args":[],"defaultTo":null,"notNullable":false,"unsigned":true},{"name":"locale","type":"string","args":[],"defaultTo":null,"notNullable":false,"unsigned":false}]},{"name":"products","indexes":[{"name":"products_documents_idx","columns":["document_id","locale","published_at"]},{"name":"products_created_by_id_fk","columns":["created_by_id"]},{"name":"products_updated_by_id_fk","columns":["updated_by_id"]}],"foreignKeys":[{"name":"products_created_by_id_fk","columns":["created_by_id"],"referencedTable":"admin_users","referencedColumns":["id"],"onDelete":"SET NULL"},{"name":"products_updated_by_id_fk","columns":["updated_by_id"],"referencedTable":"admin_users","referencedColumns":["id"],"onDelete":"SET NULL"}],"columns":[{"name":"id","type":"increments","args":[{"primary":true,"primaryKey":true}],"defaultTo":null,"notNullable":true,"unsigned":false},{"name":"document_id","type":"string","args":[],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"name","type":"string","args":[],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"slug","type":"string","args":[],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"description","type":"text","args":["longtext"],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"product_type","type":"string","args":[],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"price","type":"integer","args":[],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"sale_price","type":"integer","args":[],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"stock","type":"integer","args":[],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"images","type":"jsonb","args":[],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"healing_properties","type":"text","args":["longtext"],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"wear_hand","type":"string","args":[],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"hsn_code","type":"string","args":[],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"gst_rate_bps","type":"integer","args":[],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"is_active","type":"boolean","args":[],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"created_at","type":"datetime","args":[{"useTz":false,"precision":6}],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"updated_at","type":"datetime","args":[{"useTz":false,"precision":6}],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"published_at","type":"datetime","args":[{"useTz":false,"precision":6}],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"created_by_id","type":"integer","args":[],"defaultTo":null,"notNullable":false,"unsigned":true},{"name":"updated_by_id","type":"integer","args":[],"defaultTo":null,"notNullable":false,"unsigned":true},{"name":"locale","type":"string","args":[],"defaultTo":null,"notNullable":false,"unsigned":false}]},{"name":"product_categories","indexes":[{"name":"product_categories_documents_idx","columns":["document_id","locale","published_at"]},{"name":"product_categories_created_by_id_fk","columns":["created_by_id"]},{"name":"product_categories_updated_by_id_fk","columns":["updated_by_id"]}],"foreignKeys":[{"name":"product_categories_created_by_id_fk","columns":["created_by_id"],"referencedTable":"admin_users","referencedColumns":["id"],"onDelete":"SET NULL"},{"name":"product_categories_updated_by_id_fk","columns":["updated_by_id"],"referencedTable":"admin_users","referencedColumns":["id"],"onDelete":"SET NULL"}],"columns":[{"name":"id","type":"increments","args":[{"primary":true,"primaryKey":true}],"defaultTo":null,"notNullable":true,"unsigned":false},{"name":"document_id","type":"string","args":[],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"name","type":"string","args":[],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"slug","type":"string","args":[],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"sort_order","type":"integer","args":[],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"created_at","type":"datetime","args":[{"useTz":false,"precision":6}],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"updated_at","type":"datetime","args":[{"useTz":false,"precision":6}],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"published_at","type":"datetime","args":[{"useTz":false,"precision":6}],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"created_by_id","type":"integer","args":[],"defaultTo":null,"notNullable":false,"unsigned":true},{"name":"updated_by_id","type":"integer","args":[],"defaultTo":null,"notNullable":false,"unsigned":true},{"name":"locale","type":"string","args":[],"defaultTo":null,"notNullable":false,"unsigned":false}]},{"name":"product_variants","indexes":[{"name":"product_variants_documents_idx","columns":["document_id","locale","published_at"]},{"name":"product_variants_created_by_id_fk","columns":["created_by_id"]},{"name":"product_variants_updated_by_id_fk","columns":["updated_by_id"]}],"foreignKeys":[{"name":"product_variants_created_by_id_fk","columns":["created_by_id"],"referencedTable":"admin_users","referencedColumns":["id"],"onDelete":"SET NULL"},{"name":"product_variants_updated_by_id_fk","columns":["updated_by_id"],"referencedTable":"admin_users","referencedColumns":["id"],"onDelete":"SET NULL"}],"columns":[{"name":"id","type":"increments","args":[{"primary":true,"primaryKey":true}],"defaultTo":null,"notNullable":true,"unsigned":false},{"name":"document_id","type":"string","args":[],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"name","type":"string","args":[],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"options","type":"jsonb","args":[],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"created_at","type":"datetime","args":[{"useTz":false,"precision":6}],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"updated_at","type":"datetime","args":[{"useTz":false,"precision":6}],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"published_at","type":"datetime","args":[{"useTz":false,"precision":6}],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"created_by_id","type":"integer","args":[],"defaultTo":null,"notNullable":false,"unsigned":true},{"name":"updated_by_id","type":"integer","args":[],"defaultTo":null,"notNullable":false,"unsigned":true},{"name":"locale","type":"string","args":[],"defaultTo":null,"notNullable":false,"unsigned":false}]},{"name":"promo_rules","indexes":[{"name":"promo_rules_documents_idx","columns":["document_id","locale","published_at"]},{"name":"promo_rules_created_by_id_fk","columns":["created_by_id"]},{"name":"promo_rules_updated_by_id_fk","columns":["updated_by_id"]}],"foreignKeys":[{"name":"promo_rules_created_by_id_fk","columns":["created_by_id"],"referencedTable":"admin_users","referencedColumns":["id"],"onDelete":"SET NULL"},{"name":"promo_rules_updated_by_id_fk","columns":["updated_by_id"],"referencedTable":"admin_users","referencedColumns":["id"],"onDelete":"SET NULL"}],"columns":[{"name":"id","type":"increments","args":[{"primary":true,"primaryKey":true}],"defaultTo":null,"notNullable":true,"unsigned":false},{"name":"document_id","type":"string","args":[],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"type","type":"string","args":[],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"config","type":"jsonb","args":[],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"is_active","type":"boolean","args":[],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"created_at","type":"datetime","args":[{"useTz":false,"precision":6}],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"updated_at","type":"datetime","args":[{"useTz":false,"precision":6}],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"published_at","type":"datetime","args":[{"useTz":false,"precision":6}],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"created_by_id","type":"integer","args":[],"defaultTo":null,"notNullable":false,"unsigned":true},{"name":"updated_by_id","type":"integer","args":[],"defaultTo":null,"notNullable":false,"unsigned":true},{"name":"locale","type":"string","args":[],"defaultTo":null,"notNullable":false,"unsigned":false}]},{"name":"reviews","indexes":[{"name":"reviews_documents_idx","columns":["document_id","locale","published_at"]},{"name":"reviews_created_by_id_fk","columns":["created_by_id"]},{"name":"reviews_updated_by_id_fk","columns":["updated_by_id"]}],"foreignKeys":[{"name":"reviews_created_by_id_fk","columns":["created_by_id"],"referencedTable":"admin_users","referencedColumns":["id"],"onDelete":"SET NULL"},{"name":"reviews_updated_by_id_fk","columns":["updated_by_id"],"referencedTable":"admin_users","referencedColumns":["id"],"onDelete":"SET NULL"}],"columns":[{"name":"id","type":"increments","args":[{"primary":true,"primaryKey":true}],"defaultTo":null,"notNullable":true,"unsigned":false},{"name":"document_id","type":"string","args":[],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"rating","type":"integer","args":[],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"comment","type":"text","args":["longtext"],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"created_at","type":"datetime","args":[{"useTz":false,"precision":6}],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"updated_at","type":"datetime","args":[{"useTz":false,"precision":6}],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"published_at","type":"datetime","args":[{"useTz":false,"precision":6}],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"created_by_id","type":"integer","args":[],"defaultTo":null,"notNullable":false,"unsigned":true},{"name":"updated_by_id","type":"integer","args":[],"defaultTo":null,"notNullable":false,"unsigned":true},{"name":"locale","type":"string","args":[],"defaultTo":null,"notNullable":false,"unsigned":false}]},{"name":"scheduled_reminders","indexes":[{"name":"scheduled_reminders_documents_idx","columns":["document_id","locale","published_at"]},{"name":"scheduled_reminders_created_by_id_fk","columns":["created_by_id"]},{"name":"scheduled_reminders_updated_by_id_fk","columns":["updated_by_id"]}],"foreignKeys":[{"name":"scheduled_reminders_created_by_id_fk","columns":["created_by_id"],"referencedTable":"admin_users","referencedColumns":["id"],"onDelete":"SET NULL"},{"name":"scheduled_reminders_updated_by_id_fk","columns":["updated_by_id"],"referencedTable":"admin_users","referencedColumns":["id"],"onDelete":"SET NULL"}],"columns":[{"name":"id","type":"increments","args":[{"primary":true,"primaryKey":true}],"defaultTo":null,"notNullable":true,"unsigned":false},{"name":"document_id","type":"string","args":[],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"reminder_type","type":"string","args":[],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"scheduled_for","type":"datetime","args":[{"useTz":false,"precision":6}],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"sent","type":"boolean","args":[],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"sent_at","type":"datetime","args":[{"useTz":false,"precision":6}],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"created_at","type":"datetime","args":[{"useTz":false,"precision":6}],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"updated_at","type":"datetime","args":[{"useTz":false,"precision":6}],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"published_at","type":"datetime","args":[{"useTz":false,"precision":6}],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"created_by_id","type":"integer","args":[],"defaultTo":null,"notNullable":false,"unsigned":true},{"name":"updated_by_id","type":"integer","args":[],"defaultTo":null,"notNullable":false,"unsigned":true},{"name":"locale","type":"string","args":[],"defaultTo":null,"notNullable":false,"unsigned":false}]},{"name":"services","indexes":[{"name":"services_documents_idx","columns":["document_id","locale","published_at"]},{"name":"services_created_by_id_fk","columns":["created_by_id"]},{"name":"services_updated_by_id_fk","columns":["updated_by_id"]}],"foreignKeys":[{"name":"services_created_by_id_fk","columns":["created_by_id"],"referencedTable":"admin_users","referencedColumns":["id"],"onDelete":"SET NULL"},{"name":"services_updated_by_id_fk","columns":["updated_by_id"],"referencedTable":"admin_users","referencedColumns":["id"],"onDelete":"SET NULL"}],"columns":[{"name":"id","type":"increments","args":[{"primary":true,"primaryKey":true}],"defaultTo":null,"notNullable":true,"unsigned":false},{"name":"document_id","type":"string","args":[],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"name","type":"string","args":[],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"type","type":"string","args":[],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"price","type":"integer","args":[],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"duration_minutes","type":"integer","args":[],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"staff_id","type":"string","args":[],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"buffer_minutes","type":"integer","args":[],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"is_active","type":"boolean","args":[],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"description","type":"text","args":["longtext"],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"created_at","type":"datetime","args":[{"useTz":false,"precision":6}],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"updated_at","type":"datetime","args":[{"useTz":false,"precision":6}],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"published_at","type":"datetime","args":[{"useTz":false,"precision":6}],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"created_by_id","type":"integer","args":[],"defaultTo":null,"notNullable":false,"unsigned":true},{"name":"updated_by_id","type":"integer","args":[],"defaultTo":null,"notNullable":false,"unsigned":true},{"name":"locale","type":"string","args":[],"defaultTo":null,"notNullable":false,"unsigned":false}]},{"name":"shipping_classes","indexes":[{"name":"shipping_classes_documents_idx","columns":["document_id","locale","published_at"]},{"name":"shipping_classes_created_by_id_fk","columns":["created_by_id"]},{"name":"shipping_classes_updated_by_id_fk","columns":["updated_by_id"]}],"foreignKeys":[{"name":"shipping_classes_created_by_id_fk","columns":["created_by_id"],"referencedTable":"admin_users","referencedColumns":["id"],"onDelete":"SET NULL"},{"name":"shipping_classes_updated_by_id_fk","columns":["updated_by_id"],"referencedTable":"admin_users","referencedColumns":["id"],"onDelete":"SET NULL"}],"columns":[{"name":"id","type":"increments","args":[{"primary":true,"primaryKey":true}],"defaultTo":null,"notNullable":true,"unsigned":false},{"name":"document_id","type":"string","args":[],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"name","type":"string","args":[],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"rate","type":"integer","args":[],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"free_above","type":"integer","args":[],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"description","type":"text","args":["longtext"],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"created_at","type":"datetime","args":[{"useTz":false,"precision":6}],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"updated_at","type":"datetime","args":[{"useTz":false,"precision":6}],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"published_at","type":"datetime","args":[{"useTz":false,"precision":6}],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"created_by_id","type":"integer","args":[],"defaultTo":null,"notNullable":false,"unsigned":true},{"name":"updated_by_id","type":"integer","args":[],"defaultTo":null,"notNullable":false,"unsigned":true},{"name":"locale","type":"string","args":[],"defaultTo":null,"notNullable":false,"unsigned":false}]},{"name":"testimonials","indexes":[{"name":"testimonials_documents_idx","columns":["document_id","locale","published_at"]},{"name":"testimonials_created_by_id_fk","columns":["created_by_id"]},{"name":"testimonials_updated_by_id_fk","columns":["updated_by_id"]}],"foreignKeys":[{"name":"testimonials_created_by_id_fk","columns":["created_by_id"],"referencedTable":"admin_users","referencedColumns":["id"],"onDelete":"SET NULL"},{"name":"testimonials_updated_by_id_fk","columns":["updated_by_id"],"referencedTable":"admin_users","referencedColumns":["id"],"onDelete":"SET NULL"}],"columns":[{"name":"id","type":"increments","args":[{"primary":true,"primaryKey":true}],"defaultTo":null,"notNullable":true,"unsigned":false},{"name":"document_id","type":"string","args":[],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"name","type":"string","args":[],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"text","type":"text","args":["longtext"],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"sort_order","type":"integer","args":[],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"is_active","type":"boolean","args":[],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"created_at","type":"datetime","args":[{"useTz":false,"precision":6}],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"updated_at","type":"datetime","args":[{"useTz":false,"precision":6}],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"published_at","type":"datetime","args":[{"useTz":false,"precision":6}],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"created_by_id","type":"integer","args":[],"defaultTo":null,"notNullable":false,"unsigned":true},{"name":"updated_by_id","type":"integer","args":[],"defaultTo":null,"notNullable":false,"unsigned":true},{"name":"locale","type":"string","args":[],"defaultTo":null,"notNullable":false,"unsigned":false}]},{"name":"wishlist_items","indexes":[{"name":"wishlist_items_documents_idx","columns":["document_id","locale","published_at"]},{"name":"wishlist_items_created_by_id_fk","columns":["created_by_id"]},{"name":"wishlist_items_updated_by_id_fk","columns":["updated_by_id"]}],"foreignKeys":[{"name":"wishlist_items_created_by_id_fk","columns":["created_by_id"],"referencedTable":"admin_users","referencedColumns":["id"],"onDelete":"SET NULL"},{"name":"wishlist_items_updated_by_id_fk","columns":["updated_by_id"],"referencedTable":"admin_users","referencedColumns":["id"],"onDelete":"SET NULL"}],"columns":[{"name":"id","type":"increments","args":[{"primary":true,"primaryKey":true}],"defaultTo":null,"notNullable":true,"unsigned":false},{"name":"document_id","type":"string","args":[],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"created_at","type":"datetime","args":[{"useTz":false,"precision":6}],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"updated_at","type":"datetime","args":[{"useTz":false,"precision":6}],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"published_at","type":"datetime","args":[{"useTz":false,"precision":6}],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"created_by_id","type":"integer","args":[],"defaultTo":null,"notNullable":false,"unsigned":true},{"name":"updated_by_id","type":"integer","args":[],"defaultTo":null,"notNullable":false,"unsigned":true},{"name":"locale","type":"string","args":[],"defaultTo":null,"notNullable":false,"unsigned":false}]},{"name":"admin_permissions","indexes":[{"name":"admin_permissions_documents_idx","columns":["document_id","locale","published_at"]},{"name":"admin_permissions_created_by_id_fk","columns":["created_by_id"]},{"name":"admin_permissions_updated_by_id_fk","columns":["updated_by_id"]}],"foreignKeys":[{"name":"admin_permissions_created_by_id_fk","columns":["created_by_id"],"referencedTable":"admin_users","referencedColumns":["id"],"onDelete":"SET NULL"},{"name":"admin_permissions_updated_by_id_fk","columns":["updated_by_id"],"referencedTable":"admin_users","referencedColumns":["id"],"onDelete":"SET NULL"}],"columns":[{"name":"id","type":"increments","args":[{"primary":true,"primaryKey":true}],"defaultTo":null,"notNullable":true,"unsigned":false},{"name":"document_id","type":"string","args":[],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"action","type":"string","args":[],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"action_parameters","type":"jsonb","args":[],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"subject","type":"string","args":[],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"properties","type":"jsonb","args":[],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"conditions","type":"jsonb","args":[],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"created_at","type":"datetime","args":[{"useTz":false,"precision":6}],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"updated_at","type":"datetime","args":[{"useTz":false,"precision":6}],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"published_at","type":"datetime","args":[{"useTz":false,"precision":6}],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"created_by_id","type":"integer","args":[],"defaultTo":null,"notNullable":false,"unsigned":true},{"name":"updated_by_id","type":"integer","args":[],"defaultTo":null,"notNullable":false,"unsigned":true},{"name":"locale","type":"string","args":[],"defaultTo":null,"notNullable":false,"unsigned":false}]},{"name":"admin_users","indexes":[{"name":"admin_users_documents_idx","columns":["document_id","locale","published_at"]},{"name":"admin_users_created_by_id_fk","columns":["created_by_id"]},{"name":"admin_users_updated_by_id_fk","columns":["updated_by_id"]}],"foreignKeys":[{"name":"admin_users_created_by_id_fk","columns":["created_by_id"],"referencedTable":"admin_users","referencedColumns":["id"],"onDelete":"SET NULL"},{"name":"admin_users_updated_by_id_fk","columns":["updated_by_id"],"referencedTable":"admin_users","referencedColumns":["id"],"onDelete":"SET NULL"}],"columns":[{"name":"id","type":"increments","args":[{"primary":true,"primaryKey":true}],"defaultTo":null,"notNullable":true,"unsigned":false},{"name":"document_id","type":"string","args":[],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"firstname","type":"string","args":[],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"lastname","type":"string","args":[],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"username","type":"string","args":[],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"email","type":"string","args":[],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"password","type":"string","args":[],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"reset_password_token","type":"string","args":[],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"registration_token","type":"string","args":[],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"is_active","type":"boolean","args":[],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"blocked","type":"boolean","args":[],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"prefered_language","type":"string","args":[],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"created_at","type":"datetime","args":[{"useTz":false,"precision":6}],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"updated_at","type":"datetime","args":[{"useTz":false,"precision":6}],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"published_at","type":"datetime","args":[{"useTz":false,"precision":6}],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"created_by_id","type":"integer","args":[],"defaultTo":null,"notNullable":false,"unsigned":true},{"name":"updated_by_id","type":"integer","args":[],"defaultTo":null,"notNullable":false,"unsigned":true},{"name":"locale","type":"string","args":[],"defaultTo":null,"notNullable":false,"unsigned":false}]},{"name":"admin_roles","indexes":[{"name":"admin_roles_documents_idx","columns":["document_id","locale","published_at"]},{"name":"admin_roles_created_by_id_fk","columns":["created_by_id"]},{"name":"admin_roles_updated_by_id_fk","columns":["updated_by_id"]}],"foreignKeys":[{"name":"admin_roles_created_by_id_fk","columns":["created_by_id"],"referencedTable":"admin_users","referencedColumns":["id"],"onDelete":"SET NULL"},{"name":"admin_roles_updated_by_id_fk","columns":["updated_by_id"],"referencedTable":"admin_users","referencedColumns":["id"],"onDelete":"SET NULL"}],"columns":[{"name":"id","type":"increments","args":[{"primary":true,"primaryKey":true}],"defaultTo":null,"notNullable":true,"unsigned":false},{"name":"document_id","type":"string","args":[],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"name","type":"string","args":[],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"code","type":"string","args":[],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"description","type":"string","args":[],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"created_at","type":"datetime","args":[{"useTz":false,"precision":6}],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"updated_at","type":"datetime","args":[{"useTz":false,"precision":6}],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"published_at","type":"datetime","args":[{"useTz":false,"precision":6}],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"created_by_id","type":"integer","args":[],"defaultTo":null,"notNullable":false,"unsigned":true},{"name":"updated_by_id","type":"integer","args":[],"defaultTo":null,"notNullable":false,"unsigned":true},{"name":"locale","type":"string","args":[],"defaultTo":null,"notNullable":false,"unsigned":false}]},{"name":"strapi_api_tokens","indexes":[{"name":"strapi_api_tokens_documents_idx","columns":["document_id","locale","published_at"]},{"name":"strapi_api_tokens_created_by_id_fk","columns":["created_by_id"]},{"name":"strapi_api_tokens_updated_by_id_fk","columns":["updated_by_id"]}],"foreignKeys":[{"name":"strapi_api_tokens_created_by_id_fk","columns":["created_by_id"],"referencedTable":"admin_users","referencedColumns":["id"],"onDelete":"SET NULL"},{"name":"strapi_api_tokens_updated_by_id_fk","columns":["updated_by_id"],"referencedTable":"admin_users","referencedColumns":["id"],"onDelete":"SET NULL"}],"columns":[{"name":"id","type":"increments","args":[{"primary":true,"primaryKey":true}],"defaultTo":null,"notNullable":true,"unsigned":false},{"name":"document_id","type":"string","args":[],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"name","type":"string","args":[],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"description","type":"string","args":[],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"type","type":"string","args":[],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"access_key","type":"string","args":[],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"encrypted_key","type":"text","args":["longtext"],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"last_used_at","type":"datetime","args":[{"useTz":false,"precision":6}],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"expires_at","type":"datetime","args":[{"useTz":false,"precision":6}],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"lifespan","type":"bigInteger","args":[],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"created_at","type":"datetime","args":[{"useTz":false,"precision":6}],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"updated_at","type":"datetime","args":[{"useTz":false,"precision":6}],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"published_at","type":"datetime","args":[{"useTz":false,"precision":6}],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"created_by_id","type":"integer","args":[],"defaultTo":null,"notNullable":false,"unsigned":true},{"name":"updated_by_id","type":"integer","args":[],"defaultTo":null,"notNullable":false,"unsigned":true},{"name":"locale","type":"string","args":[],"defaultTo":null,"notNullable":false,"unsigned":false}]},{"name":"strapi_api_token_permissions","indexes":[{"name":"strapi_api_token_permissions_documents_idx","columns":["document_id","locale","published_at"]},{"name":"strapi_api_token_permissions_created_by_id_fk","columns":["created_by_id"]},{"name":"strapi_api_token_permissions_updated_by_id_fk","columns":["updated_by_id"]}],"foreignKeys":[{"name":"strapi_api_token_permissions_created_by_id_fk","columns":["created_by_id"],"referencedTable":"admin_users","referencedColumns":["id"],"onDelete":"SET NULL"},{"name":"strapi_api_token_permissions_updated_by_id_fk","columns":["updated_by_id"],"referencedTable":"admin_users","referencedColumns":["id"],"onDelete":"SET NULL"}],"columns":[{"name":"id","type":"increments","args":[{"primary":true,"primaryKey":true}],"defaultTo":null,"notNullable":true,"unsigned":false},{"name":"document_id","type":"string","args":[],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"action","type":"string","args":[],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"created_at","type":"datetime","args":[{"useTz":false,"precision":6}],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"updated_at","type":"datetime","args":[{"useTz":false,"precision":6}],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"published_at","type":"datetime","args":[{"useTz":false,"precision":6}],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"created_by_id","type":"integer","args":[],"defaultTo":null,"notNullable":false,"unsigned":true},{"name":"updated_by_id","type":"integer","args":[],"defaultTo":null,"notNullable":false,"unsigned":true},{"name":"locale","type":"string","args":[],"defaultTo":null,"notNullable":false,"unsigned":false}]},{"name":"strapi_transfer_tokens","indexes":[{"name":"strapi_transfer_tokens_documents_idx","columns":["document_id","locale","published_at"]},{"name":"strapi_transfer_tokens_created_by_id_fk","columns":["created_by_id"]},{"name":"strapi_transfer_tokens_updated_by_id_fk","columns":["updated_by_id"]}],"foreignKeys":[{"name":"strapi_transfer_tokens_created_by_id_fk","columns":["created_by_id"],"referencedTable":"admin_users","referencedColumns":["id"],"onDelete":"SET NULL"},{"name":"strapi_transfer_tokens_updated_by_id_fk","columns":["updated_by_id"],"referencedTable":"admin_users","referencedColumns":["id"],"onDelete":"SET NULL"}],"columns":[{"name":"id","type":"increments","args":[{"primary":true,"primaryKey":true}],"defaultTo":null,"notNullable":true,"unsigned":false},{"name":"document_id","type":"string","args":[],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"name","type":"string","args":[],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"description","type":"string","args":[],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"access_key","type":"string","args":[],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"last_used_at","type":"datetime","args":[{"useTz":false,"precision":6}],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"expires_at","type":"datetime","args":[{"useTz":false,"precision":6}],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"lifespan","type":"bigInteger","args":[],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"created_at","type":"datetime","args":[{"useTz":false,"precision":6}],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"updated_at","type":"datetime","args":[{"useTz":false,"precision":6}],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"published_at","type":"datetime","args":[{"useTz":false,"precision":6}],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"created_by_id","type":"integer","args":[],"defaultTo":null,"notNullable":false,"unsigned":true},{"name":"updated_by_id","type":"integer","args":[],"defaultTo":null,"notNullable":false,"unsigned":true},{"name":"locale","type":"string","args":[],"defaultTo":null,"notNullable":false,"unsigned":false}]},{"name":"strapi_transfer_token_permissions","indexes":[{"name":"strapi_transfer_token_permissions_documents_idx","columns":["document_id","locale","published_at"]},{"name":"strapi_transfer_token_permissions_created_by_id_fk","columns":["created_by_id"]},{"name":"strapi_transfer_token_permissions_updated_by_id_fk","columns":["updated_by_id"]}],"foreignKeys":[{"name":"strapi_transfer_token_permissions_created_by_id_fk","columns":["created_by_id"],"referencedTable":"admin_users","referencedColumns":["id"],"onDelete":"SET NULL"},{"name":"strapi_transfer_token_permissions_updated_by_id_fk","columns":["updated_by_id"],"referencedTable":"admin_users","referencedColumns":["id"],"onDelete":"SET NULL"}],"columns":[{"name":"id","type":"increments","args":[{"primary":true,"primaryKey":true}],"defaultTo":null,"notNullable":true,"unsigned":false},{"name":"document_id","type":"string","args":[],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"action","type":"string","args":[],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"created_at","type":"datetime","args":[{"useTz":false,"precision":6}],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"updated_at","type":"datetime","args":[{"useTz":false,"precision":6}],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"published_at","type":"datetime","args":[{"useTz":false,"precision":6}],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"created_by_id","type":"integer","args":[],"defaultTo":null,"notNullable":false,"unsigned":true},{"name":"updated_by_id","type":"integer","args":[],"defaultTo":null,"notNullable":false,"unsigned":true},{"name":"locale","type":"string","args":[],"defaultTo":null,"notNullable":false,"unsigned":false}]},{"name":"strapi_sessions","indexes":[{"name":"strapi_sessions_documents_idx","columns":["document_id","locale","published_at"]},{"name":"strapi_sessions_created_by_id_fk","columns":["created_by_id"]},{"name":"strapi_sessions_updated_by_id_fk","columns":["updated_by_id"]}],"foreignKeys":[{"name":"strapi_sessions_created_by_id_fk","columns":["created_by_id"],"referencedTable":"admin_users","referencedColumns":["id"],"onDelete":"SET NULL"},{"name":"strapi_sessions_updated_by_id_fk","columns":["updated_by_id"],"referencedTable":"admin_users","referencedColumns":["id"],"onDelete":"SET NULL"}],"columns":[{"name":"id","type":"increments","args":[{"primary":true,"primaryKey":true}],"defaultTo":null,"notNullable":true,"unsigned":false},{"name":"document_id","type":"string","args":[],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"user_id","type":"string","args":[],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"session_id","type":"string","args":[],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"child_id","type":"string","args":[],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"device_id","type":"string","args":[],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"origin","type":"string","args":[],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"expires_at","type":"datetime","args":[{"useTz":false,"precision":6}],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"absolute_expires_at","type":"datetime","args":[{"useTz":false,"precision":6}],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"status","type":"string","args":[],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"type","type":"string","args":[],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"created_at","type":"datetime","args":[{"useTz":false,"precision":6}],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"updated_at","type":"datetime","args":[{"useTz":false,"precision":6}],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"published_at","type":"datetime","args":[{"useTz":false,"precision":6}],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"created_by_id","type":"integer","args":[],"defaultTo":null,"notNullable":false,"unsigned":true},{"name":"updated_by_id","type":"integer","args":[],"defaultTo":null,"notNullable":false,"unsigned":true},{"name":"locale","type":"string","args":[],"defaultTo":null,"notNullable":false,"unsigned":false}]},{"name":"strapi_core_store_settings","indexes":[],"foreignKeys":[],"columns":[{"name":"id","type":"increments","args":[{"primary":true,"primaryKey":true}],"defaultTo":null,"notNullable":true,"unsigned":false},{"name":"key","type":"string","args":[],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"value","type":"text","args":["longtext"],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"type","type":"string","args":[],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"environment","type":"string","args":[],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"tag","type":"string","args":[],"defaultTo":null,"notNullable":false,"unsigned":false}]},{"name":"strapi_webhooks","indexes":[],"foreignKeys":[],"columns":[{"name":"id","type":"increments","args":[{"primary":true,"primaryKey":true}],"defaultTo":null,"notNullable":true,"unsigned":false},{"name":"name","type":"string","args":[],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"url","type":"text","args":["longtext"],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"headers","type":"jsonb","args":[],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"events","type":"jsonb","args":[],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"enabled","type":"boolean","args":[],"defaultTo":null,"notNullable":false,"unsigned":false}]},{"name":"strapi_history_versions","indexes":[{"name":"strapi_history_versions_created_by_id_fk","columns":["created_by_id"]}],"foreignKeys":[{"name":"strapi_history_versions_created_by_id_fk","columns":["created_by_id"],"referencedTable":"admin_users","referencedColumns":["id"],"onDelete":"SET NULL"}],"columns":[{"name":"id","type":"increments","args":[{"primary":true,"primaryKey":true}],"defaultTo":null,"notNullable":true,"unsigned":false},{"name":"content_type","type":"string","args":[],"defaultTo":null,"notNullable":true,"unsigned":false},{"name":"related_document_id","type":"string","args":[],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"locale","type":"string","args":[],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"status","type":"string","args":[],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"data","type":"jsonb","args":[],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"schema","type":"jsonb","args":[],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"created_at","type":"datetime","args":[{"useTz":false,"precision":6}],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"created_by_id","type":"integer","args":[],"defaultTo":null,"notNullable":false,"unsigned":true}]},{"name":"strapi_ai_metadata_jobs","indexes":[],"foreignKeys":[],"columns":[{"name":"id","type":"increments","args":[{"primary":true,"primaryKey":true}],"defaultTo":null,"notNullable":true,"unsigned":false},{"name":"status","type":"string","args":[],"defaultTo":null,"notNullable":true,"unsigned":false},{"name":"created_at","type":"datetime","args":[{"useTz":false,"precision":6}],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"completed_at","type":"datetime","args":[{"useTz":false,"precision":6}],"defaultTo":null,"notNullable":false,"unsigned":false}]},{"name":"strapi_ai_localization_jobs","indexes":[],"foreignKeys":[],"columns":[{"name":"id","type":"increments","args":[{"primary":true,"primaryKey":true}],"defaultTo":null,"notNullable":true,"unsigned":false},{"name":"content_type","type":"string","args":[],"defaultTo":null,"notNullable":true,"unsigned":false},{"name":"related_document_id","type":"string","args":[],"defaultTo":null,"notNullable":true,"unsigned":false},{"name":"source_locale","type":"string","args":[],"defaultTo":null,"notNullable":true,"unsigned":false},{"name":"target_locales","type":"jsonb","args":[],"defaultTo":null,"notNullable":true,"unsigned":false},{"name":"status","type":"string","args":[],"defaultTo":null,"notNullable":true,"unsigned":false},{"name":"created_at","type":"datetime","args":[{"useTz":false,"precision":6}],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"updated_at","type":"datetime","args":[{"useTz":false,"precision":6}],"defaultTo":null,"notNullable":false,"unsigned":false}]},{"name":"files_related_mph","indexes":[{"name":"files_related_mph_fk","columns":["file_id"]},{"name":"files_related_mph_oidx","columns":["order"]},{"name":"files_related_mph_idix","columns":["related_id"]}],"foreignKeys":[{"name":"files_related_mph_fk","columns":["file_id"],"referencedColumns":["id"],"referencedTable":"files","onDelete":"CASCADE"}],"columns":[{"name":"id","type":"increments","args":[{"primary":true,"primaryKey":true}],"defaultTo":null,"notNullable":true,"unsigned":false},{"name":"file_id","type":"integer","args":[],"defaultTo":null,"notNullable":false,"unsigned":true},{"name":"related_id","type":"integer","args":[],"defaultTo":null,"notNullable":false,"unsigned":true},{"name":"related_type","type":"string","args":[],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"field","type":"string","args":[],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"order","type":"double","args":[],"defaultTo":null,"notNullable":false,"unsigned":true}]},{"name":"files_folder_lnk","indexes":[{"name":"files_folder_lnk_fk","columns":["file_id"]},{"name":"files_folder_lnk_ifk","columns":["folder_id"]},{"name":"files_folder_lnk_uq","columns":["file_id","folder_id"],"type":"unique"},{"name":"files_folder_lnk_oifk","columns":["file_ord"]}],"foreignKeys":[{"name":"files_folder_lnk_fk","columns":["file_id"],"referencedColumns":["id"],"referencedTable":"files","onDelete":"CASCADE"},{"name":"files_folder_lnk_ifk","columns":["folder_id"],"referencedColumns":["id"],"referencedTable":"upload_folders","onDelete":"CASCADE"}],"columns":[{"name":"id","type":"increments","args":[{"primary":true,"primaryKey":true}],"defaultTo":null,"notNullable":true,"unsigned":false},{"name":"file_id","type":"integer","args":[],"defaultTo":null,"notNullable":false,"unsigned":true},{"name":"folder_id","type":"integer","args":[],"defaultTo":null,"notNullable":false,"unsigned":true},{"name":"file_ord","type":"double","args":[],"defaultTo":null,"notNullable":false,"unsigned":true}]},{"name":"upload_folders_parent_lnk","indexes":[{"name":"upload_folders_parent_lnk_fk","columns":["folder_id"]},{"name":"upload_folders_parent_lnk_ifk","columns":["inv_folder_id"]},{"name":"upload_folders_parent_lnk_uq","columns":["folder_id","inv_folder_id"],"type":"unique"},{"name":"upload_folders_parent_lnk_oifk","columns":["folder_ord"]}],"foreignKeys":[{"name":"upload_folders_parent_lnk_fk","columns":["folder_id"],"referencedColumns":["id"],"referencedTable":"upload_folders","onDelete":"CASCADE"},{"name":"upload_folders_parent_lnk_ifk","columns":["inv_folder_id"],"referencedColumns":["id"],"referencedTable":"upload_folders","onDelete":"CASCADE"}],"columns":[{"name":"id","type":"increments","args":[{"primary":true,"primaryKey":true}],"defaultTo":null,"notNullable":true,"unsigned":false},{"name":"folder_id","type":"integer","args":[],"defaultTo":null,"notNullable":false,"unsigned":true},{"name":"inv_folder_id","type":"integer","args":[],"defaultTo":null,"notNullable":false,"unsigned":true},{"name":"folder_ord","type":"double","args":[],"defaultTo":null,"notNullable":false,"unsigned":true}]},{"name":"strapi_release_actions_release_lnk","indexes":[{"name":"strapi_release_actions_release_lnk_fk","columns":["release_action_id"]},{"name":"strapi_release_actions_release_lnk_ifk","columns":["release_id"]},{"name":"strapi_release_actions_release_lnk_uq","columns":["release_action_id","release_id"],"type":"unique"},{"name":"strapi_release_actions_release_lnk_oifk","columns":["release_action_ord"]}],"foreignKeys":[{"name":"strapi_release_actions_release_lnk_fk","columns":["release_action_id"],"referencedColumns":["id"],"referencedTable":"strapi_release_actions","onDelete":"CASCADE"},{"name":"strapi_release_actions_release_lnk_ifk","columns":["release_id"],"referencedColumns":["id"],"referencedTable":"strapi_releases","onDelete":"CASCADE"}],"columns":[{"name":"id","type":"increments","args":[{"primary":true,"primaryKey":true}],"defaultTo":null,"notNullable":true,"unsigned":false},{"name":"release_action_id","type":"integer","args":[],"defaultTo":null,"notNullable":false,"unsigned":true},{"name":"release_id","type":"integer","args":[],"defaultTo":null,"notNullable":false,"unsigned":true},{"name":"release_action_ord","type":"double","args":[],"defaultTo":null,"notNullable":false,"unsigned":true}]},{"name":"strapi_workflows_stage_required_to_publish_lnk","indexes":[{"name":"strapi_workflows_stage_required_to_publish_lnk_fk","columns":["workflow_id"]},{"name":"strapi_workflows_stage_required_to_publish_lnk_ifk","columns":["workflow_stage_id"]},{"name":"strapi_workflows_stage_required_to_publish_lnk_uq","columns":["workflow_id","workflow_stage_id"],"type":"unique"}],"foreignKeys":[{"name":"strapi_workflows_stage_required_to_publish_lnk_fk","columns":["workflow_id"],"referencedColumns":["id"],"referencedTable":"strapi_workflows","onDelete":"CASCADE"},{"name":"strapi_workflows_stage_required_to_publish_lnk_ifk","columns":["workflow_stage_id"],"referencedColumns":["id"],"referencedTable":"strapi_workflows_stages","onDelete":"CASCADE"}],"columns":[{"name":"id","type":"increments","args":[{"primary":true,"primaryKey":true}],"defaultTo":null,"notNullable":true,"unsigned":false},{"name":"workflow_id","type":"integer","args":[],"defaultTo":null,"notNullable":false,"unsigned":true},{"name":"workflow_stage_id","type":"integer","args":[],"defaultTo":null,"notNullable":false,"unsigned":true}]},{"name":"strapi_workflows_stages_workflow_lnk","indexes":[{"name":"strapi_workflows_stages_workflow_lnk_fk","columns":["workflow_stage_id"]},{"name":"strapi_workflows_stages_workflow_lnk_ifk","columns":["workflow_id"]},{"name":"strapi_workflows_stages_workflow_lnk_uq","columns":["workflow_stage_id","workflow_id"],"type":"unique"},{"name":"strapi_workflows_stages_workflow_lnk_oifk","columns":["workflow_stage_ord"]}],"foreignKeys":[{"name":"strapi_workflows_stages_workflow_lnk_fk","columns":["workflow_stage_id"],"referencedColumns":["id"],"referencedTable":"strapi_workflows_stages","onDelete":"CASCADE"},{"name":"strapi_workflows_stages_workflow_lnk_ifk","columns":["workflow_id"],"referencedColumns":["id"],"referencedTable":"strapi_workflows","onDelete":"CASCADE"}],"columns":[{"name":"id","type":"increments","args":[{"primary":true,"primaryKey":true}],"defaultTo":null,"notNullable":true,"unsigned":false},{"name":"workflow_stage_id","type":"integer","args":[],"defaultTo":null,"notNullable":false,"unsigned":true},{"name":"workflow_id","type":"integer","args":[],"defaultTo":null,"notNullable":false,"unsigned":true},{"name":"workflow_stage_ord","type":"double","args":[],"defaultTo":null,"notNullable":false,"unsigned":true}]},{"name":"strapi_workflows_stages_permissions_lnk","indexes":[{"name":"strapi_workflows_stages_permissions_lnk_fk","columns":["workflow_stage_id"]},{"name":"strapi_workflows_stages_permissions_lnk_ifk","columns":["permission_id"]},{"name":"strapi_workflows_stages_permissions_lnk_uq","columns":["workflow_stage_id","permission_id"],"type":"unique"},{"name":"strapi_workflows_stages_permissions_lnk_ofk","columns":["permission_ord"]}],"foreignKeys":[{"name":"strapi_workflows_stages_permissions_lnk_fk","columns":["workflow_stage_id"],"referencedColumns":["id"],"referencedTable":"strapi_workflows_stages","onDelete":"CASCADE"},{"name":"strapi_workflows_stages_permissions_lnk_ifk","columns":["permission_id"],"referencedColumns":["id"],"referencedTable":"admin_permissions","onDelete":"CASCADE"}],"columns":[{"name":"id","type":"increments","args":[{"primary":true,"primaryKey":true}],"defaultTo":null,"notNullable":true,"unsigned":false},{"name":"workflow_stage_id","type":"integer","args":[],"defaultTo":null,"notNullable":false,"unsigned":true},{"name":"permission_id","type":"integer","args":[],"defaultTo":null,"notNullable":false,"unsigned":true},{"name":"permission_ord","type":"double","args":[],"defaultTo":null,"notNullable":false,"unsigned":true}]},{"name":"up_permissions_role_lnk","indexes":[{"name":"up_permissions_role_lnk_fk","columns":["permission_id"]},{"name":"up_permissions_role_lnk_ifk","columns":["role_id"]},{"name":"up_permissions_role_lnk_uq","columns":["permission_id","role_id"],"type":"unique"},{"name":"up_permissions_role_lnk_oifk","columns":["permission_ord"]}],"foreignKeys":[{"name":"up_permissions_role_lnk_fk","columns":["permission_id"],"referencedColumns":["id"],"referencedTable":"up_permissions","onDelete":"CASCADE"},{"name":"up_permissions_role_lnk_ifk","columns":["role_id"],"referencedColumns":["id"],"referencedTable":"up_roles","onDelete":"CASCADE"}],"columns":[{"name":"id","type":"increments","args":[{"primary":true,"primaryKey":true}],"defaultTo":null,"notNullable":true,"unsigned":false},{"name":"permission_id","type":"integer","args":[],"defaultTo":null,"notNullable":false,"unsigned":true},{"name":"role_id","type":"integer","args":[],"defaultTo":null,"notNullable":false,"unsigned":true},{"name":"permission_ord","type":"double","args":[],"defaultTo":null,"notNullable":false,"unsigned":true}]},{"name":"bookings_user_lnk","indexes":[{"name":"bookings_user_lnk_fk","columns":["booking_id"]},{"name":"bookings_user_lnk_ifk","columns":["user_id"]},{"name":"bookings_user_lnk_uq","columns":["booking_id","user_id"],"type":"unique"},{"name":"bookings_user_lnk_oifk","columns":["booking_ord"]}],"foreignKeys":[{"name":"bookings_user_lnk_fk","columns":["booking_id"],"referencedColumns":["id"],"referencedTable":"bookings","onDelete":"CASCADE"},{"name":"bookings_user_lnk_ifk","columns":["user_id"],"referencedColumns":["id"],"referencedTable":"up_users","onDelete":"CASCADE"}],"columns":[{"name":"id","type":"increments","args":[{"primary":true,"primaryKey":true}],"defaultTo":null,"notNullable":true,"unsigned":false},{"name":"booking_id","type":"integer","args":[],"defaultTo":null,"notNullable":false,"unsigned":true},{"name":"user_id","type":"integer","args":[],"defaultTo":null,"notNullable":false,"unsigned":true},{"name":"booking_ord","type":"double","args":[],"defaultTo":null,"notNullable":false,"unsigned":true}]},{"name":"bookings_service_lnk","indexes":[{"name":"bookings_service_lnk_fk","columns":["booking_id"]},{"name":"bookings_service_lnk_ifk","columns":["service_id"]},{"name":"bookings_service_lnk_uq","columns":["booking_id","service_id"],"type":"unique"},{"name":"bookings_service_lnk_oifk","columns":["booking_ord"]}],"foreignKeys":[{"name":"bookings_service_lnk_fk","columns":["booking_id"],"referencedColumns":["id"],"referencedTable":"bookings","onDelete":"CASCADE"},{"name":"bookings_service_lnk_ifk","columns":["service_id"],"referencedColumns":["id"],"referencedTable":"services","onDelete":"CASCADE"}],"columns":[{"name":"id","type":"increments","args":[{"primary":true,"primaryKey":true}],"defaultTo":null,"notNullable":true,"unsigned":false},{"name":"booking_id","type":"integer","args":[],"defaultTo":null,"notNullable":false,"unsigned":true},{"name":"service_id","type":"integer","args":[],"defaultTo":null,"notNullable":false,"unsigned":true},{"name":"booking_ord","type":"double","args":[],"defaultTo":null,"notNullable":false,"unsigned":true}]},{"name":"cart_items_user_lnk","indexes":[{"name":"cart_items_user_lnk_fk","columns":["cart_item_id"]},{"name":"cart_items_user_lnk_ifk","columns":["user_id"]},{"name":"cart_items_user_lnk_uq","columns":["cart_item_id","user_id"],"type":"unique"},{"name":"cart_items_user_lnk_oifk","columns":["cart_item_ord"]}],"foreignKeys":[{"name":"cart_items_user_lnk_fk","columns":["cart_item_id"],"referencedColumns":["id"],"referencedTable":"cart_items","onDelete":"CASCADE"},{"name":"cart_items_user_lnk_ifk","columns":["user_id"],"referencedColumns":["id"],"referencedTable":"up_users","onDelete":"CASCADE"}],"columns":[{"name":"id","type":"increments","args":[{"primary":true,"primaryKey":true}],"defaultTo":null,"notNullable":true,"unsigned":false},{"name":"cart_item_id","type":"integer","args":[],"defaultTo":null,"notNullable":false,"unsigned":true},{"name":"user_id","type":"integer","args":[],"defaultTo":null,"notNullable":false,"unsigned":true},{"name":"cart_item_ord","type":"double","args":[],"defaultTo":null,"notNullable":false,"unsigned":true}]},{"name":"cart_items_product_lnk","indexes":[{"name":"cart_items_product_lnk_fk","columns":["cart_item_id"]},{"name":"cart_items_product_lnk_ifk","columns":["product_id"]},{"name":"cart_items_product_lnk_uq","columns":["cart_item_id","product_id"],"type":"unique"},{"name":"cart_items_product_lnk_oifk","columns":["cart_item_ord"]}],"foreignKeys":[{"name":"cart_items_product_lnk_fk","columns":["cart_item_id"],"referencedColumns":["id"],"referencedTable":"cart_items","onDelete":"CASCADE"},{"name":"cart_items_product_lnk_ifk","columns":["product_id"],"referencedColumns":["id"],"referencedTable":"products","onDelete":"CASCADE"}],"columns":[{"name":"id","type":"increments","args":[{"primary":true,"primaryKey":true}],"defaultTo":null,"notNullable":true,"unsigned":false},{"name":"cart_item_id","type":"integer","args":[],"defaultTo":null,"notNullable":false,"unsigned":true},{"name":"product_id","type":"integer","args":[],"defaultTo":null,"notNullable":false,"unsigned":true},{"name":"cart_item_ord","type":"double","args":[],"defaultTo":null,"notNullable":false,"unsigned":true}]},{"name":"coupon_usages_coupon_lnk","indexes":[{"name":"coupon_usages_coupon_lnk_fk","columns":["coupon_usage_id"]},{"name":"coupon_usages_coupon_lnk_ifk","columns":["coupon_code_id"]},{"name":"coupon_usages_coupon_lnk_uq","columns":["coupon_usage_id","coupon_code_id"],"type":"unique"},{"name":"coupon_usages_coupon_lnk_oifk","columns":["coupon_usage_ord"]}],"foreignKeys":[{"name":"coupon_usages_coupon_lnk_fk","columns":["coupon_usage_id"],"referencedColumns":["id"],"referencedTable":"coupon_usages","onDelete":"CASCADE"},{"name":"coupon_usages_coupon_lnk_ifk","columns":["coupon_code_id"],"referencedColumns":["id"],"referencedTable":"coupon_codes","onDelete":"CASCADE"}],"columns":[{"name":"id","type":"increments","args":[{"primary":true,"primaryKey":true}],"defaultTo":null,"notNullable":true,"unsigned":false},{"name":"coupon_usage_id","type":"integer","args":[],"defaultTo":null,"notNullable":false,"unsigned":true},{"name":"coupon_code_id","type":"integer","args":[],"defaultTo":null,"notNullable":false,"unsigned":true},{"name":"coupon_usage_ord","type":"double","args":[],"defaultTo":null,"notNullable":false,"unsigned":true}]},{"name":"coupon_usages_user_lnk","indexes":[{"name":"coupon_usages_user_lnk_fk","columns":["coupon_usage_id"]},{"name":"coupon_usages_user_lnk_ifk","columns":["user_id"]},{"name":"coupon_usages_user_lnk_uq","columns":["coupon_usage_id","user_id"],"type":"unique"},{"name":"coupon_usages_user_lnk_oifk","columns":["coupon_usage_ord"]}],"foreignKeys":[{"name":"coupon_usages_user_lnk_fk","columns":["coupon_usage_id"],"referencedColumns":["id"],"referencedTable":"coupon_usages","onDelete":"CASCADE"},{"name":"coupon_usages_user_lnk_ifk","columns":["user_id"],"referencedColumns":["id"],"referencedTable":"up_users","onDelete":"CASCADE"}],"columns":[{"name":"id","type":"increments","args":[{"primary":true,"primaryKey":true}],"defaultTo":null,"notNullable":true,"unsigned":false},{"name":"coupon_usage_id","type":"integer","args":[],"defaultTo":null,"notNullable":false,"unsigned":true},{"name":"user_id","type":"integer","args":[],"defaultTo":null,"notNullable":false,"unsigned":true},{"name":"coupon_usage_ord","type":"double","args":[],"defaultTo":null,"notNullable":false,"unsigned":true}]},{"name":"coupon_usages_order_lnk","indexes":[{"name":"coupon_usages_order_lnk_fk","columns":["coupon_usage_id"]},{"name":"coupon_usages_order_lnk_ifk","columns":["order_id"]},{"name":"coupon_usages_order_lnk_uq","columns":["coupon_usage_id","order_id"],"type":"unique"},{"name":"coupon_usages_order_lnk_oifk","columns":["coupon_usage_ord"]}],"foreignKeys":[{"name":"coupon_usages_order_lnk_fk","columns":["coupon_usage_id"],"referencedColumns":["id"],"referencedTable":"coupon_usages","onDelete":"CASCADE"},{"name":"coupon_usages_order_lnk_ifk","columns":["order_id"],"referencedColumns":["id"],"referencedTable":"orders","onDelete":"CASCADE"}],"columns":[{"name":"id","type":"increments","args":[{"primary":true,"primaryKey":true}],"defaultTo":null,"notNullable":true,"unsigned":false},{"name":"coupon_usage_id","type":"integer","args":[],"defaultTo":null,"notNullable":false,"unsigned":true},{"name":"order_id","type":"integer","args":[],"defaultTo":null,"notNullable":false,"unsigned":true},{"name":"coupon_usage_ord","type":"double","args":[],"defaultTo":null,"notNullable":false,"unsigned":true}]},{"name":"digital_assets_product_lnk","indexes":[{"name":"digital_assets_product_lnk_fk","columns":["digital_asset_id"]},{"name":"digital_assets_product_lnk_ifk","columns":["product_id"]},{"name":"digital_assets_product_lnk_uq","columns":["digital_asset_id","product_id"],"type":"unique"},{"name":"digital_assets_product_lnk_oifk","columns":["digital_asset_ord"]}],"foreignKeys":[{"name":"digital_assets_product_lnk_fk","columns":["digital_asset_id"],"referencedColumns":["id"],"referencedTable":"digital_assets","onDelete":"CASCADE"},{"name":"digital_assets_product_lnk_ifk","columns":["product_id"],"referencedColumns":["id"],"referencedTable":"products","onDelete":"CASCADE"}],"columns":[{"name":"id","type":"increments","args":[{"primary":true,"primaryKey":true}],"defaultTo":null,"notNullable":true,"unsigned":false},{"name":"digital_asset_id","type":"integer","args":[],"defaultTo":null,"notNullable":false,"unsigned":true},{"name":"product_id","type":"integer","args":[],"defaultTo":null,"notNullable":false,"unsigned":true},{"name":"digital_asset_ord","type":"double","args":[],"defaultTo":null,"notNullable":false,"unsigned":true}]},{"name":"digital_purchases_user_lnk","indexes":[{"name":"digital_purchases_user_lnk_fk","columns":["digital_purchase_id"]},{"name":"digital_purchases_user_lnk_ifk","columns":["user_id"]},{"name":"digital_purchases_user_lnk_uq","columns":["digital_purchase_id","user_id"],"type":"unique"},{"name":"digital_purchases_user_lnk_oifk","columns":["digital_purchase_ord"]}],"foreignKeys":[{"name":"digital_purchases_user_lnk_fk","columns":["digital_purchase_id"],"referencedColumns":["id"],"referencedTable":"digital_purchases","onDelete":"CASCADE"},{"name":"digital_purchases_user_lnk_ifk","columns":["user_id"],"referencedColumns":["id"],"referencedTable":"up_users","onDelete":"CASCADE"}],"columns":[{"name":"id","type":"increments","args":[{"primary":true,"primaryKey":true}],"defaultTo":null,"notNullable":true,"unsigned":false},{"name":"digital_purchase_id","type":"integer","args":[],"defaultTo":null,"notNullable":false,"unsigned":true},{"name":"user_id","type":"integer","args":[],"defaultTo":null,"notNullable":false,"unsigned":true},{"name":"digital_purchase_ord","type":"double","args":[],"defaultTo":null,"notNullable":false,"unsigned":true}]},{"name":"digital_purchases_order_lnk","indexes":[{"name":"digital_purchases_order_lnk_fk","columns":["digital_purchase_id"]},{"name":"digital_purchases_order_lnk_ifk","columns":["order_id"]},{"name":"digital_purchases_order_lnk_uq","columns":["digital_purchase_id","order_id"],"type":"unique"},{"name":"digital_purchases_order_lnk_oifk","columns":["digital_purchase_ord"]}],"foreignKeys":[{"name":"digital_purchases_order_lnk_fk","columns":["digital_purchase_id"],"referencedColumns":["id"],"referencedTable":"digital_purchases","onDelete":"CASCADE"},{"name":"digital_purchases_order_lnk_ifk","columns":["order_id"],"referencedColumns":["id"],"referencedTable":"orders","onDelete":"CASCADE"}],"columns":[{"name":"id","type":"increments","args":[{"primary":true,"primaryKey":true}],"defaultTo":null,"notNullable":true,"unsigned":false},{"name":"digital_purchase_id","type":"integer","args":[],"defaultTo":null,"notNullable":false,"unsigned":true},{"name":"order_id","type":"integer","args":[],"defaultTo":null,"notNullable":false,"unsigned":true},{"name":"digital_purchase_ord","type":"double","args":[],"defaultTo":null,"notNullable":false,"unsigned":true}]},{"name":"digital_purchases_product_lnk","indexes":[{"name":"digital_purchases_product_lnk_fk","columns":["digital_purchase_id"]},{"name":"digital_purchases_product_lnk_ifk","columns":["product_id"]},{"name":"digital_purchases_product_lnk_uq","columns":["digital_purchase_id","product_id"],"type":"unique"},{"name":"digital_purchases_product_lnk_oifk","columns":["digital_purchase_ord"]}],"foreignKeys":[{"name":"digital_purchases_product_lnk_fk","columns":["digital_purchase_id"],"referencedColumns":["id"],"referencedTable":"digital_purchases","onDelete":"CASCADE"},{"name":"digital_purchases_product_lnk_ifk","columns":["product_id"],"referencedColumns":["id"],"referencedTable":"products","onDelete":"CASCADE"}],"columns":[{"name":"id","type":"increments","args":[{"primary":true,"primaryKey":true}],"defaultTo":null,"notNullable":true,"unsigned":false},{"name":"digital_purchase_id","type":"integer","args":[],"defaultTo":null,"notNullable":false,"unsigned":true},{"name":"product_id","type":"integer","args":[],"defaultTo":null,"notNullable":false,"unsigned":true},{"name":"digital_purchase_ord","type":"double","args":[],"defaultTo":null,"notNullable":false,"unsigned":true}]},{"name":"digital_purchases_asset_lnk","indexes":[{"name":"digital_purchases_asset_lnk_fk","columns":["digital_purchase_id"]},{"name":"digital_purchases_asset_lnk_ifk","columns":["digital_asset_id"]},{"name":"digital_purchases_asset_lnk_uq","columns":["digital_purchase_id","digital_asset_id"],"type":"unique"},{"name":"digital_purchases_asset_lnk_oifk","columns":["digital_purchase_ord"]}],"foreignKeys":[{"name":"digital_purchases_asset_lnk_fk","columns":["digital_purchase_id"],"referencedColumns":["id"],"referencedTable":"digital_purchases","onDelete":"CASCADE"},{"name":"digital_purchases_asset_lnk_ifk","columns":["digital_asset_id"],"referencedColumns":["id"],"referencedTable":"digital_assets","onDelete":"CASCADE"}],"columns":[{"name":"id","type":"increments","args":[{"primary":true,"primaryKey":true}],"defaultTo":null,"notNullable":true,"unsigned":false},{"name":"digital_purchase_id","type":"integer","args":[],"defaultTo":null,"notNullable":false,"unsigned":true},{"name":"digital_asset_id","type":"integer","args":[],"defaultTo":null,"notNullable":false,"unsigned":true},{"name":"digital_purchase_ord","type":"double","args":[],"defaultTo":null,"notNullable":false,"unsigned":true}]},{"name":"invoices_order_lnk","indexes":[{"name":"invoices_order_lnk_fk","columns":["invoice_id"]},{"name":"invoices_order_lnk_ifk","columns":["order_id"]},{"name":"invoices_order_lnk_uq","columns":["invoice_id","order_id"],"type":"unique"}],"foreignKeys":[{"name":"invoices_order_lnk_fk","columns":["invoice_id"],"referencedColumns":["id"],"referencedTable":"invoices","onDelete":"CASCADE"},{"name":"invoices_order_lnk_ifk","columns":["order_id"],"referencedColumns":["id"],"referencedTable":"orders","onDelete":"CASCADE"}],"columns":[{"name":"id","type":"increments","args":[{"primary":true,"primaryKey":true}],"defaultTo":null,"notNullable":true,"unsigned":false},{"name":"invoice_id","type":"integer","args":[],"defaultTo":null,"notNullable":false,"unsigned":true},{"name":"order_id","type":"integer","args":[],"defaultTo":null,"notNullable":false,"unsigned":true}]},{"name":"orders_user_lnk","indexes":[{"name":"orders_user_lnk_fk","columns":["order_id"]},{"name":"orders_user_lnk_ifk","columns":["user_id"]},{"name":"orders_user_lnk_uq","columns":["order_id","user_id"],"type":"unique"},{"name":"orders_user_lnk_oifk","columns":["order_ord"]}],"foreignKeys":[{"name":"orders_user_lnk_fk","columns":["order_id"],"referencedColumns":["id"],"referencedTable":"orders","onDelete":"CASCADE"},{"name":"orders_user_lnk_ifk","columns":["user_id"],"referencedColumns":["id"],"referencedTable":"up_users","onDelete":"CASCADE"}],"columns":[{"name":"id","type":"increments","args":[{"primary":true,"primaryKey":true}],"defaultTo":null,"notNullable":true,"unsigned":false},{"name":"order_id","type":"integer","args":[],"defaultTo":null,"notNullable":false,"unsigned":true},{"name":"user_id","type":"integer","args":[],"defaultTo":null,"notNullable":false,"unsigned":true},{"name":"order_ord","type":"double","args":[],"defaultTo":null,"notNullable":false,"unsigned":true}]},{"name":"orders_coupon_lnk","indexes":[{"name":"orders_coupon_lnk_fk","columns":["order_id"]},{"name":"orders_coupon_lnk_ifk","columns":["coupon_code_id"]},{"name":"orders_coupon_lnk_uq","columns":["order_id","coupon_code_id"],"type":"unique"},{"name":"orders_coupon_lnk_oifk","columns":["order_ord"]}],"foreignKeys":[{"name":"orders_coupon_lnk_fk","columns":["order_id"],"referencedColumns":["id"],"referencedTable":"orders","onDelete":"CASCADE"},{"name":"orders_coupon_lnk_ifk","columns":["coupon_code_id"],"referencedColumns":["id"],"referencedTable":"coupon_codes","onDelete":"CASCADE"}],"columns":[{"name":"id","type":"increments","args":[{"primary":true,"primaryKey":true}],"defaultTo":null,"notNullable":true,"unsigned":false},{"name":"order_id","type":"integer","args":[],"defaultTo":null,"notNullable":false,"unsigned":true},{"name":"coupon_code_id","type":"integer","args":[],"defaultTo":null,"notNullable":false,"unsigned":true},{"name":"order_ord","type":"double","args":[],"defaultTo":null,"notNullable":false,"unsigned":true}]},{"name":"order_items_order_lnk","indexes":[{"name":"order_items_order_lnk_fk","columns":["order_item_id"]},{"name":"order_items_order_lnk_ifk","columns":["order_id"]},{"name":"order_items_order_lnk_uq","columns":["order_item_id","order_id"],"type":"unique"},{"name":"order_items_order_lnk_oifk","columns":["order_item_ord"]}],"foreignKeys":[{"name":"order_items_order_lnk_fk","columns":["order_item_id"],"referencedColumns":["id"],"referencedTable":"order_items","onDelete":"CASCADE"},{"name":"order_items_order_lnk_ifk","columns":["order_id"],"referencedColumns":["id"],"referencedTable":"orders","onDelete":"CASCADE"}],"columns":[{"name":"id","type":"increments","args":[{"primary":true,"primaryKey":true}],"defaultTo":null,"notNullable":true,"unsigned":false},{"name":"order_item_id","type":"integer","args":[],"defaultTo":null,"notNullable":false,"unsigned":true},{"name":"order_id","type":"integer","args":[],"defaultTo":null,"notNullable":false,"unsigned":true},{"name":"order_item_ord","type":"double","args":[],"defaultTo":null,"notNullable":false,"unsigned":true}]},{"name":"order_items_product_lnk","indexes":[{"name":"order_items_product_lnk_fk","columns":["order_item_id"]},{"name":"order_items_product_lnk_ifk","columns":["product_id"]},{"name":"order_items_product_lnk_uq","columns":["order_item_id","product_id"],"type":"unique"},{"name":"order_items_product_lnk_oifk","columns":["order_item_ord"]}],"foreignKeys":[{"name":"order_items_product_lnk_fk","columns":["order_item_id"],"referencedColumns":["id"],"referencedTable":"order_items","onDelete":"CASCADE"},{"name":"order_items_product_lnk_ifk","columns":["product_id"],"referencedColumns":["id"],"referencedTable":"products","onDelete":"CASCADE"}],"columns":[{"name":"id","type":"increments","args":[{"primary":true,"primaryKey":true}],"defaultTo":null,"notNullable":true,"unsigned":false},{"name":"order_item_id","type":"integer","args":[],"defaultTo":null,"notNullable":false,"unsigned":true},{"name":"product_id","type":"integer","args":[],"defaultTo":null,"notNullable":false,"unsigned":true},{"name":"order_item_ord","type":"double","args":[],"defaultTo":null,"notNullable":false,"unsigned":true}]},{"name":"order_shipments_order_lnk","indexes":[{"name":"order_shipments_order_lnk_fk","columns":["order_shipment_id"]},{"name":"order_shipments_order_lnk_ifk","columns":["order_id"]},{"name":"order_shipments_order_lnk_uq","columns":["order_shipment_id","order_id"],"type":"unique"}],"foreignKeys":[{"name":"order_shipments_order_lnk_fk","columns":["order_shipment_id"],"referencedColumns":["id"],"referencedTable":"order_shipments","onDelete":"CASCADE"},{"name":"order_shipments_order_lnk_ifk","columns":["order_id"],"referencedColumns":["id"],"referencedTable":"orders","onDelete":"CASCADE"}],"columns":[{"name":"id","type":"increments","args":[{"primary":true,"primaryKey":true}],"defaultTo":null,"notNullable":true,"unsigned":false},{"name":"order_shipment_id","type":"integer","args":[],"defaultTo":null,"notNullable":false,"unsigned":true},{"name":"order_id","type":"integer","args":[],"defaultTo":null,"notNullable":false,"unsigned":true}]},{"name":"password_reset_tokens_user_lnk","indexes":[{"name":"password_reset_tokens_user_lnk_fk","columns":["password_reset_token_id"]},{"name":"password_reset_tokens_user_lnk_ifk","columns":["user_id"]},{"name":"password_reset_tokens_user_lnk_uq","columns":["password_reset_token_id","user_id"],"type":"unique"},{"name":"password_reset_tokens_user_lnk_oifk","columns":["password_reset_token_ord"]}],"foreignKeys":[{"name":"password_reset_tokens_user_lnk_fk","columns":["password_reset_token_id"],"referencedColumns":["id"],"referencedTable":"password_reset_tokens","onDelete":"CASCADE"},{"name":"password_reset_tokens_user_lnk_ifk","columns":["user_id"],"referencedColumns":["id"],"referencedTable":"up_users","onDelete":"CASCADE"}],"columns":[{"name":"id","type":"increments","args":[{"primary":true,"primaryKey":true}],"defaultTo":null,"notNullable":true,"unsigned":false},{"name":"password_reset_token_id","type":"integer","args":[],"defaultTo":null,"notNullable":false,"unsigned":true},{"name":"user_id","type":"integer","args":[],"defaultTo":null,"notNullable":false,"unsigned":true},{"name":"password_reset_token_ord","type":"double","args":[],"defaultTo":null,"notNullable":false,"unsigned":true}]},{"name":"products_category_lnk","indexes":[{"name":"products_category_lnk_fk","columns":["product_id"]},{"name":"products_category_lnk_ifk","columns":["product_category_id"]},{"name":"products_category_lnk_uq","columns":["product_id","product_category_id"],"type":"unique"},{"name":"products_category_lnk_oifk","columns":["product_ord"]}],"foreignKeys":[{"name":"products_category_lnk_fk","columns":["product_id"],"referencedColumns":["id"],"referencedTable":"products","onDelete":"CASCADE"},{"name":"products_category_lnk_ifk","columns":["product_category_id"],"referencedColumns":["id"],"referencedTable":"product_categories","onDelete":"CASCADE"}],"columns":[{"name":"id","type":"increments","args":[{"primary":true,"primaryKey":true}],"defaultTo":null,"notNullable":true,"unsigned":false},{"name":"product_id","type":"integer","args":[],"defaultTo":null,"notNullable":false,"unsigned":true},{"name":"product_category_id","type":"integer","args":[],"defaultTo":null,"notNullable":false,"unsigned":true},{"name":"product_ord","type":"double","args":[],"defaultTo":null,"notNullable":false,"unsigned":true}]},{"name":"products_shipping_class_lnk","indexes":[{"name":"products_shipping_class_lnk_fk","columns":["product_id"]},{"name":"products_shipping_class_lnk_ifk","columns":["shipping_class_id"]},{"name":"products_shipping_class_lnk_uq","columns":["product_id","shipping_class_id"],"type":"unique"},{"name":"products_shipping_class_lnk_oifk","columns":["product_ord"]}],"foreignKeys":[{"name":"products_shipping_class_lnk_fk","columns":["product_id"],"referencedColumns":["id"],"referencedTable":"products","onDelete":"CASCADE"},{"name":"products_shipping_class_lnk_ifk","columns":["shipping_class_id"],"referencedColumns":["id"],"referencedTable":"shipping_classes","onDelete":"CASCADE"}],"columns":[{"name":"id","type":"increments","args":[{"primary":true,"primaryKey":true}],"defaultTo":null,"notNullable":true,"unsigned":false},{"name":"product_id","type":"integer","args":[],"defaultTo":null,"notNullable":false,"unsigned":true},{"name":"shipping_class_id","type":"integer","args":[],"defaultTo":null,"notNullable":false,"unsigned":true},{"name":"product_ord","type":"double","args":[],"defaultTo":null,"notNullable":false,"unsigned":true}]},{"name":"product_variants_product_lnk","indexes":[{"name":"product_variants_product_lnk_fk","columns":["product_variant_id"]},{"name":"product_variants_product_lnk_ifk","columns":["product_id"]},{"name":"product_variants_product_lnk_uq","columns":["product_variant_id","product_id"],"type":"unique"},{"name":"product_variants_product_lnk_oifk","columns":["product_variant_ord"]}],"foreignKeys":[{"name":"product_variants_product_lnk_fk","columns":["product_variant_id"],"referencedColumns":["id"],"referencedTable":"product_variants","onDelete":"CASCADE"},{"name":"product_variants_product_lnk_ifk","columns":["product_id"],"referencedColumns":["id"],"referencedTable":"products","onDelete":"CASCADE"}],"columns":[{"name":"id","type":"increments","args":[{"primary":true,"primaryKey":true}],"defaultTo":null,"notNullable":true,"unsigned":false},{"name":"product_variant_id","type":"integer","args":[],"defaultTo":null,"notNullable":false,"unsigned":true},{"name":"product_id","type":"integer","args":[],"defaultTo":null,"notNullable":false,"unsigned":true},{"name":"product_variant_ord","type":"double","args":[],"defaultTo":null,"notNullable":false,"unsigned":true}]},{"name":"reviews_user_lnk","indexes":[{"name":"reviews_user_lnk_fk","columns":["review_id"]},{"name":"reviews_user_lnk_ifk","columns":["user_id"]},{"name":"reviews_user_lnk_uq","columns":["review_id","user_id"],"type":"unique"},{"name":"reviews_user_lnk_oifk","columns":["review_ord"]}],"foreignKeys":[{"name":"reviews_user_lnk_fk","columns":["review_id"],"referencedColumns":["id"],"referencedTable":"reviews","onDelete":"CASCADE"},{"name":"reviews_user_lnk_ifk","columns":["user_id"],"referencedColumns":["id"],"referencedTable":"up_users","onDelete":"CASCADE"}],"columns":[{"name":"id","type":"increments","args":[{"primary":true,"primaryKey":true}],"defaultTo":null,"notNullable":true,"unsigned":false},{"name":"review_id","type":"integer","args":[],"defaultTo":null,"notNullable":false,"unsigned":true},{"name":"user_id","type":"integer","args":[],"defaultTo":null,"notNullable":false,"unsigned":true},{"name":"review_ord","type":"double","args":[],"defaultTo":null,"notNullable":false,"unsigned":true}]},{"name":"reviews_product_lnk","indexes":[{"name":"reviews_product_lnk_fk","columns":["review_id"]},{"name":"reviews_product_lnk_ifk","columns":["product_id"]},{"name":"reviews_product_lnk_uq","columns":["review_id","product_id"],"type":"unique"},{"name":"reviews_product_lnk_oifk","columns":["review_ord"]}],"foreignKeys":[{"name":"reviews_product_lnk_fk","columns":["review_id"],"referencedColumns":["id"],"referencedTable":"reviews","onDelete":"CASCADE"},{"name":"reviews_product_lnk_ifk","columns":["product_id"],"referencedColumns":["id"],"referencedTable":"products","onDelete":"CASCADE"}],"columns":[{"name":"id","type":"increments","args":[{"primary":true,"primaryKey":true}],"defaultTo":null,"notNullable":true,"unsigned":false},{"name":"review_id","type":"integer","args":[],"defaultTo":null,"notNullable":false,"unsigned":true},{"name":"product_id","type":"integer","args":[],"defaultTo":null,"notNullable":false,"unsigned":true},{"name":"review_ord","type":"double","args":[],"defaultTo":null,"notNullable":false,"unsigned":true}]},{"name":"scheduled_reminders_booking_lnk","indexes":[{"name":"scheduled_reminders_booking_lnk_fk","columns":["scheduled_reminder_id"]},{"name":"scheduled_reminders_booking_lnk_ifk","columns":["booking_id"]},{"name":"scheduled_reminders_booking_lnk_uq","columns":["scheduled_reminder_id","booking_id"],"type":"unique"},{"name":"scheduled_reminders_booking_lnk_oifk","columns":["scheduled_reminder_ord"]}],"foreignKeys":[{"name":"scheduled_reminders_booking_lnk_fk","columns":["scheduled_reminder_id"],"referencedColumns":["id"],"referencedTable":"scheduled_reminders","onDelete":"CASCADE"},{"name":"scheduled_reminders_booking_lnk_ifk","columns":["booking_id"],"referencedColumns":["id"],"referencedTable":"bookings","onDelete":"CASCADE"}],"columns":[{"name":"id","type":"increments","args":[{"primary":true,"primaryKey":true}],"defaultTo":null,"notNullable":true,"unsigned":false},{"name":"scheduled_reminder_id","type":"integer","args":[],"defaultTo":null,"notNullable":false,"unsigned":true},{"name":"booking_id","type":"integer","args":[],"defaultTo":null,"notNullable":false,"unsigned":true},{"name":"scheduled_reminder_ord","type":"double","args":[],"defaultTo":null,"notNullable":false,"unsigned":true}]},{"name":"wishlist_items_user_lnk","indexes":[{"name":"wishlist_items_user_lnk_fk","columns":["wishlist_item_id"]},{"name":"wishlist_items_user_lnk_ifk","columns":["user_id"]},{"name":"wishlist_items_user_lnk_uq","columns":["wishlist_item_id","user_id"],"type":"unique"},{"name":"wishlist_items_user_lnk_oifk","columns":["wishlist_item_ord"]}],"foreignKeys":[{"name":"wishlist_items_user_lnk_fk","columns":["wishlist_item_id"],"referencedColumns":["id"],"referencedTable":"wishlist_items","onDelete":"CASCADE"},{"name":"wishlist_items_user_lnk_ifk","columns":["user_id"],"referencedColumns":["id"],"referencedTable":"up_users","onDelete":"CASCADE"}],"columns":[{"name":"id","type":"increments","args":[{"primary":true,"primaryKey":true}],"defaultTo":null,"notNullable":true,"unsigned":false},{"name":"wishlist_item_id","type":"integer","args":[],"defaultTo":null,"notNullable":false,"unsigned":true},{"name":"user_id","type":"integer","args":[],"defaultTo":null,"notNullable":false,"unsigned":true},{"name":"wishlist_item_ord","type":"double","args":[],"defaultTo":null,"notNullable":false,"unsigned":true}]},{"name":"wishlist_items_product_lnk","indexes":[{"name":"wishlist_items_product_lnk_fk","columns":["wishlist_item_id"]},{"name":"wishlist_items_product_lnk_ifk","columns":["product_id"]},{"name":"wishlist_items_product_lnk_uq","columns":["wishlist_item_id","product_id"],"type":"unique"},{"name":"wishlist_items_product_lnk_oifk","columns":["wishlist_item_ord"]}],"foreignKeys":[{"name":"wishlist_items_product_lnk_fk","columns":["wishlist_item_id"],"referencedColumns":["id"],"referencedTable":"wishlist_items","onDelete":"CASCADE"},{"name":"wishlist_items_product_lnk_ifk","columns":["product_id"],"referencedColumns":["id"],"referencedTable":"products","onDelete":"CASCADE"}],"columns":[{"name":"id","type":"increments","args":[{"primary":true,"primaryKey":true}],"defaultTo":null,"notNullable":true,"unsigned":false},{"name":"wishlist_item_id","type":"integer","args":[],"defaultTo":null,"notNullable":false,"unsigned":true},{"name":"product_id","type":"integer","args":[],"defaultTo":null,"notNullable":false,"unsigned":true},{"name":"wishlist_item_ord","type":"double","args":[],"defaultTo":null,"notNullable":false,"unsigned":true}]},{"name":"admin_permissions_role_lnk","indexes":[{"name":"admin_permissions_role_lnk_fk","columns":["permission_id"]},{"name":"admin_permissions_role_lnk_ifk","columns":["role_id"]},{"name":"admin_permissions_role_lnk_uq","columns":["permission_id","role_id"],"type":"unique"},{"name":"admin_permissions_role_lnk_oifk","columns":["permission_ord"]}],"foreignKeys":[{"name":"admin_permissions_role_lnk_fk","columns":["permission_id"],"referencedColumns":["id"],"referencedTable":"admin_permissions","onDelete":"CASCADE"},{"name":"admin_permissions_role_lnk_ifk","columns":["role_id"],"referencedColumns":["id"],"referencedTable":"admin_roles","onDelete":"CASCADE"}],"columns":[{"name":"id","type":"increments","args":[{"primary":true,"primaryKey":true}],"defaultTo":null,"notNullable":true,"unsigned":false},{"name":"permission_id","type":"integer","args":[],"defaultTo":null,"notNullable":false,"unsigned":true},{"name":"role_id","type":"integer","args":[],"defaultTo":null,"notNullable":false,"unsigned":true},{"name":"permission_ord","type":"double","args":[],"defaultTo":null,"notNullable":false,"unsigned":true}]},{"name":"admin_users_roles_lnk","indexes":[{"name":"admin_users_roles_lnk_fk","columns":["user_id"]},{"name":"admin_users_roles_lnk_ifk","columns":["role_id"]},{"name":"admin_users_roles_lnk_uq","columns":["user_id","role_id"],"type":"unique"},{"name":"admin_users_roles_lnk_ofk","columns":["role_ord"]},{"name":"admin_users_roles_lnk_oifk","columns":["user_ord"]}],"foreignKeys":[{"name":"admin_users_roles_lnk_fk","columns":["user_id"],"referencedColumns":["id"],"referencedTable":"admin_users","onDelete":"CASCADE"},{"name":"admin_users_roles_lnk_ifk","columns":["role_id"],"referencedColumns":["id"],"referencedTable":"admin_roles","onDelete":"CASCADE"}],"columns":[{"name":"id","type":"increments","args":[{"primary":true,"primaryKey":true}],"defaultTo":null,"notNullable":true,"unsigned":false},{"name":"user_id","type":"integer","args":[],"defaultTo":null,"notNullable":false,"unsigned":true},{"name":"role_id","type":"integer","args":[],"defaultTo":null,"notNullable":false,"unsigned":true},{"name":"role_ord","type":"double","args":[],"defaultTo":null,"notNullable":false,"unsigned":true},{"name":"user_ord","type":"double","args":[],"defaultTo":null,"notNullable":false,"unsigned":true}]},{"name":"strapi_api_token_permissions_token_lnk","indexes":[{"name":"strapi_api_token_permissions_token_lnk_fk","columns":["api_token_permission_id"]},{"name":"strapi_api_token_permissions_token_lnk_ifk","columns":["api_token_id"]},{"name":"strapi_api_token_permissions_token_lnk_uq","columns":["api_token_permission_id","api_token_id"],"type":"unique"},{"name":"strapi_api_token_permissions_token_lnk_oifk","columns":["api_token_permission_ord"]}],"foreignKeys":[{"name":"strapi_api_token_permissions_token_lnk_fk","columns":["api_token_permission_id"],"referencedColumns":["id"],"referencedTable":"strapi_api_token_permissions","onDelete":"CASCADE"},{"name":"strapi_api_token_permissions_token_lnk_ifk","columns":["api_token_id"],"referencedColumns":["id"],"referencedTable":"strapi_api_tokens","onDelete":"CASCADE"}],"columns":[{"name":"id","type":"increments","args":[{"primary":true,"primaryKey":true}],"defaultTo":null,"notNullable":true,"unsigned":false},{"name":"api_token_permission_id","type":"integer","args":[],"defaultTo":null,"notNullable":false,"unsigned":true},{"name":"api_token_id","type":"integer","args":[],"defaultTo":null,"notNullable":false,"unsigned":true},{"name":"api_token_permission_ord","type":"double","args":[],"defaultTo":null,"notNullable":false,"unsigned":true}]},{"name":"strapi_transfer_token_permissions_token_lnk","indexes":[{"name":"strapi_transfer_token_permissions_token_lnk_fk","columns":["transfer_token_permission_id"]},{"name":"strapi_transfer_token_permissions_token_lnk_ifk","columns":["transfer_token_id"]},{"name":"strapi_transfer_token_permissions_token_lnk_uq","columns":["transfer_token_permission_id","transfer_token_id"],"type":"unique"},{"name":"strapi_transfer_token_permissions_token_lnk_oifk","columns":["transfer_token_permission_ord"]}],"foreignKeys":[{"name":"strapi_transfer_token_permissions_token_lnk_fk","columns":["transfer_token_permission_id"],"referencedColumns":["id"],"referencedTable":"strapi_transfer_token_permissions","onDelete":"CASCADE"},{"name":"strapi_transfer_token_permissions_token_lnk_ifk","columns":["transfer_token_id"],"referencedColumns":["id"],"referencedTable":"strapi_transfer_tokens","onDelete":"CASCADE"}],"columns":[{"name":"id","type":"increments","args":[{"primary":true,"primaryKey":true}],"defaultTo":null,"notNullable":true,"unsigned":false},{"name":"transfer_token_permission_id","type":"integer","args":[],"defaultTo":null,"notNullable":false,"unsigned":true},{"name":"transfer_token_id","type":"integer","args":[],"defaultTo":null,"notNullable":false,"unsigned":true},{"name":"transfer_token_permission_ord","type":"double","args":[],"defaultTo":null,"notNullable":false,"unsigned":true}]}]}	2026-03-30 16:27:29.176	1afaf8e2574d26a84c6cde05fe98cca7090f592294bddb507b202c12dba06560
\.


--
-- Data for Name: strapi_history_versions; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.strapi_history_versions (id, content_type, related_document_id, locale, status, data, schema, created_at, created_by_id) FROM stdin;
\.


--
-- Data for Name: strapi_migrations; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.strapi_migrations (id, name, "time") FROM stdin;
\.


--
-- Data for Name: strapi_migrations_internal; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.strapi_migrations_internal (id, name, "time") FROM stdin;
1	5.0.0-rename-identifiers-longer-than-max-length	2026-03-27 06:07:50.244
2	5.0.0-02-created-document-id	2026-03-27 06:07:50.315
3	5.0.0-03-created-locale	2026-03-27 06:07:50.377
4	5.0.0-04-created-published-at	2026-03-27 06:07:50.44
5	5.0.0-05-drop-slug-fields-index	2026-03-27 06:07:50.503
6	5.0.0-06-add-document-id-indexes	2026-03-27 06:07:50.557
7	core::5.0.0-discard-drafts	2026-03-27 06:07:50.617
\.


--
-- Data for Name: strapi_release_actions; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.strapi_release_actions (id, document_id, type, content_type, entry_document_id, locale, is_entry_valid, created_at, updated_at, published_at, created_by_id, updated_by_id) FROM stdin;
\.


--
-- Data for Name: strapi_release_actions_release_lnk; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.strapi_release_actions_release_lnk (id, release_action_id, release_id, release_action_ord) FROM stdin;
\.


--
-- Data for Name: strapi_releases; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.strapi_releases (id, document_id, name, released_at, scheduled_at, timezone, status, created_at, updated_at, published_at, created_by_id, updated_by_id, locale) FROM stdin;
\.


--
-- Data for Name: strapi_sessions; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.strapi_sessions (id, document_id, user_id, session_id, child_id, device_id, origin, expires_at, absolute_expires_at, status, type, created_at, updated_at, published_at, created_by_id, updated_by_id, locale) FROM stdin;
1	shstr0hzqzl4b543sv12omph	1	6c0e27ea4299b718df48c7f16ed78fe6	\N	422ac7aa-704d-4209-89b8-3cad0f2f5803	admin	2026-03-27 18:38:18.733	2026-04-26 16:38:18.733	active	session	2026-03-27 16:38:18.733	2026-03-27 16:38:18.733	2026-03-27 16:38:18.733	\N	\N	\N
\.


--
-- Data for Name: strapi_transfer_token_permissions; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.strapi_transfer_token_permissions (id, document_id, action, created_at, updated_at, published_at, created_by_id, updated_by_id, locale) FROM stdin;
\.


--
-- Data for Name: strapi_transfer_token_permissions_token_lnk; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.strapi_transfer_token_permissions_token_lnk (id, transfer_token_permission_id, transfer_token_id, transfer_token_permission_ord) FROM stdin;
\.


--
-- Data for Name: strapi_transfer_tokens; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.strapi_transfer_tokens (id, document_id, name, description, access_key, last_used_at, expires_at, lifespan, created_at, updated_at, published_at, created_by_id, updated_by_id, locale) FROM stdin;
\.


--
-- Data for Name: strapi_webhooks; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.strapi_webhooks (id, name, url, headers, events, enabled) FROM stdin;
\.


--
-- Data for Name: strapi_workflows; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.strapi_workflows (id, document_id, name, content_types, created_at, updated_at, published_at, created_by_id, updated_by_id, locale) FROM stdin;
\.


--
-- Data for Name: strapi_workflows_stage_required_to_publish_lnk; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.strapi_workflows_stage_required_to_publish_lnk (id, workflow_id, workflow_stage_id) FROM stdin;
\.


--
-- Data for Name: strapi_workflows_stages; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.strapi_workflows_stages (id, document_id, name, color, created_at, updated_at, published_at, created_by_id, updated_by_id, locale) FROM stdin;
\.


--
-- Data for Name: strapi_workflows_stages_permissions_lnk; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.strapi_workflows_stages_permissions_lnk (id, workflow_stage_id, permission_id, permission_ord) FROM stdin;
\.


--
-- Data for Name: strapi_workflows_stages_workflow_lnk; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.strapi_workflows_stages_workflow_lnk (id, workflow_stage_id, workflow_id, workflow_stage_ord) FROM stdin;
\.


--
-- Data for Name: testimonials; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.testimonials (id, document_id, name, text, sort_order, is_active, created_at, updated_at, published_at, created_by_id, updated_by_id, locale) FROM stdin;
\.


--
-- Data for Name: up_permissions; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.up_permissions (id, document_id, action, created_at, updated_at, published_at, created_by_id, updated_by_id, locale) FROM stdin;
1	h0qljsj1b2tora8jgpxoh1wr	plugin::users-permissions.auth.logout	2026-03-27 06:07:52.328	2026-03-27 06:07:52.328	2026-03-27 06:07:52.328	\N	\N	\N
2	ehilesa1dirfl8grrj43u9vi	plugin::users-permissions.user.me	2026-03-27 06:07:52.328	2026-03-27 06:07:52.328	2026-03-27 06:07:52.328	\N	\N	\N
3	rhiz5htzcpkqxijv393abl8p	plugin::users-permissions.auth.changePassword	2026-03-27 06:07:52.328	2026-03-27 06:07:52.328	2026-03-27 06:07:52.329	\N	\N	\N
4	zavw80gp63zek6veiu6641wa	plugin::users-permissions.auth.callback	2026-03-27 06:07:52.343	2026-03-27 06:07:52.343	2026-03-27 06:07:52.343	\N	\N	\N
5	t26daea5oybrtj9xivotjdde	plugin::users-permissions.auth.connect	2026-03-27 06:07:52.343	2026-03-27 06:07:52.343	2026-03-27 06:07:52.344	\N	\N	\N
6	hxq8657nlyxi7m5u1pjb8kjp	plugin::users-permissions.auth.forgotPassword	2026-03-27 06:07:52.343	2026-03-27 06:07:52.343	2026-03-27 06:07:52.344	\N	\N	\N
7	l0bjw3qcts0yh05ky4no6h1t	plugin::users-permissions.auth.resetPassword	2026-03-27 06:07:52.343	2026-03-27 06:07:52.343	2026-03-27 06:07:52.344	\N	\N	\N
8	ts56f517nvmx68x56qmkk0ff	plugin::users-permissions.auth.emailConfirmation	2026-03-27 06:07:52.343	2026-03-27 06:07:52.343	2026-03-27 06:07:52.344	\N	\N	\N
10	wpugnr4v1e9sxgr93alh27c1	plugin::users-permissions.auth.sendEmailConfirmation	2026-03-27 06:07:52.343	2026-03-27 06:07:52.343	2026-03-27 06:07:52.344	\N	\N	\N
9	s19gkd2z6bd87b4v1szyvcuv	plugin::users-permissions.auth.register	2026-03-27 06:07:52.343	2026-03-27 06:07:52.343	2026-03-27 06:07:52.344	\N	\N	\N
11	qslhfia1994zhwwil884156t	plugin::users-permissions.auth.refresh	2026-03-27 06:07:52.343	2026-03-27 06:07:52.343	2026-03-27 06:07:52.345	\N	\N	\N
12	yx43fkrsvmtpszp8fxpo4iny	api::availability-rule.availability-rule.find	2026-03-30 17:08:53.38	2026-03-30 17:08:53.38	2026-03-30 17:08:53.381	\N	\N	\N
13	ordibxg8caxcatnh1hjv60sq	api::availability-rule.availability-rule.findOne	2026-03-30 17:08:53.421	2026-03-30 17:08:53.421	2026-03-30 17:08:53.422	\N	\N	\N
14	pxgyic9llslwospqfn83pw9t	api::banner.banner.find	2026-03-30 17:08:53.429	2026-03-30 17:08:53.429	2026-03-30 17:08:53.43	\N	\N	\N
15	ft01v9xj6v1arhfbd9xv76s8	api::banner.banner.findOne	2026-03-30 17:08:53.438	2026-03-30 17:08:53.438	2026-03-30 17:08:53.438	\N	\N	\N
16	ub7ix7026zy9tyxz0g70zzqu	api::blocked-slot.blocked-slot.find	2026-03-30 17:08:53.446	2026-03-30 17:08:53.446	2026-03-30 17:08:53.446	\N	\N	\N
17	fci1xdlhnlsm4s6uu7nfwf3d	api::blocked-slot.blocked-slot.findOne	2026-03-30 17:08:53.453	2026-03-30 17:08:53.453	2026-03-30 17:08:53.453	\N	\N	\N
18	a82p6xux3qxz0sv3m0zi6cjj	api::booking-setting.booking-setting.find	2026-03-30 17:08:53.46	2026-03-30 17:08:53.46	2026-03-30 17:08:53.46	\N	\N	\N
19	tkzxk2e1gme28lthylpqmlki	api::business-setting.business-setting.find	2026-03-30 17:08:53.466	2026-03-30 17:08:53.466	2026-03-30 17:08:53.467	\N	\N	\N
20	c335nlqvfpisytzbz4ua7sub	api::commerce-placeholder.commerce-placeholder.find	2026-03-30 17:08:53.475	2026-03-30 17:08:53.475	2026-03-30 17:08:53.475	\N	\N	\N
21	a2lvsocdqa9f7ad3hrxrpqaz	api::commerce-placeholder.commerce-placeholder.findOne	2026-03-30 17:08:53.482	2026-03-30 17:08:53.482	2026-03-30 17:08:53.482	\N	\N	\N
22	odd1l0150lcyrot7xxmeo5yo	api::commerce-placeholder.commerce.createOrder	2026-03-30 17:08:53.489	2026-03-30 17:08:53.489	2026-03-30 17:08:53.489	\N	\N	\N
23	riipx2is785dlugpoe4ywhz9	api::commerce-placeholder.commerce.verifyPayment	2026-03-30 17:08:53.496	2026-03-30 17:08:53.496	2026-03-30 17:08:53.496	\N	\N	\N
24	kdvsk0ac9l1oizkfcrwf87z6	api::contact-message.contact-message.find	2026-03-30 17:08:53.505	2026-03-30 17:08:53.505	2026-03-30 17:08:53.505	\N	\N	\N
25	c4w4p0191mrfy7c0i3b8nug7	api::contact-message.contact-message.findOne	2026-03-30 17:08:53.512	2026-03-30 17:08:53.512	2026-03-30 17:08:53.512	\N	\N	\N
26	y23sphm9vbpttxchgaryk6td	api::contact-message.contact-message.create	2026-03-30 17:08:53.518	2026-03-30 17:08:53.518	2026-03-30 17:08:53.518	\N	\N	\N
27	ek2p1imppi0hmotsy8vg906z	api::coupon-code.coupon-code.find	2026-03-30 17:08:53.528	2026-03-30 17:08:53.528	2026-03-30 17:08:53.528	\N	\N	\N
28	wp60mk0qz9tkeexmvynw0flr	api::coupon-code.coupon-code.findOne	2026-03-30 17:08:53.537	2026-03-30 17:08:53.537	2026-03-30 17:08:53.537	\N	\N	\N
29	ssqfozutkwbjenkpuoibkvmx	api::digital-asset.digital-asset.find	2026-03-30 17:08:53.551	2026-03-30 17:08:53.551	2026-03-30 17:08:53.551	\N	\N	\N
30	im7qjgcm0yp4xqoajfq191ow	api::digital-asset.digital-asset.findOne	2026-03-30 17:08:53.564	2026-03-30 17:08:53.564	2026-03-30 17:08:53.564	\N	\N	\N
31	unsloze80xr5yzefavboiyex	api::legal-page.legal-page.find	2026-03-30 17:08:53.574	2026-03-30 17:08:53.574	2026-03-30 17:08:53.574	\N	\N	\N
32	a467cac4jng5g6oifj23b6ff	api::legal-page.legal-page.findOne	2026-03-30 17:08:53.579	2026-03-30 17:08:53.579	2026-03-30 17:08:53.579	\N	\N	\N
33	e8qxumg7d0a9l38587wcqr9y	api::popup.popup.find	2026-03-30 17:08:53.585	2026-03-30 17:08:53.585	2026-03-30 17:08:53.585	\N	\N	\N
34	it6zkqu999uf1o8f0o9rig0v	api::popup.popup.findOne	2026-03-30 17:08:53.591	2026-03-30 17:08:53.591	2026-03-30 17:08:53.592	\N	\N	\N
35	aho7w5h3qp1qsbpliy0l4xnt	api::product.product.find	2026-03-30 17:08:53.597	2026-03-30 17:08:53.597	2026-03-30 17:08:53.597	\N	\N	\N
36	fxlk8bl4ketixgv81yicue09	api::product.product.findOne	2026-03-30 17:08:53.614	2026-03-30 17:08:53.614	2026-03-30 17:08:53.614	\N	\N	\N
37	hgsv3z8wbhgwoof5nikbbpz1	api::product-category.product-category.find	2026-03-30 17:08:53.621	2026-03-30 17:08:53.621	2026-03-30 17:08:53.621	\N	\N	\N
38	gwqiax9g96w4s8q2tgf1urs2	api::product-category.product-category.findOne	2026-03-30 17:08:53.629	2026-03-30 17:08:53.629	2026-03-30 17:08:53.629	\N	\N	\N
39	pv3jq34i4qnlkztfs5qo8bm1	api::product-variant.product-variant.find	2026-03-30 17:08:53.636	2026-03-30 17:08:53.636	2026-03-30 17:08:53.636	\N	\N	\N
40	fv92512nsheo0m5ln1cuqo0t	api::product-variant.product-variant.findOne	2026-03-30 17:08:53.643	2026-03-30 17:08:53.643	2026-03-30 17:08:53.644	\N	\N	\N
41	zzxwg3inaip9ir8jv094pmbt	api::promo-rule.promo-rule.find	2026-03-30 17:08:53.65	2026-03-30 17:08:53.65	2026-03-30 17:08:53.65	\N	\N	\N
42	q1fco8msxpuhzqqo9jpkteeh	api::promo-rule.promo-rule.findOne	2026-03-30 17:08:53.657	2026-03-30 17:08:53.657	2026-03-30 17:08:53.657	\N	\N	\N
43	ppujbrr474yq89vbfb4jaccl	api::review.review.find	2026-03-30 17:08:53.668	2026-03-30 17:08:53.668	2026-03-30 17:08:53.668	\N	\N	\N
44	dcrs79z6wf1r9ma3pa2u6htc	api::review.review.findOne	2026-03-30 17:08:53.675	2026-03-30 17:08:53.675	2026-03-30 17:08:53.675	\N	\N	\N
45	b4pb6r1yd9y6v8igzqd3m64m	api::service.service.find	2026-03-30 17:08:53.681	2026-03-30 17:08:53.681	2026-03-30 17:08:53.681	\N	\N	\N
46	jyzhafztsgx78hsfhc0u0nux	api::service.service.findOne	2026-03-30 17:08:53.688	2026-03-30 17:08:53.688	2026-03-30 17:08:53.688	\N	\N	\N
47	qg8urciolyxn4ecyhb2cjem7	api::shipping-class.shipping-class.find	2026-03-30 17:08:53.695	2026-03-30 17:08:53.695	2026-03-30 17:08:53.696	\N	\N	\N
48	u1etsewrt45n4zb55psodndf	api::shipping-class.shipping-class.findOne	2026-03-30 17:08:53.702	2026-03-30 17:08:53.702	2026-03-30 17:08:53.702	\N	\N	\N
49	w2f6r708gp2ypnp81upsb2tc	api::testimonial.testimonial.find	2026-03-30 17:08:53.716	2026-03-30 17:08:53.716	2026-03-30 17:08:53.716	\N	\N	\N
50	gecqehrz5fmtdrdk9oqvb7de	api::testimonial.testimonial.findOne	2026-03-30 17:08:53.722	2026-03-30 17:08:53.722	2026-03-30 17:08:53.722	\N	\N	\N
\.


--
-- Data for Name: up_permissions_role_lnk; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.up_permissions_role_lnk (id, permission_id, role_id, permission_ord) FROM stdin;
1	1	1	1
2	3	1	1
3	2	1	1
4	4	2	1
5	5	2	1
6	6	2	1
7	7	2	2
8	8	2	2
9	10	2	2
10	11	2	2
11	9	2	2
12	12	2	3
13	13	2	4
14	14	2	5
15	15	2	6
16	16	2	7
17	17	2	8
18	18	2	9
19	19	2	10
20	20	2	11
21	21	2	12
22	22	2	13
23	23	2	14
24	24	2	15
25	25	2	16
26	26	2	17
27	27	2	18
28	28	2	19
29	29	2	20
30	30	2	21
31	31	2	22
32	32	2	23
33	33	2	24
34	34	2	25
35	35	2	26
36	36	2	27
37	37	2	28
38	38	2	29
39	39	2	30
40	40	2	31
41	41	2	32
42	42	2	33
43	43	2	34
44	44	2	35
45	45	2	36
46	46	2	37
47	47	2	38
48	48	2	39
49	49	2	40
50	50	2	41
\.


--
-- Data for Name: up_roles; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.up_roles (id, document_id, name, description, type, created_at, updated_at, published_at, created_by_id, updated_by_id, locale) FROM stdin;
1	yqsg9pwlq88lcee7nieqa0fe	Authenticated	Default role given to authenticated user.	authenticated	2026-03-27 06:07:52.315	2026-03-27 06:07:52.315	2026-03-27 06:07:52.315	\N	\N	\N
2	xtn3c7f3p6u7ytwddlxxj9pc	Public	Default role given to unauthenticated user.	public	2026-03-27 06:07:52.32	2026-03-27 06:07:52.32	2026-03-27 06:07:52.32	\N	\N	\N
\.


--
-- Data for Name: up_users; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.up_users (id, document_id, created_at, updated_at, published_at, created_by_id, updated_by_id, locale, phone, app_role) FROM stdin;
\.


--
-- Data for Name: upload_folders; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.upload_folders (id, document_id, name, path_id, path, created_at, updated_at, published_at, created_by_id, updated_by_id, locale) FROM stdin;
\.


--
-- Data for Name: upload_folders_parent_lnk; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.upload_folders_parent_lnk (id, folder_id, inv_folder_id, folder_ord) FROM stdin;
\.


--
-- Data for Name: wishlist_items; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.wishlist_items (id, document_id, created_at, updated_at, published_at, created_by_id, updated_by_id, locale) FROM stdin;
\.


--
-- Data for Name: wishlist_items_product_lnk; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.wishlist_items_product_lnk (id, wishlist_item_id, product_id, wishlist_item_ord) FROM stdin;
\.


--
-- Data for Name: wishlist_items_user_lnk; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.wishlist_items_user_lnk (id, wishlist_item_id, user_id, wishlist_item_ord) FROM stdin;
\.


--
-- Name: admin_permissions_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.admin_permissions_id_seq', 228, true);


--
-- Name: admin_permissions_role_lnk_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.admin_permissions_role_lnk_id_seq', 228, true);


--
-- Name: admin_roles_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.admin_roles_id_seq', 3, true);


--
-- Name: admin_users_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.admin_users_id_seq', 1, true);


--
-- Name: admin_users_roles_lnk_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.admin_users_roles_lnk_id_seq', 1, true);


--
-- Name: availability_rules_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.availability_rules_id_seq', 1, false);


--
-- Name: banners_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.banners_id_seq', 1, false);


--
-- Name: blocked_slots_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.blocked_slots_id_seq', 1, false);


--
-- Name: booking_setting_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.booking_setting_id_seq', 1, true);


--
-- Name: bookings_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.bookings_id_seq', 1, false);


--
-- Name: bookings_service_lnk_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.bookings_service_lnk_id_seq', 1, false);


--
-- Name: bookings_user_lnk_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.bookings_user_lnk_id_seq', 1, false);


--
-- Name: business_setting_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.business_setting_id_seq', 1, true);


--
-- Name: cart_items_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.cart_items_id_seq', 1, false);


--
-- Name: cart_items_product_lnk_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.cart_items_product_lnk_id_seq', 1, false);


--
-- Name: cart_items_user_lnk_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.cart_items_user_lnk_id_seq', 1, false);


--
-- Name: commerce_placeholders_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.commerce_placeholders_id_seq', 1, false);


--
-- Name: contact_messages_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.contact_messages_id_seq', 1, false);


--
-- Name: coupon_codes_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.coupon_codes_id_seq', 1, false);


--
-- Name: coupon_usages_coupon_lnk_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.coupon_usages_coupon_lnk_id_seq', 1, false);


--
-- Name: coupon_usages_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.coupon_usages_id_seq', 1, false);


--
-- Name: coupon_usages_order_lnk_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.coupon_usages_order_lnk_id_seq', 1, false);


--
-- Name: coupon_usages_user_lnk_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.coupon_usages_user_lnk_id_seq', 1, false);


--
-- Name: digital_assets_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.digital_assets_id_seq', 1, false);


--
-- Name: digital_assets_product_lnk_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.digital_assets_product_lnk_id_seq', 1, false);


--
-- Name: digital_purchases_asset_lnk_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.digital_purchases_asset_lnk_id_seq', 1, false);


--
-- Name: digital_purchases_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.digital_purchases_id_seq', 1, false);


--
-- Name: digital_purchases_order_lnk_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.digital_purchases_order_lnk_id_seq', 1, false);


--
-- Name: digital_purchases_product_lnk_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.digital_purchases_product_lnk_id_seq', 1, false);


--
-- Name: digital_purchases_user_lnk_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.digital_purchases_user_lnk_id_seq', 1, false);


--
-- Name: email_logs_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.email_logs_id_seq', 1, false);


--
-- Name: files_folder_lnk_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.files_folder_lnk_id_seq', 1, false);


--
-- Name: files_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.files_id_seq', 1, false);


--
-- Name: files_related_mph_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.files_related_mph_id_seq', 1, false);


--
-- Name: i18n_locale_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.i18n_locale_id_seq', 1, true);


--
-- Name: invoices_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.invoices_id_seq', 1, false);


--
-- Name: invoices_order_lnk_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.invoices_order_lnk_id_seq', 1, false);


--
-- Name: legal_pages_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.legal_pages_id_seq', 1, false);


--
-- Name: order_items_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.order_items_id_seq', 1, false);


--
-- Name: order_items_order_lnk_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.order_items_order_lnk_id_seq', 1, false);


--
-- Name: order_items_product_lnk_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.order_items_product_lnk_id_seq', 1, false);


--
-- Name: order_shipments_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.order_shipments_id_seq', 1, false);


--
-- Name: order_shipments_order_lnk_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.order_shipments_order_lnk_id_seq', 1, false);


--
-- Name: orders_coupon_lnk_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.orders_coupon_lnk_id_seq', 1, false);


--
-- Name: orders_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.orders_id_seq', 1, false);


--
-- Name: orders_user_lnk_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.orders_user_lnk_id_seq', 1, false);


--
-- Name: password_reset_tokens_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.password_reset_tokens_id_seq', 1, false);


--
-- Name: password_reset_tokens_user_lnk_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.password_reset_tokens_user_lnk_id_seq', 1, false);


--
-- Name: popups_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.popups_id_seq', 1, false);


--
-- Name: product_categories_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.product_categories_id_seq', 6, true);


--
-- Name: product_variants_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.product_variants_id_seq', 1, false);


--
-- Name: product_variants_product_lnk_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.product_variants_product_lnk_id_seq', 1, false);


--
-- Name: products_category_lnk_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.products_category_lnk_id_seq', 28, true);


--
-- Name: products_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.products_id_seq', 28, true);


--
-- Name: products_shipping_class_lnk_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.products_shipping_class_lnk_id_seq', 28, true);


--
-- Name: promo_rules_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.promo_rules_id_seq', 1, false);


--
-- Name: reviews_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.reviews_id_seq', 1, false);


--
-- Name: reviews_product_lnk_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.reviews_product_lnk_id_seq', 1, false);


--
-- Name: reviews_user_lnk_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.reviews_user_lnk_id_seq', 1, false);


--
-- Name: scheduled_reminders_booking_lnk_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.scheduled_reminders_booking_lnk_id_seq', 1, false);


--
-- Name: scheduled_reminders_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.scheduled_reminders_id_seq', 1, false);


--
-- Name: services_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.services_id_seq', 9, true);


--
-- Name: shipping_classes_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.shipping_classes_id_seq', 2, true);


--
-- Name: strapi_ai_localization_jobs_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.strapi_ai_localization_jobs_id_seq', 1, false);


--
-- Name: strapi_ai_metadata_jobs_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.strapi_ai_metadata_jobs_id_seq', 1, false);


--
-- Name: strapi_api_token_permissions_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.strapi_api_token_permissions_id_seq', 1, false);


--
-- Name: strapi_api_token_permissions_token_lnk_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.strapi_api_token_permissions_token_lnk_id_seq', 1, false);


--
-- Name: strapi_api_tokens_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.strapi_api_tokens_id_seq', 2, true);


--
-- Name: strapi_core_store_settings_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.strapi_core_store_settings_id_seq', 59, true);


--
-- Name: strapi_database_schema_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.strapi_database_schema_id_seq', 3, true);


--
-- Name: strapi_history_versions_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.strapi_history_versions_id_seq', 1, false);


--
-- Name: strapi_migrations_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.strapi_migrations_id_seq', 1, false);


--
-- Name: strapi_migrations_internal_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.strapi_migrations_internal_id_seq', 7, true);


--
-- Name: strapi_release_actions_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.strapi_release_actions_id_seq', 1, false);


--
-- Name: strapi_release_actions_release_lnk_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.strapi_release_actions_release_lnk_id_seq', 1, false);


--
-- Name: strapi_releases_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.strapi_releases_id_seq', 1, false);


--
-- Name: strapi_sessions_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.strapi_sessions_id_seq', 1, true);


--
-- Name: strapi_transfer_token_permissions_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.strapi_transfer_token_permissions_id_seq', 1, false);


--
-- Name: strapi_transfer_token_permissions_token_lnk_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.strapi_transfer_token_permissions_token_lnk_id_seq', 1, false);


--
-- Name: strapi_transfer_tokens_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.strapi_transfer_tokens_id_seq', 1, false);


--
-- Name: strapi_webhooks_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.strapi_webhooks_id_seq', 1, false);


--
-- Name: strapi_workflows_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.strapi_workflows_id_seq', 1, false);


--
-- Name: strapi_workflows_stage_required_to_publish_lnk_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.strapi_workflows_stage_required_to_publish_lnk_id_seq', 1, false);


--
-- Name: strapi_workflows_stages_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.strapi_workflows_stages_id_seq', 1, false);


--
-- Name: strapi_workflows_stages_permissions_lnk_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.strapi_workflows_stages_permissions_lnk_id_seq', 1, false);


--
-- Name: strapi_workflows_stages_workflow_lnk_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.strapi_workflows_stages_workflow_lnk_id_seq', 1, false);


--
-- Name: testimonials_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.testimonials_id_seq', 1, false);


--
-- Name: up_permissions_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.up_permissions_id_seq', 50, true);


--
-- Name: up_permissions_role_lnk_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.up_permissions_role_lnk_id_seq', 50, true);


--
-- Name: up_roles_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.up_roles_id_seq', 2, true);


--
-- Name: up_users_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.up_users_id_seq', 1, false);


--
-- Name: upload_folders_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.upload_folders_id_seq', 1, false);


--
-- Name: upload_folders_parent_lnk_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.upload_folders_parent_lnk_id_seq', 1, false);


--
-- Name: wishlist_items_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.wishlist_items_id_seq', 1, false);


--
-- Name: wishlist_items_product_lnk_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.wishlist_items_product_lnk_id_seq', 1, false);


--
-- Name: wishlist_items_user_lnk_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.wishlist_items_user_lnk_id_seq', 1, false);


--
-- Name: admin_permissions admin_permissions_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.admin_permissions
    ADD CONSTRAINT admin_permissions_pkey PRIMARY KEY (id);


--
-- Name: admin_permissions_role_lnk admin_permissions_role_lnk_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.admin_permissions_role_lnk
    ADD CONSTRAINT admin_permissions_role_lnk_pkey PRIMARY KEY (id);


--
-- Name: admin_permissions_role_lnk admin_permissions_role_lnk_uq; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.admin_permissions_role_lnk
    ADD CONSTRAINT admin_permissions_role_lnk_uq UNIQUE (permission_id, role_id);


--
-- Name: admin_roles admin_roles_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.admin_roles
    ADD CONSTRAINT admin_roles_pkey PRIMARY KEY (id);


--
-- Name: admin_users admin_users_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.admin_users
    ADD CONSTRAINT admin_users_pkey PRIMARY KEY (id);


--
-- Name: admin_users_roles_lnk admin_users_roles_lnk_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.admin_users_roles_lnk
    ADD CONSTRAINT admin_users_roles_lnk_pkey PRIMARY KEY (id);


--
-- Name: admin_users_roles_lnk admin_users_roles_lnk_uq; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.admin_users_roles_lnk
    ADD CONSTRAINT admin_users_roles_lnk_uq UNIQUE (user_id, role_id);


--
-- Name: availability_rules availability_rules_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.availability_rules
    ADD CONSTRAINT availability_rules_pkey PRIMARY KEY (id);


--
-- Name: banners banners_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.banners
    ADD CONSTRAINT banners_pkey PRIMARY KEY (id);


--
-- Name: blocked_slots blocked_slots_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.blocked_slots
    ADD CONSTRAINT blocked_slots_pkey PRIMARY KEY (id);


--
-- Name: booking_setting booking_setting_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.booking_setting
    ADD CONSTRAINT booking_setting_pkey PRIMARY KEY (id);


--
-- Name: bookings bookings_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.bookings
    ADD CONSTRAINT bookings_pkey PRIMARY KEY (id);


--
-- Name: bookings_service_lnk bookings_service_lnk_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.bookings_service_lnk
    ADD CONSTRAINT bookings_service_lnk_pkey PRIMARY KEY (id);


--
-- Name: bookings_service_lnk bookings_service_lnk_uq; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.bookings_service_lnk
    ADD CONSTRAINT bookings_service_lnk_uq UNIQUE (booking_id, service_id);


--
-- Name: bookings_user_lnk bookings_user_lnk_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.bookings_user_lnk
    ADD CONSTRAINT bookings_user_lnk_pkey PRIMARY KEY (id);


--
-- Name: bookings_user_lnk bookings_user_lnk_uq; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.bookings_user_lnk
    ADD CONSTRAINT bookings_user_lnk_uq UNIQUE (booking_id, user_id);


--
-- Name: business_setting business_setting_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.business_setting
    ADD CONSTRAINT business_setting_pkey PRIMARY KEY (id);


--
-- Name: cart_items cart_items_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.cart_items
    ADD CONSTRAINT cart_items_pkey PRIMARY KEY (id);


--
-- Name: cart_items_product_lnk cart_items_product_lnk_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.cart_items_product_lnk
    ADD CONSTRAINT cart_items_product_lnk_pkey PRIMARY KEY (id);


--
-- Name: cart_items_product_lnk cart_items_product_lnk_uq; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.cart_items_product_lnk
    ADD CONSTRAINT cart_items_product_lnk_uq UNIQUE (cart_item_id, product_id);


--
-- Name: cart_items_user_lnk cart_items_user_lnk_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.cart_items_user_lnk
    ADD CONSTRAINT cart_items_user_lnk_pkey PRIMARY KEY (id);


--
-- Name: cart_items_user_lnk cart_items_user_lnk_uq; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.cart_items_user_lnk
    ADD CONSTRAINT cart_items_user_lnk_uq UNIQUE (cart_item_id, user_id);


--
-- Name: commerce_placeholders commerce_placeholders_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.commerce_placeholders
    ADD CONSTRAINT commerce_placeholders_pkey PRIMARY KEY (id);


--
-- Name: contact_messages contact_messages_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.contact_messages
    ADD CONSTRAINT contact_messages_pkey PRIMARY KEY (id);


--
-- Name: coupon_codes coupon_codes_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.coupon_codes
    ADD CONSTRAINT coupon_codes_pkey PRIMARY KEY (id);


--
-- Name: coupon_usages_coupon_lnk coupon_usages_coupon_lnk_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.coupon_usages_coupon_lnk
    ADD CONSTRAINT coupon_usages_coupon_lnk_pkey PRIMARY KEY (id);


--
-- Name: coupon_usages_coupon_lnk coupon_usages_coupon_lnk_uq; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.coupon_usages_coupon_lnk
    ADD CONSTRAINT coupon_usages_coupon_lnk_uq UNIQUE (coupon_usage_id, coupon_code_id);


--
-- Name: coupon_usages_order_lnk coupon_usages_order_lnk_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.coupon_usages_order_lnk
    ADD CONSTRAINT coupon_usages_order_lnk_pkey PRIMARY KEY (id);


--
-- Name: coupon_usages_order_lnk coupon_usages_order_lnk_uq; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.coupon_usages_order_lnk
    ADD CONSTRAINT coupon_usages_order_lnk_uq UNIQUE (coupon_usage_id, order_id);


--
-- Name: coupon_usages coupon_usages_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.coupon_usages
    ADD CONSTRAINT coupon_usages_pkey PRIMARY KEY (id);


--
-- Name: coupon_usages_user_lnk coupon_usages_user_lnk_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.coupon_usages_user_lnk
    ADD CONSTRAINT coupon_usages_user_lnk_pkey PRIMARY KEY (id);


--
-- Name: coupon_usages_user_lnk coupon_usages_user_lnk_uq; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.coupon_usages_user_lnk
    ADD CONSTRAINT coupon_usages_user_lnk_uq UNIQUE (coupon_usage_id, user_id);


--
-- Name: digital_assets digital_assets_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.digital_assets
    ADD CONSTRAINT digital_assets_pkey PRIMARY KEY (id);


--
-- Name: digital_assets_product_lnk digital_assets_product_lnk_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.digital_assets_product_lnk
    ADD CONSTRAINT digital_assets_product_lnk_pkey PRIMARY KEY (id);


--
-- Name: digital_assets_product_lnk digital_assets_product_lnk_uq; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.digital_assets_product_lnk
    ADD CONSTRAINT digital_assets_product_lnk_uq UNIQUE (digital_asset_id, product_id);


--
-- Name: digital_purchases_asset_lnk digital_purchases_asset_lnk_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.digital_purchases_asset_lnk
    ADD CONSTRAINT digital_purchases_asset_lnk_pkey PRIMARY KEY (id);


--
-- Name: digital_purchases_asset_lnk digital_purchases_asset_lnk_uq; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.digital_purchases_asset_lnk
    ADD CONSTRAINT digital_purchases_asset_lnk_uq UNIQUE (digital_purchase_id, digital_asset_id);


--
-- Name: digital_purchases_order_lnk digital_purchases_order_lnk_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.digital_purchases_order_lnk
    ADD CONSTRAINT digital_purchases_order_lnk_pkey PRIMARY KEY (id);


--
-- Name: digital_purchases_order_lnk digital_purchases_order_lnk_uq; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.digital_purchases_order_lnk
    ADD CONSTRAINT digital_purchases_order_lnk_uq UNIQUE (digital_purchase_id, order_id);


--
-- Name: digital_purchases digital_purchases_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.digital_purchases
    ADD CONSTRAINT digital_purchases_pkey PRIMARY KEY (id);


--
-- Name: digital_purchases_product_lnk digital_purchases_product_lnk_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.digital_purchases_product_lnk
    ADD CONSTRAINT digital_purchases_product_lnk_pkey PRIMARY KEY (id);


--
-- Name: digital_purchases_product_lnk digital_purchases_product_lnk_uq; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.digital_purchases_product_lnk
    ADD CONSTRAINT digital_purchases_product_lnk_uq UNIQUE (digital_purchase_id, product_id);


--
-- Name: digital_purchases_user_lnk digital_purchases_user_lnk_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.digital_purchases_user_lnk
    ADD CONSTRAINT digital_purchases_user_lnk_pkey PRIMARY KEY (id);


--
-- Name: digital_purchases_user_lnk digital_purchases_user_lnk_uq; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.digital_purchases_user_lnk
    ADD CONSTRAINT digital_purchases_user_lnk_uq UNIQUE (digital_purchase_id, user_id);


--
-- Name: email_logs email_logs_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.email_logs
    ADD CONSTRAINT email_logs_pkey PRIMARY KEY (id);


--
-- Name: files_folder_lnk files_folder_lnk_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.files_folder_lnk
    ADD CONSTRAINT files_folder_lnk_pkey PRIMARY KEY (id);


--
-- Name: files_folder_lnk files_folder_lnk_uq; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.files_folder_lnk
    ADD CONSTRAINT files_folder_lnk_uq UNIQUE (file_id, folder_id);


--
-- Name: files files_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.files
    ADD CONSTRAINT files_pkey PRIMARY KEY (id);


--
-- Name: files_related_mph files_related_mph_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.files_related_mph
    ADD CONSTRAINT files_related_mph_pkey PRIMARY KEY (id);


--
-- Name: i18n_locale i18n_locale_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.i18n_locale
    ADD CONSTRAINT i18n_locale_pkey PRIMARY KEY (id);


--
-- Name: invoices_order_lnk invoices_order_lnk_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.invoices_order_lnk
    ADD CONSTRAINT invoices_order_lnk_pkey PRIMARY KEY (id);


--
-- Name: invoices_order_lnk invoices_order_lnk_uq; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.invoices_order_lnk
    ADD CONSTRAINT invoices_order_lnk_uq UNIQUE (invoice_id, order_id);


--
-- Name: invoices invoices_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.invoices
    ADD CONSTRAINT invoices_pkey PRIMARY KEY (id);


--
-- Name: legal_pages legal_pages_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.legal_pages
    ADD CONSTRAINT legal_pages_pkey PRIMARY KEY (id);


--
-- Name: order_items_order_lnk order_items_order_lnk_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.order_items_order_lnk
    ADD CONSTRAINT order_items_order_lnk_pkey PRIMARY KEY (id);


--
-- Name: order_items_order_lnk order_items_order_lnk_uq; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.order_items_order_lnk
    ADD CONSTRAINT order_items_order_lnk_uq UNIQUE (order_item_id, order_id);


--
-- Name: order_items order_items_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.order_items
    ADD CONSTRAINT order_items_pkey PRIMARY KEY (id);


--
-- Name: order_items_product_lnk order_items_product_lnk_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.order_items_product_lnk
    ADD CONSTRAINT order_items_product_lnk_pkey PRIMARY KEY (id);


--
-- Name: order_items_product_lnk order_items_product_lnk_uq; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.order_items_product_lnk
    ADD CONSTRAINT order_items_product_lnk_uq UNIQUE (order_item_id, product_id);


--
-- Name: order_shipments_order_lnk order_shipments_order_lnk_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.order_shipments_order_lnk
    ADD CONSTRAINT order_shipments_order_lnk_pkey PRIMARY KEY (id);


--
-- Name: order_shipments_order_lnk order_shipments_order_lnk_uq; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.order_shipments_order_lnk
    ADD CONSTRAINT order_shipments_order_lnk_uq UNIQUE (order_shipment_id, order_id);


--
-- Name: order_shipments order_shipments_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.order_shipments
    ADD CONSTRAINT order_shipments_pkey PRIMARY KEY (id);


--
-- Name: orders_coupon_lnk orders_coupon_lnk_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.orders_coupon_lnk
    ADD CONSTRAINT orders_coupon_lnk_pkey PRIMARY KEY (id);


--
-- Name: orders_coupon_lnk orders_coupon_lnk_uq; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.orders_coupon_lnk
    ADD CONSTRAINT orders_coupon_lnk_uq UNIQUE (order_id, coupon_code_id);


--
-- Name: orders orders_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.orders
    ADD CONSTRAINT orders_pkey PRIMARY KEY (id);


--
-- Name: orders_user_lnk orders_user_lnk_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.orders_user_lnk
    ADD CONSTRAINT orders_user_lnk_pkey PRIMARY KEY (id);


--
-- Name: orders_user_lnk orders_user_lnk_uq; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.orders_user_lnk
    ADD CONSTRAINT orders_user_lnk_uq UNIQUE (order_id, user_id);


--
-- Name: password_reset_tokens password_reset_tokens_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.password_reset_tokens
    ADD CONSTRAINT password_reset_tokens_pkey PRIMARY KEY (id);


--
-- Name: password_reset_tokens_user_lnk password_reset_tokens_user_lnk_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.password_reset_tokens_user_lnk
    ADD CONSTRAINT password_reset_tokens_user_lnk_pkey PRIMARY KEY (id);


--
-- Name: password_reset_tokens_user_lnk password_reset_tokens_user_lnk_uq; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.password_reset_tokens_user_lnk
    ADD CONSTRAINT password_reset_tokens_user_lnk_uq UNIQUE (password_reset_token_id, user_id);


--
-- Name: popups popups_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.popups
    ADD CONSTRAINT popups_pkey PRIMARY KEY (id);


--
-- Name: product_categories product_categories_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.product_categories
    ADD CONSTRAINT product_categories_pkey PRIMARY KEY (id);


--
-- Name: product_variants product_variants_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.product_variants
    ADD CONSTRAINT product_variants_pkey PRIMARY KEY (id);


--
-- Name: product_variants_product_lnk product_variants_product_lnk_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.product_variants_product_lnk
    ADD CONSTRAINT product_variants_product_lnk_pkey PRIMARY KEY (id);


--
-- Name: product_variants_product_lnk product_variants_product_lnk_uq; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.product_variants_product_lnk
    ADD CONSTRAINT product_variants_product_lnk_uq UNIQUE (product_variant_id, product_id);


--
-- Name: products_category_lnk products_category_lnk_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.products_category_lnk
    ADD CONSTRAINT products_category_lnk_pkey PRIMARY KEY (id);


--
-- Name: products_category_lnk products_category_lnk_uq; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.products_category_lnk
    ADD CONSTRAINT products_category_lnk_uq UNIQUE (product_id, product_category_id);


--
-- Name: products products_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.products
    ADD CONSTRAINT products_pkey PRIMARY KEY (id);


--
-- Name: products_shipping_class_lnk products_shipping_class_lnk_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.products_shipping_class_lnk
    ADD CONSTRAINT products_shipping_class_lnk_pkey PRIMARY KEY (id);


--
-- Name: products_shipping_class_lnk products_shipping_class_lnk_uq; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.products_shipping_class_lnk
    ADD CONSTRAINT products_shipping_class_lnk_uq UNIQUE (product_id, shipping_class_id);


--
-- Name: promo_rules promo_rules_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.promo_rules
    ADD CONSTRAINT promo_rules_pkey PRIMARY KEY (id);


--
-- Name: reviews reviews_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.reviews
    ADD CONSTRAINT reviews_pkey PRIMARY KEY (id);


--
-- Name: reviews_product_lnk reviews_product_lnk_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.reviews_product_lnk
    ADD CONSTRAINT reviews_product_lnk_pkey PRIMARY KEY (id);


--
-- Name: reviews_product_lnk reviews_product_lnk_uq; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.reviews_product_lnk
    ADD CONSTRAINT reviews_product_lnk_uq UNIQUE (review_id, product_id);


--
-- Name: reviews_user_lnk reviews_user_lnk_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.reviews_user_lnk
    ADD CONSTRAINT reviews_user_lnk_pkey PRIMARY KEY (id);


--
-- Name: reviews_user_lnk reviews_user_lnk_uq; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.reviews_user_lnk
    ADD CONSTRAINT reviews_user_lnk_uq UNIQUE (review_id, user_id);


--
-- Name: scheduled_reminders_booking_lnk scheduled_reminders_booking_lnk_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.scheduled_reminders_booking_lnk
    ADD CONSTRAINT scheduled_reminders_booking_lnk_pkey PRIMARY KEY (id);


--
-- Name: scheduled_reminders_booking_lnk scheduled_reminders_booking_lnk_uq; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.scheduled_reminders_booking_lnk
    ADD CONSTRAINT scheduled_reminders_booking_lnk_uq UNIQUE (scheduled_reminder_id, booking_id);


--
-- Name: scheduled_reminders scheduled_reminders_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.scheduled_reminders
    ADD CONSTRAINT scheduled_reminders_pkey PRIMARY KEY (id);


--
-- Name: services services_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.services
    ADD CONSTRAINT services_pkey PRIMARY KEY (id);


--
-- Name: shipping_classes shipping_classes_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.shipping_classes
    ADD CONSTRAINT shipping_classes_pkey PRIMARY KEY (id);


--
-- Name: strapi_ai_localization_jobs strapi_ai_localization_jobs_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.strapi_ai_localization_jobs
    ADD CONSTRAINT strapi_ai_localization_jobs_pkey PRIMARY KEY (id);


--
-- Name: strapi_ai_metadata_jobs strapi_ai_metadata_jobs_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.strapi_ai_metadata_jobs
    ADD CONSTRAINT strapi_ai_metadata_jobs_pkey PRIMARY KEY (id);


--
-- Name: strapi_api_token_permissions strapi_api_token_permissions_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.strapi_api_token_permissions
    ADD CONSTRAINT strapi_api_token_permissions_pkey PRIMARY KEY (id);


--
-- Name: strapi_api_token_permissions_token_lnk strapi_api_token_permissions_token_lnk_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.strapi_api_token_permissions_token_lnk
    ADD CONSTRAINT strapi_api_token_permissions_token_lnk_pkey PRIMARY KEY (id);


--
-- Name: strapi_api_token_permissions_token_lnk strapi_api_token_permissions_token_lnk_uq; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.strapi_api_token_permissions_token_lnk
    ADD CONSTRAINT strapi_api_token_permissions_token_lnk_uq UNIQUE (api_token_permission_id, api_token_id);


--
-- Name: strapi_api_tokens strapi_api_tokens_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.strapi_api_tokens
    ADD CONSTRAINT strapi_api_tokens_pkey PRIMARY KEY (id);


--
-- Name: strapi_core_store_settings strapi_core_store_settings_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.strapi_core_store_settings
    ADD CONSTRAINT strapi_core_store_settings_pkey PRIMARY KEY (id);


--
-- Name: strapi_database_schema strapi_database_schema_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.strapi_database_schema
    ADD CONSTRAINT strapi_database_schema_pkey PRIMARY KEY (id);


--
-- Name: strapi_history_versions strapi_history_versions_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.strapi_history_versions
    ADD CONSTRAINT strapi_history_versions_pkey PRIMARY KEY (id);


--
-- Name: strapi_migrations_internal strapi_migrations_internal_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.strapi_migrations_internal
    ADD CONSTRAINT strapi_migrations_internal_pkey PRIMARY KEY (id);


--
-- Name: strapi_migrations strapi_migrations_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.strapi_migrations
    ADD CONSTRAINT strapi_migrations_pkey PRIMARY KEY (id);


--
-- Name: strapi_release_actions strapi_release_actions_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.strapi_release_actions
    ADD CONSTRAINT strapi_release_actions_pkey PRIMARY KEY (id);


--
-- Name: strapi_release_actions_release_lnk strapi_release_actions_release_lnk_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.strapi_release_actions_release_lnk
    ADD CONSTRAINT strapi_release_actions_release_lnk_pkey PRIMARY KEY (id);


--
-- Name: strapi_release_actions_release_lnk strapi_release_actions_release_lnk_uq; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.strapi_release_actions_release_lnk
    ADD CONSTRAINT strapi_release_actions_release_lnk_uq UNIQUE (release_action_id, release_id);


--
-- Name: strapi_releases strapi_releases_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.strapi_releases
    ADD CONSTRAINT strapi_releases_pkey PRIMARY KEY (id);


--
-- Name: strapi_sessions strapi_sessions_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.strapi_sessions
    ADD CONSTRAINT strapi_sessions_pkey PRIMARY KEY (id);


--
-- Name: strapi_transfer_token_permissions strapi_transfer_token_permissions_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.strapi_transfer_token_permissions
    ADD CONSTRAINT strapi_transfer_token_permissions_pkey PRIMARY KEY (id);


--
-- Name: strapi_transfer_token_permissions_token_lnk strapi_transfer_token_permissions_token_lnk_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.strapi_transfer_token_permissions_token_lnk
    ADD CONSTRAINT strapi_transfer_token_permissions_token_lnk_pkey PRIMARY KEY (id);


--
-- Name: strapi_transfer_token_permissions_token_lnk strapi_transfer_token_permissions_token_lnk_uq; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.strapi_transfer_token_permissions_token_lnk
    ADD CONSTRAINT strapi_transfer_token_permissions_token_lnk_uq UNIQUE (transfer_token_permission_id, transfer_token_id);


--
-- Name: strapi_transfer_tokens strapi_transfer_tokens_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.strapi_transfer_tokens
    ADD CONSTRAINT strapi_transfer_tokens_pkey PRIMARY KEY (id);


--
-- Name: strapi_webhooks strapi_webhooks_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.strapi_webhooks
    ADD CONSTRAINT strapi_webhooks_pkey PRIMARY KEY (id);


--
-- Name: strapi_workflows strapi_workflows_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.strapi_workflows
    ADD CONSTRAINT strapi_workflows_pkey PRIMARY KEY (id);


--
-- Name: strapi_workflows_stage_required_to_publish_lnk strapi_workflows_stage_required_to_publish_lnk_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.strapi_workflows_stage_required_to_publish_lnk
    ADD CONSTRAINT strapi_workflows_stage_required_to_publish_lnk_pkey PRIMARY KEY (id);


--
-- Name: strapi_workflows_stage_required_to_publish_lnk strapi_workflows_stage_required_to_publish_lnk_uq; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.strapi_workflows_stage_required_to_publish_lnk
    ADD CONSTRAINT strapi_workflows_stage_required_to_publish_lnk_uq UNIQUE (workflow_id, workflow_stage_id);


--
-- Name: strapi_workflows_stages_permissions_lnk strapi_workflows_stages_permissions_lnk_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.strapi_workflows_stages_permissions_lnk
    ADD CONSTRAINT strapi_workflows_stages_permissions_lnk_pkey PRIMARY KEY (id);


--
-- Name: strapi_workflows_stages_permissions_lnk strapi_workflows_stages_permissions_lnk_uq; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.strapi_workflows_stages_permissions_lnk
    ADD CONSTRAINT strapi_workflows_stages_permissions_lnk_uq UNIQUE (workflow_stage_id, permission_id);


--
-- Name: strapi_workflows_stages strapi_workflows_stages_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.strapi_workflows_stages
    ADD CONSTRAINT strapi_workflows_stages_pkey PRIMARY KEY (id);


--
-- Name: strapi_workflows_stages_workflow_lnk strapi_workflows_stages_workflow_lnk_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.strapi_workflows_stages_workflow_lnk
    ADD CONSTRAINT strapi_workflows_stages_workflow_lnk_pkey PRIMARY KEY (id);


--
-- Name: strapi_workflows_stages_workflow_lnk strapi_workflows_stages_workflow_lnk_uq; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.strapi_workflows_stages_workflow_lnk
    ADD CONSTRAINT strapi_workflows_stages_workflow_lnk_uq UNIQUE (workflow_stage_id, workflow_id);


--
-- Name: testimonials testimonials_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.testimonials
    ADD CONSTRAINT testimonials_pkey PRIMARY KEY (id);


--
-- Name: up_permissions up_permissions_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.up_permissions
    ADD CONSTRAINT up_permissions_pkey PRIMARY KEY (id);


--
-- Name: up_permissions_role_lnk up_permissions_role_lnk_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.up_permissions_role_lnk
    ADD CONSTRAINT up_permissions_role_lnk_pkey PRIMARY KEY (id);


--
-- Name: up_permissions_role_lnk up_permissions_role_lnk_uq; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.up_permissions_role_lnk
    ADD CONSTRAINT up_permissions_role_lnk_uq UNIQUE (permission_id, role_id);


--
-- Name: up_roles up_roles_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.up_roles
    ADD CONSTRAINT up_roles_pkey PRIMARY KEY (id);


--
-- Name: up_users up_users_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.up_users
    ADD CONSTRAINT up_users_pkey PRIMARY KEY (id);


--
-- Name: upload_folders_parent_lnk upload_folders_parent_lnk_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.upload_folders_parent_lnk
    ADD CONSTRAINT upload_folders_parent_lnk_pkey PRIMARY KEY (id);


--
-- Name: upload_folders_parent_lnk upload_folders_parent_lnk_uq; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.upload_folders_parent_lnk
    ADD CONSTRAINT upload_folders_parent_lnk_uq UNIQUE (folder_id, inv_folder_id);


--
-- Name: upload_folders upload_folders_path_id_index; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.upload_folders
    ADD CONSTRAINT upload_folders_path_id_index UNIQUE (path_id);


--
-- Name: upload_folders upload_folders_path_index; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.upload_folders
    ADD CONSTRAINT upload_folders_path_index UNIQUE (path);


--
-- Name: upload_folders upload_folders_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.upload_folders
    ADD CONSTRAINT upload_folders_pkey PRIMARY KEY (id);


--
-- Name: wishlist_items wishlist_items_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.wishlist_items
    ADD CONSTRAINT wishlist_items_pkey PRIMARY KEY (id);


--
-- Name: wishlist_items_product_lnk wishlist_items_product_lnk_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.wishlist_items_product_lnk
    ADD CONSTRAINT wishlist_items_product_lnk_pkey PRIMARY KEY (id);


--
-- Name: wishlist_items_product_lnk wishlist_items_product_lnk_uq; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.wishlist_items_product_lnk
    ADD CONSTRAINT wishlist_items_product_lnk_uq UNIQUE (wishlist_item_id, product_id);


--
-- Name: wishlist_items_user_lnk wishlist_items_user_lnk_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.wishlist_items_user_lnk
    ADD CONSTRAINT wishlist_items_user_lnk_pkey PRIMARY KEY (id);


--
-- Name: wishlist_items_user_lnk wishlist_items_user_lnk_uq; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.wishlist_items_user_lnk
    ADD CONSTRAINT wishlist_items_user_lnk_uq UNIQUE (wishlist_item_id, user_id);


--
-- Name: admin_permissions_created_by_id_fk; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX admin_permissions_created_by_id_fk ON public.admin_permissions USING btree (created_by_id);


--
-- Name: admin_permissions_documents_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX admin_permissions_documents_idx ON public.admin_permissions USING btree (document_id, locale, published_at);


--
-- Name: admin_permissions_role_lnk_fk; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX admin_permissions_role_lnk_fk ON public.admin_permissions_role_lnk USING btree (permission_id);


--
-- Name: admin_permissions_role_lnk_ifk; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX admin_permissions_role_lnk_ifk ON public.admin_permissions_role_lnk USING btree (role_id);


--
-- Name: admin_permissions_role_lnk_oifk; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX admin_permissions_role_lnk_oifk ON public.admin_permissions_role_lnk USING btree (permission_ord);


--
-- Name: admin_permissions_updated_by_id_fk; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX admin_permissions_updated_by_id_fk ON public.admin_permissions USING btree (updated_by_id);


--
-- Name: admin_roles_created_by_id_fk; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX admin_roles_created_by_id_fk ON public.admin_roles USING btree (created_by_id);


--
-- Name: admin_roles_documents_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX admin_roles_documents_idx ON public.admin_roles USING btree (document_id, locale, published_at);


--
-- Name: admin_roles_updated_by_id_fk; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX admin_roles_updated_by_id_fk ON public.admin_roles USING btree (updated_by_id);


--
-- Name: admin_users_created_by_id_fk; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX admin_users_created_by_id_fk ON public.admin_users USING btree (created_by_id);


--
-- Name: admin_users_documents_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX admin_users_documents_idx ON public.admin_users USING btree (document_id, locale, published_at);


--
-- Name: admin_users_roles_lnk_fk; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX admin_users_roles_lnk_fk ON public.admin_users_roles_lnk USING btree (user_id);


--
-- Name: admin_users_roles_lnk_ifk; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX admin_users_roles_lnk_ifk ON public.admin_users_roles_lnk USING btree (role_id);


--
-- Name: admin_users_roles_lnk_ofk; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX admin_users_roles_lnk_ofk ON public.admin_users_roles_lnk USING btree (role_ord);


--
-- Name: admin_users_roles_lnk_oifk; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX admin_users_roles_lnk_oifk ON public.admin_users_roles_lnk USING btree (user_ord);


--
-- Name: admin_users_updated_by_id_fk; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX admin_users_updated_by_id_fk ON public.admin_users USING btree (updated_by_id);


--
-- Name: availability_rules_created_by_id_fk; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX availability_rules_created_by_id_fk ON public.availability_rules USING btree (created_by_id);


--
-- Name: availability_rules_documents_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX availability_rules_documents_idx ON public.availability_rules USING btree (document_id, locale, published_at);


--
-- Name: availability_rules_updated_by_id_fk; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX availability_rules_updated_by_id_fk ON public.availability_rules USING btree (updated_by_id);


--
-- Name: banners_created_by_id_fk; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX banners_created_by_id_fk ON public.banners USING btree (created_by_id);


--
-- Name: banners_documents_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX banners_documents_idx ON public.banners USING btree (document_id, locale, published_at);


--
-- Name: banners_updated_by_id_fk; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX banners_updated_by_id_fk ON public.banners USING btree (updated_by_id);


--
-- Name: blocked_slots_created_by_id_fk; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX blocked_slots_created_by_id_fk ON public.blocked_slots USING btree (created_by_id);


--
-- Name: blocked_slots_documents_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX blocked_slots_documents_idx ON public.blocked_slots USING btree (document_id, locale, published_at);


--
-- Name: blocked_slots_updated_by_id_fk; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX blocked_slots_updated_by_id_fk ON public.blocked_slots USING btree (updated_by_id);


--
-- Name: booking_setting_created_by_id_fk; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX booking_setting_created_by_id_fk ON public.booking_setting USING btree (created_by_id);


--
-- Name: booking_setting_documents_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX booking_setting_documents_idx ON public.booking_setting USING btree (document_id, locale, published_at);


--
-- Name: booking_setting_updated_by_id_fk; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX booking_setting_updated_by_id_fk ON public.booking_setting USING btree (updated_by_id);


--
-- Name: bookings_created_by_id_fk; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX bookings_created_by_id_fk ON public.bookings USING btree (created_by_id);


--
-- Name: bookings_documents_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX bookings_documents_idx ON public.bookings USING btree (document_id, locale, published_at);


--
-- Name: bookings_service_lnk_fk; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX bookings_service_lnk_fk ON public.bookings_service_lnk USING btree (booking_id);


--
-- Name: bookings_service_lnk_ifk; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX bookings_service_lnk_ifk ON public.bookings_service_lnk USING btree (service_id);


--
-- Name: bookings_service_lnk_oifk; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX bookings_service_lnk_oifk ON public.bookings_service_lnk USING btree (booking_ord);


--
-- Name: bookings_updated_by_id_fk; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX bookings_updated_by_id_fk ON public.bookings USING btree (updated_by_id);


--
-- Name: bookings_user_lnk_fk; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX bookings_user_lnk_fk ON public.bookings_user_lnk USING btree (booking_id);


--
-- Name: bookings_user_lnk_ifk; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX bookings_user_lnk_ifk ON public.bookings_user_lnk USING btree (user_id);


--
-- Name: bookings_user_lnk_oifk; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX bookings_user_lnk_oifk ON public.bookings_user_lnk USING btree (booking_ord);


--
-- Name: business_setting_created_by_id_fk; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX business_setting_created_by_id_fk ON public.business_setting USING btree (created_by_id);


--
-- Name: business_setting_documents_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX business_setting_documents_idx ON public.business_setting USING btree (document_id, locale, published_at);


--
-- Name: business_setting_updated_by_id_fk; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX business_setting_updated_by_id_fk ON public.business_setting USING btree (updated_by_id);


--
-- Name: cart_items_created_by_id_fk; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX cart_items_created_by_id_fk ON public.cart_items USING btree (created_by_id);


--
-- Name: cart_items_documents_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX cart_items_documents_idx ON public.cart_items USING btree (document_id, locale, published_at);


--
-- Name: cart_items_product_lnk_fk; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX cart_items_product_lnk_fk ON public.cart_items_product_lnk USING btree (cart_item_id);


--
-- Name: cart_items_product_lnk_ifk; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX cart_items_product_lnk_ifk ON public.cart_items_product_lnk USING btree (product_id);


--
-- Name: cart_items_product_lnk_oifk; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX cart_items_product_lnk_oifk ON public.cart_items_product_lnk USING btree (cart_item_ord);


--
-- Name: cart_items_updated_by_id_fk; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX cart_items_updated_by_id_fk ON public.cart_items USING btree (updated_by_id);


--
-- Name: cart_items_user_lnk_fk; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX cart_items_user_lnk_fk ON public.cart_items_user_lnk USING btree (cart_item_id);


--
-- Name: cart_items_user_lnk_ifk; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX cart_items_user_lnk_ifk ON public.cart_items_user_lnk USING btree (user_id);


--
-- Name: cart_items_user_lnk_oifk; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX cart_items_user_lnk_oifk ON public.cart_items_user_lnk USING btree (cart_item_ord);


--
-- Name: commerce_placeholders_created_by_id_fk; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX commerce_placeholders_created_by_id_fk ON public.commerce_placeholders USING btree (created_by_id);


--
-- Name: commerce_placeholders_documents_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX commerce_placeholders_documents_idx ON public.commerce_placeholders USING btree (document_id, locale, published_at);


--
-- Name: commerce_placeholders_updated_by_id_fk; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX commerce_placeholders_updated_by_id_fk ON public.commerce_placeholders USING btree (updated_by_id);


--
-- Name: contact_messages_created_by_id_fk; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX contact_messages_created_by_id_fk ON public.contact_messages USING btree (created_by_id);


--
-- Name: contact_messages_documents_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX contact_messages_documents_idx ON public.contact_messages USING btree (document_id, locale, published_at);


--
-- Name: contact_messages_updated_by_id_fk; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX contact_messages_updated_by_id_fk ON public.contact_messages USING btree (updated_by_id);


--
-- Name: coupon_codes_created_by_id_fk; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX coupon_codes_created_by_id_fk ON public.coupon_codes USING btree (created_by_id);


--
-- Name: coupon_codes_documents_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX coupon_codes_documents_idx ON public.coupon_codes USING btree (document_id, locale, published_at);


--
-- Name: coupon_codes_updated_by_id_fk; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX coupon_codes_updated_by_id_fk ON public.coupon_codes USING btree (updated_by_id);


--
-- Name: coupon_usages_coupon_lnk_fk; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX coupon_usages_coupon_lnk_fk ON public.coupon_usages_coupon_lnk USING btree (coupon_usage_id);


--
-- Name: coupon_usages_coupon_lnk_ifk; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX coupon_usages_coupon_lnk_ifk ON public.coupon_usages_coupon_lnk USING btree (coupon_code_id);


--
-- Name: coupon_usages_coupon_lnk_oifk; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX coupon_usages_coupon_lnk_oifk ON public.coupon_usages_coupon_lnk USING btree (coupon_usage_ord);


--
-- Name: coupon_usages_created_by_id_fk; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX coupon_usages_created_by_id_fk ON public.coupon_usages USING btree (created_by_id);


--
-- Name: coupon_usages_documents_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX coupon_usages_documents_idx ON public.coupon_usages USING btree (document_id, locale, published_at);


--
-- Name: coupon_usages_order_lnk_fk; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX coupon_usages_order_lnk_fk ON public.coupon_usages_order_lnk USING btree (coupon_usage_id);


--
-- Name: coupon_usages_order_lnk_ifk; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX coupon_usages_order_lnk_ifk ON public.coupon_usages_order_lnk USING btree (order_id);


--
-- Name: coupon_usages_order_lnk_oifk; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX coupon_usages_order_lnk_oifk ON public.coupon_usages_order_lnk USING btree (coupon_usage_ord);


--
-- Name: coupon_usages_updated_by_id_fk; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX coupon_usages_updated_by_id_fk ON public.coupon_usages USING btree (updated_by_id);


--
-- Name: coupon_usages_user_lnk_fk; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX coupon_usages_user_lnk_fk ON public.coupon_usages_user_lnk USING btree (coupon_usage_id);


--
-- Name: coupon_usages_user_lnk_ifk; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX coupon_usages_user_lnk_ifk ON public.coupon_usages_user_lnk USING btree (user_id);


--
-- Name: coupon_usages_user_lnk_oifk; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX coupon_usages_user_lnk_oifk ON public.coupon_usages_user_lnk USING btree (coupon_usage_ord);


--
-- Name: digital_assets_created_by_id_fk; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX digital_assets_created_by_id_fk ON public.digital_assets USING btree (created_by_id);


--
-- Name: digital_assets_documents_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX digital_assets_documents_idx ON public.digital_assets USING btree (document_id, locale, published_at);


--
-- Name: digital_assets_product_lnk_fk; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX digital_assets_product_lnk_fk ON public.digital_assets_product_lnk USING btree (digital_asset_id);


--
-- Name: digital_assets_product_lnk_ifk; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX digital_assets_product_lnk_ifk ON public.digital_assets_product_lnk USING btree (product_id);


--
-- Name: digital_assets_product_lnk_oifk; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX digital_assets_product_lnk_oifk ON public.digital_assets_product_lnk USING btree (digital_asset_ord);


--
-- Name: digital_assets_updated_by_id_fk; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX digital_assets_updated_by_id_fk ON public.digital_assets USING btree (updated_by_id);


--
-- Name: digital_purchases_asset_lnk_fk; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX digital_purchases_asset_lnk_fk ON public.digital_purchases_asset_lnk USING btree (digital_purchase_id);


--
-- Name: digital_purchases_asset_lnk_ifk; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX digital_purchases_asset_lnk_ifk ON public.digital_purchases_asset_lnk USING btree (digital_asset_id);


--
-- Name: digital_purchases_asset_lnk_oifk; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX digital_purchases_asset_lnk_oifk ON public.digital_purchases_asset_lnk USING btree (digital_purchase_ord);


--
-- Name: digital_purchases_created_by_id_fk; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX digital_purchases_created_by_id_fk ON public.digital_purchases USING btree (created_by_id);


--
-- Name: digital_purchases_documents_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX digital_purchases_documents_idx ON public.digital_purchases USING btree (document_id, locale, published_at);


--
-- Name: digital_purchases_order_lnk_fk; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX digital_purchases_order_lnk_fk ON public.digital_purchases_order_lnk USING btree (digital_purchase_id);


--
-- Name: digital_purchases_order_lnk_ifk; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX digital_purchases_order_lnk_ifk ON public.digital_purchases_order_lnk USING btree (order_id);


--
-- Name: digital_purchases_order_lnk_oifk; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX digital_purchases_order_lnk_oifk ON public.digital_purchases_order_lnk USING btree (digital_purchase_ord);


--
-- Name: digital_purchases_product_lnk_fk; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX digital_purchases_product_lnk_fk ON public.digital_purchases_product_lnk USING btree (digital_purchase_id);


--
-- Name: digital_purchases_product_lnk_ifk; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX digital_purchases_product_lnk_ifk ON public.digital_purchases_product_lnk USING btree (product_id);


--
-- Name: digital_purchases_product_lnk_oifk; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX digital_purchases_product_lnk_oifk ON public.digital_purchases_product_lnk USING btree (digital_purchase_ord);


--
-- Name: digital_purchases_updated_by_id_fk; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX digital_purchases_updated_by_id_fk ON public.digital_purchases USING btree (updated_by_id);


--
-- Name: digital_purchases_user_lnk_fk; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX digital_purchases_user_lnk_fk ON public.digital_purchases_user_lnk USING btree (digital_purchase_id);


--
-- Name: digital_purchases_user_lnk_ifk; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX digital_purchases_user_lnk_ifk ON public.digital_purchases_user_lnk USING btree (user_id);


--
-- Name: digital_purchases_user_lnk_oifk; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX digital_purchases_user_lnk_oifk ON public.digital_purchases_user_lnk USING btree (digital_purchase_ord);


--
-- Name: email_logs_created_by_id_fk; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX email_logs_created_by_id_fk ON public.email_logs USING btree (created_by_id);


--
-- Name: email_logs_documents_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX email_logs_documents_idx ON public.email_logs USING btree (document_id, locale, published_at);


--
-- Name: email_logs_updated_by_id_fk; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX email_logs_updated_by_id_fk ON public.email_logs USING btree (updated_by_id);


--
-- Name: files_created_by_id_fk; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX files_created_by_id_fk ON public.files USING btree (created_by_id);


--
-- Name: files_documents_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX files_documents_idx ON public.files USING btree (document_id, locale, published_at);


--
-- Name: files_folder_lnk_fk; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX files_folder_lnk_fk ON public.files_folder_lnk USING btree (file_id);


--
-- Name: files_folder_lnk_ifk; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX files_folder_lnk_ifk ON public.files_folder_lnk USING btree (folder_id);


--
-- Name: files_folder_lnk_oifk; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX files_folder_lnk_oifk ON public.files_folder_lnk USING btree (file_ord);


--
-- Name: files_related_mph_fk; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX files_related_mph_fk ON public.files_related_mph USING btree (file_id);


--
-- Name: files_related_mph_idix; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX files_related_mph_idix ON public.files_related_mph USING btree (related_id);


--
-- Name: files_related_mph_oidx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX files_related_mph_oidx ON public.files_related_mph USING btree ("order");


--
-- Name: files_updated_by_id_fk; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX files_updated_by_id_fk ON public.files USING btree (updated_by_id);


--
-- Name: i18n_locale_created_by_id_fk; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX i18n_locale_created_by_id_fk ON public.i18n_locale USING btree (created_by_id);


--
-- Name: i18n_locale_documents_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX i18n_locale_documents_idx ON public.i18n_locale USING btree (document_id, locale, published_at);


--
-- Name: i18n_locale_updated_by_id_fk; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX i18n_locale_updated_by_id_fk ON public.i18n_locale USING btree (updated_by_id);


--
-- Name: invoices_created_by_id_fk; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX invoices_created_by_id_fk ON public.invoices USING btree (created_by_id);


--
-- Name: invoices_documents_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX invoices_documents_idx ON public.invoices USING btree (document_id, locale, published_at);


--
-- Name: invoices_order_lnk_fk; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX invoices_order_lnk_fk ON public.invoices_order_lnk USING btree (invoice_id);


--
-- Name: invoices_order_lnk_ifk; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX invoices_order_lnk_ifk ON public.invoices_order_lnk USING btree (order_id);


--
-- Name: invoices_updated_by_id_fk; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX invoices_updated_by_id_fk ON public.invoices USING btree (updated_by_id);


--
-- Name: legal_pages_created_by_id_fk; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX legal_pages_created_by_id_fk ON public.legal_pages USING btree (created_by_id);


--
-- Name: legal_pages_documents_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX legal_pages_documents_idx ON public.legal_pages USING btree (document_id, locale, published_at);


--
-- Name: legal_pages_updated_by_id_fk; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX legal_pages_updated_by_id_fk ON public.legal_pages USING btree (updated_by_id);


--
-- Name: order_items_created_by_id_fk; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX order_items_created_by_id_fk ON public.order_items USING btree (created_by_id);


--
-- Name: order_items_documents_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX order_items_documents_idx ON public.order_items USING btree (document_id, locale, published_at);


--
-- Name: order_items_order_lnk_fk; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX order_items_order_lnk_fk ON public.order_items_order_lnk USING btree (order_item_id);


--
-- Name: order_items_order_lnk_ifk; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX order_items_order_lnk_ifk ON public.order_items_order_lnk USING btree (order_id);


--
-- Name: order_items_order_lnk_oifk; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX order_items_order_lnk_oifk ON public.order_items_order_lnk USING btree (order_item_ord);


--
-- Name: order_items_product_lnk_fk; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX order_items_product_lnk_fk ON public.order_items_product_lnk USING btree (order_item_id);


--
-- Name: order_items_product_lnk_ifk; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX order_items_product_lnk_ifk ON public.order_items_product_lnk USING btree (product_id);


--
-- Name: order_items_product_lnk_oifk; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX order_items_product_lnk_oifk ON public.order_items_product_lnk USING btree (order_item_ord);


--
-- Name: order_items_updated_by_id_fk; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX order_items_updated_by_id_fk ON public.order_items USING btree (updated_by_id);


--
-- Name: order_shipments_created_by_id_fk; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX order_shipments_created_by_id_fk ON public.order_shipments USING btree (created_by_id);


--
-- Name: order_shipments_documents_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX order_shipments_documents_idx ON public.order_shipments USING btree (document_id, locale, published_at);


--
-- Name: order_shipments_order_lnk_fk; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX order_shipments_order_lnk_fk ON public.order_shipments_order_lnk USING btree (order_shipment_id);


--
-- Name: order_shipments_order_lnk_ifk; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX order_shipments_order_lnk_ifk ON public.order_shipments_order_lnk USING btree (order_id);


--
-- Name: order_shipments_updated_by_id_fk; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX order_shipments_updated_by_id_fk ON public.order_shipments USING btree (updated_by_id);


--
-- Name: orders_coupon_lnk_fk; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX orders_coupon_lnk_fk ON public.orders_coupon_lnk USING btree (order_id);


--
-- Name: orders_coupon_lnk_ifk; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX orders_coupon_lnk_ifk ON public.orders_coupon_lnk USING btree (coupon_code_id);


--
-- Name: orders_coupon_lnk_oifk; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX orders_coupon_lnk_oifk ON public.orders_coupon_lnk USING btree (order_ord);


--
-- Name: orders_created_by_id_fk; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX orders_created_by_id_fk ON public.orders USING btree (created_by_id);


--
-- Name: orders_documents_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX orders_documents_idx ON public.orders USING btree (document_id, locale, published_at);


--
-- Name: orders_updated_by_id_fk; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX orders_updated_by_id_fk ON public.orders USING btree (updated_by_id);


--
-- Name: orders_user_lnk_fk; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX orders_user_lnk_fk ON public.orders_user_lnk USING btree (order_id);


--
-- Name: orders_user_lnk_ifk; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX orders_user_lnk_ifk ON public.orders_user_lnk USING btree (user_id);


--
-- Name: orders_user_lnk_oifk; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX orders_user_lnk_oifk ON public.orders_user_lnk USING btree (order_ord);


--
-- Name: password_reset_tokens_created_by_id_fk; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX password_reset_tokens_created_by_id_fk ON public.password_reset_tokens USING btree (created_by_id);


--
-- Name: password_reset_tokens_documents_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX password_reset_tokens_documents_idx ON public.password_reset_tokens USING btree (document_id, locale, published_at);


--
-- Name: password_reset_tokens_updated_by_id_fk; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX password_reset_tokens_updated_by_id_fk ON public.password_reset_tokens USING btree (updated_by_id);


--
-- Name: password_reset_tokens_user_lnk_fk; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX password_reset_tokens_user_lnk_fk ON public.password_reset_tokens_user_lnk USING btree (password_reset_token_id);


--
-- Name: password_reset_tokens_user_lnk_ifk; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX password_reset_tokens_user_lnk_ifk ON public.password_reset_tokens_user_lnk USING btree (user_id);


--
-- Name: password_reset_tokens_user_lnk_oifk; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX password_reset_tokens_user_lnk_oifk ON public.password_reset_tokens_user_lnk USING btree (password_reset_token_ord);


--
-- Name: popups_created_by_id_fk; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX popups_created_by_id_fk ON public.popups USING btree (created_by_id);


--
-- Name: popups_documents_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX popups_documents_idx ON public.popups USING btree (document_id, locale, published_at);


--
-- Name: popups_updated_by_id_fk; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX popups_updated_by_id_fk ON public.popups USING btree (updated_by_id);


--
-- Name: product_categories_created_by_id_fk; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX product_categories_created_by_id_fk ON public.product_categories USING btree (created_by_id);


--
-- Name: product_categories_documents_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX product_categories_documents_idx ON public.product_categories USING btree (document_id, locale, published_at);


--
-- Name: product_categories_updated_by_id_fk; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX product_categories_updated_by_id_fk ON public.product_categories USING btree (updated_by_id);


--
-- Name: product_variants_created_by_id_fk; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX product_variants_created_by_id_fk ON public.product_variants USING btree (created_by_id);


--
-- Name: product_variants_documents_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX product_variants_documents_idx ON public.product_variants USING btree (document_id, locale, published_at);


--
-- Name: product_variants_product_lnk_fk; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX product_variants_product_lnk_fk ON public.product_variants_product_lnk USING btree (product_variant_id);


--
-- Name: product_variants_product_lnk_ifk; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX product_variants_product_lnk_ifk ON public.product_variants_product_lnk USING btree (product_id);


--
-- Name: product_variants_product_lnk_oifk; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX product_variants_product_lnk_oifk ON public.product_variants_product_lnk USING btree (product_variant_ord);


--
-- Name: product_variants_updated_by_id_fk; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX product_variants_updated_by_id_fk ON public.product_variants USING btree (updated_by_id);


--
-- Name: products_category_lnk_fk; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX products_category_lnk_fk ON public.products_category_lnk USING btree (product_id);


--
-- Name: products_category_lnk_ifk; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX products_category_lnk_ifk ON public.products_category_lnk USING btree (product_category_id);


--
-- Name: products_category_lnk_oifk; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX products_category_lnk_oifk ON public.products_category_lnk USING btree (product_ord);


--
-- Name: products_created_by_id_fk; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX products_created_by_id_fk ON public.products USING btree (created_by_id);


--
-- Name: products_documents_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX products_documents_idx ON public.products USING btree (document_id, locale, published_at);


--
-- Name: products_shipping_class_lnk_fk; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX products_shipping_class_lnk_fk ON public.products_shipping_class_lnk USING btree (product_id);


--
-- Name: products_shipping_class_lnk_ifk; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX products_shipping_class_lnk_ifk ON public.products_shipping_class_lnk USING btree (shipping_class_id);


--
-- Name: products_shipping_class_lnk_oifk; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX products_shipping_class_lnk_oifk ON public.products_shipping_class_lnk USING btree (product_ord);


--
-- Name: products_updated_by_id_fk; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX products_updated_by_id_fk ON public.products USING btree (updated_by_id);


--
-- Name: promo_rules_created_by_id_fk; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX promo_rules_created_by_id_fk ON public.promo_rules USING btree (created_by_id);


--
-- Name: promo_rules_documents_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX promo_rules_documents_idx ON public.promo_rules USING btree (document_id, locale, published_at);


--
-- Name: promo_rules_updated_by_id_fk; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX promo_rules_updated_by_id_fk ON public.promo_rules USING btree (updated_by_id);


--
-- Name: reviews_created_by_id_fk; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX reviews_created_by_id_fk ON public.reviews USING btree (created_by_id);


--
-- Name: reviews_documents_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX reviews_documents_idx ON public.reviews USING btree (document_id, locale, published_at);


--
-- Name: reviews_product_lnk_fk; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX reviews_product_lnk_fk ON public.reviews_product_lnk USING btree (review_id);


--
-- Name: reviews_product_lnk_ifk; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX reviews_product_lnk_ifk ON public.reviews_product_lnk USING btree (product_id);


--
-- Name: reviews_product_lnk_oifk; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX reviews_product_lnk_oifk ON public.reviews_product_lnk USING btree (review_ord);


--
-- Name: reviews_updated_by_id_fk; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX reviews_updated_by_id_fk ON public.reviews USING btree (updated_by_id);


--
-- Name: reviews_user_lnk_fk; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX reviews_user_lnk_fk ON public.reviews_user_lnk USING btree (review_id);


--
-- Name: reviews_user_lnk_ifk; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX reviews_user_lnk_ifk ON public.reviews_user_lnk USING btree (user_id);


--
-- Name: reviews_user_lnk_oifk; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX reviews_user_lnk_oifk ON public.reviews_user_lnk USING btree (review_ord);


--
-- Name: scheduled_reminders_booking_lnk_fk; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX scheduled_reminders_booking_lnk_fk ON public.scheduled_reminders_booking_lnk USING btree (scheduled_reminder_id);


--
-- Name: scheduled_reminders_booking_lnk_ifk; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX scheduled_reminders_booking_lnk_ifk ON public.scheduled_reminders_booking_lnk USING btree (booking_id);


--
-- Name: scheduled_reminders_booking_lnk_oifk; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX scheduled_reminders_booking_lnk_oifk ON public.scheduled_reminders_booking_lnk USING btree (scheduled_reminder_ord);


--
-- Name: scheduled_reminders_created_by_id_fk; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX scheduled_reminders_created_by_id_fk ON public.scheduled_reminders USING btree (created_by_id);


--
-- Name: scheduled_reminders_documents_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX scheduled_reminders_documents_idx ON public.scheduled_reminders USING btree (document_id, locale, published_at);


--
-- Name: scheduled_reminders_updated_by_id_fk; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX scheduled_reminders_updated_by_id_fk ON public.scheduled_reminders USING btree (updated_by_id);


--
-- Name: services_created_by_id_fk; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX services_created_by_id_fk ON public.services USING btree (created_by_id);


--
-- Name: services_documents_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX services_documents_idx ON public.services USING btree (document_id, locale, published_at);


--
-- Name: services_updated_by_id_fk; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX services_updated_by_id_fk ON public.services USING btree (updated_by_id);


--
-- Name: shipping_classes_created_by_id_fk; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX shipping_classes_created_by_id_fk ON public.shipping_classes USING btree (created_by_id);


--
-- Name: shipping_classes_documents_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX shipping_classes_documents_idx ON public.shipping_classes USING btree (document_id, locale, published_at);


--
-- Name: shipping_classes_updated_by_id_fk; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX shipping_classes_updated_by_id_fk ON public.shipping_classes USING btree (updated_by_id);


--
-- Name: strapi_api_token_permissions_created_by_id_fk; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX strapi_api_token_permissions_created_by_id_fk ON public.strapi_api_token_permissions USING btree (created_by_id);


--
-- Name: strapi_api_token_permissions_documents_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX strapi_api_token_permissions_documents_idx ON public.strapi_api_token_permissions USING btree (document_id, locale, published_at);


--
-- Name: strapi_api_token_permissions_token_lnk_fk; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX strapi_api_token_permissions_token_lnk_fk ON public.strapi_api_token_permissions_token_lnk USING btree (api_token_permission_id);


--
-- Name: strapi_api_token_permissions_token_lnk_ifk; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX strapi_api_token_permissions_token_lnk_ifk ON public.strapi_api_token_permissions_token_lnk USING btree (api_token_id);


--
-- Name: strapi_api_token_permissions_token_lnk_oifk; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX strapi_api_token_permissions_token_lnk_oifk ON public.strapi_api_token_permissions_token_lnk USING btree (api_token_permission_ord);


--
-- Name: strapi_api_token_permissions_updated_by_id_fk; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX strapi_api_token_permissions_updated_by_id_fk ON public.strapi_api_token_permissions USING btree (updated_by_id);


--
-- Name: strapi_api_tokens_created_by_id_fk; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX strapi_api_tokens_created_by_id_fk ON public.strapi_api_tokens USING btree (created_by_id);


--
-- Name: strapi_api_tokens_documents_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX strapi_api_tokens_documents_idx ON public.strapi_api_tokens USING btree (document_id, locale, published_at);


--
-- Name: strapi_api_tokens_updated_by_id_fk; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX strapi_api_tokens_updated_by_id_fk ON public.strapi_api_tokens USING btree (updated_by_id);


--
-- Name: strapi_history_versions_created_by_id_fk; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX strapi_history_versions_created_by_id_fk ON public.strapi_history_versions USING btree (created_by_id);


--
-- Name: strapi_release_actions_created_by_id_fk; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX strapi_release_actions_created_by_id_fk ON public.strapi_release_actions USING btree (created_by_id);


--
-- Name: strapi_release_actions_documents_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX strapi_release_actions_documents_idx ON public.strapi_release_actions USING btree (document_id, locale, published_at);


--
-- Name: strapi_release_actions_release_lnk_fk; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX strapi_release_actions_release_lnk_fk ON public.strapi_release_actions_release_lnk USING btree (release_action_id);


--
-- Name: strapi_release_actions_release_lnk_ifk; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX strapi_release_actions_release_lnk_ifk ON public.strapi_release_actions_release_lnk USING btree (release_id);


--
-- Name: strapi_release_actions_release_lnk_oifk; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX strapi_release_actions_release_lnk_oifk ON public.strapi_release_actions_release_lnk USING btree (release_action_ord);


--
-- Name: strapi_release_actions_updated_by_id_fk; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX strapi_release_actions_updated_by_id_fk ON public.strapi_release_actions USING btree (updated_by_id);


--
-- Name: strapi_releases_created_by_id_fk; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX strapi_releases_created_by_id_fk ON public.strapi_releases USING btree (created_by_id);


--
-- Name: strapi_releases_documents_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX strapi_releases_documents_idx ON public.strapi_releases USING btree (document_id, locale, published_at);


--
-- Name: strapi_releases_updated_by_id_fk; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX strapi_releases_updated_by_id_fk ON public.strapi_releases USING btree (updated_by_id);


--
-- Name: strapi_sessions_created_by_id_fk; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX strapi_sessions_created_by_id_fk ON public.strapi_sessions USING btree (created_by_id);


--
-- Name: strapi_sessions_documents_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX strapi_sessions_documents_idx ON public.strapi_sessions USING btree (document_id, locale, published_at);


--
-- Name: strapi_sessions_updated_by_id_fk; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX strapi_sessions_updated_by_id_fk ON public.strapi_sessions USING btree (updated_by_id);


--
-- Name: strapi_transfer_token_permissions_created_by_id_fk; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX strapi_transfer_token_permissions_created_by_id_fk ON public.strapi_transfer_token_permissions USING btree (created_by_id);


--
-- Name: strapi_transfer_token_permissions_documents_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX strapi_transfer_token_permissions_documents_idx ON public.strapi_transfer_token_permissions USING btree (document_id, locale, published_at);


--
-- Name: strapi_transfer_token_permissions_token_lnk_fk; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX strapi_transfer_token_permissions_token_lnk_fk ON public.strapi_transfer_token_permissions_token_lnk USING btree (transfer_token_permission_id);


--
-- Name: strapi_transfer_token_permissions_token_lnk_ifk; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX strapi_transfer_token_permissions_token_lnk_ifk ON public.strapi_transfer_token_permissions_token_lnk USING btree (transfer_token_id);


--
-- Name: strapi_transfer_token_permissions_token_lnk_oifk; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX strapi_transfer_token_permissions_token_lnk_oifk ON public.strapi_transfer_token_permissions_token_lnk USING btree (transfer_token_permission_ord);


--
-- Name: strapi_transfer_token_permissions_updated_by_id_fk; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX strapi_transfer_token_permissions_updated_by_id_fk ON public.strapi_transfer_token_permissions USING btree (updated_by_id);


--
-- Name: strapi_transfer_tokens_created_by_id_fk; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX strapi_transfer_tokens_created_by_id_fk ON public.strapi_transfer_tokens USING btree (created_by_id);


--
-- Name: strapi_transfer_tokens_documents_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX strapi_transfer_tokens_documents_idx ON public.strapi_transfer_tokens USING btree (document_id, locale, published_at);


--
-- Name: strapi_transfer_tokens_updated_by_id_fk; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX strapi_transfer_tokens_updated_by_id_fk ON public.strapi_transfer_tokens USING btree (updated_by_id);


--
-- Name: strapi_workflows_created_by_id_fk; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX strapi_workflows_created_by_id_fk ON public.strapi_workflows USING btree (created_by_id);


--
-- Name: strapi_workflows_documents_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX strapi_workflows_documents_idx ON public.strapi_workflows USING btree (document_id, locale, published_at);


--
-- Name: strapi_workflows_stage_required_to_publish_lnk_fk; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX strapi_workflows_stage_required_to_publish_lnk_fk ON public.strapi_workflows_stage_required_to_publish_lnk USING btree (workflow_id);


--
-- Name: strapi_workflows_stage_required_to_publish_lnk_ifk; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX strapi_workflows_stage_required_to_publish_lnk_ifk ON public.strapi_workflows_stage_required_to_publish_lnk USING btree (workflow_stage_id);


--
-- Name: strapi_workflows_stages_created_by_id_fk; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX strapi_workflows_stages_created_by_id_fk ON public.strapi_workflows_stages USING btree (created_by_id);


--
-- Name: strapi_workflows_stages_documents_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX strapi_workflows_stages_documents_idx ON public.strapi_workflows_stages USING btree (document_id, locale, published_at);


--
-- Name: strapi_workflows_stages_permissions_lnk_fk; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX strapi_workflows_stages_permissions_lnk_fk ON public.strapi_workflows_stages_permissions_lnk USING btree (workflow_stage_id);


--
-- Name: strapi_workflows_stages_permissions_lnk_ifk; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX strapi_workflows_stages_permissions_lnk_ifk ON public.strapi_workflows_stages_permissions_lnk USING btree (permission_id);


--
-- Name: strapi_workflows_stages_permissions_lnk_ofk; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX strapi_workflows_stages_permissions_lnk_ofk ON public.strapi_workflows_stages_permissions_lnk USING btree (permission_ord);


--
-- Name: strapi_workflows_stages_updated_by_id_fk; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX strapi_workflows_stages_updated_by_id_fk ON public.strapi_workflows_stages USING btree (updated_by_id);


--
-- Name: strapi_workflows_stages_workflow_lnk_fk; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX strapi_workflows_stages_workflow_lnk_fk ON public.strapi_workflows_stages_workflow_lnk USING btree (workflow_stage_id);


--
-- Name: strapi_workflows_stages_workflow_lnk_ifk; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX strapi_workflows_stages_workflow_lnk_ifk ON public.strapi_workflows_stages_workflow_lnk USING btree (workflow_id);


--
-- Name: strapi_workflows_stages_workflow_lnk_oifk; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX strapi_workflows_stages_workflow_lnk_oifk ON public.strapi_workflows_stages_workflow_lnk USING btree (workflow_stage_ord);


--
-- Name: strapi_workflows_updated_by_id_fk; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX strapi_workflows_updated_by_id_fk ON public.strapi_workflows USING btree (updated_by_id);


--
-- Name: testimonials_created_by_id_fk; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX testimonials_created_by_id_fk ON public.testimonials USING btree (created_by_id);


--
-- Name: testimonials_documents_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX testimonials_documents_idx ON public.testimonials USING btree (document_id, locale, published_at);


--
-- Name: testimonials_updated_by_id_fk; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX testimonials_updated_by_id_fk ON public.testimonials USING btree (updated_by_id);


--
-- Name: up_permissions_created_by_id_fk; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX up_permissions_created_by_id_fk ON public.up_permissions USING btree (created_by_id);


--
-- Name: up_permissions_documents_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX up_permissions_documents_idx ON public.up_permissions USING btree (document_id, locale, published_at);


--
-- Name: up_permissions_role_lnk_fk; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX up_permissions_role_lnk_fk ON public.up_permissions_role_lnk USING btree (permission_id);


--
-- Name: up_permissions_role_lnk_ifk; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX up_permissions_role_lnk_ifk ON public.up_permissions_role_lnk USING btree (role_id);


--
-- Name: up_permissions_role_lnk_oifk; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX up_permissions_role_lnk_oifk ON public.up_permissions_role_lnk USING btree (permission_ord);


--
-- Name: up_permissions_updated_by_id_fk; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX up_permissions_updated_by_id_fk ON public.up_permissions USING btree (updated_by_id);


--
-- Name: up_roles_created_by_id_fk; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX up_roles_created_by_id_fk ON public.up_roles USING btree (created_by_id);


--
-- Name: up_roles_documents_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX up_roles_documents_idx ON public.up_roles USING btree (document_id, locale, published_at);


--
-- Name: up_roles_updated_by_id_fk; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX up_roles_updated_by_id_fk ON public.up_roles USING btree (updated_by_id);


--
-- Name: up_users_created_by_id_fk; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX up_users_created_by_id_fk ON public.up_users USING btree (created_by_id);


--
-- Name: up_users_documents_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX up_users_documents_idx ON public.up_users USING btree (document_id, locale, published_at);


--
-- Name: up_users_updated_by_id_fk; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX up_users_updated_by_id_fk ON public.up_users USING btree (updated_by_id);


--
-- Name: upload_files_created_at_index; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX upload_files_created_at_index ON public.files USING btree (created_at);


--
-- Name: upload_files_ext_index; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX upload_files_ext_index ON public.files USING btree (ext);


--
-- Name: upload_files_folder_path_index; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX upload_files_folder_path_index ON public.files USING btree (folder_path);


--
-- Name: upload_files_name_index; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX upload_files_name_index ON public.files USING btree (name);


--
-- Name: upload_files_size_index; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX upload_files_size_index ON public.files USING btree (size);


--
-- Name: upload_files_updated_at_index; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX upload_files_updated_at_index ON public.files USING btree (updated_at);


--
-- Name: upload_folders_created_by_id_fk; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX upload_folders_created_by_id_fk ON public.upload_folders USING btree (created_by_id);


--
-- Name: upload_folders_documents_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX upload_folders_documents_idx ON public.upload_folders USING btree (document_id, locale, published_at);


--
-- Name: upload_folders_parent_lnk_fk; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX upload_folders_parent_lnk_fk ON public.upload_folders_parent_lnk USING btree (folder_id);


--
-- Name: upload_folders_parent_lnk_ifk; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX upload_folders_parent_lnk_ifk ON public.upload_folders_parent_lnk USING btree (inv_folder_id);


--
-- Name: upload_folders_parent_lnk_oifk; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX upload_folders_parent_lnk_oifk ON public.upload_folders_parent_lnk USING btree (folder_ord);


--
-- Name: upload_folders_updated_by_id_fk; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX upload_folders_updated_by_id_fk ON public.upload_folders USING btree (updated_by_id);


--
-- Name: wishlist_items_created_by_id_fk; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX wishlist_items_created_by_id_fk ON public.wishlist_items USING btree (created_by_id);


--
-- Name: wishlist_items_documents_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX wishlist_items_documents_idx ON public.wishlist_items USING btree (document_id, locale, published_at);


--
-- Name: wishlist_items_product_lnk_fk; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX wishlist_items_product_lnk_fk ON public.wishlist_items_product_lnk USING btree (wishlist_item_id);


--
-- Name: wishlist_items_product_lnk_ifk; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX wishlist_items_product_lnk_ifk ON public.wishlist_items_product_lnk USING btree (product_id);


--
-- Name: wishlist_items_product_lnk_oifk; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX wishlist_items_product_lnk_oifk ON public.wishlist_items_product_lnk USING btree (wishlist_item_ord);


--
-- Name: wishlist_items_updated_by_id_fk; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX wishlist_items_updated_by_id_fk ON public.wishlist_items USING btree (updated_by_id);


--
-- Name: wishlist_items_user_lnk_fk; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX wishlist_items_user_lnk_fk ON public.wishlist_items_user_lnk USING btree (wishlist_item_id);


--
-- Name: wishlist_items_user_lnk_ifk; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX wishlist_items_user_lnk_ifk ON public.wishlist_items_user_lnk USING btree (user_id);


--
-- Name: wishlist_items_user_lnk_oifk; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX wishlist_items_user_lnk_oifk ON public.wishlist_items_user_lnk USING btree (wishlist_item_ord);


--
-- Name: admin_permissions admin_permissions_created_by_id_fk; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.admin_permissions
    ADD CONSTRAINT admin_permissions_created_by_id_fk FOREIGN KEY (created_by_id) REFERENCES public.admin_users(id) ON DELETE SET NULL;


--
-- Name: admin_permissions_role_lnk admin_permissions_role_lnk_fk; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.admin_permissions_role_lnk
    ADD CONSTRAINT admin_permissions_role_lnk_fk FOREIGN KEY (permission_id) REFERENCES public.admin_permissions(id) ON DELETE CASCADE;


--
-- Name: admin_permissions_role_lnk admin_permissions_role_lnk_ifk; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.admin_permissions_role_lnk
    ADD CONSTRAINT admin_permissions_role_lnk_ifk FOREIGN KEY (role_id) REFERENCES public.admin_roles(id) ON DELETE CASCADE;


--
-- Name: admin_permissions admin_permissions_updated_by_id_fk; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.admin_permissions
    ADD CONSTRAINT admin_permissions_updated_by_id_fk FOREIGN KEY (updated_by_id) REFERENCES public.admin_users(id) ON DELETE SET NULL;


--
-- Name: admin_roles admin_roles_created_by_id_fk; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.admin_roles
    ADD CONSTRAINT admin_roles_created_by_id_fk FOREIGN KEY (created_by_id) REFERENCES public.admin_users(id) ON DELETE SET NULL;


--
-- Name: admin_roles admin_roles_updated_by_id_fk; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.admin_roles
    ADD CONSTRAINT admin_roles_updated_by_id_fk FOREIGN KEY (updated_by_id) REFERENCES public.admin_users(id) ON DELETE SET NULL;


--
-- Name: admin_users admin_users_created_by_id_fk; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.admin_users
    ADD CONSTRAINT admin_users_created_by_id_fk FOREIGN KEY (created_by_id) REFERENCES public.admin_users(id) ON DELETE SET NULL;


--
-- Name: admin_users_roles_lnk admin_users_roles_lnk_fk; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.admin_users_roles_lnk
    ADD CONSTRAINT admin_users_roles_lnk_fk FOREIGN KEY (user_id) REFERENCES public.admin_users(id) ON DELETE CASCADE;


--
-- Name: admin_users_roles_lnk admin_users_roles_lnk_ifk; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.admin_users_roles_lnk
    ADD CONSTRAINT admin_users_roles_lnk_ifk FOREIGN KEY (role_id) REFERENCES public.admin_roles(id) ON DELETE CASCADE;


--
-- Name: admin_users admin_users_updated_by_id_fk; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.admin_users
    ADD CONSTRAINT admin_users_updated_by_id_fk FOREIGN KEY (updated_by_id) REFERENCES public.admin_users(id) ON DELETE SET NULL;


--
-- Name: availability_rules availability_rules_created_by_id_fk; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.availability_rules
    ADD CONSTRAINT availability_rules_created_by_id_fk FOREIGN KEY (created_by_id) REFERENCES public.admin_users(id) ON DELETE SET NULL;


--
-- Name: availability_rules availability_rules_updated_by_id_fk; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.availability_rules
    ADD CONSTRAINT availability_rules_updated_by_id_fk FOREIGN KEY (updated_by_id) REFERENCES public.admin_users(id) ON DELETE SET NULL;


--
-- Name: banners banners_created_by_id_fk; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.banners
    ADD CONSTRAINT banners_created_by_id_fk FOREIGN KEY (created_by_id) REFERENCES public.admin_users(id) ON DELETE SET NULL;


--
-- Name: banners banners_updated_by_id_fk; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.banners
    ADD CONSTRAINT banners_updated_by_id_fk FOREIGN KEY (updated_by_id) REFERENCES public.admin_users(id) ON DELETE SET NULL;


--
-- Name: blocked_slots blocked_slots_created_by_id_fk; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.blocked_slots
    ADD CONSTRAINT blocked_slots_created_by_id_fk FOREIGN KEY (created_by_id) REFERENCES public.admin_users(id) ON DELETE SET NULL;


--
-- Name: blocked_slots blocked_slots_updated_by_id_fk; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.blocked_slots
    ADD CONSTRAINT blocked_slots_updated_by_id_fk FOREIGN KEY (updated_by_id) REFERENCES public.admin_users(id) ON DELETE SET NULL;


--
-- Name: booking_setting booking_setting_created_by_id_fk; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.booking_setting
    ADD CONSTRAINT booking_setting_created_by_id_fk FOREIGN KEY (created_by_id) REFERENCES public.admin_users(id) ON DELETE SET NULL;


--
-- Name: booking_setting booking_setting_updated_by_id_fk; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.booking_setting
    ADD CONSTRAINT booking_setting_updated_by_id_fk FOREIGN KEY (updated_by_id) REFERENCES public.admin_users(id) ON DELETE SET NULL;


--
-- Name: bookings bookings_created_by_id_fk; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.bookings
    ADD CONSTRAINT bookings_created_by_id_fk FOREIGN KEY (created_by_id) REFERENCES public.admin_users(id) ON DELETE SET NULL;


--
-- Name: bookings_service_lnk bookings_service_lnk_fk; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.bookings_service_lnk
    ADD CONSTRAINT bookings_service_lnk_fk FOREIGN KEY (booking_id) REFERENCES public.bookings(id) ON DELETE CASCADE;


--
-- Name: bookings_service_lnk bookings_service_lnk_ifk; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.bookings_service_lnk
    ADD CONSTRAINT bookings_service_lnk_ifk FOREIGN KEY (service_id) REFERENCES public.services(id) ON DELETE CASCADE;


--
-- Name: bookings bookings_updated_by_id_fk; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.bookings
    ADD CONSTRAINT bookings_updated_by_id_fk FOREIGN KEY (updated_by_id) REFERENCES public.admin_users(id) ON DELETE SET NULL;


--
-- Name: bookings_user_lnk bookings_user_lnk_fk; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.bookings_user_lnk
    ADD CONSTRAINT bookings_user_lnk_fk FOREIGN KEY (booking_id) REFERENCES public.bookings(id) ON DELETE CASCADE;


--
-- Name: bookings_user_lnk bookings_user_lnk_ifk; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.bookings_user_lnk
    ADD CONSTRAINT bookings_user_lnk_ifk FOREIGN KEY (user_id) REFERENCES public.up_users(id) ON DELETE CASCADE;


--
-- Name: business_setting business_setting_created_by_id_fk; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.business_setting
    ADD CONSTRAINT business_setting_created_by_id_fk FOREIGN KEY (created_by_id) REFERENCES public.admin_users(id) ON DELETE SET NULL;


--
-- Name: business_setting business_setting_updated_by_id_fk; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.business_setting
    ADD CONSTRAINT business_setting_updated_by_id_fk FOREIGN KEY (updated_by_id) REFERENCES public.admin_users(id) ON DELETE SET NULL;


--
-- Name: cart_items cart_items_created_by_id_fk; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.cart_items
    ADD CONSTRAINT cart_items_created_by_id_fk FOREIGN KEY (created_by_id) REFERENCES public.admin_users(id) ON DELETE SET NULL;


--
-- Name: cart_items_product_lnk cart_items_product_lnk_fk; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.cart_items_product_lnk
    ADD CONSTRAINT cart_items_product_lnk_fk FOREIGN KEY (cart_item_id) REFERENCES public.cart_items(id) ON DELETE CASCADE;


--
-- Name: cart_items_product_lnk cart_items_product_lnk_ifk; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.cart_items_product_lnk
    ADD CONSTRAINT cart_items_product_lnk_ifk FOREIGN KEY (product_id) REFERENCES public.products(id) ON DELETE CASCADE;


--
-- Name: cart_items cart_items_updated_by_id_fk; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.cart_items
    ADD CONSTRAINT cart_items_updated_by_id_fk FOREIGN KEY (updated_by_id) REFERENCES public.admin_users(id) ON DELETE SET NULL;


--
-- Name: cart_items_user_lnk cart_items_user_lnk_fk; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.cart_items_user_lnk
    ADD CONSTRAINT cart_items_user_lnk_fk FOREIGN KEY (cart_item_id) REFERENCES public.cart_items(id) ON DELETE CASCADE;


--
-- Name: cart_items_user_lnk cart_items_user_lnk_ifk; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.cart_items_user_lnk
    ADD CONSTRAINT cart_items_user_lnk_ifk FOREIGN KEY (user_id) REFERENCES public.up_users(id) ON DELETE CASCADE;


--
-- Name: commerce_placeholders commerce_placeholders_created_by_id_fk; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.commerce_placeholders
    ADD CONSTRAINT commerce_placeholders_created_by_id_fk FOREIGN KEY (created_by_id) REFERENCES public.admin_users(id) ON DELETE SET NULL;


--
-- Name: commerce_placeholders commerce_placeholders_updated_by_id_fk; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.commerce_placeholders
    ADD CONSTRAINT commerce_placeholders_updated_by_id_fk FOREIGN KEY (updated_by_id) REFERENCES public.admin_users(id) ON DELETE SET NULL;


--
-- Name: contact_messages contact_messages_created_by_id_fk; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.contact_messages
    ADD CONSTRAINT contact_messages_created_by_id_fk FOREIGN KEY (created_by_id) REFERENCES public.admin_users(id) ON DELETE SET NULL;


--
-- Name: contact_messages contact_messages_updated_by_id_fk; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.contact_messages
    ADD CONSTRAINT contact_messages_updated_by_id_fk FOREIGN KEY (updated_by_id) REFERENCES public.admin_users(id) ON DELETE SET NULL;


--
-- Name: coupon_codes coupon_codes_created_by_id_fk; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.coupon_codes
    ADD CONSTRAINT coupon_codes_created_by_id_fk FOREIGN KEY (created_by_id) REFERENCES public.admin_users(id) ON DELETE SET NULL;


--
-- Name: coupon_codes coupon_codes_updated_by_id_fk; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.coupon_codes
    ADD CONSTRAINT coupon_codes_updated_by_id_fk FOREIGN KEY (updated_by_id) REFERENCES public.admin_users(id) ON DELETE SET NULL;


--
-- Name: coupon_usages_coupon_lnk coupon_usages_coupon_lnk_fk; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.coupon_usages_coupon_lnk
    ADD CONSTRAINT coupon_usages_coupon_lnk_fk FOREIGN KEY (coupon_usage_id) REFERENCES public.coupon_usages(id) ON DELETE CASCADE;


--
-- Name: coupon_usages_coupon_lnk coupon_usages_coupon_lnk_ifk; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.coupon_usages_coupon_lnk
    ADD CONSTRAINT coupon_usages_coupon_lnk_ifk FOREIGN KEY (coupon_code_id) REFERENCES public.coupon_codes(id) ON DELETE CASCADE;


--
-- Name: coupon_usages coupon_usages_created_by_id_fk; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.coupon_usages
    ADD CONSTRAINT coupon_usages_created_by_id_fk FOREIGN KEY (created_by_id) REFERENCES public.admin_users(id) ON DELETE SET NULL;


--
-- Name: coupon_usages_order_lnk coupon_usages_order_lnk_fk; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.coupon_usages_order_lnk
    ADD CONSTRAINT coupon_usages_order_lnk_fk FOREIGN KEY (coupon_usage_id) REFERENCES public.coupon_usages(id) ON DELETE CASCADE;


--
-- Name: coupon_usages_order_lnk coupon_usages_order_lnk_ifk; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.coupon_usages_order_lnk
    ADD CONSTRAINT coupon_usages_order_lnk_ifk FOREIGN KEY (order_id) REFERENCES public.orders(id) ON DELETE CASCADE;


--
-- Name: coupon_usages coupon_usages_updated_by_id_fk; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.coupon_usages
    ADD CONSTRAINT coupon_usages_updated_by_id_fk FOREIGN KEY (updated_by_id) REFERENCES public.admin_users(id) ON DELETE SET NULL;


--
-- Name: coupon_usages_user_lnk coupon_usages_user_lnk_fk; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.coupon_usages_user_lnk
    ADD CONSTRAINT coupon_usages_user_lnk_fk FOREIGN KEY (coupon_usage_id) REFERENCES public.coupon_usages(id) ON DELETE CASCADE;


--
-- Name: coupon_usages_user_lnk coupon_usages_user_lnk_ifk; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.coupon_usages_user_lnk
    ADD CONSTRAINT coupon_usages_user_lnk_ifk FOREIGN KEY (user_id) REFERENCES public.up_users(id) ON DELETE CASCADE;


--
-- Name: digital_assets digital_assets_created_by_id_fk; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.digital_assets
    ADD CONSTRAINT digital_assets_created_by_id_fk FOREIGN KEY (created_by_id) REFERENCES public.admin_users(id) ON DELETE SET NULL;


--
-- Name: digital_assets_product_lnk digital_assets_product_lnk_fk; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.digital_assets_product_lnk
    ADD CONSTRAINT digital_assets_product_lnk_fk FOREIGN KEY (digital_asset_id) REFERENCES public.digital_assets(id) ON DELETE CASCADE;


--
-- Name: digital_assets_product_lnk digital_assets_product_lnk_ifk; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.digital_assets_product_lnk
    ADD CONSTRAINT digital_assets_product_lnk_ifk FOREIGN KEY (product_id) REFERENCES public.products(id) ON DELETE CASCADE;


--
-- Name: digital_assets digital_assets_updated_by_id_fk; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.digital_assets
    ADD CONSTRAINT digital_assets_updated_by_id_fk FOREIGN KEY (updated_by_id) REFERENCES public.admin_users(id) ON DELETE SET NULL;


--
-- Name: digital_purchases_asset_lnk digital_purchases_asset_lnk_fk; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.digital_purchases_asset_lnk
    ADD CONSTRAINT digital_purchases_asset_lnk_fk FOREIGN KEY (digital_purchase_id) REFERENCES public.digital_purchases(id) ON DELETE CASCADE;


--
-- Name: digital_purchases_asset_lnk digital_purchases_asset_lnk_ifk; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.digital_purchases_asset_lnk
    ADD CONSTRAINT digital_purchases_asset_lnk_ifk FOREIGN KEY (digital_asset_id) REFERENCES public.digital_assets(id) ON DELETE CASCADE;


--
-- Name: digital_purchases digital_purchases_created_by_id_fk; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.digital_purchases
    ADD CONSTRAINT digital_purchases_created_by_id_fk FOREIGN KEY (created_by_id) REFERENCES public.admin_users(id) ON DELETE SET NULL;


--
-- Name: digital_purchases_order_lnk digital_purchases_order_lnk_fk; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.digital_purchases_order_lnk
    ADD CONSTRAINT digital_purchases_order_lnk_fk FOREIGN KEY (digital_purchase_id) REFERENCES public.digital_purchases(id) ON DELETE CASCADE;


--
-- Name: digital_purchases_order_lnk digital_purchases_order_lnk_ifk; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.digital_purchases_order_lnk
    ADD CONSTRAINT digital_purchases_order_lnk_ifk FOREIGN KEY (order_id) REFERENCES public.orders(id) ON DELETE CASCADE;


--
-- Name: digital_purchases_product_lnk digital_purchases_product_lnk_fk; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.digital_purchases_product_lnk
    ADD CONSTRAINT digital_purchases_product_lnk_fk FOREIGN KEY (digital_purchase_id) REFERENCES public.digital_purchases(id) ON DELETE CASCADE;


--
-- Name: digital_purchases_product_lnk digital_purchases_product_lnk_ifk; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.digital_purchases_product_lnk
    ADD CONSTRAINT digital_purchases_product_lnk_ifk FOREIGN KEY (product_id) REFERENCES public.products(id) ON DELETE CASCADE;


--
-- Name: digital_purchases digital_purchases_updated_by_id_fk; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.digital_purchases
    ADD CONSTRAINT digital_purchases_updated_by_id_fk FOREIGN KEY (updated_by_id) REFERENCES public.admin_users(id) ON DELETE SET NULL;


--
-- Name: digital_purchases_user_lnk digital_purchases_user_lnk_fk; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.digital_purchases_user_lnk
    ADD CONSTRAINT digital_purchases_user_lnk_fk FOREIGN KEY (digital_purchase_id) REFERENCES public.digital_purchases(id) ON DELETE CASCADE;


--
-- Name: digital_purchases_user_lnk digital_purchases_user_lnk_ifk; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.digital_purchases_user_lnk
    ADD CONSTRAINT digital_purchases_user_lnk_ifk FOREIGN KEY (user_id) REFERENCES public.up_users(id) ON DELETE CASCADE;


--
-- Name: email_logs email_logs_created_by_id_fk; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.email_logs
    ADD CONSTRAINT email_logs_created_by_id_fk FOREIGN KEY (created_by_id) REFERENCES public.admin_users(id) ON DELETE SET NULL;


--
-- Name: email_logs email_logs_updated_by_id_fk; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.email_logs
    ADD CONSTRAINT email_logs_updated_by_id_fk FOREIGN KEY (updated_by_id) REFERENCES public.admin_users(id) ON DELETE SET NULL;


--
-- Name: files files_created_by_id_fk; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.files
    ADD CONSTRAINT files_created_by_id_fk FOREIGN KEY (created_by_id) REFERENCES public.admin_users(id) ON DELETE SET NULL;


--
-- Name: files_folder_lnk files_folder_lnk_fk; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.files_folder_lnk
    ADD CONSTRAINT files_folder_lnk_fk FOREIGN KEY (file_id) REFERENCES public.files(id) ON DELETE CASCADE;


--
-- Name: files_folder_lnk files_folder_lnk_ifk; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.files_folder_lnk
    ADD CONSTRAINT files_folder_lnk_ifk FOREIGN KEY (folder_id) REFERENCES public.upload_folders(id) ON DELETE CASCADE;


--
-- Name: files_related_mph files_related_mph_fk; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.files_related_mph
    ADD CONSTRAINT files_related_mph_fk FOREIGN KEY (file_id) REFERENCES public.files(id) ON DELETE CASCADE;


--
-- Name: files files_updated_by_id_fk; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.files
    ADD CONSTRAINT files_updated_by_id_fk FOREIGN KEY (updated_by_id) REFERENCES public.admin_users(id) ON DELETE SET NULL;


--
-- Name: i18n_locale i18n_locale_created_by_id_fk; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.i18n_locale
    ADD CONSTRAINT i18n_locale_created_by_id_fk FOREIGN KEY (created_by_id) REFERENCES public.admin_users(id) ON DELETE SET NULL;


--
-- Name: i18n_locale i18n_locale_updated_by_id_fk; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.i18n_locale
    ADD CONSTRAINT i18n_locale_updated_by_id_fk FOREIGN KEY (updated_by_id) REFERENCES public.admin_users(id) ON DELETE SET NULL;


--
-- Name: invoices invoices_created_by_id_fk; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.invoices
    ADD CONSTRAINT invoices_created_by_id_fk FOREIGN KEY (created_by_id) REFERENCES public.admin_users(id) ON DELETE SET NULL;


--
-- Name: invoices_order_lnk invoices_order_lnk_fk; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.invoices_order_lnk
    ADD CONSTRAINT invoices_order_lnk_fk FOREIGN KEY (invoice_id) REFERENCES public.invoices(id) ON DELETE CASCADE;


--
-- Name: invoices_order_lnk invoices_order_lnk_ifk; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.invoices_order_lnk
    ADD CONSTRAINT invoices_order_lnk_ifk FOREIGN KEY (order_id) REFERENCES public.orders(id) ON DELETE CASCADE;


--
-- Name: invoices invoices_updated_by_id_fk; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.invoices
    ADD CONSTRAINT invoices_updated_by_id_fk FOREIGN KEY (updated_by_id) REFERENCES public.admin_users(id) ON DELETE SET NULL;


--
-- Name: legal_pages legal_pages_created_by_id_fk; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.legal_pages
    ADD CONSTRAINT legal_pages_created_by_id_fk FOREIGN KEY (created_by_id) REFERENCES public.admin_users(id) ON DELETE SET NULL;


--
-- Name: legal_pages legal_pages_updated_by_id_fk; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.legal_pages
    ADD CONSTRAINT legal_pages_updated_by_id_fk FOREIGN KEY (updated_by_id) REFERENCES public.admin_users(id) ON DELETE SET NULL;


--
-- Name: order_items order_items_created_by_id_fk; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.order_items
    ADD CONSTRAINT order_items_created_by_id_fk FOREIGN KEY (created_by_id) REFERENCES public.admin_users(id) ON DELETE SET NULL;


--
-- Name: order_items_order_lnk order_items_order_lnk_fk; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.order_items_order_lnk
    ADD CONSTRAINT order_items_order_lnk_fk FOREIGN KEY (order_item_id) REFERENCES public.order_items(id) ON DELETE CASCADE;


--
-- Name: order_items_order_lnk order_items_order_lnk_ifk; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.order_items_order_lnk
    ADD CONSTRAINT order_items_order_lnk_ifk FOREIGN KEY (order_id) REFERENCES public.orders(id) ON DELETE CASCADE;


--
-- Name: order_items_product_lnk order_items_product_lnk_fk; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.order_items_product_lnk
    ADD CONSTRAINT order_items_product_lnk_fk FOREIGN KEY (order_item_id) REFERENCES public.order_items(id) ON DELETE CASCADE;


--
-- Name: order_items_product_lnk order_items_product_lnk_ifk; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.order_items_product_lnk
    ADD CONSTRAINT order_items_product_lnk_ifk FOREIGN KEY (product_id) REFERENCES public.products(id) ON DELETE CASCADE;


--
-- Name: order_items order_items_updated_by_id_fk; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.order_items
    ADD CONSTRAINT order_items_updated_by_id_fk FOREIGN KEY (updated_by_id) REFERENCES public.admin_users(id) ON DELETE SET NULL;


--
-- Name: order_shipments order_shipments_created_by_id_fk; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.order_shipments
    ADD CONSTRAINT order_shipments_created_by_id_fk FOREIGN KEY (created_by_id) REFERENCES public.admin_users(id) ON DELETE SET NULL;


--
-- Name: order_shipments_order_lnk order_shipments_order_lnk_fk; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.order_shipments_order_lnk
    ADD CONSTRAINT order_shipments_order_lnk_fk FOREIGN KEY (order_shipment_id) REFERENCES public.order_shipments(id) ON DELETE CASCADE;


--
-- Name: order_shipments_order_lnk order_shipments_order_lnk_ifk; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.order_shipments_order_lnk
    ADD CONSTRAINT order_shipments_order_lnk_ifk FOREIGN KEY (order_id) REFERENCES public.orders(id) ON DELETE CASCADE;


--
-- Name: order_shipments order_shipments_updated_by_id_fk; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.order_shipments
    ADD CONSTRAINT order_shipments_updated_by_id_fk FOREIGN KEY (updated_by_id) REFERENCES public.admin_users(id) ON DELETE SET NULL;


--
-- Name: orders_coupon_lnk orders_coupon_lnk_fk; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.orders_coupon_lnk
    ADD CONSTRAINT orders_coupon_lnk_fk FOREIGN KEY (order_id) REFERENCES public.orders(id) ON DELETE CASCADE;


--
-- Name: orders_coupon_lnk orders_coupon_lnk_ifk; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.orders_coupon_lnk
    ADD CONSTRAINT orders_coupon_lnk_ifk FOREIGN KEY (coupon_code_id) REFERENCES public.coupon_codes(id) ON DELETE CASCADE;


--
-- Name: orders orders_created_by_id_fk; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.orders
    ADD CONSTRAINT orders_created_by_id_fk FOREIGN KEY (created_by_id) REFERENCES public.admin_users(id) ON DELETE SET NULL;


--
-- Name: orders orders_updated_by_id_fk; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.orders
    ADD CONSTRAINT orders_updated_by_id_fk FOREIGN KEY (updated_by_id) REFERENCES public.admin_users(id) ON DELETE SET NULL;


--
-- Name: orders_user_lnk orders_user_lnk_fk; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.orders_user_lnk
    ADD CONSTRAINT orders_user_lnk_fk FOREIGN KEY (order_id) REFERENCES public.orders(id) ON DELETE CASCADE;


--
-- Name: orders_user_lnk orders_user_lnk_ifk; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.orders_user_lnk
    ADD CONSTRAINT orders_user_lnk_ifk FOREIGN KEY (user_id) REFERENCES public.up_users(id) ON DELETE CASCADE;


--
-- Name: password_reset_tokens password_reset_tokens_created_by_id_fk; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.password_reset_tokens
    ADD CONSTRAINT password_reset_tokens_created_by_id_fk FOREIGN KEY (created_by_id) REFERENCES public.admin_users(id) ON DELETE SET NULL;


--
-- Name: password_reset_tokens password_reset_tokens_updated_by_id_fk; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.password_reset_tokens
    ADD CONSTRAINT password_reset_tokens_updated_by_id_fk FOREIGN KEY (updated_by_id) REFERENCES public.admin_users(id) ON DELETE SET NULL;


--
-- Name: password_reset_tokens_user_lnk password_reset_tokens_user_lnk_fk; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.password_reset_tokens_user_lnk
    ADD CONSTRAINT password_reset_tokens_user_lnk_fk FOREIGN KEY (password_reset_token_id) REFERENCES public.password_reset_tokens(id) ON DELETE CASCADE;


--
-- Name: password_reset_tokens_user_lnk password_reset_tokens_user_lnk_ifk; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.password_reset_tokens_user_lnk
    ADD CONSTRAINT password_reset_tokens_user_lnk_ifk FOREIGN KEY (user_id) REFERENCES public.up_users(id) ON DELETE CASCADE;


--
-- Name: popups popups_created_by_id_fk; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.popups
    ADD CONSTRAINT popups_created_by_id_fk FOREIGN KEY (created_by_id) REFERENCES public.admin_users(id) ON DELETE SET NULL;


--
-- Name: popups popups_updated_by_id_fk; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.popups
    ADD CONSTRAINT popups_updated_by_id_fk FOREIGN KEY (updated_by_id) REFERENCES public.admin_users(id) ON DELETE SET NULL;


--
-- Name: product_categories product_categories_created_by_id_fk; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.product_categories
    ADD CONSTRAINT product_categories_created_by_id_fk FOREIGN KEY (created_by_id) REFERENCES public.admin_users(id) ON DELETE SET NULL;


--
-- Name: product_categories product_categories_updated_by_id_fk; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.product_categories
    ADD CONSTRAINT product_categories_updated_by_id_fk FOREIGN KEY (updated_by_id) REFERENCES public.admin_users(id) ON DELETE SET NULL;


--
-- Name: product_variants product_variants_created_by_id_fk; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.product_variants
    ADD CONSTRAINT product_variants_created_by_id_fk FOREIGN KEY (created_by_id) REFERENCES public.admin_users(id) ON DELETE SET NULL;


--
-- Name: product_variants_product_lnk product_variants_product_lnk_fk; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.product_variants_product_lnk
    ADD CONSTRAINT product_variants_product_lnk_fk FOREIGN KEY (product_variant_id) REFERENCES public.product_variants(id) ON DELETE CASCADE;


--
-- Name: product_variants_product_lnk product_variants_product_lnk_ifk; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.product_variants_product_lnk
    ADD CONSTRAINT product_variants_product_lnk_ifk FOREIGN KEY (product_id) REFERENCES public.products(id) ON DELETE CASCADE;


--
-- Name: product_variants product_variants_updated_by_id_fk; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.product_variants
    ADD CONSTRAINT product_variants_updated_by_id_fk FOREIGN KEY (updated_by_id) REFERENCES public.admin_users(id) ON DELETE SET NULL;


--
-- Name: products_category_lnk products_category_lnk_fk; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.products_category_lnk
    ADD CONSTRAINT products_category_lnk_fk FOREIGN KEY (product_id) REFERENCES public.products(id) ON DELETE CASCADE;


--
-- Name: products_category_lnk products_category_lnk_ifk; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.products_category_lnk
    ADD CONSTRAINT products_category_lnk_ifk FOREIGN KEY (product_category_id) REFERENCES public.product_categories(id) ON DELETE CASCADE;


--
-- Name: products products_created_by_id_fk; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.products
    ADD CONSTRAINT products_created_by_id_fk FOREIGN KEY (created_by_id) REFERENCES public.admin_users(id) ON DELETE SET NULL;


--
-- Name: products_shipping_class_lnk products_shipping_class_lnk_fk; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.products_shipping_class_lnk
    ADD CONSTRAINT products_shipping_class_lnk_fk FOREIGN KEY (product_id) REFERENCES public.products(id) ON DELETE CASCADE;


--
-- Name: products_shipping_class_lnk products_shipping_class_lnk_ifk; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.products_shipping_class_lnk
    ADD CONSTRAINT products_shipping_class_lnk_ifk FOREIGN KEY (shipping_class_id) REFERENCES public.shipping_classes(id) ON DELETE CASCADE;


--
-- Name: products products_updated_by_id_fk; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.products
    ADD CONSTRAINT products_updated_by_id_fk FOREIGN KEY (updated_by_id) REFERENCES public.admin_users(id) ON DELETE SET NULL;


--
-- Name: promo_rules promo_rules_created_by_id_fk; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.promo_rules
    ADD CONSTRAINT promo_rules_created_by_id_fk FOREIGN KEY (created_by_id) REFERENCES public.admin_users(id) ON DELETE SET NULL;


--
-- Name: promo_rules promo_rules_updated_by_id_fk; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.promo_rules
    ADD CONSTRAINT promo_rules_updated_by_id_fk FOREIGN KEY (updated_by_id) REFERENCES public.admin_users(id) ON DELETE SET NULL;


--
-- Name: reviews reviews_created_by_id_fk; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.reviews
    ADD CONSTRAINT reviews_created_by_id_fk FOREIGN KEY (created_by_id) REFERENCES public.admin_users(id) ON DELETE SET NULL;


--
-- Name: reviews_product_lnk reviews_product_lnk_fk; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.reviews_product_lnk
    ADD CONSTRAINT reviews_product_lnk_fk FOREIGN KEY (review_id) REFERENCES public.reviews(id) ON DELETE CASCADE;


--
-- Name: reviews_product_lnk reviews_product_lnk_ifk; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.reviews_product_lnk
    ADD CONSTRAINT reviews_product_lnk_ifk FOREIGN KEY (product_id) REFERENCES public.products(id) ON DELETE CASCADE;


--
-- Name: reviews reviews_updated_by_id_fk; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.reviews
    ADD CONSTRAINT reviews_updated_by_id_fk FOREIGN KEY (updated_by_id) REFERENCES public.admin_users(id) ON DELETE SET NULL;


--
-- Name: reviews_user_lnk reviews_user_lnk_fk; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.reviews_user_lnk
    ADD CONSTRAINT reviews_user_lnk_fk FOREIGN KEY (review_id) REFERENCES public.reviews(id) ON DELETE CASCADE;


--
-- Name: reviews_user_lnk reviews_user_lnk_ifk; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.reviews_user_lnk
    ADD CONSTRAINT reviews_user_lnk_ifk FOREIGN KEY (user_id) REFERENCES public.up_users(id) ON DELETE CASCADE;


--
-- Name: scheduled_reminders_booking_lnk scheduled_reminders_booking_lnk_fk; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.scheduled_reminders_booking_lnk
    ADD CONSTRAINT scheduled_reminders_booking_lnk_fk FOREIGN KEY (scheduled_reminder_id) REFERENCES public.scheduled_reminders(id) ON DELETE CASCADE;


--
-- Name: scheduled_reminders_booking_lnk scheduled_reminders_booking_lnk_ifk; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.scheduled_reminders_booking_lnk
    ADD CONSTRAINT scheduled_reminders_booking_lnk_ifk FOREIGN KEY (booking_id) REFERENCES public.bookings(id) ON DELETE CASCADE;


--
-- Name: scheduled_reminders scheduled_reminders_created_by_id_fk; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.scheduled_reminders
    ADD CONSTRAINT scheduled_reminders_created_by_id_fk FOREIGN KEY (created_by_id) REFERENCES public.admin_users(id) ON DELETE SET NULL;


--
-- Name: scheduled_reminders scheduled_reminders_updated_by_id_fk; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.scheduled_reminders
    ADD CONSTRAINT scheduled_reminders_updated_by_id_fk FOREIGN KEY (updated_by_id) REFERENCES public.admin_users(id) ON DELETE SET NULL;


--
-- Name: services services_created_by_id_fk; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.services
    ADD CONSTRAINT services_created_by_id_fk FOREIGN KEY (created_by_id) REFERENCES public.admin_users(id) ON DELETE SET NULL;


--
-- Name: services services_updated_by_id_fk; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.services
    ADD CONSTRAINT services_updated_by_id_fk FOREIGN KEY (updated_by_id) REFERENCES public.admin_users(id) ON DELETE SET NULL;


--
-- Name: shipping_classes shipping_classes_created_by_id_fk; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.shipping_classes
    ADD CONSTRAINT shipping_classes_created_by_id_fk FOREIGN KEY (created_by_id) REFERENCES public.admin_users(id) ON DELETE SET NULL;


--
-- Name: shipping_classes shipping_classes_updated_by_id_fk; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.shipping_classes
    ADD CONSTRAINT shipping_classes_updated_by_id_fk FOREIGN KEY (updated_by_id) REFERENCES public.admin_users(id) ON DELETE SET NULL;


--
-- Name: strapi_api_token_permissions strapi_api_token_permissions_created_by_id_fk; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.strapi_api_token_permissions
    ADD CONSTRAINT strapi_api_token_permissions_created_by_id_fk FOREIGN KEY (created_by_id) REFERENCES public.admin_users(id) ON DELETE SET NULL;


--
-- Name: strapi_api_token_permissions_token_lnk strapi_api_token_permissions_token_lnk_fk; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.strapi_api_token_permissions_token_lnk
    ADD CONSTRAINT strapi_api_token_permissions_token_lnk_fk FOREIGN KEY (api_token_permission_id) REFERENCES public.strapi_api_token_permissions(id) ON DELETE CASCADE;


--
-- Name: strapi_api_token_permissions_token_lnk strapi_api_token_permissions_token_lnk_ifk; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.strapi_api_token_permissions_token_lnk
    ADD CONSTRAINT strapi_api_token_permissions_token_lnk_ifk FOREIGN KEY (api_token_id) REFERENCES public.strapi_api_tokens(id) ON DELETE CASCADE;


--
-- Name: strapi_api_token_permissions strapi_api_token_permissions_updated_by_id_fk; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.strapi_api_token_permissions
    ADD CONSTRAINT strapi_api_token_permissions_updated_by_id_fk FOREIGN KEY (updated_by_id) REFERENCES public.admin_users(id) ON DELETE SET NULL;


--
-- Name: strapi_api_tokens strapi_api_tokens_created_by_id_fk; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.strapi_api_tokens
    ADD CONSTRAINT strapi_api_tokens_created_by_id_fk FOREIGN KEY (created_by_id) REFERENCES public.admin_users(id) ON DELETE SET NULL;


--
-- Name: strapi_api_tokens strapi_api_tokens_updated_by_id_fk; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.strapi_api_tokens
    ADD CONSTRAINT strapi_api_tokens_updated_by_id_fk FOREIGN KEY (updated_by_id) REFERENCES public.admin_users(id) ON DELETE SET NULL;


--
-- Name: strapi_history_versions strapi_history_versions_created_by_id_fk; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.strapi_history_versions
    ADD CONSTRAINT strapi_history_versions_created_by_id_fk FOREIGN KEY (created_by_id) REFERENCES public.admin_users(id) ON DELETE SET NULL;


--
-- Name: strapi_release_actions strapi_release_actions_created_by_id_fk; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.strapi_release_actions
    ADD CONSTRAINT strapi_release_actions_created_by_id_fk FOREIGN KEY (created_by_id) REFERENCES public.admin_users(id) ON DELETE SET NULL;


--
-- Name: strapi_release_actions_release_lnk strapi_release_actions_release_lnk_fk; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.strapi_release_actions_release_lnk
    ADD CONSTRAINT strapi_release_actions_release_lnk_fk FOREIGN KEY (release_action_id) REFERENCES public.strapi_release_actions(id) ON DELETE CASCADE;


--
-- Name: strapi_release_actions_release_lnk strapi_release_actions_release_lnk_ifk; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.strapi_release_actions_release_lnk
    ADD CONSTRAINT strapi_release_actions_release_lnk_ifk FOREIGN KEY (release_id) REFERENCES public.strapi_releases(id) ON DELETE CASCADE;


--
-- Name: strapi_release_actions strapi_release_actions_updated_by_id_fk; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.strapi_release_actions
    ADD CONSTRAINT strapi_release_actions_updated_by_id_fk FOREIGN KEY (updated_by_id) REFERENCES public.admin_users(id) ON DELETE SET NULL;


--
-- Name: strapi_releases strapi_releases_created_by_id_fk; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.strapi_releases
    ADD CONSTRAINT strapi_releases_created_by_id_fk FOREIGN KEY (created_by_id) REFERENCES public.admin_users(id) ON DELETE SET NULL;


--
-- Name: strapi_releases strapi_releases_updated_by_id_fk; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.strapi_releases
    ADD CONSTRAINT strapi_releases_updated_by_id_fk FOREIGN KEY (updated_by_id) REFERENCES public.admin_users(id) ON DELETE SET NULL;


--
-- Name: strapi_sessions strapi_sessions_created_by_id_fk; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.strapi_sessions
    ADD CONSTRAINT strapi_sessions_created_by_id_fk FOREIGN KEY (created_by_id) REFERENCES public.admin_users(id) ON DELETE SET NULL;


--
-- Name: strapi_sessions strapi_sessions_updated_by_id_fk; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.strapi_sessions
    ADD CONSTRAINT strapi_sessions_updated_by_id_fk FOREIGN KEY (updated_by_id) REFERENCES public.admin_users(id) ON DELETE SET NULL;


--
-- Name: strapi_transfer_token_permissions strapi_transfer_token_permissions_created_by_id_fk; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.strapi_transfer_token_permissions
    ADD CONSTRAINT strapi_transfer_token_permissions_created_by_id_fk FOREIGN KEY (created_by_id) REFERENCES public.admin_users(id) ON DELETE SET NULL;


--
-- Name: strapi_transfer_token_permissions_token_lnk strapi_transfer_token_permissions_token_lnk_fk; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.strapi_transfer_token_permissions_token_lnk
    ADD CONSTRAINT strapi_transfer_token_permissions_token_lnk_fk FOREIGN KEY (transfer_token_permission_id) REFERENCES public.strapi_transfer_token_permissions(id) ON DELETE CASCADE;


--
-- Name: strapi_transfer_token_permissions_token_lnk strapi_transfer_token_permissions_token_lnk_ifk; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.strapi_transfer_token_permissions_token_lnk
    ADD CONSTRAINT strapi_transfer_token_permissions_token_lnk_ifk FOREIGN KEY (transfer_token_id) REFERENCES public.strapi_transfer_tokens(id) ON DELETE CASCADE;


--
-- Name: strapi_transfer_token_permissions strapi_transfer_token_permissions_updated_by_id_fk; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.strapi_transfer_token_permissions
    ADD CONSTRAINT strapi_transfer_token_permissions_updated_by_id_fk FOREIGN KEY (updated_by_id) REFERENCES public.admin_users(id) ON DELETE SET NULL;


--
-- Name: strapi_transfer_tokens strapi_transfer_tokens_created_by_id_fk; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.strapi_transfer_tokens
    ADD CONSTRAINT strapi_transfer_tokens_created_by_id_fk FOREIGN KEY (created_by_id) REFERENCES public.admin_users(id) ON DELETE SET NULL;


--
-- Name: strapi_transfer_tokens strapi_transfer_tokens_updated_by_id_fk; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.strapi_transfer_tokens
    ADD CONSTRAINT strapi_transfer_tokens_updated_by_id_fk FOREIGN KEY (updated_by_id) REFERENCES public.admin_users(id) ON DELETE SET NULL;


--
-- Name: strapi_workflows strapi_workflows_created_by_id_fk; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.strapi_workflows
    ADD CONSTRAINT strapi_workflows_created_by_id_fk FOREIGN KEY (created_by_id) REFERENCES public.admin_users(id) ON DELETE SET NULL;


--
-- Name: strapi_workflows_stage_required_to_publish_lnk strapi_workflows_stage_required_to_publish_lnk_fk; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.strapi_workflows_stage_required_to_publish_lnk
    ADD CONSTRAINT strapi_workflows_stage_required_to_publish_lnk_fk FOREIGN KEY (workflow_id) REFERENCES public.strapi_workflows(id) ON DELETE CASCADE;


--
-- Name: strapi_workflows_stage_required_to_publish_lnk strapi_workflows_stage_required_to_publish_lnk_ifk; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.strapi_workflows_stage_required_to_publish_lnk
    ADD CONSTRAINT strapi_workflows_stage_required_to_publish_lnk_ifk FOREIGN KEY (workflow_stage_id) REFERENCES public.strapi_workflows_stages(id) ON DELETE CASCADE;


--
-- Name: strapi_workflows_stages strapi_workflows_stages_created_by_id_fk; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.strapi_workflows_stages
    ADD CONSTRAINT strapi_workflows_stages_created_by_id_fk FOREIGN KEY (created_by_id) REFERENCES public.admin_users(id) ON DELETE SET NULL;


--
-- Name: strapi_workflows_stages_permissions_lnk strapi_workflows_stages_permissions_lnk_fk; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.strapi_workflows_stages_permissions_lnk
    ADD CONSTRAINT strapi_workflows_stages_permissions_lnk_fk FOREIGN KEY (workflow_stage_id) REFERENCES public.strapi_workflows_stages(id) ON DELETE CASCADE;


--
-- Name: strapi_workflows_stages_permissions_lnk strapi_workflows_stages_permissions_lnk_ifk; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.strapi_workflows_stages_permissions_lnk
    ADD CONSTRAINT strapi_workflows_stages_permissions_lnk_ifk FOREIGN KEY (permission_id) REFERENCES public.admin_permissions(id) ON DELETE CASCADE;


--
-- Name: strapi_workflows_stages strapi_workflows_stages_updated_by_id_fk; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.strapi_workflows_stages
    ADD CONSTRAINT strapi_workflows_stages_updated_by_id_fk FOREIGN KEY (updated_by_id) REFERENCES public.admin_users(id) ON DELETE SET NULL;


--
-- Name: strapi_workflows_stages_workflow_lnk strapi_workflows_stages_workflow_lnk_fk; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.strapi_workflows_stages_workflow_lnk
    ADD CONSTRAINT strapi_workflows_stages_workflow_lnk_fk FOREIGN KEY (workflow_stage_id) REFERENCES public.strapi_workflows_stages(id) ON DELETE CASCADE;


--
-- Name: strapi_workflows_stages_workflow_lnk strapi_workflows_stages_workflow_lnk_ifk; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.strapi_workflows_stages_workflow_lnk
    ADD CONSTRAINT strapi_workflows_stages_workflow_lnk_ifk FOREIGN KEY (workflow_id) REFERENCES public.strapi_workflows(id) ON DELETE CASCADE;


--
-- Name: strapi_workflows strapi_workflows_updated_by_id_fk; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.strapi_workflows
    ADD CONSTRAINT strapi_workflows_updated_by_id_fk FOREIGN KEY (updated_by_id) REFERENCES public.admin_users(id) ON DELETE SET NULL;


--
-- Name: testimonials testimonials_created_by_id_fk; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.testimonials
    ADD CONSTRAINT testimonials_created_by_id_fk FOREIGN KEY (created_by_id) REFERENCES public.admin_users(id) ON DELETE SET NULL;


--
-- Name: testimonials testimonials_updated_by_id_fk; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.testimonials
    ADD CONSTRAINT testimonials_updated_by_id_fk FOREIGN KEY (updated_by_id) REFERENCES public.admin_users(id) ON DELETE SET NULL;


--
-- Name: up_permissions up_permissions_created_by_id_fk; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.up_permissions
    ADD CONSTRAINT up_permissions_created_by_id_fk FOREIGN KEY (created_by_id) REFERENCES public.admin_users(id) ON DELETE SET NULL;


--
-- Name: up_permissions_role_lnk up_permissions_role_lnk_fk; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.up_permissions_role_lnk
    ADD CONSTRAINT up_permissions_role_lnk_fk FOREIGN KEY (permission_id) REFERENCES public.up_permissions(id) ON DELETE CASCADE;


--
-- Name: up_permissions_role_lnk up_permissions_role_lnk_ifk; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.up_permissions_role_lnk
    ADD CONSTRAINT up_permissions_role_lnk_ifk FOREIGN KEY (role_id) REFERENCES public.up_roles(id) ON DELETE CASCADE;


--
-- Name: up_permissions up_permissions_updated_by_id_fk; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.up_permissions
    ADD CONSTRAINT up_permissions_updated_by_id_fk FOREIGN KEY (updated_by_id) REFERENCES public.admin_users(id) ON DELETE SET NULL;


--
-- Name: up_roles up_roles_created_by_id_fk; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.up_roles
    ADD CONSTRAINT up_roles_created_by_id_fk FOREIGN KEY (created_by_id) REFERENCES public.admin_users(id) ON DELETE SET NULL;


--
-- Name: up_roles up_roles_updated_by_id_fk; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.up_roles
    ADD CONSTRAINT up_roles_updated_by_id_fk FOREIGN KEY (updated_by_id) REFERENCES public.admin_users(id) ON DELETE SET NULL;


--
-- Name: up_users up_users_created_by_id_fk; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.up_users
    ADD CONSTRAINT up_users_created_by_id_fk FOREIGN KEY (created_by_id) REFERENCES public.admin_users(id) ON DELETE SET NULL;


--
-- Name: up_users up_users_updated_by_id_fk; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.up_users
    ADD CONSTRAINT up_users_updated_by_id_fk FOREIGN KEY (updated_by_id) REFERENCES public.admin_users(id) ON DELETE SET NULL;


--
-- Name: upload_folders upload_folders_created_by_id_fk; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.upload_folders
    ADD CONSTRAINT upload_folders_created_by_id_fk FOREIGN KEY (created_by_id) REFERENCES public.admin_users(id) ON DELETE SET NULL;


--
-- Name: upload_folders_parent_lnk upload_folders_parent_lnk_fk; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.upload_folders_parent_lnk
    ADD CONSTRAINT upload_folders_parent_lnk_fk FOREIGN KEY (folder_id) REFERENCES public.upload_folders(id) ON DELETE CASCADE;


--
-- Name: upload_folders_parent_lnk upload_folders_parent_lnk_ifk; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.upload_folders_parent_lnk
    ADD CONSTRAINT upload_folders_parent_lnk_ifk FOREIGN KEY (inv_folder_id) REFERENCES public.upload_folders(id) ON DELETE CASCADE;


--
-- Name: upload_folders upload_folders_updated_by_id_fk; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.upload_folders
    ADD CONSTRAINT upload_folders_updated_by_id_fk FOREIGN KEY (updated_by_id) REFERENCES public.admin_users(id) ON DELETE SET NULL;


--
-- Name: wishlist_items wishlist_items_created_by_id_fk; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.wishlist_items
    ADD CONSTRAINT wishlist_items_created_by_id_fk FOREIGN KEY (created_by_id) REFERENCES public.admin_users(id) ON DELETE SET NULL;


--
-- Name: wishlist_items_product_lnk wishlist_items_product_lnk_fk; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.wishlist_items_product_lnk
    ADD CONSTRAINT wishlist_items_product_lnk_fk FOREIGN KEY (wishlist_item_id) REFERENCES public.wishlist_items(id) ON DELETE CASCADE;


--
-- Name: wishlist_items_product_lnk wishlist_items_product_lnk_ifk; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.wishlist_items_product_lnk
    ADD CONSTRAINT wishlist_items_product_lnk_ifk FOREIGN KEY (product_id) REFERENCES public.products(id) ON DELETE CASCADE;


--
-- Name: wishlist_items wishlist_items_updated_by_id_fk; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.wishlist_items
    ADD CONSTRAINT wishlist_items_updated_by_id_fk FOREIGN KEY (updated_by_id) REFERENCES public.admin_users(id) ON DELETE SET NULL;


--
-- Name: wishlist_items_user_lnk wishlist_items_user_lnk_fk; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.wishlist_items_user_lnk
    ADD CONSTRAINT wishlist_items_user_lnk_fk FOREIGN KEY (wishlist_item_id) REFERENCES public.wishlist_items(id) ON DELETE CASCADE;


--
-- Name: wishlist_items_user_lnk wishlist_items_user_lnk_ifk; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.wishlist_items_user_lnk
    ADD CONSTRAINT wishlist_items_user_lnk_ifk FOREIGN KEY (user_id) REFERENCES public.up_users(id) ON DELETE CASCADE;


--
-- PostgreSQL database dump complete
--

\unrestrict qjuOj8i7zNIuqefQ4njsyeOQemPe4MQp1oZD6BY1lKcv30JyGPlZHw5w6dOI9TU

