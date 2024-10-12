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
-- Name: alimento; Type: TABLE; Schema: public; Owner: admin
--

CREATE TABLE public.alimento (
    alimento_id bigint NOT NULL,
    created timestamp(6) without time zone,
    createdby bigint,
    isactive boolean DEFAULT true NOT NULL,
    updated timestamp(6) without time zone,
    updatedby bigint,
    agua numeric(10,3),
    calcio numeric(10,3),
    carbohidratos_totales numeric(10,3),
    cenizas numeric(10,3),
    energia_kcal numeric(10,3),
    energia_kj numeric(10,3),
    fosforo numeric(10,3),
    genero character varying(255),
    grasa_total numeric(10,3),
    hierro numeric(10,3),
    niacina numeric(10,3),
    nombre character varying(255),
    numero integer,
    potasio numeric(10,3),
    proteinas numeric(10,3),
    rivoflavina numeric(10,3),
    sodio numeric(10,3),
    tiamina numeric(10,3),
    vitamina_c numeric(10,3),
    zinc numeric(10,3),
    ac_grasos_monoinsaturados numeric(10,3),
    ac_grasos_poliinsaturados numeric(10,3),
    ac_grasos_saturados numeric(10,3),
    carbohidratos_disponibles numeric(10,3),
    colesterol numeric(10,3),
    fibra_dietetica numeric(10,3)
);


ALTER TABLE public.alimento OWNER TO admin;

--
-- Name: alimento_alimento_id_seq; Type: SEQUENCE; Schema: public; Owner: admin
--

CREATE SEQUENCE public.alimento_alimento_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.alimento_alimento_id_seq OWNER TO admin;

--
-- Name: alimento_alimento_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: admin
--

ALTER SEQUENCE public.alimento_alimento_id_seq OWNED BY public.alimento.alimento_id;


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
-- Name: register_token; Type: TABLE; Schema: public; Owner: admin
--

CREATE TABLE public.register_token (
    token_id bigint NOT NULL,
    expiry_date timestamp(6) without time zone,
    token character varying(255),
    usuario_id bigint NOT NULL
);


ALTER TABLE public.register_token OWNER TO admin;

--
-- Name: register_token_token_id_seq; Type: SEQUENCE; Schema: public; Owner: admin
--

CREATE SEQUENCE public.register_token_token_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.register_token_token_id_seq OWNER TO admin;

--
-- Name: register_token_token_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: admin
--

ALTER SEQUENCE public.register_token_token_id_seq OWNED BY public.register_token.token_id;


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
    nombre character varying(255),
    created timestamp(6) without time zone,
    createdby bigint,
    updated timestamp(6) without time zone,
    updatedby bigint,
    isactive boolean NOT NULL,
    isenabled boolean
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
-- Name: alimento alimento_id; Type: DEFAULT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.alimento ALTER COLUMN alimento_id SET DEFAULT nextval('public.alimento_alimento_id_seq'::regclass);


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
-- Name: register_token token_id; Type: DEFAULT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.register_token ALTER COLUMN token_id SET DEFAULT nextval('public.register_token_token_id_seq'::regclass);


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
-- Data for Name: alimento; Type: TABLE DATA; Schema: public; Owner: admin
--

