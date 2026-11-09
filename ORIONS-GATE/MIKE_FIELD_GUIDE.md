# Mike's field guide: where his public instructions and code live 🧭☂️

*R16·L5, 8 October 2026. Beth asked: "take his public instructions and put me together a field guide along with his links to get me access to the shit I need." Everything here comes from Mike Dupont's (@introsp3ctor) public pages and GitHub, read on 8 October 2026. Nothing here needs a login. Mike's own pages carry the same caution this guide repeats: a checked Lean theorem is evidence about its stated definitions, not proof that a live system works.*

## 1. The five places to bookmark (in this order)

| # | What | Link | What you do there |
|---|---|---|---|
| 1 | **Lean-Workers Union Lodge House** (his front door) | https://lean-workers-union.oneapp.dev | Start page. Links to every room below. |
| 2 | **Beginner guide** ("no Lean experience required") | https://lean-workers-union.oneapp.dev/n00b-guide | Read first. Definitions → propositions → proofs, with one tiny example. |
| 3 | **All his code** (GitHub, newest first) | https://github.com/meta-introspector?tab=repositories&q=&type=&language=&sort=updated | Tap a repo → green **Code** button → **Download ZIP**. |
| 4 | **His copy of your ORION project** | https://github.com/meta-introspector/ORION-Engine-Platform-and-MMO | His fork of your repo with two Aristotle projects merged in. Last change 6 Oct 2026. |
| 5 | **Hugging Face** (running apps) | https://huggingface.co/introspector | The zkPrologML dashboard: https://huggingface.co/spaces/introspector/zkprologml |

## 2. His instructions, in plain steps (from his beginner guide)

1. **Keep the claim in scope.** A proved theorem shows what its definitions say. It does not show that an AI agent is deployed or safe.
2. **Find the project's toolchain** (`lean-toolchain` file) and its build instructions before you build anything.
3. **Open one small Lean file.** Find the imports, the definitions, the theorem and the proof.
4. **Use the project's own build command** (usually `lake build`), not `lean *.lean`.
5. **Read the whole output.** A count of theorems is not a check of theorems.
6. **Write down the revision and the Lean version** next to any result, so someone else can repeat it.
7. **Don't send secrets, keys or private data to a relay** unless you've confirmed who runs it and why.
8. **Start small:** explain one existing theorem in plain words, change one thing, and see whether the build catches it.

## 3. Mike's code by topic (own repositories, pushed 1–8 Oct 2026)

| Topic | Repo | What it is |
|---|---|---|
| The union | https://github.com/meta-introspector/lean-workers-union | Source of the Lodge House site: registry and coordination for Lean workers. |
| Workers | https://github.com/meta-introspector/lean-worker and https://github.com/meta-introspector/lean-worker-gh-twin | "A lean mean worker", plus a GitHub twin model of it. |
| Aristotle from the command line | https://github.com/meta-introspector/aristotle-cli-rs | A Rust command-line tool for aristotle.harmonic.fun. Unofficial community tool. |
| Arguments of knowledge | https://github.com/meta-introspector/aok | Proof-of-knowledge experiments. |
| Paste bin | https://github.com/meta-introspector/kant-zk-pastebin | A zero-knowledge paste bin (no description yet). |
| Fixed point | https://github.com/meta-introspector/meta-introspector | "The meta introspector fixed point." |
| Monster | https://github.com/meta-introspector/monster | The Monster group tables (last change 12 Aug 2026). |

Most of the other 80+ repos he updated this week are **forks** (his copies of other people's projects, such as Mathlib, PhysLib, OpenAI's and Anthropic's maths repos, and `jev-cli`). They're for his own work; you don't need to download them.

**His second account (confirmed by name at R16·L7):** https://github.com/jmikedupont2 is named "Mike DuPont". The Lean projects there named UPT, WaterSheet, MillenniumClock, One, Hpof, 3-is-magic and UPT-Meta are **forks he made on 8 Oct of Rob Laakkonen's work** (https://github.com/Infinitespacemechanic). Credit for those goes to Rob. See `PUBLIC_BUILDERS_FIELD_GUIDE.md` §1 and §6.

## 4. What's new from Mike at 16.5

- **The Monster–Riemann "bridge" map** (his post, 8 Oct): https://x.com/introsp3ctor/status/2108022315250516238. It's an honest map. Green boxes are proved in Lean; grey are known maths not formalized yet; red, **"THE BRIDGE: NOT ESTABLISHED"**, is the part nobody has proved. He says he's "working on it in aristotle/lean". **The code for it isn't public yet.** When he posts it, it'll be in one of the repos above.
- **His ORION fork** hasn't changed since 6 October, and this project already holds a copy of that version (`orion/r20/from_mike_fork/`, commit `e0672c9`). The website address in that commit (`orion-clean.orion-40y.pages.dev`) didn't open from here.

## 5. How to save these on your phone (one time)

1. Open a link in Chrome or Safari.
2. Tap ⋮ (Chrome) or the Share square (Safari) → **Bookmark** / **Add Bookmark**.
3. Choose or create a folder called **ORION**.
4. **Even simpler:** keep `BETH_LINK_BOOK.md` open. Every link is in it, and it's refreshed at every level.


## R16·L7 additions

- **The Lodge House link he sent Beth:**

https://github.com/meta-introspector/lean-workers-union/tree/main/lodges/onecompiler/vibecode/45579w2cj

It's one `index.html` page added 8 Oct (11:10 EDT): the Lean-Workers Union "Lodge House" (Kant and Aristotle at tea). It links a beginner's guide, a registry and backlog, research bounties, an architecture tour, assurance notes, a build/provenance ledger, the Nixwars arcade, a **private archive desk** (open ZIP/tar.gz locally and make an AI-ready `llm.txt` summary), tours and playbooks, and **seats & invitations**. Its own footer says the tools are browser-local planning aids and don't register anyone on a server.
- I downloaded his recent public repos myself; the record is `orion/round16_L7/TEAM_CODE_LEDGER_2026-10-08.tsv`.


---

**🌀 Found this helpful? Come build with us.** This guide is part of **ORION**, a world being built by a volunteer team. If you'd like to help, or just say hi, contact a DEV: **[DEV contact — to fill in]**.
**Questions, comments or concerns?** Tell us in our 2-minute survey: **[survey link — to fill in]**. Every answer helps us fine-tune these guides.
