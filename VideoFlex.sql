/*Création des Tables*/

CREATE TABLE Compte(
 id_compte integer PRIMARY KEY,
 nom varchar(25) not null,
 prenom varchar(25) not null,
 adresse text not null,
 courriel varchar(50) unique not null CHECK (courriel LIKE '%@%'),
 mdp text not null,
 type_abo int not null CHECK (type_abo IN (0, 1)),
 datefin_abo date not null
);

CREATE TABLE Profil(
 id_profil integer PRIMARY KEY,
 nom varchar(25) not null,
 id_compte integer not null,
 FOREIGN KEY (id_compte) REFERENCES Compte(id_compte) ON DELETE CASCADE ON UPDATE CASCADE
);

CREATE TABLE Personne(
 id_personne integer PRIMARY KEY,
 nom varchar(25) not null,
 prenom varchar(25) not null
);

CREATE TABLE Personnage(
 id_personnage integer PRIMARY KEY,
 nom varchar(25) not null
);


CREATE TABLE Video(
 titre_vid varchar(50) PRIMARY KEY,
 annee_prod integer not null,
 duree time not null,
 id_personne integer,
 titre_ser varchar(50),
 saison integer,
 episode integer,
 FOREIGN KEY (id_personne) REFERENCES Personne(id_personne) ON DELETE CASCADE ON UPDATE CASCADE
);

CREATE TABLE Visionnage(
 id_visio integer PRIMARY KEY,
 duree time not null,
 fin int not null CHECK (fin IN (0, 1)),
 id_profil integer,
 titre_vid varchar(50),
 FOREIGN KEY (id_profil) REFERENCES Profil(id_profil) ON DELETE CASCADE ON UPDATE CASCADE,
 FOREIGN KEY (titre_vid) REFERENCES Video(titre_vid) ON DELETE CASCADE ON UPDATE CASCADE
);


CREATE TABLE attribue(
 id_profil integer,
 nom varchar(25),
 titre_vid varchar(50),
 PRIMARY KEY (id_profil, nom, titre_vid),
 FOREIGN KEY (id_profil) REFERENCES Profil(id_profil) ON DELETE CASCADE ON UPDATE CASCADE,
 FOREIGN KEY (titre_vid) REFERENCES Video(titre_vid) ON DELETE CASCADE ON UPDATE CASCADE
);

CREATE TABLE joue(
 id_personne integer,
 id_personnage integer,
 titre_vid varchar(50),
 PRIMARY KEY (id_personne, id_personnage, titre_vid),
 FOREIGN KEY (id_personne) REFERENCES Personne(id_personne) ON DELETE CASCADE ON UPDATE CASCADE,
 FOREIGN KEY (id_personnage) REFERENCES Personnage(id_personnage) ON DELETE CASCADE ON UPDATE CASCADE,
 FOREIGN KEY (titre_vid) REFERENCES Video(titre_vid) ON DELETE CASCADE ON UPDATE CASCADE
);

CREATE TABLE note(
 id_profil integer,
 titre_vid varchar(50),
 note numeric CHECK (note BETWEEN 0.0 AND 10.0),
 PRIMARY KEY (id_profil, titre_vid),
 FOREIGN KEY (id_profil) REFERENCES Profil(id_profil) ON DELETE CASCADE ON UPDATE CASCADE,
 FOREIGN KEY (titre_vid) REFERENCES Video(titre_vid) ON DELETE CASCADE ON UPDATE CASCADE
);





/*Vue pour afficher le classement des 10 meilleurs films*/
CREATE VIEW bestFilms AS (
    SELECT titre_vid AS Films, avg(note) AS Note
    FROM note NATURAL JOIN Video
    WHERE titre_ser IS NULL
    GROUP BY titre_vid
    ORDER BY avg(note) DESC LIMIT 10
);




/*Insertion de quelques données*/
INSERT INTO Compte VALUES (1, 'Bilodeau', 'Oliver', '20, avenue Lemonnier', 'Bilolo@gmail.com', md5('aaa'), 1, '2022-05-22');
INSERT INTO Compte VALUES (2, 'Burrows', 'Ethan', 'Vertoordreef 2', 'Burr@gmail.com', md5('eee'), 0, '2022-03-12');
INSERT INTO Compte VALUES (3, 'Potvin', 'Jeanette', 'avenue Thierry Guibert', 'Pot@gmail.com', md5('miaou'), 1, '2022-01-15');


