--
-- PostgreSQL database dump
--

-- Dumped from database version 14.0 (Ubuntu 14.0-1.pgdg20.04+1)
-- Dumped by pg_dump version 14.0 (Ubuntu 14.0-1.pgdg20.04+1)

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
-- Name: attribue; Type: TABLE; Schema: public; Owner: dqd
--

CREATE TABLE public.attribue (
    id_profil integer NOT NULL,
    nom character varying(25) NOT NULL,
    titre_vid character varying(50) NOT NULL
);


ALTER TABLE public.attribue OWNER TO dqd;

--
-- Name: note; Type: TABLE; Schema: public; Owner: dqd
--

CREATE TABLE public.note (
    id_profil integer NOT NULL,
    titre_vid character varying(50) NOT NULL,
    note numeric,
    CONSTRAINT note_note_check CHECK (((note >= 0.0) AND (note <= 10.0)))
);


ALTER TABLE public.note OWNER TO dqd;

--
-- Name: video; Type: TABLE; Schema: public; Owner: dqd
--

CREATE TABLE public.video (
    titre_vid character varying(50) NOT NULL,
    annee_prod integer NOT NULL,
    duree time without time zone NOT NULL,
    id_personne integer,
    titre_ser character varying(50),
    saison integer,
    episode integer
);


ALTER TABLE public.video OWNER TO dqd;

--
-- Name: bestfilms; Type: VIEW; Schema: public; Owner: dqd
--

CREATE VIEW public.bestfilms AS
 SELECT note.titre_vid AS films,
    avg(note.note) AS note
   FROM (public.note
     JOIN public.video USING (titre_vid))
  WHERE (video.titre_ser IS NULL)
  GROUP BY note.titre_vid
  ORDER BY (avg(note.note)) DESC
 LIMIT 10;


ALTER TABLE public.bestfilms OWNER TO dqd;

--
-- Name: compte; Type: TABLE; Schema: public; Owner: dqd
--

CREATE TABLE public.compte (
    id_compte integer NOT NULL,
    nom character varying(25) NOT NULL,
    prenom character varying(25) NOT NULL,
    adresse text NOT NULL,
    courriel character varying(50) NOT NULL,
    mdp text NOT NULL,
    type_abo integer NOT NULL,
    datefin_abo date NOT NULL,
    CONSTRAINT compte_courriel_check CHECK (((courriel)::text ~~ '%@%'::text)),
    CONSTRAINT compte_type_abo_check CHECK ((type_abo = ANY (ARRAY[0, 1])))
);


ALTER TABLE public.compte OWNER TO dqd;

--
-- Name: joue; Type: TABLE; Schema: public; Owner: dqd
--

CREATE TABLE public.joue (
    id_personne integer NOT NULL,
    id_personnage integer NOT NULL,
    titre_vid character varying(50) NOT NULL
);


ALTER TABLE public.joue OWNER TO dqd;

--
-- Name: personnage; Type: TABLE; Schema: public; Owner: dqd
--

CREATE TABLE public.personnage (
    id_personnage integer NOT NULL,
    nom character varying(25) NOT NULL
);


ALTER TABLE public.personnage OWNER TO dqd;

--
-- Name: personne; Type: TABLE; Schema: public; Owner: dqd
--

CREATE TABLE public.personne (
    id_personne integer NOT NULL,
    nom character varying(25) NOT NULL,
    prenom character varying(25) NOT NULL
);


ALTER TABLE public.personne OWNER TO dqd;

--
-- Name: profil; Type: TABLE; Schema: public; Owner: dqd
--

CREATE TABLE public.profil (
    id_profil integer NOT NULL,
    nom character varying(25) NOT NULL,
    id_compte integer NOT NULL
);


ALTER TABLE public.profil OWNER TO dqd;

--
-- Name: visionnage; Type: TABLE; Schema: public; Owner: dqd
--

CREATE TABLE public.visionnage (
    id_visio integer NOT NULL,
    duree time without time zone NOT NULL,
    fin integer NOT NULL,
    id_profil integer,
    titre_vid character varying(50),
    CONSTRAINT visionnage_fin_check CHECK ((fin = ANY (ARRAY[0, 1])))
);


ALTER TABLE public.visionnage OWNER TO dqd;

--
-- Data for Name: attribue; Type: TABLE DATA; Schema: public; Owner: dqd
--

