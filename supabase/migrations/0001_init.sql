-- Flyer — schéma initial (Sprint 0)
-- Voir docs/07-architecture.md. Toutes les tables ont la RLS activée :
-- un utilisateur ne voit que les données de son entreprise.

create extension if not exists "pgcrypto";

-- ---------------------------------------------------------------------------
-- Types
-- ---------------------------------------------------------------------------
create type public.event_status as enum ('draft', 'published', 'completed', 'cancelled');
create type public.need_type as enum ('photo', 'video', 'audio', 'text');
create type public.need_status as enum ('missing', 'provided', 'generated');
create type public.publication_status as enum ('scheduled', 'publishing', 'published', 'failed');
create type public.plan as enum ('free', 'pro', 'studio', 'partner');
create type public.subscription_source as enum ('revenuecat', 'partner_code', 'trial', 'manual');
create type public.crm_provider as enum ('salesforce', 'odoo');

-- ---------------------------------------------------------------------------
-- Profils & entreprises
-- ---------------------------------------------------------------------------
create table public.profiles (
  id uuid primary key references auth.users (id) on delete cascade,
  display_name text,
  locale text not null default 'fr',
  created_at timestamptz not null default now()
);

create table public.businesses (
  id uuid primary key default gen_random_uuid(),
  owner_id uuid not null references public.profiles (id) on delete cascade,
  name text not null,
  siret text,
  logo_url text,
  address text,
  phone text,
  email text,
  website text,
  socials jsonb not null default '{}'::jsonb,
  colors jsonb not null default '[]'::jsonb,
  created_at timestamptz not null default now(),
  updated_at timestamptz not null default now()
);
create index businesses_owner_idx on public.businesses (owner_id);

-- Membres d'une entreprise (multi-utilisateurs Studio, S7). Le propriétaire
-- est inséré automatiquement par trigger.
create table public.business_members (
  business_id uuid not null references public.businesses (id) on delete cascade,
  user_id uuid not null references public.profiles (id) on delete cascade,
  role text not null default 'owner' check (role in ('owner', 'editor')),
  primary key (business_id, user_id)
);

create or replace function public.is_business_member(p_business_id uuid)
returns boolean language sql stable security definer set search_path = public as $$
  select exists (
    select 1 from public.business_members
    where business_id = p_business_id and user_id = auth.uid()
  );
$$;

create or replace function public.handle_new_business()
returns trigger language plpgsql security definer set search_path = public as $$
begin
  insert into public.business_members (business_id, user_id, role)
  values (new.id, new.owner_id, 'owner');
  return new;
end;
$$;
create trigger on_business_created
  after insert on public.businesses
  for each row execute function public.handle_new_business();

create or replace function public.handle_new_user()
returns trigger language plpgsql security definer set search_path = public as $$
begin
  insert into public.profiles (id, display_name)
  values (new.id, coalesce(new.raw_user_meta_data ->> 'display_name', split_part(new.email, '@', 1)));
  return new;
end;
$$;
create trigger on_auth_user_created
  after insert on auth.users
  for each row execute function public.handle_new_user();

-- ---------------------------------------------------------------------------
-- Events
-- ---------------------------------------------------------------------------
create table public.events (
  id uuid primary key default gen_random_uuid(),
  business_id uuid not null references public.businesses (id) on delete cascade,
  name text not null,
  description text not null default '',
  start_date date not null,
  end_date date not null,
  venue_name text,
  partner_store_name text,
  price numeric(10, 2),
  booking_url text,
  slug text unique,
  status public.event_status not null default 'draft',
  created_at timestamptz not null default now(),
  updated_at timestamptz not null default now(),
  constraint events_dates_check check (end_date >= start_date)
);
create index events_business_idx on public.events (business_id, start_date);

create table public.event_schedules (
  id uuid primary key default gen_random_uuid(),
  event_id uuid not null references public.events (id) on delete cascade,
  day date not null,
  start_time time not null,
  end_time time not null,
  constraint event_schedules_time_check check (end_time > start_time),
  unique (event_id, day)
);

-- ---------------------------------------------------------------------------
-- Plateformes & besoins
-- ---------------------------------------------------------------------------
create table public.platforms (
  code text primary key,
  label text not null,
  required_needs public.need_type[] not null default '{}',
  supports_api boolean not null default false
);

insert into public.platforms (code, label, required_needs, supports_api) values
  ('instagram',       'Instagram',        '{photo,text}',        true),
  ('facebook',        'Facebook',         '{photo,text}',        true),
  ('tiktok',          'TikTok',           '{video,audio,text}',  true),
  ('linkedin',        'LinkedIn',         '{photo,text}',        true),
  ('google_business', 'Google Business',  '{photo,text}',        true),
  ('local_groups',    'Groupes locaux',   '{photo,text}',        false),
  ('store_page',      'Page du magasin',  '{photo,text}',        false),
  ('print_a4',        'Affiche A4',       '{photo,text}',        false);

