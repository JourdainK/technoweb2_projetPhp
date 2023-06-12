--
-- PostgreSQL database dump
--

-- Dumped from database version 15.2
-- Dumped by pg_dump version 15.2

-- Started on 2023-06-12 22:24:24

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
-- TOC entry 265 (class 1255 OID 32976)
-- Name: addville(text, text, integer); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.addville(nomville text, nompays text, codep integer) RETURNS integer
    LANGUAGE plpgsql
    AS $$
DECLARE
    v_idville INTEGER;
    v_idpays INTEGER;
BEGIN
    SELECT id_ville INTO v_idville FROM ville WHERE nom_ville = nomville;
    IF not found THEN
        SELECT id_pays INTO v_idpays FROM pays WHERE nom_pays = nompays;
        IF not found THEN
            BEGIN
                INSERT INTO pays(nom_pays) VALUES (nompays);
                EXCEPTION WHEN unique_violation THEN
                    RAISE NOTICE 'Un autre processus a inséré la même valeur';
            END;
            SELECT id_pays INTO v_idpays FROM pays WHERE nom_pays = nompays;
			INSERT INTO ville(nom_ville, cp, id_pays) VALUES (nomville, codep, v_idpays);
			RETURN 1;
        ELSE
            INSERT INTO ville(nom_ville, cp, id_pays) VALUES (nomville, codep, v_idpays);
            RETURN 1;
        END IF;
    ELSE
        RETURN 0;
    END IF;
    
    -- Add a return statement for the case where a new row is not inserted
    RETURN 0;
END;
$$;


ALTER FUNCTION public.addville(nomville text, nompays text, codep integer) OWNER TO postgres;

--
-- TOC entry 249 (class 1255 OID 32963)
-- Name: getadmin(text, text); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.getadmin(text, text) RETURNS integer
    LANGUAGE plpgsql
    AS $_$
declare p_login alias for $1;
declare p_pass alias for $2;
declare id integer;
declare retour integer;
begin

SELECT INTO id id_admin FROM admin where login =p_login and
password = p_pass;
if not found
then 
	retour =  0;
else
	retour  = 1;
end if;
return retour;

end;
$_$;


ALTER FUNCTION public.getadmin(text, text) OWNER TO postgres;

--
-- TOC entry 250 (class 1255 OID 32965)
-- Name: isadmin(text, text); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.isadmin(p_login text, p_password text) RETURNS boolean
    LANGUAGE plpgsql
    AS $$
DECLARE
  id INTEGER;
  retour INTEGER;
BEGIN
  SELECT id_admin INTO id FROM admin WHERE login = p_login AND password = p_password;
  IF NOT FOUND THEN
    retour := 0;
  ELSE
    retour := 1;
  END IF;

  RETURN retour;
END;
$$;


ALTER FUNCTION public.isadmin(p_login text, p_password text) OWNER TO postgres;

--
-- TOC entry 253 (class 1255 OID 32994)
-- Name: isuser(text, text); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.isuser(text, text) RETURNS integer
    LANGUAGE plpgsql
    AS $_$
	declare v_mail alias for $1;
	declare v_pwd alias for $2;
	declare v_id integer;
	
	BEGIN
		SELECT id_client INTO v_id FROM client WHERE email_client = v_mail AND password = v_pwd;
		
		if NOT FOUND THEN
			return 0;
		else
		   return 1;
		end if;
	END;
	$_$;


ALTER FUNCTION public.isuser(text, text) OWNER TO postgres;

--
-- TOC entry 251 (class 1255 OID 32975)
-- Name: updateclient(integer, text, text, text, integer); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.updateclient(v_id integer, v_nom text, v_pass text, v_mail text, v_idville integer) RETURNS integer
    LANGUAGE plpgsql
    AS $$
DECLARE
    v_ckupdate INTEGER;
BEGIN
    UPDATE client SET 
        nom_client = v_nom, 
        password = v_pass, 
        email_client = v_mail, 
        id_ville = v_idville 
    WHERE id_client = v_id;
    GET DIAGNOSTICS v_ckupdate = ROW_COUNT;
    RETURN v_ckupdate;
END;
$$;


ALTER FUNCTION public.updateclient(v_id integer, v_nom text, v_pass text, v_mail text, v_idville integer) OWNER TO postgres;

--
-- TOC entry 252 (class 1255 OID 32966)
-- Name: verifier_connexion(text, text); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.verifier_connexion(text, text) RETURNS integer
    LANGUAGE plpgsql
    AS $_$
	declare f_login alias for $1;
	declare f_password alias for $2;
	declare id integer;
	declare retour integer;
begin
	select into id id_admin from admin where login=f_login and password=f_password;
	if not found
	then
	  retour=0;
	else
	  retour=1;
	end if;
	return retour;
end;
$_$;


ALTER FUNCTION public.verifier_connexion(text, text) OWNER TO postgres;

SET default_tablespace = '';

SET default_table_access_method = heap;

--
-- TOC entry 242 (class 1259 OID 32956)
-- Name: admin; Type: TABLE; Schema: public; Owner: kev
--

CREATE TABLE public.admin (
    id_admin integer NOT NULL,
    login text NOT NULL,
    password text
);


ALTER TABLE public.admin OWNER TO kev;

--
-- TOC entry 219 (class 1259 OID 24600)
-- Name: attribut; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.attribut (
    id_attribut integer NOT NULL,
    nom_attribut text NOT NULL
);


ALTER TABLE public.attribut OWNER TO postgres;

--
-- TOC entry 218 (class 1259 OID 24599)
-- Name: attribut_id_attribut_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.attribut_id_attribut_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.attribut_id_attribut_seq OWNER TO postgres;

--
-- TOC entry 3504 (class 0 OID 0)
-- Dependencies: 218
-- Name: attribut_id_attribut_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.attribut_id_attribut_seq OWNED BY public.attribut.id_attribut;


