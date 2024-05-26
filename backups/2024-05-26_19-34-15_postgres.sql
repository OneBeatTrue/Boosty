--
-- PostgreSQL database dump
--

-- Dumped from database version 16.3 (Debian 16.3-1.pgdg120+1)
-- Dumped by pg_dump version 16.3 (Debian 16.3-1.pgdg120+1)

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
-- Name: attachment_types; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.attachment_types (
    attachment_type_id bigint NOT NULL,
    attachment_type character varying(255) NOT NULL
);


ALTER TABLE public.attachment_types OWNER TO postgres;

--
-- Name: attachment_types_attachment_type_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.attachment_types_attachment_type_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.attachment_types_attachment_type_id_seq OWNER TO postgres;

--
-- Name: attachment_types_attachment_type_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.attachment_types_attachment_type_id_seq OWNED BY public.attachment_types.attachment_type_id;


--
-- Name: attachments; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.attachments (
    attachment_id bigint NOT NULL,
    attachment bytea NOT NULL
);


ALTER TABLE public.attachments OWNER TO postgres;

--
-- Name: attachments_attachment_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.attachments_attachment_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.attachments_attachment_id_seq OWNER TO postgres;

--
-- Name: attachments_attachment_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.attachments_attachment_id_seq OWNED BY public.attachments.attachment_id;


--
-- Name: bank_types; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.bank_types (
    bank_type_id bigint NOT NULL,
    bank_type_name character varying(255) NOT NULL
);


ALTER TABLE public.bank_types OWNER TO postgres;

--
-- Name: bank_types_bank_type_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.bank_types_bank_type_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.bank_types_bank_type_id_seq OWNER TO postgres;

--
-- Name: bank_types_bank_type_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.bank_types_bank_type_id_seq OWNED BY public.bank_types.bank_type_id;


--
-- Name: billings; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.billings (
    billing_id bigint NOT NULL,
    user_id bigint NOT NULL,
    currency_id bigint NOT NULL,
    card_number bigint NOT NULL,
    valid_until date NOT NULL,
    cardholder_name character varying(255) NOT NULL,
    cvv smallint NOT NULL,
    bank_type_id bigint NOT NULL
);


ALTER TABLE public.billings OWNER TO postgres;

--
-- Name: billings_billing_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.billings_billing_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.billings_billing_id_seq OWNER TO postgres;

--
-- Name: billings_billing_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.billings_billing_id_seq OWNED BY public.billings.billing_id;


--
-- Name: comments; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.comments (
    comment_id bigint NOT NULL,
    recipient_comment_id bigint,
    recipient_post_id bigint NOT NULL,
    sender_id bigint NOT NULL,
    message text NOT NULL
);


ALTER TABLE public.comments OWNER TO postgres;

--
-- Name: comments_comment_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.comments_comment_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.comments_comment_id_seq OWNER TO postgres;

--
-- Name: comments_comment_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.comments_comment_id_seq OWNED BY public.comments.comment_id;


--
-- Name: creators; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.creators (
    creator_id bigint NOT NULL,
    cover bytea,
    description character varying(255),
    withdrawal_system_id bigint NOT NULL,
    withdrawal_required_inf character varying(255) NOT NULL,
    balance double precision NOT NULL
);


ALTER TABLE public.creators OWNER TO postgres;

--
-- Name: currencies; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.currencies (
    currency_id bigint NOT NULL,
    currency_name character varying(255) NOT NULL
);


ALTER TABLE public.currencies OWNER TO postgres;

--
-- Name: currencies_currency_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.currencies_currency_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.currencies_currency_id_seq OWNER TO postgres;

--
-- Name: currencies_currency_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.currencies_currency_id_seq OWNED BY public.currencies.currency_id;


--
-- Name: followings; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.followings (
    user_id bigint NOT NULL,
    creator_id bigint NOT NULL
)
PARTITION BY RANGE (creator_id);


