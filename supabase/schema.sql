-- Chess Arena Online: initial prototype schema
-- Run this entire file in Supabase Dashboard -> SQL Editor.
create table if not exists public.chess_rooms (
  id text primary key check (length(id) between 6 and 32),
  fen text not null,
  moves jsonb not null default '[]'::jsonb,
  status text not null default 'waiting' check (status in ('waiting','playing','finished')),
  white_connected boolean not null default false,
  black_connected boolean not null default false,
  updated_at timestamptz not null default now(),
  created_at timestamptz not null default now()
);

alter table public.chess_rooms enable row level security;

-- Prototype policy only: anyone with the public client key can read/change rooms.
-- Do not use this policy for a production game with valuable/private data.
drop policy if exists "prototype rooms readable by clients" on public.chess_rooms;
create policy "prototype rooms readable by clients"
  on public.chess_rooms for select to anon, authenticated using (true);

drop policy if exists "prototype rooms creatable by clients" on public.chess_rooms;
create policy "prototype rooms creatable by clients"
  on public.chess_rooms for insert to anon, authenticated with check (true);

drop policy if exists "prototype rooms updatable by clients" on public.chess_rooms;
create policy "prototype rooms updatable by clients"
  on public.chess_rooms for update to anon, authenticated using (true) with check (true);

-- Enable Realtime events for room updates. Ignore duplicate membership errors.
do $$
begin
  alter publication supabase_realtime add table public.chess_rooms;
exception
  when duplicate_object then null;
  when undefined_object then
    raise notice 'Publication supabase_realtime was not found. Enable Realtime for chess_rooms in the Supabase Dashboard.';
end $$;
