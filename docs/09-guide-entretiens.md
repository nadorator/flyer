# 09 — Guide d'entretiens Sprint 0 & checklist comptes

Objectif Sprint 0 : **5 interviews de photographes** (30 min) + **1 interview de responsable de magasin**, pour confronter les proto-personas (`02-personas.md`) au terrain et obtenir **≥ 3 verbatims réels par persona**. Les maquettes (`08-design-tokens-et-maquettes-s1.md`) sont montrées en fin d'entretien seulement.

## 1. Recrutement
| Cible | Persona visé | Où les trouver | Objectif |
|---|---|---|---|
| Photographe animalier en magasin (indépendant) | Camille | l'amie photographe + ses collègues sur les mêmes enseignes | 2 |
| Photographe multi-salons / famille / mariage, déjà équipé (CRM, newsletter) | Marc | groupes Facebook « Photographes pros France », Instagram local | 2 |
| Photographe débutant ou en reconversion, prêt à tester gratuitement | Ahmed | groupes Facebook, école de photo, bouche-à-oreille | 1 |
| Responsable / adjoint de magasin Zooplus, Maxi Zoo, Animalis | Sophie | via le photographe : « le magasin où tu vas la semaine prochaine » | 1 |

Message type (DM / SMS) : *« Je prépare une app pour aider les photographes à remplir leurs séances en magasin. 30 min en visio ou par téléphone pour que tu me racontes ta dernière séance ? Rien à préparer, pas de vente. »*

## 2. Trame photographe (30 min)

**Règles** : questions ouvertes, laisser les silences, relancer avec « raconte-moi la dernière fois que… », **ne pas présenter la solution avant la minute 22**, noter les verbatims mot à mot.

| Min | Bloc | Questions |
|---|---|---|
| 0–3 | Accueil | Présentation, consentement à la prise de notes/enregistrement, « il n'y a pas de bonne réponse ». |
| 3–8 | Contexte | Depuis combien de temps ? Quelle part de ton CA vient des séances en magasin / événements ? Combien d'events par mois ? Seul ou en équipe ? |
| 8–16 | **Le dernier event** (cœur) | Raconte-moi ta dernière séance en magasin, du premier contact avec le magasin au soir de la séance. Qui devait faire la pub ? Qu'est-ce qui a été fait réellement ? Combien de créneaux étaient réservés la veille ? Comment l'as-tu su ? Qu'as-tu fait ce soir-là ? |
| 16–22 | Pratiques actuelles | Comment communiques-tu aujourd'hui (réseaux, affiches, groupes locaux) ? Combien de temps ça te prend par event ? Qu'est-ce qui te saoule le plus ? Comment gardes-tu les coordonnées de tes clients ? Les recontactes-tu ? Avec quoi (Excel, carnet, CRM) ? Payes-tu déjà un outil ? Combien ? |
| 22–27 | Réaction aux maquettes | Montrer 4.3 puis 4.4 (`08`). « Qu'est-ce que tu comprends ? » « Qu'est-ce qui manque pour ta prochaine séance ? » « Combien de temps tu penses mettre à remplir ça ? » Puis évoquer : flyers IA, kit pour le magasin, publication automatique, CRM, import CSV. Pour chaque : *l'utiliserais-tu la semaine prochaine ? oui / peut-être / non — pourquoi ?* |
| 27–30 | Clôture | « Si tu avais une baguette magique pour ta prochaine séance ? » Prix acceptable par mois ? Accepterais-tu de tester une bêta et de rappeler le magasin après ? Contact d'un collègue ? |

### Signaux à écouter (validation des hypothèses)
| Hypothèse | Signal positif | Signal négatif |
|---|---|---|
| H0 création < 5 min | « je saisis déjà tout ça dans mon agenda / mes stories » | infos dispersées, horaires différents chaque jour, plusieurs intervenants |
| H1 IA & multi-publication | « je mets 2–3 h à faire mes visuels / je ne poste que sur Insta faute de temps » | déjà un graphiste, veut un contrôle total du visuel, poste déjà partout en 20 min |
| H2 kit partenaire | « le magasin me demande toujours une affiche », « ils n'ont rien imprimé » | le magasin a sa propre com' nationale, interdiction d'affichage |
| H3 code partenaire | prêt à parrainer, demande « c'est combien ? » avant la fin | méfiance envers le gratuit, pas le temps de faire des retours |
| H4 CSV suffit | Excel / carnet / Instagram DM comme CRM | déjà sur Salesforce / Odoo / HubSpot |

