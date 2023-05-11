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

--
-- Name: actividade; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.actividade (
    nome character varying(25) NOT NULL,
    descripcion character varying(50)
);


--
-- Name: cliente; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.cliente (
    dni character varying(10) NOT NULL,
    nome character varying(25) NOT NULL,
    sexo character varying(1),
    telefono character varying(10)
);


--
-- Name: monitor; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.monitor (
    nif character varying(10) NOT NULL,
    nome character varying(25) NOT NULL,
    especialidade character varying(50)
);


--
-- Name: piscina; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.piscina (
    nome character varying(25) NOT NULL,
    aforo numeric(3,0),
    monitor character varying(10) NOT NULL
);


--
-- Name: sesion; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.sesion (
    codsesion numeric(6,0) NOT NULL,
    datahora timestamp without time zone,
    cliente character varying(10) NOT NULL,
    actividade character varying(25) NOT NULL,
    piscina character varying(25) NOT NULL,
    monitor character varying(10) NOT NULL
);


--
-- Data for Name: actividade; Type: TABLE DATA; Schema: public; Owner: -
--



--
-- Data for Name: cliente; Type: TABLE DATA; Schema: public; Owner: -
--



--
-- Data for Name: monitor; Type: TABLE DATA; Schema: public; Owner: -
--



--
-- Data for Name: piscina; Type: TABLE DATA; Schema: public; Owner: -
--



--
-- Data for Name: sesion; Type: TABLE DATA; Schema: public; Owner: -
--



--
-- Name: actividade actividade_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.actividade
    ADD CONSTRAINT actividade_pkey PRIMARY KEY (nome);


--
-- Name: cliente cliente_pkey1; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.cliente
    ADD CONSTRAINT cliente_pkey1 PRIMARY KEY (dni);


--
-- Name: monitor monitor_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.monitor
    ADD CONSTRAINT monitor_pkey PRIMARY KEY (nif);


--
-- Name: piscina piscina_pkey1; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.piscina
    ADD CONSTRAINT piscina_pkey1 PRIMARY KEY (nome);


--
-- Name: sesion sesion_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.sesion
    ADD CONSTRAINT sesion_pkey PRIMARY KEY (codsesion);


--
-- Name: piscina piscina_monitor_fk; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.piscina
    ADD CONSTRAINT piscina_monitor_fk FOREIGN KEY (monitor) REFERENCES public.monitor(nif) NOT VALID;


--
-- Name: sesion sesion_actividade_fk; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.sesion
    ADD CONSTRAINT sesion_actividade_fk FOREIGN KEY (actividade) REFERENCES public.actividade(nome) NOT VALID;


--
-- Name: sesion sesion_cliente_fk; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.sesion
    ADD CONSTRAINT sesion_cliente_fk FOREIGN KEY (cliente) REFERENCES public.cliente(dni) NOT VALID;


--
-- Name: sesion sesion_monitor_fk; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.sesion
    ADD CONSTRAINT sesion_monitor_fk FOREIGN KEY (monitor) REFERENCES public.monitor(nif) NOT VALID;


--
-- Name: sesion sesion_piscina_fk; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.sesion
    ADD CONSTRAINT sesion_piscina_fk FOREIGN KEY (piscina) REFERENCES public.piscina(nome) NOT VALID;


--
-- PostgreSQL database dump complete
--