INSERT INTO Profil VALUES (4, 'Bilo', 1);
INSERT INTO Profil VALUES (5, 'Bilo2', 1);
INSERT INTO Profil VALUES (6, 'ethan', 2);
INSERT INTO Profil VALUES (7, 'jeanette', 3);
INSERT INTO Profil VALUES (8, 'janet', 3);





INSERT INTO Personne VALUES (1, 'Rocher', 'Hamilton');
INSERT INTO Personne VALUES (2, 'Aubrette', 'Guédry');
INSERT INTO Personne VALUES (3, 'Aubrette', 'Guédry');
INSERT INTO Personne VALUES (4, 'Couet', 'Laurent');
INSERT INTO Personne VALUES (5, 'Favreau', 'Harbin');
INSERT INTO Personne VALUES (6, 'Hugh', 'Hervé');
INSERT INTO Personne VALUES (7, 'Dufresne', 'Alexis');
INSERT INTO Personne VALUES (8, 'Tyson', 'Thibault');
INSERT INTO Personne VALUES (9, 'Turcotte', 'Jeoffroi');
INSERT INTO Personne VALUES (10, 'Karel', 'Michel');
INSERT INTO Personne VALUES (11, 'Léveillé', 'Iven');
INSERT INTO Personne VALUES (12, 'Meunier', 'Eliot');
INSERT INTO Personne VALUES (13, 'Jetté', 'Noelle');
INSERT INTO Personne VALUES (14, 'Bélanger', 'Eugène');

INSERT INTO Personne VALUES (15, 'Couet', 'Laurent');
INSERT INTO Personne VALUES (16, 'Perillard', 'Aymon');
INSERT INTO Personne VALUES (17, 'Coulombe', 'Sydney');
INSERT INTO Personne VALUES (18, 'Charbonneau', 'Fantina');
INSERT INTO Personne VALUES (19, 'Mousseau', 'Roslyn');
INSERT INTO Personne VALUES (20, 'Leverett', 'Bernard');
INSERT INTO Personne VALUES (21, 'Bosmans', 'Ferre');
INSERT INTO Personne VALUES (22, 'Gay', 'Jodion');
INSERT INTO Personne VALUES (23, 'Jonas', 'Simon');
INSERT INTO Personne VALUES (24, 'Lefebre', 'Ella');
INSERT INTO Personne VALUES (25, 'Prohaska', 'Nicolas');
INSERT INTO Personne VALUES (26, 'Clare', 'Wiza');
INSERT INTO Personne VALUES (27, 'Miller', 'Terry');
INSERT INTO Personne VALUES (28, 'Vivien', 'Spencer');
INSERT INTO Personne VALUES (29, 'Katelin', 'Rippin');
INSERT INTO Personne VALUES (30, 'Grace', 'Zulauf');

INSERT INTO Personne VALUES (31, 'Monroe', 'Hilper');
INSERT INTO Personne VALUES (32, 'Schumm', 'Ken');
INSERT INTO Personne VALUES (33, 'Sporer', 'Lacey');
INSERT INTO Personne VALUES (34, 'Margie', 'Will');
INSERT INTO Personne VALUES (35, 'Torp', 'Ophelia');
INSERT INTO Personne VALUES (36, 'Legros', 'Keon');
INSERT INTO Personne VALUES (37, 'Emard', 'Brody');
INSERT INTO Personne VALUES (38, 'Cristian', 'Hirthe');
INSERT INTO Personne VALUES (39, 'Marks', 'Kamryn');
INSERT INTO Personne VALUES (40, 'Moore', 'Liliana');



INSERT INTO Personnage VALUES (1, 'Venom');
INSERT INTO Personnage VALUES (2, 'Thierry');
INSERT INTO Personnage VALUES (3, 'Nita');
INSERT INTO Personnage VALUES (4, 'Bob');
INSERT INTO Personnage VALUES (5, 'James');
INSERT INTO Personnage VALUES (6, 'Bond');
INSERT INTO Personnage VALUES (7, 'Joe');
INSERT INTO Personnage VALUES (8, 'Michel');
INSERT INTO Personnage VALUES (9, 'Alice');
INSERT INTO Personnage VALUES (10, 'Aguni');
INSERT INTO Personnage VALUES (11, 'Sam');

INSERT INTO Personnage VALUES (12, 'Annabelle');
INSERT INTO Personnage VALUES (13, 'Slender Man');
INSERT INTO Personnage VALUES (14, 'Saw');
INSERT INTO Personnage VALUES (15, 'Lupin');

INSERT INTO Personnage VALUES (16, 'Thibault');
INSERT INTO Personnage VALUES (17, 'Théo');
INSERT INTO Personnage VALUES (18, 'Lya');
INSERT INTO Personnage VALUES (19, 'Cristi');
INSERT INTO Personnage VALUES (20, 'Robert');
INSERT INTO Personnage VALUES (21, 'Jean');

