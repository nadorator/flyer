// Edge Function `sync-crm` — FL-605 (Odoo) / FL-606 (Salesforce) (Sprint 7, H4)
//
// Synchronise les contacts d'une entreprise avec un CRM externe, dans les
// deux sens, via une interface d'adaptateur commune. Les secrets (clé API
// Odoo, tokens OAuth Salesforce) sont dans Vault et déchiffrés ici seulement.
//
// Entrée (POST, JSON, JWT utilisateur requis, plan Studio / Partenaire) :
//   {
//     "connection_id": "uuid",
//     "direction": "both"          // "pull" | "push" | "both"
//   }
//
// Sortie 200 :
//   { "pulled": 12, "pushed": 7, "conflicts": 1, "last_sync_at": "ISO" }
//
// Erreurs : 400 invalid_request · 401 unauthenticated · 402 plan_required
//           404 connection_not_found · 502 provider_error
//
// Événement analytique : `crm_synced {provider, pulled, pushed}`.

import { adminClient, handler, HttpError, json, requireUser, track, type Plan } from "../_shared/supabase.ts";

type Direction = "pull" | "push" | "both";

interface SyncRequest {
  connection_id: string;
  direction?: Direction;
}

/** Contact normalisé, indépendant du fournisseur. */
export interface CrmContact {
  externalId?: string;
  fullName: string;
  email?: string;
  phone?: string;
  tags: string[];
  consentMarketing: boolean;
  updatedAt?: string;
}

/** Contrat commun des connecteurs (Odoo, Salesforce). */
export interface CrmAdapter {
  pull(since?: string): Promise<CrmContact[]>;
  push(contacts: CrmContact[]): Promise<{ externalId: string; localId: string }[]>;
}

// TODO (S7) : implémenter OdooAdapter (XML-RPC `res.partner`, clé API) et
// SalesforceAdapter (REST `Contact`, OAuth refresh token).
function createAdapter(provider: "odoo" | "salesforce", _secret: string, _instanceUrl: string): CrmAdapter {
  return {
    async pull() {
      console.log(`[sync-crm] pull ${provider} (squelette)`);
      return [];
    },
    async push(contacts) {
      console.log(`[sync-crm] push ${contacts.length} contacts vers ${provider} (squelette)`);
      return [];
    },
  };
}

Deno.serve(handler(async (req) => {
  const { user } = await requireUser(req);
  const admin = adminClient();

  const body = (await req.json().catch(() => null)) as SyncRequest | null;
  if (!body?.connection_id) throw new HttpError(400, "invalid_request");
  const direction: Direction = body.direction ?? "both";

  const { data: plan } = await admin.rpc("current_plan", { p_user_id: user.id });
  if (!(["studio", "partner"] as Plan[]).includes(plan as Plan)) {
    throw new HttpError(402, "plan_required", { required: "studio" });
  }

  const { data: connection } = await admin
    .from("crm_connections")
    .select("*, business_members!inner(user_id)")
    .eq("id", body.connection_id)
    .eq("business_members.user_id", user.id)
    .maybeSingle();
  if (!connection) throw new HttpError(404, "connection_not_found");

  // TODO (S7) : lire le secret Vault via connection.secret_id.
  const adapter = createAdapter(connection.provider, "<vault>", connection.instance_url ?? "");

  let pulled = 0;
  let pushed = 0;
  const conflicts = 0;

  if (direction !== "push") {
    const remote = await adapter.pull(connection.last_sync_at ?? undefined);
    // TODO : upsert dans `customers` par external_id, résolution « dernier écrit gagne ».
    pulled = remote.length;
  }
  if (direction !== "pull") {
    const { data: local } = await admin
      .from("customers")
      .select("id, full_name, email, phone, tags, consent_marketing, updated_at")
      .eq("business_id", connection.business_id)
      .gt("updated_at", connection.last_sync_at ?? "1970-01-01");
    const mapped: CrmContact[] = (local ?? []).map((c) => ({
      fullName: c.full_name,
      email: c.email ?? undefined,
      phone: c.phone ?? undefined,
      tags: c.tags ?? [],
      consentMarketing: c.consent_marketing,
      updatedAt: c.updated_at,
    }));
    const result = await adapter.push(mapped);
    pushed = result.length;
  }

  const lastSyncAt = new Date().toISOString();
  await admin.from("crm_connections").update({ last_sync_at: lastSyncAt }).eq("id", connection.id);
  await track(admin, user.id, "crm_synced", { provider: connection.provider, pulled, pushed });

  return json({ pulled, pushed, conflicts, last_sync_at: lastSyncAt });
}));
