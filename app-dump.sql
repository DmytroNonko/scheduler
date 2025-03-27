--
-- PostgreSQL database dump
--

-- Dumped from database version 16.8
-- Dumped by pg_dump version 16.8

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
-- Name: notify_messenger_messages(); Type: FUNCTION; Schema: public; Owner: app
--

CREATE FUNCTION public.notify_messenger_messages() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
            BEGIN
                PERFORM pg_notify('messenger_messages', NEW.queue_name::text);
                RETURN NEW;
            END;
        $$;


ALTER FUNCTION public.notify_messenger_messages() OWNER TO app;

SET default_tablespace = '';

SET default_table_access_method = heap;

--
-- Name: bell; Type: TABLE; Schema: public; Owner: app
--

CREATE TABLE public.bell (
    id uuid NOT NULL,
    name character varying(50) NOT NULL
);


ALTER TABLE public.bell OWNER TO app;

--
-- Name: COLUMN bell.id; Type: COMMENT; Schema: public; Owner: app
--

COMMENT ON COLUMN public.bell.id IS '(DC2Type:uuid)';


--
-- Name: curriculum; Type: TABLE; Schema: public; Owner: app
--

CREATE TABLE public.curriculum (
    id uuid NOT NULL,
    grade_id uuid,
    subject_id uuid,
    hours integer NOT NULL
);


ALTER TABLE public.curriculum OWNER TO app;

--
-- Name: COLUMN curriculum.id; Type: COMMENT; Schema: public; Owner: app
--

COMMENT ON COLUMN public.curriculum.id IS '(DC2Type:uuid)';


--
-- Name: COLUMN curriculum.grade_id; Type: COMMENT; Schema: public; Owner: app
--

COMMENT ON COLUMN public.curriculum.grade_id IS '(DC2Type:uuid)';


--
-- Name: COLUMN curriculum.subject_id; Type: COMMENT; Schema: public; Owner: app
--

COMMENT ON COLUMN public.curriculum.subject_id IS '(DC2Type:uuid)';


--
-- Name: doctrine_migration_versions; Type: TABLE; Schema: public; Owner: app
--

CREATE TABLE public.doctrine_migration_versions (
    version character varying(191) NOT NULL,
    executed_at timestamp(0) without time zone DEFAULT NULL::timestamp without time zone,
    execution_time integer
);


ALTER TABLE public.doctrine_migration_versions OWNER TO app;

--
-- Name: grade; Type: TABLE; Schema: public; Owner: app
--

CREATE TABLE public.grade (
    id uuid NOT NULL,
    name character varying(50) NOT NULL
);


ALTER TABLE public.grade OWNER TO app;

--
-- Name: COLUMN grade.id; Type: COMMENT; Schema: public; Owner: app
--

COMMENT ON COLUMN public.grade.id IS '(DC2Type:uuid)';


--
-- Name: grade_subject; Type: TABLE; Schema: public; Owner: app
--

CREATE TABLE public.grade_subject (
    grade_id uuid NOT NULL,
    subject_id uuid NOT NULL
);


ALTER TABLE public.grade_subject OWNER TO app;

--
-- Name: COLUMN grade_subject.grade_id; Type: COMMENT; Schema: public; Owner: app
--

COMMENT ON COLUMN public.grade_subject.grade_id IS '(DC2Type:uuid)';


--
-- Name: COLUMN grade_subject.subject_id; Type: COMMENT; Schema: public; Owner: app
--

COMMENT ON COLUMN public.grade_subject.subject_id IS '(DC2Type:uuid)';


--
-- Name: messenger_messages; Type: TABLE; Schema: public; Owner: app
--

CREATE TABLE public.messenger_messages (
    id bigint NOT NULL,
    body text NOT NULL,
    headers text NOT NULL,
    queue_name character varying(190) NOT NULL,
    created_at timestamp(0) without time zone NOT NULL,
    available_at timestamp(0) without time zone NOT NULL,
    delivered_at timestamp(0) without time zone DEFAULT NULL::timestamp without time zone
);