--
-- TOC entry 238 (class 1259 OID 24697)
-- Name: produit_attributs; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.produit_attributs (
    id_produit integer NOT NULL,
    id_attribut integer NOT NULL,
    valeur text
);


ALTER TABLE public.produit_attributs OWNER TO postgres;

--
-- TOC entry 244 (class 1259 OID 32971)
-- Name: attribut_valeur; Type: VIEW; Schema: public; Owner: postgres
--

CREATE VIEW public.attribut_valeur AS
 SELECT pa.id_produit,
    pa.id_attribut,
    a.nom_attribut,
    pa.valeur
   FROM (public.attribut a
     JOIN public.produit_attributs pa ON ((a.id_attribut = pa.id_attribut)));


ALTER TABLE public.attribut_valeur OWNER TO postgres;

--
-- TOC entry 217 (class 1259 OID 24589)
-- Name: categorie; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.categorie (
    id_categorie integer NOT NULL,
    nom_categorie text NOT NULL,
    pic text
);


ALTER TABLE public.categorie OWNER TO postgres;

--
-- TOC entry 216 (class 1259 OID 24588)
-- Name: categorie_id_categorie_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.categorie_id_categorie_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.categorie_id_categorie_seq OWNER TO postgres;

--
-- TOC entry 3505 (class 0 OID 0)
-- Dependencies: 216
-- Name: categorie_id_categorie_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.categorie_id_categorie_seq OWNED BY public.categorie.id_categorie;


--
-- TOC entry 225 (class 1259 OID 24626)
-- Name: client; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.client (
    id_client integer NOT NULL,
    nom_client text NOT NULL,
    password text,
    email_client text NOT NULL,
    id_ville integer NOT NULL
);


ALTER TABLE public.client OWNER TO postgres;

--
-- TOC entry 223 (class 1259 OID 24624)
-- Name: client_id_client_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.client_id_client_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.client_id_client_seq OWNER TO postgres;

--
-- TOC entry 3506 (class 0 OID 0)
-- Dependencies: 223
-- Name: client_id_client_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.client_id_client_seq OWNED BY public.client.id_client;


--
-- TOC entry 224 (class 1259 OID 24625)
-- Name: client_id_ville_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.client_id_ville_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.client_id_ville_seq OWNER TO postgres;

--
-- TOC entry 3507 (class 0 OID 0)
-- Dependencies: 224
-- Name: client_id_ville_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.client_id_ville_seq OWNED BY public.client.id_ville;


--
-- TOC entry 228 (class 1259 OID 24644)
-- Name: commande; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.commande (
    id_commande integer NOT NULL,
    prix_comm numeric(15,2) NOT NULL,
    statut boolean NOT NULL,
    date_commande date NOT NULL,
    id_client integer NOT NULL
);


ALTER TABLE public.commande OWNER TO postgres;

--
-- TOC entry 227 (class 1259 OID 24643)
-- Name: commande_id_client_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.commande_id_client_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.commande_id_client_seq OWNER TO postgres;

--
-- TOC entry 3508 (class 0 OID 0)
-- Dependencies: 227
-- Name: commande_id_client_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.commande_id_client_seq OWNED BY public.commande.id_client;


--
-- TOC entry 226 (class 1259 OID 24642)
-- Name: commande_id_commande_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.commande_id_commande_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.commande_id_commande_seq OWNER TO postgres;

--
-- TOC entry 3509 (class 0 OID 0)
-- Dependencies: 226
-- Name: commande_id_commande_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.commande_id_commande_seq OWNED BY public.commande.id_commande;


--
-- TOC entry 235 (class 1259 OID 24677)
-- Name: detail; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.detail (
    id_detail integer NOT NULL,
    quantite integer NOT NULL,
    id_commande integer NOT NULL,
    id_produit integer NOT NULL
);


ALTER TABLE public.detail OWNER TO postgres;

--
-- TOC entry 233 (class 1259 OID 24675)
-- Name: detail_id_commande_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.detail_id_commande_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.detail_id_commande_seq OWNER TO postgres;

--
-- TOC entry 3510 (class 0 OID 0)
-- Dependencies: 233
-- Name: detail_id_commande_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.detail_id_commande_seq OWNED BY public.detail.id_commande;


--
-- TOC entry 232 (class 1259 OID 24674)
-- Name: detail_id_liste_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.detail_id_liste_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.detail_id_liste_seq OWNER TO postgres;

--
-- TOC entry 3511 (class 0 OID 0)
-- Dependencies: 232
-- Name: detail_id_liste_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.detail_id_liste_seq OWNED BY public.detail.id_detail;


--
-- TOC entry 234 (class 1259 OID 24676)
-- Name: detail_id_produit_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.detail_id_produit_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.detail_id_produit_seq OWNER TO postgres;

--
-- TOC entry 3512 (class 0 OID 0)
-- Dependencies: 234
-- Name: detail_id_produit_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.detail_id_produit_seq OWNED BY public.detail.id_produit;


--
-- TOC entry 231 (class 1259 OID 24658)
-- Name: produit; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.produit (
    id_produit integer NOT NULL,
    nom_produit text NOT NULL,
    description text,
    prix numeric(15,2) NOT NULL,
    photo text,
    id_categorie integer NOT NULL
);


ALTER TABLE public.produit OWNER TO postgres;

--
-- TOC entry 241 (class 1259 OID 24741)
-- Name: details_commande; Type: VIEW; Schema: public; Owner: postgres
--