create table public.event_platform_needs (
  id uuid primary key default gen_random_uuid(),
  event_id uuid not null references public.events (id) on delete cascade,
  platform_code text not null references public.platforms (code),
  need_type public.need_type not null,
  status public.need_status not null default 'missing',
  asset_url text,
  updated_at timestamptz not null default now(),
  unique (event_id, platform_code, need_type)
);

-- Propositions IA (texte / visuel) par event et plateforme.
create table public.generated_contents (
  id uuid primary key default gen_random_uuid(),
  event_id uuid not null references public.events (id) on delete cascade,
  platform_code text references public.platforms (code),
  kind text not null check (kind in ('text', 'image_square', 'image_story', 'image_a4')),
  content text,
  asset_url text,
  selected boolean not null default false,
  model text,
  cost_cents integer,
  created_at timestamptz not null default now()
);
create index generated_contents_event_idx on public.generated_contents (event_id);

-- ---------------------------------------------------------------------------
-- Publication
-- ---------------------------------------------------------------------------
create table public.social_connections (
  id uuid primary key default gen_random_uuid(),
  business_id uuid not null references public.businesses (id) on delete cascade,
  platform_code text not null references public.platforms (code),
  external_account_id text,
  external_account_name text,
  -- Tokens chiffrés via Vault ; jamais lus par le client (voir RLS ci-dessous).
  access_token_secret_id uuid,
  refresh_token_secret_id uuid,
  expires_at timestamptz,
  created_at timestamptz not null default now(),
  unique (business_id, platform_code, external_account_id)
);

create table public.publications (
  id uuid primary key default gen_random_uuid(),
  event_id uuid not null references public.events (id) on delete cascade,
  platform_code text not null references public.platforms (code),
  connection_id uuid references public.social_connections (id) on delete set null,
  content_id uuid references public.generated_contents (id) on delete set null,
  scheduled_at timestamptz,
  published_at timestamptz,
  status public.publication_status not null default 'scheduled',
  external_id text,
  error text,
  created_at timestamptz not null default now()
);
create index publications_due_idx on public.publications (status, scheduled_at);

-- ---------------------------------------------------------------------------
-- Kit partenaire & réservations
-- ---------------------------------------------------------------------------
create table public.partner_kits (
  id uuid primary key default gen_random_uuid(),
  event_id uuid not null references public.events (id) on delete cascade,
  token uuid not null unique default gen_random_uuid(),
  poster_url text,
  post_text text,
  post_image_url text,
  opened_at timestamptz,
  checked_poster boolean not null default false,
  checked_post boolean not null default false,
  checked_team boolean not null default false,
  created_at timestamptz not null default now()
);

-- ---------------------------------------------------------------------------
-- CRM
-- ---------------------------------------------------------------------------
create table public.customers (
  id uuid primary key default gen_random_uuid(),
  business_id uuid not null references public.businesses (id) on delete cascade,
  full_name text not null,
  email text,
  phone text,
  tags text[] not null default '{}',
  consent_marketing boolean not null default false,
  consent_at timestamptz,
  external_id text,
  created_at timestamptz not null default now(),
  updated_at timestamptz not null default now()
);
create index customers_business_idx on public.customers (business_id);
create unique index customers_business_email_idx on public.customers (business_id, lower(email)) where email is not null;

create table public.pets (
  id uuid primary key default gen_random_uuid(),
  customer_id uuid not null references public.customers (id) on delete cascade,
  name text not null,
  species text
);

create table public.bookings (
  id uuid primary key default gen_random_uuid(),
  event_id uuid not null references public.events (id) on delete cascade,
  customer_id uuid references public.customers (id) on delete set null,
  slot_at timestamptz,
  source text not null default 'public_page',
  created_at timestamptz not null default now()
);

create table public.crm_connections (
  id uuid primary key default gen_random_uuid(),
  business_id uuid not null references public.businesses (id) on delete cascade,
  provider public.crm_provider not null,
  instance_url text,
  secret_id uuid, -- référence Vault, jamais exposée au client
  last_sync_at timestamptz,
  created_at timestamptz not null default now(),
  unique (business_id, provider)
);

-- ---------------------------------------------------------------------------
-- Monétisation
-- ---------------------------------------------------------------------------
create table public.partner_codes (
  id uuid primary key default gen_random_uuid(),
  code text not null unique,
  plan_granted public.plan not null default 'partner',
  valid_from timestamptz not null default now(),
  valid_until timestamptz,
  duration_days integer not null default 365,
  max_redemptions integer not null default 1,
  redemptions_count integer not null default 0,
  owner_user_id uuid references public.profiles (id) on delete set null,
  requires_feedback boolean not null default true,
  notes text,
  created_at timestamptz not null default now()
);

