# Mini-projet Bases de données : Ligue des champions

Module TI503N, Bases de données 1.
Binôme : Raphaël Simon et Selim Rebai.

Ce dépôt contient la partie 1 du mini-projet, donc l'analyse des besoins et le MCD.

## Le domaine choisi

On voulait un domaine qu'on connaît bien tous les deux, et on est partis sur le football, plus précisément sur une organisation qui gère une compétition européenne de clubs comme le fait l'UEFA avec la Ligue des champions. Concrètement elle inscrit les clubs qualifiés, construit le calendrier, découpe la saison en phases, programme les matchs, désigne les arbitres, enregistre les résultats et publie les classements.

Au départ on avait pris les trois compétitions européennes d'un coup, Ligue des champions, Ligue Europa et Ligue Conférence, mais on s'est vite rendu compte que ça n'apportait rien : on se retrouvait avec une entité `COMPETITION` à trois lignes, et des règles de gestion diluées parce que les trois compétitions ne fonctionnent pas exactement pareil. On a donc tout recentré sur la Ligue des champions seule, et là on a pu aller beaucoup plus loin dans le déroulement sportif lui-même.

Pour le contenu on s'est appuyés sur les deux sites de l'UEFA, https://fr.uefa.com/uefachampionsleague/ pour la compétition et https://fr.uefa.com/insideuefa/ pour le fonctionnement de l'organisation.

## Étape 1 : analyse des besoins

### Le prompt

On a repris la base de prompt fournie avec le sujet sans toucher à sa structure, en remplissant uniquement les parties `[A COMPLETER]`. Le texte complet se trouve aussi dans `prompt.txt`, avec le détail de la correspondance RICARDO.

> Tu travailles dans le domaine de l'organisation de compétitions de football de clubs au niveau continental. Ton organisation a comme activité d'organiser et de gérer une seule compétition, la Ligue des champions : elle inscrit les clubs qualifiés, construit le calendrier, découpe la saison en phases successives, programme et supervise les matchs, désigne les arbitres, enregistre les résultats et publie les classements. C'est une organisation comme l'UEFA, la CONMEBOL, l'AFC ou la FIFA. Les données ont été collectées sur les saisons, les phases de la compétition, les clubs engagés, les stades, les joueurs inscrits, les entraîneurs, les matchs, les arbitres, les événements de jeu (buts et cartons) et les classements. Inspire-toi des sites web suivants : https://fr.uefa.com/uefachampionsleague/ et https://fr.uefa.com/insideuefa/.
>
> Ton organisation veut appliquer MERISE pour concevoir un système d'information. Tu es chargé de la partie analyse, c'est-à-dire de collecter les besoins auprès de l'entreprise. Elle a fait appel à un étudiant en ingénierie informatique pour réaliser ce projet, tu dois lui fournir les informations nécessaires pour qu'il applique ensuite lui-même les étapes suivantes de conception et développement de la base de données.
>
> D'abord, établis les règles de gestion des données de ton organisation, sous la forme d'une liste à puce. Elle doit correspondre aux informations que fournit quelqu'un qui connaît le fonctionnement de l'entreprise, mais pas comment se construit un système d'information.
>
> Ensuite, à partir de ces règles, fournis un dictionnaire de données brutes avec les colonnes suivantes, regroupées dans un tableau : signification de la donnée, type, taille en nombre de caractères ou de chiffres. Il doit y avoir entre 25 et 35 données. Il sert à fournir des informations supplémentaires sur chaque donnée (taille et type) mais sans a priori sur comment les données vont être modélisées ensuite.
>
> Fournis donc les règles de gestion et le dictionnaire de données.

### Où on a placé les 7 éléments de RICARDO

Le rôle est posé dès la première phrase avec « Tu travailles dans le domaine de l'organisation de compétitions de football de clubs au niveau continental », qu'on complète plus loin par « Tu es chargé de la partie analyse ». L'idée était que l'IA incarne le métier et pas l'informaticien, sinon elle a tendance à répondre directement en termes de tables et de clés.

Les instructions, ce sont les deux étapes qu'on introduit par « D'abord » et « Ensuite ». On a tenu à écrire « à partir de ces règles » pour que le dictionnaire découle vraiment des règles de gestion, parce que sans ça on obtenait deux blocs qui ne se parlaient pas.