CREATE VIEW public.details_commande AS
 SELECT c.id_commande AS idcom,
    p.id_produit AS idprod,
    p.nom_produit,
    p.prix,
    cg.nom_categorie,
    d.quantite
   FROM (((public.commande c
     JOIN public.detail d ON ((c.id_commande = d.id_commande)))
     JOIN public.produit p ON ((d.id_produit = p.id_produit)))
     JOIN public.categorie cg ON ((p.id_categorie = cg.id_categorie)))
  ORDER BY c.id_commande, p.id_produit;


ALTER TABLE public.details_commande OWNER TO postgres;

--
-- TOC entry 243 (class 1259 OID 32967)
-- Name: dvds; Type: VIEW; Schema: public; Owner: postgres
--

CREATE VIEW public.dvds AS
 SELECT produit.id_produit,
    produit.nom_produit,
    produit.description,
    produit.prix,
    produit.photo
   FROM public.produit
  WHERE (produit.id_categorie = 1);


ALTER TABLE public.dvds OWNER TO postgres;

--
-- TOC entry 246 (class 1259 OID 32981)
-- Name: goodies; Type: VIEW; Schema: public; Owner: postgres
--

CREATE VIEW public.goodies AS
 SELECT produit.id_produit,
    produit.nom_produit,
    produit.description,
    produit.prix,
    produit.photo
   FROM public.produit
  WHERE (produit.id_categorie = 3)
  ORDER BY produit.id_produit;


ALTER TABLE public.goodies OWNER TO postgres;

--
-- TOC entry 215 (class 1259 OID 24578)
-- Name: pays; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.pays (
    id_pays integer NOT NULL,
    nom_pays text NOT NULL
);


ALTER TABLE public.pays OWNER TO postgres;

--
-- TOC entry 222 (class 1259 OID 24610)
-- Name: ville; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.ville (
    id_ville integer NOT NULL,
    nom_ville text,
    cp text,
    id_pays integer NOT NULL
);


ALTER TABLE public.ville OWNER TO postgres;

--
-- TOC entry 240 (class 1259 OID 24736)
-- Name: infos_gen_com; Type: VIEW; Schema: public; Owner: postgres
--

CREATE VIEW public.infos_gen_com AS
 SELECT cm.id_commande,
    cm.prix_comm AS prix_tot,
    cm.statut,
    cm.date_commande,
    cl.nom_client,
    cl.email_client AS mail,
    v.nom_ville AS ville,
    v.cp,
    p.nom_pays AS pays
   FROM (((public.commande cm
     JOIN public.client cl ON ((cm.id_client = cl.id_client)))
     JOIN public.ville v ON ((cl.id_ville = v.id_ville)))
     JOIN public.pays p ON ((v.id_pays = p.id_pays)));


ALTER TABLE public.infos_gen_com OWNER TO postgres;

--
-- TOC entry 245 (class 1259 OID 32977)
-- Name: livres; Type: VIEW; Schema: public; Owner: postgres
--

CREATE VIEW public.livres AS
 SELECT produit.id_produit,
    produit.nom_produit,
    produit.description,
    produit.prix,
    produit.photo
   FROM public.produit
  WHERE (produit.id_categorie = 2)
  ORDER BY produit.id_produit;


ALTER TABLE public.livres OWNER TO postgres;

--
-- TOC entry 214 (class 1259 OID 24577)
-- Name: pays_id_pays_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.pays_id_pays_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.pays_id_pays_seq OWNER TO postgres;

--
-- TOC entry 3513 (class 0 OID 0)
-- Dependencies: 214
-- Name: pays_id_pays_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.pays_id_pays_seq OWNED BY public.pays.id_pays;


--
-- TOC entry 239 (class 1259 OID 24731)
-- Name: prod_infos; Type: VIEW; Schema: public; Owner: postgres
--

CREATE VIEW public.prod_infos AS
 SELECT p.id_produit,
    p.nom_produit,
    p.description,
    p.prix,
    c.nom_categorie AS cat,
    a.nom_attribut,
    pa.valeur AS val_atb
   FROM (((public.produit p
     JOIN public.categorie c ON ((p.id_categorie = c.id_categorie)))
     JOIN public.produit_attributs pa ON ((p.id_produit = pa.id_produit)))
     JOIN public.attribut a ON ((pa.id_attribut = a.id_attribut)))
  ORDER BY p.id_produit, pa.id_attribut;


ALTER TABLE public.prod_infos OWNER TO postgres;

--
-- TOC entry 237 (class 1259 OID 24696)
-- Name: produit_attributs_id_attribut_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.produit_attributs_id_attribut_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.produit_attributs_id_attribut_seq OWNER TO postgres;

--
-- TOC entry 3514 (class 0 OID 0)
-- Dependencies: 237
-- Name: produit_attributs_id_attribut_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.produit_attributs_id_attribut_seq OWNED BY public.produit_attributs.id_attribut;


--
-- TOC entry 236 (class 1259 OID 24695)
-- Name: produit_attributs_id_produit_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.produit_attributs_id_produit_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.produit_attributs_id_produit_seq OWNER TO postgres;

--
-- TOC entry 3515 (class 0 OID 0)
-- Dependencies: 236
-- Name: produit_attributs_id_produit_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.produit_attributs_id_produit_seq OWNED BY public.produit_attributs.id_produit;


--
-- TOC entry 230 (class 1259 OID 24657)
-- Name: produit_id_categorie_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.produit_id_categorie_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.produit_id_categorie_seq OWNER TO postgres;

--
-- TOC entry 3516 (class 0 OID 0)
-- Dependencies: 230
-- Name: produit_id_categorie_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.produit_id_categorie_seq OWNED BY public.produit.id_categorie;


--
-- TOC entry 229 (class 1259 OID 24656)
-- Name: produit_id_produit_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.produit_id_produit_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.produit_id_produit_seq OWNER TO postgres;

--
-- TOC entry 3517 (class 0 OID 0)
-- Dependencies: 229
-- Name: produit_id_produit_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.produit_id_produit_seq OWNED BY public.produit.id_produit;