INSERT INTO Personnage VALUES (22, 'Shrek');
INSERT INTO Personnage VALUES (23, 'Le Grinch');
INSERT INTO Personnage VALUES (24, 'Bob');
INSERT INTO Personnage VALUES (25, 'Grue');
INSERT INTO Personnage VALUES (26, 'Vivo');
INSERT INTO Personnage VALUES (27, 'Andrés');

INSERT INTO Personnage VALUES (28, 'Helmer');
INSERT INTO Personnage VALUES (29, 'Ines');
INSERT INTO Personnage VALUES (30, 'Mathys');
INSERT INTO Personnage VALUES (31, 'Lena');

INSERT INTO Personnage VALUES (32, 'Laura');
INSERT INTO Personnage VALUES (33, 'Lee');
INSERT INTO Personnage VALUES (34, 'Bruce');
INSERT INTO Personnage VALUES (35, 'Pauwels');
INSERT INTO Personnage VALUES (36, 'Baki');
INSERT INTO Personnage VALUES (37, 'Arima');

INSERT INTO Personnage VALUES (38, 'Kosei');
INSERT INTO Personnage VALUES (39, 'Gordi');


INSERT INTO Personnage VALUES (40, 'Cochon');
INSERT INTO Personnage VALUES (41, 'Démon');
INSERT INTO Personnage VALUES (42, 'Sylvain');

INSERT INTO Personnage VALUES (43, 'Levi');
INSERT INTO Personnage VALUES (44, 'Eva');
INSERT INTO Personnage VALUES (45, 'Jeon');

INSERT INTO Personnage VALUES (47, 'Mr.Joe');
INSERT INTO Personnage VALUES (48, 'Mickey');
INSERT INTO Personnage VALUES (49, 'Dempsey');

INSERT INTO Personnage VALUES (50, 'Peter');
INSERT INTO Personnage VALUES (51, 'Oncle Ben');
INSERT INTO Personnage VALUES (52, 'Bouffon vert');

INSERT INTO Personnage VALUES (53, 'Mr.Bean');

INSERT INTO Personnage VALUES (54, 'Panthere rose');
INSERT INTO Personnage VALUES (55, 'Dracula');



INSERT INTO Video(titre_vid, annee_prod, duree, id_personne) VALUES ('Venom', 2018, '00:02:00', 1);
INSERT INTO Video(titre_vid, annee_prod, duree, id_personne) VALUES ('Infinite', 2021, '00:02:00', 1);
INSERT INTO Video(titre_vid, annee_prod, duree, id_personne) VALUES ('Jolt', 2021, '00:02:00', 2);
INSERT INTO Video(titre_vid, annee_prod, duree, id_personne) VALUES ('Drive or Die', 2021, '00:02:00', 3);

INSERT INTO Video(titre_vid, annee_prod, duree, id_personne) VALUES ('Annabelle', 2014, '00:02:00', 4);
INSERT INTO Video(titre_vid, annee_prod, duree, id_personne) VALUES ('Slender Man', 2018, '00:02:00', 4);
INSERT INTO Video(titre_vid, annee_prod, duree, id_personne) VALUES ('Saw', 2004, '00:02:00', 4);
INSERT INTO Video(titre_vid, annee_prod, duree, id_personne) VALUES ('Dos', 2021, '00:02:00', 5);

INSERT INTO Video(titre_vid, annee_prod, duree, id_personne) VALUES ('Queenpins', 2021, '00:02:00', 6);
INSERT INTO Video(titre_vid, annee_prod, duree, id_personne) VALUES ('On sera 2!', 2021, '00:02:00', 7);
INSERT INTO Video(titre_vid, annee_prod, duree, id_personne) VALUES ('La cassette', 2021, '00:02:00', 8);

INSERT INTO Video(titre_vid, annee_prod, duree, id_personne) VALUES ('Shrek', 2001, '00:02:00', 9);
INSERT INTO Video(titre_vid, annee_prod, duree, id_personne) VALUES ('Le Grinch', 2018, '00:02:00', 10);
INSERT INTO Video(titre_vid, annee_prod, duree, id_personne) VALUES ('Les Minions', 2017, '00:02:00', 10);
INSERT INTO Video(titre_vid, annee_prod, duree, id_personne) VALUES ('Vivo', 2021, '00:02:00', 11);