ALTER TABLE public.followings OWNER TO postgres;

--
-- Name: followings_0; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.followings_0 (
    user_id bigint NOT NULL,
    creator_id bigint NOT NULL,
    CONSTRAINT check_creator_id_0 CHECK (((creator_id >= 0) AND (creator_id < 100000)))
);


ALTER TABLE public.followings_0 OWNER TO postgres;

--
-- Name: followings_100000; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.followings_100000 (
    user_id bigint NOT NULL,
    creator_id bigint NOT NULL,
    CONSTRAINT check_creator_id_100000 CHECK (((creator_id >= 100000) AND (creator_id < 200000)))
);


ALTER TABLE public.followings_100000 OWNER TO postgres;

--
-- Name: followings_200000; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.followings_200000 (
    user_id bigint NOT NULL,
    creator_id bigint NOT NULL,
    CONSTRAINT check_creator_id_200000 CHECK (((creator_id >= 200000) AND (creator_id < 300000)))
);


ALTER TABLE public.followings_200000 OWNER TO postgres;

--
-- Name: followings_300000; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.followings_300000 (
    user_id bigint NOT NULL,
    creator_id bigint NOT NULL,
    CONSTRAINT check_creator_id_300000 CHECK (((creator_id >= 300000) AND (creator_id < 400000)))
);


ALTER TABLE public.followings_300000 OWNER TO postgres;

--
-- Name: followings_400000; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.followings_400000 (
    user_id bigint NOT NULL,
    creator_id bigint NOT NULL,
    CONSTRAINT check_creator_id_400000 CHECK (((creator_id >= 400000) AND (creator_id < 500000)))
);


ALTER TABLE public.followings_400000 OWNER TO postgres;

--
-- Name: followings_500000; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.followings_500000 (
    user_id bigint NOT NULL,
    creator_id bigint NOT NULL,
    CONSTRAINT check_creator_id_500000 CHECK (((creator_id >= 500000) AND (creator_id < 600000)))
);


ALTER TABLE public.followings_500000 OWNER TO postgres;

--
-- Name: links; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.links (
    link_id bigint NOT NULL,
    creator_id bigint NOT NULL,
    link character varying(255) NOT NULL
);


ALTER TABLE public.links OWNER TO postgres;

--
-- Name: links_link_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.links_link_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.links_link_id_seq OWNER TO postgres;

--
-- Name: links_link_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.links_link_id_seq OWNED BY public.links.link_id;


--
-- Name: posts; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.posts (
    post_id bigint NOT NULL,
    creator_id bigint NOT NULL,
    minimal_required_sub_level_id bigint,
    title character varying(255),
    content text,
    attachment_id bigint,
    attachment_type_id bigint,
    teaser_text text,
    teaser_img bytea,
    comments_availability boolean NOT NULL
);


ALTER TABLE public.posts OWNER TO postgres;

--
-- Name: posts_post_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.posts_post_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.posts_post_id_seq OWNER TO postgres;

--
-- Name: posts_post_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.posts_post_id_seq OWNED BY public.posts.post_id;


--
-- Name: subscription_levels; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.subscription_levels (
    sub_level_id bigint NOT NULL,
    creator_id bigint NOT NULL,
    price double precision NOT NULL,
    title character varying(255) NOT NULL,
    cover bytea,
    description character varying(255),
    welcome_message character varying(255)
);


ALTER TABLE public.subscription_levels OWNER TO postgres;

--
-- Name: subscription_levels_sub_level_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.subscription_levels_sub_level_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.subscription_levels_sub_level_id_seq OWNER TO postgres;

--
-- Name: subscription_levels_sub_level_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.subscription_levels_sub_level_id_seq OWNED BY public.subscription_levels.sub_level_id;


--
-- Name: subscriptions; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.subscriptions (
    sub_id bigint NOT NULL,
    user_id bigint NOT NULL,
    sub_level_id bigint NOT NULL,
    start_date date NOT NULL,
    end_date date NOT NULL
);


