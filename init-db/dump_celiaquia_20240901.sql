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
-- Name: cuestionario; Type: TABLE; Schema: public; Owner: admin
--

CREATE TABLE public.cuestionario (
    cuestionario_id bigint NOT NULL,
    created timestamp(6) without time zone,
    createdby bigint,
    isactive boolean NOT NULL,
    updated timestamp(6) without time zone,
    updatedby bigint,
    posicion integer,
    pregunta character varying(255)
);


ALTER TABLE public.cuestionario OWNER TO admin;

--
-- Name: cuestionario_cuestionario_id_seq; Type: SEQUENCE; Schema: public; Owner: admin
--

CREATE SEQUENCE public.cuestionario_cuestionario_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.cuestionario_cuestionario_id_seq OWNER TO admin;

--
-- Name: cuestionario_cuestionario_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: admin
--

ALTER SEQUENCE public.cuestionario_cuestionario_id_seq OWNED BY public.cuestionario.cuestionario_id;


--
-- Name: cuidado_posicion_seq; Type: SEQUENCE; Schema: public; Owner: admin
--

CREATE SEQUENCE public.cuidado_posicion_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.cuidado_posicion_seq OWNER TO admin;

--
-- Name: cuidado; Type: TABLE; Schema: public; Owner: admin
--