COPY public.attribue (id_profil, nom, titre_vid) FROM stdin;
4	action	Ennemie
4	horreur	Desespoir
4	paranormal	Enfer
4	horreur	L"homme Tronconneuse
4	paranormal	Malédiction
5	en famille	Shrek
5	comedie	Shrek
5	en famille	Le Grinch
5	comedie	Mr. Bean
5	enfantin	La maison de la panthère rose
6	comedie	Oups
6	comedie	Ole!!
6	action	Le garçon sans abri
6	badass	Rencontre avec le coach Mickey
7	horreur	Slender Man
7	horreur	Saw
7	horreur	Dos
7	action	Peter l"homme araignée
\.


--
-- Data for Name: compte; Type: TABLE DATA; Schema: public; Owner: dqd
--

COPY public.compte (id_compte, nom, prenom, adresse, courriel, mdp, type_abo, datefin_abo) FROM stdin;
1	Bilodeau	Oliver	20, avenue Lemonnier	Bilolo@gmail.com	47bce5c74f589f4867dbd57e9ca9f808	1	2022-05-22
2	Burrows	Ethan	Vertoordreef 2	Burr@gmail.com	d2f2297d6e829cd3493aa7de4416a18f	0	2022-03-12
3	Potvin	Jeanette	avenue Thierry Guibert	Pot@gmail.com	4a82a984abeb41e09765f66cc26ef518	1	2022-01-15
\.


--
-- Data for Name: joue; Type: TABLE DATA; Schema: public; Owner: dqd
--

COPY public.joue (id_personne, id_personnage, titre_vid) FROM stdin;
15	1	Venom
16	2	Venom
17	3	Infinite
18	4	Infinite
19	5	Infinite
20	6	Jolt
21	7	Jolt
22	8	Jolt
23	9	Drive or Die
24	10	Drive or Die
25	11	Drive or Die
26	12	Annabelle
26	13	Slender Man
26	14	Saw
27	15	Dos
28	16	Queenpins
29	17	Queenpins
30	18	On sera 2!
31	19	On sera 2!
32	20	La cassette
33	21	La cassette
34	22	Shrek
34	23	Le Grinch
35	24	Les Minions
36	25	Les Minions
35	26	Vivo
36	27	Vivo
16	28	Ennemie
17	29	Ennemie
17	29	Prendre les armes
18	30	Prendre les armes
16	28	Au feu
17	29	Au feu
18	30	Au feu
18	30	Face au danger
16	28	Rouge
16	28	Sang
16	28	Otage
17	29	Otage
18	30	Otage
19	31	Otage
17	29	Discussion
18	30	Discussion
19	31	Discussion
16	28	Sauvetage
17	29	Sauvetage
18	30	Sauvetage
19	31	Sauvetage
26	32	Desespoir
27	33	Enfer
37	34	Mort
38	35	Au diable
39	36	Ténèbre
40	37	Sombre
28	38	Oups
29	39	Oups
28	38	Ole!!
29	39	Ole!!
28	38	Chocolat
29	39	Chocolat
28	38	Aie Aie
29	39	Aie Aie
28	38	Calamar
29	39	Calamar
28	38	Petard
29	39	Petard
28	38	Le voilà
29	39	Le voilà
28	38	Bonbon
29	39	Bonbon
28	38	Wow
15	40	L"homme Tronconneuse
16	41	L"homme Tronconneuse
17	42	L"homme Tronconneuse
15	40	Malédiction
16	41	Malédiction
17	42	Malédiction
15	40	Rassemblement
16	41	Rassemblement
17	42	Rassemblement
15	40	Opération
16	41	Opération
17	42	Opération
15	40	Démon
16	41	Démon
17	42	Démon
15	40	Guérison
16	41	Guérison
17	42	Guérison
18	43	Une famille heureuse
19	44	Une famille heureuse
18	43	Séparation
19	44	Séparation
19	44	Eva la démonne
20	45	Heisenberg
19	44	Opération sauvetage !
20	45	Opération sauvetage !
18	43	Combat final
19	44	Combat final
20	45	Combat final
21	47	Le garçon sans abri
21	47	Rencontre avec le coach Mickey
22	48	Rencontre avec le coach Mickey
21	47	Vers le titre mondial
22	48	Vers le titre mondial
21	47	Combat contre Dempsey
23	49	Combat contre Dempsey
21	47	Adversaire redoutable
23	49	Adversaire redoutable
21	47	Champion du monde
24	50	Peter l"homme araignée
25	51	Oncle Ben
24	50	Course poursuite
26	52	Course poursuite
24	50	Vengeance
26	52	Vengeance
26	52	Bouffon vert
27	53	Mr. Bean
27	53	Les malheurs de Mr.Bean
27	53	Mr.Bean va en ville
27	53	Joyeux Noël Mr.Bean
27	53	Mr.bean va à l"école
27	53	Au revoir Mr.Bean
28	54	La maison de la panthère rose
28	54	La panthère à l"hopital
28	54	Le génie rose de la lampe
28	54	Le chevalier rose
28	54	Chien dangereux
28	54	Panthère contre Dracula
29	55	Panthère contre Dracula
28	54	La panthère au restaurant
\.