Le contexte occupe la fin du premier paragraphe et tout le deuxième : l'activité détaillée de l'organisation, le fait qu'il n'y ait qu'une seule compétition, la liste des sujets sur lesquels les données ont été collectées, et le fait que le résultat sera repris par un étudiant qui suit la méthode MERISE.

Pour les contraintes on en a mis quatre, réparties sur les deux derniers paragraphes. Il y a d'abord les deux évidentes, le nombre de données entre 25 et 35 et le format en liste à puce. Mais les deux plus utiles sont celles qui portent sur le registre : « quelqu'un qui connaît le fonctionnement de l'entreprise, mais pas comment se construit un système d'information » empêche l'IA de répondre en vocabulaire de modélisation, et « sans a priori sur comment les données vont être modélisées ensuite » l'empêche de glisser des identifiants techniques ou des clés étrangères dans le dictionnaire.

Les références sont les deux liens UEFA placés à la fin du premier paragraphe.

Le rendement désiré est imposé deux fois, une fois pour chaque livrable : liste à puce pour les règles, et tableau à trois colonnes nommées pour le dictionnaire.

L'objectif enfin, c'est la dernière phrase, « Fournis donc les règles de gestion et le dictionnaire de données », qu'on avait déjà annoncée plus haut en disant que l'étudiant devait pouvoir continuer seul.

### Ce qu'on a vérifié dans la réponse

On a repris le résultat ligne par ligne pour voir s'il collait à ce qu'on avait demandé, et dans l'ensemble ça tenait : 35 données donc dans la fourchette, les trois colonnes demandées, des règles de gestion rédigées du point de vue métier sans jamais parler d'entité ni de cardinalité, et surtout aucun identifiant technique dans le dictionnaire, ce qui était la contrainte la plus facile à rater.

On a quand même dû tout resoumettre une fois. Comme on l'a dit plus haut, la première version portait sur les trois compétitions et le résultat partait dans tous les sens, avec des règles valables pour l'une mais pas pour les autres. On en a profité pour ajouter au contexte le fait que l'organisation inscrit les clubs qualifiés et désigne les arbitres, parce que sans ça on n'obtenait rien sur les listes de joueurs ni sur les différents rôles d'arbitrage, alors que c'est justement ce qui rend le modèle intéressant.

Il reste deux choix du dictionnaire sur lesquels on s'est posé la question. La minute de jeu est sur 3 chiffres et pas 2, simplement pour pouvoir aller jusqu'à la 120e en prolongation. Et le rang et les points sont là alors qu'on pourrait les recalculer à partir des matchs, mais comme l'organisation les publie officiellement on a considéré qu'ils font partie de ses données.

### Règles de gestion

**Saison et phases**

- L'organisation gère une seule compétition, la Ligue des champions, qui se dispute une fois par saison.
- Une saison s'écrit sous la forme « 2026/27 » et a une date de début et une date de fin.
- Une saison se découpe en plusieurs phases qui se suivent dans un ordre fixé : tours de qualification, barrages, phase de ligue, barrages à élimination directe, huitièmes, quarts, demi-finales, finale.
- La phase de ligue réunit 36 clubs, et chaque club y joue 8 matchs répartis en journées numérotées de 1 à 8.

**Clubs et stades**

- Un club a un nom, appartient à un pays et a une année de fondation.
- Un club joue ses matchs à domicile dans son stade habituel.
- Plusieurs clubs peuvent partager le même stade, comme l'AC Milan et l'Inter qui jouent tous les deux à San Siro.
- Un stade a un nom, se situe dans une ville et a une capacité en nombre de places.
- Un club peut jouer dans un autre stade que le sien, par exemple en cas de travaux ou de sanction.
- La finale se joue dans un stade désigné à l'avance, quels que soient les clubs qualifiés.

**Joueurs et entraîneurs**

- Chaque saison, un club inscrit une liste de joueurs pour la compétition.
- Un joueur a un nom, un prénom, une date de naissance, une nationalité et un poste parmi gardien, défenseur, milieu ou attaquant.
- Un joueur porte un numéro de maillot dans son club pour une saison donnée, et ce numéro peut changer d'une saison à l'autre, en général quand il change de club.
- Un joueur peut changer de club d'une saison à l'autre, mais sur une saison donnée il n'est inscrit que pour un seul club.
- Un club a un seul entraîneur principal à un moment donné, et on garde la date à laquelle il a pris ses fonctions.
- Un entraîneur a un nom, un prénom et une nationalité, et il peut entraîner plusieurs clubs dans sa carrière, y compris au cours d'une même saison s'il est remplacé en cours d'année.

