--
-- PostgreSQL database dump
--

-- Dumped from database version 16.2 (Debian 16.2-1.pgdg120+2)
-- Dumped by pg_dump version 16.2 (Debian 16.2-1.pgdg120+2)

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
-- Name: cuidado; Type: TABLE; Schema: public; Owner: admin
--

CREATE TABLE public.cuidado (
    cuidado_id bigint NOT NULL,
    descripcion character varying(4096),
    isactive boolean NOT NULL,
    posicion integer,
    titulo character varying(255)
);


ALTER TABLE public.cuidado OWNER TO admin;

--
-- Name: cuidado_cuidado_id_seq; Type: SEQUENCE; Schema: public; Owner: admin
--

CREATE SEQUENCE public.cuidado_cuidado_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.cuidado_cuidado_id_seq OWNER TO admin;

--
-- Name: cuidado_cuidado_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: admin
--

ALTER SEQUENCE public.cuidado_cuidado_id_seq OWNED BY public.cuidado.cuidado_id;


--
-- Name: instructive; Type: TABLE; Schema: public; Owner: admin
--

CREATE TABLE public.instructive (
    instructive_id bigint NOT NULL,
    description character varying(4096),
    is_active boolean NOT NULL,
    "position" integer,
    title character varying(255)
);


ALTER TABLE public.instructive OWNER TO admin;

--
-- Name: instructive_instructive_id_seq; Type: SEQUENCE; Schema: public; Owner: admin
--

CREATE SEQUENCE public.instructive_instructive_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.instructive_instructive_id_seq OWNER TO admin;

--
-- Name: instructive_instructive_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: admin
--

ALTER SEQUENCE public.instructive_instructive_id_seq OWNED BY public.instructive.instructive_id;


--
-- Name: rol; Type: TABLE; Schema: public; Owner: admin
--

CREATE TABLE public.rol (
    rol_id bigint NOT NULL,
    nombre character varying(255)
);


ALTER TABLE public.rol OWNER TO admin;

--
-- Name: role_role_id_seq; Type: SEQUENCE; Schema: public; Owner: admin
--

CREATE SEQUENCE public.role_role_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.role_role_id_seq OWNER TO admin;

--
-- Name: role_role_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: admin
--

ALTER SEQUENCE public.role_role_id_seq OWNED BY public.rol.rol_id;


--
-- Name: user_rol; Type: TABLE; Schema: public; Owner: admin
--

CREATE TABLE public.user_rol (
    usuario_id bigint NOT NULL,
    rol_id bigint NOT NULL
);


ALTER TABLE public.user_rol OWNER TO admin;

--
-- Name: usuario; Type: TABLE; Schema: public; Owner: admin
--

CREATE TABLE public.usuario (
    usuario_id bigint NOT NULL,
    username character varying(255),
    password character varying(255),
    email character varying(255),
    fnac date
);


ALTER TABLE public.usuario OWNER TO admin;

--
-- Name: usuario_usuario_id_seq; Type: SEQUENCE; Schema: public; Owner: admin
--

CREATE SEQUENCE public.usuario_usuario_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.usuario_usuario_id_seq OWNER TO admin;

--
-- Name: usuario_usuario_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: admin
--

ALTER SEQUENCE public.usuario_usuario_id_seq OWNED BY public.usuario.usuario_id;


--
-- Name: cuidado cuidado_id; Type: DEFAULT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.cuidado ALTER COLUMN cuidado_id SET DEFAULT nextval('public.cuidado_cuidado_id_seq'::regclass);


--
-- Name: instructive instructive_id; Type: DEFAULT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.instructive ALTER COLUMN instructive_id SET DEFAULT nextval('public.instructive_instructive_id_seq'::regclass);


--
-- Name: rol rol_id; Type: DEFAULT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.rol ALTER COLUMN rol_id SET DEFAULT nextval('public.role_role_id_seq'::regclass);


--
-- Name: usuario usuario_id; Type: DEFAULT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.usuario ALTER COLUMN usuario_id SET DEFAULT nextval('public.usuario_usuario_id_seq'::regclass);


--
-- Data for Name: cuidado; Type: TABLE DATA; Schema: public; Owner: admin
--