ALTER TABLE public.subscriptions OWNER TO postgres;

--
-- Name: subscriptions_sub_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.subscriptions_sub_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.subscriptions_sub_id_seq OWNER TO postgres;

--
-- Name: subscriptions_sub_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.subscriptions_sub_id_seq OWNED BY public.subscriptions.sub_id;


--
-- Name: tags; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.tags (
    tag character varying(255) NOT NULL,
    post_id bigint NOT NULL
);


ALTER TABLE public.tags OWNER TO postgres;

--
-- Name: users; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.users (
    user_id bigint NOT NULL,
    name character varying(255) NOT NULL,
    phone_number bigint NOT NULL,
    email character varying(255),
    profile_picture bytea,
    password character varying(64) NOT NULL
);


ALTER TABLE public.users OWNER TO postgres;

--
-- Name: users_user_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.users_user_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.users_user_id_seq OWNER TO postgres;

--
-- Name: users_user_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.users_user_id_seq OWNED BY public.users.user_id;


--
-- Name: withdrawal_systems; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.withdrawal_systems (
    withdrawal_system_id bigint NOT NULL,
    name character varying(255) NOT NULL,
    percent double precision,
    mandatory_deduction double precision
);


ALTER TABLE public.withdrawal_systems OWNER TO postgres;

--
-- Name: withdrawal_systems_withdrawal_system_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.withdrawal_systems_withdrawal_system_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.withdrawal_systems_withdrawal_system_id_seq OWNER TO postgres;

--
-- Name: withdrawal_systems_withdrawal_system_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.withdrawal_systems_withdrawal_system_id_seq OWNED BY public.withdrawal_systems.withdrawal_system_id;


--
-- Name: withdrawals; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.withdrawals (
    withdrawal_id bigint NOT NULL,
    creator_id bigint NOT NULL,
    withdrawal_system_id bigint NOT NULL,
    datetime timestamp without time zone NOT NULL,
    amount double precision NOT NULL
);


ALTER TABLE public.withdrawals OWNER TO postgres;

--
-- Name: withdrawals_withdrawal_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.withdrawals_withdrawal_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.withdrawals_withdrawal_id_seq OWNER TO postgres;

--
-- Name: withdrawals_withdrawal_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.withdrawals_withdrawal_id_seq OWNED BY public.withdrawals.withdrawal_id;


--
-- Name: followings_0; Type: TABLE ATTACH; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.followings ATTACH PARTITION public.followings_0 FOR VALUES FROM ('0') TO ('100000');


--
-- Name: followings_100000; Type: TABLE ATTACH; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.followings ATTACH PARTITION public.followings_100000 FOR VALUES FROM ('100000') TO ('200000');


--
-- Name: followings_200000; Type: TABLE ATTACH; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.followings ATTACH PARTITION public.followings_200000 FOR VALUES FROM ('200000') TO ('300000');


--
-- Name: followings_300000; Type: TABLE ATTACH; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.followings ATTACH PARTITION public.followings_300000 FOR VALUES FROM ('300000') TO ('400000');


--
-- Name: followings_400000; Type: TABLE ATTACH; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.followings ATTACH PARTITION public.followings_400000 FOR VALUES FROM ('400000') TO ('500000');


--
-- Name: followings_500000; Type: TABLE ATTACH; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.followings ATTACH PARTITION public.followings_500000 FOR VALUES FROM ('500000') TO ('600000');


--
-- Name: attachment_types attachment_type_id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.attachment_types ALTER COLUMN attachment_type_id SET DEFAULT nextval('public.attachment_types_attachment_type_id_seq'::regclass);


--
-- Name: attachments attachment_id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.attachments ALTER COLUMN attachment_id SET DEFAULT nextval('public.attachments_attachment_id_seq'::regclass);


