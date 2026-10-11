# Flyer

> L'app Android / iOS des photographes événementiels : créez un event, laissez l'IA générer vos flyers et vos textes, publiez partout, donnez au magasin partenaire un kit prêt à relayer, et gardez le contact avec vos clients.

**Problème terrain** : le magasin partenaire promet de faire la pub et de prendre les réservations… et la veille au soir, rien n'a été fait. Flyer redonne la main au photographe sur sa communication et son remplissage.

## Documentation produit (Lean UX)

| Document | Contenu |
|---|---|
| [docs/00-vision.md](docs/00-vision.md) | Problème, proposition de valeur, cibles, principes produit |
| [docs/01-lean-ux-canvas.md](docs/01-lean-ux-canvas.md) | Lean UX Canvas (8 cases), hypothèses H0–H6, MVP, métriques |
| [docs/02-personas.md](docs/02-personas.md) | 5 personas simulés (Camille, Marc, Sophie, Léa, Ahmed), empathy & journey maps |
| [docs/03-backlog-priorise.md](docs/03-backlog-priorise.md) | Epics E1–E8, stories Gherkin, MoSCoW, matrice valeur/effort |
| [docs/04-regles-sprints.md](docs/04-regles-sprints.md) | Cadence, rituels, DoR / DoD, règles produit, conventions de code |
| [docs/05-monetisation.md](docs/05-monetisation.md) | Plans Gratuit / Pro / Studio / Partenaire, quotas, codes partenaires, B2B |
| [docs/06-preparation-sprints.md](docs/06-preparation-sprints.md) | Sprints S0 → S7 : objectifs, hypothèses, stories, métriques, risques |
| [docs/07-architecture.md](docs/07-architecture.md) | Flutter + Supabase + Edge Functions, schéma, flux, sécurité, RGPD |
| [docs/08-design-tokens-et-maquettes-s1.md](docs/08-design-tokens-et-maquettes-s1.md) | Design tokens (`theme.dart`), maquettes basse fidélité S1, checklist Ready |
| [docs/09-guide-entretiens.md](docs/09-guide-entretiens.md) | Guide d'entretiens S0, fiche de synthèse, checklist comptes développeur |

## Stack

- **Flutter** 3.32 / Dart 3.8 — Material 3, `flutter_riverpod`, `go_router`, `freezed`.
- **Supabase** (région EU) — Auth, Postgres + RLS, Storage, Edge Functions (Deno).
- **IA, réseaux sociaux, CRM** — uniquement via Edge Functions (aucune clé dans l'app).
- **Monétisation** — RevenueCat (`purchases_flutter`) + codes partenaires.

## Démarrer

### Prérequis
- Flutter 3.32+ (`flutter doctor` sans erreur bloquante).
- [Supabase CLI](https://supabase.com/docs/guides/cli) (optionnel pour le backend local).

### Configuration

```bash
cp .env.example .env
# Renseignez SUPABASE_URL et SUPABASE_ANON_KEY (projet Supabase, région EU)
```

Sans `.env` valide, l'app démarre quand même en **mode non configuré** (écran de connexion placeholder, aucun appel réseau).

### Commandes

```bash
flutter pub get
dart run build_runner build --delete-conflicting-outputs   # génère freezed / json
flutter analyze
flutter test
flutter run
```

### Backend Supabase

Projet hébergé (région EU, Irlande) : les migrations sont appliquées avec la CLI via `npx` (pas d'installation globale nécessaire).

```bash
export SUPABASE_ACCESS_TOKEN=sbp_...            # token personnel : https://supabase.com/dashboard/account/tokens
npx supabase@latest link --project-ref <ref>    # une seule fois, crée supabase/.temp (ignoré par git)
npx supabase@latest db push                     # applique supabase/migrations/*.sql
npx supabase@latest db advisors --linked        # lints sécurité / perf : 0 ERROR attendu
npx supabase@latest migration new <nom>         # nouvelle migration (imperative)
```

En local (Docker) :

```bash
npx supabase@latest start                       # Postgres local
npx supabase@latest db reset                    # rejoue les migrations
npx supabase@latest functions serve             # Edge Functions en local
```

Les squelettes d'Edge Functions se trouvent dans `supabase/functions/` : `generate-content`, `publish-meta`, `sync-crm`, `redeem-partner-code`.

Buckets Storage (migration `storage_buckets`) : `logos` (public, 2 Mo), `flyers` et `kits` (privés, URLs signées). Convention de chemin : `<business_id>/<fichier>` — les policies n'autorisent que les membres de l'entreprise.

### Intégration continue

`.github/workflows/ci.yml` s'exécute sur chaque push / PR :
- **flutter** : `build_runner`, `dart format --set-exit-if-changed`, `flutter analyze --fatal-infos`, `flutter test --coverage` ;
- **supabase** : rejeu de toutes les migrations sur un Postgres local + `db lint`.

## Structure du code

```
lib/
  main.dart                 # .env, init Supabase tolérante, ProviderScope
  app/                      # app.dart, router.dart (go_router), theme.dart
  core/
    supabase/               # client + état configuré / non configuré
    analytics/              # événements Lean UX typés
    widgets/                # PlaceholderPage…
  features/
    auth/  business_profile/  events/  ai_content/
    publishing/  partner_kit/  crm/  billing/
      {data,domain,presentation}
supabase/
  migrations/               # schéma SQL + RLS
  functions/                # Edge Functions (Deno / TypeScript)
test/                       # miroir de lib/
```

## Contribuer

Lire [docs/04-regles-sprints.md](docs/04-regles-sprints.md) (Definition of Ready / Done, conventions). Branches `feat/FL-xxx-description`, commits [Conventional Commits](https://www.conventionalcommits.org), PR vers `main`.
