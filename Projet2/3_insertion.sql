
USE ligue_champions;

-- ==========================================
-- 1. PHASES
-- ==========================================

INSERT INTO PHASE
(id_phase, nom_phase, ordre_phase, id_saison)
VALUES
(1, 'Phase de ligue', 1, 1),
(2, 'Demi-finales', 2, 1),
(3, 'Finale', 3, 1);

-- ==========================================
-- 2. JOUEURS
-- ==========================================

INSERT INTO JOUEUR
(id_joueur, nom_joueur, prenom_joueur, date_naiss_joueur,
 nationalite_joueur, poste_joueur)
VALUES
(1,'Mbappe','Kylian','1998-12-20','Francaise','Attaquant'),
(2,'Hakimi','Achraf','1998-11-04','Marocaine','Defenseur'),
(3,'Vinicius','Junior','2000-07-12','Bresilienne','Attaquant'),
(4,'Bellingham','Jude','2003-06-29','Anglaise','Milieu'),
(5,'Yamal','Lamine','2007-07-13','Espagnole','Attaquant'),
(6,'Pedri','Pedro','2002-11-25','Espagnole','Milieu'),
(7,'Kane','Harry','1993-07-28','Anglaise','Attaquant'),
(8,'Musiala','Jamal','2003-02-26','Allemande','Milieu'),
(9,'Salah','Mohamed','1992-06-15','Egyptienne','Attaquant'),
(10,'Van Dijk','Virgil','1991-07-08','Neerlandaise','Defenseur'),
(11,'Saka','Bukayo','2001-09-05','Anglaise','Attaquant'),
(12,'Odegaard','Martin','1998-12-17','Norvegienne','Milieu'),
(13,'Martinez','Lautaro','1997-08-22','Argentine','Attaquant'),
(14,'Barella','Nicolo','1997-02-07','Italienne','Milieu'),
(15,'Brandt','Julian','1996-05-02','Allemande','Milieu'),
(16,'Adeyemi','Karim','2002-01-18','Allemande','Attaquant');

-- ==========================================
-- 3. DIRIGER
-- ==========================================

INSERT INTO DIRIGER
(id_entraineur,id_club,date_prise_fonction)
VALUES
(1,1,'2025-07-01'),
(2,2,'2025-07-01'),
(3,3,'2025-07-01'),
(4,4,'2025-07-01'),
(5,5,'2025-07-01'),
(6,6,'2025-07-01'),
(7,7,'2025-07-01'),
(8,8,'2025-07-01');

-- ==========================================
-- 4. INSCRIRE
-- ==========================================

INSERT INTO INSCRIRE
(id_joueur,id_club,id_saison,num_maillot)
VALUES
(1,1,1,7),
(2,1,1,2),
(3,2,1,7),
(4,2,1,5),
(5,3,1,10),
(6,3,1,8),
(7,4,1,9),
(8,4,1,42),
(9,5,1,11),
(10,5,1,4),
(11,6,1,7),
(12,6,1,8),
(13,7,1,10),
(14,7,1,23),
(15,8,1,10),
(16,8,1,27);

-- ==========================================
-- 5. MATCHS
-- ==========================================

INSERT INTO `MATCH`
(num_match,date_heure_match,num_journee,affluence,
 buts_domicile,buts_exterieur,id_stade,id_phase,
 id_club_domicile,id_club_exterieur)
VALUES
(1,'2025-09-16 21:00:00',1,47000,2,1,1,1,1,2),
(2,'2025-09-17 21:00:00',1,80000,3,2,2,1,2,3),
(3,'2025-09-18 21:00:00',1,74000,1,1,4,1,4,5),
(4,'2025-09-19 21:00:00',1,60000,2,0,6,1,6,7),
(5,'2026-04-28 21:00:00',1,47000,2,0,1,2,1,4),
(6,'2026-04-29 21:00:00',1,80000,1,2,2,2,2,6),
(7,'2026-06-10 21:00:00',1,80000,3,2,2,3,2,1);

-- ==========================================
-- 6. ARBITRER
-- ==========================================

INSERT INTO ARBITRER
(id_arbitre,num_match,role_arbitre)
VALUES
(1,1,'Central'),
(2,1,'Assistant 1'),
(3,1,'Assistant 2'),
(4,2,'Central'),
(5,2,'Assistant 1'),
(6,2,'Assistant 2'),
(7,3,'Central'),
(8,3,'Assistant 1'),
(1,4,'Central'),
(2,4,'Assistant 1'),
(3,5,'Central'),
(4,5,'Assistant 1'),
(5,6,'Central'),
(6,6,'Assistant 1'),
(7,7,'Central'),
(8,7,'Assistant 1');

-- ==========================================
-- 7. EVENEMENTS
-- ==========================================

INSERT INTO EVENEMENT
(num_match,num_evenement,minute_evenement,
 type_evenement,id_joueur)
VALUES
(1,1,25,'But',1),
(1,2,67,'But',3),
(1,3,80,'Carton jaune',2),
(2,1,15,'But',3),
(2,2,40,'But',5),
(2,3,72,'But',4),
(3,1,33,'But',7),
(3,2,75,'Carton jaune',10),
(4,1,20,'But',11),
(4,2,55,'But',13),
(5,1,35,'But',1),
(5,2,70,'But',7),
(6,1,42,'But',3),
(6,2,65,'But',11),
(7,1,20,'But',3),
(7,2,50,'But',1),
(7,3,78,'But',3);

-- ==========================================
-- 8. CLASSER
-- ==========================================

INSERT INTO CLASSER
(id_club,id_phase,rang,points)
VALUES
(1,1,1,18),
(2,1,2,16),
(3,1,3,15),
(4,1,4,14),
(5,1,5,12),
(6,1,6,11),
(7,1,7,9),
(8,1,8,8),
(1,2,1,6),
(2,2,2,4),
(4,2,3,3),
(6,2,4,1),
(2,3,1,3),
(1,3,2,0);

-- ==========================================
-- 9. VERIFICATION
-- ==========================================

SELECT 'SAISON' AS nom_table, COUNT(*) AS total FROM SAISON
UNION ALL SELECT 'STADE', COUNT(*) FROM STADE
UNION ALL SELECT 'CLUB', COUNT(*) FROM CLUB
UNION ALL SELECT 'ENTRAINEUR', COUNT(*) FROM ENTRAINEUR
UNION ALL SELECT 'ARBITRE', COUNT(*) FROM ARBITRE
UNION ALL SELECT 'JOUEUR', COUNT(*) FROM JOUEUR
UNION ALL SELECT 'PHASE', COUNT(*) FROM PHASE
UNION ALL SELECT 'MATCH', COUNT(*) FROM `MATCH`
UNION ALL SELECT 'EVENEMENT', COUNT(*) FROM EVENEMENT
UNION ALL SELECT 'ARBITRER', COUNT(*) FROM ARBITRER
UNION ALL SELECT 'DIRIGER', COUNT(*) FROM DIRIGER
UNION ALL SELECT 'INSCRIRE', COUNT(*) FROM INSCRIRE
UNION ALL SELECT 'CLASSER', COUNT(*) FROM CLASSER;