COPY public.alimento (alimento_id, created, createdby, isactive, updated, updatedby, agua, calcio, carbohidratos_totales, cenizas, energia_kcal, energia_kj, fosforo, genero, grasa_total, hierro, niacina, nombre, numero, potasio, proteinas, rivoflavina, sodio, tiamina, vitamina_c, zinc, ac_grasos_monoinsaturados, ac_grasos_poliinsaturados, ac_grasos_saturados, carbohidratos_disponibles, colesterol, fibra_dietetica) FROM stdin;
2	\N	\N	t	\N	\N	39.800	\N	1.100	1.900	454.000	1900.900	\N	\N	44.200	\N	2.700	Cerdo, chorizo, fresco, crudo	218	\N	13.000	0.200	\N	0.100	2.600	\N	\N	\N	\N	\N	\N	\N
3	\N	\N	t	\N	\N	50.000	6.000	\N	0.500	320.000	1339.800	209.000	\N	24.300	1.200	\N	Cerdo, costilla, a la parrilla	214	359.000	25.200	\N	106.000	\N	\N	\N	\N	\N	\N	\N	\N	\N
4	\N	\N	t	\N	\N	60.700	2.000	\N	0.800	250.000	1046.800	233.000	\N	18.900	1.400	11.600	Cerdo, costilla flaca, cruda	213	380.000	19.900	0.100	99.000	0.600	\N	\N	\N	\N	\N	\N	\N	\N
5	\N	\N	t	\N	\N	60.400	15.000	\N	4.900	211.000	883.500	143.000	\N	14.400	7.500	\N	Cerdo, jamón cocido	216	107.000	20.300	\N	1900.000	\N	\N	\N	\N	\N	\N	\N	\N	\N
6	\N	\N	t	\N	\N	28.900	11.000	\N	8.500	473.000	1980.500	152.000	\N	44.600	4.000	\N	Cerdo, jamón crudo	215	219.000	18.000	\N	2940.000	\N	\N	\N	\N	\N	\N	\N	\N	\N
7	\N	\N	t	\N	\N	14.300	37.000	\N	6.600	670.000	2805.300	38.000	\N	70.800	1.300	\N	Cerdo, panceta	217	17.000	8.300	\N	1780.000	\N	\N	\N	\N	\N	\N	\N	\N	\N
8	\N	\N	t	\N	\N	77.000	13.000	\N	1.600	99.000	414.500	170.000	\N	2.700	1.700	10.600	Cordero, carne de la paleta, crudo	219	361.000	18.700	0.100	97.000	0.100	\N	\N	\N	\N	\N	\N	\N	\N
9	\N	\N	t	\N	\N	62.000	17.000	\N	2.200	182.000	762.000	242.000	\N	7.800	5.700	\N	Cordero, carne de la paleta, flaca, a la parrilla	220	446.000	28.000	\N	122.000	\N	\N	\N	\N	\N	\N	\N	\N	\N
10	\N	\N	t	\N	\N	63.800	11.000	\N	1.000	168.000	703.400	249.000	\N	5.400	2.000	\N	Pollo, asado a la parrilla	224	333.000	29.800	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
11	\N	\N	t	\N	\N	64.400	12.000	\N	1.800	162.000	678.300	193.000	\N	5.400	3.300	\N	Pollo, asado al horno	223	327.000	28.400	\N	129.000	\N	\N	\N	\N	\N	\N	\N	\N	\N
12	\N	\N	t	\N	\N	80.000	2.000	\N	1.200	88.000	368.500	200.000	\N	2.500	5.000	\N	Pollo, carne-pellejo-menudos, fresco, crudo	221	292.000	16.300	\N	119.000	\N	\N	\N	\N	\N	\N	\N	\N	\N
13	\N	\N	t	\N	\N	63.000	2.000	\N	2.200	198.000	829.000	158.000	\N	11.700	1.700	\N	Pollo, hervido	222	363.000	23.100	\N	110.000	\N	\N	\N	\N	\N	\N	\N	\N	\N
14	\N	\N	t	\N	\N	83.700	\N	\N	0.600	64.000	268.000	\N	\N	0.200	\N	\N	Rana, carne de la pata, fresca, cruda	225	\N	15.500	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
15	\N	\N	t	\N	\N	62.800	9.600	\N	2.700	199.000	\N	254.000	\N	12.800	2.700	\N	Hamburguesas light asada	558	329.000	21.000	\N	747.000	\N	\N	5.400	\N	\N	\N	\N	\N	\N
16	\N	\N	t	\N	\N	59.600	7.600	\N	2.600	248.000	\N	223.000	\N	18.400	2.500	\N	Hamburguesas regulares de carne vacuna asadas	559	316.000	20.500	\N	769.000	\N	\N	5.200	\N	\N	\N	\N	\N	\N
17	\N	\N	t	\N	\N	68.000	32.000	\N	3.600	136.000	\N	159.000	\N	4.400	1.900	\N	Salchichas  light tipo Viena	560	256.000	14.200	\N	1093.000	\N	\N	2.600	\N	\N	\N	\N	\N	\N
18	\N	\N	t	\N	\N	68.300	33.000	\N	3.200	139.000	\N	135.000	\N	5.000	1.900	\N	Salchichas light tipo Viena hervidas	561	223.000	13.700	\N	973.000	\N	\N	2.500	\N	\N	\N	\N	\N	\N
19	\N	\N	t	\N	\N	60.400	37.000	\N	3.900	211.000	\N	180.000	\N	13.600	1.600	\N	Salchichas tipo Viena	562	222.000	11.300	\N	1292.000	\N	\N	1.900	\N	\N	\N	\N	\N	\N
20	\N	\N	t	\N	\N	60.900	40.000	\N	3.500	209.000	\N	162.000	\N	13.400	1.800	\N	Salchichas tipo Viena hervidas	563	183.000	11.800	\N	1141.000	\N	\N	1.900	\N	\N	\N	\N	\N	\N
21	\N	\N	t	\N	\N	69.500	\N	\N	1.400	170.000	711.800	\N	\N	10.700	\N	\N	Vacuno, asado, fresco, crudo	226	\N	18.400	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
22	\N	\N	t	\N	\N	63.900	4.000	\N	1.400	189.000	791.300	238.000	\N	10.100	3.500	\N	Vacuno, bife, a la parrilla	227	367.000	24.600	\N	97.000	\N	\N	\N	\N	\N	\N	\N	\N	\N
23	\N	\N	t	\N	\N	67.000	\N	0.000	\N	190.000	795.500	\N	\N	12.000	\N	\N	Vacuno, bife angosto c/c de novillito, fresco, crudo	503	\N	21.000	\N	42.000	\N	\N	\N	\N	\N	\N	\N	\N	\N
24	\N	\N	t	\N	\N	74.300	\N	0.000	1.100	114.000	477.300	\N	\N	3.200	\N	\N	Vacuno, bola de lomo de novillito, fresco, crudo	504	\N	22.000	\N	44.000	\N	\N	\N	\N	\N	\N	\N	\N	\N
25	\N	\N	t	\N	\N	73.800	\N	0.000	1.000	120.000	502.400	\N	\N	3.900	\N	\N	Vacuno, brazuelo de novillito, fresco, crudo	505	\N	21.000	\N	56.000	\N	\N	\N	\N	\N	\N	\N	\N	\N
26	\N	\N	t	\N	\N	\N	\N	\N	12.500	785.000	3286.800	\N	\N	87.000	\N	\N	Vacuno, caracú (médula de hueso largo), crudo	228	\N	0.500	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
27	\N	\N	t	\N	\N	71.600	\N	0.000	1.000	143.000	598.700	\N	\N	6.700	\N	\N	Vacuno, colita de cuadril de novillito, fresco, crudo	506	\N	21.000	\N	36.000	\N	\N	\N	\N	\N	\N	\N	\N	\N
28	\N	\N	t	\N	\N	73.700	\N	0.000	1.000	116.000	485.700	\N	\N	2.600	\N	\N	Vacuno, corazón de cuadril de novillito, fresco, crudo	507	\N	22.000	\N	39.000	\N	\N	\N	\N	\N	\N	\N	\N	\N
29	\N	\N	t	\N	\N	74.000	2.000	\N	2.000	111.000	464.800	234.000	\N	3.000	3.200	\N	Vacuno, cuadril y bife angosto flaco, fresco, crudo	229	368.000	21.000	\N	47.000	\N	\N	\N	\N	\N	\N	\N	\N	\N
30	\N	\N	t	\N	\N	59.500	14.000	\N	2.400	224.000	937.900	145.000	\N	14.400	13.500	\N	Vacuno, en conserva, enlatado	230	148.000	23.700	\N	895.000	\N	\N	\N	\N	\N	\N	\N	\N	\N
31	\N	\N	t	\N	\N	59.600	9.000	\N	2.600	248.000	1038.400	\N	\N	18.400	2.400	\N	Vacuno, hamburguesas cocidas	554	322.000	20.500	\N	834.000	\N	\N	5.000	\N	\N	\N	\N	\N	\N
32	\N	\N	t	\N	\N	63.900	7.000	\N	2.600	218.000	912.800	\N	\N	16.500	1.800	\N	Vacuno, hamburguesas crudas	553	278.000	17.300	\N	703.000	\N	\N	3.700	\N	\N	\N	\N	\N	\N
33	\N	\N	t	\N	\N	62.800	12.000	\N	2.700	199.000	833.200	\N	\N	12.800	2.700	\N	Vacuno, hamburguesas light cocidas	556	342.000	21.000	\N	862.000	\N	\N	5.300	\N	\N	\N	\N	\N	\N
34	\N	\N	t	\N	\N	68.200	11.000	\N	2.400	175.000	732.700	\N	\N	11.300	2.000	\N	Vacuno, hamburguesas light crudas	555	320.000	18.400	\N	754.000	\N	\N	4.300	\N	\N	\N	\N	\N	\N
35	\N	\N	t	\N	\N	69.700	4.000	6.000	1.400	132.000	552.700	376.000	\N	3.200	10.000	12.700	Vacuno, hígado, crudo	231	320.000	19.700	2.300	86.000	0.200	\N	\N	\N	\N	\N	\N	\N	\N
36	\N	\N	t	\N	\N	91.400	2.000	\N	1.200	33.000	138.200	252.000	\N	0.600	1.100	\N	Vacuno, jugo de carne	232	618.000	6.800	\N	247.000	\N	\N	\N	\N	\N	\N	\N	\N	\N
37	\N	\N	t	\N	\N	71.600	2.000	\N	2.100	116.000	485.700	188.000	\N	4.000	2.700	\N	Vacuno, lomo, fresco, crudo	233	369.000	20.000	\N	79.000	\N	\N	\N	\N	\N	\N	\N	\N	\N
38	\N	\N	t	\N	\N	74.500	\N	0.000	1.200	106.000	443.800	\N	\N	1.700	\N	\N	Vacuno, nalga de novillito, fresco, crudo	510	\N	22.000	\N	38.000	\N	\N	\N	\N	\N	\N	\N	\N	\N
39	\N	\N	t	\N	\N	75.300	3.000	\N	2.100	97.000	406.100	186.000	\N	1.400	3.500	\N	Vacuno, nalga, fresco, crudo	234	399.000	21.200	\N	63.000	\N	\N	\N	\N	\N	\N	\N	\N	\N
40	\N	\N	t	\N	\N	74.700	\N	0.000	1.000	125.000	523.400	\N	\N	5.500	\N	\N	Vacuno, paleta de novillito, fresco, crudo	511	\N	19.000	\N	63.000	\N	\N	\N	\N	\N	\N	\N	\N	\N
41	\N	\N	t	\N	\N	73.600	\N	0.000	1.000	132.000	552.700	\N	\N	6.100	\N	\N	Vacuno, paletín o marucha de novillito, fresco, crudo	512	\N	20.000	\N	80.000	\N	\N	\N	\N	\N	\N	\N	\N	\N
42	\N	\N	t	\N	\N	74.400	\N	0.000	1.100	116.000	485.700	\N	\N	3.700	\N	\N	Vacuno, palomita de novillito, fresco, crudo	513	\N	20.000	\N	61.000	\N	\N	\N	\N	\N	\N	\N	\N	\N
43	\N	\N	t	\N	\N	52.600	25.000	\N	2.400	335.000	1402.600	317.000	\N	31.000	7.600	\N	Vacuno, pasta de hígado	235	209.000	14.000	\N	627.000	\N	\N	\N	\N	\N	\N	\N	\N	\N
44	\N	\N	t	\N	\N	74.100	\N	0.000	1.100	125.000	523.400	\N	\N	1.900	\N	\N	Vacuno, peceto de novillito, fresco, crudo	514	\N	23.000	\N	50.000	\N	\N	\N	\N	\N	\N	\N	\N	\N
45	\N	\N	t	\N	\N	72.100	\N	0.000	1.300	139.000	582.000	\N	\N	6.500	\N	\N	Vacuno, pecho de novillito, fresco, crudo	515	\N	20.000	\N	170.000	\N	\N	\N	\N	\N	\N	\N	\N	\N
46	\N	\N	t	\N	\N	74.900	14.000	0.900	1.100	137.000	573.600	262.000	\N	8.100	15.000	10.500	Vacuno, riñon, fresco, crudo	236	231.000	15.000	1.700	245.000	0.200	\N	\N	\N	\N	\N	\N	\N	\N
47	\N	\N	t	\N	\N	64.400	\N	0.000	1.000	211.000	883.500	\N	\N	15.000	\N	\N	Vacuno, tapa de cuadril de novillito, fresco, crudo	521	\N	20.000	\N	53.000	\N	\N	\N	\N	\N	\N	\N	\N	\N
48	\N	\N	t	\N	\N	67.800	4.000	\N	1.600	139.000	582.000	224.000	\N	3.400	4.100	\N	Vacuno, ternera, costilla flaca, a la parrilla	237	406.000	27.200	\N	74.000	\N	\N	\N	\N	\N	\N	\N	\N	\N
49	\N	\N	t	\N	\N	76.300	5.000	\N	2.000	95.000	397.800	201.000	\N	1.700	2.000	\N	Vacuno, ternera, costilla flaca, fresco, crudo	238	325.000	20.000	\N	88.000	\N	\N	\N	\N	\N	\N	\N	\N	\N
50	\N	\N	t	\N	\N	70.100	\N	0.000	0.900	154.000	644.800	\N	\N	7.600	\N	\N	Vacuno, tortuguita de novillito, fresco, crudo	516	\N	22.000	\N	69.000	\N	\N	\N	\N	\N	\N	\N	\N	\N
51	\N	\N	t	\N	\N	55.600	3.000	\N	1.500	258.000	1080.200	204.000	\N	17.300	4.100	\N	Vacuno, vacío, a la parrilla	240	381.000	25.600	\N	91.000	\N	\N	\N	\N	\N	\N	\N	\N	\N
52	\N	\N	t	\N	\N	56.100	3.000	\N	1.500	241.000	1009.100	234.000	\N	14.300	4.400	\N	Vacuno, vacío, al horno	241	339.000	28.100	\N	63.000	\N	\N	\N	\N	\N	\N	\N	\N	\N
53	\N	\N	t	\N	\N	68.900	\N	0.000	0.900	174.000	728.500	\N	\N	11.000	\N	\N	Vacuno, vacío de novillito, fresco, crudo	517	\N	20.000	\N	53.000	\N	\N	\N	\N	\N	\N	\N	\N	\N
54	\N	\N	t	\N	\N	66.500	2.000	\N	1.300	171.000	716.000	213.000	\N	8.400	3.200	\N	Vacuno, vacío flaco, fresco, crudo	239	359.000	23.800	\N	70.000	\N	\N	\N	\N	\N	\N	\N	\N	\N
55	\N	\N	t	\N	\N	52.700	\N	0.100	1.400	233.000	975.600	\N	\N	9.900	\N	\N	Bife, cocido	242	\N	36.000	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
56	\N	\N	t	\N	\N	71.600	\N	4.300	1.200	120.000	502.400	\N	\N	2.200	\N	\N	Bife, crudo	243	\N	20.700	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
57	\N	\N	t	\N	\N	55.300	\N	0.700	1.000	197.000	824.800	\N	\N	4.400	\N	\N	Nalga, cocida	244	\N	38.600	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
58	\N	\N	t	\N	\N	74.400	\N	4.900	1.100	98.000	410.300	\N	\N	\N	\N	\N	Nalga, cruda	245	\N	19.500	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
59	\N	\N	t	\N	\N	54.600	\N	0.400	1.600	207.000	866.700	\N	\N	6.400	\N	\N	Paleta, cocida	246	\N	37.000	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
60	\N	\N	t	\N	\N	76.400	\N	0.200	1.000	107.000	448.000	\N	\N	3.400	\N	\N	Paleta, cruda	247	\N	19.000	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
61	\N	\N	t	\N	\N	48.900	\N	1.200	1.900	231.000	967.200	\N	\N	6.800	\N	\N	Vacío, cocido	248	\N	41.100	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
62	\N	\N	t	\N	\N	75.300	\N	3.100	1.100	105.000	439.600	\N	\N	2.200	\N	\N	Vacío, crudo	249	\N	18.400	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
63	\N	\N	t	\N	\N	51.800	\N	0.300	1.600	236.000	988.100	\N	\N	9.800	\N	\N	Bife, cocido	250	\N	36.500	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
64	\N	\N	t	\N	\N	72.200	\N	3.200	1.100	120.000	502.400	\N	\N	2.500	\N	\N	Bife, crudo	251	\N	21.100	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
65	\N	\N	t	\N	\N	59.600	\N	0.600	0.900	177.000	741.100	\N	\N	3.800	\N	\N	Nalga, cocida	252	\N	35.100	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
66	\N	\N	t	\N	\N	74.400	\N	2.500	1.100	103.000	431.300	\N	\N	1.100	\N	\N	Nalga, cruda	253	\N	21.000	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
67	\N	\N	t	\N	\N	56.800	\N	0.900	1.600	192.000	803.900	\N	\N	5.200	\N	\N	Paleta, cocida	254	\N	35.500	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
68	\N	\N	t	\N	\N	75.800	\N	2.000	1.000	106.000	443.800	\N	\N	2.700	\N	\N	Paleta, cruda	255	\N	18.400	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
69	\N	\N	t	\N	\N	53.900	\N	1.200	1.500	203.000	850.000	\N	\N	5.000	\N	\N	Vacío, cocido	256	\N	38.400	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
70	\N	\N	t	\N	\N	75.300	\N	2.700	1.000	107.000	448.000	\N	\N	2.500	\N	\N	Vacío, crudo	257	\N	18.400	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
71	\N	\N	t	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	2.500	\N	\N	Bola de lomo	258	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
72	\N	\N	t	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	2.000	\N	\N	Carré	259	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
73	\N	\N	t	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	3.200	\N	\N	Cuadrada	260	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
74	\N	\N	t	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	2.100	\N	\N	Lomo	261	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
75	\N	\N	t	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	2.000	\N	\N	Nalga	262	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
76	\N	\N	t	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	4.500	\N	\N	Peceto	263	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
77	\N	\N	t	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	1.800	\N	\N	Bife	270	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
78	\N	\N	t	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	2.200	\N	\N	Bola de lomo	264	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
79	\N	\N	t	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	2.300	\N	\N	Cuadrada	265	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
80	\N	\N	t	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	2.300	\N	\N	Cuadril	266	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
81	\N	\N	t	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	2.100	\N	\N	Nalga	267	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
82	\N	\N	t	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	2.200	\N	\N	Peceto	268	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
83	\N	\N	t	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	2.300	\N	\N	Total pata	269	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
84	\N	\N	t	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	3.900	\N	\N	Pata sin piel	271	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
85	\N	\N	t	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	1.200	\N	\N	Pechuga sin piel	272	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
86	\N	\N	t	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	45.700	\N	\N	Piel sola	273	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
87	\N	\N	t	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	2.400	\N	\N	Bife angosto	274	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
88	\N	\N	t	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	2.600	\N	\N	Bola de lomo	275	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
89	\N	\N	t	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	1.100	\N	\N	Cuadrada	279	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
90	\N	\N	t	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	1.900	\N	\N	Cuadril, colita	276	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
91	\N	\N	t	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	2.200	\N	\N	Cuadril, corazón	277	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
92	\N	\N	t	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	3.000	\N	\N	Cuadril, tapa	278	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
93	\N	\N	t	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	3.800	\N	\N	Lomo	280	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
94	\N	\N	t	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	3.600	\N	\N	Marucha	281	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
95	\N	\N	t	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	1.000	\N	\N	Nalga	282	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
96	\N	\N	t	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	4.600	\N	\N	Palomita	283	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
97	\N	\N	t	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	1.600	\N	\N	Peceto	284	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
98	\N	\N	t	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	3.200	\N	\N	Bife angosto	285	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
99	\N	\N	t	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	3.100	\N	\N	Bola de lomo	286	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
100	\N	\N	t	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	1.200	\N	\N	Cuadrada	290	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
101	\N	\N	t	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	2.700	\N	\N	Cuadril, colita	287	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
102	\N	\N	t	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	2.900	\N	\N	Cuadril, corazón	288	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
103	\N	\N	t	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	4.200	\N	\N	Cuadril, tapa	289	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
104	\N	\N	t	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	5.200	\N	\N	Lomo	291	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
105	\N	\N	t	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	3.900	\N	\N	Marucha	292	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
106	\N	\N	t	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	1.100	\N	\N	Nalga	293	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
107	\N	\N	t	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	5.400	\N	\N	Palomita	294	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
108	\N	\N	t	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	1.800	\N	\N	Peceto	295	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
109	\N	\N	t	\N	\N	74.300	\N	\N	3.100	98.000	410.300	\N	\N	2.500	\N	\N	\\"Jamon cocido \\"\\"Villafranca Novissimo\\"\\".El Bierzo. Reducido en colesterol\\"	522	\N	18.000	\N	486.000	\N	\N	\N	\N	\N	\N	\N	\N	\N
110	\N	\N	t	\N	\N	73.600	\N	\N	4.300	95.000	397.800	\N	\N	2.000	\N	\N	\\"Lomo ahumado de cerdo cocido \\"\\"Villafranca Novissimo\\"\\". El Bierzo. Reducido en sodio y en colesterol\\"	523	\N	19.000	\N	902.000	\N	\N	\N	\N	\N	\N	\N	\N	\N
111	\N	\N	t	\N	\N	66.700	\N	\N	4.000	139.000	582.000	\N	\N	5.700	\N	\N	\\"Mortadela\\"\\" Villafranca Novissimo\\"\\". El Bierzo - reducida en grasa y en sodio\\"	524	\N	16.000	\N	655.000	\N	\N	\N	\N	\N	\N	\N	\N	\N
112	\N	\N	t	\N	\N	75.500	\N	\N	3.400	79.000	330.800	\N	\N	0.400	\N	\N	\\"Pastron ahumado \\"\\"Villafranca Novissimo\\"\\". El Bierzo. Reducido en sodio y en colesterol\\"	525	\N	16.000	\N	658.000	\N	\N	\N	\N	\N	\N	\N	\N	\N
113	\N	\N	t	\N	\N	67.600	\N	\N	3.900	134.000	561.100	\N	\N	4.600	\N	\N	\\"Salame \\"\\"Villafranca Novissimo\\"\\".El Bierzo.Reducido en sodio y en colesterol\\"	526	\N	22.000	\N	740.000	\N	\N	\N	\N	\N	\N	\N	\N	\N
114	\N	\N	t	\N	\N	73.000	69.000	7.700	3.600	46.000	192.600	29.000	Lagostomus maximus maximus Blainv	3.700	2.600	\N	Carne de vizcacha	557	260.000	23.900	\N	\N	\N	9.900	\N	\N	\N	\N	\N	\N	\N
115	\N	\N	t	\N	\N	11.200	\N	63.600	2.300	384.000	1607.800	\N	Amarantus caudatus	7.600	12.200	\N	Amaranto, semilla, cruda (Amarantus caudatus)	484	\N	15.300	\N	\N	\N	\N	4.800	\N	\N	\N	\N	\N	\N
116	\N	\N	t	\N	\N	11.500	\N	64.300	2.500	381.000	1595.800	\N	Amarantus hipochondriacus	7.400	13.500	\N	Amaranto, semilla, cruda (Amarantus hipochondriacus)	486	\N	14.400	\N	\N	\N	\N	4.900	\N	\N	\N	\N	\N	\N
117	\N	\N	t	\N	\N	10.800	\N	62.700	2.800	388.000	1623.300	\N	Amarantus mantegazzianus	8.400	8.200	\N	Amaranto, semilla, cruda (Amarantus mantegazzianus)	483	\N	15.400	\N	\N	\N	\N	4.000	\N	\N	\N	\N	\N	\N
118	\N	\N	t	\N	\N	11.300	\N	63.400	2.200	384.000	1608.200	\N	Amarantus cruentus	7.600	10.900	\N	Amaranto, semillia, cruda (Amarantus cruentus)	485	\N	15.600	\N	\N	\N	\N	3.800	\N	\N	\N	\N	\N	\N
119	\N	\N	t	\N	\N	12.500	9.000	79.200	1.200	339.000	1419.000	93.000	\N	0.200	0.700	4.700	Arroz, grano, blanco, pulido, crudo	1	78.000	6.900	0.100	4.000	0.000	\N	\N	\N	\N	\N	77.500	\N	1.700
120	\N	\N	t	\N	\N	79.000	3.000	19.400	0.100	82.000	343.000	26.000	\N	0.100	0.600	\N	Arroz, grano, blanco, pulido, hervido	2	80.000	1.400	\N	5.000	\N	\N	\N	\N	\N	\N	19.100	\N	0.300
121	\N	\N	t	\N	\N	11.900	36.000	62.500	2.200	383.000	1603.600	360.000	\N	7.800	4.100	1.400	Avena , grano, arrollada, cruda	3	391.000	15.600	0.200	47.000	0.600	\N	\N	\N	\N	\N	\N	\N	\N
122	\N	\N	t	\N	\N	10.900	21.000	\N	1.900	343.000	1436.100	333.000	\N	7.100	4.200	\N	Avena, grano, arrollada, cruda	4	460.000	12.800	\N	65.000	\N	\N	4.400	\N	\N	\N	56.900	\N	10.400
123	\N	\N	t	\N	\N	77.100	12.000	15.800	1.400	86.000	360.000	90.000	\N	1.900	1.100	\N	Avena, grano, arrollada, hervida	5	87.000	3.800	\N	21.000	\N	\N	\N	\N	\N	\N	13.400	\N	2.400
124	\N	\N	t	\N	\N	12.000	15.000	74.900	1.400	317.000	1326.000	204.000	\N	1.500	2.800	7.400	Cebada, grano, mondado, perlado, crudo	6	138.000	10.200	0.100	6.000	0.100	\N	\N	\N	\N	\N	65.600	\N	9.300
125	\N	\N	t	\N	\N	77.200	7.000	19.300	\N	82.000	344.000	35.000	\N	0.100	0.700	\N	Cebada, grano, mondado, perlado, hervido	7	59.000	3.800	\N	13.000	\N	\N	\N	\N	\N	\N	16.500	\N	2.800
126	\N	\N	t	\N	\N	10.000	\N	76.900	1.200	328.000	1374.000	\N	\N	1.700	\N	1.700	\\"Cebada, harina \\"\\"Genser\\"\\", cruda\\"	8	\N	10.200	0.200	\N	0.100	\N	\N	\N	\N	\N	68.000	\N	8.000
127	\N	\N	t	\N	\N	11.000	\N	78.500	0.700	332.000	1392.000	\N	\N	0.900	\N	1.300	Centeno, harina, clara, cruda	9	\N	8.900	0.300	\N	0.100	\N	\N	\N	\N	\N	72.200	\N	6.300
128	\N	\N	t	\N	\N	40.200	23.000	48.900	1.600	206.000	863.000	156.000	\N	0.600	2.300	\N	Centeno, pan	10	205.000	8.700	\N	219.000	\N	\N	\N	\N	\N	\N	41.500	\N	7.400
129	\N	\N	t	\N	\N	38.400	31.000	49.000	1.300	214.000	894.000	278.000	\N	0.900	2.200	\N	Centeno, pan con harina integral	11	259.000	10.400	\N	466.000	\N	\N	\N	\N	\N	\N	41.000	\N	8.000
130	\N	\N	t	\N	\N	13.400	\N	74.100	1.100	346.000	1448.700	281.000	Zea Mays	0.800	9.500	\N	Maiz, amarillo Leales, grano entero, crudo	488	\N	10.600	\N	\N	\N	\N	3.200	\N	\N	\N	\N	\N	\N
131	\N	\N	t	\N	\N	12.700	\N	74.600	1.300	345.000	1444.500	203.000	Zea Mays	0.500	7.700	\N	Maiz amarillo, pisingallo, grano entero, crudo	490	\N	10.900	\N	\N	\N	\N	1.800	\N	\N	\N	\N	\N	\N
132	\N	\N	t	\N	\N	12.800	\N	76.400	0.700	305.000	1277.000	38.000	Zea Mays	1.100	1.100	\N	Maiz amarillo, sémola, grano entero, crudo	491	\N	9.000	\N	\N	\N	\N	1.000	\N	\N	\N	\N	\N	\N
133	\N	\N	t	\N	\N	13.900	\N	73.600	1.600	344.000	1439.100	251.000	Zea Mays	1.100	6.400	\N	Maiz, amarillo trópico 327, grano entero, crudo	489	\N	9.800	\N	\N	\N	\N	2.000	\N	\N	\N	\N	\N	\N
134	\N	\N	t	\N	\N	13.000	\N	77.700	1.100	340.000	1423.600	261.000	Zea Mays	0.900	3.400	\N	Maiz, blanco 8 rayas, grano entero, crudo	487	\N	7.300	\N	\N	\N	\N	1.800	\N	\N	\N	\N	\N	\N
135	\N	\N	t	\N	\N	13.900	\N	74.800	1.500	335.000	1402.600	325.000	Zea mays	0.900	11.500	\N	Maiz, blanco perla, grano entero, crudo	482	\N	9.000	\N	\N	\N	\N	2.500	\N	\N	\N	\N	\N	\N
136	\N	\N	t	\N	\N	73.900	6.000	20.500	0.700	97.000	405.000	103.000	\N	1.200	0.500	2.000	Maiz, choclo	12	113.000	3.700	0.100	40.000	0.100	8.200	\N	\N	\N	\N	17.800	\N	2.700
137	\N	\N	t	\N	\N	13.400	\N	74.900	1.300	346.000	1449.000	280.000	Zea mays	0.900	\N	\N	Maiz, grano, entero (Zea mays spp)	13	\N	9.500	\N	\N	\N	\N	\N	\N	\N	\N	67.600	\N	7.300
138	\N	\N	t	\N	\N	10.700	12.000	73.900	1.100	369.000	1545.000	87.000	\N	3.200	2.600	2.400	Maiz, harina amarilla (polenta), cruda	14	269.000	11.100	0.100	25.000	0.200	\N	\N	\N	\N	\N	\N	\N	\N
139	\N	\N	t	\N	\N	11.900	26.000	73.400	0.700	338.000	1415.000	170.000	\N	4.900	2.900	\N	Maiz, harina amarilla (polenta), cruda	15	299.000	9.100	\N	35.000	\N	\N	2.000	\N	\N	\N	64.500	\N	8.900
140	\N	\N	t	\N	\N	82.700	8.000	13.700	0.100	68.000	285.000	42.000	\N	0.800	0.900	\N	Maiz, harina amarilla (polenta), hervida	16	55.000	3.200	\N	11.000	\N	\N	\N	\N	\N	\N	11.900	\N	1.800
141	\N	\N	t	\N	\N	33.800	\N	53.200	1.000	275.000	1151.400	\N	\N	2.900	\N	\N	Maiz, pan	17	\N	9.100	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
142	\N	\N	t	\N	\N	15.200	212.000	72.500	2.600	382.000	1653.000	125.000	\N	10.100	1.200	\N	\\"Trigo, bizcochos \\"\\"Bay Biscuit\\"\\"\\"	19	97.000	5.900	\N	171.000	\N	\N	\N	\N	\N	\N	67.100	\N	1.500
143	\N	\N	t	\N	\N	6.200	69.000	70.000	4.700	401.000	1679.000	339.000	\N	8.900	1.100	\N	Trigo, bizcochos, vainillas	21	138.000	10.200	\N	111.000	\N	\N	\N	\N	\N	\N	\N	\N	\N
144	\N	\N	t	\N	\N	24.800	28.000	63.000	1.400	300.000	1256.100	194.000	\N	1.000	0.100	\N	Trigo, galleta de campo	22	136.000	9.800	\N	295.000	\N	\N	\N	\N	\N	\N	\N	\N	\N
145	\N	\N	t	\N	\N	10.500	16.000	75.900	0.100	361.000	1511.500	115.000	\N	0.700	0.100	\N	Trigo, galleta marinera	23	10.000	12.800	\N	30.000	\N	\N	\N	\N	\N	\N	\N	\N	\N
146	\N	\N	t	\N	\N	5.100	44.000	62.000	3.900	442.000	1850.700	174.000	\N	15.500	0.900	\N	\\"Trigo, galletitas de agua \\"\\"Express\\"\\"\\"	24	99.000	13.500	\N	323.000	\N	\N	\N	\N	\N	\N	\N	\N	\N
147	\N	\N	t	\N	\N	3.700	51.000	67.600	3.400	437.000	1829.700	117.000	\N	13.100	3.700	\N	\\"Trigo, galletitas de agua \\"\\"Traviata\\"\\"\\"	25	52.000	12.200	\N	640.000	\N	\N	\N	\N	\N	\N	\N	\N	\N
148	\N	\N	t	\N	\N	6.000	18.000	\N	1.300	410.000	1716.700	59.000	\N	11.600	1.700	\N	Trigo, galletitas de harina blanca	26	160.000	12.200	\N	141.000	\N	\N	2.200	\N	\N	\N	64.200	\N	4.700
149	\N	\N	t	\N	\N	5.400	19.000	\N	1.900	411.000	1720.900	200.000	\N	15.800	2.000	\N	Trigo, galletitas de harina integral	27	182.000	10.600	\N	141.000	\N	\N	2.200	\N	\N	\N	56.500	\N	9.800
150	\N	\N	t	\N	\N	3.000	42.000	73.000	5.400	417.000	1746.000	111.000	\N	10.100	1.000	\N	\\"Trigo, galletitas dulces \\"\\"Manón\\"\\"\\"	28	41.000	8.500	\N	233.000	\N	\N	\N	\N	\N	\N	\N	\N	\N
151	\N	\N	t	\N	\N	6.200	40.000	67.000	5.500	419.000	1754.400	180.000	\N	13.100	1.800	\N	\\"Trigo, galletitas dulces \\"\\"Minue\\"\\"\\"	29	97.000	8.200	\N	209.000	\N	\N	\N	\N	\N	\N	\N	\N	\N
152	\N	\N	t	\N	\N	12.000	46.000	58.000	4.000	442.000	1850.700	128.000	\N	21.100	1.800	\N	\\"Trigo, galletitas oblea \\"\\"Opera\\"\\"\\"	30	43.000	4.900	\N	208.000	\N	\N	\N	\N	\N	\N	\N	\N	\N
153	\N	\N	t	\N	\N	12.700	14.000	69.800	3.100	347.000	1452.900	333.000	\N	2.000	2.600	\N	Trigo, grano entero, crudo	18	355.000	12.400	\N	9.000	\N	\N	\N	\N	\N	\N	\N	\N	\N
154	\N	\N	t	\N	\N	10.000	24.000	72.600	4.700	342.000	1432.000	143.000	\N	0.200	1.700	\N	Trigo, grisines	31	148.000	12.500	\N	628.000	\N	\N	\N	\N	\N	\N	\N	\N	\N
155	\N	\N	t	\N	\N	12.700	11.000	\N	0.300	348.000	1457.100	91.000	\N	2.600	0.800	1.100	Trigo, harina cuatro ceros	33	144.000	10.200	0.100	3.000	0.200	\N	1.200	\N	\N	\N	70.800	\N	3.300
156	\N	\N	t	\N	\N	12.400	27.000	\N	1.800	308.000	1289.600	267.000	\N	3.000	3.300	5.200	Trigo, harina integral	34	605.000	11.400	0.400	16.000	1.600	\N	3.800	\N	\N	\N	58.800	\N	12.600
157	\N	\N	t	\N	\N	13.100	11.000	\N	0.600	340.000	1423.600	171.000	\N	2.700	1.500	1.700	Trigo, harina tres cero	32	176.000	10.300	0.100	10.000	0.200	\N	1.800	\N	\N	\N	68.700	\N	4.600
158	\N	\N	t	\N	\N	34.000	19.000	56.700	0.200	264.000	1105.400	97.000	\N	0.200	1.400	2.500	Trigo, pan alemán	38	69.000	8.900	0.300	150.000	0.200	\N	\N	\N	\N	\N	\N	\N	\N
159	\N	\N	t	\N	\N	29.200	20.000	60.700	1.100	280.000	1172.400	121.000	\N	0.300	1.200	\N	Trigo, pan criollo	39	128.000	8.700	\N	264.000	\N	\N	\N	\N	\N	\N	\N	\N	\N
160	\N	\N	t	\N	\N	35.000	68.000	\N	2.100	223.000	933.700	209.000	\N	1.600	1.200	\N	Trigo, pan de salvado	41	338.000	9.800	\N	112.000	\N	\N	\N	\N	\N	\N	42.300	\N	9.200
161	\N	\N	t	\N	\N	24.700	39.000	62.600	1.000	307.000	1285.400	157.000	\N	1.900	1.200	\N	Trigo, pan de Viena	40	132.000	9.800	\N	71.000	\N	\N	\N	\N	\N	\N	\N	\N	\N
162	\N	\N	t	\N	\N	29.800	19.000	\N	1.400	268.000	1122.100	136.000	\N	0.700	1.000	\N	Trigo, pan francés	37	175.000	8.400	\N	136.000	\N	\N	1.800	\N	\N	\N	57.000	\N	2.800
163	\N	\N	t	\N	\N	30.900	22.000	57.400	2.000	269.000	1126.300	107.000	\N	0.200	1.100	2.300	Trigo, pan francés	36	93.000	9.300	0.300	274.000	0.200	\N	\N	\N	\N	\N	\N	\N	\N
164	\N	\N	t	\N	\N	31.600	21.000	58.300	1.200	271.000	1134.700	208.000	\N	0.500	2.900	\N	Trigo, pan negro con levadura agria	42	165.000	8.400	\N	84.000	\N	\N	\N	\N	\N	\N	\N	\N	\N
165	\N	\N	t	\N	\N	34.000	21.000	52.400	1.700	269.000	1126.300	379.000	\N	2.400	2.900	\N	Trigo, pan negro con levadura comprimida	43	161.000	9.500	\N	123.000	\N	\N	\N	\N	\N	\N	\N	\N	\N
166	\N	\N	t	\N	\N	32.200	24.000	56.300	1.300	269.000	1126.300	210.000	\N	0.600	2.300	\N	Trigo, pan negro sin levadura	44	214.000	9.600	\N	45.000	\N	\N	\N	\N	\N	\N	\N	\N	\N
167	\N	\N	t	\N	\N	14.000	74.000	\N	5.400	171.000	716.000	904.000	\N	5.500	9.200	19.100	Trigo, salvado	35	1304.000	16.300	0.500	27.000	1.100	\N	9.600	\N	\N	\N	14.000	\N	44.700
168	\N	\N	t	\N	\N	12.400	12.000	73.400	1.600	349.000	1461.300	132.000	\N	0.900	2.700	3.600	Trigo, sémola, cruda	45	149.000	11.700	0.100	11.000	0.200	\N	\N	\N	\N	\N	\N	\N	\N
169	\N	\N	t	\N	\N	82.200	3.000	15.000	0.400	70.000	293.100	32.000	\N	\N	0.800	\N	Trigo, sémola, hervida	46	26.000	2.400	\N	5.000	\N	\N	\N	\N	\N	\N	\N	\N	\N
170	\N	\N	t	\N	\N	74.600	\N	16.900	2.900	98.000	410.300	\N	\N	1.500	\N	\N	Trigo, tallarines, frescos, hervidos	47	\N	4.100	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
171	\N	\N	t	\N	\N	77.700	33.000	19.400	0.900	93.000	389.400	29.000	Zyziphus sativa	0.400	0.600	\N	Aceituna de monte	496	192.000	1.600	\N	\N	\N	10.000	\N	\N	\N	\N	\N	\N	\N
172	\N	\N	t	\N	\N	75.200	61.000	4.000	5.800	144.000	602.900	17.000	Olea europaea	13.500	1.000	2.600	Aceituna verde, pulpa, encurtida	119	91.000	1.500	0.100	2250.000	0.000	1.600	\N	\N	\N	\N	\N	\N	\N
173	\N	\N	t	\N	\N	78.000	13.000	21.100	0.400	87.000	364.300	5.000	\N	0.100	1.700	0.600	Ananá enlatado, contenido envase	121	57.000	0.400	0.100	1.000	0.100	12.800	\N	\N	\N	\N	\N	\N	\N
174	\N	\N	t	\N	\N	85.300	12.000	13.700	0.400	58.000	242.800	8.000	Ananassa sativa L.	0.200	0.400	1.000	Ananá, pulpa, fresco	120	247.000	0.400	0.100	2.000	0.100	40.300	\N	\N	\N	\N	\N	\N	\N
175	\N	\N	t	\N	\N	74.800	7.000	23.000	0.800	99.000	414.500	28.000	Musa sapientum L.	0.200	0.400	1.200	Banana, pulpa, fresca	122	348.000	1.200	0.100	1.000	0.100	6.100	\N	\N	\N	\N	\N	\N	\N
176	\N	\N	t	\N	\N	83.000	16.000	14.800	0.600	68.000	284.700	17.000	Prunus avium L	0.500	0.400	0.800	Cereza, pulpa, fresca	123	275.000	1.100	0.000	3.000	0.000	5.600	\N	\N	\N	\N	\N	\N	\N
177	\N	\N	t	\N	\N	32.900	46.000	61.600	3.500	255.000	1067.700	92.000	Prunus domestica L	0.100	1.800	2.700	Ciruela, pasa, cruda	125	846.000	1.900	0.600	21.000	0.200	7.400	\N	\N	\N	\N	\N	\N	\N
178	\N	\N	t	\N	\N	56.400	31.000	40.100	2.400	165.000	690.900	64.000	Prunus domestica L	0.100	3.300	\N	Ciruela, pasa, hervida	126	534.000	1.000	\N	16.000	\N	\N	\N	\N	\N	\N	\N	\N	\N
179	\N	\N	t	\N	\N	85.700	24.000	12.900	0.500	56.000	234.500	16.000	Prunus domestica L	0.200	0.400	0.800	Ciruela, pulpa, fresca	124	261.000	0.700	0.100	2.000	0.000	4.200	\N	\N	\N	\N	\N	\N	\N
180	\N	\N	t	\N	\N	46.900	13.000	14.000	1.000	382.000	1599.400	94.000	Cocos nucifera	34.700	2.100	0.100	Coco, pulpa, fresco, crudo	127	436.000	3.400	\N	17.000	0.200	\N	\N	\N	\N	\N	\N	\N	\N
181	\N	\N	t	\N	\N	85.400	17.000	12.900	0.600	57.000	238.700	21.000	Prunus Armeniaca L.	0.100	0.400	1.200	Damasco, pulpa, fresco, crudo	128	320.000	1.000	0.100	1.000	0.000	3.100	\N	\N	\N	\N	\N	\N	\N
182	\N	\N	t	\N	\N	85.100	41.000	11.500	0.800	49.000	205.200	35.000	Morrenia odorata	1.000	0.600	\N	Doca	542	312.000	1.600	\N	\N	\N	41.600	\N	\N	\N	\N	\N	\N	\N
183	\N	\N	t	\N	\N	89.300	20.000	7.500	0.700	40.000	167.500	43.000	Prunus persica L.	\N	2.800	\N	Durazno orejón, pulpa y piel, hervido	131	276.000	2.500	\N	14.000	\N	\N	\N	\N	\N	\N	\N	\N	\N
184	\N	\N	t	\N	\N	80.900	4.000	18.200	0.400	75.000	314.000	10.000	Prunus persica L.	0.100	1.900	1.000	Durazno, pulpa, envasado al natural	130	151.000	0.400	0.000	1.000	0.000	3.600	\N	\N	\N	\N	\N	\N	\N
185	\N	\N	t	\N	\N	86.900	5.000	12.000	0.500	51.000	213.500	19.000	Prunus persica L.	0.100	0.400	0.800	Durazno, pulpa, fresco, crudo	129	259.000	0.500	0.000	3.000	0.000	6.300	\N	\N	\N	\N	\N	\N	\N
186	\N	\N	t	\N	\N	90.000	22.000	8.100	0.500	41.000	171.700	23.000	Fragarta h chiloensis Duch Var, ananassa B.	0.600	0.700	0.400	Frutilla pulpa, fresca, cruda	132	161.000	0.800	0.100	2.000	0.000	88.700	\N	\N	\N	\N	\N	\N	\N
187	\N	\N	t	\N	\N	81.000	11.000	17.700	0.500	75.000	314.000	105.000	Punica granatium L.	0.200	0.800	\N	Granada, pulpa, fresca	133	63.000	0.600	0.000	85.000	0.000	\N	\N	\N	\N	\N	\N	\N	\N
188	\N	\N	t	\N	\N	65.600	56.000	23.700	0.900	147.000	615.500	23.000	Brumelia obtusifolia	3.200	1.300	\N	Guaraniná, Brumelia obtusifolia	497	200.000	1.600	\N	\N	\N	16.400	\N	\N	\N	\N	\N	\N	\N
189	\N	\N	t	\N	\N	78.000	34.000	19.600	0.600	88.000	368.500	32.000	Ficus carica L.	0.400	0.400	0.700	Higo, pulpa, fresca	134	268.000	1.400	0.000	2.000	0.000	0.600	\N	\N	\N	\N	\N	\N	\N
190	\N	\N	t	\N	\N	78.200	\N	20.000	0.600	87.000	364.300	\N	Diospyrus Kaki L.	0.400	\N	0.100	Kaki, pulpa, fresco	135	\N	0.800	0.000	\N	0.000	13.100	\N	\N	\N	\N	\N	\N	\N
191	\N	\N	t	\N	\N	81.300	\N	17.100	0.600	73.000	305.700	\N	Fortunella spp.	0.100	\N	\N	Kinoto, pulpa y cáscara, fresco, crudo	136	\N	0.900	0.100	\N	0.100	57.600	\N	\N	\N	\N	\N	\N	\N
192	\N	\N	t	\N	\N	89.300	107.000	8.700	0.500	44.000	184.200	21.000	Citrus limonia	0.600	0.400	\N	Limón, pulpa, fresco	137	163.000	0.900	0.000	6.000	0.100	62.600	\N	\N	\N	\N	\N	\N	\N
193	\N	\N	t	\N	\N	92.000	3.000	6.000	1.500	26.000	108.900	5.000	Malus sylvestria	\N	0.600	\N	Manzana, hervida	139	58.000	0.500	\N	4.000	\N	\N	\N	\N	\N	\N	\N	\N	\N
194	\N	\N	t	\N	\N	84.100	4.000	14.900	0.300	64.000	268.000	9.000	Malus sylvestria	0.400	0.500	0.200	Manzana, pulpa, fresca, cruda	138	122.000	0.300	0.000	5.000	0.000	2.800	\N	\N	\N	\N	\N	\N	\N
195	\N	\N	t	\N	\N	68.900	14.000	23.400	1.400	84.000	351.700	110.000	Passiflora sp.	1.700	1.300	\N	Mburucuyá maduro	544	253.000	4.700	\N	\N	\N	14.600	\N	\N	\N	\N	\N	\N	\N
196	\N	\N	t	\N	\N	78.600	15.000	15.700	0.900	59.000	247.000	52.000	Passiflora sp.	1.600	5.000	\N	Mburucuyá verde	543	241.000	3.200	\N	\N	\N	26.400	\N	\N	\N	\N	\N	\N	\N
197	\N	\N	t	\N	\N	92.700	17.000	5.900	0.600	28.000	117.200	18.000	Cucumis melo L.	0.200	0.500	0.300	Melón, pulpa, fresco	140	275.000	0.600	0.000	17.000	0.000	14.800	\N	\N	\N	\N	\N	\N	\N
198	\N	\N	t	\N	\N	85.300	14.000	13.900	0.400	58.000	242.800	19.000	Cydonia oblonga L.	0.100	0.300	0.900	Membrillo, pulpa, fresco, crudo	141	203.000	0.300	0.100	3.000	0.000	3.400	\N	\N	\N	\N	\N	\N	\N
199	\N	\N	t	\N	\N	82.800	36.000	14.600	0.800	69.000	288.900	48.000	Morus spp.	0.600	1.600	1.100	Mora, fresca	142	257.000	1.200	0.100	2.000	0.100	2.400	\N	\N	\N	\N	\N	\N	\N
200	\N	\N	t	\N	\N	82.800	34.000	14.300	0.600	70.000	293.100	32.000	Eugenia uniflora	0.700	0.800	\N	Ñandapirí	502	213.000	1.700	\N	\N	\N	21.500	\N	\N	\N	\N	\N	\N	\N
201	\N	\N	t	\N	\N	65.400	15.000	3.300	3.200	258.000	1080.200	31.000	Persea gratissima	26.400	0.500	0.400	Palta, pulpa, fresca	143	396.000	1.700	0.100	16.000	0.000	5.800	\N	\N	\N	\N	\N	\N	\N
202	\N	\N	t	\N	\N	24.000	\N	71.600	1.700	299.000	1251.900	\N	Pirus comimunis L.	0.400	\N	1.300	Pera, orejón, crudo	145	\N	2.300	0.100	\N	0.100	9.200	\N	\N	\N	\N	\N	\N	\N
203	\N	\N	t	\N	\N	82.700	8.000	15.800	0.400	70.000	293.100	10.000	Pirus comimunis L.	0.400	0.200	0.200	Pera, pulpa, fresca, cruda	144	129.000	0.700	0.100	2.000	0.100	3.000	\N	\N	\N	\N	\N	\N	\N
204	\N	\N	t	\N	\N	92.900	13.000	5.900	0.700	26.000	108.900	10.000	Citrus grandis Osbeck	\N	0.200	\N	Pomelo, pulpa, fresco	146	147.000	0.500	0.100	37.000	0.100	47.800	\N	\N	\N	\N	\N	\N	\N
205	\N	\N	t	\N	\N	92.100	11.000	6.900	0.300	31.000	129.800	3.000	Citrullus vulgaris Schard	0.200	0.200	\N	Sandía, pulpa, fresca, cruda	147	73.000	0.500	0.000	8.000	0.000	9.100	\N	\N	\N	\N	\N	\N	\N
206	\N	\N	t	\N	\N	89.000	32.000	8.100	0.300	49.000	205.200	19.000	Eugenia  myrciantes	1.600	0.400	\N	Ubajay	545	97.000	1.100	\N	\N	\N	75.100	\N	\N	\N	\N	\N	\N	\N
207	\N	\N	t	\N	\N	\N	\N	\N	\N	900.000	3768.300	\N	\N	100.000	\N	\N	Aceite comestible mezcla Lira, 85% girasol, 15% oliva	148	\N	\N	\N	\N	\N	\N	\N	33.600	54.600	12.000	\N	\N	\N
208	\N	\N	t	\N	\N	\N	\N	\N	\N	900.000	3768.300	\N	\N	100.000	\N	\N	Aceite comestible mezcla Patito, 94% girasol, 6% maiz	149	\N	\N	\N	\N	\N	\N	\N	27.600	61.100	11.000	\N	\N	\N
209	\N	\N	t	\N	\N	\N	\N	\N	\N	900.000	3768.300	\N	\N	100.000	\N	\N	Aceite de canola	150	\N	\N	\N	\N	\N	\N	\N	55.000	33.900	6.100	\N	\N	\N
210	\N	\N	t	\N	\N	\N	\N	\N	\N	900.000	3768.300	\N	\N	100.000	\N	\N	Aceite de girasol Familiar	151	\N	\N	\N	\N	\N	\N	\N	23.000	61.700	10.900	\N	\N	\N
211	\N	\N	t	\N	\N	\N	\N	\N	\N	900.000	3768.300	\N	\N	100.000	\N	\N	Aceite de girasol Ideal	152	\N	\N	\N	\N	\N	\N	\N	27.000	62.000	11.000	\N	\N	\N
212	\N	\N	t	\N	\N	\N	\N	\N	\N	900.000	3768.300	\N	\N	100.000	\N	\N	Aceite de girasol Natura	153	\N	\N	\N	\N	\N	\N	\N	24.800	60.900	9.900	\N	\N	\N
213	\N	\N	t	\N	\N	\N	\N	\N	\N	900.000	3768.300	\N	\N	100.000	\N	\N	Aceite de maiz Arcor	154	\N	\N	\N	\N	\N	\N	\N	33.600	47.700	14.400	\N	\N	\N
214	\N	\N	t	\N	\N	\N	\N	\N	\N	900.000	3768.300	\N	Oil	100.000	\N	\N	Aceite de maiz Cocinero	155	\N	\N	\N	\N	\N	\N	\N	37.800	46.600	16.000	\N	\N	\N
215	\N	\N	t	\N	\N	\N	\N	\N	\N	900.000	3768.300	\N	\N	100.000	\N	\N	Aceite de maiz Mazzola	156	\N	\N	\N	\N	\N	\N	\N	31.800	48.700	15.200	\N	\N	\N
216	\N	\N	t	\N	\N	\N	\N	\N	\N	900.000	3768.300	\N	\N	100.000	\N	\N	Aceite de oliva Cocinero	157	\N	\N	\N	\N	\N	\N	\N	71.100	12.400	17.000	\N	\N	\N
217	\N	\N	t	\N	\N	\N	\N	\N	\N	900.000	3768.300	\N	\N	100.000	\N	\N	Aceite de uva Cocinero	158	\N	\N	\N	\N	\N	\N	\N	23.600	65.600	11.000	\N	\N	\N
218	\N	\N	t	\N	\N	0.100	\N	\N	\N	898.000	3759.900	\N	\N	99.800	\N	\N	Grasa de cerdo	159	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
219	\N	\N	t	\N	\N	0.100	\N	\N	\N	899.000	3764.100	\N	\N	99.900	\N	\N	Grasa Vacuna	160	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
220	\N	\N	t	\N	\N	16.000	\N	\N	\N	747.000	3127.700	\N	\N	83.000	\N	\N	Margarina 100% vegetal Delicia	162	\N	\N	\N	\N	\N	\N	\N	49.800	12.900	20.300	\N	\N	\N
221	\N	\N	t	\N	\N	16.000	\N	\N	\N	747.000	3127.700	\N	\N	83.000	\N	\N	Margarina 100% vegetal Manty (en pote y en pan)	161	\N	\N	\N	\N	\N	\N	\N	41.500	27.400	14.100	\N	\N	\N
222	\N	\N	t	\N	\N	42.000	\N	\N	\N	504.000	2110.200	\N	\N	56.000	\N	\N	Margarina reducida en calorias Manty liviana	163	\N	\N	\N	\N	\N	\N	\N	33.000	9.500	13.500	\N	\N	\N
223	\N	\N	t	\N	\N	71.900	\N	0.100	1.100	174.000	728.500	\N	\N	13.300	\N	\N	Huevo de codorniz, entero, crudo	350	\N	13.600	\N	\N	\N	\N	\N	5.500	1.400	4.200	\N	430.000	\N
224	\N	\N	t	\N	\N	86.800	\N	\N	0.100	54.000	226.100	\N	\N	0.300	\N	\N	Huevo de gallina, clara, cocido	347	\N	12.800	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
225	\N	\N	t	\N	\N	87.100	10.000	\N	1.100	48.000	201.000	28.000	\N	0.200	0.900	\N	Huevo de gallina, clara, cruda	345	142.000	11.600	\N	186.000	\N	\N	\N	\N	\N	\N	\N	\N	\N
226	\N	\N	t	\N	\N	74.900	56.000	0.400	1.000	156.000	653.200	213.000	\N	11.800	2.500	0.200	Huevo de gallina, entero, crudo	344	138.000	12.000	0.500	135.000	0.300	\N	\N	4.500	2.900	3.200	\N	449.000	\N
227	\N	\N	t	\N	\N	68.000	64.000	\N	1.200	196.000	820.700	256.000	\N	14.500	2.500	\N	Huevo de gallina, frito	348	176.000	16.300	\N	220.000	\N	\N	\N	\N	\N	\N	\N	\N	\N
228	\N	\N	t	\N	\N	74.600	104.000	\N	1.100	152.000	636.400	166.000	\N	10.900	3.400	\N	Huevo de gallina, poché	349	57.000	13.400	\N	183.000	\N	\N	\N	\N	\N	\N	\N	\N	\N
229	\N	\N	t	\N	\N	52.100	109.000	\N	2.600	325.000	1360.800	510.000	\N	28.700	5.900	\N	Huevo de gallina, yema, cruda	346	114.000	16.600	\N	65.000	\N	\N	\N	\N	\N	\N	\N	1315.000	\N
230	\N	\N	t	\N	\N	23.600	\N	55.800	4.500	328.000	1373.300	\N	\N	8.100	\N	\N	Leche, condensada, Nestlé	306	\N	8.000	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
231	\N	\N	t	\N	\N	90.500	\N	6.200	\N	45.000	188.400	\N	\N	1.400	\N	\N	Leche de burra, entera, fluida	296	\N	1.900	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
232	\N	\N	t	\N	\N	86.200	153.000	3.000	1.600	78.000	326.600	139.000	\N	5.900	0.300	\N	Leche de cabra, entera, fluida	297	171.000	3.300	\N	27.000	\N	\N	\N	\N	\N	\N	\N	\N	\N
233	\N	\N	t	\N	\N	82.600	207.000	4.500	0.900	99.000	414.500	123.000	\N	6.500	\N	\N	Leche de oveja, entera, fluida	298	187.000	5.500	\N	30.000	\N	\N	\N	\N	\N	\N	\N	\N	\N
234	\N	\N	t	\N	\N	88.700	\N	4.600	0.700	57.000	238.700	\N	\N	2.900	\N	\N	Leche de vaca, entera, fluida, adicionada con vitamina A	302	\N	3.100	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
235	\N	\N	t	\N	\N	88.700	123.000	4.600	0.700	57.000	238.700	95.000	\N	2.900	0.100	\N	Leche de vaca, entera, fluida, pasteurizada	301	137.000	3.100	\N	57.000	\N	\N	0.300	\N	\N	\N	\N	\N	\N
236	\N	\N	t	\N	\N	90.100	120.000	4.600	0.700	44.000	184.200	109.000	\N	1.400	0.100	\N	Leche de vaca parcialm. descremada, adic. con vit A y D	303	138.000	3.200	\N	55.000	\N	\N	0.300	\N	\N	\N	\N	\N	\N
237	\N	\N	t	\N	\N	3.200	1303.000	52.200	8.200	370.000	1549.200	1027.000	\N	1.000	0.500	\N	Leche en polvo descremada	305	1640.000	35.500	\N	563.000	\N	\N	0.300	\N	\N	\N	\N	\N	\N
238	\N	\N	t	\N	\N	2.800	821.000	40.900	5.700	489.000	2047.400	761.000	\N	24.800	0.500	\N	Leche en polvo entera	304	1224.000	25.800	\N	404.000	\N	\N	3.300	\N	\N	\N	\N	\N	\N
239	\N	\N	t	\N	\N	7.000	229.000	49.500	2.400	520.000	2177.200	110.000	\N	31.500	0.500	\N	Leche humana, entera, en polvo	300	383.000	9.600	\N	114.000	\N	\N	\N	\N	\N	\N	\N	\N	\N
240	\N	\N	t	\N	\N	87.000	32.000	7.100	0.600	71.000	297.300	14.000	\N	4.200	0.000	0.400	Leche humana, entera, fluida	299	44.000	1.100	0.000	11.000	0.000	4.400	\N	\N	\N	\N	\N	\N	\N
241	\N	\N	t	\N	\N	15.300	15.000	\N	0.200	758.000	3173.700	24.000	\N	84.000	0.200	\N	Manteca, fresca	307	15.000	0.500	\N	223.000	\N	\N	\N	\N	\N	\N	\N	\N	\N
242	\N	\N	t	\N	\N	66.200	56.000	3.900	0.600	246.000	1030.000	97.000	\N	22.600	\N	\N	Queso crema, entero, untable	308	148.000	6.600	\N	74.000	\N	\N	\N	\N	\N	\N	\N	\N	\N
243	\N	\N	t	\N	\N	78.600	116.000	6.100	1.300	82.000	343.300	198.000	\N	0.300	\N	\N	Queso descremado, untable	310	260.000	13.700	\N	106.000	\N	\N	\N	\N	\N	\N	\N	\N	\N
244	\N	\N	t	\N	\N	68.100	75.000	\N	3.800	182.000	762.000	161.000	\N	14.000	\N	\N	Queso, Petit Suisse	311	81.000	14.100	\N	30.000	\N	\N	\N	\N	\N	\N	\N	\N	\N
245	\N	\N	t	\N	\N	77.800	102.000	5.500	1.100	104.000	435.400	175.000	\N	4.000	\N	\N	Queso semidescremado, untable	309	202.000	11.500	\N	90.000	\N	\N	\N	\N	\N	\N	\N	\N	\N
246	\N	\N	t	\N	\N	77.800	102.000	5.600	1.100	104.000	435.400	175.000	\N	4.000	\N	\N	Queso  Blanco Argentino Semimagro	552	202.000	11.500	\N	90.000	\N	\N	\N	\N	\N	\N	\N	\N	\N
247	\N	\N	t	\N	\N	47.700	610.000	\N	6.700	309.000	1293.800	450.000	\N	25.300	\N	\N	Queso Belpaese	312	56.000	20.300	0.400	510.000	0.000	\N	\N	\N	\N	\N	\N	\N	\N
248	\N	\N	t	\N	\N	55.300	75.000	\N	1.600	287.000	1201.700	330.000	\N	23.000	\N	\N	Queso Camembert	313	66.000	20.100	\N	1240.000	\N	\N	\N	\N	\N	\N	\N	\N	\N
249	\N	\N	t	\N	\N	49.900	\N	4.200	3.300	302.000	1264.500	\N	\N	22.900	\N	\N	Queso cremoso	315	\N	19.700	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
250	\N	\N	t	\N	\N	50.200	625.000	3.900	3.700	291.000	1218.400	700.000	\N	21.400	\N	\N	Queso cuartirolo	316	64.000	20.800	0.900	360.000	0.000	\N	\N	\N	\N	\N	\N	\N	\N
251	\N	\N	t	\N	\N	59.500	460.000	\N	1.600	260.000	1088.600	321.000	\N	20.900	\N	\N	Queso doble crema	317	69.000	18.000	\N	500.000	\N	\N	\N	\N	\N	\N	\N	\N	\N
252	\N	\N	t	\N	\N	47.800	225.000	\N	4.100	324.000	1356.600	250.000	\N	26.300	\N	\N	Queso Limburgués	318	59.000	21.800	0.600	800.000	0.000	\N	\N	\N	\N	\N	\N	\N	\N
253	\N	\N	t	\N	\N	50.700	\N	3.300	3.100	282.000	1180.700	\N	\N	19.300	\N	\N	Queso mozarella	314	\N	23.600	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
254	\N	\N	t	\N	\N	49.800	\N	3.700	3.300	301.000	1260.300	\N	\N	22.700	\N	\N	Queso Por Salut	319	\N	20.400	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
255	\N	\N	t	\N	\N	40.200	\N	4.300	4.400	377.000	1578.500	\N	\N	31.100	\N	\N	Queso azul	550	\N	20.000	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
256	\N	\N	t	\N	\N	36.000	800.000	\N	8.000	357.000	1494.800	750.000	\N	26.500	\N	\N	Queso Cheddar	320	41.000	29.500	1.200	390.000	0.000	\N	\N	\N	\N	\N	\N	\N	\N
257	\N	\N	t	\N	\N	42.100	450.000	\N	7.100	328.000	1373.300	500.000	\N	24.900	\N	\N	Queso Chubut	321	68.000	25.900	\N	270.000	\N	\N	\N	\N	\N	\N	\N	\N	\N
258	\N	\N	t	\N	\N	36.400	765.000	\N	5.700	340.000	1423.600	450.000	\N	33.600	\N	\N	Queso Fontina	322	72.000	24.300	0.300	690.000	0.100	\N	\N	\N	\N	\N	\N	\N	\N
259	\N	\N	t	\N	\N	31.700	340.000	\N	3.000	480.000	2009.800	215.000	\N	43.700	\N	\N	Queso Gorgonzola	323	123.000	21.600	0.400	930.000	0.000	\N	\N	\N	\N	\N	\N	\N	\N
260	\N	\N	t	\N	\N	37.100	1080.000	\N	4.900	379.000	1586.900	698.000	\N	29.400	0.300	\N	Queso Gruyere	324	128.000	28.600	0.600	542.000	0.000	\N	\N	\N	\N	\N	\N	\N	\N
261	\N	\N	t	\N	\N	37.600	890.000	\N	10.100	345.000	1444.500	630.000	\N	27.200	\N	\N	Queso Holanda	325	84.000	25.100	0.300	730.000	0.100	\N	\N	\N	\N	\N	\N	\N	\N
262	\N	\N	t	\N	\N	33.700	475.000	\N	7.000	410.000	1716.700	530.000	\N	34.500	\N	\N	Queso Pategrás	326	74.000	24.800	\N	720.000	\N	\N	\N	\N	\N	\N	\N	\N	\N
263	\N	\N	t	\N	\N	37.600	200.000	\N	4.400	426.000	1783.700	250.000	\N	38.800	\N	\N	Queso Roquefort	327	74.000	19.200	0.400	1210.000	0.200	\N	\N	\N	\N	\N	\N	\N	\N
264	\N	\N	t	\N	\N	34.000	\N	1.900	4.200	404.000	1691.500	\N	\N	31.300	\N	\N	Queso Suizo	328	\N	28.600	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
265	\N	\N	t	\N	\N	41.000	340.000	\N	7.100	358.000	1498.900	272.000	\N	30.100	\N	\N	Queso Tafí	329	69.000	21.800	\N	750.000	\N	\N	\N	\N	\N	\N	\N	\N	\N
266	\N	\N	t	\N	\N	41.900	\N	\N	5.600	345.000	1444.500	\N	\N	27.000	\N	\N	Queso Tandil	330	\N	25.500	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
267	\N	\N	t	\N	\N	39.000	\N	\N	9.700	332.000	1390.100	\N	\N	25.600	\N	\N	Queso tipo Mar del Plata	331	\N	25.400	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
268	\N	\N	t	\N	\N	29.200	950.000	\N	9.600	402.000	1683.200	510.000	\N	31.500	\N	\N	Queso Goya	332	68.000	29.700	0.600	1020.000	0.100	\N	\N	\N	\N	\N	\N	\N	\N
269	\N	\N	t	\N	\N	34.300	1170.000	\N	8.600	350.000	1465.400	775.000	\N	24.400	\N	\N	Queso Parmesano	333	61.000	32.700	\N	680.000	\N	\N	\N	\N	\N	\N	\N	\N	\N
270	\N	\N	t	\N	\N	31.900	925.000	\N	6.800	391.000	1637.100	765.000	\N	29.200	\N	\N	Queso Provolone	334	72.000	32.100	0.300	1190.000	0.100	\N	\N	\N	\N	\N	\N	\N	\N
271	\N	\N	t	\N	\N	33.600	950.000	3.400	5.500	365.000	1528.300	610.000	\N	24.200	\N	\N	Queso Reggianito	335	61.000	33.400	0.300	1230.000	0.000	\N	\N	\N	\N	\N	\N	\N	\N
272	\N	\N	t	\N	\N	30.800	\N	5.000	5.100	402.000	1683.200	\N	\N	29.100	\N	\N	Queso Sardo	336	\N	30.000	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
273	\N	\N	t	\N	\N	35.100	985.000	\N	8.900	357.000	1494.800	830.000	\N	26.600	\N	\N	Queso Sbrinz	337	67.000	29.400	0.200	870.000	0.100	\N	\N	\N	\N	\N	\N	\N	\N
274	\N	\N	t	\N	\N	70.900	193.000	4.000	1.600	168.000	703.400	241.000	\N	11.800	258.000	\N	Ricota de leche entera	338	155.000	11.600	\N	146.000	\N	\N	\N	\N	\N	\N	\N	\N	\N
275	\N	\N	t	\N	\N	70.900	207.000	4.000	1.600	168.000	703.400	243.000	\N	11.700	0.400	\N	Ricotta semidescremada	551	155.000	11.600	\N	160.000	\N	\N	\N	\N	\N	\N	\N	\N	\N
276	\N	\N	t	\N	\N	88.500	110.000	5.900	1.100	59.000	247.000	125.000	\N	0.200	93.000	\N	Yogur descremado	341	177.000	4.300	\N	75.000	\N	\N	372.000	\N	\N	\N	\N	\N	\N
277	\N	\N	t	\N	\N	91.800	\N	4.100	0.800	30.000	125.600	\N	\N	0.100	\N	\N	Yogur descremado bebible	343	\N	3.300	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
278	\N	\N	t	\N	\N	86.800	247.000	7.100	1.400	48.000	201.000	188.000	\N	0.100	0.100	\N	Yogur descremado fortificado con Ca	432	200.000	4.600	\N	121.000	\N	\N	0.500	\N	\N	\N	\N	\N	\N
279	\N	\N	t	\N	\N	81.700	\N	12.700	0.600	82.000	343.300	\N	\N	2.200	\N	\N	Yogur entero bebible	342	\N	2.800	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
280	\N	\N	t	\N	\N	86.100	\N	5.300	1.000	66.000	276.300	\N	\N	3.000	\N	\N	Yogur entero natural	339	\N	4.600	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
281	\N	\N	t	\N	\N	79.800	125.000	12.400	1.000	88.000	368.500	114.000	\N	2.400	0.100	\N	Yogur entero saborizado	340	172.000	4.400	\N	59.000	\N	\N	0.400	\N	\N	\N	\N	\N	\N
282	\N	\N	t	\N	\N	50.000	\N	\N	\N	320.000	1339.800	\N	\N	32.000	\N	\N	Mayonesa reducida en calorías	357	\N	\N	\N	\N	\N	\N	\N	8.700	19.800	3.500	\N	\N	\N
283	\N	\N	t	\N	\N	10.000	\N	\N	\N	723.000	3027.200	\N	\N	79.000	\N	\N	Mayonesa Ri-k	358	\N	\N	\N	\N	\N	\N	\N	21.500	48.500	9.000	\N	\N	\N
284	\N	\N	t	\N	\N	62.500	\N	1.000	\N	245.000	1025.800	\N	\N	19.000	\N	\N	Mortadela	359	\N	17.500	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
285	\N	\N	t	\N	\N	18.500	\N	60.800	\N	288.000	1205.900	\N	Typha domingensis	3.200	\N	\N	Polen de Totora	527	\N	14.200	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
286	\N	\N	t	\N	\N	81.900	\N	0.200	1.200	72.000	301.500	\N	Genypterus blacodes	0.900	\N	\N	Abadejo, fresco, crudo, carne	164	\N	15.800	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
287	\N	\N	t	\N	\N	65.900	\N	\N	2.200	183.000	766.300	\N	Pimedolus clarias maculatus	10.900	\N	\N	Amarillo, fresco, a la parrilla, músculo dorsal	398	\N	21.300	\N	\N	\N	\N	\N	5.700	1.500	3.400	\N	\N	\N
288	\N	\N	t	\N	\N	61.300	\N	\N	2.000	233.000	974.400	\N	Pimedolus clarias maculatus	17.000	\N	\N	Amarillo, fresco, al horno, músculo dorsal	397	\N	19.900	\N	\N	\N	\N	\N	8.500	2.200	5.100	\N	\N	\N
289	\N	\N	t	\N	\N	73.700	13.000	\N	1.100	141.000	591.800	\N	Pimedolus clarias maculatus	8.000	0.600	\N	Amarillo, fresco, crudo, músculo dorsal	395	\N	17.300	\N	\N	\N	\N	\N	8.800	1.900	5.400	\N	\N	\N
290	\N	\N	t	\N	\N	59.400	\N	\N	1.900	232.000	970.300	\N	Pimedolus clarias maculatus	15.600	\N	\N	Amarillo, fresco, frito, músculo dorsal	399	\N	22.800	\N	\N	\N	\N	\N	8.600	2.200	5.100	\N	\N	\N
291	\N	\N	t	\N	\N	68.500	\N	\N	1.100	180.000	754.000	\N	Pimedolus clarias maculatus	11.700	\N	\N	Amarillo, fresco, hervido, músculo dorsal	396	\N	18.700	\N	\N	\N	\N	\N	5.300	1.400	3.100	\N	\N	\N
292	\N	\N	t	\N	\N	76.400	20.000	0.500	1.200	92.000	385.200	220.000	Pomatomus saltatrix	0.400	1.400	15.800	Anchoa, fresca, cruda, carne	165	266.000	21.500	0.500	80.000	0.200	\N	\N	\N	\N	\N	\N	\N	\N
293	\N	\N	t	\N	\N	73.000	\N	0.800	1.600	129.000	540.100	\N	Engraulis anchoita hubbs larini	5.400	\N	\N	Anchoita, fresca, cruda, carne	166	\N	19.200	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
294	\N	\N	t	\N	\N	69.500	\N	\N	1.900	128.000	537.000	\N	Pterodotas granulosus	3.700	\N	\N	Armado, fresco, al horno, músculo dorsal	403	\N	23.700	\N	\N	\N	\N	\N	1.100	0.500	0.900	\N	\N	\N
295	\N	\N	t	\N	\N	81.600	7.000	\N	1.200	75.000	314.100	\N	Pterodotas granulosus	1.500	1.400	\N	Armado, fresco, crudo, músculo dorsal	400	\N	15.400	\N	\N	\N	\N	\N	0.300	0.200	0.400	\N	\N	\N
296	\N	\N	t	\N	\N	79.900	\N	\N	1.000	103.000	430.000	\N	Pterodotas granulosus	4.900	\N	\N	Armado, fresco, crudo, músculo ventral	401	\N	14.600	\N	\N	\N	\N	\N	1.600	0.500	1.100	\N	\N	\N
297	\N	\N	t	\N	\N	70.600	\N	\N	2.200	130.000	542.900	\N	Pterodotas granulosus	4.900	\N	\N	Armado, fresco, frito, músculo dorsal	404	\N	21.400	\N	\N	\N	\N	\N	1.500	0.700	1.200	\N	\N	\N
298	\N	\N	t	\N	\N	74.600	\N	\N	1.200	102.000	426.000	\N	Pterodotas granulosus	2.100	\N	\N	Armado, fresco, hervido, músculo dorsal	402	\N	20.800	\N	\N	\N	\N	\N	0.600	0.300	0.500	\N	\N	\N
299	\N	\N	t	\N	\N	76.000	17.000	0.000	1.700	100.000	418.700	228.000	Pagrus pagrus	2.000	1.800	8.000	Besugo, fresco, crudo, carne	167	264.000	20.400	0.400	84.000	0.100	\N	3.300	\N	\N	\N	\N	\N	\N
300	\N	\N	t	\N	\N	68.600	\N	\N	2.000	150.000	627.600	\N	Leporinus obtusidens	6.100	\N	\N	Boga, fresca, a la parrilla, músculo dorsal	408	\N	23.700	\N	\N	\N	\N	\N	8.600	0.500	1.800	\N	\N	\N
301	\N	\N	t	\N	\N	67.400	\N	\N	2.400	150.000	626.500	\N	Leporinus obtusidens	5.500	\N	\N	Boga, fresca, al horno, músculo dorsal	407	\N	25.100	\N	\N	\N	\N	\N	3.500	0.600	2.000	\N	\N	\N
302	\N	\N	t	\N	\N	\N	\N	\N	\N	\N	\N	\N	Leporinus affinis	3.900	\N	\N	Boga, fresca, cruda (carne entre aleta dorsal y ventral)	168	\N	\N	\N	\N	\N	\N	\N	1.400	0.300	1.000	\N	\N	\N
303	\N	\N	t	\N	\N	68.500	\N	\N	1.200	180.000	754.700	\N	Leporinus obtusidens	11.800	\N	\N	Boga, fresca, cruda, músculo ventral	405	\N	18.500	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
304	\N	\N	t	\N	\N	65.800	\N	\N	2.400	168.000	702.500	\N	Leporinus obtusidens	7.900	\N	\N	Boga, fresca, frita, músculo dorsal	409	\N	24.300	\N	\N	\N	\N	\N	4.000	0.600	2.300	\N	\N	\N
305	\N	\N	t	\N	\N	69.400	\N	\N	1.100	158.000	663.200	\N	Leporinus obtusidens	7.500	\N	\N	Boga, fresca, hervida, músculo dorsal	406	\N	22.700	\N	\N	\N	\N	\N	3.900	0.600	2.300	\N	\N	\N
306	\N	\N	t	\N	\N	62.200	\N	\N	1.300	219.000	917.000	\N	Sarda sarda	14.500	\N	\N	Bonito, fresco, crudo, carne	169	\N	22.000	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
307	\N	\N	t	\N	\N	79.500	18.000	0.400	1.400	83.000	347.500	207.000	Urophycis brasilensis	1.200	2.100	27.200	Brótola, fresca, cruda, carne	170	282.000	17.600	0.200	82.000	0.100	2.700	\N	\N	\N	\N	\N	\N	\N
308	\N	\N	t	\N	\N	60.400	\N	0.400	1.400	232.000	971.400	\N	Pneumatophorus japonicus marplatensis	15.800	\N	\N	Caballa, fresca, cruda, carne	171	\N	22.000	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
309	\N	\N	t	\N	\N	77.600	\N	0.300	1.400	95.000	397.800	\N	Cheilodactylus bergi	2.300	\N	\N	Castañeta, fresca, cruda, carne	173	\N	18.400	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
310	\N	\N	t	\N	\N	67.400	\N	0.500	4.000	170.000	711.800	\N	Cheilodactylus bergi	11.100	\N	\N	Castañeta, fresca, cruda, entera	172	\N	17.000	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
311	\N	\N	t	\N	\N	77.000	\N	0.700	1.200	107.000	448.000	\N	Leptocephalus orbignyanus	4.000	\N	\N	Congrio, fresco, crudo, carne	174	\N	17.200	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
312	\N	\N	t	\N	\N	79.200	680.000	0.600	2.200	86.000	360.100	590.000	Sorgentinia incisa	2.200	2.000	\N	Cornalito, fresco, crudo, entero	175	296.000	16.000	\N	90.000	\N	\N	\N	\N	\N	\N	\N	\N	\N
313	\N	\N	t	\N	\N	77.000	\N	0.400	1.300	97.000	406.100	\N	Micropogonias undulatus	1.900	\N	3.100	Corvina blanca, fresca, cruda, carne	176	\N	19.500	0.200	\N	0.100	2.900	\N	\N	\N	\N	\N	\N	\N
314	\N	\N	t	\N	\N	78.800	\N	0.400	1.200	84.000	351.700	\N	Pagonias cromis	0.800	\N	\N	Corvina negra, fresca, cruda, carne	177	\N	18.800	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
315	\N	\N	t	\N	\N	79.500	\N	0.100	1.100	80.000	335.000	\N	Salminus maxilosus	0.500	\N	\N	Dorado, fresco, crudo, carne	179	\N	18.800	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
316	\N	\N	t	\N	\N	\N	\N	\N	\N	\N	\N	\N	Salminus maxilosus	2.600	\N	\N	Dorado, fresco, crudo (carne entre aleta ventral y dorsal)	178	\N	\N	\N	\N	\N	\N	\N	0.900	0.300	0.600	\N	\N	\N
317	\N	\N	t	\N	\N	81.700	\N	0.100	0.600	72.000	301.500	\N	\N	0.200	\N	\N	Gatuso, fresco, crudo, carne	180	\N	17.400	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
318	\N	\N	t	\N	\N	71.500	\N	0.200	1.300	149.000	623.900	\N	Trachurus pictatus	8.000	\N	\N	Jurel, fresco, crudo, carne	181	\N	19.000	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
319	\N	\N	t	\N	\N	80.200	\N	0.200	1.400	78.000	326.600	\N	Paralichthys spp	0.800	\N	3.500	Lenguado, fresco, crudo, carne	182	\N	17.500	0.300	\N	0.100	1.800	\N	\N	\N	\N	\N	\N	\N
320	\N	\N	t	\N	\N	72.300	\N	1.100	1.000	146.000	611.300	\N	\N	7.800	\N	\N	Lisa, fresca, cruda, carne	183	\N	17.900	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
321	\N	\N	t	\N	\N	80.200	21.000	0.100	1.200	81.000	339.100	216.000	Merluccis merluccis	1.300	1.900	1.200	Merluza, fresca, cruda, carne	184	262.000	17.100	0.300	91.000	0.100	1.100	\N	\N	\N	\N	\N	\N	\N
322	\N	\N	t	\N	\N	79.400	\N	0.500	1.200	83.000	347.500	\N	Acanthistis brasilianus	1.000	\N	\N	Mero, fresco, crudo, carne	185	\N	17.900	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
323	\N	\N	t	\N	\N	65.000	\N	\N	1.900	189.000	792.400	\N	Pimelodus albicans	11.300	\N	\N	Moncholo, fresco, al horno, músculo dorsal	413	\N	22.000	\N	\N	\N	\N	\N	4.900	1.600	3.000	\N	\N	\N
324	\N	\N	t	\N	\N	76.600	7.000	\N	1.100	112.000	468.400	\N	Pimelodus albicans	4.700	0.800	\N	Moncholo, fresco, crudo, músculo dorsal	410	\N	17.500	\N	\N	\N	\N	\N	6.300	1.600	3.700	\N	\N	\N
325	\N	\N	t	\N	\N	73.100	\N	\N	1.100	148.000	621.500	\N	Pimelodus albicans	9.100	\N	\N	Moncholo, fresco, crudo, músculo ventral	411	\N	16.700	\N	\N	\N	\N	\N	7.500	1.700	3.900	\N	\N	\N
326	\N	\N	t	\N	\N	69.500	\N	\N	0.900	187.000	781.200	\N	Pimelodus albicans	13.300	\N	\N	Moncholo, fresco, hervido, músculo dorsal	412	\N	16.700	\N	\N	\N	\N	\N	3.300	1.000	2.000	\N	\N	\N
327	\N	\N	t	\N	\N	63.400	\N	0.400	1.200	215.000	900.200	\N	Parona signata	14.800	\N	\N	Palometa, fresca, cruda, carne	186	\N	20.100	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
328	\N	\N	t	\N	\N	75.400	\N	0.300	1.300	113.000	473.100	\N	Umbrina canosal	3.900	\N	\N	Pargo, fresco, crudo, carne	187	\N	19.100	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
329	\N	\N	t	\N	\N	66.500	\N	\N	2.500	169.000	707.600	\N	Luciopimelodus pati	8.800	\N	\N	Patí, fresco, a la parrilla, músculo dorsal	416	\N	22.600	\N	\N	\N	\N	\N	3.900	1.200	2.800	\N	\N	\N
330	\N	\N	t	\N	\N	67.200	\N	\N	2.200	183.000	767.600	\N	Luciopimelodus pati	11.200	\N	\N	Patí, fresco, al horno, músculo dorsal	415	\N	20.600	\N	\N	\N	\N	\N	4.900	1.500	3.500	\N	\N	\N
331	\N	\N	t	\N	\N	78.700	18.000	0.300	1.000	90.000	376.800	201.000	Luciopimelodus pati	1.800	1.900	\N	Patí, fresco, crudo, carne	189	256.000	18.200	\N	68.000	\N	\N	\N	\N	\N	\N	\N	\N	\N
332	\N	\N	t	\N	\N	\N	\N	\N	\N	\N	\N	\N	Luciopimelodus pati	3.400	\N	\N	Patí, fresco, crudo (carne entre dorsal y ventral)	188	\N	\N	\N	\N	\N	\N	\N	1.200	0.400	0.300	\N	\N	\N
333	\N	\N	t	\N	\N	72.500	9.000	\N	1.000	161.000	673.200	\N	Luciopimelodus pati	10.800	0.900	\N	Patí, fresco, crudo, músculo dorsal	428	\N	15.900	\N	\N	\N	\N	\N	4.700	1.400	3.300	\N	\N	\N
334	\N	\N	t	\N	\N	72.900	\N	\N	1.000	159.000	665.600	\N	Luciopimelodus pati	10.900	\N	\N	Patí, fresco, crudo, músculo ventral	429	\N	15.200	\N	\N	\N	\N	\N	3.200	1.600	3.700	\N	\N	\N
335	\N	\N	t	\N	\N	60.500	\N	\N	2.200	215.000	898.500	\N	Luciopimelodus pati	13.600	\N	\N	Patí, fresco, frito, músculo dorsal	417	\N	23.000	\N	\N	\N	\N	\N	6.100	1.800	4.300	\N	\N	\N
336	\N	\N	t	\N	\N	73.800	\N	\N	1.000	133.000	556.800	\N	Luciopimelodus pati	6.100	\N	\N	Patí, fresco, hervido, músculo dorsal	414	\N	19.600	\N	\N	\N	\N	\N	2.700	0.800	1.900	\N	\N	\N
337	\N	\N	t	\N	\N	80.000	20.000	\N	1.300	77.000	322.400	210.000	\N	0.400	1.900	\N	Pejerrey agua dulce, fresco, crudo, carne	190	256.000	18.300	\N	68.000	\N	\N	\N	\N	\N	\N	\N	\N	\N
338	\N	\N	t	\N	\N	78.200	\N	0.200	1.700	86.000	360.100	\N	Atherinidas	1.200	\N	\N	Pejerrey mar, fresco, crudo, carne	191	\N	18.600	\N	\N	\N	9.000	\N	\N	\N	\N	\N	\N	\N
339	\N	\N	t	\N	\N	77.700	18.000	0.200	1.500	97.000	406.100	205.000	Cynosción striatus	2.800	2.200	4.000	Pescadilla, fresca, crudo, carne	192	279.000	17.800	0.300	90.000	0.100	1.200	\N	\N	\N	\N	\N	\N	\N
340	\N	\N	t	\N	\N	77.400	\N	\N	2.400	84.000	351.700	\N	Callorhynchus	0.400	\N	\N	Pez Gallo, fresco, crudo, carne	193	\N	20.200	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
341	\N	\N	t	\N	\N	77.400	\N	0.000	1.300	96.000	402.000	\N	Perophis brasilensis	1.700	\N	\N	Pez palo, fresco, crudo, carne	194	\N	20.100	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
342	\N	\N	t	\N	\N	76.900	\N	\N	2.000	109.000	456.400	\N	Helicolenus dactylopterus labillei	4.500	\N	\N	Rubio, fresco, crudo, carne	195	\N	17.100	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
343	\N	\N	t	\N	\N	69.500	\N	\N	2.600	130.000	543.800	\N	Prochilodus lineatus	4.000	\N	\N	Sábalo, fresco, a la parrilla, músculo dorsal	422	\N	23.400	\N	\N	\N	\N	\N	1.900	0.500	1.800	\N	\N	\N
344	\N	\N	t	\N	\N	65.200	\N	\N	3.200	153.000	638.800	\N	Prochilodus lineatus	5.800	\N	\N	Sábalo, fresco, al horno, músculo dorsal	421	\N	25.100	\N	\N	\N	\N	\N	1.800	0.500	1.700	\N	\N	\N
345	\N	\N	t	\N	\N	73.200	10.000	\N	1.200	145.000	605.700	\N	Prochilodus lineatus	8.100	0.600	\N	Sábalo, fresco, crudo, músculo dorsal	418	\N	18.000	\N	\N	\N	\N	\N	2.400	0.600	2.100	\N	\N	\N
346	\N	\N	t	\N	\N	72.400	\N	\N	1.200	151.000	632.000	\N	Prochilodus lineatus	9.000	\N	\N	Sábalo, fresco, crudo, músculo ventral	419	\N	17.500	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
347	\N	\N	t	\N	\N	65.500	\N	\N	2.600	166.000	694.000	\N	Prochilodus lineatus	7.400	\N	\N	Sábalo, fresco, frito, músculo dorsal	423	\N	24.900	\N	\N	\N	\N	\N	1.900	0.500	0.800	\N	\N	\N
348	\N	\N	t	\N	\N	73.000	\N	\N	1.200	130.000	544.400	\N	Prochilodus lineatus	5.300	\N	\N	Sábalo, fresco, hervido, músculo dorsal	420	\N	20.500	\N	\N	\N	\N	\N	1.500	0.800	1.500	\N	\N	\N
349	\N	\N	t	\N	\N	70.200	\N	\N	6.900	136.000	569.400	\N	Fueguine sardine	8.900	\N	\N	Sardina fueguina, fresca, cruda, carne	196	\N	14.000	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
350	\N	\N	t	\N	\N	55.300	\N	\N	3.200	255.000	1067.500	\N	Pseudoplastistoma coruscans	17.900	\N	\N	Surubí, fresco, al horno, músculo dorsal	426	\N	23.500	\N	\N	\N	\N	\N	7.800	2.500	5.500	\N	\N	\N
351	\N	\N	t	\N	\N	76.500	20.000	0.200	1.100	110.000	460.600	203.000	\N	4.000	1.900	\N	Surubí, fresco, crudo, carne	199	276.000	18.200	\N	72.000	\N	\N	\N	\N	\N	\N	\N	\N	\N
352	\N	\N	t	\N	\N	\N	\N	\N	\N	\N	\N	\N	Pseudoplastistoma coruscans	0.900	\N	\N	Surubí, fresco, crudo, carne zona dorsal	198	\N	\N	\N	\N	\N	\N	\N	1.200	1.200	1.200	\N	\N	\N
353	\N	\N	t	\N	\N	\N	\N	\N	\N	\N	\N	\N	Pseudoplastistoma coruscans	1.700	\N	\N	Surubí, fresco, crudo, carne zona ventral	197	\N	\N	\N	\N	\N	\N	\N	0.700	0.400	0.200	\N	\N	\N
354	\N	\N	t	\N	\N	68.300	1.000	\N	1.100	187.000	784.700	\N	Pseudoplastistoma coruscans	13.000	0.300	\N	Surubí, fresco, crudo, músculo dorsal	424	\N	17.600	\N	\N	\N	\N	\N	3.300	1.300	2.700	\N	\N	\N
355	\N	\N	t	\N	\N	51.500	\N	\N	3.700	269.000	1124.700	\N	Pseudoplastistoma coruscans	18.000	\N	\N	Surubí, fresco, frito, músculo dorsal	427	\N	26.700	\N	\N	\N	\N	\N	7.500	2.400	5.300	\N	\N	\N
356	\N	\N	t	\N	\N	65.100	\N	\N	1.200	186.000	780.500	\N	Pseudoplastistoma coruscans	10.300	\N	\N	Surubí, fresco, hervido, músculo dorsal	425	\N	23.400	\N	\N	\N	\N	\N	4.500	1.400	3.200	\N	\N	\N
357	\N	\N	t	\N	\N	79.900	\N	0.400	1.000	79.000	330.800	\N	\N	0.600	\N	\N	Tararira, fresca, cruda, carne	200	\N	18.100	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
358	\N	\N	t	\N	\N	77.000	\N	0.200	1.500	98.000	410.300	\N	Prionotus punctatus	2.400	\N	\N	Testolin, fresco, crudo, carne	201	\N	18.900	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
359	\N	\N	t	\N	\N	79.300	\N	\N	1.700	79.000	330.800	\N	Illex ilexebrosus	0.600	\N	\N	Calamar, fresco, crudo (tubo aletas y tentáculos)	203	\N	18.400	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
360	\N	\N	t	\N	\N	79.100	\N	\N	1.700	80.000	335.000	\N	Illex ilexebrosus	0.700	\N	\N	Calamar, fresco, entero, crudo	202	\N	18.500	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
361	\N	\N	t	\N	\N	76.600	\N	0.000	1.600	91.000	381.000	\N	Artemesia longinaris	0.800	\N	\N	Camarón, fresco, crudo, carne de cola	204	\N	21.000	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
362	\N	\N	t	\N	\N	83.900	\N	0.000	1.600	66.000	276.300	\N	Lithodes antarcticus	1.100	\N	\N	Centolla, fresca, carne, cruda	205	\N	13.900	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
363	\N	\N	t	\N	\N	78.400	\N	0.000	1.900	83.000	347.500	\N	Lithodes antarcticus	0.800	\N	\N	Centolla, fresca (carne de pata solamente)	206	\N	18.800	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
364	\N	\N	t	\N	\N	75.300	\N	0.200	1.700	97.000	406.100	\N	Hymenopenaeus multeri	0.900	\N	\N	Langostino, fresco, crudo, carne de cola	207	\N	22.000	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
365	\N	\N	t	\N	\N	77.900	\N	2.500	3.000	95.000	397.800	\N	Mytilus platensis spp	1.600	\N	\N	Mejillón, fresco, crudo (capturado en primavera)	209	\N	17.600	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
366	\N	\N	t	\N	\N	83.000	88.000	1.700	2.300	64.000	268.000	236.000	Mytilus platensis spp	1.100	5.800	2.900	Mejillón, fresco, crudo, carne	208	315.000	11.900	0.300	289.000	0.000	\N	\N	\N	\N	\N	\N	\N	\N
367	\N	\N	t	\N	\N	72.800	\N	\N	\N	84.000	351.700	\N	\N	\N	\N	\N	Mejillón, fresco, pre-cocido, carne	210	\N	21.100	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
368	\N	\N	t	\N	\N	56.500	\N	4.300	1.200	202.000	845.800	\N	\N	11.600	\N	\N	Ancho, pasta	211	\N	20.200	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
369	\N	\N	t	\N	\N	62.500	\N	\N	2.300	212.000	887.600	\N	Scomber japonicus marplatensis	11.800	\N	\N	Caballa, tronco	212	\N	26.500	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
370	\N	\N	t	\N	\N	31.700	24.000	65.000	2.300	263.000	1101.200	35.000	\N	0.100	0.700	\N	Batata, dulce	351	231.000	0.900	\N	19.000	\N	\N	\N	\N	\N	\N	\N	\N	\N
371	\N	\N	t	\N	\N	0.500	175.000	62.400	0.200	549.000	2298.700	215.000	\N	31.500	1.700	5.400	Chocolatín	353	487.000	5.400	1.200	93.000	0.900	\N	\N	\N	\N	\N	\N	\N	\N
372	\N	\N	t	\N	\N	22.000	\N	73.100	1.000	306.000	1281.200	\N	\N	0.200	\N	0.100	Ciruela, mermelada	352	\N	3.700	0.100	\N	0.000	1.800	\N	\N	\N	\N	\N	\N	\N
373	\N	\N	t	\N	\N	28.000	253.000	57.400	1.500	314.000	1314.700	176.000	\N	6.600	0.400	\N	Dulce de leche	549	265.000	6.500	\N	138.000	\N	\N	0.700	\N	\N	\N	\N	\N	\N
374	\N	\N	t	\N	\N	28.500	228.000	52.900	1.500	260.000	1088.500	182.000	\N	1.600	0.300	\N	Dulce de Leche Light	546	240.000	6.200	\N	142.000	\N	\N	0.700	\N	\N	\N	\N	\N	\N
375	\N	\N	t	\N	\N	28.500	279.000	55.000	1.700	317.000	1327.300	219.000	\N	7.500	0.600	\N	Dulce de leche para reposteria	548	371.000	7.300	\N	141.000	\N	\N	87.000	\N	\N	\N	\N	\N	\N
376	\N	\N	t	\N	\N	24.400	209.000	7.900	1.300	337.000	1411.000	146.000	\N	7.900	1.600	\N	Dulce de leche repostero suelto	547	272.000	5.300	\N	138.000	\N	\N	0.800	\N	\N	\N	\N	\N	\N
377	\N	\N	t	\N	\N	20.000	\N	76.400	0.000	304.000	1272.800	\N	\N	0.100	\N	0.200	Durazno, mermelada	354	\N	3.500	0.000	\N	0.000	\N	\N	\N	\N	\N	\N	\N	\N
378	\N	\N	t	\N	\N	22.000	\N	73.200	0.400	309.000	1293.800	\N	\N	0.600	\N	\N	Frutilla, mermelada	355	\N	3.800	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
379	\N	\N	t	\N	\N	24.300	322.000	56.800	1.800	341.000	1427.800	257.000	\N	9.000	0.300	\N	Leche, dulce de leche	356	393.000	8.100	1.000	122.000	0.000	\N	\N	\N	\N	\N	\N	\N	\N
380	\N	\N	t	\N	\N	90.600	101.000	\N	2.000	15.000	62.000	41.000	Beta vulgaris cycla	0.200	1.800	0.500	Acelga, hoja	494	493.000	2.900	0.140	235.000	0.089	21.100	0.400	\N	\N	\N	0.400	\N	3.900
381	\N	\N	t	\N	\N	94.000	53.000	\N	2.000	8.000	33.000	23.000	Beta vulgaris cycla	0.100	0.340	\N	Acelga, tallo	495	470.000	1.200	\N	150.000	\N	\N	0.200	\N	\N	\N	0.600	\N	2.900
382	\N	\N	t	\N	\N	86.500	69.000	7.700	1.800	46.000	193.000	29.000	Hipochaeris sp.	1.200	2.570	\N	Achicoria de Monte	499	260.000	2.800	\N	\N	\N	9.900	\N	\N	\N	\N	\N	\N	\N
383	\N	\N	t	\N	\N	94.200	18.000	2.900	1.000	21.000	88.000	21.000	Cichorium intybus	0.300	0.690	\N	Achicoria, hoja, fresca, cruda	50	182.000	1.600	\N	7.000	\N	49.300	\N	\N	\N	\N	\N	\N	\N
384	\N	\N	t	\N	\N	88.800	36.000	7.900	1.330	34.000	142.000	53.000	Canna coccinea	0.200	0.770	\N	Achira (raíces)	498	677.000	1.700	\N	\N	\N	5.600	\N	\N	\N	\N	\N	\N	\N
385	\N	\N	t	\N	\N	74.200	\N	20.000	1.200	99.000	415.000	\N	Alium satyvum	0.200	\N	0.700	Ajo, bulbo, fresco, crudo	51	\N	4.400	0.061	\N	0.296	8.800	\N	\N	\N	\N	\N	\N	\N
386	\N	\N	t	\N	\N	83.700	40.000	11.900	1.100	63.000	264.000	94.000	Cynara scolymus	0.400	1.890	0.800	Alcaucil, inflorescencia, fresco, crudo	52	\N	2.900	\N	\N	0.050	21.700	\N	\N	\N	\N	\N	\N	\N
387	\N	\N	t	\N	\N	80.600	525.000	6.800	5.600	57.000	239.000	155.000	Medicago sativa	0.400	3.890	1.700	Alfalfa, hoja, fresca, cruda	53	976.000	6.600	0.347	12.000	0.256	183.600	\N	\N	\N	\N	\N	\N	\N
388	\N	\N	t	\N	\N	71.200	21.000	16.600	3.300	102.000	427.000	129.000	Pisum sativum L.	\N	1.630	1.200	Arveja, semilla, fresca, cruda	54	395.000	8.900	0.158	38.000	0.210	24.200	\N	\N	\N	\N	\N	\N	\N
389	\N	\N	t	\N	\N	70.400	54.000	\N	1.100	105.000	440.000	67.000	\N	0.800	1.500	2.900	Arveja, semilla, fresca, enlatada	56	155.000	6.000	0.087	88.000	0.086	2.200	1.500	\N	\N	\N	18.300	\N	3.400
390	\N	\N	t	\N	\N	79.400	17.000	13.400	1.400	77.000	322.000	69.000	\N	\N	1.130	\N	Arveja, semilla, fresca, hervida	55	159.000	5.800	\N	20.000	\N	6.700	\N	\N	\N	\N	\N	\N	\N
391	\N	\N	t	\N	\N	11.600	52.000	\N	2.560	304.000	1273.000	340.000	Pisum sativum L.	2.900	4.300	\N	Arveja, semilla, seca, entera, cruda	57	1096.000	22.500	\N	14.000	\N	\N	4.200	\N	\N	\N	46.900	\N	13.500
392	\N	\N	t	\N	\N	11.100	51.000	\N	2.650	311.000	1302.000	349.000	\N	2.900	4.500	\N	Arveja, semilla, seca, partida, cruda	58	988.000	22.000	\N	16.000	\N	\N	3.700	\N	\N	\N	49.100	\N	12.200
393	\N	\N	t	\N	\N	68.000	17.000	22.500	0.600	129.000	540.000	91.000	\N	0.700	2.500	\N	Arveja, semilla, seca, partida, hervida	59	215.000	8.200	\N	7.000	\N	\N	\N	\N	\N	\N	\N	\N	\N
394	\N	\N	t	\N	\N	6.000	287.000	17.700	2.700	668.000	2797.000	354.000	Corylus, avellana	60.900	4.100	5.000	Avellana, pepita, seca	60	618.000	12.700	0.428	19.000	0.520	\N	\N	\N	\N	\N	\N	\N	\N
395	\N	\N	t	\N	\N	54.000	50.000	35.000	2.100	212.000	888.000	90.000	Ipomaea batatas Lam	7.200	0.900	\N	Batata, frita	63	819.000	1.700	\N	19.000	\N	\N	\N	\N	\N	\N	\N	\N	\N
396	\N	\N	t	\N	\N	76.100	32.000	21.700	1.000	92.000	385.000	66.000	Ipomaea batatas Lam	\N	0.420	\N	Batata, hervida	62	516.000	1.200	\N	6.000	\N	10.000	\N	\N	\N	\N	\N	\N	\N
397	\N	\N	t	\N	\N	78.000	34.000	19.800	1.100	84.000	352.000	64.000	Ipomaea batatas Lam	\N	0.250	1.100	Batata, raiz, fresca, cruda	61	417.000	1.100	0.140	6.000	0.103	20.100	\N	\N	\N	\N	\N	\N	\N
398	\N	\N	t	\N	\N	92.700	10.000	5.500	0.500	28.000	117.000	12.000	Solaun melongena	0.200	0.390	1.800	Berenjena, pulpa, fresca, cruda	64	238.000	1.100	0.479	3.000	0.118	2.200	\N	\N	\N	\N	\N	\N	\N
399	\N	\N	t	\N	\N	93.600	222.000	3.300	1.100	23.000	96.000	52.000	Nasturtium officinale R. Br.	0.300	1.620	0.600	Berro (hojas y tallo), fresco, crudo	65	314.000	1.700	0.207	60.000	0.118	111.300	\N	\N	\N	\N	\N	\N	\N
400	\N	\N	t	\N	\N	89.900	\N	5.500	1.100	37.000	155.000	\N	Brassica oleracea itálica Plank	0.200	\N	0.700	Brócoli, tallo de hoja, fresco, crudo	66	\N	3.300	0.165	\N	0.076	93.300	\N	\N	\N	\N	\N	\N	\N
401	\N	\N	t	\N	\N	91.800	150.000	4.400	2.200	25.000	105.000	40.000	Cynara Cardundulus	0.200	3.090	0.100	Cardo (penca y hojas), fresco, crudo	67	318.000	1.400	0.055	86.000	0.018	1.800	\N	\N	\N	\N	\N	\N	\N
402	\N	\N	t	\N	\N	3.000	161.000	2.400	4.400	731.000	3061.000	573.000	Bertholletia exceisa	72.100	1.510	\N	Castaña de Pará, pepita, cruda	68	1344.000	18.100	\N	100.000	\N	\N	\N	\N	\N	\N	\N	\N	\N
403	\N	\N	t	\N	\N	94.700	26.000	3.500	1.000	17.000	71.000	20.000	Allium cepa	\N	0.580	0.300	Cebolla blanca, bulbo, cruda	69	100.000	0.800	0.070	26.000	0.060	9.100	\N	\N	\N	\N	\N	\N	\N
404	\N	\N	t	\N	\N	97.400	12.000	1.800	0.200	10.000	42.000	14.000	Alllium cepa	\N	\N	\N	Cebolla blanca, bulbo, hervida	70	87.000	0.600	\N	26.000	\N	\N	\N	\N	\N	\N	\N	\N	\N
405	\N	\N	t	\N	\N	91.600	32.000	3.200	2.800	22.000	92.000	100.000	Phaseolus vulgaris	\N	2.800	0.700	Chaucha, vaina y semilla, cruda	72	247.000	2.400	0.280	23.000	0.048	19.600	\N	\N	\N	\N	\N	\N	\N
406	\N	\N	t	\N	\N	91.700	25.000	4.900	0.800	31.000	130.000	65.000	Brassica oleracea Acephala DC	0.200	0.900	0.500	Coliflor, pimpollo, fresco, crudo	71	313.000	2.400	0.080	41.000	0.137	59.300	\N	\N	\N	\N	\N	\N	\N
407	\N	\N	t	\N	\N	88.800	72.000	6.600	1.630	33.000	137.000	63.000	Taraxacum  officinale	0.400	1.900	\N	Diente de león, hoja	539	350.000	2.600	\N	\N	\N	4.500	\N	\N	\N	\N	\N	\N	\N
408	\N	\N	t	\N	\N	93.300	44.000	4.000	0.900	24.000	101.000	67.000	Cichorioum endivia	0.200	2.770	0.400	Escarola crespa, hoja, cruda	73	381.000	1.600	0.035	10.000	0.026	11.100	\N	\N	\N	\N	\N	\N	\N
409	\N	\N	t	\N	\N	93.000	25.000	3.900	0.700	26.000	109.000	39.000	Asparagus officinalis	0.200	1.000	0.400	Esparrago, tallo tierno, fresco, crudo	74	196.000	2.200	0.162	7.000	0.186	16.500	\N	\N	\N	\N	\N	\N	\N
410	\N	\N	t	\N	\N	92.300	95.000	2.000	1.800	24.000	101.000	92.000	Spinacia oleracea	\N	3.080	\N	Espinaca, hoja, fresca, cruda	75	918.000	3.900	0.210	36.000	0.098	57.000	\N	\N	\N	\N	\N	\N	\N
411	\N	\N	t	\N	\N	96.000	32.000	0.700	0.800	13.000	54.000	47.000	\N	\N	1.050	\N	Espinaca, hoja, fresca, hervida	76	274.000	2.500	\N	18.000	\N	23.700	\N	\N	\N	\N	\N	\N	\N
412	\N	\N	t	\N	\N	70.000	35.000	20.200	1.500	125.000	523.000	158.000	Cicer arietinum	2.200	2.500	\N	Garbanzo, grano entero, seco, hervido	77	333.000	6.100	\N	8.000	\N	\N	\N	\N	\N	\N	\N	\N	\N
413	\N	\N	t	\N	\N	73.400	36.000	16.300	2.800	99.000	415.000	157.000	Vicia faba	0.800	1.390	0.800	Habas, semilla inmadura, fresca, cruda	78	502.000	6.700	0.152	12.000	0.200	38.300	\N	\N	\N	\N	\N	\N	\N
414	\N	\N	t	\N	\N	92.800	\N	3.600	1.500	24.000	101.000	\N	Foeniculum vulgare Gaerth	0.200	\N	0.300	Hinojo, tallo, fresco, crudo	79	\N	1.900	0.036	\N	0.036	15.900	\N	\N	\N	\N	\N	\N	\N
415	\N	\N	t	\N	\N	87.100	50.000	7.600	1.460	43.000	178.000	38.000	Rumex spp.	0.800	1.200	\N	Lengua de vaca, hojas, tejido fresco, parte comestible	540	315.000	3.100	\N	\N	\N	48.900	\N	\N	\N	\N	\N	\N	\N
416	\N	\N	t	\N	\N	10.900	46.000	64.800	2.700	350.000	1465.000	265.000	Lens esculenta	0.800	3.860	1.500	Lenteja, semilla entera, seca, cruda	80	1104.000	20.800	0.189	12.000	0.385	\N	\N	\N	\N	\N	\N	\N	\N
417	\N	\N	t	\N	\N	9.500	\N	39.500	3.250	399.000	1671.000	\N	Lupinus mutabilis sweet	10.000	\N	\N	Lupino andino, con cáscara, semilla, crudo	492	\N	37.800	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
418	\N	\N	t	\N	\N	8.200	\N	38.300	3.430	411.000	1723.000	\N	Lupinus mutabilis sweet	11.600	\N	\N	Lupino andino, sin cáscara, semilla, crudo	493	\N	38.400	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
419	\N	\N	t	\N	\N	5.100	128.000	11.100	6.300	576.000	2412.000	491.000	Arachis Hypogea	44.300	4.060	22.000	Maní, semilla con piel, crudo	81	737.000	33.200	0.272	11.000	0.668	\N	\N	\N	\N	\N	\N	\N	\N
420	\N	\N	t	\N	\N	3.000	146.000	10.800	5.900	592.000	2479.000	530.000	\N	45.500	2.680	18.000	Maní, semilla sin piel, tostado	82	725.000	34.800	0.249	11.000	0.325	\N	\N	\N	\N	\N	\N	\N	\N
421	\N	\N	t	\N	\N	87.200	\N	5.300	1.900	51.000	214.000	\N	Lepidium sativum	1.400	\N	1.300	Mastuerzo (hoja y pecíolo), fresco, crudo	83	\N	4.200	0.156	\N	0.093	66.800	\N	\N	\N	\N	\N	\N	\N
422	\N	\N	t	\N	\N	84.600	172.000	8.100	2.200	50.000	209.000	46.000	Coronupos didimus	1.400	3.980	\N	Mastuerzo, hoja	501	276.000	3.700	\N	\N	\N	11.500	\N	\N	\N	\N	\N	\N	\N
423	\N	\N	t	\N	\N	93.900	72.000	1.900	3.400	11.000	46.000	31.000	\N	\N	\N	\N	Nabo, hervido	85	168.000	0.800	\N	23.000	\N	\N	\N	\N	\N	\N	\N	\N	\N
424	\N	\N	t	\N	\N	96.000	28.000	1.500	1.500	10.000	42.000	16.000	Brassica rapa L.	\N	0.560	0.400	Nabo, raiz (pulpa), fresco, crudo	84	304.000	1.000	0.020	28.000	0.043	44.500	\N	\N	\N	\N	\N	\N	\N
425	\N	\N	t	\N	\N	3.500	61.000	13.200	2.000	715.000	2994.000	510.000	Juglans regia	67.400	2.350	5.100	Nuez, pepita	86	687.000	13.900	0.442	3.000	0.152	\N	\N	\N	\N	\N	\N	\N	\N
426	\N	\N	t	\N	\N	78.000	36.000	19.300	0.500	88.000	369.000	72.000	Solanum tuberosum	\N	0.860	1.900	Papa, pulpa sin cáscara, fresca, cruda	87	493.000	2.700	0.106	24.000	0.130	21.200	\N	\N	\N	\N	\N	\N	\N
427	\N	\N	t	\N	\N	65.800	14.000	23.600	1.500	162.000	678.000	79.000	\N	6.200	0.440	\N	Papa, pulpa sin cáscara, frita, bastón	89	510.000	2.900	\N	35.000	\N	14.400	\N	\N	\N	\N	\N	\N	\N
428	\N	\N	t	\N	\N	78.000	21.000	19.600	0.200	88.000	369.000	69.000	\N	\N	1.840	\N	Papa, pulpa sin cáscara, hervida	88	405.000	2.400	\N	17.000	\N	4.900	\N	\N	\N	\N	\N	\N	\N
429	\N	\N	t	\N	\N	96.100	23.000	2.700	0.400	15.000	63.000	24.000	Cucumis sativus	0.100	0.300	0.100	Pepino, pulpa, fresco, crudo	90	141.000	0.700	0.057	13.000	0.044	6.100	\N	\N	\N	\N	\N	\N	\N
430	\N	\N	t	\N	\N	83.900	\N	9.000	2.400	60.000	251.000	\N	Petroselium sativus Hoffm	1.000	\N	0.300	Perejil, hoja, fresco, crudo	91	\N	3.700	0.054	\N	0.096	282.000	\N	\N	\N	\N	\N	\N	\N
431	\N	\N	t	\N	\N	42.400	17.000	37.900	3.900	221.000	925.000	181.000	\N	1.200	1.710	14.400	Piñon de araucaria, pepita, crudo	92	305.000	14.600	0.221	5.000	0.403	\N	\N	\N	\N	\N	\N	\N	\N
432	\N	\N	t	\N	\N	4.200	\N	18.100	1.400	648.000	2713.000	\N	Pistacia Vera	54.000	\N	\N	Pistacho, pepita, crudo	93	\N	22.300	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
433	\N	\N	t	\N	\N	12.700	\N	62.800	3.970	337.000	1411.000	468.000	Phaseolus vulgaris	0.800	11.410	\N	Poroto Alubia, semilla, seco	528	\N	19.800	\N	\N	\N	\N	2.500	\N	\N	\N	\N	\N	\N
434	\N	\N	t	\N	\N	13.300	\N	62.000	3.870	336.000	1407.000	295.000	Phaseolus vulgaris	0.900	8.910	\N	Poroto Carioca, semilla, seco	530	\N	20.000	\N	\N	\N	\N	3.000	\N	\N	\N	\N	\N	\N
435	\N	\N	t	\N	\N	13.200	\N	61.000	5.000	333.000	1394.000	542.000	Phaseolus vulgaris	1.200	13.760	\N	Poroto Colorado, semilla, seco	529	\N	19.600	\N	\N	\N	\N	3.600	\N	\N	\N	\N	\N	\N
436	\N	\N	t	\N	\N	13.400	\N	60.400	3.790	336.000	1407.000	440.000	Phaseolus vulgaris	1.000	17.700	\N	Poroto Grand Berry, semilla, seco	531	\N	21.500	\N	\N	\N	\N	3.200	\N	\N	\N	\N	\N	\N
437	\N	\N	t	\N	\N	13.000	\N	60.600	4.890	326.000	1365.000	478.000	Phaseolus vulgaris	0.500	9.800	\N	Poroto Great Northern, semilla, seco	532	\N	21.000	\N	\N	\N	\N	3.600	\N	\N	\N	\N	\N	\N
438	\N	\N	t	\N	\N	12.900	\N	61.500	4.090	306.000	1281.000	418.000	Phaseolus vulgaris	1.000	15.900	\N	Poroto Negro, semilla, seco	533	\N	20.600	\N	\N	\N	\N	3.500	\N	\N	\N	\N	\N	\N
439	\N	\N	t	\N	\N	13.800	\N	55.600	3.460	336.000	1407.000	334.000	Phaseolus vulgaris	1.100	22.890	\N	Poroto Novy Bean, semilla, seco	534	\N	26.000	\N	\N	\N	\N	3.200	\N	\N	\N	\N	\N	\N
440	\N	\N	t	\N	\N	12.700	\N	63.700	4.350	328.000	1373.000	460.000	Phaseolus vulgaris	1.100	9.500	\N	Poroto Oval, semilla, seco	535	\N	18.200	\N	\N	\N	\N	3.900	\N	\N	\N	\N	\N	\N
441	\N	\N	t	\N	\N	14.200	\N	63.300	5.260	322.000	1348.000	577.000	Phaseolus vulgaris	0.600	\N	\N	Poroto Pallares, semilla, seco	536	\N	16.600	\N	\N	\N	\N	6.100	\N	\N	\N	\N	\N	\N
442	\N	\N	t	\N	\N	13.700	\N	56.700	3.450	336.000	1407.000	442.000	Phaseolus vulgaris	0.800	14.560	\N	Poroto Small Red, semilla, seco	537	\N	25.300	\N	\N	\N	\N	2.500	\N	\N	\N	\N	\N	\N
443	\N	\N	t	\N	\N	70.600	49.000	\N	1.500	89.000	373.000	105.000	Phaseolus vulgaris	0.900	1.700	\N	Poroto, semilla, enlatado	95	366.000	8.400	\N	92.000	\N	\N	1.300	\N	\N	\N	11.900	\N	6.700
444	\N	\N	t	\N	\N	11.700	125.000	\N	3.200	290.000	1214.000	352.000	Phaseolus vulgaris	2.800	8.200	1.700	Poroto, semilla, seco, crudo	94	1710.000	23.900	0.185	8.000	0.399	\N	2.700	\N	\N	\N	42.300	\N	16.100
445	\N	\N	t	\N	\N	88.200	58.000	7.900	1.000	45.000	188.000	6.000	Allium porrum	0.400	0.650	0.500	Puerro (bulbo, tallo y hojas), fresco, crudo	96	199.000	2.500	0.030	81.000	0.111	10.200	\N	\N	\N	\N	\N	\N	\N
446	\N	\N	t	\N	\N	13.700	94.000	78.700	2.200	341.000	1428.000	97.000	\N	1.000	7.460	\N	Quinua, harina	98	\N	4.400	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
447	\N	\N	t	\N	\N	11.700	171.000	63.300	6.100	354.000	1482.000	122.000	Chenopodium quinoa vild	5.100	9.500	3.000	Quinua, semilla, cruda	97	394.000	13.800	0.199	6.000	0.089	0.500	\N	\N	\N	\N	\N	\N	\N
448	\N	\N	t	\N	\N	91.800	\N	5.800	1.000	29.000	121.000	\N	Raphanus sativus	0.100	\N	0.500	Rabanito, raiz, fresco, crudo	99	\N	1.300	\N	\N	0.067	17.700	\N	\N	\N	\N	\N	\N	\N
449	\N	\N	t	\N	\N	90.000	138.000	\N	\N	\N	\N	64.000	Cichorium intybus	\N	1.710	\N	Radicheta, hoja, fresco, cruda	100	339.000	2.200	\N	97.000	\N	14.800	\N	\N	\N	\N	\N	\N	\N
450	\N	\N	t	\N	\N	85.600	13.000	11.100	0.900	54.000	226.000	46.000	Beta Vulgaris	\N	2.860	0.700	Remolacha, tubérculo, fresca, cruda	101	399.000	2.400	0.053	51.000	0.065	9.400	\N	\N	\N	\N	\N	\N	\N
451	\N	\N	t	\N	\N	90.300	11.000	7.900	0.800	36.000	151.000	39.000	Beta Vulgaris	\N	1.820	\N	Remolacha, tubérculo, hervida	102	338.000	1.000	\N	63.000	\N	\N	\N	\N	\N	\N	\N	\N	\N
452	\N	\N	t	\N	\N	84.900	\N	8.900	1.300	58.000	243.000	\N	Brassica oleracea gemmifera	0.500	\N	\N	Repollito Bruselas, hoja, fresco, crudo	103	\N	4.400	\N	\N	\N	136.000	\N	\N	\N	\N	\N	\N	\N
453	\N	\N	t	\N	\N	94.000	\N	1.900	1.700	17.000	71.000	\N	Brassica oleracea capitata	\N	\N	\N	Repollo blanco, hoja, fresco, crudo	104	\N	2.400	0.160	\N	0.102	23.000	\N	\N	\N	\N	\N	\N	\N
454	\N	\N	t	\N	\N	95.000	47.000	1.800	1.000	16.000	67.000	40.000	Brassica oleracea capitata	\N	1.270	\N	Repollo blanco, hoja, hervido	105	126.000	2.200	\N	11.000	\N	27.400	\N	\N	\N	\N	\N	\N	\N
455	\N	\N	t	\N	\N	79.100	\N	15.500	0.900	85.000	356.000	\N	Trapogon porrifolium	1.000	\N	0.700	Salsifí, raiz, fresco, crudo	106	\N	3.500	0.068	\N	0.058	4.900	\N	\N	\N	\N	\N	\N	\N
456	\N	\N	t	\N	\N	10.200	\N	39.800	6.290	368.000	1541.000	695.000	Glycine max	6.800	7.610	\N	Soja FT11, poroto seco	538	\N	36.900	\N	\N	\N	\N	4.200	\N	\N	\N	\N	\N	\N
457	\N	\N	t	\N	\N	9.600	175.000	\N	4.410	356.000	1491.000	498.000	Glycine max. L	24.200	7.600	\N	Soja, semilla madura, seca, cruda	107	2008.000	34.600	\N	7.000	\N	\N	3.700	\N	\N	\N	11.200	\N	16.000
458	\N	\N	t	\N	\N	14.800	\N	82.000	1.200	336.000	1407.000	\N	\N	\N	\N	\N	Tapioca, cruda (harina mandioca)	108	\N	2.000	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
459	\N	\N	t	\N	\N	85.700	\N	13.700	0.500	55.000	230.000	\N	\N	\N	\N	\N	Tapioca, hervida	109	\N	0.100	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
460	\N	\N	t	\N	\N	94.000	9.000	4.100	0.900	20.000	84.000	43.000	Licopersicum sculentum	\N	1.670	0.400	Tomate, fresco, crudo	110	267.000	1.000	0.067	5.000	0.071	18.100	\N	\N	\N	\N	\N	\N	\N
461	\N	\N	t	\N	\N	94.000	5.000	4.200	0.800	21.000	88.000	28.000	Licopersicum sculentum	\N	1.840	\N	Tomate, hervido	111	307.000	1.000	\N	7.000	\N	9.700	\N	\N	\N	\N	\N	\N	\N
462	\N	\N	t	\N	\N	96.000	2.000	1.700	1.300	11.000	46.000	44.000	Licopersicum sculentum	\N	0.710	\N	Tomate, jugo, fresco	112	338.000	1.000	\N	8.000	\N	\N	\N	\N	\N	\N	\N	\N	\N
463	\N	\N	t	\N	\N	89.500	84.000	5.700	1.700	32.000	134.000	41.000	Portulaca oleracea	0.500	3.020	\N	Verdolaga, hoja	500	332.000	2.400	\N	\N	\N	11.000	\N	\N	\N	\N	\N	\N	\N
464	\N	\N	t	\N	\N	93.200	\N	3.300	1.500	23.000	96.000	\N	Portulaca oleracea	0.400	\N	1.200	Verdolaga, hoja y tallo, fresca, cruda	113	\N	1.600	0.139	\N	0.062	12.300	\N	\N	\N	\N	\N	\N	\N
465	\N	\N	t	\N	\N	81.000	274.000	11.100	3.160	60.000	249.000	46.000	Amarantus quitensis	0.700	6.400	\N	Yuyo colorado, hoja	541	293.000	4.100	\N	\N	\N	25.700	\N	\N	\N	\N	\N	\N	\N
466	\N	\N	t	\N	\N	94.000	14.000	4.400	0.600	22.000	92.000	47.000	\N	\N	0.300	\N	Zanahoria, jugo, fresco	116	305.000	1.000	\N	53.000	\N	\N	\N	\N	\N	\N	\N	\N	\N
467	\N	\N	t	\N	\N	86.000	37.000	12.000	0.900	\N	\N	46.000	Daucus carota	\N	0.470	0.300	Zanahoria, raiz, pelada, fresca	114	366.000	1.100	0.069	22.000	0.080	3.900	\N	\N	\N	\N	\N	\N	\N
468	\N	\N	t	\N	\N	\N	34.000	\N	\N	\N	\N	37.000	Daucus carota	\N	1.360	\N	Zanahoria, raiz, pelada, hervida	115	284.000	\N	\N	22.000	\N	1.000	\N	\N	\N	\N	\N	\N	\N
469	\N	\N	t	\N	\N	96.000	24.000	2.400	0.800	13.000	54.000	33.000	\N	\N	1.510	\N	Zapallito, parte tierna, fresco, crudo	117	203.000	0.800	\N	2.000	\N	\N	\N	\N	\N	\N	\N	\N	\N
470	\N	\N	t	\N	\N	95.000	35.000	2.800	0.900	16.000	67.000	40.000	\N	\N	0.850	\N	Zapallito, parte tierna, hervido	118	165.000	1.300	\N	4.000	\N	\N	\N	\N	\N	\N	\N	\N	\N
471	\N	\N	t	\N	\N	91.000	23.000	5.800	2.500	27.000	113.000	14.000	Cucurbita pepo	0.200	0.900	0.400	Zapallo, pulpa, fresco, crudo	430	162.000	0.500	0.058	2.000	0.044	4.800	\N	\N	\N	\N	\N	\N	\N
472	\N	\N	t	\N	\N	94.000	17.000	4.600	1.000	20.000	84.000	13.000	Cucurbita pepo	\N	0.590	\N	Zapallo, pulpa, hervido	431	142.000	0.400	\N	4.000	\N	\N	\N	\N	\N	\N	\N	\N	\N
\.


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
10	\N	\N	t	2024-09-01 17:06:56.529304	2	\N	test modificado desde insomnia
\.


