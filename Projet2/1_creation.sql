
-- =====================================================
-- MINI-PROJET TI503N
-- LIGUE DES CHAMPIONS
-- Raphaël Simon / Selim Rebai
-- =====================================================

CREATE DATABASE IF NOT EXISTS ligue_champions;
USE ligue_champions;

-- SUPPRESSION DES ANCIENNES TABLES

SET FOREIGN_KEY_CHECKS = 0;

DROP TABLE IF EXISTS CLASSER;
DROP TABLE IF EXISTS INSCRIRE;
DROP TABLE IF EXISTS DIRIGER;
DROP TABLE IF EXISTS ARBITRER;
DROP TABLE IF EXISTS EVENEMENT;
DROP TABLE IF EXISTS `MATCH`;
DROP TABLE IF EXISTS PHASE;
DROP TABLE IF EXISTS ARBITRE;
DROP TABLE IF EXISTS ENTRAINEUR;
DROP TABLE IF EXISTS JOUEUR;
DROP TABLE IF EXISTS CLUB;
DROP TABLE IF EXISTS STADE;
DROP TABLE IF EXISTS SAISON;

SET FOREIGN_KEY_CHECKS = 1;

-- 1. SAISON

CREATE TABLE SAISON (
    id_saison INT AUTO_INCREMENT PRIMARY KEY,
    libelle_saison VARCHAR(9) NOT NULL UNIQUE,
    date_debut_saison DATE NOT NULL,
    date_fin_saison DATE NOT NULL,
    CHECK (date_fin_saison > date_debut_saison)
);

-- 2. STADE

CREATE TABLE STADE (
    id_stade INT AUTO_INCREMENT PRIMARY KEY,
    nom_stade VARCHAR(60) NOT NULL,
    ville_stade VARCHAR(40) NOT NULL,
    capacite_stade INT NOT NULL,
    CHECK (capacite_stade > 0)
);

-- 3. CLUB

CREATE TABLE CLUB (
    id_club INT AUTO_INCREMENT PRIMARY KEY,
    nom_club VARCHAR(50) NOT NULL,
    pays_club VARCHAR(40) NOT NULL,
    annee_fondation INT,
    id_stade INT NOT NULL,

    FOREIGN KEY (id_stade)
        REFERENCES STADE(id_stade)
        ON UPDATE CASCADE
        ON DELETE RESTRICT
);

-- 4. JOUEUR

CREATE TABLE JOUEUR (
    id_joueur INT AUTO_INCREMENT PRIMARY KEY,
    nom_joueur VARCHAR(40) NOT NULL,
    prenom_joueur VARCHAR(40) NOT NULL,
    date_naiss_joueur DATE NOT NULL,
    nationalite_joueur VARCHAR(40) NOT NULL,
    poste_joueur VARCHAR(20) NOT NULL,

    CHECK (poste_joueur IN (
        'Gardien',
        'Defenseur',
        'Milieu',
        'Attaquant'
    ))
);

-- 5. ENTRAINEUR

CREATE TABLE ENTRAINEUR (
    id_entraineur INT AUTO_INCREMENT PRIMARY KEY,
    nom_entraineur VARCHAR(40) NOT NULL,
    prenom_entraineur VARCHAR(40) NOT NULL,
    nationalite_entraineur VARCHAR(40) NOT NULL
);

-- 6. ARBITRE

CREATE TABLE ARBITRE (
    id_arbitre INT AUTO_INCREMENT PRIMARY KEY,
    nom_arbitre VARCHAR(40) NOT NULL,
    prenom_arbitre VARCHAR(40) NOT NULL,
    nationalite_arbitre VARCHAR(40) NOT NULL
);

-- 7. PHASE

CREATE TABLE PHASE (
    id_phase INT AUTO_INCREMENT PRIMARY KEY,
    nom_phase VARCHAR(40) NOT NULL,
    ordre_phase INT NOT NULL,
    id_saison INT NOT NULL,

    FOREIGN KEY (id_saison)
        REFERENCES SAISON(id_saison)
        ON UPDATE CASCADE
        ON DELETE CASCADE,

    UNIQUE (id_saison, ordre_phase),
    CHECK (ordre_phase > 0)
);

-- 8. MATCH

