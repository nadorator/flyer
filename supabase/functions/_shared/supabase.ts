// Utilitaires communs aux Edge Functions Flyer.
import { createClient, type SupabaseClient } from "jsr:@supabase/supabase-js@2";

export type Plan = "free" | "pro" | "studio" | "partner";

/** Client agissant au nom de l'utilisateur appelant (RLS appliquée). */
export function userClient(req: Request): SupabaseClient {
  return createClient(
    Deno.env.get("SUPABASE_URL")!,
    Deno.env.get("SUPABASE_ANON_KEY")!,
    { global: { headers: { Authorization: req.headers.get("Authorization") ?? "" } } },
  );
}

/** Client service role (contourne la RLS) — à n'utiliser que côté serveur. */
export function adminClient(): SupabaseClient {
  return createClient(
    Deno.env.get("SUPABASE_URL")!,
    Deno.env.get("SUPABASE_SERVICE_ROLE_KEY")!,
  );
}

/** Retourne l'utilisateur authentifié ou lève une erreur 401. */
export async function requireUser(req: Request) {
  const client = userClient(req);
  const { data, error } = await client.auth.getUser();
  if (error || !data.user) throw new HttpError(401, "unauthenticated");
  return { client, user: data.user };
}

export class HttpError extends Error {
  constructor(public status: number, message: string, public details?: unknown) {
    super(message);
  }
}

export function json(body: unknown, status = 200): Response {
  return new Response(JSON.stringify(body), {
    status,
    headers: { "Content-Type": "application/json", ...corsHeaders },
  });
}

export const corsHeaders = {
  "Access-Control-Allow-Origin": "*",
  "Access-Control-Allow-Headers": "authorization, x-client-info, apikey, content-type",
};

/** Enveloppe standard : CORS, gestion d'erreurs, journalisation. */
export function handler(fn: (req: Request) => Promise<Response>) {
  return async (req: Request): Promise<Response> => {
    if (req.method === "OPTIONS") return new Response("ok", { headers: corsHeaders });
    try {
      return await fn(req);
    } catch (e) {
      if (e instanceof HttpError) {
        return json({ error: e.message, details: e.details }, e.status);
      }
      console.error(e);
      return json({ error: "internal_error" }, 500);
    }
  };
}

/** Journalise un événement analytique côté serveur. */
export async function track(
  admin: SupabaseClient,
  userId: string | null,
  name: string,
  props: Record<string, unknown> = {},
) {
  await admin.from("analytics_events").insert({ user_id: userId, name, props });
}
