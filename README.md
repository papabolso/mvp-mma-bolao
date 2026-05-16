# MVP MMA 1 · Bolão Friendly · Edição Netflix 🥊

Bolão Streamlit + Supabase para o evento **Rousey vs Carano** (MVP MMA 1) na Netflix.

## Stack
- Streamlit (frontend)
- Supabase (Postgres backend)
- Tema visual Netflix (preto/vermelho, fontes Bebas Neue + Oswald)

## Card pré-populado (16/05/2026 · Intuit Dome)
1. **MAIN:** Ronda Rousey vs Gina Carano
2. **CO-MAIN:** Nate Diaz vs Mike Perry
3. Francis Ngannou vs Philipe Lins
4. Junior dos Santos vs Robelis Despaigne
5. Adriano Moraes vs Phumi Nkuta
6. Salahdine Parnasse vs Kenneth Cross

## Setup

### 1. Supabase
- Crie projeto em [supabase.com](https://supabase.com)
- SQL Editor → cole `supabase_schema.sql` → Run
- Settings → API: copie `URL` e `anon public key`

### 2. Secrets do Streamlit
Crie `.streamlit/secrets.toml`:

```toml
[supabase]
url = "https://SEU-PROJETO.supabase.co"
key = "SUA-ANON-KEY"

[admin]
password = "mvpmma2026"
```

### 3. Local
```bash
pip install -r requirements.txt
streamlit run app.py
```

### 4. Deploy Streamlit Cloud
- Push pro GitHub
- share.streamlit.io → New app
- Cole o conteúdo de `secrets.toml` em Settings → Secrets

## Regras de Pontuação
| Item | Pts |
|---|---|
| Acerto F1 (Main) | 2 |
| Acerto F2 (Co-Main) | 1 (ou 2 com flag) |
| Demais acertos | 1 |
| FOTN par exato | +2 |
| POTN acerto | +1 por nome |

**Desempate:** Pts → Acertos → Luta 1 → Luta 2 → ... → Nome
