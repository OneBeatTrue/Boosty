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
    attachment bytea NOT NULL,
    post_id bigint NOT NULL,
    attachment_type_id bigint NOT NULL
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
1	Photo
2	Video
3	File
4	Audio
\.


--
-- Data for Name: attachments; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.attachments (attachment_id, attachment, post_id, attachment_type_id) FROM stdin;
1	\\xc88e95caf5c470a8a299	1	3
2	\\x5befc6c23a30761f3dc3	2	1
3	\\xbe747a80350afe0ff252	3	2
4	\\x90f69bed125b0c26a389	3	3
5	\\x1c981efb1b803d196653	4	1
6	\\x25ef463cdb7a65104bf6	5	4
7	\\x99690c27eea085a3d8de	6	4
8	\\x97a1b1de30e639826bee	6	3
9	\\xa468a54609fc4756a702	7	4
10	\\xa9c34a3873bca902c63f	7	4
11	\\x9dbeed2e688604638646	8	1
12	\\x15608632971f1490add2	8	3
13	\\xff11f4d1a250ec8870d9	9	2
14	\\x19d26111fd7872058b0a	10	1
15	\\x4c8172fbf1b510ea4199	11	1
16	\\x795b7d50a17be56a3037	11	4
17	\\xd0f3b092b12613248bf1	12	1
18	\\xef8aa34e0f15931f5243	12	2
19	\\xbb77b414c28f30772061	13	4
20	\\x77b985805a3a9bb8893a	14	1
21	\\xcff0860eb92b38074313	15	4
22	\\xabf21ac8bf5129cb564b	16	2
23	\\x4b14d6df9d6bdfaa9eb7	16	2
24	\\x6cff82471f92ba1b65a7	17	2
25	\\xbaa3b50ace6b3ed75b0f	18	4
26	\\xc02eedc83c84c6ba120e	18	2
27	\\x7a10e37ea7ea29cd59c3	19	4
\.


--
-- Data for Name: bank_types; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.bank_types (bank_type_id, bank_type_name) FROM stdin;
1	Russian
2	Foreign
\.


--
-- Data for Name: billings; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.billings (billing_id, user_id, currency_id, card_number, valid_until, cardholder_name, cvv, bank_type_id) FROM stdin;
1	1	4	3507164554091268	2022-12-08	gsIBGqXaoU	475	1
2	1	2	2060080543920955	2022-07-10	YMbPqWighw	715	2
3	2	1	4171510561899758	2017-05-02	TlReGHZdaB	103	2
4	3	2	9262887723595074	2024-06-22	crWOkruLGF	636	2
5	4	3	4614856061447471	2023-03-03	AyCWdlPQTj	503	1
6	4	4	3256215398811316	2019-09-20	kJbtScZXrp	876	2
7	5	3	4108177028753059	2015-05-27	NzwvzcCUve	911	1
8	7	1	6209568023123192	2018-03-01	jRduXnhpaE	923	1
9	7	4	8390304342738758	2023-02-05	lwClDMXOYY	134	2
10	9	4	7813364903760856	2015-09-25	OmFPWmacgk	394	2
11	9	4	7168515564640513	2018-05-15	ZSwgEgLFgB	282	1
\.