ALTER TABLE public.messenger_messages OWNER TO app;

--
-- Name: COLUMN messenger_messages.created_at; Type: COMMENT; Schema: public; Owner: app
--

COMMENT ON COLUMN public.messenger_messages.created_at IS '(DC2Type:datetime_immutable)';


--
-- Name: COLUMN messenger_messages.available_at; Type: COMMENT; Schema: public; Owner: app
--

COMMENT ON COLUMN public.messenger_messages.available_at IS '(DC2Type:datetime_immutable)';


--
-- Name: COLUMN messenger_messages.delivered_at; Type: COMMENT; Schema: public; Owner: app
--

COMMENT ON COLUMN public.messenger_messages.delivered_at IS '(DC2Type:datetime_immutable)';


--
-- Name: messenger_messages_id_seq; Type: SEQUENCE; Schema: public; Owner: app
--

CREATE SEQUENCE public.messenger_messages_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.messenger_messages_id_seq OWNER TO app;

--
-- Name: messenger_messages_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: app
--

ALTER SEQUENCE public.messenger_messages_id_seq OWNED BY public.messenger_messages.id;


--
-- Name: subject; Type: TABLE; Schema: public; Owner: app
--

CREATE TABLE public.subject (
    id uuid NOT NULL,
    teacher_id uuid,
    name character varying(50) NOT NULL
);


ALTER TABLE public.subject OWNER TO app;

--
-- Name: COLUMN subject.id; Type: COMMENT; Schema: public; Owner: app
--

COMMENT ON COLUMN public.subject.id IS '(DC2Type:uuid)';


--
-- Name: COLUMN subject.teacher_id; Type: COMMENT; Schema: public; Owner: app
--

COMMENT ON COLUMN public.subject.teacher_id IS '(DC2Type:uuid)';


--
-- Name: teacher; Type: TABLE; Schema: public; Owner: app
--

CREATE TABLE public.teacher (
    id uuid NOT NULL,
    name character varying(100) NOT NULL
);


ALTER TABLE public.teacher OWNER TO app;

--
-- Name: COLUMN teacher.id; Type: COMMENT; Schema: public; Owner: app
--

COMMENT ON COLUMN public.teacher.id IS '(DC2Type:uuid)';


--
-- Name: weekday; Type: TABLE; Schema: public; Owner: app
--

CREATE TABLE public.weekday (
    id uuid NOT NULL,
    name character varying(20) NOT NULL
);


ALTER TABLE public.weekday OWNER TO app;

--
-- Name: COLUMN weekday.id; Type: COMMENT; Schema: public; Owner: app
--

COMMENT ON COLUMN public.weekday.id IS '(DC2Type:uuid)';


--
-- Name: messenger_messages id; Type: DEFAULT; Schema: public; Owner: app
--

ALTER TABLE ONLY public.messenger_messages ALTER COLUMN id SET DEFAULT nextval('public.messenger_messages_id_seq'::regclass);


--
-- Data for Name: bell; Type: TABLE DATA; Schema: public; Owner: app
--

COPY public.bell (id, name) FROM stdin;
6423eba8-083a-4241-b481-f5dc91185036	quis
35b01703-55ab-42ca-b627-5aa3b8b5f5d2	neque
38390178-9015-4356-8220-d4cee2374e3e	dolor
f20c1852-a4e8-4052-8a0c-54113de0dd27	blanditiis
5d2782fa-dab4-49f3-8831-17f9b4283be9	vel
\.


--
-- Data for Name: curriculum; Type: TABLE DATA; Schema: public; Owner: app
--