CREATE TABLE public.cuidado (
    cuidado_id bigint NOT NULL,
    created timestamp(6) without time zone,
    createdby bigint,
    isactive boolean NOT NULL,
    updated timestamp(6) without time zone,
    updatedby bigint,
    descripcion character varying(4096),
    posicion integer DEFAULT nextval('public.cuidado_posicion_seq'::regclass),
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
-- Name: opcion; Type: TABLE; Schema: public; Owner: admin
--

CREATE TABLE public.opcion (
    opcion_id bigint NOT NULL,
    created timestamp(6) without time zone,
    createdby bigint,
    isactive boolean NOT NULL,
    updated timestamp(6) without time zone,
    updatedby bigint,
    opcion character varying(255),
    cuestionario_id bigint
);


ALTER TABLE public.opcion OWNER TO admin;

--
-- Name: opcion_opcion_id_seq; Type: SEQUENCE; Schema: public; Owner: admin
--

CREATE SEQUENCE public.opcion_opcion_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.opcion_opcion_id_seq OWNER TO admin;

--
-- Name: opcion_opcion_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: admin
--

ALTER SEQUENCE public.opcion_opcion_id_seq OWNED BY public.opcion.opcion_id;


--
-- Name: respuesta; Type: TABLE; Schema: public; Owner: admin
--

CREATE TABLE public.respuesta (
    respuesta_id bigint NOT NULL,
    created timestamp(6) without time zone,
    createdby bigint,
    isactive boolean NOT NULL,
    updated timestamp(6) without time zone,
    updatedby bigint,
    opcion_id bigint NOT NULL,
    usuario_id bigint NOT NULL
);


ALTER TABLE public.respuesta OWNER TO admin;

--
-- Name: respuesta_respuesta_id_seq; Type: SEQUENCE; Schema: public; Owner: admin
--

CREATE SEQUENCE public.respuesta_respuesta_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.respuesta_respuesta_id_seq OWNER TO admin;

--
-- Name: respuesta_respuesta_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: admin
--

ALTER SEQUENCE public.respuesta_respuesta_id_seq OWNED BY public.respuesta.respuesta_id;


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
    fnac date,
    apellido character varying(255),
    dni character varying(255),
    nombre character varying(255)
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
-- Name: cuestionario cuestionario_id; Type: DEFAULT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.cuestionario ALTER COLUMN cuestionario_id SET DEFAULT nextval('public.cuestionario_cuestionario_id_seq'::regclass);


--
-- Name: cuidado cuidado_id; Type: DEFAULT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.cuidado ALTER COLUMN cuidado_id SET DEFAULT nextval('public.cuidado_cuidado_id_seq'::regclass);


--
-- Name: opcion opcion_id; Type: DEFAULT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.opcion ALTER COLUMN opcion_id SET DEFAULT nextval('public.opcion_opcion_id_seq'::regclass);


--
-- Name: respuesta respuesta_id; Type: DEFAULT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.respuesta ALTER COLUMN respuesta_id SET DEFAULT nextval('public.respuesta_respuesta_id_seq'::regclass);


--
-- Name: rol rol_id; Type: DEFAULT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.rol ALTER COLUMN rol_id SET DEFAULT nextval('public.role_role_id_seq'::regclass);


--
-- Name: usuario usuario_id; Type: DEFAULT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.usuario ALTER COLUMN usuario_id SET DEFAULT nextval('public.usuario_usuario_id_seq'::regclass);


--
-- Data for Name: cuestionario; Type: TABLE DATA; Schema: public; Owner: admin
--

COPY public.cuestionario (cuestionario_id, created, createdby, isactive, updated, updatedby, posicion, pregunta) FROM stdin;
1	\N	\N	t	\N	\N	1	Hace cuanto tiempo te diagnosticaron celiaquia?
2	\N	\N	t	\N	\N	2	Con qué frecuencia seguis una dieta libre de gluten?
3	\N	\N	t	\N	\N	3	Te resulta difícil encontrar alimentos sin tacc?
4	\N	\N	t	\N	\N	4	Lees las etiquetas de los alimentos para comprobar si contienen gluten?
5	\N	\N	t	\N	\N	5	Qué tan seguido comes fuera de casa (restaurantes, eventos, etc.)?
6	\N	\N	t	\N	\N	6	Conoces los efectos de no llevar adecuadamente una dieta sin tacc?
7	\N	\N	t	\N	\N	7	Qué tanto confías en los menús sin gluten de los restaurantes?
8	\N	\N	t	\N	\N	8	Sabes lo que es la contaminacion cruzada?
9	\N	\N	t	\N	\N	9	Qué factor consideras más desafiante al seguir una dieta sin tacc?
\.


--
-- Data for Name: cuidado; Type: TABLE DATA; Schema: public; Owner: admin
--

COPY public.cuidado (cuidado_id, created, createdby, isactive, updated, updatedby, descripcion, posicion, titulo) FROM stdin;
4	\N	\N	t	2024-08-25 14:30:49.077784	2	cuarto	3	cuarto
3	\N	\N	t	2024-08-25 14:30:49.07942	2	tercero	4	tercero
6	2024-08-26 19:05:54.203647	2	t	2024-08-26 19:05:54.203647	2	testeando posiciones	5	cuidado create
7	2024-08-26 19:06:26.198948	2	t	2024-08-26 19:06:26.198948	2	testeando posiciones	6	cuidado create
5	2024-08-26 18:14:42.586822	2	t	2024-08-26 18:14:42.586822	2	test desde insomnia 2	7	cuidado insomnia 2
8	2024-08-26 19:06:50.797604	2	f	2024-08-26 19:18:57.884683	2	testeando posiciones	8	cuidado create
2	\N	\N	t	\N	\N	segundo	2	segundo
1	\N	\N	t	\N	\N	primero	1	primero
\.


--
-- Data for Name: opcion; Type: TABLE DATA; Schema: public; Owner: admin
--

COPY public.opcion (opcion_id, created, createdby, isactive, updated, updatedby, opcion, cuestionario_id) FROM stdin;
1	\N	\N	t	\N	\N	Menos de 1 año	1
2	\N	\N	t	\N	\N	1 a 3 años	1
3	\N	\N	t	\N	\N	4 a 6 años	1
4	\N	\N	t	\N	\N	Más de 6 años	1
5	\N	\N	t	\N	\N	Siempre	2
6	\N	\N	t	\N	\N	La mayoría de las veces	2
7	\N	\N	t	\N	\N	A veces	2
8	\N	\N	t	\N	\N	Rara vez o nunca	2
9	\N	\N	t	\N	\N	Nunca	3
10	\N	\N	t	\N	\N	Rara vez	3
11	\N	\N	t	\N	\N	A menudo	3
12	\N	\N	t	\N	\N	Siempre	3
13	\N	\N	t	\N	\N	Siempre	4
14	\N	\N	t	\N	\N	A veces	4
15	\N	\N	t	\N	\N	Rara vez	4
16	\N	\N	t	\N	\N	Nunca	4
17	\N	\N	t	\N	\N	Más de 5 veces por semana	5
18	\N	\N	t	\N	\N	3-4 veces por semana	5
19	\N	\N	t	\N	\N	1-2 veces por semana	5
20	\N	\N	t	\N	\N	Menos de una vez por semana	5
21	\N	\N	t	\N	\N	Si	6
22	\N	\N	t	\N	\N	Mas o menos	6
23	\N	\N	t	\N	\N	No	6
24	\N	\N	t	\N	\N	Confío completamente	7
25	\N	\N	t	\N	\N	Confío con algunas dudas	7
26	\N	\N	t	\N	\N	Desconfío en la mayoría de los casos	7
27	\N	\N	t	\N	\N	No confío en absoluto	7
28	\N	\N	t	\N	\N	Si	8
29	\N	\N	t	\N	\N	No	8
30	\N	\N	t	\N	\N	Precio de los productos sin tacc	9
31	\N	\N	t	\N	\N	Disponibilidad de productos sin tacc	9
32	\N	\N	t	\N	\N	Sabor de los alimentos sin tacc	9
33	\N	\N	t	\N	\N	Contaminacion cruzada	9
34	\N	\N	t	\N	\N	Falta de opciones al comer fuera de casa	9
\.


--
-- Data for Name: respuesta; Type: TABLE DATA; Schema: public; Owner: admin
--

COPY public.respuesta (respuesta_id, created, createdby, isactive, updated, updatedby, opcion_id, usuario_id) FROM stdin;
\.


--
-- Data for Name: rol; Type: TABLE DATA; Schema: public; Owner: admin
--

COPY public.rol (rol_id, nombre) FROM stdin;
3	ROL_PACIENTE
2	ROL_DEFAULT
1	ROL_ADMIN
\.


--
-- Data for Name: user_rol; Type: TABLE DATA; Schema: public; Owner: admin
--

COPY public.user_rol (usuario_id, rol_id) FROM stdin;
2	2
3	3
5	3
1	1
\.


--
-- Data for Name: usuario; Type: TABLE DATA; Schema: public; Owner: admin
--

COPY public.usuario (usuario_id, username, password, email, fnac, apellido, dni, nombre) FROM stdin;
3	paciente	$2a$10$HZeUo2TjNkEAQGCYmpYUwey7v45q0GEAjNWSHutT.C5LiK4dOD/FK	paciente@gmail.com	1999-05-18	paciente	1234	paciente
2	user	$2a$10$OGNFRLqpy1.bmPWQCSXtH.uTgniemXKxLvoTTI4PE3gg5Gn.gYpMS	user@gmail.com	1997-09-11	user	1234	user
5	test	$2a$10$kSjxEaiV6rH2amZCQ/3Z6uK0xVPAq5D9qYJvT/YyMVm019t8tafQa	test@test.com	2024-07-25	test	1234	test
1	admin	$2a$10$L0rqEM2ATQL7gA2g175dSeHHO454iDncyqMhOy4h8u.x/vCAi7bsu	admin@gmail.com	1998-04-08	admin	1234	admin
\.


--
-- Name: cuestionario_cuestionario_id_seq; Type: SEQUENCE SET; Schema: public; Owner: admin
--

SELECT pg_catalog.setval('public.cuestionario_cuestionario_id_seq', 9, true);


--
-- Name: cuidado_cuidado_id_seq; Type: SEQUENCE SET; Schema: public; Owner: admin
--

SELECT pg_catalog.setval('public.cuidado_cuidado_id_seq', 8, true);


--
-- Name: cuidado_posicion_seq; Type: SEQUENCE SET; Schema: public; Owner: admin
--

SELECT pg_catalog.setval('public.cuidado_posicion_seq', 4, true);


--
-- Name: opcion_opcion_id_seq; Type: SEQUENCE SET; Schema: public; Owner: admin
--

SELECT pg_catalog.setval('public.opcion_opcion_id_seq', 34, true);


--
-- Name: respuesta_respuesta_id_seq; Type: SEQUENCE SET; Schema: public; Owner: admin
--

SELECT pg_catalog.setval('public.respuesta_respuesta_id_seq', 1, false);


--
-- Name: role_role_id_seq; Type: SEQUENCE SET; Schema: public; Owner: admin
--

SELECT pg_catalog.setval('public.role_role_id_seq', 3, true);


--
-- Name: usuario_usuario_id_seq; Type: SEQUENCE SET; Schema: public; Owner: admin
--

SELECT pg_catalog.setval('public.usuario_usuario_id_seq', 5, true);


--
-- Name: cuestionario cuestionario_pkey; Type: CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.cuestionario
    ADD CONSTRAINT cuestionario_pkey PRIMARY KEY (cuestionario_id);


--
-- Name: cuidado cuidado_pkey; Type: CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.cuidado
    ADD CONSTRAINT cuidado_pkey PRIMARY KEY (cuidado_id);


--
-- Name: opcion opcion_pkey; Type: CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.opcion
    ADD CONSTRAINT opcion_pkey PRIMARY KEY (opcion_id);


--
-- Name: respuesta respuesta_pkey; Type: CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.respuesta
    ADD CONSTRAINT respuesta_pkey PRIMARY KEY (respuesta_id);


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
-- Name: respuesta fk74432jjxb0xi8pqbr4mt82v98; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.respuesta
    ADD CONSTRAINT fk74432jjxb0xi8pqbr4mt82v98 FOREIGN KEY (opcion_id) REFERENCES public.opcion(opcion_id);


--
-- Name: opcion fk7e50il4gkyu68tp3i0jqtib3w; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.opcion
    ADD CONSTRAINT fk7e50il4gkyu68tp3i0jqtib3w FOREIGN KEY (cuestionario_id) REFERENCES public.cuestionario(cuestionario_id);


--
-- Name: respuesta fkctn14ljjyruo647pixtk6c9e7; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.respuesta
    ADD CONSTRAINT fkctn14ljjyruo647pixtk6c9e7 FOREIGN KEY (usuario_id) REFERENCES public.usuario(usuario_id);


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

