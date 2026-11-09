-- =====================================================
-- MINI-PROJET TI503N
-- LIGUE DES CHAMPIONS
-- Raphaël Simon / Selim Rebai
-- FICHIER 4 : INTERROGATION DE LA BASE DE DONNEES
-- =====================================================

USE ligue_champions;


-- =====================================================
-- PARTIE 1 : PROJECTIONS ET SELECTIONS
-- 5 requêtes
-- =====================================================

-- REQUETE 1 :
-- Afficher tous les clubs par ordre alphabétique.

SELECT *
FROM CLUB
ORDER BY nom_club ASC;


-- REQUETE 2 :
-- Rechercher les joueurs dont le nom commence par la lettre M.

SELECT nom_joueur, prenom_joueur, nationalite_joueur, poste_joueur
FROM JOUEUR
WHERE nom_joueur LIKE 'M%'
ORDER BY nom_joueur;


-- REQUETE 3 :
-- Afficher les matchs ayant lieu entre 2024 et 2026.

SELECT num_match, date_heure_match, buts_domicile, buts_exterieur
FROM `MATCH`
WHERE date_heure_match BETWEEN '2024-01-01' AND '2026-12-31'
ORDER BY date_heure_match;


-- REQUETE 4 :
-- Afficher les clubs appartenant à certains pays.

SELECT nom_club, pays_club
FROM CLUB
WHERE pays_club IN ('France', 'Espagne', 'Allemagne')
ORDER BY pays_club;


-- REQUETE 5 :
-- Afficher les différentes nationalités des joueurs sans doublons.

SELECT DISTINCT nationalite_joueur
FROM JOUEUR
ORDER BY nationalite_joueur;


-- =====================================================
-- PARTIE 2 : FONCTIONS D'AGREGATION
-- GROUP BY ET HAVING
-- 5 requêtes
-- =====================================================

-- REQUETE 6 :
-- Compter le nombre de clubs par pays.
-- Afficher uniquement les pays ayant au moins 2 clubs.

SELECT pays_club, COUNT(*) AS nombre_clubs
FROM CLUB
GROUP BY pays_club
HAVING COUNT(*) >= 2
ORDER BY nombre_clubs DESC;


-- REQUETE 7 :
-- Calculer l'affluence moyenne des matchs pour chaque phase.

SELECT P.nom_phase,
       AVG(M.affluence) AS affluence_moyenne
FROM `MATCH` M
JOIN PHASE P ON M.id_phase = P.id_phase
WHERE M.affluence IS NOT NULL
GROUP BY P.id_phase, P.nom_phase
ORDER BY affluence_moyenne DESC;


-- REQUETE 8 :
-- Calculer le nombre total de buts marqués dans chaque phase.

SELECT P.nom_phase,
       SUM(M.buts_domicile + M.buts_exterieur) AS total_buts
FROM `MATCH` M
JOIN PHASE P ON M.id_phase = P.id_phase
GROUP BY P.id_phase, P.nom_phase
ORDER BY total_buts DESC;


-- REQUETE 9 :
-- Compter le nombre de matchs organisés dans chaque stade.

SELECT S.nom_stade,
       S.ville_stade,
       COUNT(M.num_match) AS nombre_matchs
FROM STADE S
LEFT JOIN `MATCH` M ON S.id_stade = M.id_stade
GROUP BY S.id_stade, S.nom_stade, S.ville_stade
ORDER BY nombre_matchs DESC;


-- REQUETE 10 :
-- Compter le nombre d'événements de chaque type.

SELECT type_evenement,
       COUNT(*) AS nombre_evenements
FROM EVENEMENT
GROUP BY type_evenement
HAVING COUNT(*) >= 1
ORDER BY nombre_evenements DESC;


-- =====================================================
-- PARTIE 3 : JOINTURES
-- 5 requêtes
-- =====================================================

-- REQUETE 11 :
-- Afficher chaque match avec les noms des deux clubs.

SELECT M.num_match,
       M.date_heure_match,
       C1.nom_club AS club_domicile,
       C2.nom_club AS club_exterieur,
       M.buts_domicile,
       M.buts_exterieur
FROM `MATCH` M
INNER JOIN CLUB C1
    ON M.id_club_domicile = C1.id_club
INNER JOIN CLUB C2
    ON M.id_club_exterieur = C2.id_club
ORDER BY M.date_heure_match;


-- REQUETE 12 :
-- Afficher les matchs avec leur stade et leur phase.

SELECT M.num_match,
       M.date_heure_match,
       S.nom_stade,
       S.ville_stade,
       P.nom_phase
FROM `MATCH` M
INNER JOIN STADE S
    ON M.id_stade = S.id_stade
INNER JOIN PHASE P
    ON M.id_phase = P.id_phase
ORDER BY M.date_heure_match;


-- REQUETE 13 :
-- Afficher les événements avec le joueur concerné et le match.

SELECT E.num_match,
       E.num_evenement,
       E.minute_evenement,
       E.type_evenement,
       J.nom_joueur,
       J.prenom_joueur
FROM EVENEMENT E
INNER JOIN JOUEUR J
    ON E.id_joueur = J.id_joueur
INNER JOIN `MATCH` M
    ON E.num_match = M.num_match
ORDER BY E.num_match, E.minute_evenement;




SELECT A.nom_arbitre,
       A.prenom_arbitre,
       AR.role_arbitre,
       M.num_match,
       M.date_heure_match
FROM ARBITRER AR
INNER JOIN ARBITRE A
    ON AR.id_arbitre = A.id_arbitre
INNER JOIN `MATCH` M
    ON AR.num_match = M.num_match
ORDER BY M.date_heure_match;


SELECT J.nom_joueur,
       J.prenom_joueur,
       C.nom_club,
       S.libelle_saison,
       I.num_maillot
FROM INSCRIRE I
INNER JOIN JOUEUR J
    ON I.id_joueur = J.id_joueur
INNER JOIN CLUB C
    ON I.id_club = C.id_club
INNER JOIN SAISON S
    ON I.id_saison = S.id_saison
ORDER BY S.libelle_saison, C.nom_club;



SELECT nom_club, pays_club
FROM CLUB
WHERE id_stade IN (
    SELECT id_stade
    FROM STADE
    WHERE capacite_stade > (
        SELECT AVG(capacite_stade)
        FROM STADE
    )
);



SELECT J.nom_joueur, J.prenom_joueur
FROM JOUEUR J
WHERE EXISTS (
    SELECT 1
    FROM INSCRIRE I
    WHERE I.id_joueur = J.id_joueur
);



SELECT C.nom_club
FROM CLUB C
WHERE NOT EXISTS (
    SELECT 1
    FROM `MATCH` M
    WHERE M.id_club_domicile = C.id_club
       OR M.id_club_exterieur = C.id_club
);


SELECT C.nom_club,
       CL.points,
       CL.rang,
       CL.id_phase
FROM CLASSER CL
INNER JOIN CLUB C
    ON CL.id_club = C.id_club
WHERE CL.points > ANY (
    SELECT CL2.points
    FROM CLASSER CL2
    WHERE CL2.id_phase = CL.id_phase
      AND CL2.id_club <> CL.id_club
);



SELECT nom_stade, ville_stade, capacite_stade
FROM STADE
WHERE capacite_stade >= ALL (
    SELECT capacite_stade
    FROM STADE
)
ORDER BY capacite_stade DESC;