INSERT INTO Video VALUES ('Ennemie', 2009, '00:02:00', 12, 'FBI', 1, 1);
INSERT INTO Video VALUES ('Prendre les armes', 2009, '00:02:00', 12, 'FBI', 1, 2);
INSERT INTO Video VALUES ('Au feu', 2009, '00:02:00', 12, 'FBI', 1, 3);
INSERT INTO Video VALUES ('Face au danger', 2009, '00:02:00', 12, 'FBI', 2, 1);
INSERT INTO Video VALUES ('Rouge', 2009, '00:02:00', 12, 'FBI', 2, 2);
INSERT INTO Video VALUES ('Sang', 2009, '00:02:00', 12, 'FBI', 2, 3);
INSERT INTO Video VALUES ('Otage', 2009, '00:02:00', 12, 'FBI', 3, 1);
INSERT INTO Video VALUES ('Discussion', 2009, '00:02:00', 12, 'FBI', 3, 2);
INSERT INTO Video VALUES ('Sauvetage', 2009, '00:02:00', 12, 'FBI', 3, 3);

INSERT INTO Video VALUES ('Desespoir', 2021, '00:02:00', 13, 'Ghost', 1, 1);
INSERT INTO Video VALUES ('Enfer', 2021, '00:02:00', 13, 'Ghost', 1, 2);
INSERT INTO Video VALUES ('Mort', 2021, '00:02:00', 13, 'Ghost', 1, 3);
INSERT INTO Video VALUES ('Au diable', 2021, '00:02:00', 13, 'Ghost', 1, 4);
INSERT INTO Video VALUES ('Ténèbre', 2021, '00:02:00', 13, 'Ghost', 1, 5);
INSERT INTO Video VALUES ('Sombre', 2021, '00:02:00', 13, 'Ghost', 1, 6);

INSERT INTO Video VALUES ('Oups', 2005, '00:02:00', 14, 'Alibaba', 1, 1);
INSERT INTO Video VALUES ('Ole!!', 2005, '00:02:00', 14, 'Alibaba', 1, 2);
INSERT INTO Video VALUES ('Chocolat', 2005, '00:02:00', 14, 'Alibaba', 1, 3);
INSERT INTO Video VALUES ('Aie Aie', 2005, '00:02:00', 14, 'Alibaba', 1, 4);
INSERT INTO Video VALUES ('Calamar', 2005, '00:02:00', 14, 'Alibaba', 1, 5);
INSERT INTO Video VALUES ('Petard', 2005, '00:02:00', 14, 'Alibaba', 2, 1);
INSERT INTO Video VALUES ('Le voilà', 2005, '00:02:00', 14, 'Alibaba', 2, 2);
INSERT INTO Video VALUES ('Bonbon', 2005, '00:02:00', 14, 'Alibaba', 2, 3);
INSERT INTO Video VALUES ('Wow', 2005, '00:02:00', 14, 'Alibaba', 2, 4);



/*Horreur*/
INSERT INTO Video VALUES ('L"homme Tronconneuse', 1997, '00:02:00', 13, 'Chainsaw Man', 1, 1);
INSERT INTO Video VALUES ('Malédiction', 1997, '00:02:00', 13, 'Chainsaw', 1, 2);
INSERT INTO Video VALUES ('Rassemblement', 1997, '00:02:00', 13, 'Chainsaw', 1, 3);
INSERT INTO Video VALUES ('Opération', 1997, '00:02:00', 13, 'Chainsaw', 2, 1);
INSERT INTO Video VALUES ('Démon', 1997, '00:02:00', 13, 'Chainsaw', 2, 2);
INSERT INTO Video VALUES ('Guérison', 1997, '00:02:00', 13, 'Chainsaw', 2, 3);

INSERT INTO Video VALUES ('Une famille heureuse', 2001, '00:02:00', 5, 'Resident Evil', 1, 1);
INSERT INTO Video VALUES ('Séparation', 2001, '00:02:00', 5, 'Resident Evil', 1, 2);
INSERT INTO Video VALUES ('Eva la démonne', 2001, '00:02:00', 5, 'Resident Evil', 2, 1);
INSERT INTO Video VALUES ('Heisenberg', 2001, '00:02:00', 5, 'Resident Evil', 2, 2);
INSERT INTO Video VALUES ('Opération sauvetage !', 2001, '00:02:00', 5, 'Resident Evil', 3, 1);
INSERT INTO Video VALUES ('Combat final', 2001, '00:02:00', 5, 'Resident Evil', 3, 2);

/*Action*/