COPY public.curriculum (id, grade_id, subject_id, hours) FROM stdin;
ddd50255-7f43-4ecf-940c-08bfe250acf3	70b1117c-dde5-4407-bd2f-56aaa75ce2df	caced07a-13ff-411f-bdbb-e66f3ef03581	12
d666e465-82e3-4941-ba6c-7d71cd7424f8	70b1117c-dde5-4407-bd2f-56aaa75ce2df	48364cc4-640b-4159-b41c-b55d0ead393a	11
e41d49dc-7a71-491d-93ca-406923bfc7c5	70b1117c-dde5-4407-bd2f-56aaa75ce2df	6567c03d-a6b6-433e-8d6a-2ccdb34f7b27	11
b69d5bac-a61e-4143-b5e8-d09e103c91d6	70b1117c-dde5-4407-bd2f-56aaa75ce2df	cccfa622-7e0a-49a2-8523-ab5f941e0517	10
d7f0446f-a5fe-404c-8222-66366535ca87	70b1117c-dde5-4407-bd2f-56aaa75ce2df	355cd7e4-ec1c-4616-a77a-abf9377fd78b	14
7753851f-6f8d-4666-a545-76689d3a6b64	87f800d5-00f3-4231-80e1-c1b3a2dc7556	caced07a-13ff-411f-bdbb-e66f3ef03581	15
6a0b6dbf-5703-4553-acbe-a4e4b157ac4b	87f800d5-00f3-4231-80e1-c1b3a2dc7556	48364cc4-640b-4159-b41c-b55d0ead393a	11
af8675a4-c5d2-499a-b5dc-4b4d7ac92791	87f800d5-00f3-4231-80e1-c1b3a2dc7556	d2e77335-a551-416f-9313-80559da3c41e	13
1bd15af0-1722-40c9-951e-cba71ae4bc3d	87f800d5-00f3-4231-80e1-c1b3a2dc7556	11e870bc-ed3f-4fb8-b3d6-ac839acfd392	13
2c022881-946f-44e7-9596-1cf093af8201	87f800d5-00f3-4231-80e1-c1b3a2dc7556	aef92550-8a10-4759-b31b-0cbe49d88926	13
0078fdf9-30b5-4554-8fed-48728aa795cc	87f800d5-00f3-4231-80e1-c1b3a2dc7556	5a5dda97-1cb7-4d2c-bd5c-751f9172b915	12
fe81e6ff-68e7-491c-b7e7-3a6a9579e776	87f800d5-00f3-4231-80e1-c1b3a2dc7556	6567c03d-a6b6-433e-8d6a-2ccdb34f7b27	14
fec71143-3352-4644-8eab-1271802f70b5	87f800d5-00f3-4231-80e1-c1b3a2dc7556	cccfa622-7e0a-49a2-8523-ab5f941e0517	13
1362f040-aa8b-47d9-babc-0b5dec72ecd8	87f800d5-00f3-4231-80e1-c1b3a2dc7556	355cd7e4-ec1c-4616-a77a-abf9377fd78b	14
78f0024a-4708-4250-b2f2-02da1c7823a5	ac061434-a6ff-469e-b251-85312f667386	a223fb14-da7a-4297-9435-3e7b7938660e	11
71ef752b-2591-424e-b803-8cc3ea324bfe	ac061434-a6ff-469e-b251-85312f667386	caced07a-13ff-411f-bdbb-e66f3ef03581	15
2c325d8d-06ef-4ad9-b8d5-4de45d7f26fd	ac061434-a6ff-469e-b251-85312f667386	48364cc4-640b-4159-b41c-b55d0ead393a	14
1667ebf3-7b19-4ef8-b69c-99960d17c4ea	ac061434-a6ff-469e-b251-85312f667386	d2e77335-a551-416f-9313-80559da3c41e	11
f899304c-758d-4b1c-87d3-9790669c3179	ac061434-a6ff-469e-b251-85312f667386	11e870bc-ed3f-4fb8-b3d6-ac839acfd392	14
22338ef0-7022-40b1-a670-e793893ee955	ac061434-a6ff-469e-b251-85312f667386	aef92550-8a10-4759-b31b-0cbe49d88926	10
b09a729a-c082-4772-a726-913e29536acf	ac061434-a6ff-469e-b251-85312f667386	5a5dda97-1cb7-4d2c-bd5c-751f9172b915	15
4ce8acb4-c17c-4775-bced-c14d834a2d21	ac061434-a6ff-469e-b251-85312f667386	6567c03d-a6b6-433e-8d6a-2ccdb34f7b27	13
f08eaa58-45f1-4391-b80c-a6a6d3cbc188	ac061434-a6ff-469e-b251-85312f667386	cccfa622-7e0a-49a2-8523-ab5f941e0517	10
bb7da600-4fea-4611-9f00-05a39e596364	ac061434-a6ff-469e-b251-85312f667386	355cd7e4-ec1c-4616-a77a-abf9377fd78b	10
4440e133-c2be-427f-9005-8cd4915c06a0	b8ef4364-f9e5-4a9c-b9f4-6d2628cde9b5	caced07a-13ff-411f-bdbb-e66f3ef03581	13
da9d47ec-5a45-4d65-a84e-782dd22baeb8	b8ef4364-f9e5-4a9c-b9f4-6d2628cde9b5	d2e77335-a551-416f-9313-80559da3c41e	11
39a97c75-1595-44e5-97cd-79aa6aeaafa0	b8ef4364-f9e5-4a9c-b9f4-6d2628cde9b5	11e870bc-ed3f-4fb8-b3d6-ac839acfd392	10
0064172e-e4c9-490f-bc2a-a5c726fc3291	b8ef4364-f9e5-4a9c-b9f4-6d2628cde9b5	aef92550-8a10-4759-b31b-0cbe49d88926	10
c41ff4f1-dcbb-4188-8bf9-a5c4b20c4d1e	b8ef4364-f9e5-4a9c-b9f4-6d2628cde9b5	6567c03d-a6b6-433e-8d6a-2ccdb34f7b27	13
3b993603-9f99-47bd-9cc3-7a7a2a79eec5	b741490b-ab45-402e-acc4-5f5367c7e0a9	a223fb14-da7a-4297-9435-3e7b7938660e	12
4bb4d307-7f25-40f6-b02b-c1b5c2941119	b741490b-ab45-402e-acc4-5f5367c7e0a9	caced07a-13ff-411f-bdbb-e66f3ef03581	15
b4cac9cf-3cd3-4496-b728-3d304bbde8f3	b741490b-ab45-402e-acc4-5f5367c7e0a9	48364cc4-640b-4159-b41c-b55d0ead393a	14
3b29aec9-ad10-43b6-8626-d93f9db7eb8d	b741490b-ab45-402e-acc4-5f5367c7e0a9	d2e77335-a551-416f-9313-80559da3c41e	11
2e7dc907-d0ac-44c2-b499-fa4115aa6b98	b741490b-ab45-402e-acc4-5f5367c7e0a9	11e870bc-ed3f-4fb8-b3d6-ac839acfd392	11
533d30cb-3990-4a72-9d38-cf1db09e61c3	b741490b-ab45-402e-acc4-5f5367c7e0a9	aef92550-8a10-4759-b31b-0cbe49d88926	15
9d25087a-41da-4f9b-a603-a87ea62ce4d6	b741490b-ab45-402e-acc4-5f5367c7e0a9	5a5dda97-1cb7-4d2c-bd5c-751f9172b915	12
5e0687a5-9353-4321-950d-351afe18502d	b741490b-ab45-402e-acc4-5f5367c7e0a9	6567c03d-a6b6-433e-8d6a-2ccdb34f7b27	11
eba0777e-3e04-4b11-9667-7e3ffc62e127	b741490b-ab45-402e-acc4-5f5367c7e0a9	cccfa622-7e0a-49a2-8523-ab5f941e0517	15
ce9937e0-b595-4b0b-bb28-a2ecb96473cb	b741490b-ab45-402e-acc4-5f5367c7e0a9	355cd7e4-ec1c-4616-a77a-abf9377fd78b	11
\.