create table public.subscriptions (
  id uuid primary key default gen_random_uuid(),
  user_id uuid not null references public.profiles (id) on delete cascade,
  plan public.plan not null,
  source public.subscription_source not null,
  current_period_end timestamptz,
  revenuecat_id text,
  partner_code_id uuid references public.partner_codes (id) on delete set null,
  created_at timestamptz not null default now()
);
create index subscriptions_user_idx on public.subscriptions (user_id, current_period_end desc);

-- Plan effectif d'un utilisateur : dernier abonnement actif, sinon 'free'.
create or replace function public.current_plan(p_user_id uuid default auth.uid())
returns public.plan language sql stable security definer set search_path = public as $$
  select coalesce(
    (select plan from public.subscriptions
     where user_id = p_user_id
       and (current_period_end is null or current_period_end > now())
     order by current_period_end desc nulls first
     limit 1),
    'free'::public.plan
  );
$$;

create table public.feedbacks (
  id uuid primary key default gen_random_uuid(),
  user_id uuid not null references public.profiles (id) on delete cascade,
  score smallint check (score between 1 and 5),
  message text,
  screen text,
  created_at timestamptz not null default now()
);

-- ---------------------------------------------------------------------------
-- Analytics (événements Lean UX)
-- ---------------------------------------------------------------------------
create table public.analytics_events (
  id bigint generated always as identity primary key,
  user_id uuid references public.profiles (id) on delete set null,
  name text not null,
  props jsonb not null default '{}'::jsonb,
  created_at timestamptz not null default now()
);
create index analytics_events_name_idx on public.analytics_events (name, created_at);