INSERT INTO Video VALUES ('Le garçon sans abri', 1983, '00:02:00', 12, 'Rocky', 1, 1);
INSERT INTO Video VALUES ('Rencontre avec le coach Mickey', 1983, '00:02:00', 12, 'Rocky', 1, 2);
INSERT INTO Video VALUES ('Vers le titre mondial', 1983, '00:02:00', 12, 'Rocky', 1, 3);
INSERT INTO Video VALUES ('Combat contre Dempsey', 1983, '00:02:00', 12, 'Rocky', 1, 4);
INSERT INTO Video VALUES ('Adversaire redoutable', 1983, '00:02:00', 12, 'Rocky', 1, 5);
INSERT INTO Video VALUES ('Champion du monde', 1983, '00:02:00', 12, 'Rocky', 1, 6);

INSERT INTO Video VALUES ('Peter l"homme araignée', 1997, '00:02:00', 12, 'Spiderman', 1, 1);
INSERT INTO Video VALUES ('Oncle Ben', 1997, '00:02:00', 12, 'Spiderman', 1, 2);
INSERT INTO Video VALUES ('Course poursuite', 1997, '00:02:00', 12, 'Spiderman', 1, 3);
INSERT INTO Video VALUES ('Vengeance', 1997, '00:02:00', 12, 'Spiderman', 1, 4);
INSERT INTO Video VALUES ('Bouffon vert', 1997, '00:02:00', 12, 'Spiderman', 1, 5);

/*Comédie*/

INSERT INTO Video VALUES ('Mr. Bean', 2015, '00:02:00', 14, 'Mister bean', 1, 1);
INSERT INTO Video VALUES ('Les malheurs de Mr.Bean', 2015, '00:02:00', 14, 'Mister bean', 1, 2);
INSERT INTO Video VALUES ('Mr.Bean va en ville', 2015, '00:02:00', 14, 'Mister bean', 1, 3);
INSERT INTO Video VALUES ('Joyeux Noël Mr.Bean', 2015, '00:02:00', 14, 'Mister bean', 2, 1);
INSERT INTO Video VALUES ('Mr.bean va à l"école', 1983, '00:02:00', 14, 'Mister bean', 2, 2);
INSERT INTO Video VALUES ('Au revoir Mr.Bean', 1983, '00:02:00', 14, 'Mister bean', 2, 3);

INSERT INTO Video VALUES ('La maison de la panthère rose', 2003, '00:02:00', 8, 'Panthère Rose', 1, 1);
INSERT INTO Video VALUES ('La panthère à l"hopital', 2003, '00:02:00', 8, 'Panthère Rose', 1, 2);
INSERT INTO Video VALUES ('Le génie rose de la lampe', 2003, '00:02:00', 8, 'Panthère Rose', 1, 3);
INSERT INTO Video VALUES ('Le chevalier rose', 2003, '00:02:00', 8, 'Panthère Rose', 2, 1);
INSERT INTO Video VALUES ('Chien dangereux', 2003, '00:02:00', 8, 'Panthère Rose', 2, 2);
INSERT INTO Video VALUES ('Panthère contre Dracula', 2003, '00:02:00', 8, 'Panthère Rose', 3, 1);
INSERT INTO Video VALUES ('La panthère au restaurant', 2003, '00:02:00', 8, 'Panthère Rose', 3, 2);



INSERT INTO Visionnage VALUES (1, '00:02:00', 1, 4, 'Ennemie');
INSERT INTO Visionnage VALUES (2, '00:01:05', 0, 4, 'Prendre les armes');
INSERT INTO Visionnage VALUES (3, '00:02:00', 1, 4, 'Desespoir');
INSERT INTO Visionnage VALUES (4, '00:02:00', 1, 4, 'Enfer');
INSERT INTO Visionnage VALUES (5, '00:00:50', 0, 4, 'Mort');
INSERT INTO Visionnage VALUES (6, '00:01:10', 0, 4, 'Annabelle');

INSERT INTO Visionnage VALUES (7, '00:02:00', 1, 5, 'Shrek');
INSERT INTO Visionnage VALUES (8, '00:01:05', 0, 5, 'Le Grinch');

INSERT INTO Visionnage VALUES (9, '00:02:00', 1, 6, 'Oups');
INSERT INTO Visionnage VALUES (10, '00:02:00', 1, 6, 'Ole!!');
INSERT INTO Visionnage VALUES (11, '00:02:00', 1, 6, 'Chocolat');
INSERT INTO Visionnage VALUES (12, '00:01:30', 0, 6, 'Aie Aie');

