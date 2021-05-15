--
-- PostgreSQL database dump
--

-- Dumped from database version 11.11 (Debian 11.11-1.pgdg90+1)
-- Dumped by pg_dump version 11.11 (Debian 11.11-0+deb10u1)

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
-- Name: web_address_statuses; Type: TYPE; Schema: public; Owner: -
--

CREATE TYPE public.web_address_statuses AS ENUM (
    'unknown',
    'up',
    'down',
    'error'
);


SET default_tablespace = '';

SET default_with_oids = false;

--
-- Name: user_having_web_addresses; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.user_having_web_addresses (
    id integer NOT NULL,
    user_id integer NOT NULL,
    web_address_id integer NOT NULL,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL
);


--
-- Name: user_having_web_addresses_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.user_having_web_addresses_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: user_having_web_addresses_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.user_having_web_addresses_id_seq OWNED BY public.user_having_web_addresses.id;


--
-- Name: users; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.users (
    id integer NOT NULL,
    email text,
    nickname text NOT NULL,
    password_hash text NOT NULL,
    password_salt text NOT NULL,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL
);


--
-- Name: users_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.users_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: users_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.users_id_seq OWNED BY public.users.id;


--
-- Name: web_addresses; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.web_addresses (
    id integer NOT NULL,
    http_status_code integer,
    notifications_sent boolean DEFAULT false NOT NULL,
    pinged_at timestamp without time zone,
    status public.web_address_statuses DEFAULT 'unknown'::public.web_address_statuses NOT NULL,
    url text NOT NULL,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL
);


--
-- Name: web_addresses_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.web_addresses_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: web_addresses_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.web_addresses_id_seq OWNED BY public.web_addresses.id;


--
-- Name: user_having_web_addresses id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.user_having_web_addresses ALTER COLUMN id SET DEFAULT nextval('public.user_having_web_addresses_id_seq'::regclass);


--
-- Name: users id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.users ALTER COLUMN id SET DEFAULT nextval('public.users_id_seq'::regclass);


--
-- Name: web_addresses id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.web_addresses ALTER COLUMN id SET DEFAULT nextval('public.web_addresses_id_seq'::regclass);


--
-- Name: user_having_web_addresses user_having_web_addresses_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.user_having_web_addresses
    ADD CONSTRAINT user_having_web_addresses_pkey PRIMARY KEY (id);


--
-- Name: users users_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_pkey PRIMARY KEY (id);


--
-- Name: web_addresses web_addresses_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.web_addresses
    ADD CONSTRAINT web_addresses_pkey PRIMARY KEY (id);


--
-- Name: user_having_web_addresses_user_id_index; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX user_having_web_addresses_user_id_index ON public.user_having_web_addresses USING btree (user_id);


--
-- Name: user_having_web_addresses_web_address_id_index; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX user_having_web_addresses_web_address_id_index ON public.user_having_web_addresses USING btree (web_address_id);


--
-- Name: users_nickname_index; Type: INDEX; Schema: public; Owner: -
--

CREATE UNIQUE INDEX users_nickname_index ON public.users USING btree (nickname);


--
-- Name: web_addresses_url_index; Type: INDEX; Schema: public; Owner: -
--

CREATE UNIQUE INDEX web_addresses_url_index ON public.web_addresses USING btree (url);


--
-- Name: user_having_web_addresses user_having_web_addresses_user_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.user_having_web_addresses
    ADD CONSTRAINT user_having_web_addresses_user_id_fkey FOREIGN KEY (user_id) REFERENCES public.users(id) ON DELETE CASCADE;


--
-- Name: user_having_web_addresses user_having_web_addresses_web_address_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.user_having_web_addresses
    ADD CONSTRAINT user_having_web_addresses_web_address_id_fkey FOREIGN KEY (web_address_id) REFERENCES public.web_addresses(id) ON DELETE CASCADE;


--
-- PostgreSQL database dump complete
--

--
-- PostgreSQL database dump
--

-- Dumped from database version 11.11 (Debian 11.11-1.pgdg90+1)
-- Dumped by pg_dump version 11.11 (Debian 11.11-0+deb10u1)

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

SET default_with_oids = false;

--
-- Name: schema_migrations; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.schema_migrations (
    filename text NOT NULL
);


ALTER TABLE public.schema_migrations OWNER TO postgres;

--
-- Data for Name: schema_migrations; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.schema_migrations (filename) FROM stdin;
20210511202025_create_users.rb
20210515090145_create_web_addresses.rb
20210515090704_create_user_having_web_addresses.rb
\.


--
-- Name: schema_migrations schema_migrations_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.schema_migrations
    ADD CONSTRAINT schema_migrations_pkey PRIMARY KEY (filename);


--
-- PostgreSQL database dump complete
--

