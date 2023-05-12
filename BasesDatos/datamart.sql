--
-- PostgreSQL database dump
--

-- Dumped from database version 15.2
-- Dumped by pg_dump version 15.2

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

SET default_table_access_method = heap;

DROP TABLE IF EXISTS public.dim_cliente;
DROP TABLE IF EXISTS public.dim_cliente_scd2;
DROP TABLE IF EXISTS public.dim_data;
DROP TABLE IF EXISTS public.dim_piscina;
DROP TABLE IF EXISTS public.fact_sesion;

--
-- Name: dim_cliente; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.dim_cliente (
    idcliente numeric(6,0) NOT NULL,
    dni character varying(10) NOT NULL,
    nome character varying(25) NOT NULL,
    sexo character varying(1)
);


--
-- Name: dim_cliente_scd2; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.dim_cliente_scd2 (
    idcliente numeric(6,0) NOT NULL,
    dni character varying(10) NOT NULL,
    nome character varying(25) NOT NULL,
    sexo character varying(1),
    valido_desde timestamp without time zone,
    valido_ate timestamp without time zone,
    num_version numeric(3,0),
    version_actual boolean
);


--
-- Name: dim_data; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.dim_data (
    iddata numeric(6,0) NOT NULL,
    mes numeric(2,0) NOT NULL,
    ano numeric(4,0) NOT NULL
);


--
-- Name: dim_piscina; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.dim_piscina (
    idpiscina numeric(6,0) NOT NULL,
    nome character varying(25) NOT NULL,
    mantemento numeric(5,0),
    temperatura numeric(2,0),
    aforo numeric(10,0)
);


--
-- Name: fact_sesion; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.fact_sesion (
    idsesion numeric(6,0) NOT NULL,
    codsesion numeric(6,0) NOT NULL,
    iddata numeric(6,0) NOT NULL,
    idcliente numeric(6,0) NOT NULL,
    idpiscina numeric(6,0) NOT NULL,
    custo numeric(4,0)
);


--
-- Data for Name: dim_cliente; Type: TABLE DATA; Schema: public; Owner: -
--



--
-- Data for Name: dim_data; Type: TABLE DATA; Schema: public; Owner: -
--

INSERT INTO public.dim_data (iddata, mes, ano) VALUES (1, 1, 2022);
INSERT INTO public.dim_data (iddata, mes, ano) VALUES (2, 2, 2022);
INSERT INTO public.dim_data (iddata, mes, ano) VALUES (3, 3, 2022);
INSERT INTO public.dim_data (iddata, mes, ano) VALUES (4, 4, 2022);
INSERT INTO public.dim_data (iddata, mes, ano) VALUES (5, 5, 2022);


--
-- Data for Name: dim_piscina; Type: TABLE DATA; Schema: public; Owner: -
--



--
-- Data for Name: fact_sesion; Type: TABLE DATA; Schema: public; Owner: -
--



--
-- Name: dim_cliente dim_cliente_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.dim_cliente
    ADD CONSTRAINT dim_cliente_pkey PRIMARY KEY (idcliente);


--
-- Name: dim_data dim_data_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.dim_data
    ADD CONSTRAINT dim_data_pkey PRIMARY KEY (iddata);


--
-- Name: fact_sesion fact_sesion_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.fact_sesion
    ADD CONSTRAINT fact_sesion_pkey PRIMARY KEY (idsesion);


--
-- Name: dim_piscina dim_piscina_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.dim_piscina
    ADD CONSTRAINT dim_piscina_pkey PRIMARY KEY (idpiscina);


--
-- PostgreSQL database dump complete
--

