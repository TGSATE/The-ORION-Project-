# Formal models and proposals readout — ORION R11🌀>10, page version 1201

*Separates four kinds of thing that keep getting mixed up. **Locked rule** = Beth's 💎. **Formal model** = a simplified Lean statement of a written rule, proved; it says the rule as written has that consequence, not that a game does it. **Proposal** = an idea not yet locked. **Deployed** = running on a live site or client.*

## 1. Status board for this round

| Item | Locked rule | Formal model | Proposal | Deployed |
|---|---|---|---|---|
| Starter pod with a linguistic Poly for everyone | ✅ 💎 R1201 | ✅ `starter_pod_houses_linguistic_poly`, `starter_pod_understands_ordinary` | — | ❌ |
| Poly = organism, pod = biosphere | ✅ 💎 R1201 (as your clarification) | ✅ `empty_pod_garbles` (only the organism translates) | — | ❌ |
| No pod + no skill → garbled; gold-lock needs no pod; bond frees slot | ✅ 💎 R1201 | ✅ `DeepCrawlEleven.lean` | — | ❌ |
| Safety text never garbled | Round 10 proposal, carried into every model | ✅ `safety_always_clear`, `safety_clear_any_pod` | needs a 💎 | ❌ |
| Master-tier pods crafted by artisans | — | — | assumed from Master Summary | ❌ |
| Liability: scoped vs equal stake | ❌ open (C-01) | ✅ disagreement proved | both | ❌ |
| Shared Work ID (one artifact, one credit) | earlier cross-platform reply, not 💎 here | ✅ `reuse_adds_no_credit`, `new_artifact_adds_one`, `triple_use_single_credit` | Matthew's primitive #6 | ❌ |
| Council handoff packet | ❌ (🍝 R11) | ✅ `handoff_preserves_state`, `handoff_grants_no_authority` | yours + Matthew's packet fields | ❌ |
| ORION Transmission Protocol v0.1 | ❌ | — | Matthew | ❌ |
| UIAR (Universal Intelligence Augmented Reality) | ❌ | — | your new name 🍝 | ❌ |
| Monster Geometry Lab | ❌ | two table rows checked arithmetically | Matthew | ❌ |
| Three planets (Earth/Krion, Mars/Kronos, Saturn/Orion) | ❌ | — | 🍝 R11; naming clash C-06 | ❌ |
| Friction Atlas site | — | — | — | ✅ deployed, byte-identical to this project's `site/` (previous pass) |

## 2. Matthew's council readout: what it proposes, and how it fits

**Six primitives:**
1. Build ID
2. Contributor ID (human or AI)
3. Artifact ID
4. Transmission ID
5. Handoff packet
6. Shared Work ID

**Fit with what exists here:**
- *Contributor ID* and *Artifact ID* match the fields your to-do list already asks for: contributor, strengths, contributions, what changed. They also match the ledger workflow in `R11_CONTRIBUTIONS_AND_PACKAGES.md`. "Human or AI" collides with the equal-stake rule's "AI none" (register C-02). Credit and pay need to be separate fields.
- *Transmission ID* as an "immutable state transition": compatible with the earlier accountability-record rule (no edits, append only). Ryan's new Weaver P0 package implements exactly this shape: an append-only, hash-chained chronicle where revocation adds an event instead of rewriting.
- *Handoff packet*: Matthew's field list is `build_version, agent, objective, completed, unresolved, decisions, assumptions, artifacts, proofs, contributor_map, vocabulary_delta, game_delta, dependencies, next_actions`. It is a superset of the handoff template already in `ROUND_ELEVEN_CHANGELOG.md`. **One addition I recommend:** an explicit `authority: none` line. The model shows that a handoff passes state but never authority, and the earlier rule says a new council member "inherits context, never permissions".
- *Shared Work ID*: modelled and proved this round (table above). One artifact shown on Chronicles, Ascent and the community layer is one credit.

**The protocol record:**

> STATE → DELTA → PROVENANCE → VALIDATION → GAME EFFECT → OPEN QUESTIONS → HANDOFF → NEXT STATE

Under this proposal, the wiki, dictionary, contributor ledger, build history, proof registry, spaghetti narrative and council handoff all become *views* of one record. If you adopt it, this set of readouts maps onto it directly:

| Protocol step | Readout that covers it |
|---|---|
| STATE, DELTA | `00_START_HERE` |
| PROVENANCE | contributor ledger |
| VALIDATION | `2_CODE_READOUT` |
| GAME EFFECT | this file |
| OPEN QUESTIONS | `CONTRADICTIONS_REGISTER` |
| HANDOFF | `ROUND_ELEVEN_CHANGELOG` |

**Not adopted by me:** the protocol is a proposal until you 💎 it.

**Monster Geometry Lab:** Matthew himself says "don't declare correspondence first; try to break it". That matches this project's rule: no physical claim without a test. The data checks out (code readout §3). Any link between Monster data and ORION's Kronos/Orion "flux" is a research hypothesis, not a result.

**UIAR:** Matthew suggests keeping it as a name for the interface style, "intelligence distributed among humans, artificial agents, persistent world-state and augmented interfaces", not as a claim that a new kind of intelligence has been shown. I agree, and that's how it's recorded in the wiki.

## 3. Ryan's packages (portfolio status, as the packages state it)

- **Weaver Proto-ASI P0 v0.2:** local tests and mutants pass (re-run here). Concurrency check VS-001 not executed; E4 not earned; authority O0 withheld.
- **Alpha-Omega v0.6:** forward simulation of 7 named ledger transitions; technically green at commit `e14019f`; **not self-merged**, pending an independent reviewer. Its own list of what it does *not* establish includes crash persistence, concurrency, parser correctness, cryptographic strength, liveness and whole-runtime correctness.
- Both keep "production: not granted". Nothing from them is wired into ORION's game.

## 4. Proposals waiting for a 💎 (carry forward)

1. Singularity names (C-03).
2. Liability rule (C-01), and whether AI can be paid (C-02).
3. Adult Penalty: designed penalty or natural result (C-04).
4. What happens to a pod after its Poly bonds (C-08); whether Polys are one species (C-07).
5. Level 65 picture: rider, hatchling or dragon (C-05).
6. Planet names vs meter names (C-06).
7. Transmission Protocol v0.1 and the handoff packet fields, plus `authority: none`.
8. Safety-text-never-garbled as a 💎 rule.
