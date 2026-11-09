
-- =====================================================
-- MINI-PROJET TI503N
-- LIGUE DES CHAMPIONS
-- FICHIER : 2_contraintes.sql
-- Raphaël Simon / Selim Rebai
-- =====================================================

USE ligue_champions;

-- =====================================================
-- 1. CONTRAINTES SUR LES CLUBS
-- =====================================================

ALTER TABLE CLUB
ADD CONSTRAINT chk_annee_fondation
CHECK (
    annee_fondation IS NULL
    OR annee_fondation BETWEEN 1800 AND 2100
);

-- =====================================================
-- 2. CONTRAINTES SUR LES ARBITRES
-- =====================================================

ALTER TABLE ARBITRER
ADD CONSTRAINT chk_role_arbitre
CHECK (
    role_arbitre IN (
        'Central',
        'Assistant 1',
        'Assistant 2',
        'Quatrieme arbitre',
        'VAR',
        'Assistant VAR'
    )
);

-- =====================================================
-- 3. CONTRAINTES SUR LES EVENEMENTS
-- =====================================================

ALTER TABLE EVENEMENT
ADD CONSTRAINT chk_type_evenement
CHECK (
    type_evenement IN (
        'But',
        'But penalty',
        'But coup franc',
        'But contre son camp',
        'Carton jaune',
        'Carton rouge'
    )
);

-- =====================================================
-- 4. TRIGGER : VERIFICATION DES MATCHS
-- =====================================================

DELIMITER $$

DROP TRIGGER IF EXISTS verifier_match_insert$$

CREATE TRIGGER verifier_match_insert
BEFORE INSERT ON `MATCH`
FOR EACH ROW
BEGIN
    DECLARE v_capacite INT;
    DECLARE v_debut DATE;
    DECLARE v_fin DATE;

    -- Un club ne peut pas jouer contre lui-même

    IF NEW.id_club_domicile = NEW.id_club_exterieur THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT =
        'Erreur : un club ne peut pas jouer contre lui-meme';
    END IF;

    -- Recuperation de la capacite du stade
    -- et des dates de la saison

    SELECT st.capacite_stade,
           s.date_debut_saison,
           s.date_fin_saison
    INTO v_capacite, v_debut, v_fin
    FROM STADE st
    JOIN PHASE p ON p.id_phase = NEW.id_phase
    JOIN SAISON s ON s.id_saison = p.id_saison
    WHERE st.id_stade = NEW.id_stade;

    -- L'affluence ne peut pas depasser la capacite

    IF NEW.affluence IS NOT NULL
       AND NEW.affluence > v_capacite THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT =
        'Erreur : affluence superieure a la capacite du stade';
    END IF;

    -- Le match doit avoir lieu pendant sa saison

    IF DATE(NEW.date_heure_match) < v_debut
       OR DATE(NEW.date_heure_match) > v_fin THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT =
        'Erreur : date du match hors de la saison';
    END IF;

END$$

-- =====================================================
-- 5. TRIGGER : VERIFICATION DES MATCHS MODIFIES
-- =====================================================

DROP TRIGGER IF EXISTS verifier_match_update$$

CREATE TRIGGER verifier_match_update
BEFORE UPDATE ON `MATCH`
FOR EACH ROW
BEGIN
    DECLARE v_capacite INT;
    DECLARE v_debut DATE;
    DECLARE v_fin DATE;

    IF NEW.id_club_domicile = NEW.id_club_exterieur THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT =
        'Erreur : un club ne peut pas jouer contre lui-meme';
    END IF;

    SELECT st.capacite_stade,
           s.date_debut_saison,
           s.date_fin_saison
    INTO v_capacite, v_debut, v_fin
    FROM STADE st
    JOIN PHASE p ON p.id_phase = NEW.id_phase
    JOIN SAISON s ON s.id_saison = p.id_saison
    WHERE st.id_stade = NEW.id_stade;

    IF NEW.affluence IS NOT NULL
       AND NEW.affluence > v_capacite THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT =
        'Erreur : affluence superieure a la capacite du stade';
    END IF;

    IF DATE(NEW.date_heure_match) < v_debut
       OR DATE(NEW.date_heure_match) > v_fin THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT =
        'Erreur : date du match hors de la saison';
    END IF;

END$$

-- =====================================================
-- 6. TRIGGER : VERIFICATION DU JOUEUR D'UN EVENEMENT
-- =====================================================

DROP TRIGGER IF EXISTS verifier_evenement_insert$$

CREATE TRIGGER verifier_evenement_insert
BEFORE INSERT ON EVENEMENT
FOR EACH ROW
BEGIN
    DECLARE v_nombre INT;

    SELECT COUNT(*)
    INTO v_nombre
    FROM `MATCH` m
    JOIN PHASE p ON p.id_phase = m.id_phase
    JOIN INSCRIRE i ON i.id_saison = p.id_saison
    WHERE m.num_match = NEW.num_match
      AND i.id_joueur = NEW.id_joueur
      AND (
          i.id_club = m.id_club_domicile
          OR i.id_club = m.id_club_exterieur
      );

    IF v_nombre = 0 THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT =
        'Erreur : le joueur ne fait pas partie des clubs du match';
    END IF;

END$$

-- =====================================================
-- 7. TRIGGER : VERIFICATION LORS D'UNE MODIFICATION
-- =====================================================

DROP TRIGGER IF EXISTS verifier_evenement_update$$

CREATE TRIGGER verifier_evenement_update
BEFORE UPDATE ON EVENEMENT
FOR EACH ROW
BEGIN
    DECLARE v_nombre INT;

    SELECT COUNT(*)
    INTO v_nombre
    FROM `MATCH` m
    JOIN PHASE p ON p.id_phase = m.id_phase
    JOIN INSCRIRE i ON i.id_saison = p.id_saison
    WHERE m.num_match = NEW.num_match
      AND i.id_joueur = NEW.id_joueur
      AND (
          i.id_club = m.id_club_domicile
          OR i.id_club = m.id_club_exterieur
      );

    IF v_nombre = 0 THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT =
        'Erreur : le joueur ne fait pas partie des clubs du match';
    END IF;

END$$

DELIMITER ;

-- =====================================================
-- 8. VERIFICATION DES CONTRAINTES
-- =====================================================

SHOW CREATE TABLE CLUB;
SHOW CREATE TABLE ARBITRER;
SHOW CREATE TABLE EVENEMENT;

-- Verification des triggers

SHOW TRIGGERS;