--
-- Data for Name: doctrine_migration_versions; Type: TABLE DATA; Schema: public; Owner: app
--

COPY public.doctrine_migration_versions (version, executed_at, execution_time) FROM stdin;
DoctrineMigrations\\Version20250327012636	2025-03-27 01:27:16	22
\.


--
-- Data for Name: grade; Type: TABLE DATA; Schema: public; Owner: app
--

COPY public.grade (id, name) FROM stdin;
70b1117c-dde5-4407-bd2f-56aaa75ce2df	9-a
87f800d5-00f3-4231-80e1-c1b3a2dc7556	6-v
ac061434-a6ff-469e-b251-85312f667386	4-l
b8ef4364-f9e5-4a9c-b9f4-6d2628cde9b5	1-x
b741490b-ab45-402e-acc4-5f5367c7e0a9	5-o
\.


--
-- Data for Name: grade_subject; Type: TABLE DATA; Schema: public; Owner: app
--

COPY public.grade_subject (grade_id, subject_id) FROM stdin;
70b1117c-dde5-4407-bd2f-56aaa75ce2df	caced07a-13ff-411f-bdbb-e66f3ef03581
70b1117c-dde5-4407-bd2f-56aaa75ce2df	48364cc4-640b-4159-b41c-b55d0ead393a
70b1117c-dde5-4407-bd2f-56aaa75ce2df	6567c03d-a6b6-433e-8d6a-2ccdb34f7b27
70b1117c-dde5-4407-bd2f-56aaa75ce2df	cccfa622-7e0a-49a2-8523-ab5f941e0517
70b1117c-dde5-4407-bd2f-56aaa75ce2df	355cd7e4-ec1c-4616-a77a-abf9377fd78b
87f800d5-00f3-4231-80e1-c1b3a2dc7556	caced07a-13ff-411f-bdbb-e66f3ef03581
87f800d5-00f3-4231-80e1-c1b3a2dc7556	48364cc4-640b-4159-b41c-b55d0ead393a
87f800d5-00f3-4231-80e1-c1b3a2dc7556	d2e77335-a551-416f-9313-80559da3c41e
87f800d5-00f3-4231-80e1-c1b3a2dc7556	11e870bc-ed3f-4fb8-b3d6-ac839acfd392
87f800d5-00f3-4231-80e1-c1b3a2dc7556	aef92550-8a10-4759-b31b-0cbe49d88926
87f800d5-00f3-4231-80e1-c1b3a2dc7556	5a5dda97-1cb7-4d2c-bd5c-751f9172b915
87f800d5-00f3-4231-80e1-c1b3a2dc7556	6567c03d-a6b6-433e-8d6a-2ccdb34f7b27
87f800d5-00f3-4231-80e1-c1b3a2dc7556	cccfa622-7e0a-49a2-8523-ab5f941e0517
87f800d5-00f3-4231-80e1-c1b3a2dc7556	355cd7e4-ec1c-4616-a77a-abf9377fd78b
ac061434-a6ff-469e-b251-85312f667386	a223fb14-da7a-4297-9435-3e7b7938660e
ac061434-a6ff-469e-b251-85312f667386	caced07a-13ff-411f-bdbb-e66f3ef03581
ac061434-a6ff-469e-b251-85312f667386	48364cc4-640b-4159-b41c-b55d0ead393a
ac061434-a6ff-469e-b251-85312f667386	d2e77335-a551-416f-9313-80559da3c41e
ac061434-a6ff-469e-b251-85312f667386	11e870bc-ed3f-4fb8-b3d6-ac839acfd392
ac061434-a6ff-469e-b251-85312f667386	aef92550-8a10-4759-b31b-0cbe49d88926
ac061434-a6ff-469e-b251-85312f667386	5a5dda97-1cb7-4d2c-bd5c-751f9172b915
ac061434-a6ff-469e-b251-85312f667386	6567c03d-a6b6-433e-8d6a-2ccdb34f7b27
ac061434-a6ff-469e-b251-85312f667386	cccfa622-7e0a-49a2-8523-ab5f941e0517
ac061434-a6ff-469e-b251-85312f667386	355cd7e4-ec1c-4616-a77a-abf9377fd78b
b8ef4364-f9e5-4a9c-b9f4-6d2628cde9b5	caced07a-13ff-411f-bdbb-e66f3ef03581
b8ef4364-f9e5-4a9c-b9f4-6d2628cde9b5	d2e77335-a551-416f-9313-80559da3c41e
b8ef4364-f9e5-4a9c-b9f4-6d2628cde9b5	11e870bc-ed3f-4fb8-b3d6-ac839acfd392
b8ef4364-f9e5-4a9c-b9f4-6d2628cde9b5	aef92550-8a10-4759-b31b-0cbe49d88926
b8ef4364-f9e5-4a9c-b9f4-6d2628cde9b5	6567c03d-a6b6-433e-8d6a-2ccdb34f7b27
b741490b-ab45-402e-acc4-5f5367c7e0a9	a223fb14-da7a-4297-9435-3e7b7938660e
b741490b-ab45-402e-acc4-5f5367c7e0a9	caced07a-13ff-411f-bdbb-e66f3ef03581
b741490b-ab45-402e-acc4-5f5367c7e0a9	48364cc4-640b-4159-b41c-b55d0ead393a
b741490b-ab45-402e-acc4-5f5367c7e0a9	d2e77335-a551-416f-9313-80559da3c41e
b741490b-ab45-402e-acc4-5f5367c7e0a9	11e870bc-ed3f-4fb8-b3d6-ac839acfd392
b741490b-ab45-402e-acc4-5f5367c7e0a9	aef92550-8a10-4759-b31b-0cbe49d88926
b741490b-ab45-402e-acc4-5f5367c7e0a9	5a5dda97-1cb7-4d2c-bd5c-751f9172b915
b741490b-ab45-402e-acc4-5f5367c7e0a9	6567c03d-a6b6-433e-8d6a-2ccdb34f7b27
b741490b-ab45-402e-acc4-5f5367c7e0a9	cccfa622-7e0a-49a2-8523-ab5f941e0517
b741490b-ab45-402e-acc4-5f5367c7e0a9	355cd7e4-ec1c-4616-a77a-abf9377fd78b
\.


