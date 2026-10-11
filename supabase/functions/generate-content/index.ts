// Edge Function `generate-content` — FL-301 / FL-302 (Sprint 2, hypothèse H1)
//
// Génère les textes et visuels d'un event pour chaque plateforme demandée.
// Les clés IA (LLM, API image) vivent uniquement ici (secrets Supabase) ;
// le client Flutter n'appelle jamais les fournisseurs directement.
//
// Entrée (POST, JSON, JWT utilisateur requis) :
//   {
//     "event_id": "uuid",
//     "platforms": ["instagram", "facebook", "print_a4"],
//     "tone": "chaleureux"            // optionnel, ton global ou par plateforme
//     "regenerate_only": "text"       // optionnel : "text" | "image"
//   }
//
// Sortie 200 :
//   {
//     "proposals": [
//       { "platform": "instagram", "kind": "text", "content": "...", "id": "uuid" },
//       ...                            // 3 textes par plateforme
//     ],
//     "images": [
//       { "kind": "image_square", "url": "https://.../flyers/...png", "id": "uuid" },
//       { "kind": "image_story",  "url": "...", "id": "uuid" },
//       { "kind": "image_a4",     "url": "...", "id": "uuid" }
//     ],
//     "quota": { "used": 6, "limit": 100 }
//   }
//
// Erreurs : 400 invalid_request · 401 unauthenticated · 402 quota_reached
//           404 event_not_found · 500 internal_error
//
// Événements analytiques : `flyer_generated` (serveur) ; `quota_reached`.

import {
  adminClient,
  handler,
  HttpError,
  json,
  requireUser,
  track,
  type Plan,
} from "../_shared/supabase.ts";

const AI_QUOTA_PER_MONTH: Record<Plan, number> = {
  free: 5,
  pro: 100,
  studio: 300,
  partner: 300,
};

interface GenerateRequest {
  event_id: string;
  platforms: string[];
  tone?: string;
  regenerate_only?: "text" | "image";
}

Deno.serve(handler(async (req) => {
  const { client, user } = await requireUser(req);
  const admin = adminClient();

  const body = (await req.json().catch(() => null)) as GenerateRequest | null;
  if (!body?.event_id || !Array.isArray(body.platforms) || body.platforms.length === 0) {
    throw new HttpError(400, "invalid_request");
  }

  // 1. Plan & quota (toujours côté serveur).
  const { data: plan } = await admin.rpc("current_plan", { p_user_id: user.id });
  const limit = AI_QUOTA_PER_MONTH[(plan as Plan) ?? "free"];
  const monthStart = new Date();
  monthStart.setUTCDate(1);
  monthStart.setUTCHours(0, 0, 0, 0);
  const { count: used } = await admin
    .from("analytics_events")
    .select("id", { count: "exact", head: true })
    .eq("user_id", user.id)
    .eq("name", "flyer_generated")
    .gte("created_at", monthStart.toISOString());
  if ((used ?? 0) >= limit) {
    await track(admin, user.id, "quota_reached", { kind: "ai", limit });
    throw new HttpError(402, "quota_reached", { used, limit });
  }

  // 2. Event + entreprise (RLS : l'utilisateur doit être membre).
  const { data: event, error } = await client
    .from("events")
    .select("*, businesses(name, logo_url, colors, phone, website, socials)")
    .eq("id", body.event_id)
    .single();
  if (error || !event) throw new HttpError(404, "event_not_found");

  // 3. TODO (S2) : appel LLM → 3 textes / plateforme (sortie JSON structurée),
  //    puis API image → fond visuel, composition texte côté serveur
  //    (carré, story, A4), upload dans Storage `flyers/`.
  //    Aucune donnée personnelle de client ne doit entrer dans les prompts.
  const proposals = body.platforms.flatMap((platform) =>
    [1, 2, 3].map((n) => ({
      platform,
      kind: "text",
      content: `[squelette] Proposition ${n} pour ${platform} — ${event.name}`,
    }))
  );
  const images: { kind: string; url: string }[] = [];

  // 4. Persistance des propositions.
  const { data: inserted } = await admin
    .from("generated_contents")
    .insert(
      proposals.map((p) => ({
        event_id: event.id,
        platform_code: p.platform,
        kind: p.kind,
        content: p.content,
        model: "skeleton",
        cost_cents: 0,
      })),
    )
    .select("id, platform_code, kind, content");

  await track(admin, user.id, "flyer_generated", {
    event_id: event.id,
    platforms: body.platforms,
    proposals: proposals.length,
  });

  return json({
    proposals: (inserted ?? []).map((row) => ({
      id: row.id,
      platform: row.platform_code,
      kind: row.kind,
      content: row.content,
    })),
    images,
    quota: { used: (used ?? 0) + 1, limit },
  });
}));