--
-- Data for Name: cuidado; Type: TABLE DATA; Schema: public; Owner: admin
--

COPY public.cuidado (cuidado_id, created, createdby, isactive, updated, updatedby, descripcion, posicion, titulo) FROM stdin;
4	\N	\N	t	2024-08-25 14:30:49.077784	2	cuarto	3	cuarto
3	\N	\N	t	2024-08-25 14:30:49.07942	2	tercero	4	tercero
6	2024-08-26 19:05:54.203647	2	t	2024-08-26 19:05:54.203647	2	testeando posiciones	5	cuidado create
7	2024-08-26 19:06:26.198948	2	t	2024-08-26 19:06:26.198948	2	testeando posiciones	6	cuidado create
8	2024-08-26 19:06:50.797604	2	f	2024-08-26 19:18:57.884683	2	testeando posiciones	8	cuidado create
5	2024-08-26 18:14:42.586822	\N	f	2024-09-03 20:26:06.098567	1	\N	\N	\N
1	\N	\N	t	2024-09-03 22:38:42.539285	1	se modifico la descripcion	\N	\N
2	\N	\N	t	\N	\N	segundo	2	segundo
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
38	\N	\N	f	2024-09-01 17:04:28.974514	2	opcion 4	10
39	\N	\N	f	2024-09-01 17:04:28.977698	2	opcion 5	10
40	2024-09-01 16:09:04.661965	2	f	2024-09-01 17:04:28.977769	2	este es nuevo	10
42	2024-09-01 17:06:56.526603	2	t	2024-09-01 17:06:56.526603	2	este es completamente nuevo	10
43	2024-09-01 17:06:56.528028	2	t	2024-09-01 17:06:56.528028	2	este estaba eliminado	10
41	2024-09-01 17:06:05.174922	2	f	2024-09-01 17:06:56.529219	2	este es completamente nuevo	10
35	\N	\N	t	2024-09-01 17:06:56.529374	2	insomnia 11	10
36	\N	\N	t	2024-09-01 17:06:56.52943	2	insomnia 22	10
37	\N	\N	t	2024-09-01 17:06:56.529747	2	insomnia 33	10
\.