## 3. Trame responsable de magasin (20 min)
1. Combien d'animations (photo ou autres) par mois ? Qui les organise ?
2. Raconte-moi la dernière séance photo : qu'est-ce que le photographe t'a envoyé ? Qu'as-tu fait avec ? Qu'est-ce qui t'a manqué ?
3. Qui gère la page Facebook / Google du magasin ? Peux-tu publier librement ou faut-il passer par le siège ?
4. Comment prends-tu les réservations (cahier, caisse, téléphone) ? Combien de temps par réservation ?
5. Montrer l'idée du **kit partenaire** (lien → affiche A4 + post prêt + QR). « Tu l'ouvrirais ? Tu l'imprimerais ? Qui doit le recevoir et quand (J-15 ? J-7 ?) ? »
6. Qu'est-ce qui te ferait vraiment relayer : un bon pour tes clients, un chiffre de ventes additionnelles, un message du siège ?

## 4. Fiche de synthèse (1 par entretien, à remplir le jour même)
```
Date / Durée / Canal :
Profil : (Camille | Marc | Ahmed | Sophie | autre : …)  — écart au persona :
Dernier event : magasin, nb créneaux, nb réservés la veille, action de secours
Temps de com' par event :            Outils actuels :            Budget outils/mois :
Verbatims (3 minimum, mot à mot) :
  1.
  2.
  3.
Réactions maquettes : compréhension (1–5), manque principal, estimation temps de saisie
Fonctions : flyers IA (O/P/N) · kit magasin (O/P/N) · publication auto (O/P/N) · CRM (O/P/N) · CSV (O/P/N)
Prix acceptable :                     Bêta-testeur ? (O/N)        Contact collègue :
Surprise / apprentissage principal :
```

## 5. Restitution (fin de S0)
- Mise à jour de `02-personas.md` : ≥ 3 verbatims réels par persona, traits corrigés, persona éventuellement **fusionné ou supprimé** s'il n'existe pas sur le terrain.
- Tableau hypothèses × signaux (compte des O/P/N) ajouté à `01-lean-ux-canvas.md`.
- Décision explicite au planning S1 : maquettes confirmées / amendées (quels champs retirés, quels ajoutés).
- Liste des **bêta-testeurs** (objectif ≥ 3) pour le test utilisateur de S1.

## 6. Checklist comptes & démarches (à lancer dès S0, délais longs)
| Démarche | Pourquoi | Délai | État |
|---|---|---|---|
| **Apple Developer Program** (99 $/an, idéalement en organisation → D-U-N-S) | TestFlight, Sign in with Apple (S1), in-app purchases (S6) | 2 j (individuel) à 3 sem (D-U-N-S) | ☐ |
| **Google Play Console** (25 $ une fois) + test interne | Internal testing S1, Google Sign-In, Play Billing (S6) | 2–7 j de vérification d'identité | ☐ |
| **Google Cloud OAuth consent screen** (client Android / iOS / Web) | Google Sign-In S1 | 1 j (+ vérification si logo/scopes) | ☐ |
| **Meta for Developers** : app + Instagram Graph / Pages, App Review | Publication automatique S4 | 2–6 sem (review) | ☐ |
| **Google Business Profile API** : demande d'accès | Publication S4 | 1–2 sem | ☐ |
| **RevenueCat** : compte + projet | Monétisation S6 | 1 h | ☐ |
| **Clés LLM / API image** (secrets Supabase `supabase secrets set`) | Edge Function `generate-content` S2 | 1 h | ☐ |
| Nom de domaine `flyer…` + redirection deep links (`/e/<slug>`, `/kit/<token>`) | Page publique S3, OAuth redirect | 1 j | ☐ |
| Révoquer / régénérer le token Supabase `sbp_…` partagé pendant S0 ; stocker en secret GitHub `SUPABASE_ACCESS_TOKEN` si la CI déploie un jour | Hygiène sécurité | 10 min | ☐ |