-- ---------------------------------------------------------------------------
-- Vue publique (page d'event, lecture anonyme par slug)
-- ---------------------------------------------------------------------------
create view public.public_events with (security_invoker = false) as
  select e.id, e.slug, e.name, e.description, e.start_date, e.end_date,
         e.venue_name, e.partner_store_name, e.price, e.booking_url,
         b.name as business_name, b.logo_url
  from public.events e
  join public.businesses b on b.id = e.business_id
  where e.status = 'published' and e.slug is not null;

-- ---------------------------------------------------------------------------
-- RLS
-- ---------------------------------------------------------------------------
alter table public.profiles enable row level security;
alter table public.businesses enable row level security;
alter table public.business_members enable row level security;
alter table public.events enable row level security;
alter table public.event_schedules enable row level security;
alter table public.platforms enable row level security;
alter table public.event_platform_needs enable row level security;
alter table public.generated_contents enable row level security;
alter table public.social_connections enable row level security;
alter table public.publications enable row level security;
alter table public.partner_kits enable row level security;
alter table public.customers enable row level security;
alter table public.pets enable row level security;
alter table public.bookings enable row level security;
alter table public.crm_connections enable row level security;
alter table public.partner_codes enable row level security;
alter table public.subscriptions enable row level security;
alter table public.feedbacks enable row level security;
alter table public.analytics_events enable row level security;

-- Profils : chacun le sien.
create policy "profiles: own" on public.profiles
  for all using (id = auth.uid()) with check (id = auth.uid());

-- Entreprises : membres en lecture, propriétaire en écriture, création libre.
create policy "businesses: members read" on public.businesses
  for select using (public.is_business_member(id));
create policy "businesses: owner insert" on public.businesses
  for insert with check (owner_id = auth.uid());
create policy "businesses: owner update" on public.businesses
  for update using (owner_id = auth.uid());
create policy "businesses: owner delete" on public.businesses
  for delete using (owner_id = auth.uid());

create policy "business_members: read own memberships" on public.business_members
  for select using (user_id = auth.uid() or public.is_business_member(business_id));

-- Tables rattachées à business_id : accès complet aux membres.
create policy "events: members" on public.events
  for all using (public.is_business_member(business_id))
  with check (public.is_business_member(business_id));
create policy "customers: members" on public.customers
  for all using (public.is_business_member(business_id))
  with check (public.is_business_member(business_id));
create policy "crm_connections: members" on public.crm_connections
  for all using (public.is_business_member(business_id))
  with check (public.is_business_member(business_id));
-- Les tokens ne sont jamais lus par le client : seules les colonnes
-- non sensibles sont exposées (les secret_id pointent vers Vault).
create policy "social_connections: members" on public.social_connections
  for all using (public.is_business_member(business_id))
  with check (public.is_business_member(business_id));

-- Tables rattachées à event_id.
create policy "event_schedules: members" on public.event_schedules
  for all using (exists (select 1 from public.events e where e.id = event_id and public.is_business_member(e.business_id)))
  with check (exists (select 1 from public.events e where e.id = event_id and public.is_business_member(e.business_id)));
create policy "event_platform_needs: members" on public.event_platform_needs
  for all using (exists (select 1 from public.events e where e.id = event_id and public.is_business_member(e.business_id)))
  with check (exists (select 1 from public.events e where e.id = event_id and public.is_business_member(e.business_id)));
create policy "generated_contents: members" on public.generated_contents
  for all using (exists (select 1 from public.events e where e.id = event_id and public.is_business_member(e.business_id)))
  with check (exists (select 1 from public.events e where e.id = event_id and public.is_business_member(e.business_id)));
create policy "publications: members" on public.publications
  for all using (exists (select 1 from public.events e where e.id = event_id and public.is_business_member(e.business_id)))
  with check (exists (select 1 from public.events e where e.id = event_id and public.is_business_member(e.business_id)));
create policy "partner_kits: members" on public.partner_kits
  for all using (exists (select 1 from public.events e where e.id = event_id and public.is_business_member(e.business_id)))
  with check (exists (select 1 from public.events e where e.id = event_id and public.is_business_member(e.business_id)));
create policy "bookings: members" on public.bookings
  for all using (exists (select 1 from public.events e where e.id = event_id and public.is_business_member(e.business_id)))
  with check (exists (select 1 from public.events e where e.id = event_id and public.is_business_member(e.business_id)));

-- Animaux : via le client.
create policy "pets: members" on public.pets
  for all using (exists (select 1 from public.customers c where c.id = customer_id and public.is_business_member(c.business_id)))
  with check (exists (select 1 from public.customers c where c.id = customer_id and public.is_business_member(c.business_id)));

-- Référentiel plateformes : lecture pour tous les utilisateurs connectés.
create policy "platforms: read" on public.platforms
  for select to authenticated using (true);

-- Abonnements et feedbacks : lecture / écriture limitée à soi ; les
-- abonnements sont écrits par les Edge Functions (service role).
create policy "subscriptions: read own" on public.subscriptions
  for select using (user_id = auth.uid());
create policy "feedbacks: own" on public.feedbacks
  for all using (user_id = auth.uid()) with check (user_id = auth.uid());

-- Codes partenaires : jamais énumérables depuis le client (aucune policy
-- select) ; validés uniquement par l'Edge Function redeem-partner-code.

-- Analytics : insertion par l'utilisateur, lecture réservée au service role.
create policy "analytics_events: insert own" on public.analytics_events
  for insert to authenticated with check (user_id is null or user_id = auth.uid());

-- Accès anonyme à la vue publique et au kit partenaire par token.
grant select on public.public_events to anon, authenticated;

-- ---------------------------------------------------------------------------
-- RPC publiques (page d'event & kit partenaire, sans compte)
-- ---------------------------------------------------------------------------

-- Marque un kit comme ouvert / coche une case de la checklist (FL-502).
create or replace function public.kit_check(p_token uuid, p_item text default null)
returns void language plpgsql security definer set search_path = public as $$
begin
  update public.partner_kits
  set opened_at = coalesce(opened_at, now()),
      checked_poster = checked_poster or p_item = 'poster',
      checked_post = checked_post or p_item = 'post',
      checked_team = checked_team or p_item = 'team'
  where token = p_token;
end;
$$;
grant execute on function public.kit_check(uuid, text) to anon, authenticated;

-- Réservation depuis la page publique (FL-504) : crée le client (consentement
-- explicite) et la réservation. Retourne l'id de réservation.
create or replace function public.create_booking(
  p_slug text, p_full_name text, p_phone text, p_pet_name text default null,
  p_consent boolean default false
) returns uuid language plpgsql security definer set search_path = public as $$
declare
  v_event public.events%rowtype;
  v_customer_id uuid;
  v_booking_id uuid;
begin
  select * into v_event from public.events where slug = p_slug and status = 'published';
  if not found then
    raise exception 'event introuvable' using errcode = 'P0002';
  end if;

  insert into public.customers (business_id, full_name, phone, consent_marketing, consent_at, tags)
  values (v_event.business_id, p_full_name, p_phone, p_consent,
          case when p_consent then now() end, array['event-' || v_event.id::text])
  returning id into v_customer_id;

  if p_pet_name is not null and length(trim(p_pet_name)) > 0 then
    insert into public.pets (customer_id, name) values (v_customer_id, p_pet_name);
  end if;

  insert into public.bookings (event_id, customer_id) values (v_event.id, v_customer_id)
  returning id into v_booking_id;

  insert into public.analytics_events (name, props)
  values ('booking_clicked', jsonb_build_object('event_id', v_event.id, 'source', 'public_page'));

  return v_booking_id;
end;
$$;
grant execute on function public.create_booking(text, text, text, text, boolean) to anon, authenticated;