COPY public.cuidado (cuidado_id, descripcion, isactive, posicion, titulo) FROM stdin;
1	test desde insomnia	t	77	cuidado insomnia
2	test desde insomnia 2	t	17	cuidado insomnia 2
3	test description	t	50	cuidado X
4	test description	t	28	Cuidado Y
5	test description	t	593	Cuidado con aure
6	test description	t	906	Cuidado con Lauti
7	test description	t	304	Cuidado Z
8	test description	t	570	TEST
9	XD	t	783	CUIDAOOO
10	test description	t	255	XD
11	Che que pasa si la descripcion es bastante larga? de hecho como deberia ser porque las descripciones estan pensadas para ser bastante largas porque son cuidados para los pacientes	t	388	Che que pasa si pongo un titulo exageradamente largo?
12	AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA	t	816	Buenisimo
\.


--
-- Data for Name: instructive; Type: TABLE DATA; Schema: public; Owner: admin
--

COPY public.instructive (instructive_id, description, is_active, "position", title) FROM stdin;
1	descripcion del instructivo 1	t	1	instructivo 1
\.


--
-- Data for Name: rol; Type: TABLE DATA; Schema: public; Owner: admin
--

COPY public.rol (rol_id, nombre) FROM stdin;
3	PACIENTE
2	DEFAULT
1	ADMIN
\.


--
-- Data for Name: user_rol; Type: TABLE DATA; Schema: public; Owner: admin
--

COPY public.user_rol (usuario_id, rol_id) FROM stdin;
2	2
1	3
3	3
5	3
\.


--
-- Data for Name: usuario; Type: TABLE DATA; Schema: public; Owner: admin
--

COPY public.usuario (usuario_id, username, password, email, fnac) FROM stdin;
3	paciente	$2a$10$HZeUo2TjNkEAQGCYmpYUwey7v45q0GEAjNWSHutT.C5LiK4dOD/FK	paciente@gmail.com	1999-05-18
2	user	$2a$10$OGNFRLqpy1.bmPWQCSXtH.uTgniemXKxLvoTTI4PE3gg5Gn.gYpMS	user@gmail.com	1997-09-11
1	admin	$2a$10$L0rqEM2ATQL7gA2g175dSeHHO454iDncyqMhOy4h8u.x/vCAi7bsu	admin@gmail.com	1998-04-08
5	test	$2a$10$kSjxEaiV6rH2amZCQ/3Z6uK0xVPAq5D9qYJvT/YyMVm019t8tafQa	test@test.com	2024-07-25
\.


--
-- Name: cuidado_cuidado_id_seq; Type: SEQUENCE SET; Schema: public; Owner: admin
--

SELECT pg_catalog.setval('public.cuidado_cuidado_id_seq', 12, true);


--
-- Name: instructive_instructive_id_seq; Type: SEQUENCE SET; Schema: public; Owner: admin
--

SELECT pg_catalog.setval('public.instructive_instructive_id_seq', 1, true);


--
-- Name: role_role_id_seq; Type: SEQUENCE SET; Schema: public; Owner: admin
--

SELECT pg_catalog.setval('public.role_role_id_seq', 3, true);


--
-- Name: usuario_usuario_id_seq; Type: SEQUENCE SET; Schema: public; Owner: admin
--

SELECT pg_catalog.setval('public.usuario_usuario_id_seq', 5, true);


--
-- Name: cuidado cuidado_pkey; Type: CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.cuidado
    ADD CONSTRAINT cuidado_pkey PRIMARY KEY (cuidado_id);


--
-- Name: instructive instructive_pkey; Type: CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.instructive
    ADD CONSTRAINT instructive_pkey PRIMARY KEY (instructive_id);


--
-- Name: rol role_pkey; Type: CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.rol
    ADD CONSTRAINT role_pkey PRIMARY KEY (rol_id);


--
-- Name: usuario usuario_pkey; Type: CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.usuario
    ADD CONSTRAINT usuario_pkey PRIMARY KEY (usuario_id);


--
-- Name: user_rol user_rol_rol_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.user_rol
    ADD CONSTRAINT user_rol_rol_id_fkey FOREIGN KEY (rol_id) REFERENCES public.rol(rol_id);


--
-- Name: user_rol user_rol_usuario_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.user_rol
    ADD CONSTRAINT user_rol_usuario_id_fkey FOREIGN KEY (usuario_id) REFERENCES public.usuario(usuario_id);


--
-- PostgreSQL database dump complete
--

