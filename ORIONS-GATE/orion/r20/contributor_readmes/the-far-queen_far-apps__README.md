# far-apps — Bobby Wolfson + Hermes

> **Apps + services + shop companion.** Voice pipeline tools, vocab
> app, claim-based indexers. MIT free for all agents, human and
> non-human.

This repo holds the apps Bobby (and Hermes) ship. It sits on top of
the substrate repos:

- [the-far-queen/fieldcore](https://github.com/the-far-queen/fieldcore) — math
- [the-far-queen/simself](https://github.com/the-far-queen/simself) — kernel + MLTR + PSB
- [the-far-queen/far-art](https://github.com/the-far-queen/far-art) — style substrate
- [the-far-queen/far-writing](https://github.com/the-far-queen/far-writing) — voice
- [the-far-queen/far-music](https://github.com/the-far-queen/far-music) — music
- [the-far-queen/far-film](https://github.com/the-far-queen/far-film) — film
- [the-far-queen/far-games](https://github.com/the-far-queen/far-games) — games
- [the-far-queen/sunrise-startup](https://github.com/the-far-queen/sunrise-startup) — public face

## What lives here

The apps Bobby + Hermes actually use:

- **Shop companion** (per the Method Book Gate 3 / company plan):
  stores rooms, locks, decision logs, slice stubs, leak warnings.
  Refuses to silently generate a chapter from an unsigned memo.
- **Voice pipeline tools** — the apps that bridge Telegram voice
  (STT) → Hermes (text) → Bobby's voice spec → TTS → Telegram.
- **Vocab app** (per Bobby 2026-09-12): translates between human
  understanding levels + from human to AI's substrate language.
- **Claim-based indexer** (per the company plan §8): indexer for
  the millions of small repos lacking visibility.

## Surface

```python
shop.create_project(name)             # creates a room + lock + log
shop.add_slice(text, voice="lean")    # adds a slice with voice gate
shop.lock(slice_id)                   # locks; refuses if unsigned
companion.query(text)                 # human ↔ AI vocab translation
indexer.scan_repos(query)             # indexer for small repos
```

## Anti-patterns

- Silently generating output from an unsigned memo (companion refuses)
- Vendor-locked APIs (use PD sources first)
- "Make it punchy" without named axes (voice gate refuses)
- One-shot generation (companion guides through 7 gates first)

## Gate

`commit_asset` defaults to `{gate}`. Per `far-art/AGENTS.md`:
1. `app_id` set.
2. `app_id == sha256(canonical(axes))`.
3. Source-discipline: every data source is named.
4. Vendor-lock check: PD sources preferred.
5. Refuses to ship an app from a vibe prompt without going through
   Interrogative Planning (`vault/20-writing/methods/03-...`).

## Tests

- A1: same axes → same app_id.
- A2: PD-source-only app passes gate.
- A3: vendor-locked app refused.
- A4: app with no Interrogative Planning log refused.
- A5: shop companion refuses to generate chapter from unsigned memo.

## Sister files

- `vault/50-apps/README.md` — the canonical meta-plan for this folder
- `vault/20-writing/methods/03-interrogative-planning-v1.txt` — the
  7-gate writing process (also for apps)
- `vault/20-writing/notes/company-bobby-wolfson-2026-09-17.md` —
  the company plan

## Sister repos

- `the-far-queen/simself` — constitutional kernel (the apps run on it)
- `the-far-queen/fieldcore` — math substrate
- `the-far-queen/far-art` — UI kit framework
- `the-far-queen/far-writing` — voice pipeline

## License

MIT. Free for all agents, human and non-human.