--
-- Data for Name: messenger_messages; Type: TABLE DATA; Schema: public; Owner: app
--

COPY public.messenger_messages (id, body, headers, queue_name, created_at, available_at, delivered_at) FROM stdin;
\.


--
-- Data for Name: subject; Type: TABLE DATA; Schema: public; Owner: app
--

COPY public.subject (id, teacher_id, name) FROM stdin;
a223fb14-da7a-4297-9435-3e7b7938660e	2ece0fef-4502-4391-b190-18d965adf301	earum
caced07a-13ff-411f-bdbb-e66f3ef03581	4f3ae250-9f1b-48cd-82cc-281fa55a2147	ex
48364cc4-640b-4159-b41c-b55d0ead393a	50f7732c-007b-4b35-a096-015ebdc51dbb	earum
d2e77335-a551-416f-9313-80559da3c41e	1f8b2fba-391b-4443-8d15-84524c7f9d33	qui
11e870bc-ed3f-4fb8-b3d6-ac839acfd392	543599ac-a232-448d-aa8a-423f42bf0038	at
aef92550-8a10-4759-b31b-0cbe49d88926	4d8d43f1-306a-4d97-8b7e-cced78c0b5c2	aut
5a5dda97-1cb7-4d2c-bd5c-751f9172b915	1c852a1c-95db-4bea-90b6-7508d65a94c7	et
6567c03d-a6b6-433e-8d6a-2ccdb34f7b27	1f6bb713-b453-4128-a6ab-b20d6b7f7ea9	veritatis
cccfa622-7e0a-49a2-8523-ab5f941e0517	ecab8285-c084-4c3d-a092-216cce80456a	voluptatem
355cd7e4-ec1c-4616-a77a-abf9377fd78b	9c9c744e-0c88-43ef-834c-94dad1d4b43d	illo
\.


