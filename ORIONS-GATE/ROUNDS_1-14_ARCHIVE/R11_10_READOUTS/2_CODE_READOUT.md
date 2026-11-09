# Code readout — ORION R11🌀>10, page version 1201

*For ☂️ coders and proof people. The narrative is in `1_…`; models vs proposals are in `3_…`.*

## 1. `1/(n+1)` — the one-line rule (☂️ "that one's for the coders")

The same fraction names **two unrelated rules**. Never cite one as evidence for the other.

| Use | Formula | Behaviour | Status |
|---|---|---|---|
| Progenitor **royalty chain** (each ancestor k takes `1/(k+1)`) | 1/2 + 1/3 + 1/4 + … | grows without limit; with just 3 ancestors it pays 13/12 of the sale | **refuted as a payout rule** (`RoundFour/Attribution.lean`: `progenitor_three_overpays`, `progenitor_unbounded`) |
| **Equal liability share** among n+1 members | (n+1) × 1/(n+1) | always exactly 1 | fine as a split rule (`DeepCrawlEleven.lean`: `equalStake_sum`) |

Both facts in one statement: `RoundElevenAnnotation.one_over_succ_two_meanings` (new; proved).

**Implementation note:** if you implement equal shares in integer currency units, `1/(n+1)` doesn't divide evenly. Decide who gets the remainder (e.g. the ledger keeps it, as with the round-down rule of the transmutation bank) and test that the shares never total more than the amount.

## 2. New Lean file: `RequestProject/RoundEleven/AnnotationPassEleven.lean`

It builds as part of the whole project with no `sorry`. `#print axioms` shows only `propext`, `Classical.choice` and `Quot.sound`, or no axioms at all. **These are models of written rules, not tests of a game client.**

| Theorem | Plain meaning |
|---|---|
| `starter_pod_houses_linguistic_poly` | the starter pod houses a linguistic Poly (💎) |
| `starter_pod_understands_ordinary` | wearing the starter pod, ordinary foreign speech is understood from day one |
| `empty_pod_garbles` | an empty pod (biosphere, no organism) translates nothing |
| `safety_clear_any_pod` | safety text is clear whatever pod you have |
| `one_over_succ_two_meanings` | §1 above |
| `reuse_adds_no_credit` | showing an already-credited artifact on another platform adds no credit |
| `new_artifact_adds_one` | a genuinely new artifact adds exactly one credit |
| `credited_le_card`, `triple_use_single_credit` | credit ≤ number of appearances; one artifact used on 3 platforms = 1 credit |
| `handoff_preserves_state` | the incoming council member gets exactly the outgoing member's state |
| `handoff_grants_no_authority` | a handoff never transfers authority |
| `monster_row1`, `monster_row2` | 196883 = 47·59·71 and 21296876 = 2²·31·41·59·71 |

**Modelling choice to be aware of:** in the Poly model, "translates" means "the pod houses a *linguistic* Poly". If later Polys of other kinds also translate, change `podTranslates`.

**Locked earlier results now 💎 by Beth** (in `DeepCrawlEleven.lean`): `no_pod_no_skill_garbled`, `gold_locked_needs_no_pod` and `bond_frees_slot_and_keeps_translation`. Beth marked 🤷‍♀️ on `liability_rules_disagree_out_of_scope`, which means it stays an open question.

## 3. New uploads: what was checked

| Upload | What it claims | What I did | Result |
|---|---|---|---|
| `weaver-proto-asi-p0-v0.2-hardened.zip` | 12/12 invariant/adversarial tests, 4/4 mutants killed, hash-chained append-only chronicle, Belnap FOUR logic where `BOTH` can't authorise; **E4 not earned, authority O0 withheld** | unzipped and ran `python3 -m unittest discover -s tests`, `mutation/run_mutants.py`, `e4/weaver_witness.py --verify-package .` (Python 3.11) | **12 tests OK; 4/4 mutants KILLED; `LOCAL_VERIFY_PASS;VS001_NOT_EXECUTED;E4_NOT_EARNED`**, matching its own claims. Two issues: the folder inside is named `weaver-p0-v0.1/` though the README says v0.2 (register E-06), and the toolchain hash differs from the author's (3.13.5 vs 3.11 here), as expected |
| `Alpha-Omega-v0.6-promotion-review-e14019f.zip` | PR #22 on `ryansctt1994-sudo/Alpha-OmegaLeanTeam` at commit `e14019f…`: Lean forward-simulation of 7 named ledger transitions, 43 replayed transitions, MU-1…MU-8 + 5 Lean mutants killed; **do not self-merge; witness W0; production not granted** | checked `CHECKSUMS.sha256` (all OK), checked the embedded evidence zip's SHA-256 (`4aed5262…454b`, matches the review), read the logs | logs are consistent with the claims: build OK on Lean 4.22.0; `axioms.log` shows only `propext` for the 12 theorems; 38 upstream tests passed; `Replay.lean` (≈700 KB, 129 theorems) has no `sorry`. **I did not rebuild it:** the packet points to the repository rather than including it, and it uses Lean 4.22 (this project uses 4.28) |
| `17da0589-…-aristotle.tar.gz` | an Aristotle project output | unpacked and compared byte for byte with this repository | it is an **old snapshot of this same project** (the Round Four triage run). 38 of its 42 files are identical to today's; the 4 that differ (`ARISTOTLE_SUMMARY.md`, `README.md`, `GAME_LORE_CODEX.md` and `RoundFour/Checks.lean`) changed since then. The Lean change is wording only ("threat level" → "threat rank"). It is **not** the separate Aristotle project with `Gauntlet.lean`; that one still hasn't been shared |
| Matthew's council readout (Monster table) | `irreps_sum.tsv` in `meta-introspector/monster`: rows indexed by A001379, p-adic exponents, `row_exponent_sum`; leading row index 192 with sum 56 | downloaded the file (saved as `orion/r11-10/monster_irreps_sum.tsv`, SHA-256 `04a28069…8232`) | **correct.** 194 rows (the Monster group has 194 irreducible representations); the first row is index 192 with sum 56; every row's sum matches its columns (checked with a quick script, not in Lean). The column primes are the 15 primes dividing the Monster's order (register E-05). Two rows are checked in Lean (`monster_row1`, `monster_row2`) |
| Manicode post (`x.com/manicode/…`) | security prompts | resolved its links | OWASP AISVS, CheatSheetSeries, owasp-java-encoder, java-html-sanitizer and manicode.ai: reference material, not code for ORION |

## 4. Tooling

- `review/notion_deep_crawl.py` and `review/deep_link_crawl.py` were reused unchanged. This round I compared the top page against the previous crawl (744 → 1201): 130 new lines, 0 removed, 5 new attachments, **no new nested Notion pages**, so the 415-document nest map in `orion/r11-deep/NEST_MAP.md` is still current.
- New saved files: `orion/r11-10/PAGE_TRANSCRIPT_v1201.md`, the 5 attachments and `orion/r11-10/SOURCE_HASHES.sha256`.

## 5. For coders: open items with code impact

- **C-01 / C-02** (liability; can an AI be paid): the ledger code shouldn't assume either rule until Beth rules.
- **C-03** (Singularity): don't use one `Singularity` type for both a joinable room and a sealed child room; use two room types.
- **C-08** (bonded Poly leaving its pod): the slot logic is proved, but the pod's state after the bond isn't specified yet.
- **C-12** (copilot renting): rented copilots must not carry private logs. Suggested test: renting a copilot exposes zero private-log entries.
- **Integer rounding** for equal shares (§1).