--
-- Data for Name: register_token; Type: TABLE DATA; Schema: public; Owner: admin
--

COPY public.register_token (token_id, expiry_date, token, usuario_id) FROM stdin;
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
6	2
\.


--
-- Data for Name: usuario; Type: TABLE DATA; Schema: public; Owner: admin
--

COPY public.usuario (usuario_id, username, password, email, fnac, apellido, dni, nombre, created, createdby, updated, updatedby, isactive, isenabled) FROM stdin;
3	paciente	$2a$10$HZeUo2TjNkEAQGCYmpYUwey7v45q0GEAjNWSHutT.C5LiK4dOD/FK	paciente@gmail.com	1999-05-18	paciente	1234	paciente	\N	\N	\N	\N	t	t
2	user	$2a$10$OGNFRLqpy1.bmPWQCSXtH.uTgniemXKxLvoTTI4PE3gg5Gn.gYpMS	user@gmail.com	1997-09-11	user	1234	user	\N	\N	\N	\N	t	t
5	test	$2a$10$kSjxEaiV6rH2amZCQ/3Z6uK0xVPAq5D9qYJvT/YyMVm019t8tafQa	test@test.com	2024-07-25	test	1234	test	\N	\N	\N	\N	t	t
1	admin	$2a$10$L0rqEM2ATQL7gA2g175dSeHHO454iDncyqMhOy4h8u.x/vCAi7bsu	admin@gmail.com	1998-04-08	admin	1234	admin	\N	\N	\N	\N	t	t
6	insomnia	$2a$10$xxngYfNyIhvhIjMwkQg2SuGiyPSC91gN/xhQFj5c.zbbf77m8LSN2	insomnia@gmail.com	1999-05-18	insomnia_modif2	12345678	insomnia_modif2	2024-09-05 23:18:28.301922	1	2024-09-05 23:46:46.839505	1	t	t
\.