INSERT INTO Visionnage VALUES (13, '00:02:00', 1, 7, 'Slender Man');
INSERT INTO Visionnage VALUES (14, '00:02:00', 1, 7, 'Saw');
INSERT INTO Visionnage VALUES (15, '00:02:00', 1, 7, 'Dos');


INSERT INTO Visionnage VALUES (16, '00:02:00', 1, 4, 'L"homme Tronconneuse');
INSERT INTO Visionnage VALUES (17, '00:00:30', 0, 4, 'Malédiction');

INSERT INTO Visionnage VALUES (18, '00:02:00', 1, 5, 'Vivo'); 
INSERT INTO Visionnage VALUES (19, '00:01:00', 0, 5, 'Mr. Bean');
INSERT INTO Visionnage VALUES (20, '00:01:00', 0, 5, 'La maison de la panthère rose'); 

INSERT INTO Visionnage VALUES (21, '00:02:00', 1, 6, 'Le garçon sans abri');
INSERT INTO Visionnage VALUES (22, '00:02:00', 1, 6, 'Rencontre avec le coach Mickey');
INSERT INTO Visionnage VALUES (23, '00:00:45', 0, 6, 'Vers le titre mondial');

INSERT INTO Visionnage VALUES (24, '00:01:00', 0, 7, 'Peter l"homme araignée');
INSERT INTO Visionnage VALUES (25, '00:00:40', 0, 7, 'Une famille heureuse');

INSERT INTO Visionnage VALUES (26, '00:02:00', 1, 8, 'Venom');
INSERT INTO Visionnage VALUES (27, '00:02:00', 1, 8, 'Infinite');
INSERT INTO Visionnage VALUES (28, '00:02:00', 1, 8, 'Jolt');


INSERT INTO attribue VALUES (4, 'action', 'Ennemie');
INSERT INTO attribue VALUES (4, 'horreur', 'Desespoir');
INSERT INTO attribue VALUES (4, 'paranormal', 'Enfer');
INSERT INTO attribue VALUES (4, 'horreur', 'L"homme Tronconneuse');
INSERT INTO attribue VALUES (4, 'paranormal', 'Malédiction');


INSERT INTO attribue VALUES (5, 'en famille', 'Shrek');
INSERT INTO attribue VALUES (5, 'comedie', 'Shrek');
INSERT INTO attribue VALUES (5, 'en famille', 'Le Grinch');
INSERT INTO attribue VALUES (5, 'comedie', 'Mr. Bean');
INSERT INTO attribue VALUES (5, 'enfantin', 'La maison de la panthère rose');


INSERT INTO attribue VALUES (6, 'comedie', 'Oups');
INSERT INTO attribue VALUES (6, 'comedie', 'Ole!!');
INSERT INTO attribue VALUES (6, 'action', 'Le garçon sans abri');
INSERT INTO attribue VALUES (6, 'badass', 'Rencontre avec le coach Mickey');


INSERT INTO attribue VALUES (7, 'horreur', 'Slender Man');
INSERT INTO attribue VALUES (7, 'horreur', 'Saw');
INSERT INTO attribue VALUES (7, 'horreur', 'Dos');
INSERT INTO attribue VALUES (7, 'action', 'Peter l"homme araignée');




INSERT INTO joue VALUES (15, 1, 'Venom');
INSERT INTO joue VALUES (16, 2, 'Venom');
INSERT INTO joue VALUES (17, 3, 'Infinite');
INSERT INTO joue VALUES (18, 4, 'Infinite');
INSERT INTO joue VALUES (19, 5, 'Infinite');
INSERT INTO joue VALUES (20, 6, 'Jolt');
INSERT INTO joue VALUES (21, 7, 'Jolt');
INSERT INTO joue VALUES (22, 8, 'Jolt');
INSERT INTO joue VALUES (23, 9, 'Drive or Die');
INSERT INTO joue VALUES (24, 10, 'Drive or Die');
INSERT INTO joue VALUES (25, 11, 'Drive or Die');

INSERT INTO joue VALUES (26, 12, 'Annabelle');
INSERT INTO joue VALUES (26, 13, 'Slender Man');
INSERT INTO joue VALUES (26, 14, 'Saw');
INSERT INTO joue VALUES (27, 15, 'Dos');

INSERT INTO joue VALUES (28, 16, 'Queenpins');
INSERT INTO joue VALUES (29, 17, 'Queenpins');
INSERT INTO joue VALUES (30, 18, 'On sera 2!');
INSERT INTO joue VALUES (31, 19, 'On sera 2!');
INSERT INTO joue VALUES (32, 20, 'La cassette');
INSERT INTO joue VALUES (33, 21, 'La cassette');