--
-- Data for Name: note; Type: TABLE DATA; Schema: public; Owner: dqd
--

COPY public.note (id_profil, titre_vid, note) FROM stdin;
4	Desespoir	8.0
4	Enfer	8.0
5	Shrek	9.5
6	Oups	7.7
7	Slender Man	4.5
7	Saw	5.5
4	L"homme Tronconneuse	8.5
5	La maison de la panthère rose	2
6	Le garçon sans abri	7.9
6	Rencontre avec le coach Mickey	9.8
6	Vers le titre mondial	9.5
8	Venom	10.0
8	Infinite	9.5
8	Jolt	9.8
\.


--
-- Data for Name: personnage; Type: TABLE DATA; Schema: public; Owner: dqd
--

COPY public.personnage (id_personnage, nom) FROM stdin;
1	Venom
2	Thierry
3	Nita
4	Bob
5	James
6	Bond
7	Joe
8	Michel
9	Alice
10	Aguni
11	Sam
12	Annabelle
13	Slender Man
14	Saw
15	Lupin
16	Thibault
17	Théo
18	Lya
19	Cristi
20	Robert
21	Jean
22	Shrek
23	Le Grinch
24	Bob
25	Grue
26	Vivo
27	Andrés
28	Helmer
29	Ines
30	Mathys
31	Lena
32	Laura
33	Lee
34	Bruce
35	Pauwels
36	Baki
37	Arima
38	Kosei
39	Gordi
40	Cochon
41	Démon
42	Sylvain
43	Levi
44	Eva
45	Jeon
47	Mr.Joe
48	Mickey
49	Dempsey
50	Peter
51	Oncle Ben
52	Bouffon vert
53	Mr.Bean
54	Panthere rose
55	Dracula
\.


--
-- Data for Name: personne; Type: TABLE DATA; Schema: public; Owner: dqd
--

COPY public.personne (id_personne, nom, prenom) FROM stdin;
1	Rocher	Hamilton
2	Aubrette	Guédry
3	Aubrette	Guédry
4	Couet	Laurent
5	Favreau	Harbin
6	Hugh	Hervé
7	Dufresne	Alexis
8	Tyson	Thibault
9	Turcotte	Jeoffroi
10	Karel	Michel
11	Léveillé	Iven
12	Meunier	Eliot
13	Jetté	Noelle
14	Bélanger	Eugène
15	Couet	Laurent
16	Perillard	Aymon
17	Coulombe	Sydney
18	Charbonneau	Fantina
19	Mousseau	Roslyn
20	Leverett	Bernard
21	Bosmans	Ferre
22	Gay	Jodion
23	Jonas	Simon
24	Lefebre	Ella
25	Prohaska	Nicolas
26	Clare	Wiza
27	Miller	Terry
28	Vivien	Spencer
29	Katelin	Rippin
30	Grace	Zulauf
31	Monroe	Hilper
32	Schumm	Ken
33	Sporer	Lacey
34	Margie	Will
35	Torp	Ophelia
36	Legros	Keon
37	Emard	Brody
38	Cristian	Hirthe
39	Marks	Kamryn
40	Moore	Liliana
\.


--
-- Data for Name: profil; Type: TABLE DATA; Schema: public; Owner: dqd
--

COPY public.profil (id_profil, nom, id_compte) FROM stdin;
4	Bilo	1
5	Bilo2	1
6	ethan	2
7	jeanette	3
8	janet	3
\.


