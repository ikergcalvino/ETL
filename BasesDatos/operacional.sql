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

DROP TABLE IF EXISTS public.sesion;
DROP TABLE IF EXISTS public.piscina;
DROP TABLE IF EXISTS public.piscina_auditoria;
DROP TABLE IF EXISTS public.cliente;
DROP TABLE IF EXISTS public.cliente_auditoria;
DROP TABLE IF EXISTS public.monitor;
DROP TABLE IF EXISTS public.actividade;

DROP FUNCTION IF EXISTS public.cliente_trigger_func();
DROP FUNCTION IF EXISTS public.piscina_trigger_func();

DROP TRIGGER IF EXISTS cliente_trigger ON public.cliente;
DROP TRIGGER IF EXISTS piscina_trigger ON public.piscina;

--
-- Name: cliente_trigger_func(); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION public.cliente_trigger_func() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
BEGIN
    if (tg_op = 'UPDATE') then
        insert into public.cliente_auditoria select NEW.*, 'mod', CURRENT_DATE;
        return NEW;
    elsif (tg_op = 'INSERT') then
        insert into public.cliente_auditoria select NEW.*, 'ins', CURRENT_DATE;
        return NEW;
    end if;
END;
$$;


--
-- Name: piscina_trigger_func(); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION public.piscina_trigger_func() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
BEGIN
    if (tg_op = 'UPDATE') then
        insert into public.piscina_auditoria select NEW.*, 'mod', CURRENT_DATE;
        return NEW;
    elsif (tg_op = 'INSERT') then
        insert into public.piscina_auditoria select NEW.*, 'ins', CURRENT_DATE;
        return NEW;
    end if;
END;
$$;


