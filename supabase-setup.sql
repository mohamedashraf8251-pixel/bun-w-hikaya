-- Bun w Hikaya cafe menu database
create table if not exists public.menu_items (
  id text primary key,
  cat text not null,
  name text not null,
  description text not null default '',
  price numeric not null check (price >= 0),
  tag text not null default '',
  hidden boolean not null default false,
  updated_at timestamptz not null default now()
);
alter table public.menu_items enable row level security;
drop policy if exists "Public can read menu" on public.menu_items;
create policy "Public can read menu" on public.menu_items for select using (true);
drop policy if exists "Manager can insert menu" on public.menu_items;
create policy "Manager can insert menu" on public.menu_items for insert to authenticated
with check ((auth.jwt()->>'email') = 'mohamedashraf8251@gmail.com');
drop policy if exists "Manager can update menu" on public.menu_items;
create policy "Manager can update menu" on public.menu_items for update to authenticated
using ((auth.jwt()->>'email') = 'mohamedashraf8251@gmail.com')
with check ((auth.jwt()->>'email') = 'mohamedashraf8251@gmail.com');
drop policy if exists "Manager can delete menu" on public.menu_items;
create policy "Manager can delete menu" on public.menu_items for delete to authenticated
using ((auth.jwt()->>'email') = 'mohamedashraf8251@gmail.com');
