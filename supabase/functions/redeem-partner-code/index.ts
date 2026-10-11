// Edge Function `redeem-partner-code` — FL-704 (Sprint 6, hypothèse H3)
//
// Active un code partenaire pour l'utilisateur connecté : vérifie validité,
// fenêtre temporelle et nombre d'utilisations, puis crée un abonnement
// `source = partner_code`. Les codes ne sont jamais lisibles depuis le client
// (aucune policy RLS select) ; la réponse d'erreur est volontairement
// générique pour éviter l'énumération.
//
// Entrée (POST, JSON, JWT utilisateur requis) :
//   { "code": "AMB-AHMED-2026" }
//
// Sortie 200 :
//   { "plan": "partner", "valid_until": "2027-10-11T00:00:00Z", "requires_feedback": true }
//
// Erreurs : 400 invalid_request · 401 unauthenticated
//           404 invalid_code (code inconnu, expiré, épuisé ou déjà utilisé)
//
// Événement analytique : `partner_code_redeemed {code_id, plan}`.

import { adminClient, handler, HttpError, json, requireUser, track } from "../_shared/supabase.ts";

interface RedeemRequest {
  code: string;
}

Deno.serve(handler(async (req) => {
  const { user } = await requireUser(req);
  const admin = adminClient();

  const body = (await req.json().catch(() => null)) as RedeemRequest | null;
  const code = body?.code?.trim().toUpperCase();
  if (!code) throw new HttpError(400, "invalid_request");

  const now = new Date();
  const { data: partnerCode } = await admin
    .from("partner_codes")
    .select("*")
    .eq("code", code)
    .maybeSingle();

  const isValid = partnerCode &&
    new Date(partnerCode.valid_from) <= now &&
    (!partnerCode.valid_until || new Date(partnerCode.valid_until) > now) &&
    partnerCode.redemptions_count < partnerCode.max_redemptions;
  if (!isValid) throw new HttpError(404, "invalid_code");

  // Un seul code actif par utilisateur.
  const { data: existing } = await admin
    .from("subscriptions")
    .select("id")
    .eq("user_id", user.id)
    .eq("source", "partner_code")
    .or(`current_period_end.is.null,current_period_end.gt.${now.toISOString()}`)
    .maybeSingle();
  if (existing) throw new HttpError(404, "invalid_code", { reason: "already_active" });

  const validUntil = new Date(now.getTime() + partnerCode.duration_days * 86_400_000).toISOString();

  // TODO (S6) : rendre atomique via une fonction SQL `redeem_partner_code`
  // (incrément + insert dans la même transaction, verrou sur la ligne du code).
  const { error: insertError } = await admin.from("subscriptions").insert({
    user_id: user.id,
    plan: partnerCode.plan_granted,
    source: "partner_code",
    current_period_end: validUntil,
    partner_code_id: partnerCode.id,
  });
  if (insertError) throw insertError;

  await admin
    .from("partner_codes")
    .update({ redemptions_count: partnerCode.redemptions_count + 1 })
    .eq("id", partnerCode.id);

  await track(admin, user.id, "partner_code_redeemed", {
    code_id: partnerCode.id,
    plan: partnerCode.plan_granted,
    owner_user_id: partnerCode.owner_user_id,
  });

  return json({
    plan: partnerCode.plan_granted,
    valid_until: validUntil,
    requires_feedback: partnerCode.requires_feedback,
  });
}));