--
-- Data for Name: video; Type: TABLE DATA; Schema: public; Owner: dqd
--

COPY public.video (titre_vid, annee_prod, duree, id_personne, titre_ser, saison, episode) FROM stdin;
Venom	2018	00:02:00	1	\N	\N	\N
Infinite	2021	00:02:00	1	\N	\N	\N
Jolt	2021	00:02:00	2	\N	\N	\N
Drive or Die	2021	00:02:00	3	\N	\N	\N
Annabelle	2014	00:02:00	4	\N	\N	\N
Slender Man	2018	00:02:00	4	\N	\N	\N
Saw	2004	00:02:00	4	\N	\N	\N
Dos	2021	00:02:00	5	\N	\N	\N
Queenpins	2021	00:02:00	6	\N	\N	\N
On sera 2!	2021	00:02:00	7	\N	\N	\N
La cassette	2021	00:02:00	8	\N	\N	\N
Shrek	2001	00:02:00	9	\N	\N	\N
Le Grinch	2018	00:02:00	10	\N	\N	\N
Les Minions	2017	00:02:00	10	\N	\N	\N
Vivo	2021	00:02:00	11	\N	\N	\N
Ennemie	2009	00:02:00	12	FBI	1	1
Prendre les armes	2009	00:02:00	12	FBI	1	2
Au feu	2009	00:02:00	12	FBI	1	3
Face au danger	2009	00:02:00	12	FBI	2	1
Rouge	2009	00:02:00	12	FBI	2	2
Sang	2009	00:02:00	12	FBI	2	3
Otage	2009	00:02:00	12	FBI	3	1
Discussion	2009	00:02:00	12	FBI	3	2
Sauvetage	2009	00:02:00	12	FBI	3	3
Desespoir	2021	00:02:00	13	Ghost	1	1
Enfer	2021	00:02:00	13	Ghost	1	2
Mort	2021	00:02:00	13	Ghost	1	3
Au diable	2021	00:02:00	13	Ghost	1	4
Ténèbre	2021	00:02:00	13	Ghost	1	5
Sombre	2021	00:02:00	13	Ghost	1	6
Oups	2005	00:02:00	14	Alibaba	1	1
Ole!!	2005	00:02:00	14	Alibaba	1	2
Chocolat	2005	00:02:00	14	Alibaba	1	3
Aie Aie	2005	00:02:00	14	Alibaba	1	4
Calamar	2005	00:02:00	14	Alibaba	1	5
Petard	2005	00:02:00	14	Alibaba	2	1
Le voilà	2005	00:02:00	14	Alibaba	2	2
Bonbon	2005	00:02:00	14	Alibaba	2	3
Wow	2005	00:02:00	14	Alibaba	2	4
L"homme Tronconneuse	1997	00:02:00	13	Chainsaw Man	1	1
Malédiction	1997	00:02:00	13	Chainsaw	1	2
Rassemblement	1997	00:02:00	13	Chainsaw	1	3
Opération	1997	00:02:00	13	Chainsaw	2	1
Démon	1997	00:02:00	13	Chainsaw	2	2
Guérison	1997	00:02:00	13	Chainsaw	2	3
Une famille heureuse	2001	00:02:00	5	Resident Evil	1	1
Séparation	2001	00:02:00	5	Resident Evil	1	2
Eva la démonne	2001	00:02:00	5	Resident Evil	2	1
Heisenberg	2001	00:02:00	5	Resident Evil	2	2
Opération sauvetage !	2001	00:02:00	5	Resident Evil	3	1
Combat final	2001	00:02:00	5	Resident Evil	3	2
Le garçon sans abri	1983	00:02:00	12	Rocky	1	1
Rencontre avec le coach Mickey	1983	00:02:00	12	Rocky	1	2
Vers le titre mondial	1983	00:02:00	12	Rocky	1	3
Combat contre Dempsey	1983	00:02:00	12	Rocky	1	4
Adversaire redoutable	1983	00:02:00	12	Rocky	1	5
Champion du monde	1983	00:02:00	12	Rocky	1	6
Peter l"homme araignée	1997	00:02:00	12	Spiderman	1	1
Oncle Ben	1997	00:02:00	12	Spiderman	1	2
Course poursuite	1997	00:02:00	12	Spiderman	1	3
Vengeance	1997	00:02:00	12	Spiderman	1	4
Bouffon vert	1997	00:02:00	12	Spiderman	1	5
Mr. Bean	2015	00:02:00	14	Mister bean	1	1
Les malheurs de Mr.Bean	2015	00:02:00	14	Mister bean	1	2
Mr.Bean va en ville	2015	00:02:00	14	Mister bean	1	3
Joyeux Noël Mr.Bean	2015	00:02:00	14	Mister bean	2	1
Mr.bean va à l"école	1983	00:02:00	14	Mister bean	2	2
Au revoir Mr.Bean	1983	00:02:00	14	Mister bean	2	3
La maison de la panthère rose	2003	00:02:00	8	Panthère Rose	1	1
La panthère à l"hopital	2003	00:02:00	8	Panthère Rose	1	2
Le génie rose de la lampe	2003	00:02:00	8	Panthère Rose	1	3
Le chevalier rose	2003	00:02:00	8	Panthère Rose	2	1
Chien dangereux	2003	00:02:00	8	Panthère Rose	2	2
Panthère contre Dracula	2003	00:02:00	8	Panthère Rose	3	1
La panthère au restaurant	2003	00:02:00	8	Panthère Rose	3	2
\.


