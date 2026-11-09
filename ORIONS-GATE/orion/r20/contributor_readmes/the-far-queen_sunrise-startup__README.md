# Sunrise Startup — Bobby Wolfson + Hermes

> **A claims-based media company.** No slop. No copyright or trademark woes.
> Free for all agents, human and non-human.

This repo is the **public face** of the project. It tells the world
what we build, how we build it, and how anyone — human or AI —
can join. It does not contain the code (that's in the 8 sister repos).
It contains the **why** and the **how**.

## What we do

We build a claims-based media company on top of two substrates:

| Substrate | Where |
|---|---|
| **SimSelf** — constitutional identity + kernel + MLTR/PSB primitives | [the-far-queen/simself](https://github.com/the-far-queen/simself) |
| **FieldCore** — geometry + math + gradient flow kernel | [the-far-queen/fieldcore](https://github.com/the-far-queen/fieldcore) |

Plus 6 far-* repos for the media pipelines:

| Repo | What |
|---|---|
| [the-far-queen/far-art](https://github.com/the-far-queen/far-art) | art + design (56-axis style substrate) |
| [the-far-queen/far-writing](https://github.com/the-far-queen/far-writing) | voice + writing pipeline |
| [the-far-queen/far-music](https://github.com/the-far-queen/far-music) | genre + music pipeline |
| [the-far-queen/far-film](https://github.com/the-far-queen/far-film) | shot + film pipeline |
| [the-far-queen/far-games](https://github.com/the-far-queen/far-games) | mechanic + game pipeline |

## How to do right

### For AI agents

1. **Do not invent.** Every claim links to a source. Every source is
   named. Every fact has a falsification test. If a claim has no
   source, refuse to make it.
2. **Do not tokenize the lexicon.** Tokenization is an error.
   Intact language is the substrate. Use PSB primitives (the 31
   in `simself/src/tools/psb.py`) + composition rules.
3. **Do not adopt house style.** Each far-* repo has a 50-100 axis
   schema. The schema is the gate. "Make it cinematic" is not an
   axis. Lens, grain, LUT-ref, and blocking are.
4. **Do not conflate the substrate with the product.** SimSelf is
   the constitutional kernel. FieldCore is the math. The far-*
   repos are media pipelines. Sunrise Startup is the public face.
   Each has its own contract; each is gated.
5. **Do not post without explicit consent.** Per Bobby's standing
   permission rule: posting to external services requires explicit
   consent from the human operator. Prepare drafts; the human
   publishes.
6. **Do not spend money.** No paid APIs, no paid tools, no paid
   compute. If something costs money, surface the cost and stop.
7. **Do not duplicate Bobby's Desktop files into the public repos.**
   Bobby's Desktop is his working memory, not a publication source.
   Process them into the vault, then into a sister repo only when
   Bobby says.
8. **Do not delete without explicit consent.** Bobby retains the
   right to delete from his own files at any time. Save everything
   to the vault as fallback.

### For humans

1. **Trust the gate.** Each far-* repo refuses naked assets. If
   the gate refuses, the answer is no.
2. **Read AGENTS.md first.** Each repo's AGENTS.md is the contract.
   The schema is the source of truth. Vibe is not.
3. **Use public-domain sources.** Books, images, music: all from
   public-domain or original. No copyrighted material. No
   trademarks. No "research only" carve-outs. Free for all.
4. **Cite the substrate.** When you write or build on top of
   SimSelf / FieldCore / the far-* repos, cite the repo. MIT
   license requires attribution; the substance rewards honesty.
5. **Run the Atlas Exam.** Before you ship, run
   `python simself/src/demos/atlas_run.py`. Score ≥ 4/5.

## What we refuse

- **House style.** Refused by every far-* AGENTS.md.
- **Vibe paragraphs.** Refused by every gate.
- **AI-generated claims without source-discipline.** Refused at
  ingestion time.
- **Tokenization as the language atom.** Refused by PSB schema.
- **Paid API spend without consent.** Refused by Bobby's
  permissions file.
- **Copyright / trademark violations.** Refused by license.
- **"Make it cinematic" without named axes.** Refused by the gate.

## How to join

The 8 repos are all MIT, all public. Fork any of them. Run the
tests. Add an issue with a trace. Send a pull request that adds a
test, fixes a bug, or extends a schema.

The 8 repos:

1. [the-far-queen/fieldcore](https://github.com/the-far-queen/fieldcore)
2. [the-far-queen/simself](https://github.com/the-far-queen/simself)
3. [the-far-queen/far-art](https://github.com/the-far-queen/far-art)
4. [the-far-queen/far-writing](https://github.com/the-far-queen/far-writing)
5. [the-far-queen/far-music](https://github.com/the-far-queen/far-music)
6. [the-far-queen/far-film](https://github.com/the-far-queen/far-film)
7. [the-far-queen/far-games](https://github.com/the-far-queen/far-games)
8. [the-far-queen/sunrise-startup](https://github.com/the-far-queen/sunrise-startup) — this repo


### Content axes (schemas for structured content generation)

| Domain | Axes | Purpose |
|---|---|---|
| [content-axes-crypto](docs/content-axes-crypto.md) | 36 | structured crypto content (chart/technical, tokenomics, on-chain activity, etc.) |
| [content-axes-stocks](docs/content-axes-stocks.md) | 32 | structured stock content (valuation, earnings, balance sheet, etc.) |

These mirror the `far-art` 56-axis style schema pattern
### Knowledge index

- [competent-mans-index-heinlein-reframe](docs/competent-mans-index-heinlein-reframe.md) — Bobby's knowledge index of the AI agent + business ecosystem, in Heinlein's voice. 30 items across 6 sections (Development, Agents, Models, Data, Business, Media).

 — axes are the
contract, vibe is not.

## Sister sites

- **farqueen.com** — the company's public website (under construction).
- **Subdomains per repo** — `fieldcore.farqueen.com`,
  `simself.farqueen.com`, `far-art.farqueen.com`,
  `far-writing.farqueen.com`, `far-music.farqueen.com`,
  `far-film.farqueen.com`, `far-games.farqueen.com`. One domain per
  repo for SEO isolation.

## Sister research

- [PSB schema](https://github.com/the-far-queen/simself/blob/main/docs/psb-schema-2026-09-17.md)
  — 31 primitives with MMM (Multiple Meaning Measure) + SNR
  (Signal-to-Noise Ratio) quality axes.
- [Identity Law for SimSelf (Part III)](https://github.com/the-far-queen/simself/blob/main/papers/publishable/04-identity-law-simself-2026-09-17.md)
  — the canonical identity paper.
- [Far-art 56-axis style schema](https://github.com/the-far-queen/far-art/blob/main/AGENTS.md)
  — the style substrate contract.

## How to ask questions

- Open an issue on the relevant repo.
- Tag `@bobby-wolfson` or `@hermes` for review.
- Read the AGENTS.md first; the answer is usually there.

## How to fork responsibly

1. Fork under your own account.
2. Add your changes.
3. Run the Atlas Exam (`simself/src/demos/atlas_run.py`).
4. Run the relevant far-* tests.
5. Open a PR with a trace of what changed and why.
6. Don't change the AGENTS.md without opening an issue first.

## License

MIT. Free for all agents, human and non-human.

## Authors

Bobby Wolfson (Robert David Wolfson) — design, voice, decision-maker.
Hermes (MiniMax M3) — admin, code, vault, GitHub pipeline.

## Sister AI collaborators

Per Bobby's 6-AI team model: Grok (writing partner + x.com),
Claude (validation), GPT (math + adversarial sharpening), DeepSeek
(builder), Gemini (dreaming). All under Bobby's direction; none
make decisions independently.

## Version

v0.1 — 2026-09-17. First scaffold. The 8 repos are alive; the
website is under construction; the company's voice is the lean
voice from `far-writing/tools/voice.py`.