--
-- Name: bank_types bank_type_id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.bank_types ALTER COLUMN bank_type_id SET DEFAULT nextval('public.bank_types_bank_type_id_seq'::regclass);


--
-- Name: billings billing_id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.billings ALTER COLUMN billing_id SET DEFAULT nextval('public.billings_billing_id_seq'::regclass);


--
-- Name: comments comment_id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.comments ALTER COLUMN comment_id SET DEFAULT nextval('public.comments_comment_id_seq'::regclass);


--
-- Name: currencies currency_id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.currencies ALTER COLUMN currency_id SET DEFAULT nextval('public.currencies_currency_id_seq'::regclass);


--
-- Name: links link_id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.links ALTER COLUMN link_id SET DEFAULT nextval('public.links_link_id_seq'::regclass);


--
-- Name: posts post_id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.posts ALTER COLUMN post_id SET DEFAULT nextval('public.posts_post_id_seq'::regclass);


--
-- Name: subscription_levels sub_level_id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.subscription_levels ALTER COLUMN sub_level_id SET DEFAULT nextval('public.subscription_levels_sub_level_id_seq'::regclass);


--
-- Name: subscriptions sub_id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.subscriptions ALTER COLUMN sub_id SET DEFAULT nextval('public.subscriptions_sub_id_seq'::regclass);


--
-- Name: users user_id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users ALTER COLUMN user_id SET DEFAULT nextval('public.users_user_id_seq'::regclass);


--
-- Name: withdrawal_systems withdrawal_system_id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.withdrawal_systems ALTER COLUMN withdrawal_system_id SET DEFAULT nextval('public.withdrawal_systems_withdrawal_system_id_seq'::regclass);


--
-- Name: withdrawals withdrawal_id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.withdrawals ALTER COLUMN withdrawal_id SET DEFAULT nextval('public.withdrawals_withdrawal_id_seq'::regclass);


--
-- Data for Name: attachment_types; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.attachment_types (attachment_type_id, attachment_type) FROM stdin;
\.


--
-- Data for Name: attachments; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.attachments (attachment_id, attachment) FROM stdin;
\.


--
-- Data for Name: bank_types; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.bank_types (bank_type_id, bank_type_name) FROM stdin;
\.


--
-- Data for Name: billings; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.billings (billing_id, user_id, currency_id, card_number, valid_until, cardholder_name, cvv, bank_type_id) FROM stdin;
\.


--
-- Data for Name: comments; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.comments (comment_id, recipient_comment_id, recipient_post_id, sender_id, message) FROM stdin;
\.


--
-- Data for Name: creators; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.creators (creator_id, cover, description, withdrawal_system_id, withdrawal_required_inf, balance) FROM stdin;
\.


--
-- Data for Name: currencies; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.currencies (currency_id, currency_name) FROM stdin;
\.


--
-- Data for Name: followings_0; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.followings_0 (user_id, creator_id) FROM stdin;
\.


--
-- Data for Name: followings_100000; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.followings_100000 (user_id, creator_id) FROM stdin;
\.


--
-- Data for Name: followings_200000; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.followings_200000 (user_id, creator_id) FROM stdin;
\.


--
-- Data for Name: followings_300000; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.followings_300000 (user_id, creator_id) FROM stdin;
\.


--
-- Data for Name: followings_400000; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.followings_400000 (user_id, creator_id) FROM stdin;
\.


--
-- Data for Name: followings_500000; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.followings_500000 (user_id, creator_id) FROM stdin;
\.


--
-- Data for Name: links; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.links (link_id, creator_id, link) FROM stdin;
\.


--
-- Data for Name: posts; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.posts (post_id, creator_id, minimal_required_sub_level_id, title, content, attachment_id, attachment_type_id, teaser_text, teaser_img, comments_availability) FROM stdin;
\.


--
-- Data for Name: subscription_levels; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.subscription_levels (sub_level_id, creator_id, price, title, cover, description, welcome_message) FROM stdin;
\.