--
-- Data for Name: visionnage; Type: TABLE DATA; Schema: public; Owner: dqd
--

COPY public.visionnage (id_visio, duree, fin, id_profil, titre_vid) FROM stdin;
1	00:02:00	1	4	Ennemie
2	00:01:05	0	4	Prendre les armes
3	00:02:00	1	4	Desespoir
4	00:02:00	1	4	Enfer
5	00:00:50	0	4	Mort
6	00:01:10	0	4	Annabelle
7	00:02:00	1	5	Shrek
8	00:01:05	0	5	Le Grinch
9	00:02:00	1	6	Oups
10	00:02:00	1	6	Ole!!
11	00:02:00	1	6	Chocolat
12	00:01:30	0	6	Aie Aie
13	00:02:00	1	7	Slender Man
14	00:02:00	1	7	Saw
15	00:02:00	1	7	Dos
16	00:02:00	1	4	L"homme Tronconneuse
17	00:00:30	0	4	Malédiction
18	00:02:00	1	5	Vivo
19	00:01:00	0	5	Mr. Bean
20	00:01:00	0	5	La maison de la panthère rose
21	00:02:00	1	6	Le garçon sans abri
22	00:02:00	1	6	Rencontre avec le coach Mickey
23	00:00:45	0	6	Vers le titre mondial
24	00:01:00	0	7	Peter l"homme araignée
25	00:00:40	0	7	Une famille heureuse
26	00:02:00	1	8	Venom
27	00:02:00	1	8	Infinite
28	00:02:00	1	8	Jolt
\.


--
-- Name: attribue attribue_pkey; Type: CONSTRAINT; Schema: public; Owner: dqd
--

ALTER TABLE ONLY public.attribue
    ADD CONSTRAINT attribue_pkey PRIMARY KEY (id_profil, nom, titre_vid);


--
-- Name: compte compte_courriel_key; Type: CONSTRAINT; Schema: public; Owner: dqd
--

ALTER TABLE ONLY public.compte
    ADD CONSTRAINT compte_courriel_key UNIQUE (courriel);


--
-- Name: compte compte_pkey; Type: CONSTRAINT; Schema: public; Owner: dqd
--

ALTER TABLE ONLY public.compte
    ADD CONSTRAINT compte_pkey PRIMARY KEY (id_compte);


--
-- Name: joue joue_pkey; Type: CONSTRAINT; Schema: public; Owner: dqd
--

ALTER TABLE ONLY public.joue
    ADD CONSTRAINT joue_pkey PRIMARY KEY (id_personne, id_personnage, titre_vid);


--
-- Name: note note_pkey; Type: CONSTRAINT; Schema: public; Owner: dqd
--

ALTER TABLE ONLY public.note
    ADD CONSTRAINT note_pkey PRIMARY KEY (id_profil, titre_vid);


--
-- Name: personnage personnage_pkey; Type: CONSTRAINT; Schema: public; Owner: dqd
--

ALTER TABLE ONLY public.personnage
    ADD CONSTRAINT personnage_pkey PRIMARY KEY (id_personnage);


