// Edge Function `publish-meta` — FL-403 / FL-404 (Sprint 4, hypothèse H1 bis)
//
// Publie un contenu sur Instagram (Graph API /media + /media_publish) ou sur
// une page Facebook (/feed, /photos). Les tokens OAuth sont stockés chiffrés
// (Vault) et déchiffrés uniquement ici. Appelée par l'app (publication
// immédiate) ou par pg_cron (publications programmées).
//
// Entrée (POST, JSON) :
//   { "publication_id": "uuid" }
//   — JWT utilisateur (membre de l'entreprise) ou en-tête `x-cron-secret`
//     pour les appels planifiés.
//
// Sortie 200 :
//   { "status": "published", "external_id": "1789...", "published_at": "ISO" }
// Sortie 502 (échec plateforme, publication marquée `failed`) :
//   { "status": "failed", "error": "message Meta" }
//
// Erreurs : 400 invalid_request · 401 unauthenticated · 404 publication_not_found
//           409 connection_missing · 500 internal_error
//
// Événements analytiques : `publish_success` / `publish_failed` (serveur).

import { adminClient, handler, HttpError, json, requireUser, track } from "../_shared/supabase.ts";

interface PublishRequest {
  publication_id: string;
}

Deno.serve(handler(async (req) => {
  const admin = adminClient();
  const isCron = req.headers.get("x-cron-secret") === Deno.env.get("CRON_SECRET");
  const userId = isCron ? null : (await requireUser(req)).user.id;

  const body = (await req.json().catch(() => null)) as PublishRequest | null;
  if (!body?.publication_id) throw new HttpError(400, "invalid_request");

  const { data: publication } = await admin
    .from("publications")
    .select("*, events(id, name, business_id), generated_contents(content, asset_url), social_connections(*)")
    .eq("id", body.publication_id)
    .single();
  if (!publication) throw new HttpError(404, "publication_not_found");
  if (!publication.social_connections) throw new HttpError(409, "connection_missing");

  // Vérification d'appartenance pour les appels utilisateur.
  if (userId) {
    const { data: member } = await admin
      .from("business_members")
      .select("user_id")
      .eq("business_id", publication.events.business_id)
      .eq("user_id", userId)
      .maybeSingle();
    if (!member) throw new HttpError(401, "unauthenticated");
  }

  await admin.from("publications").update({ status: "publishing" }).eq("id", publication.id);

  try {
    // TODO (S4) :
    //  1. Déchiffrer le token : select decrypted_secret from vault.decrypted_secrets
    //     where id = publication.social_connections.access_token_secret_id
    //  2. Instagram : POST /{ig-user-id}/media {image_url, caption}
    //                 puis POST /{ig-user-id}/media_publish {creation_id}
    //     Facebook  : POST /{page-id}/photos {url, message} ou /feed {message, link}
    //  3. Gérer l'expiration du token → status 'failed' + error 'token_expired'
    const externalId = `skeleton-${crypto.randomUUID()}`;
    const publishedAt = new Date().toISOString();

    await admin
      .from("publications")
      .update({ status: "published", external_id: externalId, published_at: publishedAt, error: null })
      .eq("id", publication.id);
    await track(admin, userId, "publish_success", {
      event_id: publication.events.id,
      platform: publication.platform_code,
    });

    return json({ status: "published", external_id: externalId, published_at: publishedAt });
  } catch (e) {
    const message = e instanceof Error ? e.message : String(e);
    await admin.from("publications").update({ status: "failed", error: message }).eq("id", publication.id);
    await track(admin, userId, "publish_failed", {
      event_id: publication.events.id,
      platform: publication.platform_code,
      error: message,
    });
    return json({ status: "failed", error: message }, 502);
  }
}));
