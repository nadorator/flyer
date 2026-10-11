# Flyer — Règles de sprint

Ces règles encadrent une petite équipe (1–3 dev Flutter, 1 produit/design, l'amie photographe comme *lead user*) qui travaille en **Lean UX** : chaque sprint doit **valider ou invalider au moins une hypothèse** du [canvas](01-lean-ux-canvas.md), pas seulement livrer des fonctionnalités.

## 1. Cadence

| Élément | Règle |
|---|---|
| Durée | Sprints de **2 semaines** (du lundi au vendredi de la semaine suivante). Sprint 0 de cadrage : **1 semaine**. |
| Release | Chaque sprint se termine par une version **testable** (TestFlight / Google Play Internal testing) même si des features sont derrière un flag. |
| Vélocité de référence | 30–35 pts / sprint pour 2 dev ; recalibrée après S1 et S2. |
| Capacité réservée | 20 % du sprint pour la dette technique, les retours utilisateurs et les bugs. |

## 2. Rituels

| Rituel | Quand | Durée | Contenu |
|---|---|---|---|
| **Sprint planning** | Lundi J1 | 2 h | Rappel de l'hypothèse du sprint, sélection des stories *Ready*, découpage, engagement. |
| **Daily** | Chaque jour | 15 min | Avancement, blocages, ce qu'on a appris des utilisateurs hier. |
| **Session utilisateurs** | Semaine 2, mardi/mercredi | 3 × 45 min | Test modéré avec **≥ 3 photographes** (dont ≥ 1 nouveau) sur la build du sprint ; grille d'observation liée à l'hypothèse. |
| **Sprint review orientée hypothèses** | Vendredi J10 | 1 h | Démo **par persona** (« Camille crée un event… »), puis **verdict sur l'hypothèse** : métriques, verbatims, décision Persévérer / Pivoter / Abandonner. Mise à jour du canvas. |
| **Rétrospective** | Vendredi J10 | 1 h | Process, outils, collaboration ; 1 à 3 actions concrètes suivies au sprint suivant. |
| **Backlog refinement** | Semaine 1, jeudi | 1 h | Préparer les stories du sprint suivant jusqu'à l'état *Ready*. |

### Format de la sprint review
1. Hypothèse du sprint et métrique cible (2 min).
2. Démo scénarisée par persona (15 min).
3. Résultats : métriques analytics + synthèse de la session utilisateurs (15 min).
4. Verdict : ✅ Validée / ❌ Invalidée / 🔁 À poursuivre, et décision produit (10 min).
5. Impact sur le backlog du sprint suivant (10 min).

## 3. Definition of Ready (DoR)

Une story entre dans un sprint seulement si :

- [ ] Elle est rédigée au format *En tant que [persona], je veux… afin de…* et référence un **persona** réel du [doc personas](02-personas.md).
- [ ] Elle est reliée à une **hypothèse** (H0–H6) ou marquée « transversal / RGPD ».
- [ ] Elle possède des **critères d'acceptation Gherkin** (Étant donné / Quand / Alors).
- [ ] Les **événements analytiques** à émettre sont nommés.
- [ ] Un wireframe ou une maquette existe pour toute story avec UI.
- [ ] Elle est estimée à **≤ 8 points** (sinon découpée).
- [ ] Les dépendances externes (comptes API, secrets, assets) sont identifiées et disponibles ou mockées.

## 4. Definition of Done (DoD)

Une story est terminée seulement si :

- [ ] Code fusionné sur `main` via **pull request revue** par un pair.
- [ ] `flutter analyze` : **0 erreur, 0 warning** sur les fichiers touchés.
- [ ] `dart run build_runner build` passe ; fichiers générés à jour.
- [ ] **Tests** : unitaires pour la logique métier (validation, mapping), widget test pour chaque nouvelle page, test d'Edge Function si concernée ; tous verts en CI.
- [ ] **Événement analytique** câblé et visible dans `analytics_events` en staging.
- [ ] Textes en **français**, clés i18n (pas de chaînes codées en dur dans les widgets au-delà du placeholder).
- [ ] Fonctionnalité incomplète → derrière un **feature flag**.
- [ ] Aucun secret dans le client (`.env` ignoré par git, revue des diffs).
- [ ] RLS / politiques Supabase mises à jour si le schéma change ; migration versionnée dans `supabase/migrations`.
- [ ] Documentation mise à jour (`docs/`, README) si le comportement ou l'architecture change.
- [ ] Démo réalisable sur la build TestFlight / Internal testing.

## 5. Règles produit

1. **Une hypothèse par sprint minimum** : si aucune hypothèse n'est testable, le sprint est mal planifié.
2. **L'IA propose, l'utilisateur valide** : jamais de publication automatique sans action explicite.
3. **Zéro dépendance au partenaire** : toute feature doit apporter de la valeur même si le magasin ne fait rien.
4. **Pas de clé API dans le client** : tout appel externe passe par une Edge Function.
5. **RGPD by design** : consentement explicite, minimisation des données, export/suppression dès que des données clients existent (S3).
6. **Mobile d'abord** : chaque écran est conçu pour un usage à une main, en moins de 15 min au total pour un event.
7. **Mesurer avant d'optimiser** : pas de feature « Could » tant que les métriques du MVP ne sont pas lues.
8. **Les personas évoluent** : après chaque session utilisateurs, mettre à jour [02-personas.md](02-personas.md) (verbatims, verdicts).

## 6. Conventions de code Flutter

### Architecture
- **Par feature** : `lib/features/<feature>/{data,domain,presentation}`.
  - `domain/` : modèles `freezed`, enums, règles métier pures (pas de Flutter, pas de Supabase).
  - `data/` : repositories (Supabase), DTO, mappers.
  - `presentation/` : pages, widgets, providers Riverpod.
- `lib/core/` : code partagé (client Supabase, analytics, widgets communs, utilitaires).
- `lib/app/` : `app.dart`, `router.dart`, `theme.dart`.

### État & données
- **Riverpod** (`flutter_riverpod` + `riverpod_annotation`) ; un provider par source de données ; `AsyncValue` pour les chargements.
- **freezed** + `json_serializable` pour tout modèle ; `copyWith` plutôt que mutation.
- Les repositories renvoient des modèles de domaine, jamais des `Map<String, dynamic>` au-delà de la couche `data`.

### Navigation
- **go_router** ; routes nommées et typées dans `router.dart` ; redirection auth centralisée ; deep links `/e/:slug` et `/kit/:token`.

### Qualité
- `flutter_lints` + règles supplémentaires dans `analysis_options.yaml` (`prefer_const_constructors`, `always_declare_return_types`, `avoid_print` hors debug…).
- Tests dans `test/` miroir de `lib/` ; `mocktail` pour les doubles.
- Nommage : fichiers `snake_case.dart`, classes `PascalCase`, providers suffixés `Provider`, pages suffixées `Page`.
- Commits : [Conventional Commits](https://www.conventionalcommits.org) (`feat(events): …`, `fix(auth): …`) avec l'ID de story (`FL-201`).
- Branches : `feat/FL-201-event-form`, PR vers `main`, squash merge.

### Supabase
- Migrations SQL versionnées (`supabase/migrations/NNNN_description.sql`), jamais de modification manuelle en prod.
- Edge Functions en TypeScript (Deno), une fonction = un dossier, contrat d'entrée/sortie documenté en tête de fichier, validation des entrées.
- RLS activée sur toute nouvelle table avant la première PR.

## 7. Gestion des apprentissages

- Un fichier `docs/learnings/SPRINT-<n>.md` (à créer à partir de S1) consigne : hypothèse, métriques, verbatims, verdict, décisions.
- Le [canvas](01-lean-ux-canvas.md) et le [backlog](03-backlog-priorise.md) sont mis à jour dans la même PR que les learnings.