--
-- Name: personne personne_pkey; Type: CONSTRAINT; Schema: public; Owner: dqd
--

ALTER TABLE ONLY public.personne
    ADD CONSTRAINT personne_pkey PRIMARY KEY (id_personne);


--
-- Name: profil profil_pkey; Type: CONSTRAINT; Schema: public; Owner: dqd
--

ALTER TABLE ONLY public.profil
    ADD CONSTRAINT profil_pkey PRIMARY KEY (id_profil);


--
-- Name: video video_pkey; Type: CONSTRAINT; Schema: public; Owner: dqd
--

ALTER TABLE ONLY public.video
    ADD CONSTRAINT video_pkey PRIMARY KEY (titre_vid);


--
-- Name: visionnage visionnage_pkey; Type: CONSTRAINT; Schema: public; Owner: dqd
--

ALTER TABLE ONLY public.visionnage
    ADD CONSTRAINT visionnage_pkey PRIMARY KEY (id_visio);


--
-- Name: attribue attribue_id_profil_fkey; Type: FK CONSTRAINT; Schema: public; Owner: dqd
--

ALTER TABLE ONLY public.attribue
    ADD CONSTRAINT attribue_id_profil_fkey FOREIGN KEY (id_profil) REFERENCES public.profil(id_profil) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: attribue attribue_titre_vid_fkey; Type: FK CONSTRAINT; Schema: public; Owner: dqd
--

ALTER TABLE ONLY public.attribue
    ADD CONSTRAINT attribue_titre_vid_fkey FOREIGN KEY (titre_vid) REFERENCES public.video(titre_vid) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: joue joue_id_personnage_fkey; Type: FK CONSTRAINT; Schema: public; Owner: dqd
--

ALTER TABLE ONLY public.joue
    ADD CONSTRAINT joue_id_personnage_fkey FOREIGN KEY (id_personnage) REFERENCES public.personnage(id_personnage) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: joue joue_id_personne_fkey; Type: FK CONSTRAINT; Schema: public; Owner: dqd
--

ALTER TABLE ONLY public.joue
    ADD CONSTRAINT joue_id_personne_fkey FOREIGN KEY (id_personne) REFERENCES public.personne(id_personne) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: joue joue_titre_vid_fkey; Type: FK CONSTRAINT; Schema: public; Owner: dqd
--

ALTER TABLE ONLY public.joue
    ADD CONSTRAINT joue_titre_vid_fkey FOREIGN KEY (titre_vid) REFERENCES public.video(titre_vid) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: note note_id_profil_fkey; Type: FK CONSTRAINT; Schema: public; Owner: dqd
--

ALTER TABLE ONLY public.note
    ADD CONSTRAINT note_id_profil_fkey FOREIGN KEY (id_profil) REFERENCES public.profil(id_profil) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: note note_titre_vid_fkey; Type: FK CONSTRAINT; Schema: public; Owner: dqd
--

ALTER TABLE ONLY public.note
    ADD CONSTRAINT note_titre_vid_fkey FOREIGN KEY (titre_vid) REFERENCES public.video(titre_vid) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: profil profil_id_compte_fkey; Type: FK CONSTRAINT; Schema: public; Owner: dqd
--

ALTER TABLE ONLY public.profil
    ADD CONSTRAINT profil_id_compte_fkey FOREIGN KEY (id_compte) REFERENCES public.compte(id_compte) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: video video_id_personne_fkey; Type: FK CONSTRAINT; Schema: public; Owner: dqd
--

ALTER TABLE ONLY public.video
    ADD CONSTRAINT video_id_personne_fkey FOREIGN KEY (id_personne) REFERENCES public.personne(id_personne) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: visionnage visionnage_id_profil_fkey; Type: FK CONSTRAINT; Schema: public; Owner: dqd
--

ALTER TABLE ONLY public.visionnage
    ADD CONSTRAINT visionnage_id_profil_fkey FOREIGN KEY (id_profil) REFERENCES public.profil(id_profil) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: visionnage visionnage_titre_vid_fkey; Type: FK CONSTRAINT; Schema: public; Owner: dqd
--

ALTER TABLE ONLY public.visionnage
    ADD CONSTRAINT visionnage_titre_vid_fkey FOREIGN KEY (titre_vid) REFERENCES public.video(titre_vid) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- PostgreSQL database dump complete
--