--
-- Data for Name: subscriptions; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.subscriptions (sub_id, user_id, sub_level_id, start_date, end_date) FROM stdin;
\.


--
-- Data for Name: tags; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.tags (tag, post_id) FROM stdin;
\.


--
-- Data for Name: users; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.users (user_id, name, phone_number, email, profile_picture, password) FROM stdin;
\.


--
-- Data for Name: withdrawal_systems; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.withdrawal_systems (withdrawal_system_id, name, percent, mandatory_deduction) FROM stdin;
\.


--
-- Data for Name: withdrawals; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.withdrawals (withdrawal_id, creator_id, withdrawal_system_id, datetime, amount) FROM stdin;
\.


--
-- Name: attachment_types_attachment_type_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.attachment_types_attachment_type_id_seq', 1, false);


--
-- Name: attachments_attachment_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.attachments_attachment_id_seq', 1, false);


--
-- Name: bank_types_bank_type_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.bank_types_bank_type_id_seq', 1, false);


--
-- Name: billings_billing_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.billings_billing_id_seq', 1, false);


--
-- Name: comments_comment_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.comments_comment_id_seq', 1, false);


--
-- Name: currencies_currency_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.currencies_currency_id_seq', 1, false);


--
-- Name: links_link_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.links_link_id_seq', 1, false);


--
-- Name: posts_post_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.posts_post_id_seq', 1, false);


--
-- Name: subscription_levels_sub_level_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.subscription_levels_sub_level_id_seq', 1, false);


--
-- Name: subscriptions_sub_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.subscriptions_sub_id_seq', 1, false);


--
-- Name: users_user_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.users_user_id_seq', 1, false);


--
-- Name: withdrawal_systems_withdrawal_system_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.withdrawal_systems_withdrawal_system_id_seq', 1, false);


--
-- Name: withdrawals_withdrawal_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.withdrawals_withdrawal_id_seq', 1, false);


--
-- Name: attachment_types attachment_types_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.attachment_types
    ADD CONSTRAINT attachment_types_pkey PRIMARY KEY (attachment_type_id);


--
-- Name: attachments attachments_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.attachments
    ADD CONSTRAINT attachments_pkey PRIMARY KEY (attachment_id);


--
-- Name: bank_types bank_types_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.bank_types
    ADD CONSTRAINT bank_types_pkey PRIMARY KEY (bank_type_id);


--
-- Name: billings billings_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.billings
    ADD CONSTRAINT billings_pkey PRIMARY KEY (billing_id);


--
-- Name: comments comments_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.comments
    ADD CONSTRAINT comments_pkey PRIMARY KEY (comment_id);


--
-- Name: creators creators_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.creators
    ADD CONSTRAINT creators_pkey PRIMARY KEY (creator_id);


--
-- Name: currencies currencies_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.currencies
    ADD CONSTRAINT currencies_pkey PRIMARY KEY (currency_id);


--
-- Name: followings unique_following; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.followings
    ADD CONSTRAINT unique_following UNIQUE (user_id, creator_id);


--
-- Name: followings_0 followings_0_user_id_creator_id_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.followings_0
    ADD CONSTRAINT followings_0_user_id_creator_id_key UNIQUE (user_id, creator_id);


--
-- Name: followings_100000 followings_100000_user_id_creator_id_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.followings_100000
    ADD CONSTRAINT followings_100000_user_id_creator_id_key UNIQUE (user_id, creator_id);


--
-- Name: followings_200000 followings_200000_user_id_creator_id_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.followings_200000
    ADD CONSTRAINT followings_200000_user_id_creator_id_key UNIQUE (user_id, creator_id);


--
-- Name: followings_300000 followings_300000_user_id_creator_id_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.followings_300000
    ADD CONSTRAINT followings_300000_user_id_creator_id_key UNIQUE (user_id, creator_id);