INSERT INTO joue VALUES (34, 22, 'Shrek');
INSERT INTO joue VALUES (34, 23, 'Le Grinch');
INSERT INTO joue VALUES (35, 24, 'Les Minions');
INSERT INTO joue VALUES (36, 25, 'Les Minions');
INSERT INTO joue VALUES (35, 26, 'Vivo');
INSERT INTO joue VALUES (36, 27, 'Vivo');

INSERT INTO joue VALUES (16, 28,'Ennemie');
INSERT INTO joue VALUES (17, 29, 'Ennemie');
INSERT INTO joue VALUES (17, 29, 'Prendre les armes');
INSERT INTO joue VALUES (18, 30, 'Prendre les armes');
INSERT INTO joue VALUES (16, 28, 'Au feu');
INSERT INTO joue VALUES (17, 29, 'Au feu');
INSERT INTO joue VALUES (18, 30, 'Au feu');
INSERT INTO joue VALUES (18, 30, 'Face au danger');
INSERT INTO joue VALUES (16, 28, 'Rouge');
INSERT INTO joue VALUES (16, 28, 'Sang');
INSERT INTO joue VALUES (16, 28, 'Otage');
INSERT INTO joue VALUES (17, 29, 'Otage');
INSERT INTO joue VALUES (18, 30, 'Otage');
INSERT INTO joue VALUES (19, 31, 'Otage');
INSERT INTO joue VALUES (17, 29, 'Discussion');
INSERT INTO joue VALUES (18, 30, 'Discussion');
INSERT INTO joue VALUES (19, 31, 'Discussion');
INSERT INTO joue VALUES (16, 28, 'Sauvetage');
INSERT INTO joue VALUES (17, 29, 'Sauvetage');
INSERT INTO joue VALUES (18, 30, 'Sauvetage');
INSERT INTO joue VALUES (19, 31, 'Sauvetage');

INSERT INTO joue VALUES (26, 32, 'Desespoir');
INSERT INTO joue VALUES (27, 33, 'Enfer');
INSERT INTO joue VALUES (37, 34, 'Mort');
INSERT INTO joue VALUES (38, 35, 'Au diable');
INSERT INTO joue VALUES (39, 36, 'Ténèbre');
INSERT INTO joue VALUES (40, 37, 'Sombre');

INSERT INTO joue VALUES (28, 38, 'Oups');
INSERT INTO joue VALUES (29, 39, 'Oups');
INSERT INTO joue VALUES (28, 38, 'Ole!!');
INSERT INTO joue VALUES (29, 39, 'Ole!!');
INSERT INTO joue VALUES (28, 38, 'Chocolat');
INSERT INTO joue VALUES (29, 39, 'Chocolat');
INSERT INTO joue VALUES (28, 38, 'Aie Aie');
INSERT INTO joue VALUES (29, 39, 'Aie Aie');
INSERT INTO joue VALUES (28, 38, 'Calamar');
INSERT INTO joue VALUES (29, 39, 'Calamar');
INSERT INTO joue VALUES (28, 38, 'Petard');
INSERT INTO joue VALUES (29, 39, 'Petard');
INSERT INTO joue VALUES (28, 38, 'Le voilà');
INSERT INTO joue VALUES (29, 39, 'Le voilà');
INSERT INTO joue VALUES (28, 38, 'Bonbon');
INSERT INTO joue VALUES (29, 39, 'Bonbon');
INSERT INTO joue VALUES (28, 38, 'Wow');


INSERT INTO joue VALUES (15, 40, 'L"homme Tronconneuse');
INSERT INTO joue VALUES (16, 41, 'L"homme Tronconneuse');
INSERT INTO joue VALUES (17, 42, 'L"homme Tronconneuse');
INSERT INTO joue VALUES (15, 40, 'Malédiction');
INSERT INTO joue VALUES (16, 41, 'Malédiction');
INSERT INTO joue VALUES (17, 42, 'Malédiction');
INSERT INTO joue VALUES (15, 40, 'Rassemblement');
INSERT INTO joue VALUES (16, 41, 'Rassemblement');
INSERT INTO joue VALUES (17, 42, 'Rassemblement');
INSERT INTO joue VALUES (15, 40, 'Opération');
INSERT INTO joue VALUES (16, 41, 'Opération');
INSERT INTO joue VALUES (17, 42, 'Opération');
INSERT INTO joue VALUES (15, 40, 'Démon');
INSERT INTO joue VALUES (16, 41, 'Démon');
INSERT INTO joue VALUES (17, 42, 'Démon');
INSERT INTO joue VALUES (15, 40, 'Guérison');
INSERT INTO joue VALUES (16, 41, 'Guérison');
INSERT INTO joue VALUES (17, 42, 'Guérison');