--
-- TOC entry 221 (class 1259 OID 24609)
-- Name: ville_id_pays_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.ville_id_pays_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.ville_id_pays_seq OWNER TO postgres;

--
-- TOC entry 3518 (class 0 OID 0)
-- Dependencies: 221
-- Name: ville_id_pays_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.ville_id_pays_seq OWNED BY public.ville.id_pays;


--
-- TOC entry 220 (class 1259 OID 24608)
-- Name: ville_id_ville_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.ville_id_ville_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.ville_id_ville_seq OWNER TO postgres;

--
-- TOC entry 3519 (class 0 OID 0)
-- Dependencies: 220
-- Name: ville_id_ville_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.ville_id_ville_seq OWNED BY public.ville.id_ville;


--
-- TOC entry 248 (class 1259 OID 32989)
-- Name: vue_attributs; Type: VIEW; Schema: public; Owner: postgres
--

CREATE VIEW public.vue_attributs AS
 SELECT pa.id_attribut,
    a.nom_attribut,
    pa.valeur,
    pa.id_produit
   FROM (public.attribut a
     JOIN public.produit_attributs pa ON ((a.id_attribut = pa.id_attribut)))
  ORDER BY pa.id_produit;


ALTER TABLE public.vue_attributs OWNER TO postgres;

--
-- TOC entry 247 (class 1259 OID 32985)
-- Name: vue_produits_categories; Type: VIEW; Schema: public; Owner: postgres
--

CREATE VIEW public.vue_produits_categories AS
 SELECT p.id_produit,
    p.nom_produit,
    p.description,
    p.prix,
    p.photo,
    p.id_categorie,
    c.nom_categorie,
    c.pic
   FROM (public.produit p
     JOIN public.categorie c ON ((p.id_categorie = c.id_categorie)))
  WHERE (c.id_categorie = p.id_categorie);


ALTER TABLE public.vue_produits_categories OWNER TO postgres;

--
-- TOC entry 3268 (class 2604 OID 24603)
-- Name: attribut id_attribut; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.attribut ALTER COLUMN id_attribut SET DEFAULT nextval('public.attribut_id_attribut_seq'::regclass);


--
-- TOC entry 3267 (class 2604 OID 24592)
-- Name: categorie id_categorie; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.categorie ALTER COLUMN id_categorie SET DEFAULT nextval('public.categorie_id_categorie_seq'::regclass);


--
-- TOC entry 3271 (class 2604 OID 24629)
-- Name: client id_client; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.client ALTER COLUMN id_client SET DEFAULT nextval('public.client_id_client_seq'::regclass);


--
-- TOC entry 3272 (class 2604 OID 24630)
-- Name: client id_ville; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.client ALTER COLUMN id_ville SET DEFAULT nextval('public.client_id_ville_seq'::regclass);


--
-- TOC entry 3273 (class 2604 OID 24647)
-- Name: commande id_commande; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.commande ALTER COLUMN id_commande SET DEFAULT nextval('public.commande_id_commande_seq'::regclass);


--
-- TOC entry 3274 (class 2604 OID 24648)
-- Name: commande id_client; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.commande ALTER COLUMN id_client SET DEFAULT nextval('public.commande_id_client_seq'::regclass);


--
-- TOC entry 3277 (class 2604 OID 24680)
-- Name: detail id_detail; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.detail ALTER COLUMN id_detail SET DEFAULT nextval('public.detail_id_liste_seq'::regclass);


--
-- TOC entry 3278 (class 2604 OID 24681)
-- Name: detail id_commande; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.detail ALTER COLUMN id_commande SET DEFAULT nextval('public.detail_id_commande_seq'::regclass);


--
-- TOC entry 3279 (class 2604 OID 24682)
-- Name: detail id_produit; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.detail ALTER COLUMN id_produit SET DEFAULT nextval('public.detail_id_produit_seq'::regclass);


--
-- TOC entry 3266 (class 2604 OID 24581)
-- Name: pays id_pays; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.pays ALTER COLUMN id_pays SET DEFAULT nextval('public.pays_id_pays_seq'::regclass);


--
-- TOC entry 3275 (class 2604 OID 24661)
-- Name: produit id_produit; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.produit ALTER COLUMN id_produit SET DEFAULT nextval('public.produit_id_produit_seq'::regclass);


--
-- TOC entry 3276 (class 2604 OID 24662)
-- Name: produit id_categorie; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.produit ALTER COLUMN id_categorie SET DEFAULT nextval('public.produit_id_categorie_seq'::regclass);


--
-- TOC entry 3280 (class 2604 OID 24700)
-- Name: produit_attributs id_produit; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.produit_attributs ALTER COLUMN id_produit SET DEFAULT nextval('public.produit_attributs_id_produit_seq'::regclass);


--
-- TOC entry 3281 (class 2604 OID 24701)
-- Name: produit_attributs id_attribut; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.produit_attributs ALTER COLUMN id_attribut SET DEFAULT nextval('public.produit_attributs_id_attribut_seq'::regclass);


--
-- TOC entry 3269 (class 2604 OID 24613)
-- Name: ville id_ville; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.ville ALTER COLUMN id_ville SET DEFAULT nextval('public.ville_id_ville_seq'::regclass);


--
-- TOC entry 3270 (class 2604 OID 24614)
-- Name: ville id_pays; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.ville ALTER COLUMN id_pays SET DEFAULT nextval('public.ville_id_pays_seq'::regclass);


--
-- TOC entry 3498 (class 0 OID 32956)
-- Dependencies: 242
-- Data for Name: admin; Type: TABLE DATA; Schema: public; Owner: kev
--

INSERT INTO public.admin VALUES (1, 'admin', 'admin');