--
-- Data for Name: teacher; Type: TABLE DATA; Schema: public; Owner: app
--

COPY public.teacher (id, name) FROM stdin;
2ece0fef-4502-4391-b190-18d965adf301	Arden Dietrich
4f3ae250-9f1b-48cd-82cc-281fa55a2147	Michaela Koch I
50f7732c-007b-4b35-a096-015ebdc51dbb	Sally Sporer
1f8b2fba-391b-4443-8d15-84524c7f9d33	Aron Lebsack II
543599ac-a232-448d-aa8a-423f42bf0038	Rosemarie Kassulke
4d8d43f1-306a-4d97-8b7e-cced78c0b5c2	Velda Weissnat Jr.
1c852a1c-95db-4bea-90b6-7508d65a94c7	Antonette Terry
1f6bb713-b453-4128-a6ab-b20d6b7f7ea9	Riley Dickinson
ecab8285-c084-4c3d-a092-216cce80456a	Raoul Labadie IV
9c9c744e-0c88-43ef-834c-94dad1d4b43d	Emmett Skiles III
\.


--
-- Data for Name: weekday; Type: TABLE DATA; Schema: public; Owner: app
--

COPY public.weekday (id, name) FROM stdin;
e4d8f2a4-bd39-46b3-b97d-4dfb6e757165	Monday
69d50831-ac24-427a-8127-b53855914683	Tuesday
e48ff01d-da45-4803-8527-a25080b2cb7b	Wednesday
68b43e1f-8ff6-456d-a70c-43eb62a43d8f	Thursday
33ffe992-6245-4ed4-823a-386567685279	Friday
\.