INSERT INTO joue VALUES (18, 43, 'Une famille heureuse');
INSERT INTO joue VALUES (19, 44, 'Une famille heureuse');
INSERT INTO joue VALUES (18, 43, 'Séparation');
INSERT INTO joue VALUES (19, 44, 'Séparation');
INSERT INTO joue VALUES (19, 44, 'Eva la démonne');
INSERT INTO joue VALUES (20, 45, 'Heisenberg');
INSERT INTO joue VALUES (19, 44, 'Opération sauvetage !');
INSERT INTO joue VALUES (20, 45, 'Opération sauvetage !');
INSERT INTO joue VALUES (18, 43, 'Combat final');
INSERT INTO joue VALUES (19, 44, 'Combat final');
INSERT INTO joue VALUES (20, 45, 'Combat final');

INSERT INTO joue VALUES (21, 47, 'Le garçon sans abri');
INSERT INTO joue VALUES (21, 47, 'Rencontre avec le coach Mickey');
INSERT INTO joue VALUES (22, 48, 'Rencontre avec le coach Mickey');
INSERT INTO joue VALUES (21, 47, 'Vers le titre mondial');
INSERT INTO joue VALUES (22, 48, 'Vers le titre mondial');
INSERT INTO joue VALUES (21, 47, 'Combat contre Dempsey');
INSERT INTO joue VALUES (23, 49, 'Combat contre Dempsey');
INSERT INTO joue VALUES (21, 47, 'Adversaire redoutable');
INSERT INTO joue VALUES (23, 49, 'Adversaire redoutable');
INSERT INTO joue VALUES (21, 47, 'Champion du monde');

INSERT INTO joue VALUES (24, 50, 'Peter l"homme araignée');
INSERT INTO joue VALUES (25, 51, 'Oncle Ben');
INSERT INTO joue VALUES (24, 50, 'Course poursuite');
INSERT INTO joue VALUES (26, 52, 'Course poursuite');
INSERT INTO joue VALUES (24, 50, 'Vengeance');
INSERT INTO joue VALUES (26, 52, 'Vengeance');
INSERT INTO joue VALUES (26, 52, 'Bouffon vert');

INSERT INTO joue VALUES (27, 53, 'Mr. Bean');
INSERT INTO joue VALUES (27, 53, 'Les malheurs de Mr.Bean');
INSERT INTO joue VALUES (27, 53, 'Mr.Bean va en ville');
INSERT INTO joue VALUES (27, 53, 'Joyeux Noël Mr.Bean');
INSERT INTO joue VALUES (27, 53, 'Mr.bean va à l"école');
INSERT INTO joue VALUES (27, 53, 'Au revoir Mr.Bean');

INSERT INTO joue VALUES (28, 54, 'La maison de la panthère rose');
INSERT INTO joue VALUES (28, 54, 'La panthère à l"hopital');
INSERT INTO joue VALUES (28, 54, 'Le génie rose de la lampe');
INSERT INTO joue VALUES (28, 54, 'Le chevalier rose');
INSERT INTO joue VALUES (28, 54, 'Chien dangereux');
INSERT INTO joue VALUES (28, 54, 'Panthère contre Dracula');
INSERT INTO joue VALUES (29, 55, 'Panthère contre Dracula');
INSERT INTO joue VALUES (28, 54, 'La panthère au restaurant');


INSERT INTO note VALUES (4, 'Desespoir', 8.0);
INSERT INTO note VALUES (4, 'Enfer', 8.0);
INSERT INTO note VALUES (5, 'Shrek', 9.5);
INSERT INTO note VALUES (6, 'Oups', 7.7);
INSERT INTO note VALUES (7, 'Slender Man', 4.5);
INSERT INTO note VALUES (7, 'Saw', 5.5);
INSERT INTO note VALUES (4, 'L"homme Tronconneuse', 8.5);
INSERT INTO note VALUES (5, 'La maison de la panthère rose', 2);
INSERT INTO note VALUES (6, 'Le garçon sans abri', 7.9);
INSERT INTO note VALUES (6, 'Rencontre avec le coach Mickey', 9.8);
INSERT INTO note VALUES (6, 'Vers le titre mondial', 9.5);

INSERT INTO note VALUES (8, 'Venom', 10.0);
INSERT INTO note VALUES (8, 'Infinite', 9.5);
INSERT INTO note VALUES (8, 'Jolt', 9.8);