**Matchs**

- Chaque match porte un numéro qui l'identifie.
- Un match oppose un club qui reçoit et un club qui se déplace, à une date et une heure données, dans un stade donné.
- Un match appartient à une seule phase, et s'il relève de la phase de ligue il porte en plus un numéro de journée.
- Pour chaque match on enregistre le nombre de buts de chaque club ainsi que l'affluence, c'est-à-dire le nombre de spectateurs.
- Dans les phases à élimination directe les clubs s'affrontent en match aller puis en match retour, et chaque match retour est rattaché à son match aller.
- La finale fait exception puisqu'elle se joue en un seul match.

**Arbitres**

- Chaque match est dirigé par une équipe d'arbitres composée d'un arbitre central, de deux assistants, d'un quatrième arbitre et d'arbitres vidéo.
- Un arbitre a un nom, un prénom et une nationalité.
- Un même arbitre officie sur beaucoup de matchs, et son rôle peut changer d'un match à l'autre.
- Un arbitre ne peut pas être désigné sur un match qui implique un club de son propre pays.

**Événements de jeu**

- Pendant un match on enregistre les faits marquants, c'est-à-dire les buts et les cartons.
- Chaque événement se rapporte à un joueur, survient à une minute précise et a un type : but en action de jeu, but sur penalty, but sur coup franc, but contre son camp, carton jaune ou carton rouge.
- Un événement n'a pas de sens en dehors du match où il s'est produit, puisque dire « 73e minute, carton jaune » ne désigne rien tant qu'on ne précise pas de quel match on parle.
- Un but contre son camp est compté pour le club adverse.
- Deux cartons jaunes reçus par un même joueur dans un même match entraînent un carton rouge.

**Classements**

- Un classement est publié pour la phase de ligue.
- Pour chaque club le classement donne son rang et son nombre de points.
- Une victoire rapporte 3 points, un match nul 1 point et une défaite 0.
- Les 8 premiers sont qualifiés directement pour les huitièmes.
- Les clubs classés de la 9e à la 24e place jouent les barrages.
- Les clubs classés de la 25e à la 36e place sont éliminés.

### Dictionnaire de données

Les types utilisés sont A pour alphabétique, AN pour alphanumérique, N pour numérique, D pour une date au format JJ/MM/AAAA et DH pour une date et heure au format JJ/MM/AAAA HH:MM.

| N° | Signification de la donnée | Type | Taille |
|:--:|---|:--:|:--:|
| 1 | Libellé de la saison (ex. 2026/27) | AN | 7 |
| 2 | Date de début de la saison | D | 10 |
| 3 | Date de fin de la saison | D | 10 |
| 4 | Nom de la phase | AN | 40 |
| 5 | Ordre de la phase dans la saison | N | 2 |
| 6 | Nom du club | AN | 50 |
| 7 | Pays du club | A | 40 |
| 8 | Année de fondation du club | N | 4 |
| 9 | Nom du stade | AN | 60 |
| 10 | Ville du stade | A | 40 |
| 11 | Capacité du stade en nombre de places | N | 6 |
| 12 | Nom du joueur | A | 40 |
| 13 | Prénom du joueur | A | 40 |
| 14 | Date de naissance du joueur | D | 10 |
| 15 | Nationalité du joueur | A | 40 |
| 16 | Poste du joueur | A | 20 |
| 17 | Numéro de maillot du joueur | N | 2 |
| 18 | Nom de l'entraîneur | A | 40 |
| 19 | Prénom de l'entraîneur | A | 40 |
| 20 | Nationalité de l'entraîneur | A | 40 |
| 21 | Date de prise de fonction de l'entraîneur | D | 10 |
| 22 | Numéro du match | N | 6 |
| 23 | Date et heure du coup d'envoi | DH | 16 |
| 24 | Numéro de la journée | N | 1 |
| 25 | Affluence du match en nombre de spectateurs | N | 6 |
| 26 | Nombre de buts du club qui reçoit | N | 2 |
| 27 | Nombre de buts du club qui se déplace | N | 2 |
| 28 | Nom de l'arbitre | A | 40 |
| 29 | Prénom de l'arbitre | A | 40 |
| 30 | Nationalité de l'arbitre | A | 40 |
| 31 | Rôle de l'arbitre sur le match | A | 30 |
| 32 | Minute de l'événement de jeu | N | 3 |
| 33 | Type de l'événement de jeu | A | 25 |
| 34 | Rang du club au classement | N | 2 |
| 35 | Nombre de points du club au classement | N | 2 |