--
-- Name: actividade; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.actividade (
    nome character varying(50) NOT NULL,
    descripcion character varying(100)
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
-- Name: cliente_auditoria; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.cliente_auditoria (
    dni character varying(10) NOT NULL,
    nome character varying(25) NOT NULL,
    sexo character varying(1),
    telefono character varying(10),
    cambio character varying(3),
    ultmod date
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
    monitor character varying(10) NOT NULL,
    mantemento numeric(5,0)
);


--
-- Name: piscina_auditoria; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.piscina_auditoria (
    nome character varying(25) NOT NULL,
    monitor character varying(10) NOT NULL,
    mantemento numeric(5,0),
    cambio character varying(3),
    ultmod date
);


--
-- Name: sesion; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.sesion (
    codsesion numeric(6,0) NOT NULL,
    datahora date,
    cliente character varying(10) NOT NULL,
    actividade character varying(50) NOT NULL,
    piscina character varying(25) NOT NULL,
    monitor character varying(10) NOT NULL
);


--
-- Name: actividade actividade_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.actividade
    ADD CONSTRAINT actividade_pkey PRIMARY KEY (nome);


--
-- Name: cliente cliente_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.cliente
    ADD CONSTRAINT cliente_pkey PRIMARY KEY (dni);


--
-- Name: monitor monitor_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.monitor
    ADD CONSTRAINT monitor_pkey PRIMARY KEY (nif);


--
-- Name: piscina piscina_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.piscina
    ADD CONSTRAINT piscina_pkey PRIMARY KEY (nome);


--
-- Name: sesion sesion_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.sesion
    ADD CONSTRAINT sesion_pkey PRIMARY KEY (codsesion);


--
-- Name: piscina piscina_monitor_fk; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.piscina
    ADD CONSTRAINT piscina_monitor_fk FOREIGN KEY (monitor) REFERENCES public.monitor(nif);


--
-- Name: sesion sesion_actividade_fk; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.sesion
    ADD CONSTRAINT sesion_actividade_fk FOREIGN KEY (actividade) REFERENCES public.actividade(nome);


--
-- Name: sesion sesion_cliente_fk; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.sesion
    ADD CONSTRAINT sesion_cliente_fk FOREIGN KEY (cliente) REFERENCES public.cliente(dni);


--
-- Name: sesion sesion_monitor_fk; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.sesion
    ADD CONSTRAINT sesion_monitor_fk FOREIGN KEY (monitor) REFERENCES public.monitor(nif);


--
-- Name: sesion sesion_piscina_fk; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.sesion
    ADD CONSTRAINT sesion_piscina_fk FOREIGN KEY (piscina) REFERENCES public.piscina(nome);


--
-- Name: cliente cliente_trigger; Type: TRIGGER; Schema: public; Owner: -
--

CREATE TRIGGER cliente_trigger AFTER INSERT OR UPDATE OF dni, nome, sexo, telefono ON public.cliente FOR EACH ROW EXECUTE FUNCTION public.cliente_trigger_func();


--
-- Name: piscina piscina_trigger; Type: TRIGGER; Schema: public; Owner: -
--

CREATE TRIGGER piscina_trigger AFTER INSERT OR UPDATE OF nome, monitor, mantemento ON public.piscina FOR EACH ROW EXECUTE FUNCTION public.piscina_trigger_func();


--
-- Data for Name: actividade; Type: TABLE DATA; Schema: public; Owner: -
--

INSERT INTO public.actividade (nome, descripcion) VALUES ('Natación Libre', 'Actividad para nadadores experimentados.');
INSERT INTO public.actividade (nome, descripcion) VALUES ('Aquagym', 'Actividad para tonificar y mejorar la forma física.');
INSERT INTO public.actividade (nome, descripcion) VALUES ('Clases de Natación Infantil', 'Actividad para niños que deseen aprender a nadar.');
INSERT INTO public.actividade (nome, descripcion) VALUES ('Clases de Hidroterapia', 'Actividad terapéutica en el agua.');
INSERT INTO public.actividade (nome, descripcion) VALUES ('Waterpolo', 'Actividad deportiva acuática en equipo.');


--
-- Data for Name: cliente; Type: TABLE DATA; Schema: public; Owner: -
--

INSERT INTO public.cliente (dni, nome, sexo, telefono) VALUES ('123456789A', 'Juan Pérez', 'M', '123456789');
INSERT INTO public.cliente (dni, nome, sexo, telefono) VALUES ('987654321B', 'María García', 'F', '987654321');
INSERT INTO public.cliente (dni, nome, sexo, telefono) VALUES ('234567890C', 'Pedro González', 'M', '234567890');
INSERT INTO public.cliente (dni, nome, sexo, telefono) VALUES ('345678901D', 'Ana Ruiz', 'F', '345678901');
INSERT INTO public.cliente (dni, nome, sexo, telefono) VALUES ('456789012E', 'Jorge Sánchez', 'M', NULL);


--
-- Data for Name: monitor; Type: TABLE DATA; Schema: public; Owner: -
--

INSERT INTO public.monitor (nif, nome, especialidade) VALUES ('123456789A', 'Pedro Pérez', 'Natación');
INSERT INTO public.monitor (nif, nome, especialidade) VALUES ('987654321B', 'María García', 'Aquagym');
INSERT INTO public.monitor (nif, nome, especialidade) VALUES ('234567890C', 'Juan González', 'Hidroterapia');
INSERT INTO public.monitor (nif, nome, especialidade) VALUES ('345678901D', 'Ana Ruiz', 'Waterpolo');
INSERT INTO public.monitor (nif, nome, especialidade) VALUES ('456789012E', 'Jorge Sánchez', 'Salvamento Acuático');


--
-- Data for Name: piscina; Type: TABLE DATA; Schema: public; Owner: -
--

INSERT INTO public.piscina (nome, monitor, mantemento) VALUES ('Piscina Olímpica', '123456789A', 2000);
INSERT INTO public.piscina (nome, monitor, mantemento) VALUES ('Piscina Infantil', '987654321B', 500);
INSERT INTO public.piscina (nome, monitor, mantemento) VALUES ('Piscina de Saltos', '234567890C', 1500);
INSERT INTO public.piscina (nome, monitor, mantemento) VALUES ('Piscina de Hidroterapia', '234567890C', 1000);
INSERT INTO public.piscina (nome, monitor, mantemento) VALUES ('Piscina de Competición', '123456789A', 2500);


--
-- Data for Name: sesion; Type: TABLE DATA; Schema: public; Owner: -
--

INSERT INTO public.sesion (codsesion, datahora, cliente, actividade, piscina, monitor) VALUES (100001, '2022-01-01', '123456789A', 'Natación Libre', 'Piscina Olímpica', '123456789A');
INSERT INTO public.sesion (codsesion, datahora, cliente, actividade, piscina, monitor) VALUES (100002, '2022-02-01', '234567890C', 'Clases de Natación Infantil', 'Piscina Infantil', '987654321B');
INSERT INTO public.sesion (codsesion, datahora, cliente, actividade, piscina, monitor) VALUES (100003, '2022-03-01', '345678901D', 'Clases de Hidroterapia', 'Piscina de Hidroterapia', '234567890C');
INSERT INTO public.sesion (codsesion, datahora, cliente, actividade, piscina, monitor) VALUES (100004, '2022-04-01', '456789012E', 'Aquagym', 'Piscina Olímpica', '987654321B');
INSERT INTO public.sesion (codsesion, datahora, cliente, actividade, piscina, monitor) VALUES (100005, '2022-05-01', '987654321B', 'Waterpolo', 'Piscina Olímpica', '123456789A');


--
-- PostgreSQL database dump complete
--