--
-- Name: messenger_messages_id_seq; Type: SEQUENCE SET; Schema: public; Owner: app
--

SELECT pg_catalog.setval('public.messenger_messages_id_seq', 1, false);


--
-- Name: bell bell_pkey; Type: CONSTRAINT; Schema: public; Owner: app
--

ALTER TABLE ONLY public.bell
    ADD CONSTRAINT bell_pkey PRIMARY KEY (id);


--
-- Name: curriculum curriculum_pkey; Type: CONSTRAINT; Schema: public; Owner: app
--

ALTER TABLE ONLY public.curriculum
    ADD CONSTRAINT curriculum_pkey PRIMARY KEY (id);


--
-- Name: doctrine_migration_versions doctrine_migration_versions_pkey; Type: CONSTRAINT; Schema: public; Owner: app
--

ALTER TABLE ONLY public.doctrine_migration_versions
    ADD CONSTRAINT doctrine_migration_versions_pkey PRIMARY KEY (version);


--
-- Name: grade grade_pkey; Type: CONSTRAINT; Schema: public; Owner: app
--

ALTER TABLE ONLY public.grade
    ADD CONSTRAINT grade_pkey PRIMARY KEY (id);


--
-- Name: grade_subject grade_subject_pkey; Type: CONSTRAINT; Schema: public; Owner: app
--

ALTER TABLE ONLY public.grade_subject
    ADD CONSTRAINT grade_subject_pkey PRIMARY KEY (grade_id, subject_id);


--
-- Name: messenger_messages messenger_messages_pkey; Type: CONSTRAINT; Schema: public; Owner: app
--

ALTER TABLE ONLY public.messenger_messages
    ADD CONSTRAINT messenger_messages_pkey PRIMARY KEY (id);


--
-- Name: subject subject_pkey; Type: CONSTRAINT; Schema: public; Owner: app
--

ALTER TABLE ONLY public.subject
    ADD CONSTRAINT subject_pkey PRIMARY KEY (id);


--
-- Name: teacher teacher_pkey; Type: CONSTRAINT; Schema: public; Owner: app
--

ALTER TABLE ONLY public.teacher
    ADD CONSTRAINT teacher_pkey PRIMARY KEY (id);


--
-- Name: weekday weekday_pkey; Type: CONSTRAINT; Schema: public; Owner: app
--

