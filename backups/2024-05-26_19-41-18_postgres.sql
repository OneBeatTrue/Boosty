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
1	\\xa201fa74585de0198def	1	1
2	\\x56c0b5d7ee31cf9302aa	1	1
3	\\x32cac5ad53d506e9977c	2	4
4	\\x478cc75b465a6030a236	2	2
5	\\x6afb74d554233f1dd9f5	3	1
6	\\xc361ba9f8c8653ca5e73	3	3
7	\\xeccb096be2331dff40d0	4	1
8	\\xe7b22365283e4a925d30	4	4
9	\\x33f75607b3a7681e6960	5	2
10	\\xfa47e16138613d3efef6	6	4
11	\\x049e2bfae1f0cd0cdad8	6	2
12	\\x099bc32bb983a5ff56e4	7	2
13	\\xcb9ae53be808af0b3aa3	7	1
14	\\x25072885a684f588389d	8	1
15	\\xd140f8b3b1c627e57cba	9	4
16	\\x57effcbbd082e301ae70	9	3
17	\\xff53e9b3b26e0aede388	10	1
18	\\x6653507dd2f878a917ee	11	4
19	\\x065597d09c9ce46ab0c6	12	2
20	\\x77debb92f92a8c1e1e29	12	4
21	\\x46dd58ca2e446686ee6c	13	1
22	\\x271c020025ce5bdbef55	13	3
23	\\x3c87406694aa3c6f0352	14	3
24	\\x904d9a9902f688b29212	15	2
25	\\xdf83d0ca2269d2da56c5	16	2
26	\\x22a964adec2842d1c626	16	4
27	\\x64d8008b4c3eeb6666a6	17	1
28	\\x7f9f4cbb443449722fab	18	1
29	\\xb747fcfce25b2854b174	19	3
30	\\xf27b95607e585d8a214f	19	3
31	\\xb4d82c1698c48ede3139	20	1
32	\\xf14235a5d98fec3c802a	20	4
33	\\x0ea8ec9409615fbcd5ff	21	1
34	\\xcd01449296ffa09cb687	22	4
35	\\x35a08b10b9f37b183852	22	3
36	\\x91df0a186bbf1a80502f	23	4
37	\\xf9c6408598a2ba3d7828	23	4
38	\\xde39624800d79c1a4bf0	24	4
39	\\x132cf28d62a642f801b2	25	3
40	\\xa9965e9ec6a29311bbe7	25	2
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
1	2	2	1837455240907699	2020-09-24	SHwMrHGPuN	113	1
2	2	2	5035394244180302	2021-06-08	wTeBnjAnIs	537	1
3	3	4	8229968948814915	2016-04-27	JPGmvIttvH	389	1
4	4	3	5263159540009576	2019-02-26	aLLXodPjgH	241	2
5	5	1	8342516288076703	2021-08-18	EmXEDcJMaR	655	1
6	6	2	5429497872205693	2015-02-27	cPokdNvnLa	231	1
7	6	3	1848911325743790	2020-12-24	mpLXyVyUJv	421	1
8	7	1	5566125920562231	2015-06-16	hfssWZCnCK	462	1
9	8	2	8809664242600278	2022-12-20	hubZosSyYV	713	1
10	8	3	9145450794259210	2019-02-27	jhlCOEIYLz	292	1
\.