--
-- Data for Name: comments; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.comments (comment_id, recipient_comment_id, recipient_post_id, sender_id, message) FROM stdin;
1	\N	6	1	"ZU27,9yO+
2	\N	14	1	`Ejb4LVL
3	\N	9	2	)Cny|Qo
4	\N	9	2	/W+gh)<+
5	\N	4	3	!sJg
6	5	4	3	N"KBUm_^;g
7	5	4	4	|6ol+E"}j
8	5	4	4	)CZ\\s9uyO4
9	8	4	5	N|G\\:7Q[
10	8	4	5	3)@k%O#T
11	\N	17	6	('S{[
12	11	13	6	4h/_k)
13	11	13	7	i#?i9*C`[B
14	\N	3	7	oqF|SW&@@
15	14	9	8	-d\\DZ>Kc?I
16	14	9	8	Bu=qc@ 
17	16	9	9	/
18	\N	16	9	WAZfsUzs)u
19	16	9	10	Wq
20	\N	19	10	GQB[QI9z*
\.


--
-- Data for Name: creators; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.creators (creator_id, cover, description, withdrawal_system_id, withdrawal_required_inf, balance) FROM stdin;
2	\\xdc70bc4d15ad14329219	argkYGThJr	1	dsngZyVPOI	248.98
3	\\xfda682f611c8fac117ea	sqfuArlTWR	3	AqCRCLZRBV	234.29
4	\\x577f5189feeb3268a369	rFIfUPjsKr	3	QosqClowff	691.16
5	\\x9af71a83df983d01805b	FRWXhBtcUQ	2	avrsVMDAEB	532
8	\\x9d1a494a0754c65f7102	bdStVawxxi	1	tjbfDCaJtG	417.31
\.


--
-- Data for Name: currencies; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.currencies (currency_id, currency_name) FROM stdin;
1	Rubles
2	Dollars
3	Euro
4	Yuan
\.


--
-- Data for Name: followings_0; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.followings_0 (user_id, creator_id) FROM stdin;
1	8
1	5
2	3
4	3
4	4
4	5
4	8
5	2
5	3
5	4
5	5
5	8
6	4
6	5
6	8
7	3
7	8
8	3
8	4
8	5
8	8
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
1	3	iJPkdvFAZS
2	3	uEmSdgchsF
3	3	iaEISWyitU
4	3	weVXvwliPV
5	4	QtIRsgeDcr
6	4	eHAjfxjaPN
7	4	DfRrPfYCOt
8	4	khbYIAAZeN
9	4	MqfAWzcPTq
10	4	dRrfVZrhaz
11	4	HFPsUeGtjn
12	4	AKAjSBYeWF
13	4	ZNfyrofeSx
14	5	bCjoyAhyEo
15	5	fCXnpGzkeh
16	5	eercjerrzA
17	5	FeimhyWthS
18	5	yzRArrXxml
19	5	mWVUaZcqcg
20	5	LwyMgLtdTH
21	5	uWLXGXJUid
22	8	FFkGfyuWou
23	8	NAHXClitEY
24	8	fHumueEyZS
25	8	PVNzakPmqy
26	8	daWetnQXSZ
27	8	YfmvfvysgS
28	8	YTjTkVvxzz
29	8	zbhFiWvdrg
30	8	qlAxRvAoPl
\.


--
-- Data for Name: posts; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.posts (post_id, creator_id, minimal_required_sub_level_id, title, content, teaser_text, teaser_img, comments_availability) FROM stdin;
1	2	3	rWJYesXBFl	r	DpihYvdasA	\\xfb692561b2bbf3b73920	t
2	2	3	aaPwMGzwyl	ia:gYFd{	nTNVLIlghl	\\x83ee3354025f33c8dd59	t
3	2	3	ciOpxifUtX	@yK1	spbFuxoZSV	\\x72e54014f02b02b3b401	t
4	3	4	YykFewdSqN	%)y&'	kRVhQSEjwM	\\x0eec050d20e612cd91b8	t
5	3	4	GPNUJdTYNm	/(4qD&k^z	MTTCFscfXP	\\xd9be22a3f166288b44ae	t
6	3	5	ACeZBZewVj	t %'	NGueldXhgZ	\\x94368a898a1d7679949e	t
7	3	5	aWwtxhAwCO	"V8_[oS2=	IepnUZTCVV	\\xe925750dbd55d0717070	t
8	3	6	NPwhvyhMMJ	O^n|"@"	qUXTmNoZRw	\\x30393767a0c25e36b130	t
9	3	6	TRObOTgIDl	*3xh7Jp*F	czNXmIvyAp	\\xafdefcd3644f7232d81b	t
10	4	9	BmXyJMjMkN	U9n6rx	kWmGgzxPxf	\\x760afe893532caa2c927	t
11	4	7	PFOBZrhDyq	!U	FxxpGBZsQr	\\x2c862d3b2021a1a4f15c	t
12	5	13	uTEacRFGwa	S!=A>#xN	qJNxwbpBvg	\\x9cc3bdc9b61f257c2e89	t
13	5	13	wxGzLvIAjP	c*	fzuwZnxqGb	\\x9af21ccb9caa9d220009	t
14	5	13	OTXxoFHgAh	(@;6J/7>*	iakkxUenEP	\\xedfdace283e17a6acda2	t
15	5	14	QzulnSQHEZ	xMkh8	eIvLCKWavo	\\x0179ad09bb5ad9c765e9	t
16	5	14	YtktoLzqBr	-Eoxo'6Z	uoPjzxkUZi	\\x53774c23b74296b06dae	t
17	8	15	mTHMfUFDXb	j\\\\	GaJDgfsqBT	\\xe1e64825fb0b2bf8df0f	t
18	8	15	imNviLiRrP	f=wxU	EuTiksBbFr	\\x7e78e9366a5eeaac67d9	t
19	8	15	WduyidRXDa	nUl>lvnXdL	RzOKPEffGQ	\\xc0a5d5010d2a209f1d0e	t
\.


--
-- Data for Name: subscription_levels; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.subscription_levels (sub_level_id, creator_id, price, title, cover, description, welcome_message) FROM stdin;
1	2	253.66	nAbYXxjMwq	\\x0660686478a526b10cb2	aPeqJncOxW	pXyjNDiCyb
2	2	43.85	JNHMFdcCJz	\\x7f3fd74a40e53eae6100	qczwaiwsfd	UEJBEzqPaV
3	2	837.19	IWNjNfnBoG	\\xbb52575661d784b06a48	pnEImxVofI	xNvnMqiKWe
4	3	648.07	UeenVPElMB	\\x8ae5dd45941333777db4	NZaGDpKLcT	ldTigbLxIN
5	3	492.97	BnWHEmaqgY	\\xe38a666a4aa4e44f3e73	wrOatQUvzA	RdMWabwbZK
6	3	846.47	cnomzrimPw	\\x4e98b9d3cc0c21e0972e	uQZuoCMdkn	RfwECIGRKv
7	4	982.53	sDJvylCttj	\\x9f8e546004b514261c3a	SBSKSiJwzj	raOXBNaTgr
8	4	673.14	OFaHmGnxeS	\\x21d99126d608e64dba0c	ITfpqWlRex	tJqGfpUOBE
9	4	519.07	uUXKoNZQxW	\\xf0fbaad45a3f83b4d290	cUdfITYVeq	AxZSiwzpYi
10	5	485.43	QAbhblHXkA	\\x41fec832027cc4ccb0a7	rjinMNhGdQ	iXhpHyDSWI
11	5	782.65	OSXfhRJvam	\\x174fb929d2e86fb9c04e	QKIoSBUnPb	DIIkQIACOt
12	5	186.95	QjYrAMmDjt	\\x2baa042c079162463a7d	NyIAlpJQUs	PfGaaIDfwV
13	5	638.81	ecKqoQuJtX	\\x6155013d33d8b0700606	EUitlWFIPL	AjyVpPEpjI
14	5	371.14	xtuvQVjkCQ	\\x0d4f3b3865d721c21bb9	DrvIJIGPED	ArnfECbEjy
15	8	59.83	jnXRzLdXxE	\\xddf3e45ca7872a0929fe	WrvgbLkaPY	ruFKftMbEa
\.


--
-- Data for Name: subscriptions; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.subscriptions (sub_id, user_id, sub_level_id, start_date, end_date) FROM stdin;
1	1	9	2017-01-26	2024-02-22
2	1	3	2015-03-28	2019-01-03
3	1	6	2021-02-23	2024-06-24
4	1	1	2018-01-13	2019-02-21
5	2	10	2015-07-13	2021-10-22
6	2	12	2018-10-25	2022-05-19
7	3	7	2017-10-14	2020-07-26
8	3	14	2016-11-02	2017-03-15
9	4	8	2016-09-23	2019-11-09
10	4	15	2016-10-07	2019-11-06
11	5	6	2018-08-14	2021-01-02
12	5	3	2017-03-21	2023-03-23
13	5	9	2021-03-18	2023-07-11
14	6	10	2024-12-08	2024-12-26
15	6	7	2022-07-09	2024-03-07
16	6	5	2019-12-03	2020-02-10
17	6	13	2020-12-06	2022-11-16
18	6	8	2018-04-05	2021-03-10
19	7	5	2015-06-17	2022-01-25
20	7	6	2019-06-20	2024-06-11
21	7	5	2018-06-06	2020-02-01
22	7	3	2021-09-24	2024-09-27
23	7	15	2015-06-10	2017-10-02
24	7	9	2019-04-12	2020-01-20
25	8	10	2016-01-20	2022-05-23
26	8	5	2019-09-20	2024-11-05
27	8	14	2017-02-09	2023-03-06
28	9	5	2015-02-23	2018-12-07
29	9	8	2022-04-28	2024-06-19
30	9	7	2016-04-06	2017-11-14
\.


--
-- Data for Name: tags; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.tags (tag, post_id) FROM stdin;
#video	1
#text	1
#music	1
#video	4
#gif	4
#photo	5
#text	5
#music	5
#music	7
#video	8
#photo	8
#photo	9
#music	9
#photo	10
#text	10
#music	10
#photo	11
#text	11
#music	11
#photo	13
#text	13
#photo	14
#gif	14
#text	14
#photo	15
#gif	15
#video	16
#gif	16
#photo	16
#video	17
#text	17
\.


--
-- Data for Name: users; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.users (user_id, name, phone_number, email, profile_picture, password) FROM stdin;
1	ndPtYgwJrn	4088783665	erzkp@itmo.com	\\x522e8a0ffacfa265e4bb	52bef14a372079c7fb7bb484bb7cd6cd8a67c14357f8c277cf5d3ca2f61f61e2
2	GnfUQtNLDb	6730793688	lgsnz@itmo.com	\\x0893cb6f4b3717857363	a931807d32dbb2c93a76891970ddf0b89d0f15ff673c733dd542669a4df4bde2
3	SNmBmRyOjm	6879392698	lxwfs@itmo.com	\\x5a1400df07bcf6578488	192e002b0b2fe11a290cbee3b7b4458f28c9606f2498a4b4cb73fdc26d7e00ff
4	xiVxuhaBcu	3969320686	lxeon@itmo.com	\\xe228f62c37ab0264bd65	2d106a5c732b49d150dc3b64162d5d3d069acd0844200b07d8aac6320bd8dec6
5	CgIBpxEXwq	3440266929	wfzrn@itmo.com	\\x389fea0b17f3036461f9	8001c3bd1d4199203d15f6fdd32c653bf89f44436bcb2a6445a0ddc91e82bbf9
6	YpEPuRbHmn	7773120551	htikx@itmo.com	\\xf2ef594856447f16d801	bf543d354c6062068256ccbc9a0ae58cbe2412ab01e807246f557c9cb1f7717b
7	MLmIVlQaUv	5313044799	lmqxc@itmo.com	\\xf80e2052b712615c7df7	2339c20be82789c24375be85f793e00766d83c55c52c402942e33fb3efe52468
8	FehYDuZcUQ	3140525710	muhnj@itmo.com	\\xbf55005bfedd882fd7d2	a2c6f6e11d256d2e752d3d173a5b47e9d3574e5c2552d5acf4c12607fd67b80c
9	NGHmZDWPcX	2129338567	hlqgo@itmo.com	\\x43d82f88d44b385c115a	fd6317c460a181fb8e43d7121763f44960e9c8aee998632b693f2eb4814f9a2f
10	OzKYEhIBgH	8862771666	qhosz@itmo.com	\\xf4bb28db7aee093811d4	e3049f84a0a52da66e86caa91c7061c033e36b9070329bf53d5f476fd7b7dcef
\.


--
-- Data for Name: withdrawal_systems; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.withdrawal_systems (withdrawal_system_id, name, percent, mandatory_deduction) FROM stdin;
1	Bank cards	0.5	30
2	VK Pay	0	0
3	PayPal	2.5	0
\.


--
-- Data for Name: withdrawals; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.withdrawals (withdrawal_id, creator_id, withdrawal_system_id, datetime, amount) FROM stdin;
1	2	2	2015-11-21 01:46:25	440.51
2	2	2	2024-06-20 02:20:35	686.69
3	2	1	2023-08-31 14:38:35	999.24
4	2	2	2021-09-20 03:10:45	154.93
5	2	1	2017-05-25 04:18:35	512.56
6	2	3	2015-01-31 23:58:01	648.85
7	3	1	2015-08-06 21:45:35	946.02
8	3	1	2017-11-01 21:55:32	548.23
9	3	3	2023-06-30 16:41:41	639.03
10	3	3	2017-08-04 06:54:19	107.26
11	3	2	2024-08-16 08:10:13	627.64
12	3	2	2016-02-04 15:25:33	689.46
13	3	2	2020-04-24 01:27:17	593.11
14	3	1	2021-07-26 20:16:00	371.7
15	3	1	2023-05-11 03:04:04	477.48
16	3	1	2023-05-11 01:57:03	684.19
17	4	3	2016-06-18 19:56:49	155.84
18	4	1	2019-11-06 05:11:42	803.6
19	4	2	2023-04-03 15:43:49	478.14
20	4	2	2017-11-15 02:35:15	20.98
21	5	1	2020-10-27 14:45:04	256.33
22	5	3	2024-12-14 04:13:19	726.28
23	5	1	2019-11-05 20:13:03	987.04
24	5	3	2015-07-20 06:51:47	847.62
25	5	3	2016-01-24 05:06:57	4.34
26	5	2	2015-08-23 16:58:11	283.71
27	5	3	2022-06-25 03:25:51	782.22
28	8	1	2018-04-17 10:41:32	398.45
\.


--
-- Name: attachment_types_attachment_type_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.attachment_types_attachment_type_id_seq', 4, true);


--
-- Name: attachments_attachment_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.attachments_attachment_id_seq', 27, true);


--
-- Name: bank_types_bank_type_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.bank_types_bank_type_id_seq', 2, true);


--
-- Name: billings_billing_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.billings_billing_id_seq', 11, true);


--
-- Name: comments_comment_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.comments_comment_id_seq', 20, true);


--
-- Name: currencies_currency_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.currencies_currency_id_seq', 4, true);


--
-- Name: links_link_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.links_link_id_seq', 30, true);


--
-- Name: posts_post_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.posts_post_id_seq', 19, true);


--
-- Name: subscription_levels_sub_level_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.subscription_levels_sub_level_id_seq', 15, true);


--
-- Name: subscriptions_sub_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.subscriptions_sub_id_seq', 30, true);


--
-- Name: users_user_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.users_user_id_seq', 10, true);


--
-- Name: withdrawal_systems_withdrawal_system_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.withdrawal_systems_withdrawal_system_id_seq', 3, true);


--
-- Name: withdrawals_withdrawal_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.withdrawals_withdrawal_id_seq', 28, true);


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
-- Name: attachments attachments_attachment_type_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.attachments
    ADD CONSTRAINT attachments_attachment_type_id_fkey FOREIGN KEY (attachment_type_id) REFERENCES public.attachment_types(attachment_type_id);


--
-- Name: attachments attachments_post_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.attachments
    ADD CONSTRAINT attachments_post_id_fkey FOREIGN KEY (post_id) REFERENCES public.posts(post_id);


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
-- Name: TABLE attachment_types; Type: ACL; Schema: public; Owner: postgres
--

GRANT SELECT ON TABLE public.attachment_types TO reader;
GRANT SELECT,INSERT,UPDATE ON TABLE public.attachment_types TO writer;
GRANT SELECT,INSERT,DELETE,UPDATE ON TABLE public.attachment_types TO no_login;


--
-- Name: TABLE attachments; Type: ACL; Schema: public; Owner: postgres
--

GRANT SELECT ON TABLE public.attachments TO reader;
GRANT SELECT,INSERT,UPDATE ON TABLE public.attachments TO writer;
GRANT SELECT,INSERT,DELETE,UPDATE ON TABLE public.attachments TO no_login;


--
-- Name: TABLE bank_types; Type: ACL; Schema: public; Owner: postgres
--

GRANT SELECT ON TABLE public.bank_types TO reader;
GRANT SELECT,INSERT,UPDATE ON TABLE public.bank_types TO writer;
GRANT SELECT,INSERT,DELETE,UPDATE ON TABLE public.bank_types TO no_login;


--
-- Name: TABLE billings; Type: ACL; Schema: public; Owner: postgres
--

GRANT SELECT ON TABLE public.billings TO reader;
GRANT SELECT,INSERT,UPDATE ON TABLE public.billings TO writer;
GRANT SELECT,INSERT,DELETE,UPDATE ON TABLE public.billings TO no_login;


--
-- Name: TABLE comments; Type: ACL; Schema: public; Owner: postgres
--

GRANT SELECT ON TABLE public.comments TO reader;
GRANT SELECT,INSERT,UPDATE ON TABLE public.comments TO writer;
GRANT SELECT,INSERT,DELETE,UPDATE ON TABLE public.comments TO no_login;


--
-- Name: TABLE creators; Type: ACL; Schema: public; Owner: postgres
--

GRANT SELECT ON TABLE public.creators TO reader;
GRANT SELECT,INSERT,UPDATE ON TABLE public.creators TO writer;
GRANT SELECT,INSERT,DELETE,UPDATE ON TABLE public.creators TO no_login;


--
-- Name: TABLE currencies; Type: ACL; Schema: public; Owner: postgres
--

GRANT SELECT ON TABLE public.currencies TO reader;
GRANT SELECT,INSERT,UPDATE ON TABLE public.currencies TO writer;
GRANT SELECT,INSERT,DELETE,UPDATE ON TABLE public.currencies TO no_login;


--
-- Name: TABLE followings; Type: ACL; Schema: public; Owner: postgres
--

GRANT SELECT ON TABLE public.followings TO reader;
GRANT SELECT,INSERT,UPDATE ON TABLE public.followings TO writer;
GRANT SELECT,INSERT,DELETE,UPDATE ON TABLE public.followings TO no_login;


--
-- Name: TABLE followings_0; Type: ACL; Schema: public; Owner: postgres
--

GRANT SELECT ON TABLE public.followings_0 TO reader;
GRANT SELECT,INSERT,UPDATE ON TABLE public.followings_0 TO writer;
GRANT SELECT,INSERT,DELETE,UPDATE ON TABLE public.followings_0 TO no_login;


--
-- Name: TABLE followings_100000; Type: ACL; Schema: public; Owner: postgres
--

GRANT SELECT ON TABLE public.followings_100000 TO reader;
GRANT SELECT,INSERT,UPDATE ON TABLE public.followings_100000 TO writer;
GRANT SELECT,INSERT,DELETE,UPDATE ON TABLE public.followings_100000 TO no_login;


--
-- Name: TABLE followings_200000; Type: ACL; Schema: public; Owner: postgres
--

GRANT SELECT ON TABLE public.followings_200000 TO reader;
GRANT SELECT,INSERT,UPDATE ON TABLE public.followings_200000 TO writer;
GRANT SELECT,INSERT,DELETE,UPDATE ON TABLE public.followings_200000 TO no_login;


--
-- Name: TABLE followings_300000; Type: ACL; Schema: public; Owner: postgres
--

GRANT SELECT ON TABLE public.followings_300000 TO reader;
GRANT SELECT,INSERT,UPDATE ON TABLE public.followings_300000 TO writer;
GRANT SELECT,INSERT,DELETE,UPDATE ON TABLE public.followings_300000 TO no_login;


--
-- Name: TABLE followings_400000; Type: ACL; Schema: public; Owner: postgres
--

GRANT SELECT ON TABLE public.followings_400000 TO reader;
GRANT SELECT,INSERT,UPDATE ON TABLE public.followings_400000 TO writer;
GRANT SELECT,INSERT,DELETE,UPDATE ON TABLE public.followings_400000 TO no_login;


--
-- Name: TABLE followings_500000; Type: ACL; Schema: public; Owner: postgres
--

GRANT SELECT ON TABLE public.followings_500000 TO reader;
GRANT SELECT,INSERT,UPDATE ON TABLE public.followings_500000 TO writer;
GRANT SELECT,INSERT,DELETE,UPDATE ON TABLE public.followings_500000 TO no_login;


--
-- Name: TABLE links; Type: ACL; Schema: public; Owner: postgres
--

GRANT SELECT ON TABLE public.links TO reader;
GRANT SELECT,INSERT,UPDATE ON TABLE public.links TO writer;
GRANT SELECT,INSERT,DELETE,UPDATE ON TABLE public.links TO no_login;


--
-- Name: TABLE posts; Type: ACL; Schema: public; Owner: postgres
--

GRANT SELECT ON TABLE public.posts TO reader;
GRANT SELECT,INSERT,UPDATE ON TABLE public.posts TO writer;
GRANT SELECT,INSERT,DELETE,UPDATE ON TABLE public.posts TO no_login;


--
-- Name: TABLE subscription_levels; Type: ACL; Schema: public; Owner: postgres
--

GRANT SELECT ON TABLE public.subscription_levels TO reader;
GRANT SELECT,INSERT,UPDATE ON TABLE public.subscription_levels TO writer;
GRANT SELECT,INSERT,DELETE,UPDATE ON TABLE public.subscription_levels TO no_login;


--
-- Name: TABLE subscriptions; Type: ACL; Schema: public; Owner: postgres
--

GRANT SELECT ON TABLE public.subscriptions TO reader;
GRANT SELECT,INSERT,UPDATE ON TABLE public.subscriptions TO writer;
GRANT SELECT,INSERT,DELETE,UPDATE ON TABLE public.subscriptions TO no_login;


--
-- Name: TABLE tags; Type: ACL; Schema: public; Owner: postgres
--

GRANT SELECT ON TABLE public.tags TO reader;
GRANT SELECT,INSERT,UPDATE ON TABLE public.tags TO writer;
GRANT SELECT,INSERT,DELETE,UPDATE ON TABLE public.tags TO no_login;


--
-- Name: TABLE users; Type: ACL; Schema: public; Owner: postgres
--

GRANT SELECT ON TABLE public.users TO reader;
GRANT SELECT,INSERT,UPDATE ON TABLE public.users TO writer;
GRANT SELECT ON TABLE public.users TO analytic;
GRANT SELECT,INSERT,DELETE,UPDATE ON TABLE public.users TO no_login;


--
-- Name: TABLE withdrawal_systems; Type: ACL; Schema: public; Owner: postgres
--

GRANT SELECT ON TABLE public.withdrawal_systems TO reader;
GRANT SELECT,INSERT,UPDATE ON TABLE public.withdrawal_systems TO writer;
GRANT SELECT,INSERT,DELETE,UPDATE ON TABLE public.withdrawal_systems TO no_login;


--
-- Name: TABLE withdrawals; Type: ACL; Schema: public; Owner: postgres
--

GRANT SELECT ON TABLE public.withdrawals TO reader;
GRANT SELECT,INSERT,UPDATE ON TABLE public.withdrawals TO writer;
GRANT SELECT,INSERT,DELETE,UPDATE ON TABLE public.withdrawals TO no_login;


--
-- PostgreSQL database dump complete
--