ALTER TABLE ONLY public.weekday
    ADD CONSTRAINT weekday_pkey PRIMARY KEY (id);


--
-- Name: idx_183ac9823edc87; Type: INDEX; Schema: public; Owner: app
--

CREATE INDEX idx_183ac9823edc87 ON public.grade_subject USING btree (subject_id);


--
-- Name: idx_183ac98fe19a1a8; Type: INDEX; Schema: public; Owner: app
--

CREATE INDEX idx_183ac98fe19a1a8 ON public.grade_subject USING btree (grade_id);


--
-- Name: idx_75ea56e016ba31db; Type: INDEX; Schema: public; Owner: app
--

CREATE INDEX idx_75ea56e016ba31db ON public.messenger_messages USING btree (delivered_at);


--
-- Name: idx_75ea56e0e3bd61ce; Type: INDEX; Schema: public; Owner: app
--

CREATE INDEX idx_75ea56e0e3bd61ce ON public.messenger_messages USING btree (available_at);


--
-- Name: idx_75ea56e0fb7336f0; Type: INDEX; Schema: public; Owner: app
--

CREATE INDEX idx_75ea56e0fb7336f0 ON public.messenger_messages USING btree (queue_name);


--
-- Name: idx_7be2a7c323edc87; Type: INDEX; Schema: public; Owner: app
--

CREATE INDEX idx_7be2a7c323edc87 ON public.curriculum USING btree (subject_id);


--
-- Name: idx_7be2a7c3fe19a1a8; Type: INDEX; Schema: public; Owner: app
--

CREATE INDEX idx_7be2a7c3fe19a1a8 ON public.curriculum USING btree (grade_id);


--
-- Name: uniq_fbce3e7a41807e1d; Type: INDEX; Schema: public; Owner: app
--

CREATE UNIQUE INDEX uniq_fbce3e7a41807e1d ON public.subject USING btree (teacher_id);


--
-- Name: messenger_messages notify_trigger; Type: TRIGGER; Schema: public; Owner: app
--

CREATE TRIGGER notify_trigger AFTER INSERT OR UPDATE ON public.messenger_messages FOR EACH ROW EXECUTE FUNCTION public.notify_messenger_messages();


--
-- Name: grade_subject fk_183ac9823edc87; Type: FK CONSTRAINT; Schema: public; Owner: app
--

ALTER TABLE ONLY public.grade_subject
    ADD CONSTRAINT fk_183ac9823edc87 FOREIGN KEY (subject_id) REFERENCES public.subject(id) ON DELETE CASCADE;


--
-- Name: grade_subject fk_183ac98fe19a1a8; Type: FK CONSTRAINT; Schema: public; Owner: app
--

ALTER TABLE ONLY public.grade_subject
    ADD CONSTRAINT fk_183ac98fe19a1a8 FOREIGN KEY (grade_id) REFERENCES public.grade(id) ON DELETE CASCADE;


--
-- Name: curriculum fk_7be2a7c323edc87; Type: FK CONSTRAINT; Schema: public; Owner: app
--

ALTER TABLE ONLY public.curriculum
    ADD CONSTRAINT fk_7be2a7c323edc87 FOREIGN KEY (subject_id) REFERENCES public.subject(id);


--
-- Name: curriculum fk_7be2a7c3fe19a1a8; Type: FK CONSTRAINT; Schema: public; Owner: app
--

ALTER TABLE ONLY public.curriculum
    ADD CONSTRAINT fk_7be2a7c3fe19a1a8 FOREIGN KEY (grade_id) REFERENCES public.grade(id);


--
-- Name: subject fk_fbce3e7a41807e1d; Type: FK CONSTRAINT; Schema: public; Owner: app
--

ALTER TABLE ONLY public.subject
    ADD CONSTRAINT fk_fbce3e7a41807e1d FOREIGN KEY (teacher_id) REFERENCES public.teacher(id);


--
-- PostgreSQL database dump complete
--