Ce qui fait 35 données au total.

## Étape 2 : le MCD

On a fait le MCD avec Mocodo, dont le fichier source est `MCD_LDC.mcd`, et on a aussi mis une version PDF dans `MCD_LDC.pdf` pour l'impression.

![MCD de la Ligue des champions](MCD_LDC.png)

### Les entités

Le modèle compte 9 entités : `SAISON`, `PHASE`, `MATCH`, `EVENEMENT`, `CLUB`, `STADE`, `JOUEUR`, `ENTRAINEUR` et `ARBITRE`.

On a ajouté des identifiants techniques qui ne figuraient pas dans le dictionnaire, à savoir `id_saison`, `id_phase`, `id_club`, `id_stade`, `id_joueur`, `id_entraineur` et `id_arbitre`. Le sujet autorise d'ajouter des données et c'était vraiment nécessaire, parce qu'aucune donnée métier ne garantit l'unicité : deux joueurs peuvent très bien être homonymes et nés le même jour, et deux stades peuvent porter le même nom dans deux villes différentes. Le seul identifiant qu'on a gardé tel quel du dictionnaire est `num_match`, qui est d'origine métier.

### Les associations

Il y en a 13 en tout.

Les plus simples relient deux entités sans rien porter. C'est le cas de `SE_DEROULER` entre la saison et ses phases en 1,N et 1,1, de `APPARTENIR` entre une phase et ses matchs en 1,N et 1,1, de `ACCUEILLIR` entre un stade et les matchs qui s'y jouent en 0,N et 1,1, de `JOUER_A_DOMICILE` entre un stade et les clubs qui y résident en 0,N et 1,1, et de `CONCERNER` entre un joueur et les événements qui le concernent en 0,N et 1,1.

`RECEVOIR` et `SE_DEPLACER` relient toutes les deux un club à un match en 0,N et 1,1. On s'est demandé s'il ne valait pas mieux les fusionner en une seule association, mais on a finalement gardé les deux parce que le rôle domicile ou extérieur porte du sens : c'est lui qui dit lequel des deux scores est `buts_domicile`.

Quatre associations portent des données. `INSCRIRE` relie `JOUEUR` en 1,N, `CLUB` en 0,N et `SAISON` en 0,N, et porte `num_maillot`. `ARBITRER` relie `ARBITRE` et `MATCH`, tous les deux en 1,N, et porte `role_arbitre`. `DIRIGER` relie `ENTRAINEUR` en 1,N et `CLUB` en 0,N, et porte `date_prise_fonction`. Et `CLASSER` relie `CLUB` et `PHASE`, tous les deux en 0,N, en portant `rang` et `points`.

Restent `SURVENIR` et `RETOUR_DE`, qui ont un statut particulier et qu'on détaille juste en dessous.

### Les éléments de modélisation avancée

Le sujet en demande au moins deux, on en a trois.

**L'association ternaire `INSCRIRE`**

`INSCRIRE` relie trois entités à la fois, `JOUEUR`, `CLUB` et `SAISON`, et porte le numéro de maillot.

On ne peut pas la découper en associations binaires parce que le numéro de maillot ne dépend d'aucune des trois entités prise séparément. Il ne dépend pas du joueur, puisque Mbappé portait le 7 au PSG et le 9 au Real. Il ne dépend pas du club non plus, parce que le 10 du Real n'est pas le même joueur d'une saison à l'autre. Et il ne dépend évidemment pas de la saison toute seule. Le numéro appartient donc au triplet entier, ce qui est exactement le cas d'usage d'une association ternaire porteuse de données.

**L'entité faible `EVENEMENT`**

`EVENEMENT` est identifiée relativement à `MATCH` par l'association `SURVENIR`, ce qui fait de `MATCH` l'entité forte.