CREATE TABLE `MATCH` (
    num_match INT AUTO_INCREMENT PRIMARY KEY,
    date_heure_match DATETIME NOT NULL,
    num_journee INT,
    affluence INT,
    buts_domicile INT NOT NULL DEFAULT 0,
    buts_exterieur INT NOT NULL DEFAULT 0,
    id_stade INT NOT NULL,
    id_phase INT NOT NULL,
    id_club_domicile INT NOT NULL,
    id_club_exterieur INT NOT NULL,
    num_match_aller INT UNIQUE,

    FOREIGN KEY (id_stade)
        REFERENCES STADE(id_stade)
        ON UPDATE CASCADE
        ON DELETE RESTRICT,

    FOREIGN KEY (id_phase)
        REFERENCES PHASE(id_phase)
        ON UPDATE CASCADE
        ON DELETE RESTRICT,

    FOREIGN KEY (id_club_domicile)
        REFERENCES CLUB(id_club)
        ON UPDATE CASCADE
        ON DELETE RESTRICT,

    FOREIGN KEY (id_club_exterieur)
        REFERENCES CLUB(id_club)
        ON UPDATE CASCADE
        ON DELETE RESTRICT,

    FOREIGN KEY (num_match_aller)
        REFERENCES `MATCH`(num_match)
        ON UPDATE CASCADE
        ON DELETE SET NULL,

    CHECK (buts_domicile >= 0),
    CHECK (buts_exterieur >= 0),
    CHECK (affluence IS NULL OR affluence >= 0),
    CHECK (num_journee IS NULL OR num_journee BETWEEN 1 AND 8)
);

-- 9. EVENEMENT

CREATE TABLE EVENEMENT (
    num_match INT NOT NULL,
    num_evenement INT NOT NULL,
    minute_evenement INT NOT NULL,
    type_evenement VARCHAR(25) NOT NULL,
    id_joueur INT NOT NULL,

    PRIMARY KEY (num_match, num_evenement),

    FOREIGN KEY (num_match)
        REFERENCES `MATCH`(num_match)
        ON UPDATE CASCADE
        ON DELETE CASCADE,

    FOREIGN KEY (id_joueur)
        REFERENCES JOUEUR(id_joueur)
        ON UPDATE CASCADE
        ON DELETE RESTRICT,

    CHECK (minute_evenement BETWEEN 1 AND 120)
);

-- 10. ARBITRER

CREATE TABLE ARBITRER (
    id_arbitre INT NOT NULL,
    num_match INT NOT NULL,
    role_arbitre VARCHAR(30) NOT NULL,

    PRIMARY KEY (id_arbitre, num_match),

    FOREIGN KEY (id_arbitre)
        REFERENCES ARBITRE(id_arbitre)
        ON UPDATE CASCADE
        ON DELETE CASCADE,

    FOREIGN KEY (num_match)
        REFERENCES `MATCH`(num_match)
        ON UPDATE CASCADE
        ON DELETE CASCADE
);

-- 11. DIRIGER

CREATE TABLE DIRIGER (
    id_entraineur INT NOT NULL,
    id_club INT NOT NULL,
    date_prise_fonction DATE NOT NULL,

    PRIMARY KEY (id_entraineur, id_club, date_prise_fonction),

    FOREIGN KEY (id_entraineur)
        REFERENCES ENTRAINEUR(id_entraineur)
        ON UPDATE CASCADE
        ON DELETE CASCADE,

    FOREIGN KEY (id_club)
        REFERENCES CLUB(id_club)
        ON UPDATE CASCADE
        ON DELETE CASCADE
);

-- 12. INSCRIRE

CREATE TABLE INSCRIRE (
    id_joueur INT NOT NULL,
    id_club INT NOT NULL,
    id_saison INT NOT NULL,
    num_maillot INT NOT NULL,

    PRIMARY KEY (id_joueur, id_club, id_saison),

    UNIQUE (id_joueur, id_saison),

    FOREIGN KEY (id_joueur)
        REFERENCES JOUEUR(id_joueur)
        ON UPDATE CASCADE
        ON DELETE CASCADE,

    FOREIGN KEY (id_club)
        REFERENCES CLUB(id_club)
        ON UPDATE CASCADE
        ON DELETE CASCADE,

    FOREIGN KEY (id_saison)
        REFERENCES SAISON(id_saison)
        ON UPDATE CASCADE
        ON DELETE CASCADE,

    CHECK (num_maillot BETWEEN 1 AND 99)
);

-- 13. CLASSER

CREATE TABLE CLASSER (
    id_club INT NOT NULL,
    id_phase INT NOT NULL,
    rang INT NOT NULL,
    points INT NOT NULL,

    PRIMARY KEY (id_club, id_phase),

    FOREIGN KEY (id_club)
        REFERENCES CLUB(id_club)
        ON UPDATE CASCADE
        ON DELETE CASCADE,

    FOREIGN KEY (id_phase)
        REFERENCES PHASE(id_phase)
        ON UPDATE CASCADE
        ON DELETE CASCADE,

    CHECK (rang > 0),
    CHECK (points >= 0)
);

-- VERIFICATION

SHOW TABLES;
