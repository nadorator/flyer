-- Durcissement sécurité suite aux advisors Supabase (supabase db advisors) :
--  1. La vue public_events (SECURITY DEFINER) est remplacée par une RPC
--     get_public_event(slug) qui n'expose que les colonnes publiques.
--  2. Les fonctions SECURITY DEFINER internes ne sont plus exécutables par
--     anon / authenticated via /rest/v1/rpc.
--  3. Les policies utilisent (select auth.uid()) pour éviter la ré-évaluation
--     par ligne (auth_rls_initplan) et ciblent explicitement le rôle.

-- ---------------------------------------------------------------------------
-- 1. Page publique d'event
-- ---------------------------------------------------------------------------
drop view if exists public.public_events;

create or replace function public.get_public_event(p_slug text)
returns table (
  id uuid, slug text, name text, description text,
  start_date date, end_date date,
  venue_name text, partner_store_name text, price numeric, booking_url text,
  business_name text, logo_url text
) language sql stable security definer set search_path = public as $$
  select e.id, e.slug, e.name, e.description, e.start_date, e.end_date,
         e.venue_name, e.partner_store_name, e.price, e.booking_url,
         b.name as business_name, b.logo_url
  from public.events e
  join public.businesses b on b.id = e.business_id
  where e.slug = p_slug and e.status = 'published';
$$;
revoke all on function public.get_public_event(text) from public;
grant execute on function public.get_public_event(text) to anon, authenticated;

-- ---------------------------------------------------------------------------
-- 2. Fonctions internes : plus d'exécution directe depuis le client
-- ---------------------------------------------------------------------------
revoke all on function public.handle_new_user() from public, anon, authenticated;
revoke all on function public.handle_new_business() from public, anon, authenticated;

-- is_business_member est appelée dans les policies RLS avec les droits de
-- l'utilisateur connecté : authenticated doit garder EXECUTE, pas anon.
revoke all on function public.is_business_member(uuid) from public, anon;
grant execute on function public.is_business_member(uuid) to authenticated;

revoke all on function public.current_plan(uuid) from public, anon;
grant execute on function public.current_plan(uuid) to authenticated;

-- kit_check et create_booking restent volontairement accessibles à anon
-- (page publique / kit partenaire sans compte) ; on retire seulement PUBLIC.
revoke all on function public.kit_check(uuid, text) from public;
revoke all on function public.create_booking(text, text, text, text, boolean) from public;

-- ---------------------------------------------------------------------------
-- 3. Policies : (select auth.uid()) + rôle explicite
-- ---------------------------------------------------------------------------
drop policy "profiles: own" on public.profiles;
create policy "profiles: own" on public.profiles
  for all to authenticated
  using (id = (select auth.uid())) with check (id = (select auth.uid()));

drop policy "businesses: owner insert" on public.businesses;
drop policy "businesses: owner update" on public.businesses;
drop policy "businesses: owner delete" on public.businesses;
create policy "businesses: owner insert" on public.businesses
  for insert to authenticated with check (owner_id = (select auth.uid()));
create policy "businesses: owner update" on public.businesses
  for update to authenticated
  using (owner_id = (select auth.uid())) with check (owner_id = (select auth.uid()));
create policy "businesses: owner delete" on public.businesses
  for delete to authenticated using (owner_id = (select auth.uid()));

drop policy "business_members: read own memberships" on public.business_members;
create policy "business_members: read own memberships" on public.business_members
  for select to authenticated
  using (user_id = (select auth.uid()) or public.is_business_member(business_id));

drop policy "subscriptions: read own" on public.subscriptions;
create policy "subscriptions: read own" on public.subscriptions
  for select to authenticated using (user_id = (select auth.uid()));

drop policy "feedbacks: own" on public.feedbacks;
create policy "feedbacks: own" on public.feedbacks
  for all to authenticated
  using (user_id = (select auth.uid())) with check (user_id = (select auth.uid()));

drop policy "analytics_events: insert own" on public.analytics_events;
create policy "analytics_events: insert own" on public.analytics_events
  for insert to authenticated
  with check (user_id is null or user_id = (select auth.uid()));