La raison est métier : un but ou un carton n'existe pas en dehors du match où il a été marqué. La minute et le type ne suffisent pas non plus à distinguer deux événements, puisque deux cartons jaunes peuvent très bien tomber à la même minute dans le même match. L'identifiant complet d'un événement est donc le couple (`num_match`, `num_evenement`). Sur le schéma, `num_evenement` apparaît souligné en pointillés, qui est la notation de Mocodo pour un identifiant relatif, et la patte du côté de `EVENEMENT` porte la cardinalité (1,1).

Ce choix a aussi réglé un problème qu'on avait au départ. On était partis sur deux entités séparées, `BUT` et `CARTON`, qui se retrouvaient avec exactement les mêmes attributs. En les regroupant dans `EVENEMENT` avec un attribut `type_evenement`, on supprime la duplication.

**L'association récursive `RETOUR_DE`**

`RETOUR_DE` relie `MATCH` à lui-même avec 0,1 de chaque côté, et traduit le fonctionnement des phases à élimination directe où une confrontation se joue en aller puis en retour, chaque match retour étant rattaché à son aller.

Les cardinalités minimales à 0 sont indispensables, parce que les matchs de la phase de ligue et la finale ne font partie d'aucun couple aller-retour et doivent donc pouvoir rester seuls.

### Normalisation

Pour la première forme normale, tous les attributs sont atomiques. On a séparé le nom et le prénom pour chaque personne, et il n'y a aucun attribut multivalué ni répétitif.

Pour la deuxième, le seul identifiant composite du modèle est celui de `EVENEMENT`, et ses attributs `minute_evenement` et `type_evenement` dépendent bien du couple complet et pas du seul `num_match`. Même chose pour `num_maillot` qui dépend du triplet entier de `INSCRIRE`.

Pour la troisième, il n'y a pas de dépendance transitive. Le point le plus sensible était la ville, qu'on a mise dans `STADE` et pas dans `CLUB` : la placer dans `CLUB` aurait créé la chaîne `id_club` vers `id_stade` vers `ville_stade`. On a suivi la même logique pour la nationalité, qui est un attribut propre à chaque personne et jamais déduit d'autre chose.

Il reste deux points volontairement dénormalisés et on l'assume. `buts_domicile` et `buts_exterieur` sont dans `MATCH` alors qu'on pourrait les recompter à partir des événements de type but, mais on les garde parce qu'ils correspondent au score officiel homologué, qui fait foi même si un événement n'a pas été saisi. C'est le même raisonnement pour `rang` et `points` dans `CLASSER`.

### Les 35 données du dictionnaire dans le MCD

Toutes les données du dictionnaire se retrouvent dans le MCD. Les données 1 à 3 sont dans `SAISON`, les 4 et 5 dans `PHASE`, les 6 à 8 dans `CLUB`, les 9 à 11 dans `STADE`, les 12 à 16 dans `JOUEUR`, les 18 à 20 dans `ENTRAINEUR`, les 22 à 27 dans `MATCH`, les 28 à 30 dans `ARBITRE` et les 32 et 33 dans `EVENEMENT`.

Les cinq qui restent sont portées par des associations : le numéro de maillot par `INSCRIRE`, la date de prise de fonction par `DIRIGER`, le rôle de l'arbitre par `ARBITRER`, et le rang et les points par `CLASSER`.

### Ce que le MCD ne peut pas exprimer

Certaines règles de gestion ne se traduisent pas dans le formalisme entité-association, donc on les note ici pour les reprendre en contraintes SQL à l'étape 3 :

- le club qui reçoit doit être différent de celui qui se déplace ;
- un arbitre ne peut pas être désigné sur un match impliquant un club de sa nationalité ;
- `num_journee` n'est renseigné que pour les matchs de la phase de ligue, avec une valeur de 1 à 8 ;
- sur une saison donnée, un joueur ne peut être inscrit que pour un seul club ;
- `minute_evenement` est comprise entre 1 et 120 ;
- `type_evenement` appartient à une liste fermée de valeurs ;
- un match ne peut pas être son propre match retour ;
- `points` vaut 3 fois le nombre de victoires plus le nombre de nuls.

## Contenu du dépôt

- `README.md` : ce fichier
- `prompt.txt` : le prompt soumis à l'IA et le détail de la correspondance RICARDO
- `MCD_LDC.mcd` : le fichier source du MCD, au format Mocodo
- `MCD_LDC.png` : l'image du MCD utilisée plus haut
- `MCD_LDC.pdf` : le MCD en version imprimable