--
-- TOC entry 3478 (class 0 OID 24600)
-- Dependencies: 219
-- Data for Name: attribut; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.attribut VALUES (1, 'duree');
INSERT INTO public.attribut VALUES (2, 'langue');
INSERT INTO public.attribut VALUES (3, 'Sous-titre 1');
INSERT INTO public.attribut VALUES (4, 'Sous-titre 2');
INSERT INTO public.attribut VALUES (5, 'Sous-titre 3');
INSERT INTO public.attribut VALUES (6, 'ISBN');
INSERT INTO public.attribut VALUES (7, 'Nombre de pages');
INSERT INTO public.attribut VALUES (8, 'Contenance');


--
-- TOC entry 3476 (class 0 OID 24589)
-- Dependencies: 217
-- Data for Name: categorie; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.categorie VALUES (2, 'Livres', 'book.jpg');
INSERT INTO public.categorie VALUES (3, 'Goodies', 'cup02.jpg');
INSERT INTO public.categorie VALUES (1, 'dvd', 'losing.jpg');


--
-- TOC entry 3484 (class 0 OID 24626)
-- Dependencies: 225
-- Data for Name: client; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.client VALUES (1, 'Pithivier', 'password', 'pithivier@mail.com', 1);
INSERT INTO public.client VALUES (5, 'test', 'test', 'test@gmail.com', 1);


--
-- TOC entry 3487 (class 0 OID 24644)
-- Dependencies: 228
-- Data for Name: commande; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.commande VALUES (2, 12.99, false, '2023-02-19', 1);


--
-- TOC entry 3494 (class 0 OID 24677)
-- Dependencies: 235
-- Data for Name: detail; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.detail VALUES (3, 1, 2, 1);
INSERT INTO public.detail VALUES (4, 1, 2, 2);


--
-- TOC entry 3474 (class 0 OID 24578)
-- Dependencies: 215
-- Data for Name: pays; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.pays VALUES (1, 'Belgique');
INSERT INTO public.pays VALUES (2, 'France');
INSERT INTO public.pays VALUES (3, 'Allemagne');
INSERT INTO public.pays VALUES (5, 'Espagne');
INSERT INTO public.pays VALUES (6, 'USA');
INSERT INTO public.pays VALUES (7, 'Chine');
INSERT INTO public.pays VALUES (8, 'Namek');
INSERT INTO public.pays VALUES (9, 'azd');