--
-- Name: followings_400000 followings_400000_user_id_creator_id_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.followings_400000
    ADD CONSTRAINT followings_400000_user_id_creator_id_key UNIQUE (user_id, creator_id);


--
-- Name: followings_500000 followings_500000_user_id_creator_id_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.followings_500000
    ADD CONSTRAINT followings_500000_user_id_creator_id_key UNIQUE (user_id, creator_id);


--
-- Name: links links_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.links
    ADD CONSTRAINT links_pkey PRIMARY KEY (link_id);


--
-- Name: posts posts_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.posts
    ADD CONSTRAINT posts_pkey PRIMARY KEY (post_id);


--
-- Name: subscription_levels subscription_levels_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.subscription_levels
    ADD CONSTRAINT subscription_levels_pkey PRIMARY KEY (sub_level_id);


--
-- Name: subscriptions subscriptions_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.subscriptions
    ADD CONSTRAINT subscriptions_pkey PRIMARY KEY (sub_id);


--
-- Name: tags unique_tag_pair; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.tags
    ADD CONSTRAINT unique_tag_pair UNIQUE (tag, post_id);


--
-- Name: users users_name_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_name_key UNIQUE (name);


--
-- Name: users users_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_pkey PRIMARY KEY (user_id);


--
-- Name: withdrawal_systems withdrawal_systems_name_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.withdrawal_systems
    ADD CONSTRAINT withdrawal_systems_name_key UNIQUE (name);


--
-- Name: withdrawal_systems withdrawal_systems_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.withdrawal_systems
    ADD CONSTRAINT withdrawal_systems_pkey PRIMARY KEY (withdrawal_system_id);


--
-- Name: withdrawals withdrawals_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.withdrawals
    ADD CONSTRAINT withdrawals_pkey PRIMARY KEY (withdrawal_id);


--
-- Name: followings_0_user_id_creator_id_key; Type: INDEX ATTACH; Schema: public; Owner: postgres
--

ALTER INDEX public.unique_following ATTACH PARTITION public.followings_0_user_id_creator_id_key;


--
-- Name: followings_100000_user_id_creator_id_key; Type: INDEX ATTACH; Schema: public; Owner: postgres
--

ALTER INDEX public.unique_following ATTACH PARTITION public.followings_100000_user_id_creator_id_key;


--
-- Name: followings_200000_user_id_creator_id_key; Type: INDEX ATTACH; Schema: public; Owner: postgres
--

ALTER INDEX public.unique_following ATTACH PARTITION public.followings_200000_user_id_creator_id_key;


--
-- Name: followings_300000_user_id_creator_id_key; Type: INDEX ATTACH; Schema: public; Owner: postgres
--

ALTER INDEX public.unique_following ATTACH PARTITION public.followings_300000_user_id_creator_id_key;


--
-- Name: followings_400000_user_id_creator_id_key; Type: INDEX ATTACH; Schema: public; Owner: postgres
--

ALTER INDEX public.unique_following ATTACH PARTITION public.followings_400000_user_id_creator_id_key;


--
-- Name: followings_500000_user_id_creator_id_key; Type: INDEX ATTACH; Schema: public; Owner: postgres
--

ALTER INDEX public.unique_following ATTACH PARTITION public.followings_500000_user_id_creator_id_key;


--
-- Name: billings billings_bank_type_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.billings
    ADD CONSTRAINT billings_bank_type_id_fkey FOREIGN KEY (bank_type_id) REFERENCES public.bank_types(bank_type_id);


--
-- Name: billings billings_currency_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.billings
    ADD CONSTRAINT billings_currency_id_fkey FOREIGN KEY (currency_id) REFERENCES public.currencies(currency_id);


--
-- Name: billings billings_user_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.billings
    ADD CONSTRAINT billings_user_id_fkey FOREIGN KEY (user_id) REFERENCES public.users(user_id);


