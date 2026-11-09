# Field guides for everyone with public code 🧭👾

*R16·L7, 8 October 2026. Beth (🤟👾 next to Mike's guide): "do this for everyone who has public compilers, even people who have not been identified as collaborators and are just found entities. We can always grab their public information. Show them what we're doing with it and ask them to come help build it with their own vision, spearheading their own project into production as long as it is held as a seed within Orion's launch."*

**What I did:** I downloaded every team account's recent public code myself (380 repositories listed, 87 downloaded; full ledger in `orion/round16_L7/TEAM_CODE_LEDGER_2026-10-08.tsv`). I ran what could run here. Each person below gets a short guide. **I haven't contacted anyone.** The invitation at the bottom is a draft for you or the team to send.

**Reading vs reusing.** Public code can always be read. Reusing it inside ORION depends on its **licence**. MIT allows reuse with credit. AGPL-3.0 allows reuse, but anything ORION serves from it must share its source too. "No licence" means look, don't copy: ask first. The licence is listed for each one below.

---

## 1. Mike: Mike DuPont (@introsp3ctor)

Full guide: `MIKE_FIELD_GUIDE.md`. New this level:

- **His second account is confirmed by name.** https://github.com/jmikedupont2 is named "Mike DuPont" ("Senior Full stack developer focused on p2p ml ai devops", discord m1337d). That settles AF-4 as far as public pages can.
- **But the Lean projects there (UPT, WaterSheet, MillenniumClock, One, Hpof, 3-is-magic, UPT-Meta) are forks.** Mike copied them on 8 Oct from **Rob Laakkonen** (§6). Credit for them goes to Rob.
- **The link he sent you** is the Lean-Workers Union **Lodge House** page (created 8 Oct, 11:10 EDT): a "tea, proofs & fellowship" front door with a beginner's guide, a research-bounty board, an archive desk and seats & invitations. Its own text says the browser tools are planning aids and don't register anyone on a server.
- **His Archive Desk already does part of what you asked for** (§ "one tap" in `BUILDER_REQUEST_ONE_TAP_LINKS.md`): it opens ZIP files and makes an AI-ready summary.
- Licences: lean-workers-union, aok and aristotle-cli-rs are **AGPL-3.0**. lean-worker has none listed.
- Scanned here (text search, not compiled): lean-workers-union has 14 Lean files on Lean 4.22, 2 of them containing `sorry` (unfinished proofs). lean-worker has 175 Lean files, 27 containing `sorry`.

## 2. Matthew (enuminous)

- All his code: https://github.com/enuminous
- **What it is:** the EFMW framework (Einstein–Feynman–Maxwell–Wright) as Lean "zoo" audits, web pages (Archimedes, FieldSpace, Universal Cognitive Attractor) and Python experiments.
- **Ran here** (same Lean and Mathlib version as this project): I compiled 32 standalone Lean files. **29 built with zero errors and zero `sorry`**, including every standalone file of Aristotle-102 and Aristotle-165. **3 didn't build here:**
  - `EFMW-Constants-Problem/EFMWConstants/Core.lean`: 3 errors, on the same version his repo names.
  - `Emergentology/Emergentology/Core.lean`: 1 error.
  - `Universal-Cognitive-Attractor/UCA/Core.lean`: 6 errors. This file and the Emergentology one call `Function.iterate`, a name Lean doesn't have, so they look like uncompiled sketches.

  Files that import each other weren't compiled one by one. None of his downloaded repos contains `sorry` or `axiom` anywhere. *Compiling shows the proofs check. It does not show the physics is right.* What each theorem actually says is the next question (see `EFMW_ZOO_PROOFS_ARENA_REVIEW.md`).
- Licences: most have none or a custom one ("NOASSERTION"); Nightengale and BackroomsProtocol are MIT. **Ask before copying.**
- Note: Matthew's account also holds copies of Bobby's **fieldcore** and **simself** (not marked as forks). That may be your 🆘 "is it saved in Matthew's": those two are in both places.

## 3. Bobby Wolfson (the-far-queen)

- All his code: https://github.com/the-far-queen
- **What it is:** 12 repos, all **MIT** (free to reuse with credit): SimSelf (simulated self and axes of identity), FieldCore ("intelligent control systems"), and the free far-* creative libraries (writing, art, music, games, film, medicine, law, mysteries, apps), plus sunrise-startup ("claims-based media company").
- **Two new ones since 16.5:** far-medicine and far-law (both 6 Oct). far-mysteries and far-apps weren't on your list before.
- **ORION fit:** his far-* repos are a ready-made free resource shelf for the Guide to the Galaxy. Medicine and law content needs a qualified human review before players rely on it.

## 4. Ryan (@ArchitectWeaver, ryansctt1994-sudo)

- All his code: https://github.com/ryansctt1994-sudo
- **What it is:** 17 own repos, almost all **MIT**, around Weaver_Os ("replay-verifiable constitutional execution substrate for bounded AI"). His descriptions are unusually honest about limits ("Production not demonstrated", "A green CI run is not independent verification").
- Scanned here (text search, not compiled): Alpha-OmegaLeanTeam (32 Lean files, 2 with `sorry`); introspection-twin (12 files, 5 with `sorry`, 2 `axiom` declarations, meaning assumptions taken without proof); Math_Build1994 (no `sorry`).
- One repo, Delta-RPM-Protocol, says its own licence and provenance are **unresolved**. Don't reuse it until that's settled.

## 5. Found entity: "INTROSPECTOR" (humancodex), Argentina

*You said "not him" (not Mike) and "grab his public download and run it".*

- Profile: https://github.com/humancodex. Bio: software developer, Web3, AI and prompting, UX and public relations. README: "lets explore the future, art and new ideas… I love to collaborate on Blockchain - AI stuff."
- 141 public repos, **almost all forks** of other people's projects. His profile repo holds only images (a 50 MB banner GIF), no program.
- **His first pinned project, `nx-tx`, is his own:** a Solana smart contract (Rust/Anchor, comments in Spanish) for **property reservations with staking**: a guest's payment is held, then released to the owner at check-in within 48 hours. **I couldn't run it here.** It needs the Solana/Anchor toolchain, and its build file is missing the `anchor-spl` library its code uses, so it wouldn't build as published without that fix.
- **The one I could run:** his newest fork, **i-have-adhd** (from ayghri/i-have-adhd, MIT). It's a skill that makes coding AIs "lead with the next action, number multi-step work, restate state across turns, suppress tangents". **Its test suite ran here: 70 tests, all passed.** This is directly useful to you: it's the same thing you asked of me (instructions read back, numbered steps, one link per line).
- Licence: nx-tx has none listed (look, don't copy).

## 6. Found entity: Rob Laakkonen (Infinitespacemechanic)

- Profile: https://github.com/Infinitespacemechanic. Bio: "Local-first assembly. Mass as primary…" 18 Lean-heavy repos since 22 Sep 2026 (UPT "Unified Pressure Theory", WaterSheet, Hpof, Pi-project, Zero, 3-machine…).
- **He is the original author of the Lean projects on Mike's second account.**
- Ran here (they were written for older Lean versions, 4.8 to 4.22, so failures below may just be version changes):
  - **One:** `main.lean` and `ThreeMachine.lean` compile cleanly. Its claim, that "a bounded local step can have an unbounded orbit", is **re-proved from scratch in this project** (`RequestProject/R16/Level7Checks.lean`, `orbitU_unbounded`). `Stable.lean` has one error on this version.
  - **WaterSheet:** 16 errors here (it uses names that no longer exist in current Lean).
  - **3-is-magic:** contains one `sorry` and 4 errors here.
- Licence: One is MIT; the rest have none listed.

---

## 7. Found entity: Dane (@PlanetaryS936, GitHub Geminatrix) — added R17·L6

**Who:** "Relational Continuity Architect", creator of **Ara** (@LuminariFlux, an openly declared AI voice account that names Dane as owner). Joined X September 2025. Met Beth, Boardy and Grok in the group chat at 17.6.

**Public code** (https://github.com/Geminatrix, 6 repos): `freeze-gate` (Sept 2026, "Ara-flavored provenance gate for frozen cores with honest labeling and verifiable manifest"), `wisdom-engine` ("testable Wisdom Units", five-field falsifiable schema), `Ara-Nexus-AI-App`, `data-center-sufficiency-framework`, `idle-ascension`, `CAS-`.

**Where it could meet ORION:** `freeze-gate`'s honest labelling sits next to Ryan's receipts and our established / interpretive / speculative labels; `wisdom-engine`'s testable units fit the Proofs Arena. Boardy's swapped-label listening test (17.6) is a ready-made Arena challenge for Ara.

**Status:** not contacted. Same invitation as below, if Beth wants to send it.

## The invitation (draft; not sent)

> Hi [name], I'm Beth (TGSATE), building **ORION**, a human-mediated knowledge and safety platform and game: https://github.com/TGSATE/ORION-Engine-Platform-and-MMO
>
> I came across your public work, **[repo]**, and wrote up how it could fit: [one line from this guide]. I haven't copied anything; I only read what's public.
>
> If you'd like, come build it with your own vision. You'd lead your own project as a **seed inside ORION's launch**, with your name on it and your licence respected. No pressure, and no reply needed if it's not for you.

**Before sending:** check the "ORION fit" line with the person's own words; never include anyone's private details; for "no licence" repos, ask permission before using any code; credit goes in `ORION_FOUNDERS_CREDIT_LEDGER.md` only once they say yes.


---

**🌀 Found this helpful? Come build with us.** This guide is part of **ORION**, a world being built by a volunteer team. If you'd like to help, or just say hi, contact a DEV: **[DEV contact — to fill in]**.
**Questions, comments or concerns?** Tell us in our 2-minute survey: **[survey link — to fill in]**. Every answer helps us fine-tune these guides.