--
-- TOC entry 3490 (class 0 OID 24658)
-- Dependencies: 231
-- Data for Name: produit; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.produit VALUES (19, 'Tasse - "I don''t believe the Government"', 'Tasse - citation de George Carlin "I don''t believe anything the government tells me"', 14.99, 'images/cup03.jpg', 3);
INSERT INTO public.produit VALUES (20, 'Tasse - "Freedom"', 'Tasse - citation de Geroge Carlin "I love the freedom we used to have"', 14.99, 'images/cup04.jpg', 3);
INSERT INTO public.produit VALUES (3, 'Playin with your head', 'George Carlin HBO special - 1986 Beverly Theater (Los Angeles - California)', 12.99, 'images/playin.jpg', 1);
INSERT INTO public.produit VALUES (4, 'What Am I doing in New Jersey ?', 'George Carlin HBO special - 1988 Au Park performing arts center (Union City , New Jersey)', 12.99, 'images/jersey.jpg', 1);
INSERT INTO public.produit VALUES (2, 'Carlin at Carnegie', 'George Carlin  HBO special - 1982 au Carnegie hall (New York city)', 12.99, 'images/carnegie.jpg', 1);
INSERT INTO public.produit VALUES (7, 'Back in town', 'George Carlin HBO special - 1996 au Beacon Theater (New York city)', 12.99, 'images/town.jpg', 1);
INSERT INTO public.produit VALUES (6, 'Jammin in New-York', 'George Carlin HBO special : 1992 au Paramount Theater (Madison Square Garden, New York city)', 12.99, 'images/jammin.jpg', 1);
INSERT INTO public.produit VALUES (8, 'George Carlin : 40 years of Comedy', 'George Carlin HBO special - 1997 au Wheeler Opera House (Aspen, Colorado)', 10.99, 'images/forty.jpg', 1);
INSERT INTO public.produit VALUES (9, 'You are all diseased', 'George Carlin HBO special - 1999 au Beacon Theater (New York city)', 12.99, 'images/diseased.jpg', 1);
INSERT INTO public.produit VALUES (10, 'Complaints and grievances', 'George Carlin HBO special - 2001 au Beacon Theater (New York city)', 12.99, 'images/complaint.jpg', 1);
INSERT INTO public.produit VALUES (11, 'Life is worth losing', 'George Carlin HBO special - 2006 au Beacon Theater (New York city)', 12.99, 'images/losing.jpg', 1);
INSERT INTO public.produit VALUES (12, 'It''s bad for ya', 'George Carlin HBO special - 2008 au Wells Fargo center for the Arts (Santa Rosa, Californie)', 12.99, 'images/bad.jpg', 1);
INSERT INTO public.produit VALUES (5, 'Doin it again', 'George Carlin HBO special : 1990 au State Theatre (New Brunswick, New Jersey)', 12.99, 'images/again.webp', 1);
INSERT INTO public.produit VALUES (13, 'Brain droppings', 'Recueil de pensées, d''observations et d''humour sarcastique de l''humoriste George Carlin. Dans ce livre, Carlin aborde des sujets variés tels que la politique, la religion, la société et la vie quotidienne, tout en offrant des commentaires cyniques et perspicaces sur ces sujets. "Brain Droppings" est un livre divertissant et stimulant qui encourage les lecteurs à remettre en question leurs propres croyances et à penser de manière critique sur le monde qui les entoure.', 18.99, 'images/drop.jpg
', 2);
INSERT INTO public.produit VALUES (16, 'Last words', 'Le célèbre comédien américain, raconte sa vie et sa carrière, en offrant un regard introspectif sur sa personnalité et ses pensées. Le livre retrace les moments clés de la vie de Carlin, des débuts de sa carrière comique jusqu''à sa consécration en tant que légende du stand-up. À travers ses histoires et ses anecdotes, Carlin donne un aperçu de son processus créatif et de sa philosophie de vie.', 18.99, 'images/words.jpg', 2);
INSERT INTO public.produit VALUES (17, 'Tasse : "don''t sweat the petty things"', 'Tasse - citation de George Carlin "Don''t sweat the petty things and don''t pet the sweaty things"', 14.99, 'Images/cup01.jpg', 3);
INSERT INTO public.produit VALUES (18, 'Tasse - "political correctness"', 'Tasse - citation de George Carlin "Political correctness is facism pretending to be manners"', 14.99, 'images/cup02.jpg', 3);
INSERT INTO public.produit VALUES (1, 'George Carlin : Again !', 'George Carlin HBO special  - 1978 au Celibrity Theatre (Phoenix - Arizona)', 12.99, 'images/again2.jpg', 1);
INSERT INTO public.produit VALUES (15, 'When will Jesus bring the pork chops ?', 'Dans ce Livre,  George Carlin, célèbre humoriste américain, offre un regard satirique sur la société contemporaine. À travers ses observations sur la politique, la religion, la technologie, la langue et bien d''autres sujets, Carlin met en lumière les absurdités et les hypocrisies de la vie moderne.', 16.99, 'images/chops.jpg', 2);
INSERT INTO public.produit VALUES (14, 'Napalm & silly putty', 'Dans ce livre, Carlin aborde des sujets controversés tels que la religion, la politique, la culture populaire et les relations humaines, tout en y apportant son humour caustique et souvent provocateur. Ce livre est un recueil de pensées et de réflexions du célèbre comédien, qui se distingue par son style unique et son point de vue non conventionnel.', 16.99, 'images/napalm.jpg', 2);


--
-- TOC entry 3497 (class 0 OID 24697)
-- Dependencies: 238
-- Data for Name: produit_attributs; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.produit_attributs VALUES (1, 2, 'Anglais');
INSERT INTO public.produit_attributs VALUES (1, 3, 'Anglais');
INSERT INTO public.produit_attributs VALUES (1, 1, '81');
INSERT INTO public.produit_attributs VALUES (1, 4, 'Français');
INSERT INTO public.produit_attributs VALUES (1, 5, 'Néerlandais');
INSERT INTO public.produit_attributs VALUES (2, 1, '56');
INSERT INTO public.produit_attributs VALUES (2, 2, 'Anglais');
INSERT INTO public.produit_attributs VALUES (2, 3, 'Anglais');
INSERT INTO public.produit_attributs VALUES (2, 4, 'Français');
INSERT INTO public.produit_attributs VALUES (2, 5, 'Néerlandais');
INSERT INTO public.produit_attributs VALUES (3, 1, '48');
INSERT INTO public.produit_attributs VALUES (3, 2, 'Anglais');
INSERT INTO public.produit_attributs VALUES (3, 3, 'Anglais');
INSERT INTO public.produit_attributs VALUES (3, 4, 'Français');
INSERT INTO public.produit_attributs VALUES (3, 5, 'Néerlandais');
INSERT INTO public.produit_attributs VALUES (4, 1, '48');
INSERT INTO public.produit_attributs VALUES (4, 2, 'Anglais');
INSERT INTO public.produit_attributs VALUES (4, 3, 'Anglais');
INSERT INTO public.produit_attributs VALUES (4, 4, 'Français');
INSERT INTO public.produit_attributs VALUES (4, 5, 'Néerlandais');
INSERT INTO public.produit_attributs VALUES (5, 1, '53');
INSERT INTO public.produit_attributs VALUES (5, 2, 'Anglais');
INSERT INTO public.produit_attributs VALUES (5, 3, 'Anglais');
INSERT INTO public.produit_attributs VALUES (5, 4, 'Français');
INSERT INTO public.produit_attributs VALUES (5, 5, 'Néerlandais');
INSERT INTO public.produit_attributs VALUES (6, 1, '57');
INSERT INTO public.produit_attributs VALUES (6, 2, 'Anglais');
INSERT INTO public.produit_attributs VALUES (6, 3, 'Anglais');
INSERT INTO public.produit_attributs VALUES (6, 4, 'Français');
INSERT INTO public.produit_attributs VALUES (6, 5, 'Néerlandais');
INSERT INTO public.produit_attributs VALUES (7, 1, '61');
INSERT INTO public.produit_attributs VALUES (7, 2, 'Anglais');
INSERT INTO public.produit_attributs VALUES (7, 3, 'Anglais');
INSERT INTO public.produit_attributs VALUES (7, 4, 'Français');
INSERT INTO public.produit_attributs VALUES (7, 5, 'Néerlandais');
INSERT INTO public.produit_attributs VALUES (8, 1, '59');
INSERT INTO public.produit_attributs VALUES (8, 2, 'Anglais');
INSERT INTO public.produit_attributs VALUES (8, 3, 'Anglais');
INSERT INTO public.produit_attributs VALUES (8, 4, 'Français');
INSERT INTO public.produit_attributs VALUES (8, 5, 'Néerlandais');
INSERT INTO public.produit_attributs VALUES (9, 1, '62');
INSERT INTO public.produit_attributs VALUES (9, 2, 'Anglais');
INSERT INTO public.produit_attributs VALUES (9, 3, 'Anglais');
INSERT INTO public.produit_attributs VALUES (9, 4, 'Français');
INSERT INTO public.produit_attributs VALUES (9, 5, 'Néerlandais');
INSERT INTO public.produit_attributs VALUES (10, 1, '56');
INSERT INTO public.produit_attributs VALUES (10, 2, 'Anglais');
INSERT INTO public.produit_attributs VALUES (10, 3, 'Anglais');
INSERT INTO public.produit_attributs VALUES (10, 4, 'Français');
INSERT INTO public.produit_attributs VALUES (10, 5, 'Néerlandais');
INSERT INTO public.produit_attributs VALUES (11, 1, '71');
INSERT INTO public.produit_attributs VALUES (11, 2, 'Anglais');
INSERT INTO public.produit_attributs VALUES (11, 3, 'Anglais');
INSERT INTO public.produit_attributs VALUES (11, 4, 'Français');
INSERT INTO public.produit_attributs VALUES (11, 5, 'Néerlandais');
INSERT INTO public.produit_attributs VALUES (12, 1, '67');
INSERT INTO public.produit_attributs VALUES (12, 2, 'Anglais');
INSERT INTO public.produit_attributs VALUES (12, 3, 'Anglais');
INSERT INTO public.produit_attributs VALUES (12, 4, 'Français');
INSERT INTO public.produit_attributs VALUES (12, 5, 'Néerlandais');
INSERT INTO public.produit_attributs VALUES (13, 6, '978-0-7868-9112-2');
INSERT INTO public.produit_attributs VALUES (13, 7, '272');
INSERT INTO public.produit_attributs VALUES (14, 6, '978-0-7868-6413-3');
INSERT INTO public.produit_attributs VALUES (14, 7, '272');
INSERT INTO public.produit_attributs VALUES (15, 6, '978-1-4013-0134-7');
INSERT INTO public.produit_attributs VALUES (15, 7, '300');
INSERT INTO public.produit_attributs VALUES (16, 6, '1-4391-7295-1');
INSERT INTO public.produit_attributs VALUES (16, 7, '320');
INSERT INTO public.produit_attributs VALUES (17, 8, '335 ml');
INSERT INTO public.produit_attributs VALUES (18, 8, '335 ml');
INSERT INTO public.produit_attributs VALUES (19, 8, '325 ml');
INSERT INTO public.produit_attributs VALUES (20, 8, '335 ml');


--
-- TOC entry 3481 (class 0 OID 24610)
-- Dependencies: 222
-- Data for Name: ville; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.ville VALUES (1, 'Mons', '7000', 1);
INSERT INTO public.ville VALUES (2, 'Paris', '75001', 2);
INSERT INTO public.ville VALUES (3, 'Berlin', '10115', 3);
INSERT INTO public.ville VALUES (4, 'Bruxelles', '1000', 1);
INSERT INTO public.ville VALUES (5, 'La louvière', '7100', 1);
INSERT INTO public.ville VALUES (6, 'Cologne', '50667', 3);
INSERT INTO public.ville VALUES (7, 'Madrid', '28001', 5);
INSERT INTO public.ville VALUES (9, 'Hongzu', '198989', 7);
INSERT INTO public.ville VALUES (10, 'Picolo', '12912912', 8);
INSERT INTO public.ville VALUES (11, 'azd', '81828', 9);


--
-- TOC entry 3520 (class 0 OID 0)
-- Dependencies: 218
-- Name: attribut_id_attribut_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.attribut_id_attribut_seq', 2, true);


--
-- TOC entry 3521 (class 0 OID 0)
-- Dependencies: 216
-- Name: categorie_id_categorie_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.categorie_id_categorie_seq', 1, true);


--
-- TOC entry 3522 (class 0 OID 0)
-- Dependencies: 223
-- Name: client_id_client_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.client_id_client_seq', 5, true);


--
-- TOC entry 3523 (class 0 OID 0)
-- Dependencies: 224
-- Name: client_id_ville_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.client_id_ville_seq', 1, false);


--
-- TOC entry 3524 (class 0 OID 0)
-- Dependencies: 227
-- Name: commande_id_client_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.commande_id_client_seq', 1, false);


--
-- TOC entry 3525 (class 0 OID 0)
-- Dependencies: 226
-- Name: commande_id_commande_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.commande_id_commande_seq', 2, true);


--
-- TOC entry 3526 (class 0 OID 0)
-- Dependencies: 233
-- Name: detail_id_commande_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.detail_id_commande_seq', 1, false);


--
-- TOC entry 3527 (class 0 OID 0)
-- Dependencies: 232
-- Name: detail_id_liste_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.detail_id_liste_seq', 3, true);


--
-- TOC entry 3528 (class 0 OID 0)
-- Dependencies: 234
-- Name: detail_id_produit_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.detail_id_produit_seq', 1, false);


--
-- TOC entry 3529 (class 0 OID 0)
-- Dependencies: 214
-- Name: pays_id_pays_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.pays_id_pays_seq', 9, true);


--
-- TOC entry 3530 (class 0 OID 0)
-- Dependencies: 237
-- Name: produit_attributs_id_attribut_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.produit_attributs_id_attribut_seq', 1, false);


--
-- TOC entry 3531 (class 0 OID 0)
-- Dependencies: 236
-- Name: produit_attributs_id_produit_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.produit_attributs_id_produit_seq', 1, false);


--
-- TOC entry 3532 (class 0 OID 0)
-- Dependencies: 230
-- Name: produit_id_categorie_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.produit_id_categorie_seq', 1, true);


--
-- TOC entry 3533 (class 0 OID 0)
-- Dependencies: 229
-- Name: produit_id_produit_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.produit_id_produit_seq', 96, true);


--
-- TOC entry 3534 (class 0 OID 0)
-- Dependencies: 221
-- Name: ville_id_pays_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.ville_id_pays_seq', 1, false);


--
-- TOC entry 3535 (class 0 OID 0)
-- Dependencies: 220
-- Name: ville_id_ville_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.ville_id_ville_seq', 11, true);


--
-- TOC entry 3313 (class 2606 OID 32962)
-- Name: admin admin_pkey; Type: CONSTRAINT; Schema: public; Owner: kev
--

ALTER TABLE ONLY public.admin
    ADD CONSTRAINT admin_pkey PRIMARY KEY (id_admin);


--
-- TOC entry 3293 (class 2606 OID 24607)
-- Name: attribut attribut_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.attribut
    ADD CONSTRAINT attribut_pkey PRIMARY KEY (id_attribut);


--
-- TOC entry 3289 (class 2606 OID 24598)
-- Name: categorie categorie_nom_categorie_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.categorie
    ADD CONSTRAINT categorie_nom_categorie_key UNIQUE (nom_categorie);


--
-- TOC entry 3291 (class 2606 OID 24596)
-- Name: categorie categorie_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.categorie
    ADD CONSTRAINT categorie_pkey PRIMARY KEY (id_categorie);


--
-- TOC entry 3297 (class 2606 OID 24636)
-- Name: client client_email_client_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.client
    ADD CONSTRAINT client_email_client_key UNIQUE (email_client);


--
-- TOC entry 3299 (class 2606 OID 24634)
-- Name: client client_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.client
    ADD CONSTRAINT client_pkey PRIMARY KEY (id_client);


--
-- TOC entry 3301 (class 2606 OID 24650)
-- Name: commande commande_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.commande
    ADD CONSTRAINT commande_pkey PRIMARY KEY (id_commande);


--
-- TOC entry 3307 (class 2606 OID 24684)
-- Name: detail detail_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.detail
    ADD CONSTRAINT detail_pkey PRIMARY KEY (id_detail);


--
-- TOC entry 3309 (class 2606 OID 24730)
-- Name: detail idcom_idprod_uk; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.detail
    ADD CONSTRAINT idcom_idprod_uk UNIQUE (id_commande, id_produit);


--
-- TOC entry 3285 (class 2606 OID 24587)
-- Name: pays pays_nom_pays_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.pays
    ADD CONSTRAINT pays_nom_pays_key UNIQUE (nom_pays);


--
-- TOC entry 3287 (class 2606 OID 24585)
-- Name: pays pays_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.pays
    ADD CONSTRAINT pays_pkey PRIMARY KEY (id_pays);


--
-- TOC entry 3282 (class 2606 OID 24725)
-- Name: commande prix_comm_chk; Type: CHECK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE public.commande
    ADD CONSTRAINT prix_comm_chk CHECK ((prix_comm > (0)::numeric)) NOT VALID;


--
-- TOC entry 3311 (class 2606 OID 24705)
-- Name: produit_attributs produit_attributs_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.produit_attributs
    ADD CONSTRAINT produit_attributs_pkey PRIMARY KEY (id_produit, id_attribut);


--
-- TOC entry 3303 (class 2606 OID 24668)
-- Name: produit produit_nom_produit_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.produit
    ADD CONSTRAINT produit_nom_produit_key UNIQUE (nom_produit);


--
-- TOC entry 3305 (class 2606 OID 24666)
-- Name: produit produit_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.produit
    ADD CONSTRAINT produit_pkey PRIMARY KEY (id_produit);


--
-- TOC entry 3283 (class 2606 OID 24726)
-- Name: detail qtite_chk; Type: CHECK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE public.detail
    ADD CONSTRAINT qtite_chk CHECK ((quantite > 0)) NOT VALID;


--
-- TOC entry 3295 (class 2606 OID 24618)
-- Name: ville ville_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.ville
    ADD CONSTRAINT ville_pkey PRIMARY KEY (id_ville);


--
-- TOC entry 3315 (class 2606 OID 24637)
-- Name: client client_id_ville_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.client
    ADD CONSTRAINT client_id_ville_fkey FOREIGN KEY (id_ville) REFERENCES public.ville(id_ville);


--
-- TOC entry 3316 (class 2606 OID 24651)
-- Name: commande commande_id_client_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.commande
    ADD CONSTRAINT commande_id_client_fkey FOREIGN KEY (id_client) REFERENCES public.client(id_client);


--
-- TOC entry 3318 (class 2606 OID 24685)
-- Name: detail detail_id_commande_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.detail
    ADD CONSTRAINT detail_id_commande_fkey FOREIGN KEY (id_commande) REFERENCES public.commande(id_commande);


--
-- TOC entry 3319 (class 2606 OID 24690)
-- Name: detail detail_id_produit_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.detail
    ADD CONSTRAINT detail_id_produit_fkey FOREIGN KEY (id_produit) REFERENCES public.produit(id_produit);


--
-- TOC entry 3320 (class 2606 OID 24711)
-- Name: produit_attributs produit_attributs_id_attribut_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.produit_attributs
    ADD CONSTRAINT produit_attributs_id_attribut_fkey FOREIGN KEY (id_attribut) REFERENCES public.attribut(id_attribut);


--
-- TOC entry 3321 (class 2606 OID 24706)
-- Name: produit_attributs produit_attributs_id_produit_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.produit_attributs
    ADD CONSTRAINT produit_attributs_id_produit_fkey FOREIGN KEY (id_produit) REFERENCES public.produit(id_produit);


--
-- TOC entry 3317 (class 2606 OID 24669)
-- Name: produit produit_id_categorie_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.produit
    ADD CONSTRAINT produit_id_categorie_fkey FOREIGN KEY (id_categorie) REFERENCES public.categorie(id_categorie);


--
-- TOC entry 3314 (class 2606 OID 24619)
-- Name: ville ville_id_pays_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.ville
    ADD CONSTRAINT ville_id_pays_fkey FOREIGN KEY (id_pays) REFERENCES public.pays(id_pays);


-- Completed on 2023-06-12 22:24:25

--
-- PostgreSQL database dump complete
--