--
-- Data for Name: comments; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.comments (comment_id, recipient_comment_id, recipient_post_id, sender_id, message) FROM stdin;
1	\N	8	1	7acno`
2	\N	9	1	!p'v.dDa
3	\N	9	2	gx{q_lX
4	3	24	2	Ep
5	4	24	3	Bh't8I
6	\N	9	3	cBfK{o7"
7	\N	14	4	!l
8	6	16	4	B
9	8	16	5	R
10	9	16	5	4S
11	9	16	6	fB!cGP/u
12	\N	12	6	eojc&5Z5
13	9	16	7	_s
14	\N	22	7	Z9u9
15	13	16	8	Fv{8',
16	\N	11	8	B#
17	\N	6	9	*lBR@
18	\N	6	9	a2pdGJ}?
19	16	1	10	S8\\,VQ0
20	\N	18	10	zyU%l
\.


--
-- Data for Name: creators; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.creators (creator_id, cover, description, withdrawal_system_id, withdrawal_required_inf, balance) FROM stdin;
1	\\x2195109c6dd2a6d0322f	PJBdnbdnDI	2	aPnwUQWuFb	101.92
2	\\x39bb6f0cf2e8a07fa05b	KunrALUzqP	1	mMIDOSKVQf	575.15
3	\\x707270f7f86192aaabac	MDytVSfDsG	1	qtDiakgZgU	64.86
4	\\xae064be9cea77b8e89c5	aOpPaTIhaK	3	VmSTctHgMW	258.37
6	\\x20119e51abd3924c533e	HZJudfXEfS	3	JSONlXmcEN	485.09
10	\\xea929ca2517fa05605f9	iMAnqaHtho	2	pWdKnIfYGZ	962.51
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
1	1
1	3
1	4
2	1
2	2
3	2
3	3
3	4
4	1
4	2
4	4
4	6
5	1
5	2
5	3
5	4
5	6
5	10
6	6
7	2
7	3
7	4
7	6
7	10
8	1
8	2
8	4
8	6
9	1
9	2
9	3
9	4
9	6
9	10
10	1
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
1	1	FQfLnohEWl
2	2	BgbKNUVTmq
3	2	XAfLzFhmww
4	2	WBbWZeBUnQ
5	2	ZmdtAfHYvL
6	2	lFJfQrplwz
7	2	ZlGwVBtJwb
8	2	WffsMmgYyQ
9	3	NrHhxSOZKD
10	3	gbRLKCUDXS
11	3	yVZrjZFdWM
12	3	NgbDCdqtvF
13	3	ymYRSbpunE
14	4	HMdeVXmJRB
15	4	WrpPvJaajX
16	4	BQEGXvxKBO
17	4	EHPYTNvxJc
18	4	UAPQDDgCPD
19	4	XOxxeADVDo
20	4	PEclgPyfiJ
21	4	GPcSdepMMP
22	10	NAMnomRheT
23	10	WdSJaXBGHd
24	10	KHFySapCDn
25	10	ZmIzCALgAi
26	10	lsgNBKbXDD
27	10	QcDDITtcDa
\.


--
-- Data for Name: posts; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.posts (post_id, creator_id, minimal_required_sub_level_id, title, content, teaser_text, teaser_img, comments_availability) FROM stdin;
1	1	1	WDZaWJPJTY	bj4]@e(t"^	cQzOEimgqc	\\x1260e317114371a8db09	t
2	1	1	FArPdtGFvm	,hUR4)"C@i	ozEfaywIVG	\\x0644204b99059761d2ef	t
3	1	2	PyHggKKKnC	o.hqU:C|3	seEMTXViZo	\\xddaaf55a02923965fa38	t
4	1	2	yMLyqXOSLz	f:s~U=%	fcwQywfEFU	\\xe54b9b9ed490ae2b0dde	t
5	1	3	weDJGhHzoY	HrV	qnWlfuQLbc	\\x2e8f84ff21cabaf6ba0c	t
6	1	3	WPnSfvyeKT	){2	asRubrRbpK	\\x5340efd422f7c87ba37e	t
7	2	6	vnGBFDTkxm	5ab){	EvLJMWdDpO	\\xe95d803a2842eb2b4e12	t
8	2	8	QMwNlLNHMf	RHPGNcY56	jKnRPAcQGI	\\x2832f8521c31a74940f8	t
9	2	8	azGWtcFXxw	u|E	oWXydUkFwY	\\x0bd8c0cd04afab79091e	t
10	2	8	uSBcyHOvae	u	RqcGFbIOXK	\\x6e5cea7c88dbc34916bf	t
11	3	10	JVUOaymqvT	eXP_	NtXlTeKEil	\\x76b018bdc220f51e0607	t
12	3	10	YsUquvJEYe	rL++RIcE	YwOLfVjvPP	\\x2683f4607cd8cbbf130c	t
13	3	10	fRQqZLizoF	J@2C;j%	wQJYwCETaU	\\xa92d1bb34c10fb8cef3a	t
14	3	11	PMEzabYhoi	bEo(U@kH	hisMmawLEl	\\x9afa7abedbc5c360bbbd	t
15	4	12	GnIWmcQzHK	(0k	dAvHQkSFKC	\\xed9d6b7523ea0739f47f	t
16	4	12	hPcvcQCVWJ	ES^!F^I|_@	FqbAMLCnjF	\\x43b4359896e0d92b8dce	t
17	4	13	bTgWWzVmAn	jq6	mxfuJVzNrc	\\x805f04a4d8ac8d86cb57	t
18	4	14	CyhyQpaZZI	F	JJIEIYoHJb	\\x1defd303b513e2c90ed4	t
19	4	14	VDTRWBVDNN	GYN<	GvzfhcgZWt	\\x94cb18e6b66dddc1f688	t
20	4	14	LCmKzuGshC	 	CIZghqcBKt	\\xcf11d5def3a9992d8a78	t
21	6	15	AZIBpJhOsh	<nn=	TwxkLYORoO	\\xc15a23b5ef1990ac736b	t
22	6	15	sWXxkfjgfD	}OeueEr |	JKbiygkGWI	\\xbd574f3207bd7d68c12f	t
23	10	17	tyMmmbLMUr	pgH?hU	odPRBAkmka	\\xb9e159bc16cb8f714c9f	t
24	10	17	tVQzUQWBIF	CB v76Yz	JtxOSmrYjc	\\xbb51eb1f45d95a8246eb	t
25	10	18	iOsRJOraqS	kD%m=&	ipwAOHMZTA	\\x5b3c8a555faa48da9683	t
\.


--
-- Data for Name: subscription_levels; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.subscription_levels (sub_level_id, creator_id, price, title, cover, description, welcome_message) FROM stdin;
1	1	257.29	qLEdDgoBzz	\\xdd98dc130d7a4677d7ee	qUUXFFZzHM	dJcuuHtVTF
2	1	157.19	jWNunRSgOa	\\x89242be5ef997ae16565	NrogkIUIif	DGwKfwEQSZ
3	1	523.3	kaTeUdBqTd	\\xca903b3d673373d78280	UdyYHlVwri	QjLkQSzikd
4	1	685.13	KaBTdivVFV	\\x7ddaf465aaa19eaf7dbe	QgRhsAGImd	wisQLmTmQo
5	2	380.38	jtgBcDDWtY	\\x9cf16656b578346e5627	XheZdgXKLK	GaICtAfabW
6	2	881.77	CUPaTdGSAP	\\x2906050a32e98d55a885	TpMpSJAEjE	tsmoFbAjiy
7	2	143.25	lSlrTVBLsN	\\xcbf30bf13775aa7eb143	aOYvUjYUGk	LswnpVARRG
8	2	383.8	JhLrvwmMat	\\x49f5a2d23420383f1ed5	WZgiFFqlgH	btoVeDbhoC
9	2	872.34	RCPercrXhy	\\xcd96443c2d272958b2a6	AbzqKyusVL	FdNGbRdrnU
10	3	601.03	lRRacLNfkS	\\x426af4e3f7434f7c8170	nmHwBKiQdT	bZcIRShjQY
11	3	304.48	PrpTMZQGeC	\\xb0f3669aee7dc9f4b2fe	HQopHskGkW	FWirbTWfPh
12	4	311.44	ANOQVUILEv	\\x2ea44370730f25749cfc	JGQOKhZBKL	wNfBCXUcAh
13	4	744.18	NYjjZusoWu	\\x775d933c31574ec1ba74	OPuIHmEncr	crnRKzSApy
14	4	792.34	VGZMamjDhQ	\\x92046838a136ac2d4011	OyPbOPwuIP	zRuNgLSXjj
15	6	217.94	xQGJpJdcMl	\\x8a161325e2d5daba6d78	iojrKKXwbd	oPXlFhUyUK
16	10	454.88	sPLqLcAznp	\\x96c33382b752f4813d95	AWwwCJfixO	ZBgeJkPyYA
17	10	966.75	RqLZanHghc	\\x958f7cddc1fa86609e4c	XdbEsLblib	kbgRNWlyWC
18	10	320.72	njMMdMICWe	\\x97b3f7a0e9a31be5503c	JKegVSOhmd	XRORDrzQNv
\.


--
-- Data for Name: subscriptions; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.subscriptions (sub_id, user_id, sub_level_id, start_date, end_date) FROM stdin;
1	2	8	2019-08-13	2020-03-20
2	3	11	2019-09-08	2021-01-25
3	3	2	2022-05-10	2023-06-03
4	3	12	2017-10-21	2020-07-20
5	5	16	2016-02-19	2018-11-14
6	5	7	2017-11-02	2018-09-09
7	5	15	2024-04-22	2024-06-25
8	6	12	2021-01-10	2023-03-22
9	6	15	2017-03-21	2020-07-17
10	6	15	2015-07-08	2017-03-25
11	6	3	2020-04-15	2023-07-06
12	6	14	2018-12-22	2019-02-01
13	6	6	2021-11-20	2022-10-22
14	7	16	2016-02-25	2021-04-08
15	7	3	2019-03-11	2022-12-07
16	7	15	2016-07-22	2020-06-08
17	8	13	2016-10-06	2022-12-26
18	9	11	2015-11-21	2021-07-21
19	10	16	2017-07-28	2023-11-24
20	10	5	2021-03-20	2021-10-11
21	10	10	2019-07-17	2024-06-16
22	10	11	2019-02-22	2021-03-26
23	10	5	2016-05-26	2016-12-06
\.


--
-- Data for Name: tags; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.tags (tag, post_id) FROM stdin;
#music	2
#photo	2
#music	3
#video	3
#photo	3
#gif	5
#photo	5
#gif	8
#music	8
#text	8
#text	9
#video	9
#photo	9
#gif	10
#music	10
#text	10
#gif	12
#music	12
#video	12
#video	13
#photo	13
#gif	16
#photo	16
#music	17
#text	17
#video	17
#gif	22
#video	22
#photo	22
#video	23
#text	23
#photo	23
#gif	25
#video	25
#photo	25
\.


--
-- Data for Name: users; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.users (user_id, name, phone_number, email, profile_picture, password) FROM stdin;
1	lXKwHBFQwC	5822664304	adwjx@itmo.com	\\x51117f37da3445ecdc56	6e082be6de7c0bbe0297a915d593e75837fc3c2678bc21bc117bf922a53e5412
2	BfZSChqOqH	7684348321	pwjfg@itmo.com	\\x56ea526494a9d13a084b	75d835239d5d61300d37270997281ae7c2646cae6445c390ee2c8afe14448fa4
3	eJhlNMbYlq	5755250986	sfveg@itmo.com	\\xd6958ffcca43c1de873d	0f8421073e4cd473fde23569cf7e0c1a4772abe8ec8a9ac10c4ad433bd2c2633
4	PdlMknWdmZ	5097855647	pzkmt@itmo.com	\\x3f0ccdbd2918ba35760d	187a90f6edb9f53a39803ce86d120a7f7b3cba2147af167c1c5334f22b012ee6
5	jltDWGVvWZ	4845780801	lfkwu@itmo.com	\\x815e1b2f781b3e83445c	b93e5b2ac894154c90d8936aca37c529832848deaa5dbb1a7fa83c974e4f6743
6	NwGyPHMVJt	5375646612	npmvt@itmo.com	\\x181bb44fcf1cc6dec266	8583e093cad03b16a89c00e8b5cda3565f6458bdd2268331de48cbdc081d43b4
7	MXNedLWLfB	1088907378	dqmkt@itmo.com	\\xef0d222214735d8a176f	085846412a24147510cefd66295ff340e888ffa1745dfd92f965b8d77bba8dd6
8	cuKPlMvwyG	1384699373	swfgk@itmo.com	\\xe1a88e6c1d56cf2ff0b1	88d272755b5f4ecfd8fdd8fc3d13c80621ad21628d53ebfa82e40866822631b3
9	gzexOMegGn	8298410314	cumqn@itmo.com	\\x0a99c032adbda9a43a5f	97cf969125129b6763f29ca75c640d8244ed72da6d585286ae8d39e1476c2756
10	HfegWDNPUm	1762348446	bpgiu@itmo.com	\\xe7d6a4341db40ec75309	558ede9be56a22a50f49a60cc3c9b7de7a2364553637b4ddd4f0e62d3d25f305
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
1	1	2	2021-01-12 15:43:15	933.57
2	1	1	2021-07-03 13:01:49	999.21
3	1	2	2015-04-20 06:57:02	520.51
4	1	1	2024-08-14 20:34:25	440.37
5	1	2	2023-11-28 22:42:52	584.72
6	1	1	2020-06-16 07:32:13	827.85
7	1	3	2024-01-06 20:19:57	801.92
8	1	1	2017-02-17 07:25:38	758.64
9	2	2	2018-11-05 17:58:09	944.12
10	2	1	2022-06-23 04:40:16	670.62
11	3	1	2017-04-15 04:18:14	936.12
12	3	2	2024-04-03 18:07:59	122.46
13	3	3	2023-12-09 02:54:25	259.4
14	3	2	2016-10-31 21:46:14	185.14
15	3	3	2019-04-08 04:56:56	834.48
16	3	2	2020-03-26 07:17:46	282.85
17	3	2	2017-11-14 09:39:18	44.47
18	3	1	2021-01-10 19:13:44	926.33
19	3	1	2015-04-12 13:26:13	760.19
20	4	2	2021-01-03 04:12:41	752.33
21	4	2	2017-04-23 04:40:10	918.49
22	4	3	2020-07-20 19:57:21	775.11
23	4	1	2020-10-29 22:52:04	553.71
24	4	3	2023-01-28 01:18:42	682.65
25	6	1	2018-08-03 03:08:00	707.91
26	6	3	2021-09-05 06:38:49	465.64
27	6	3	2020-08-06 02:40:01	866.73
28	6	1	2017-08-31 16:56:11	134.55
29	6	1	2015-05-08 04:10:49	541.34
30	6	3	2015-10-13 20:52:33	556.14
31	6	2	2024-05-09 21:56:27	9.47
32	6	2	2024-04-30 23:00:16	290.36
33	6	1	2018-11-11 10:27:42	118.14
34	10	2	2022-11-04 20:33:14	264.99
35	10	3	2016-09-29 23:42:40	948.77
\.


--
-- Name: attachment_types_attachment_type_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.attachment_types_attachment_type_id_seq', 4, true);


--
-- Name: attachments_attachment_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.attachments_attachment_id_seq', 40, true);


--
-- Name: bank_types_bank_type_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.bank_types_bank_type_id_seq', 2, true);


--
-- Name: billings_billing_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.billings_billing_id_seq', 10, true);


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

SELECT pg_catalog.setval('public.links_link_id_seq', 27, true);


--
-- Name: posts_post_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.posts_post_id_seq', 25, true);


--
-- Name: subscription_levels_sub_level_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.subscription_levels_sub_level_id_seq', 18, true);


--
-- Name: subscriptions_sub_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.subscriptions_sub_id_seq', 23, true);


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

SELECT pg_catalog.setval('public.withdrawals_withdrawal_id_seq', 35, true);


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
-- PostgreSQL database dump complete
--

