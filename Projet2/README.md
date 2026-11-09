# V. Scénario d'utilisation de la base de données

## 1. Présentation du contexte

Notre base de données concerne la Ligue des champions de l'UEFA. Elle permet de stocker et de consulter des informations sur les saisons, les clubs, les joueurs, les entraîneurs, les arbitres, les stades, les matchs et les différentes phases de la compétition.

Cette base est destinée à un responsable des statistiques de la Ligue des champions. Son rôle est d'exploiter les informations enregistrées afin d'analyser le déroulement de la compétition et les performances des différents participants.

## 2. Objectifs de l'utilisateur

Le responsable des statistiques souhaite utiliser la base de données pour :

- Consulter les clubs participants et leur pays d'origine.
- Rechercher des joueurs selon leur nom, leur nationalité ou leur poste.
- Consulter les résultats des matchs et les scores.
- Identifier les joueurs associés aux événements des matchs.
- Comparer les performances des clubs selon les phases de la compétition.
- Calculer le nombre de buts inscrits pendant chaque phase.
- Analyser la fréquentation des stades.
- Consulter les arbitres ayant dirigé les rencontres.
- Connaître les joueurs inscrits dans chaque club pour une saison donnée.
- Identifier les stades ayant les plus grandes capacités d'accueil.

## 3. Données à extraire

Pour répondre à ces besoins, l'utilisateur doit pouvoir extraire plusieurs catégories d'informations :

**Informations sur les clubs :**
- Nom du club.
- Pays d'origine.
- Stade associé.
- Nombre de points et classement.

**Informations sur les joueurs :**
- Nom et prénom.
- Nationalité.
- Poste occupé.
- Club et saison d'inscription.
- Numéro de maillot.

**Informations sur les matchs :**
- Date et heure.
- Clubs à domicile et à l'extérieur.
- Nombre de buts de chaque équipe.
- Stade et phase de la compétition.
- Affluence.

**Informations statistiques :**
- Nombre de clubs par pays.
- Affluence moyenne par phase.
- Nombre total de buts par phase.
- Nombre de matchs organisés dans chaque stade.
- Nombre d'événements de chaque type.

## 4. Utilité des requêtes SQL

Les requêtes SQL réalisées permettent de répondre aux besoins du responsable des statistiques.

Les projections et sélections permettent de rechercher des informations précises et de filtrer les résultats selon différents critères.

Les fonctions d'agrégation permettent de calculer des statistiques, notamment avec COUNT, SUM et AVG, associées à GROUP BY et HAVING.

Les jointures permettent de croiser les informations provenant de plusieurs tables, par exemple pour associer un match aux deux clubs participants, au stade et à la phase concernée.

Enfin, les requêtes imbriquées permettent d'effectuer des recherches plus avancées, notamment pour identifier les clubs n'ayant participé à aucun match ou les stades ayant la plus grande capacité.

L'ensemble de ces requêtes permet d'exploiter efficacement les données de la Ligue des champions et d'obtenir une vision globale de la compétition.

## 5. Analyse des plans d'exécution

### 5.1. Requête étudiée

Nous avons choisi la requête 12 du fichier `4_interrogation.sql`.

Cette requête permet d'afficher les matchs avec le nom et la ville de leur stade ainsi que la phase de compétition correspondante.

Elle utilise trois tables : MATCH, STADE et PHASE.

### 5.2. Tailles des relations

Les données de notre base de données sont les suivantes :

- MATCH : 7 lignes.
- STADE : 8 lignes.
- PHASE : 3 lignes.

### 5.3. Premier plan d'exécution

Dans le premier plan, nous effectuons d'abord la jointure entre MATCH et STADE, puis nous joignons le résultat avec PHASE.

Calcul des instructions :

- Jointure MATCH et STADE : 7 × 8 = 56 instructions.
- Jointure du résultat avec PHASE : 7 × 3 = 21 instructions.

Total des jointures : 56 + 21 = 77 instructions.

### 5.4. Deuxième plan d'exécution

Dans le deuxième plan, nous commençons par joindre MATCH et PHASE, puis nous joignons le résultat avec STADE.

Calcul des instructions :

- Jointure MATCH et PHASE : 7 × 3 = 21 instructions.
- Jointure du résultat avec STADE : 7 × 8 = 56 instructions.

Total des jointures : 21 + 56 = 77 instructions.

### 5.5. Optimisation par projection

Pour optimiser les deux plans, nous pouvons effectuer les projections avant les jointures afin de ne conserver que les colonnes nécessaires à la requête.

Les projections initiales nécessitent :

- MATCH : 7 instructions.
- STADE : 8 instructions.
- PHASE : 3 instructions.

Soit 18 instructions supplémentaires.

La projection finale nécessite 7 instructions.

Le coût total estimé de chaque plan est donc :

77 + 18 + 7 = 102 instructions.

Le coût du tri final n'est pas inclus, car la méthode simplifiée du TD3 ne fournit pas de formule pour cette opération.

### 5.6. Conclusion

Les deux plans d'exécution présentent le même coût estimé de 102 instructions avec la méthode de calcul du TD3.

Il n'est donc pas possible de désigner un plan strictement plus performant à partir de ces estimations.

L'optimisation consiste principalement à effectuer les projections le plus tôt possible afin de limiter les données manipulées lors des jointures.