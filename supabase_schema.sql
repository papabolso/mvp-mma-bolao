-- =====================================================
-- MVP MMA 1 — Bolão Friendly · Edição Netflix Especial
-- Schema Supabase (Postgres)
-- =====================================================
-- Como usar:
-- 1. Crie um projeto em supabase.com
-- 2. SQL Editor > New Query > Cole isso > Run
-- 3. Pegue URL e ANON KEY em Project Settings > API
-- 4. Coloque em .streamlit/secrets.toml (veja README)

-- ---------- TABELAS ----------

create table if not exists lutas (
  id            int primary key,
  lutador_1     text not null,
  lutador_2     text not null,
  tipo          text not null check (tipo in ('F1','F2','PRINCIPAL','PRELIM')),
  ordem         int default 0
);

create table if not exists palpites (
  id            bigserial primary key,
  nome          text not null,
  luta_id       int not null references lutas(id) on delete cascade,
  palpite       text not null,
  fotn_1        text default '',
  fotn_2        text default '',
  potn_1        text default '',
  potn_2        text default '',
  created_at    timestamptz default now(),
  unique (nome, luta_id)
);

create table if not exists resultados (
  luta_id       int primary key references lutas(id) on delete cascade,
  vencedor_real text default '',
  pontos        int default 1
);

-- Linha única de config global do evento (id=1 sempre)
create table if not exists config (
  id            int primary key default 1,
  fotn_1        text default '',
  fotn_2        text default '',
  potn_1        text default '', -- pode ter múltiplos separados por vírgula
  potn_2        text default '',
  f2_especial   boolean default false,
  bloqueado     boolean default false,
  abertura      text default '',     -- "DD/MM/AAAA HH:MM" BRT
  fechamento    text default '',
  check (id = 1)
);

insert into config (id) values (1) on conflict (id) do nothing;

-- ---------- CARD OFICIAL MVP MMA 1 (16/05/2026) ----------

insert into lutas (id, lutador_1, lutador_2, tipo, ordem) values
  (1, 'Ronda Rousey',       'Gina Carano',       'F1',       1),
  (2, 'Nate Diaz',           'Mike Perry',        'F2',       2),
  (3, 'Francis Ngannou',     'Philipe Lins',      'PRINCIPAL',3),
  (4, 'Junior dos Santos',   'Robelis Despaigne', 'PRINCIPAL',4),
  (5, 'Adriano Moraes',      'Phumi Nkuta',       'PRELIM',   5),
  (6, 'Salahdine Parnasse',  'Kenneth Cross',     'PRELIM',   6)
on conflict (id) do nothing;

-- ---------- RLS ----------
-- Para um bolão entre amigos com chave anon publicada no Streamlit,
-- mantemos RLS desabilitado (qualquer um com a chave pode ler/escrever).
-- Se quiser endurecer, ative RLS e crie policies específicas.

alter table lutas       disable row level security;
alter table palpites    disable row level security;
alter table resultados  disable row level security;
alter table config      disable row level security;