--
-- Name: alimento_alimento_id_seq; Type: SEQUENCE SET; Schema: public; Owner: admin
--

SELECT pg_catalog.setval('public.alimento_alimento_id_seq', 472, true);


--
-- Name: cuestionario_cuestionario_id_seq; Type: SEQUENCE SET; Schema: public; Owner: admin
--

SELECT pg_catalog.setval('public.cuestionario_cuestionario_id_seq', 10, true);


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

SELECT pg_catalog.setval('public.opcion_opcion_id_seq', 43, true);


--
-- Name: register_token_token_id_seq; Type: SEQUENCE SET; Schema: public; Owner: admin
--

SELECT pg_catalog.setval('public.register_token_token_id_seq', 1, false);


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

SELECT pg_catalog.setval('public.usuario_usuario_id_seq', 6, true);


--
-- Name: alimento alimento_pkey; Type: CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.alimento
    ADD CONSTRAINT alimento_pkey PRIMARY KEY (alimento_id);


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
-- Name: register_token register_token_pkey; Type: CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.register_token
    ADD CONSTRAINT register_token_pkey PRIMARY KEY (token_id);


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
-- Name: register_token uk_bp4htmq93htjc5pc7g8j1i8f1; Type: CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.register_token
    ADD CONSTRAINT uk_bp4htmq93htjc5pc7g8j1i8f1 UNIQUE (usuario_id);


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
-- Name: register_token fkqevd2wyq2x6vpj8vyb4etgde7; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.register_token
    ADD CONSTRAINT fkqevd2wyq2x6vpj8vyb4etgde7 FOREIGN KEY (usuario_id) REFERENCES public.usuario(usuario_id);


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