--
-- Name: comments comments_recipient_comment_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.comments
    ADD CONSTRAINT comments_recipient_comment_id_fkey FOREIGN KEY (recipient_comment_id) REFERENCES public.comments(comment_id);


--
-- Name: comments comments_recipient_post_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.comments
    ADD CONSTRAINT comments_recipient_post_id_fkey FOREIGN KEY (recipient_post_id) REFERENCES public.posts(post_id);


--
-- Name: comments comments_sender_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.comments
    ADD CONSTRAINT comments_sender_id_fkey FOREIGN KEY (sender_id) REFERENCES public.users(user_id);


--
-- Name: creators creators_creator_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.creators
    ADD CONSTRAINT creators_creator_id_fkey FOREIGN KEY (creator_id) REFERENCES public.users(user_id);


--
-- Name: creators creators_withdrawal_system_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.creators
    ADD CONSTRAINT creators_withdrawal_system_id_fkey FOREIGN KEY (withdrawal_system_id) REFERENCES public.withdrawal_systems(withdrawal_system_id);


--
-- Name: followings followings_creator_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE public.followings
    ADD CONSTRAINT followings_creator_id_fkey FOREIGN KEY (creator_id) REFERENCES public.creators(creator_id);


--
-- Name: followings followings_user_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE public.followings
    ADD CONSTRAINT followings_user_id_fkey FOREIGN KEY (user_id) REFERENCES public.users(user_id);


--
-- Name: links links_creator_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.links
    ADD CONSTRAINT links_creator_id_fkey FOREIGN KEY (creator_id) REFERENCES public.creators(creator_id);


--
-- Name: posts posts_attachment_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.posts
    ADD CONSTRAINT posts_attachment_id_fkey FOREIGN KEY (attachment_id) REFERENCES public.attachments(attachment_id);


--
-- Name: posts posts_attachment_type_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.posts
    ADD CONSTRAINT posts_attachment_type_id_fkey FOREIGN KEY (attachment_type_id) REFERENCES public.attachment_types(attachment_type_id);


--
-- Name: posts posts_creator_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.posts
    ADD CONSTRAINT posts_creator_id_fkey FOREIGN KEY (creator_id) REFERENCES public.creators(creator_id);


--
-- Name: posts posts_minimal_required_sub_level_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.posts
    ADD CONSTRAINT posts_minimal_required_sub_level_id_fkey FOREIGN KEY (minimal_required_sub_level_id) REFERENCES public.subscription_levels(sub_level_id);


--
-- Name: subscription_levels subscription_levels_creator_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.subscription_levels
    ADD CONSTRAINT subscription_levels_creator_id_fkey FOREIGN KEY (creator_id) REFERENCES public.creators(creator_id);


--
-- Name: subscriptions subscriptions_sub_level_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.subscriptions
    ADD CONSTRAINT subscriptions_sub_level_id_fkey FOREIGN KEY (sub_level_id) REFERENCES public.subscription_levels(sub_level_id);


--
-- Name: subscriptions subscriptions_user_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.subscriptions
    ADD CONSTRAINT subscriptions_user_id_fkey FOREIGN KEY (user_id) REFERENCES public.users(user_id);


--
-- Name: tags tags_post_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.tags
    ADD CONSTRAINT tags_post_id_fkey FOREIGN KEY (post_id) REFERENCES public.posts(post_id);


--
-- Name: withdrawals withdrawals_creator_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.withdrawals
    ADD CONSTRAINT withdrawals_creator_id_fkey FOREIGN KEY (creator_id) REFERENCES public.creators(creator_id);


--
-- Name: withdrawals withdrawals_withdrawal_system_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.withdrawals
    ADD CONSTRAINT withdrawals_withdrawal_system_id_fkey FOREIGN KEY (withdrawal_system_id) REFERENCES public.withdrawal_systems(withdrawal_system_id);


--
-- PostgreSQL database dump complete
--

