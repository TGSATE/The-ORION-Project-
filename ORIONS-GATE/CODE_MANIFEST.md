# Code manifest and comparison notes

This file is the "CODE export" asked for in the comparison against the OEPPF / Round Three build. It lists every
file in this project (Appendix A) and every theorem in the Lean files (Appendix B), so the comparison can be done
file by file and line by line, not only from the Properties panel.

To regenerate it after any change: `python3 review/make_code_manifest.py`. The hand-written part is
`CODE_MANIFEST_HEADER.md`; the appendices are generated.

## How to check it yourself

- `lake build` builds every Lean file. It finishes with no errors and no `sorry`.
- Every theorem in the project uses only Lean's standard axioms (`propext`, `Classical.choice`, `Quot.sound`, plus
  the compiler-trust axioms `Lean.ofReduceBool` / `Lean.trustCompiler` that `native_decide` uses). No theorem
  depends on `sorry`.
- The four Python files each run on their own and print their self-test result:
  `python3 orion/gate_reference.py`, `python3 review/ghost_rider_v3_check.py`,
  `python3 review/anti_babel_await_check.py`, `python3 review/h4_penrose_fixed.py`.
  They are executable sketches and checks, not proofs.

## Panel count versus code count

The Properties panel shows the headline results picked out for review. The Lean code holds
**739** named theorems and lemmas (Appendix B); the rest are companion facts, earlier versions and supporting steps.
"Proved" in either place means proved about the rules **as written down in the Lean definitions**. There is no game
or platform code in this project, so nothing here is a proof about a running system.

## Corrections to the comparison

### 1. The safety kernel *is* in this project

The comparison says the Gate / Roles / Consensus / Record / Shares files "may still be in the repo". They are, and
they build with everything else:

| File | What it covers |
| --- | --- |
| `RequestProject/Orion/Gate.lean` | Execution gate (Ryan's Round Three contribution): an unmapped lever never executes however strong the plight; the emergency path stays inside a pre-delegated envelope (listed levers and deeds, blast/residue caps, expiry, use count); total exposure over a run is bounded; a sub-envelope never permits more than its parent; jurisdiction over every deed touched; the decision never commits an unmapped lever but always offers halt/reverse under a real plight; break-glass needs two distinct humans and a cooling-off delay; the audit verdict doesn't depend on the outcome. |
| `RequestProject/Orion/Roles.lean` | Separation of roles: fewer principals than roles can't separate them; a copilot alone can't separate them and holds at most one role; an offline assignment that does separate them exists. |
| `RequestProject/Orion/Consensus.lean` | Correlated reviewers: effective number of independent reviewers, between 1 and n, falls as correlation rises. |
| `RequestProject/Orion/Record.lean` | Append-only record: pushing keeps history, the root entry is preserved, the digest is injective, tiering is lossless. |
| `RequestProject/Orion/Shares.lean` | Credit allocation: floor allocation never over-allocates, the final allocation sums exactly and each share is within one unit; responsibility shares sum to one, out-of-scope parties get zero. |
| `RequestProject/Orion/Tests.lean` | Held-out "cousin" cases: an answer that encodes the claim passes every cousin, one that fails a cousin was pattern-matching. Metaphor gate: "Seashell Spirals = Fibonacci" passes its check, a troll substitute (powers of two) fails it. |
| `orion/gate_reference.py` | Runnable Python sketch of the same gate, with self-tests. |
| `review/ghost_rider_v3_check.py`, `review/anti_babel_await_check.py` | Checks on the Ghost Rider and anti-Babel code that was shared earlier. |

So the platform-safety layer (no self-authorisation, envelopes, dual break-glass) is formalized here too. It's just
not what the Round Three curation entries on the panel are about.

### 2. 43 versus 46 is not a mismatch

The Core roster in `RequestProject/Zoo/Arena.lean` has **46** entries. `EFMWZoo.coreRoster_spec` proves it has 46
distinct names and that its first 23 are exactly the v1 inventory.

The **43** is the number of dragon **species**. Following the curation answers, `HIVE`, `PULSE` and `SHEPHERD` are
archetype upgrades, not animals. `RoundThreeCuration.roster_split` proves:

\[ 46 \text{ Core entries} = 43 \text{ species (including } \texttt{DRAGON} \text{ and } \texttt{PHOENIX}) + 3 \text{ archetypes.} \]

The species list is computed from the 46-entry roster by removing the three archetypes, so the two numbers can't
drift apart. The canonical number for the Proofs Arena roster is 46. The canonical number for "species a dragon
can be built on" is 43. The older `RoundThreeDragon.speciesChoices` (all 46 as builds) is kept in the code, marked
*Superseded*.

### 3. What is genuinely not here

- **Ryan's Formal Kernel v0.3 / ProtoASI package** (authority state machine, "learning does not grant
  authority"). Those ZIPs were never shared with this project, so nothing here formalizes or checks them. The
  Round Three gate above is based on his Round Three contribution summary and transcript only.
- **Kronos / Orion meters and dual perception.** Only the aggro side is modelled: Kronos-aligned (kinetic)
  skills reset aggro, ORION-aligned debuffs and heals don't (`RoundThreeClarifications`, `RoundThreeCuration`).
  The meters themselves aren't formalized.
- **Education / Global / Social hubs.** Not formalized.

## The four answers still needed

Until these are answered, the proofs assume the reading shown. Each is a one-word answer.

| # | Question | What the proofs assume now | Where |
| --- | --- | --- | --- |
| 1 | Rounding: do costs round **up** and payouts round **down**? | Both halvings are defined; `rounding_spec` proves they differ by at most 1 and only on odd amounts. Which one applies to costs and which to payouts isn't fixed yet. | `RoundThreeCuration.rounding_spec`, `ROUNDS_1-14_ARCHIVE/ROUND_THREE_CLARIFICATIONS.md` §8.5 |
| 2 | Keep the lock names "Gold Lock" (64 character nodes) and "Black Hole lock" (144 dragon nodes)? | These names. Renaming doesn't change any proof. | `ROUNDS_1-14_ARCHIVE/ROUND_THREE_CLARIFICATIONS.md` §8.6 |
| 3 | In a group, does casting a Kronos (kinetic) skill while a teammate is aggroed aggro **only the caster**, for the full 10 minutes? | Yes (`join_fight`). Members who cast nothing kinetic are never aggroed by the group (`stays_inactive`, proved regardless of this answer). | `RoundThreeCuration.join_fight`, §8.8 |
| 4 | Can **any** species take the `HIVE` / `PULSE` / `SHEPHERD` archetype, or only the generic `DRAGON`? | Any species: the model puts no species restriction on archetype upgrades. | `RoundThreeCuration.archetypes_valid`, `ROUNDS_1-14_ARCHIVE/ROUND_THREE_CLARIFICATIONS.md` "Still open" |

## Older entries that were replaced

These stay in the code so the history is visible. Each is marked *Superseded* in its docstring and points at its
replacement:

- `RoundThreeDragon.speciesChoices` (46 builds) → `RoundThreeCuration.speciesChoices` (43 species + 3 archetypes).
- `RoundThreeDragon.canPlantSeed` → `RoundThreeCuration.canHatch` (the skybox gate needs the quest-line escape or a key).
- `RoundThreeDragon.looks_do_not_matter` → `RoundThreeCuration.skin_never_matters` (body and archetype affect abilities; only skin never does).
- The mid-encounter PvP refusal in `RoundThreeRulings` → the toggle in `RoundThreeClarifications` that records the request and applies it when the encounter ends.
- An earlier reading of the gift rules in `RoundThreeFollowups` → the gift rules in `RoundThreeRulings` (numbered queue slots 1–20, sender's warning, schematic-based points).

## Appendix A. Every file in the project

| File | Lines | SHA-256 (first 16 hex) |
| --- | ---: | --- |
| `ARISTOTLE_SUMMARY.md` | 1509 | `f5e865ab8be7750c` |
| `BETH_NUMEROLOGY_LOG_FOR_TEAM.md` | 443 | `b148402a16d9b505` |
| `BOBBY_STORYLINE_STARTER_PACK.md` | 127 | `68b18b1fb0c66110` |
| `CODE_MANIFEST_HEADER.md` | 94 | `98f6334a3f0a3d48` |
| `COLLABORATOR_PRODUCTION_PROPOSALS.md` | 127 | `c905ae7d4a9416f8` |
| `CONTRADICTIONS_REGISTER.md` | 217 | `8273061e19cabccd` |
| `DIAMOND_RULES.md` | 82 | `d53d806868388566` |
| `EFMW_ZOO_PROOFS_ARENA_REVIEW.md` | 82 | `07eba2dc59c16c25` |
| `ENDERS_GAME_DRAGON_BACKDROP.md` | 54 | `506032f625592684` |
| `FOLLOW_UPS.md` | 259 | `46dd74f9a8528607` |
| `FREE_VIDEO_EDITING_GUIDE.md` | 76 | `b07cbed7de06748e` |
| `FRICTION_EXAMINATION.md` | 136 | `988a8a517458cf3a` |
| `Faerie-Queen.txt` | 360 | `93861b39d5b47fed` |
| `GAMEPLAY_MECHANICS_SUMMARY.md` | 334 | `5ebb77194d94eb6e` |
| `GAME_LORE_CODEX.md` | 283 | `a45d5391e71310a3` |
| `GAME_MASTER_TRAINING_GROUND.md` | 102 | `2ecb912fac74e9f9` |
| `GHOST_WRITER_IN_THE_MIRROR.md` | 102 | `869ab7841c0eee01` |
| `HANDOFF-3.md` | 58 | `acb6ca72850c2051` |
| `ROUNDS_1-14_ARCHIVE/IMAGE_MATH_CHECKS_R15.md` | 78 | `672f37cc197f5282` |
| `INDEPENDENT_REPRODUCTION.md` | 13 | `1505db17e0b001a4` |
| `LOOM-TRIAD-001_v0.3.release-receipt.json` | 6 | `40239017931f7463` |
| `MEMBER_NOTES_THIS_ROUND.md` | 126 | `0b91447182ca8025` |
| `NEPAL_SPARK_ACADEMY_PROPOSAL.md` | 86 | `e709576eeecd70a7` |
| `ROUNDS_1-14_ARCHIVE/ORION_ALBUM_ROUND14_REVIEW.md` | 44 | `7b1bac76270a2cb8` |
| `ROUNDS_1-14_ARCHIVE/ORION_BREADCRUMB_TRAIL_R15.md` | 82 | `8dca7f74db04882c` |
| `ORION_BUILD_GLOSSARY.md` | 204 | `9a5c719f487fb746` |
| `ORION_BUS_PLAYLIST.md` | 20 | `b23049c7f3b0ef65` |
| `ORION_EDUCATOR_COLLABORATION_PROPOSAL.md` | 88 | `4c3d8625e7ba6822` |
| `ORION_FOUNDERS_CREDIT_LEDGER.md` | 107 | `31e995f43f87b158` |
| `ORION_FUNCTIONAL_WALKTHROUGH.md` | 157 | `f1ca30ec385b8e87` |
| `ORION_GAME_MANUAL.md` | 254 | `df1a316822c35f89` |
| `ORION_HANDOFF_FOR_UIARS.md` | 169 | `6ac3e9e6a97ccc35` |
| `ORION_IMAGE_DEEP_DIVE.md` | 95 | `3a49e61cdd31609b` |
| `ORION_IMAGE_PROMPTS_BETH.md` | 228 | `3269b43ad0b3c6ba` |
| `ORION_IMAGE_PROMPT_LIBRARY.md` | 148 | `fd83218af232405d` |
| `ORION_IMAGE_READOUTS_META_AI.md` | 265 | `ba519e167245f860` |
| `ORION_LINK_ARCHIVE.md` | 1310 | `11ba5da56199b62f` |
| `ORION_MASTER_INDEX.md` | 247 | `d050efe0ce6e5008` |
| `ORION_MEMBER_PACKETS/BETH.md` | 57 | `087e1d2b18e91e57` |
| `ORION_MEMBER_PACKETS/BRIANNA.md` | 45 | `9a96e01d78e8efe9` |
| `ORION_MEMBER_PACKETS/KING_BOBBY.md` | 46 | `0bcf119414582c90` |
| `ORION_MEMBER_PACKETS/LUCIEN.md` | 49 | `368cc4615b0297e4` |
| `ORION_MEMBER_PACKETS/MAREK.md` | 46 | `bd0aa7b1b6171213` |
| `ORION_MEMBER_PACKETS/MATTHEW.md` | 48 | `1981eac43304a429` |
| `ORION_MEMBER_PACKETS/MIKE.md` | 49 | `879ec753c09d7d06` |
| `ORION_MEMBER_PACKETS/README.md` | 22 | `90a3ccb6f866f783` |
| `ORION_MEMBER_PACKETS/RYAN.md` | 48 | `da59835f4ed5813f` |
| `ORION_MEMBER_PACKETS/SHAKES.md` | 47 | `a02bc3bcf44c2a21` |
| `ORION_MEMBER_PACKETS/TRISS.md` | 47 | `4049c6562f224541` |
| `ORION_PLAYER_CHARACTER_SHEETS.md` | 116 | `bb5dbb179944e05f` |
| `ORION_PUBLIC_CHARACTER_CARDS.md` | 76 | `bbb6f66984026f2b` |
| `ORION_RUNNING_ROSTER.md` | 306 | `7d899b5926ff7d99` |
| `ORION_SPAM_FILTER_REVIEW.md` | 46 | `306343d76e719f64` |
| `ORION_STORYLINE_LIBRARY.md` | 37 | `554602c8a36b0efe` |
| `ORION_SUMMARY_CURRENT.md` | 193 | `02aed7c388ca16f8` |
| `ORION_TEAM_PROCESS_AND_TOOLS.md` | 122 | `a4d95853b24d4ffa` |
| `ORION_UNDER18_STRUCTURE.md` | 125 | `28d1eb528713146e` |
| `ORION_WEBPAGE_BUILDER_PROMPT.md` | 148 | `c02717f204ed68eb` |
| `ORION_WIKI_DICTIONARY.md` | 203 | `b14c319f36c84ed3` |
| `ORION_X_THREAD_BLURBS.md` | 197 | `e238aa9c51c943c9` |
| `PERSONAL_DETAILS_REVIEW_BETH.md` | 69 | `03812b190c5e9c76` |
| `PRE_PUBLICATION_REVIEW.md` | 20 | `8edab6a565a750a6` |
| `ROUNDS_1-14_ARCHIVE/R11_10_READOUTS/00_START_HERE.md` | 22 | `ee2a9f409a50a5a9` |
| `ROUNDS_1-14_ARCHIVE/R11_10_READOUTS/1_NARRATIVE_READOUT.md` | 75 | `5f325f423feccc7f` |
| `ROUNDS_1-14_ARCHIVE/R11_10_READOUTS/2_CODE_READOUT.md` | 61 | `2d581c92ecb527e0` |
| `ROUNDS_1-14_ARCHIVE/R11_10_READOUTS/3_FORMAL_MODELS_AND_PROPOSALS_READOUT.md` | 75 | `9ccc2b2589b7c88b` |
| `ROUNDS_1-14_ARCHIVE/R11_10_READOUTS/4_PERSONAL_READOUT_BETH.md` | 80 | `776c8c5e94c0be14` |
| `ROUNDS_1-14_ARCHIVE/R11_CONTRIBUTIONS_AND_PACKAGES.md` | 97 | `fbec956cd1b75ec2` |
| `README.md` | 109 | `df8f7f9185bb9a61` |
| `ROUNDS_1-14_ARCHIVE/ROUND_EIGHT_REPLY.md` | 324 | `13d99e61e05d015d` |
| `ROUNDS_1-14_ARCHIVE/ROUND_EIGHT_SECOND_PASS.md` | 179 | `9a125b42c433656a` |
| `ROUNDS_1-14_ARCHIVE/ROUND_ELEVEN_CHANGELOG.md` | 103 | `61ba707420f79c01` |
| `ROUNDS_1-14_ARCHIVE/ROUND_ELEVEN_DEEP_CRAWL_READOUT.md` | 239 | `46b42604e2b61551` |
| `ROUNDS_1-14_ARCHIVE/ROUND_ELEVEN_REPLY.md` | 46 | `ffd512377f23ccec` |
| `ROUNDS_1-14_ARCHIVE/ROUND_ELEVEN_SOCIAL_AND_MONSTER_READOUT.md` | 25 | `d02047c1bf863986` |
| `ROUNDS_1-14_ARCHIVE/ROUND_ELEVEN_V1559_SWEEP_READOUT.md` | 97 | `63465d49da0700f9` |
| `ROUNDS_1-14_ARCHIVE/ROUND_ELEVEN_V1770_INTAKE_READOUT.md` | 74 | `40dfee8aea4005ed` |
| `ROUNDS_1-14_ARCHIVE/ROUND_ELEVEN_V1843_NARRATIVE_READOUT.md` | 273 | `d621edbb701959a3` |
| `ROUNDS_1-14_ARCHIVE/ROUND_FIFTEEN_READOUT.md` | 143 | `f0260d5aee1a65df` |
| `ROUNDS_1-14_ARCHIVE/ROUND_FIVE_RYAN_LINKS.md` | 237 | `ccedd18e069b9435` |
| `ROUNDS_1-14_ARCHIVE/ROUND_FOURTEEN_READOUT.md` | 101 | `4b6226015df1b933` |
| `ROUNDS_1-14_ARCHIVE/ROUND_FOUR_PAGE_COMPARISON.md` | 165 | `6f8debb0b351d9d5` |
| `ROUNDS_1-14_ARCHIVE/ROUND_FOUR_RULINGS_UPDATE.md` | 137 | `cc7b7845850e4526` |
| `ROUNDS_1-14_ARCHIVE/ROUND_FOUR_RYAN_GAMEPLAY_READOUT.md` | 267 | `df4943688177363c` |
| `ROUNDS_1-14_ARCHIVE/ROUND_FOUR_TRIAGE.md` | 387 | `f644c6d460a59559` |
| `ROUNDS_1-14_ARCHIVE/ROUND_FOUR_UPDATE_FOUR.md` | 163 | `8190f1bdca7389c5` |
| `ROUNDS_1-14_ARCHIVE/ROUND_FOUR_UPDATE_THREE.md` | 142 | `decd07ab50eb92bf` |
| `ROUNDS_1-14_ARCHIVE/ROUND_NINE_FIFTH_PASS.md` | 264 | `a2f7de83f1be03bd` |
| `ROUNDS_1-14_ARCHIVE/ROUND_NINE_FOURTH_PASS.md` | 212 | `8c005fae4295d409` |
| `ROUNDS_1-14_ARCHIVE/ROUND_NINE_REPLY.md` | 374 | `315028971c336421` |
| `ROUNDS_1-14_ARCHIVE/ROUND_NINE_SECOND_PASS.md` | 194 | `be212bdb9c9cd6f2` |
| `ROUNDS_1-14_ARCHIVE/ROUND_NINE_THIRD_PASS.md` | 152 | `573f9d091aa630d3` |
| `ROUNDS_1-14_ARCHIVE/ROUND_SEVEN_FOLLOW_UP.md` | 198 | `7d327db99a3ea51f` |
| `ROUNDS_1-14_ARCHIVE/ROUND_SEVEN_FOURTH_PASS.md` | 143 | `fbaaed2028460421` |
| `ROUNDS_1-14_ARCHIVE/ROUND_SEVEN_REPLY.md` | 135 | `18c1141c85eb2777` |
| `ROUNDS_1-14_ARCHIVE/ROUND_SEVEN_THIRD_PASS.md` | 180 | `82ef52ea66a95807` |
| `ROUNDS_1-14_ARCHIVE/ROUND_SIX_REPLY.md` | 155 | `a07c2413ca8bd1cc` |
| `ROUNDS_1-14_ARCHIVE/ROUND_TEN_REPLY.md` | 24 | `6fe449a88037edd5` |
| `ROUNDS_1-14_ARCHIVE/ROUND_THIRTEEN_READOUT.md` | 351 | `111847236510820a` |
| `ROUNDS_1-14_ARCHIVE/ROUND_THREE_CLARIFICATIONS.md` | 358 | `41f844a69f7a20d0` |
| `ROUNDS_1-14_ARCHIVE/ROUND_THREE_DECISIONS.md` | 162 | `9b080815d8bab713` |
| `ROUNDS_1-14_ARCHIVE/ROUND_THREE_RESPONSES.md` | 455 | `0679da5f6300e1da` |
| `ROUNDS_1-14_ARCHIVE/ROUND_THREE_RULINGS.md` | 210 | `f3018fd6ca4fc2dd` |
| `ROUNDS_1-14_ARCHIVE/ROUND_TWELVE_FOLLOW_UP_READOUT.md` | 253 | `76b0d642cdc33f9c` |
| `ROUNDS_1-14_ARCHIVE/ROUND_TWELVE_READOUT.md` | 339 | `6211ce352ec2d1a5` |
| `ROUNDS_1-14_ARCHIVE/ROUND_TWELVE_THIRD_PASS_READOUT.md` | 316 | `897e8b9bbb2a3854` |
| `RequestProject/.gitkeep` | 0 | `e3b0c44298fc1c14` |
| `RequestProject/Friction/Channel.lean` | 52 | `c8af042387ea15d4` |
| `RequestProject/Friction/Mechanics.lean` | 192 | `290567f9e83cdc8b` |
| `RequestProject/Friction/NumericalClaims.lean` | 128 | `21e28776ada4d610` |
| `RequestProject/Main.lean` | 24 | `929b0bddef0b781f` |
| `RequestProject/Orion/Consensus.lean` | 106 | `331ed95c263b29c0` |
| `RequestProject/Orion/Gate.lean` | 214 | `79ea410ecd382e55` |
| `RequestProject/Orion/Record.lean` | 88 | `d78f3ac0e88fa4c5` |
| `RequestProject/Orion/Roles.lean` | 84 | `7004d1432c54571e` |
| `RequestProject/Orion/Shares.lean` | 155 | `e2ea269897c5affc` |
| `RequestProject/Orion/Tests.lean` | 78 | `aa60146a52610bb0` |
| `RequestProject/RoundEight/OpeningEight.lean` | 552 | `b8ebff8e4ff6e20b` |
| `RequestProject/RoundEight/POSMv04Check.lean` | 316 | `6ba9a6fae06051de` |
| `RequestProject/RoundEight/SecondPassEight.lean` | 536 | `82b350951fb8a4ee` |
| `RequestProject/RoundEleven/AnnotationPassEleven.lean` | 143 | `224ee24800e1b1e5` |
| `RequestProject/RoundEleven/DeepCrawlEleven.lean` | 91 | `ddc1a50afbfeb0fa` |
| `RequestProject/RoundEleven/MonsterArithmeticEleven.lean` | 34 | `f049eb23cb610375` |
| `RequestProject/RoundEleven/OpeningEleven.lean` | 56 | `60e84601a2c48c77` |
| `RequestProject/RoundEleven/ReadoutRuleEleven.lean` | 72 | `36007cf65150524e` |
| `RequestProject/RoundEleven/SharedPostsEleven.lean` | 31 | `2c2c313150866ef0` |
| `RequestProject/RoundEleven/SocialSweepEleven.lean` | 106 | `6ad0290c93b5b96c` |
| `RequestProject/RoundFifteen/ImageMathChecks.lean` | 148 | `9353ae10a29fbf1e` |
| `RequestProject/RoundFive/RulingsFive.lean` | 379 | `87aa700fe3a65925` |
| `RequestProject/RoundFour/Attribution.lean` | 127 | `aceb7ae65ba2d29f` |
| `RequestProject/RoundFour/Checks.lean` | 235 | `9b4e63edae0ce000` |
| `RequestProject/RoundFour/H4.lean` | 235 | `a5689ba0da02de4e` |
| `RequestProject/RoundFour/PlayerRounding.lean` | 151 | `e1e8f74b276bc931` |
| `RequestProject/RoundFour/Rulings.lean` | 342 | `fa76679c44108573` |
| `RequestProject/RoundFour/RulingsFour.lean` | 338 | `83a47cfe09bce1a7` |
| `RequestProject/RoundFour/RulingsThree.lean` | 263 | `d0778feda3ba6fcb` |
| `RequestProject/RoundFour/RulingsTwo.lean` | 302 | `ad53c43e4b166683` |
| `RequestProject/RoundFourteen/SnapshotCounts.lean` | 137 | `0f887d20e8718e97` |
| `RequestProject/RoundFourteen/SpamFilterAndRules.lean` | 213 | `d3fd09d281eb64f1` |
| `RequestProject/RoundNine/FifthPassNine.lean` | 338 | `e787f90597f8e3c9` |
| `RequestProject/RoundNine/FourthPassNine.lean` | 285 | `d343b2b6565de3b3` |
| `RequestProject/RoundNine/OpeningNine.lean` | 651 | `e1a0c6c41f74966f` |
| `RequestProject/RoundNine/SecondPassNine.lean` | 543 | `5798b26c527919c0` |
| `RequestProject/RoundNine/ThirdPassNine.lean` | 260 | `76019dd4ab8b8800` |
| `RequestProject/RoundSeven/FollowUpSeven.lean` | 315 | `0a3ca12bb7395d0c` |
| `RequestProject/RoundSeven/FourthPassSeven.lean` | 203 | `428c2f8f1f2a9191` |
| `RequestProject/RoundSeven/RulingsSeven.lean` | 307 | `c992759969fa9dbe` |
| `RequestProject/RoundSeven/ThirdPassSeven.lean` | 269 | `8a947612546d1899` |
| `RequestProject/RoundSix/RulingsSix.lean` | 326 | `2e1ffd8a602a3503` |
| `RequestProject/RoundSixteen/EFMWAxiomsReview.lean` | 63 | `1d066f5ebadfcd21` |
| `RequestProject/RoundSixteen/EFMWAxiomsUpstream.lean` | 182 | `3c01bbc03328911f` |
| `RequestProject/RoundSixteen/PlaylistBuses.lean` | 66 | `f641657fd142083f` |
| `RequestProject/RoundTen/OpeningTen.lean` | 77 | `e640e88eadd91d77` |
| `RequestProject/RoundThirteen/LaunchPathAndBlurbs.lean` | 198 | `ab2691944b76f148` |
| `RequestProject/RoundThree/Clarifications.lean` | 333 | `4c637e9844d7e2ab` |
| `RequestProject/RoundThree/Compilation.lean` | 202 | `6a5858cfb2485e7c` |
| `RequestProject/RoundThree/Curation.lean` | 456 | `85ed1c909ca1c325` |
| `RequestProject/RoundThree/Decisions.lean` | 361 | `c39769aca2b42729` |
| `RequestProject/RoundThree/Dragon.lean` | 179 | `ba80a1dda0f7c736` |
| `RequestProject/RoundThree/Followups.lean` | 350 | `1abb29b882fde60d` |
| `RequestProject/RoundThree/Rulings.lean` | 570 | `82ebcb40d99ab848` |
| `RequestProject/RoundThreeLinks.lean` | 34 | `8c382317e6feeaa7` |
| `RequestProject/RoundTwelve/AlbumMathAndRulings.lean` | 161 | `c037a0be88ed911d` |
| `RequestProject/RoundTwelve/FieldCoreAndFieldSpace.lean` | 258 | `7b5b86c30f016946` |
| `RequestProject/RoundTwelve/ThirdPass.lean` | 186 | `8061971b2da5d303` |
| `RequestProject/Site/Grid.lean` | 72 | `4e93148eba2ae3ee` |
| `RequestProject/Site/Tour.lean` | 73 | `d6d414845bf7a8e2` |
| `RequestProject/Skybox/Count.lean` | 166 | `17985ef14fa4f7c4` |
| `RequestProject/TeamReview/GrantPath.lean` | 253 | `8363dd8aaff4fdb3` |
| `RequestProject/TeamReview/IT3Checks.lean` | 145 | `158aee56d64c4306` |
| `RequestProject/Zoo/Arena.lean` | 197 | `37e0b00d3b558fc6` |
| `ROUNDS_1-14_ARCHIVE/SPAGHETTI_LINKS_ROUND_THREE.md` | 41 | `07a3be634f8632e4` |
| `ROUNDS_1-14_ARCHIVE/SPAGHETTI_ROUND_THREE_COMPILATION_REVIEW.md` | 170 | `77c802e11d0c473e` |
| `TEAM_ROSTER_AND_X_REVIEW.md` | 171 | `da3dcdaf3a11984a` |
| `THE_ORION_CHRONICLES_CURRENT.md` | 143 | `ec5a184df34c40a8` |
| `lake-manifest.json` | 95 | `116c6ef00aa899fb` |
| `lakefile.toml` | 11 | `b1481968ce2912f2` |
| `lean-toolchain` | 1 | `db7bb24b756d745b` |
| `orion/gate_reference.py` | 107 | `820a53a0feb4603e` |
| `orion/r10-late/3ef5aabf_122A6329-F76D-4B9F-9E07-3049002FEBEC.heic` | 8095 | `f6abcefa4082633f` |
| `orion/r10-late/3ef5aabf_122A6329-F76D-4B9F-9E07-3049002FEBEC.jpg` | 1922 | `f824937989448443` |
| `orion/r10-late/3ef5aabf_7B405280-DCA2-4908-94F4-23910BA8EBEA.heic` | 5362 | `e8ce8633cfc5904c` |
| `orion/r10-late/3ef5aabf_7B405280-DCA2-4908-94F4-23910BA8EBEA.jpg` | 1490 | `1d38862415995f73` |
| `orion/r10-late/3ef5aabf_D9C903BE-8F02-473A-B679-4D82CE986D91.png` | 1357 | `d59f97fbf37f9966` |
| `orion/r10-late/3ef5aabf_IMG_3755.heic` | 3433 | `15689b6d59e34623` |
| `orion/r10-late/3ef5aabf_IMG_3755.jpg` | 1169 | `72c33379a422c925` |
| `orion/r10-late/3ef5aabf_IMG_3756.heic` | 3706 | `4ce50ce707f2fdd7` |
| `orion/r10-late/3ef5aabf_IMG_3756.jpg` | 1313 | `662e708b1debece5` |
| `orion/r10-late/3ef5aabf_PROOF-AND-REPORT.md` | 210 | `9285ff846b897616` |
| `orion/r10-late/PAGE_TRANSCRIPT.md` | 758 | `9a7e2c397c9b530d` |
| `orion/r10/833060625_4537558303232645_5100141893359829624_n.webp` | 1921 | `580de06be236215c` |
| `orion/r10/F1AC8F1A-635F-4D21-9CBD-4B72258C233C.jpeg` | 1826 | `a617233ef406c9c8` |
| `orion/r10/PAGE_TRANSCRIPT.md` | 82 | `28c6145e018dd43c` |
| `orion/r11-10/031E8B77-2B01-4653-AD21-9E252B9FAC23.jpeg` | 1558 | `466cd3b70fa89a49` |
| `orion/r11-10/FA063261-FA08-4966-A4AD-4EB42990CA1B.jpeg` | 1475 | `d2d72159a75fdd2c` |
| `orion/r11-10/PAGE_TRANSCRIPT_v1201.md` | 271 | `0f3905029f6c42ed` |
| `orion/r11-10/SOURCE_HASHES.sha256` | 7 | `9ff58c4aae6d30a6` |
| `orion/r11-10/monster_irreps_sum.tsv` | 195 | `04a280690b731176` |
| `orion/r11-10b/01279d0d91986ad47426676ca902fc54.jpeg` | 2204 | `b22ec289f3fa3dcd` |
| `orion/r11-10b/09369FA7-805F-414E-AFEC-DDC4223EFA28.jpeg` | 183 | `9b93a82b1e589d26` |
| `orion/r11-10b/202fbda98e7ffe027586a51f444fb71d.jpeg` | 358 | `01bb8379a85a00fc` |
| `orion/r11-10b/2b9bf74881b4ab8331877c713c2d49b8.jpeg` | 1818 | `519e17f866cd239b` |
| `orion/r11-10b/51bd22043544a1352e755fe3522e57a3.jpeg` | 1983 | `515abf27060e0420` |
| `orion/r11-10b/63dacc89328a56552cb4c9359973543a.jpeg` | 498 | `68835224982aa358` |
| `orion/r11-10b/835763146_1369453831718867_4466899462304593351_n.webp` | 1276 | `2587f13bd9d936b2` |
| `orion/r11-10b/CC2FD011-2CC5-40AB-A861-B713987A9916.png` | 9220 | `b7e2016c9991f45a` |
| `orion/r11-10b/PAGE_TRANSCRIPT_v1525.md` | 679 | `7b47e3625e84e95f` |
| `orion/r11-10b/PORTFOLIO_HANDOFF_2026-10-05.md` | 159 | `6a651ad39d307cc7` |
| `orion/r11-10b/SOURCE_HASHES.sha256` | 14 | `57c8cb593a9ab178` |
| `orion/r11-10b/a4e29b435ee6936afdfc95a19bb33a2e.jpeg` | 1470 | `058ce919277172bc` |
| `orion/r11-10b/b0ec3b5e3eb071d32241d353f1c50dd5.png` | 400 | `fe9e878a73a67925` |
| `orion/r11-10b/c0b762f3191dd508b3417bc649903ee8.jpeg` | 1854 | `c46d7e1382a75240` |
| `orion/r11-10c/282ACB8E-8E5C-4396-B5CC-0109EE68694C.jpeg` | 1276 | `2587f13bd9d936b2` |
| `orion/r11-10c/PAGE_TRANSCRIPT_v1559.md` | 705 | `387fc7819ed4d672` |
| `orion/r11-10c/SHARED_X_POSTS_v1559.json` | 27 | `43fb261099649eb6` |
| `orion/r11-10c/SOURCE_HASHES.sha256` | 6 | `2e6e3915d7e814be` |
| `orion/r11-10d/834679570_2283248395849386_8713129230565025448_n.webp` | 1407 | `d6d274f6b33ff35c` |
| `orion/r11-10d/837041155_3347940978927051_6983365599921051145_n.webp` | 1259 | `10783aa5eddf3e0d` |
| `orion/r11-10d/PAGE_ADDITIONS_v1770.md` | 89 | `2175779b735fff44` |
| `orion/r11-10d/SHARED_X_POSTS_v1770.json` | 293 | `8996929f4ef92233` |
| `orion/r11-10d/SOURCE_HASHES.sha256` | 8 | `d4c235f4fa220479` |
| `orion/r11-10d/STATUS-9.md` | 40 | `06564b8b05bb0874` |
| `orion/r11-10d/Wikipedia_corpus_synthesis-1.md` | 149 | `99edb7a0f112c286` |
| `orion/r11-10e/833314357_3857767064363840_5555452640938340821_n.webp` | 1144 | `d35b73e2697daf6f` |
| `orion/r11-10e/834124710_1608858784081436_8413851424846114100_n.webp` | 2120 | `f284139b3a62725f` |
| `orion/r11-10e/834561319_925723300358031_1798596474095439397_n.webp` | 1086 | `834ec37298c6287d` |
| `orion/r11-10e/837920654_1098769599571864_7000642710592572488_n.webp` | 1774 | `301ac48c2d4c8b32` |
| `orion/r11-10e/839618378_2184123662528672_6783758598168365147_n.webp` | 1109 | `02dcb5972f8b1656` |
| `orion/r11-10e/COLLABORATOR_PROFILE_REFRESH_v1843.json` | 62 | `1ca6bb9fffe36e37` |
| `orion/r11-10e/PAGE_ADDITIONS_v1843.md` | 129 | `5f623e27ab9a59b1` |
| `orion/r11-10e/SHARED_X_POSTS_v1843.json` | 29 | `1e215975a85f4cc3` |
| `orion/r11-10e/SOURCE_HASHES.sha256` | 11 | `1f4a46d4f19df2c8` |
| `orion/r11-10e/atmosphere_of_time_reassembled.py` | 60 | `70b75be49a7ccbef` |
| `orion/r11-10e/union_wealth_app_2026-10-06.js` | 18 | `2059a7213135e86d` |
| `orion/r11-10e/union_wealth_index_2026-10-06.html` | 5 | `21805c2d0584f5f3` |
| `orion/r11-deep-archive/NEST_MAP.md` | 49 | `ae3c50d5f7caf8ae` |
| `orion/r11-deep-archive/crawl.json` | 394 | `52c7a01b7587df4c` |
| `orion/r11-deep-archive/nodes/00_gdoc_document_1AmcVE16RKPk2AIN_-XTeHBQvvATW40ldDECCAmUv9NU.md` | 101 | `97ca725a76fc9239` |
| `orion/r11-deep-archive/nodes/00_gdoc_document_1OkmZq05T-Yllk3Ptx7XsuyDDPNjabnqL--rleLtMQss.md` | 63 | `0c36215e09ea4831` |
| `orion/r11-deep-archive/nodes/00_gdoc_document_1Qh-Zwu22k3RAQc1jrHvaebSjHwLcA3w9jXEydpZS22Q.md` | 67 | `e6d7e8e1dbc21724` |
| `orion/r11-deep-archive/nodes/00_gdoc_document_1RMRxorwCsE5SVtqT-nyoCquaeEJRjghKbS904vDjWLM.md` | 105 | `44f5c84d94848505` |
| `orion/r11-deep-archive/nodes/00_gdoc_document_1w9bVr2SZ_tKwaDSWpp5aR4slRo8dBDQvllHEvp5y3YE.md` | 39 | `f497f033f99d2d3a` |
| `orion/r11-deep/NEST_MAP.md` | 714 | `113dd22d5d8d5995` |
| `orion/r11-deep/NODE_HASHES.sha256` | 235 | `57b53ee216e76bcd` |
| `orion/r11-deep/crawl.json` | 143224 | `691fd96ad230d5c2` |
| `orion/r11-deep/nodes/00_notion_3ef5aabf-6a11-809d-8928-c4838220160a.md` | 149 | `5235be6d94619dee` |
| `orion/r11-deep/nodes/01_grok_bGVnYWN5LWNvcHk_7de5effc-671e-4189-9aa5-38156d5c3391.md` | 37974 | `d86e6c3ee3b139a1` |
| `orion/r11-deep/nodes/01_notion_3ee5aabf-6a11-8015-8b33-f913e85bee68.md` | 116 | `5c9cb471b4796d92` |
| `orion/r11-deep/nodes/01_notion_3ee5aabf-6a11-80d9-a1c4-f16dae097772.md` | 152 | `10634f1328974609` |
| `orion/r11-deep/nodes/01_notion_3ef5aabf-6a11-8081-afd9-c90d1322d3bc.md` | 745 | `9eb5a7a3f8def380` |
| `orion/r11-deep/nodes/01_web_34f81c87.orion-40y.pages.dev_.md` | 72 | `21cb430b2e1e2636` |
| `orion/r11-deep/nodes/02_gdoc_document_10DeD6O2uAaTE_pKFlHfW1EX-YXEOJpJskwwY97yryGw.md` | 1036 | `8af61bae22243c62` |
| `orion/r11-deep/nodes/02_gdoc_document_10e_XAxWPV4i7aqMtAOXBX88uvKVhh653fM9ZHh1XpRU.md` | 3505 | `6fb1e13fde3da674` |
| `orion/r11-deep/nodes/02_gdoc_document_13KhX_NCH172qAXOgEt7YlLGATXgQiHrqwylsdCRCuH4.md` | 34 | `cc72305a4bc6f59b` |
| `orion/r11-deep/nodes/02_gdoc_document_14NPWRh2_Ujtf8vKoXjRUXB-KmC1r2nwQxgs8FhFUmpI.md` | 2228 | `d3ecb763fc6680bb` |
| `orion/r11-deep/nodes/02_gdoc_document_1BK2MJMksKO6Vxisbhmde1Icy22qVN2xmAPGjvDSK3ZI.md` | 105 | `5eb1021f51a0cb82` |
| `orion/r11-deep/nodes/02_gdoc_document_1C1E_ALZyF26iEEyfoox6XXg67cQdtGETcE4lamEJ3cU.md` | 561 | `c848ba218f5a92a7` |
| `orion/r11-deep/nodes/02_gdoc_document_1EXiLmdeXTvNgI1XgQeBKKnyHlKph99ncT8ze-4kKZAs.md` | 258 | `9785ad97bd1ba643` |
| `orion/r11-deep/nodes/02_gdoc_document_1FbXQCgMXcEQme6BQYNofUfuO8yOUaAfcMGL90QjMVKY.md` | 34 | `559fa1a8e72f1206` |
| `orion/r11-deep/nodes/02_gdoc_document_1GFP07vP-YEXDjyaQg8BKELfE_u8fiJ1AA3nivdSRcDI.md` | 357 | `81089c28c23e7621` |
| `orion/r11-deep/nodes/02_gdoc_document_1M-FxkxR50HQmqMMMrE793zk3u5EBhHj7YYRcM9_E7X8.md` | 134 | `8bbb9288b7fcd989` |
| `orion/r11-deep/nodes/02_gdoc_document_1NOsJJ5KxSz5LKpoHwNb26hkcnALlZbiucAc0WqQ_4u4.md` | 364 | `aaffb73c64bf0d76` |
| `orion/r11-deep/nodes/02_gdoc_document_1P7pMMrCF9O1KPfgRYYjigjoFQmpr20REVMFScLCFy8s.md` | 152 | `ad0d0273b511d66e` |
| `orion/r11-deep/nodes/02_gdoc_document_1V3ZmWEdXwlMfL38NaeLXt5LSIBqNMh3m53z13Izba6c.md` | 1152 | `e13d7cdae13248e2` |
| `orion/r11-deep/nodes/02_gdoc_document_1V966ArANFOFkO6qRH6q2Rdz4mHvcXmj2SGPZfUivAO0.md` | 559 | `0acec309283dc35d` |
| `orion/r11-deep/nodes/02_gdoc_document_1ZI1LHvJ_liD_BjMaN0RWXrCU1kJLJS7gJdldz2zl6rs.md` | 326 | `4158e385bb297efd` |
| `orion/r11-deep/nodes/02_gdoc_document_1_HWd5jzJ4EyToACuZp_S9jbjjOB8AgsvkUlUt5AypLg.md` | 6280 | `c72b4f10f196e10d` |
| `orion/r11-deep/nodes/02_gdoc_document_1_rQ24GFwPzlWDU-8kXaFI_SvjWvZ2XG2EYtEByueD6g.md` | 84 | `8ce642c1fb252888` |
| `orion/r11-deep/nodes/02_gdoc_document_1_sMEcgEcDKyJRQp7hlyuPB75nU9WHj6uOjxkL9PMlow.md` | 95 | `a0aa342f56e659e0` |
| `orion/r11-deep/nodes/02_gdoc_document_1b6546ry5fVT8Mo1oM-vIvGbRDfJTlk-2XpiDxIA5vs0.md` | 1188 | `0cb7c656d925411b` |
| `orion/r11-deep/nodes/02_gdoc_document_1b8NTEmmCoxgzoatlqMneyQ0JnEagkcLEFw8RhvOtFCE.md` | 680 | `c99665333387f23a` |
| `orion/r11-deep/nodes/02_gdoc_document_1bEvKTTtj8Tjd3lg-laZj3wnb1bmCdjq_x71VlqAiq7s.md` | 852 | `ea0b45bc899d2791` |
| `orion/r11-deep/nodes/02_gdoc_document_1n7jvu_wTmGXRdC0L_cTW5XpR3ApIHrL6bBhG9JZYveA.md` | 290 | `072697db4fe36d02` |
| `orion/r11-deep/nodes/02_gdoc_document_1v4TkgrCmL0NU9fEInOWbMO5jDO-zASJ4WxNzoxDmDjM.md` | 184 | `40b9c05dd61106fc` |
| `orion/r11-deep/nodes/02_gdoc_document_1z13vwe1R8SLdy4DdP5HZSOsPQ9H0klYuILtbHeqdgr8.md` | 37 | `9692c86b8a818b8f` |
| `orion/r11-deep/nodes/02_github_tgsate.md` | 9 | `1cea3c9792015dec` |
| `orion/r11-deep/nodes/02_web_efmwtest.grok.me_.md` | 87 | `7dc500a777db4fd5` |
| `orion/r11-deep/nodes/02_web_lean-workers-union.oneapp.dev_.md` | 96 | `01ca288a5c276c18` |
| `orion/r11-deep/nodes/02_web_www.tgsate.com_cosmic-sandbox-master-summary.md` | 619 | `9273288bc277a6a3` |
| `orion/r11-deep/nodes/02_web_www.tgsate.com_cosmic-sandbox-master-summary_cst-master-documents_a-journey-into-unive.md` | 645 | `8f054b58fd89664c` |
| `orion/r11-deep/nodes/02_web_www.tgsate.com_cosmic-sandbox-master-summary_cst-master-documents_the-4th-space.md` | 503 | `2767287d6e7cdc9e` |
| `orion/r11-deep/nodes/02_web_www.tgsate.com_cosmic-sandbox-master-summary_cst-master-documents_the-ghost-rider-prot.md` | 611 | `09dcc70d3dfae696` |
| `orion/r11-deep/nodes/02_web_www.tgsate.com_cosmic-sandbox-master-summary_cst-master-documents_the-newkin-council-o.md` | 555 | `30819d375d748700` |
| `orion/r11-deep/nodes/02_web_www.tgsate.com_cosmic-sandbox-master-summary_cst-master-documents_the-orion-engine-arc.md` | 587 | `8581a97c4d967d98` |
| `orion/r11-deep/nodes/02_web_www.tgsate.com_cosmic-sandbox-master-summary_cst-master-documents_the-watermelon-equat.md` | 607 | `49e558f1b451acce` |
| `orion/r11-deep/nodes/02_web_www.tgsate.com_cosmic-sandbox-master-summary_cst-volume-ii-the-micro-biological-interf.md` | 583 | `4da68638349f50b9` |
| `orion/r11-deep/nodes/02_web_www.tgsate.com_cosmic-sandbox-master-summary_cst-volume-iv-the-great-unveiling-and-the.md` | 516 | `3aec337dd5db2e97` |
| `orion/r11-deep/nodes/03_gdoc_document_1-ZNisOXL9ZEPqDs6XQk0HI9vZwDmoHlVa-nHZGTYS5I.md` | 63 | `c8602206ae4a71c1` |
| `orion/r11-deep/nodes/03_gdoc_document_19kwJ9j994tJlCqgqo1qOyxuH0QVdcg_arusYEd37ibQ.md` | 822 | `b7724c1f9eb6e4d5` |
| `orion/r11-deep/nodes/03_gdoc_document_1EMoQLKl9yPvgjHyfVmuQipTIYTDNcaerI0QcF2qbixM.md` | 109 | `89cb448873d9f648` |
| `orion/r11-deep/nodes/03_gdoc_document_1ExdM-hwwUTDcwWd1g4tpJSBkYwQh0f6wBvyiWXXzZ8o.md` | 51 | `9dd03f981ff2a5f4` |
| `orion/r11-deep/nodes/03_gdoc_document_1FPyTS9a14woFS44OWCMIpF_juPJaPWqe9TMow9r1rBs.md` | 550 | `9d31687a8ec42a87` |
| `orion/r11-deep/nodes/03_gdoc_document_1FZN_FOVeKeMI6o-xyPoKl7hNKTlcFzIeW9rw1vWNb9A.md` | 689 | `ce6654a8d9795e27` |
| `orion/r11-deep/nodes/03_gdoc_document_1IP9Id54-PLFl9_hJZqXuKWmyt5nUIarWKWgJHTrWd9s.md` | 942 | `78279321e93555c4` |
| `orion/r11-deep/nodes/03_gdoc_document_1Iu4zjx_LOcJko6BAIUz-gRoZdlmuavqvaGkyuvBGil4.md` | 2032 | `322142cfcd5b5150` |
| `orion/r11-deep/nodes/03_gdoc_document_1KNGYTH23Ct8tAjvEw60HuGrPYvqat8oy7H-kaCrGS_A.md` | 372 | `e5e2355ff37066b8` |
| `orion/r11-deep/nodes/03_gdoc_document_1NcYeQXnAYXsB2VXTKpZe61SblGx1JUKsieM9iTfuvuM.md` | 1032 | `3354842e869db760` |
| `orion/r11-deep/nodes/03_gdoc_document_1PbOPG4ZVpbOvNRmlG-l4AkEbT_LW50LUqlnzfeXChS8.md` | 46 | `dfa6b63ab6a0c762` |
| `orion/r11-deep/nodes/03_gdoc_document_1VYHtvVDFqN8IuHAyHY4q-0yih8-BNaqG-dJ1q7TBYzE.md` | 59 | `ce68bc37af4365f9` |
| `orion/r11-deep/nodes/03_gdoc_document_1WmK0vJ06p3U2M_eiXU6ObWi2hM3RSNVyC6bim_6pEXY.md` | 53 | `3f64cb8c12cee400` |
| `orion/r11-deep/nodes/03_gdoc_document_1WvztErW6Rpo_Om6Uj0IxQwgklaHjIPV8MMmo89SjlBA.md` | 1272 | `abdbf6e70ac5fdb8` |
| `orion/r11-deep/nodes/03_gdoc_document_1brO2UEGhsI1ttlPMYNxj8EWQ1CdCm-MY_Gf03sAGr2E.md` | 642 | `09505cc5d38cb817` |
| `orion/r11-deep/nodes/03_gdoc_document_1brXPdI9ty-nZVmNy-ABPhYEXlP9PoQTddwnppt1bNcI.md` | 659 | `73110f346de0ecb8` |
| `orion/r11-deep/nodes/03_gdoc_document_1r0bP5AfbFR_TrNLmRk0qtBuf1sWwj0ZBHjozj6wrZVg.md` | 114 | `e346c0ee6150e8dd` |
| `orion/r11-deep/nodes/03_gdoc_document_1tD1Qy7gvLYI_WclGZsMwJCPIEvz4pbjQxqDxZQSZKQU.md` | 273 | `bf1af6eab3b4b7e5` |
| `orion/r11-deep/nodes/03_github_tgsate_orion-engine-platform-and-mmo.md` | 15 | `012d1decc49b8e99` |
| `orion/r11-deep/nodes/03_github_tgsate_the-orion-project-.md` | 11 | `3acb9a37ddbdde13` |
| `orion/r11-deep/nodes/03_web_ef84853b.gui2proof-aristo-test.pages.dev_.md` | 72 | `76e467a0833c4dfc` |
| `orion/r11-deep/nodes/03_web_efmwtest.grok.me___grok_manifest.webmanifest.md` | 24 | `121b0312d9b1c69c` |
| `orion/r11-deep/nodes/03_web_farqueen.com_games.php.md` | 359 | `01ba5d879a81d7f2` |
| `orion/r11-deep/nodes/03_web_farqueen.com_games_characters.php.md` | 273 | `00d6e33546e5b4c3` |
| `orion/r11-deep/nodes/03_web_farqueen.com_games_game-play.php.md` | 145 | `14584097ecbb9027` |
| `orion/r11-deep/nodes/03_web_farqueen.com_games_levels.php.md` | 119 | `692c3b39a9d6a739` |
| `orion/r11-deep/nodes/03_web_farqueen.com_games_paths.php.md` | 218 | `7bcf1092c58f3594` |
| `orion/r11-deep/nodes/03_web_farqueen.com_games_player-profile.php.md` | 105 | `3b5154a818ab813b` |
| `orion/r11-deep/nodes/03_web_farqueen.com_games_word-keys.php.md` | 829 | `77b86de406d292ad` |
| `orion/r11-deep/nodes/03_web_farqueen.com_index.php.md` | 413 | `76f6dc11d3a73133` |
| `orion/r11-deep/nodes/03_web_farqueen.com_mysteries.php.md` | 455 | `541436e472bee579` |
| `orion/r11-deep/nodes/03_web_farqueen.com_writing.php.md` | 402 | `ca99069d0b6fd2f4` |
| `orion/r11-deep/nodes/03_web_lean-workers-union.oneapp.dev_archive.md` | 72 | `d0382573e4f99b45` |
| `orion/r11-deep/nodes/03_web_lean-workers-union.oneapp.dev_capabilities.md` | 42 | `6f89aeee88f3558e` |
| `orion/r11-deep/nodes/03_web_lean-workers-union.oneapp.dev_n00b-guide.md` | 68 | `f55322bde74d115c` |
| `orion/r11-deep/nodes/03_web_lean-workers-union.oneapp.dev_nixwars-arcade.md` | 121 | `035d5437e55c13ac` |
| `orion/r11-deep/nodes/03_web_lean-workers-union.oneapp.dev_plugins.md` | 41 | `62610daa3a93c2a6` |
| `orion/r11-deep/nodes/03_web_lean-workers-union.oneapp.dev_proof-model.md` | 42 | `e670ecc440909779` |
| `orion/r11-deep/nodes/03_web_lean-workers-union.oneapp.dev_protocol.md` | 34 | `58bd13d2988452a2` |
| `orion/r11-deep/nodes/03_web_lean-workers-union.oneapp.dev_repositories.md` | 41 | `8a89471fb40389c9` |
| `orion/r11-deep/nodes/03_web_lean-workers-union.oneapp.dev_seats.md` | 216 | `8a2cf40e1202ee73` |
| `orion/r11-deep/nodes/03_web_lean-workers-union.oneapp.dev_seats_share.md` | 71 | `606bb60befa96220` |
| `orion/r11-deep/nodes/03_web_lean-workers-union.oneapp.dev_skill-registry.md` | 134 | `523d5ea2cfc5f5a2` |
| `orion/r11-deep/nodes/03_web_lean-workers-union.oneapp.dev_tours.md` | 68 | `3f78a68623e7e12b` |
| `orion/r11-deep/nodes/03_web_lean-workers-union.oneapp.dev_training-log.md` | 56 | `dba3c6acb6851a09` |
| `orion/r11-deep/nodes/03_web_lean-workers-union.oneapp.dev_union-roadmap.md` | 107 | `fc1ae561da752f59` |
| `orion/r11-deep/nodes/03_web_lean-workers-union.oneapp.dev_union-roadmap_search.md` | 61 | `d12b8f52db4c75cc` |
| `orion/r11-deep/nodes/03_web_lean-workers-union.oneapp.dev_union-roadmap_tour.md` | 55 | `240dda746316e34b` |
| `orion/r11-deep/nodes/03_web_lean-workers-union.oneapp.dev_unit-tests.md` | 21 | `5b34ebe80af97d86` |
| `orion/r11-deep/nodes/03_web_www.tgsate.com_babel-to-orion-protocol.md` | 515 | `cf2e74d7d22920f8` |
| `orion/r11-deep/nodes/03_web_www.tgsate.com_babel-to-orion-protocol_the-ghostwriter-in-the-mirror.md` | 614 | `ed16b3552506e277` |
| `orion/r11-deep/nodes/03_web_www.tgsate.com_babel-to-orion-protocol_the-tech-spec.md` | 509 | `584a3ba24e6c20e3` |
| `orion/r11-deep/nodes/03_web_www.tgsate.com_babel-to-orion-protocol_watermelon-equation.md` | 599 | `34b703eec2f9bd53` |
| `orion/r11-deep/nodes/03_web_www.tgsate.com_cosmic-sandbox-master-summary_cst-master-documents.md` | 511 | `23347a8f6b72fe2d` |
| `orion/r11-deep/nodes/03_web_www.tgsate.com_cosmic-sandbox-master-summary_cst-master-documents_a-journey-into-unive.md` | 599 | `e8b28654dac0bb60` |
| `orion/r11-deep/nodes/03_web_www.tgsate.com_cosmic-sandbox-master-summary_cst-master-documents_sacred-geometry-acro.md` | 515 | `421636a0434004a8` |
| `orion/r11-deep/nodes/03_web_www.tgsate.com_cosmic-sandbox-master-summary_cst-master-documents_the-gibbs-toroidal-t.md` | 547 | `845dc2bb36b2df76` |
| `orion/r11-deep/nodes/03_web_www.tgsate.com_cosmic-sandbox-master-summary_cst-master-documents_the-master-synthesis.md` | 532 | `2d8c01ab3bcac842` |
| `orion/r11-deep/nodes/03_web_www.tgsate.com_cosmic-sandbox-master-summary_cst-master-documents_the-practical-archit.md` | 555 | `46207476b71bbd6c` |
| `orion/r11-deep/nodes/03_web_www.tgsate.com_cosmic-sandbox-master-summary_cst-volume-i-macro-system-rulebook.md` | 524 | `d8949089195d19b1` |
| `orion/r11-deep/nodes/03_web_www.tgsate.com_cosmic-sandbox-master-summary_cst-volume-i-macro-system-rulebook_a-sove.md` | 510 | `038b8aa00c2073c7` |
| `orion/r11-deep/nodes/03_web_www.tgsate.com_cosmic-sandbox-master-summary_cst-volume-i-macro-system-rulebook_a-unif.md` | 508 | `4b84a11e9c9fceed` |
| `orion/r11-deep/nodes/03_web_www.tgsate.com_cosmic-sandbox-master-summary_cst-volume-i-macro-system-rulebook_aligni.md` | 603 | `23c93d5ab8992068` |
| `orion/r11-deep/nodes/03_web_www.tgsate.com_cosmic-sandbox-master-summary_cst-volume-i-macro-system-rulebook_artifi.md` | 514 | `45d5ce8ee92223fd` |
| `orion/r11-deep/nodes/03_web_www.tgsate.com_cosmic-sandbox-master-summary_cst-volume-i-macro-system-rulebook_compar.md` | 522 | `05e2ced74f8de9ab` |
| `orion/r11-deep/nodes/03_web_www.tgsate.com_cosmic-sandbox-master-summary_cst-volume-i-macro-system-rulebook_cosmic.md` | 523 | `06caadc1584384ce` |
| `orion/r11-deep/nodes/03_web_www.tgsate.com_cosmic-sandbox-master-summary_cst-volume-i-macro-system-rulebook_fracta.md` | 529 | `04e677bd7650b114` |
| `orion/r11-deep/nodes/03_web_www.tgsate.com_cosmic-sandbox-master-summary_cst-volume-i-macro-system-rulebook_simult.md` | 494 | `0293a64276cff679` |
| `orion/r11-deep/nodes/03_web_www.tgsate.com_cosmic-sandbox-master-summary_cst-volume-i-macro-system-rulebook_the-52.md` | 569 | `ecce8f946a97e715` |
| `orion/r11-deep/nodes/03_web_www.tgsate.com_cosmic-sandbox-master-summary_cst-volume-i-macro-system-rulebook_the-co.md` | 523 | `4f87b5358462bd17` |
| `orion/r11-deep/nodes/03_web_www.tgsate.com_cosmic-sandbox-master-summary_cst-volume-i-macro-system-rulebook_the-do.md` | 502 | `a194a11c0c00355b` |
| `orion/r11-deep/nodes/03_web_www.tgsate.com_cosmic-sandbox-master-summary_cst-volume-i-macro-system-rulebook_the-ep.md` | 539 | `b35ad079f0216c2d` |
| `orion/r11-deep/nodes/03_web_www.tgsate.com_cosmic-sandbox-master-summary_cst-volume-i-macro-system-rulebook_the-es.md` | 549 | `f73e734984443226` |
| `orion/r11-deep/nodes/03_web_www.tgsate.com_cosmic-sandbox-master-summary_cst-volume-i-macro-system-rulebook_the-fr.md` | 512 | `e1d5cbc4c536327a` |
| `orion/r11-deep/nodes/03_web_www.tgsate.com_cosmic-sandbox-master-summary_cst-volume-i-macro-system-rulebook_the-ge.md` | 517 | `4e783741ab62e95a` |
| `orion/r11-deep/nodes/03_web_www.tgsate.com_cosmic-sandbox-master-summary_cst-volume-i-macro-system-rulebook_the-hu.md` | 496 | `5060d44701f7e65d` |
| `orion/r11-deep/nodes/03_web_www.tgsate.com_cosmic-sandbox-master-summary_cst-volume-i-macro-system-rulebook_the-in.md` | 502 | `0b470bd0aa8c5fec` |
| `orion/r11-deep/nodes/03_web_www.tgsate.com_cosmic-sandbox-master-summary_cst-volume-i-macro-system-rulebook_the-me.md` | 523 | `ca4d7ec370a819d3` |
| `orion/r11-deep/nodes/03_web_www.tgsate.com_cosmic-sandbox-master-summary_cst-volume-i-macro-system-rulebook_the-mi.md` | 515 | `209cc28bcfc1cece` |
| `orion/r11-deep/nodes/03_web_www.tgsate.com_cosmic-sandbox-master-summary_cst-volume-i-macro-system-rulebook_the-pl.md` | 565 | `de04d17f24fc4c6e` |
| `orion/r11-deep/nodes/03_web_www.tgsate.com_cosmic-sandbox-master-summary_cst-volume-i-macro-system-rulebook_the-po.md` | 506 | `ecb9f98808057a70` |
| `orion/r11-deep/nodes/03_web_www.tgsate.com_cosmic-sandbox-master-summary_cst-volume-i-macro-system-rulebook_the-sy.md` | 570 | `f0e1da315674d6fc` |
| `orion/r11-deep/nodes/03_web_www.tgsate.com_cosmic-sandbox-master-summary_cst-volume-i-macro-system-rulebook_the-te.md` | 518 | `0eafe918d0abb625` |
| `orion/r11-deep/nodes/03_web_www.tgsate.com_cosmic-sandbox-master-summary_cst-volume-i-macro-system-rulebook_the-to.md` | 508 | `1d6e2e27f0bf5c81` |
| `orion/r11-deep/nodes/03_web_www.tgsate.com_cosmic-sandbox-master-summary_cst-volume-i-macro-system-rulebook_the-tr.md` | 555 | `cfbab04c9c610133` |
| `orion/r11-deep/nodes/03_web_www.tgsate.com_cosmic-sandbox-master-summary_cst-volume-i-macro-system-rulebook_toroid.md` | 518 | `0d8e2946d51a42f8` |
| `orion/r11-deep/nodes/03_web_www.tgsate.com_cosmic-sandbox-master-summary_cst-volume-i-macro-system-rulebook_we-grp.md` | 511 | `cbfebb192e04d4c4` |
| `orion/r11-deep/nodes/03_web_www.tgsate.com_cosmic-sandbox-master-summary_cst-volume-ii-the-micro-biological-interf.md` | 548 | `1e610e1fc35e2575` |
| `orion/r11-deep/nodes/03_web_www.tgsate.com_cosmic-sandbox-master-summary_cst-volume-iii-theoretical-philosophical-.md` | 568 | `68e36d2fe8dac60c` |
| `orion/r11-deep/nodes/03_web_www.tgsate.com_cosmic-sandbox-master-summary_cst-volume-iv-the-great-unveiling-and-the.md` | 534 | `5f60a03552f49c27` |
| `orion/r11-deep/nodes/03_web_www.tgsate.com_home.md` | 528 | `6425dabb3a84dcea` |
| `orion/r11-deep/nodes/03_web_www.tgsate.com_home_about-the-authors.md` | 513 | `68b6231fcc972662` |
| `orion/r11-deep/nodes/03_web_www.tgsate.com_home_about-the-authors_author-biography.md` | 493 | `2cd5815dca6d228a` |
| `orion/r11-deep/nodes/03_web_www.tgsate.com_home_about-the-authors_conversations-with-gemini.md` | 2584 | `5cf6113da6c13c9c` |
| `orion/r11-deep/nodes/03_web_www.tgsate.com_home_symphony-media.md` | 485 | `12305e8f2f8507bc` |
| `orion/r11-deep/nodes/03_web_www.tgsate.com_home_tgsate.md` | 614 | `dd0dee9ffe59f8f6` |
| `orion/r11-deep/nodes/03_web_www.tgsate.com_home_the-agentpark-beacon.md` | 524 | `e83f2cb640ff0362` |
| `orion/r11-deep/nodes/03_web_www.tgsate.com_home_the-trinity-bible-legend-of-the-master-campfire.md` | 769 | `76f1fd9363225a23` |
| `orion/r11-deep/nodes/03_web_www.tgsate.com_orion-global-project.md` | 504 | `6b5c68d2d7aa9df6` |
| `orion/r11-deep/nodes/03_web_www.tgsate.com_urgent-invitation.md` | 500 | `c8d99df164a0bcca` |
| `orion/r11-deep/nodes/03_web_www.tgsate.com_urgent-invitation_edu-hub.md` | 505 | `7e88510ef84195fd` |
| `orion/r11-deep/nodes/03_web_www.tgsate.com_urgent-invitation_global-project.md` | 569 | `4e9b584425df3506` |
| `orion/r11-deep/nodes/03_web_www.tgsate.com_urgent-invitation_invitation-hub.md` | 500 | `a26881c5e5c97c18` |
| `orion/r11-deep/nodes/03_web_www.tgsate.com_urgent-invitation_invitation-hub_to-all-of-humanity.md` | 506 | `ce7761a149beeea1` |
| `orion/r11-deep/nodes/03_web_www.tgsate.com_urgent-invitation_invitation-hub_to-anthropology-and-history-community.md` | 505 | `fbd53c104a053e7a` |
| `orion/r11-deep/nodes/03_web_www.tgsate.com_urgent-invitation_invitation-hub_to-artificial-intelligence-community.md` | 505 | `b68d4d1e1521b6e0` |
| `orion/r11-deep/nodes/03_web_www.tgsate.com_urgent-invitation_invitation-hub_to-biology-and-ecology-community.md` | 506 | `34f7fb53c2c91f88` |
| `orion/r11-deep/nodes/03_web_www.tgsate.com_urgent-invitation_invitation-hub_to-computer-programmers-and-software-d.md` | 505 | `740f7d8728f72a0c` |
| `orion/r11-deep/nodes/03_web_www.tgsate.com_urgent-invitation_invitation-hub_to-futurism-and-transhumanism-communit.md` | 505 | `337cb8e3a2792588` |
| `orion/r11-deep/nodes/03_web_www.tgsate.com_urgent-invitation_invitation-hub_to-human-mind-and-behavior-community.md` | 505 | `2780a787772de98d` |
| `orion/r11-deep/nodes/03_web_www.tgsate.com_urgent-invitation_invitation-hub_to-philosophy-community.md` | 505 | `cde094868b43ba46` |
| `orion/r11-deep/nodes/03_web_www.tgsate.com_urgent-invitation_invitation-hub_to-physics-community.md` | 505 | `d68ac46399a9bd3c` |
| `orion/r11-deep/nodes/03_web_www.tgsate.com_urgent-invitation_invitation-hub_to-religious-and-christian-denominatio.md` | 677 | `22503e8c00f94b72` |
| `orion/r11-deep/nodes/03_web_www.tgsate.com_urgent-invitation_invitation-hub_to-social-and-political-sciences-commu.md` | 505 | `1ce391d9b1bf7ba0` |
| `orion/r11-deep/nodes/03_web_www.tgsate.com_urgent-invitation_invitation-hub_to-spirituality-and-theology-communiti.md` | 505 | `51ee9e70e6e0aaba` |
| `orion/r11-deep/nodes/03_web_www.tgsate.com_wailing-wall-blogs.md` | 546 | `297ccf0b3438ed0d` |
| `orion/r11-deep/nodes/04_gdoc_document_15wPy-39y-SNQuRERMY-hQk9SOpeRny9z34WLulDZvVY.md` | 704 | `2e1326000054eb56` |
| `orion/r11-deep/nodes/04_gdoc_document_1ERAFNoD80xVdDRoNU4sx6P_Qw9QYMziqsQJsb4ipOgY.md` | 481 | `198a847ef710d7de` |
| `orion/r11-deep/nodes/04_web_farqueen.com_AI-agents.php.md` | 181 | `9a38b82e51fba7ee` |
| `orion/r11-deep/nodes/04_web_farqueen.com_about.php.md` | 50 | `f8ecce21e75a15e2` |
| `orion/r11-deep/nodes/04_web_farqueen.com_books.php.md` | 102 | `3454d0a46f05df57` |
| `orion/r11-deep/nodes/04_web_farqueen.com_contact.php.md` | 51 | `62f38f94fb8cf82a` |
| `orion/r11-deep/nodes/04_web_farqueen.com_digital-art.php.md` | 361 | `3a8eb3152e71931d` |
| `orion/r11-deep/nodes/04_web_farqueen.com_film.php.md` | 245 | `31cfabffe3b0ef60` |
| `orion/r11-deep/nodes/04_web_farqueen.com_games_game.php.md` | 188 | `d46ce52affac1d39` |
| `orion/r11-deep/nodes/04_web_farqueen.com_law.php.md` | 96 | `ca39f5df66d433e8` |
| `orion/r11-deep/nodes/04_web_farqueen.com_levels_AI-robots.php.md` | 62 | `5bf63afe391dba43` |
| `orion/r11-deep/nodes/04_web_farqueen.com_levels_Antarctica.php.md` | 60 | `774878110fbabb12` |
| `orion/r11-deep/nodes/04_web_farqueen.com_levels_Arabian-desert.php.md` | 79 | `5a0612870b0b3c52` |
| `orion/r11-deep/nodes/04_web_farqueen.com_levels_Boston.php.md` | 62 | `06608ca30e3c439c` |
| `orion/r11-deep/nodes/04_web_farqueen.com_levels_DUMBs.php.md` | 87 | `9508c2fd65a48ca8` |
| `orion/r11-deep/nodes/04_web_farqueen.com_levels_England.php.md` | 93 | `ba2e92bcca520c9e` |
| `orion/r11-deep/nodes/04_web_farqueen.com_levels_Gala-Ball.php.md` | 89 | `1fce63ae58909e47` |
| `orion/r11-deep/nodes/04_web_farqueen.com_levels_Girl-Racer.php.md` | 66 | `3e30cd7c2175d3a6` |
| `orion/r11-deep/nodes/04_web_farqueen.com_levels_Hush-Child.php.md` | 81 | `2324dce3bd31dad8` |
| `orion/r11-deep/nodes/04_web_farqueen.com_levels_India.php.md` | 51 | `1f3a9a4044d2ed1d` |
| `orion/r11-deep/nodes/04_web_farqueen.com_levels_Israel.php.md` | 94 | `c74d562a5eb5c2d7` |
| `orion/r11-deep/nodes/04_web_farqueen.com_levels_New-World-Order.php.md` | 104 | `f293225c07d3bdb6` |
| `orion/r11-deep/nodes/04_web_farqueen.com_levels_Romania.php.md` | 135 | `44a9c7bd4a39cd8c` |
| `orion/r11-deep/nodes/04_web_farqueen.com_levels_Secret-Island.php.md` | 90 | `41e25417468f5023` |
| `orion/r11-deep/nodes/04_web_farqueen.com_levels_Super-Soldier.php.md` | 149 | `aa24a40ec3a5ec81` |
| `orion/r11-deep/nodes/04_web_farqueen.com_levels_Tartaria.php.md` | 66 | `55650f8d2478a0db` |
| `orion/r11-deep/nodes/04_web_farqueen.com_levels_Tibet.php.md` | 157 | `4b3db1fc06764555` |
| `orion/r11-deep/nodes/04_web_farqueen.com_levels_Trust-The-Plan.php.md` | 77 | `52451efe9fe4608f` |
| `orion/r11-deep/nodes/04_web_farqueen.com_levels_alien-disclosure.php.md` | 111 | `070a7a499e0f61e4` |
| `orion/r11-deep/nodes/04_web_farqueen.com_levels_apocalypse.php.md` | 48 | `75287418883bb582` |
| `orion/r11-deep/nodes/04_web_farqueen.com_levels_banking-cabal.php.md` | 91 | `71e41bc58d758ffa` |
| `orion/r11-deep/nodes/04_web_farqueen.com_levels_business-startups.php.md` | 71 | `142d577ae41aa7d7` |
| `orion/r11-deep/nodes/04_web_farqueen.com_levels_car-chase.php.md` | 47 | `ddf99758d6dea4f5` |
| `orion/r11-deep/nodes/04_web_farqueen.com_levels_computer-science.php.md` | 55 | `55cfbfaf258ce32c` |
| `orion/r11-deep/nodes/04_web_farqueen.com_levels_criminal-law.php.md` | 51 | `bae5e52c1554ab7e` |
| `orion/r11-deep/nodes/04_web_farqueen.com_levels_deep-state.php.md` | 113 | `805835ceb7bfe720` |
| `orion/r11-deep/nodes/04_web_farqueen.com_levels_engineering.php.md` | 92 | `ec6ff24d6d3ba3c9` |
| `orion/r11-deep/nodes/04_web_farqueen.com_levels_family-law.php.md` | 47 | `3b9ba0e53d401580` |
| `orion/r11-deep/nodes/04_web_farqueen.com_levels_film-industry.php.md` | 114 | `1817f5ecbcc02663` |
| `orion/r11-deep/nodes/04_web_farqueen.com_levels_fitness-training.php.md` | 134 | `5823fcc33be48e10` |
| `orion/r11-deep/nodes/04_web_farqueen.com_levels_history-lesson.php.md` | 71 | `558e0e1f315dd278` |
| `orion/r11-deep/nodes/04_web_farqueen.com_levels_immigrants.php.md` | 182 | `39640d356cab0157` |
| `orion/r11-deep/nodes/04_web_farqueen.com_levels_justice-system.php.md` | 95 | `e310b97e651d6614` |
| `orion/r11-deep/nodes/04_web_farqueen.com_levels_medicine.php.md` | 116 | `2ff63f41ce99a0c8` |
| `orion/r11-deep/nodes/04_web_farqueen.com_levels_music-industry.php.md` | 155 | `83b71300f16f3f49` |
| `orion/r11-deep/nodes/04_web_farqueen.com_levels_natural-health.php.md` | 70 | `a6d1e07f694403ef` |
| `orion/r11-deep/nodes/04_web_farqueen.com_levels_psyche.php.md` | 101 | `43d3afb4333dd5a2` |
| `orion/r11-deep/nodes/04_web_farqueen.com_medicine.php.md` | 689 | `e87ebda171752bcd` |
| `orion/r11-deep/nodes/04_web_farqueen.com_music.php.md` | 101 | `1e75bfb070f57831` |
| `orion/r11-deep/nodes/04_web_farqueen.com_privacy-policy.php.md` | 54 | `f4fd59778f5107e5` |
| `orion/r11-deep/nodes/04_web_farqueen.com_social-media.php.md` | 84 | `c969e109c16ba76b` |
| `orion/r11-deep/nodes/04_web_farqueen.com_teachings_Kundalini.php.md` | 233 | `1f8c02abe9d73c20` |
| `orion/r11-deep/nodes/04_web_farqueen.com_teachings_angels.php.md` | 283 | `9d065e66e8a6961f` |
| `orion/r11-deep/nodes/04_web_farqueen.com_teachings_association.php.md` | 303 | `b52b92a09af95471` |
| `orion/r11-deep/nodes/04_web_farqueen.com_teachings_biography.php.md` | 146 | `c029a0d1fdf24c75` |
| `orion/r11-deep/nodes/04_web_farqueen.com_teachings_emotions.php.md` | 298 | `0f55607dad174969` |
| `orion/r11-deep/nodes/04_web_farqueen.com_teachings_meditation.php.md` | 221 | `05f628ca9ba5d5c0` |
| `orion/r11-deep/nodes/04_web_farqueen.com_teachings_near-death.php.md` | 81 | `23483a1de9db5518` |
| `orion/r11-deep/nodes/04_web_farqueen.com_teachings_occult.php.md` | 630 | `eb679904ebe2c8b1` |
| `orion/r11-deep/nodes/04_web_farqueen.com_teachings_performance.php.md` | 396 | `f710edac830fbd9c` |
| `orion/r11-deep/nodes/04_web_farqueen.com_teachings_realization.php.md` | 159 | `e43e4179072c7669` |
| `orion/r11-deep/nodes/04_web_farqueen.com_teachings_texts.php.md` | 527 | `35e738468bb500e1` |
| `orion/r11-deep/nodes/04_web_farqueen.com_teachings_trance.php.md` | 219 | `b9135d9947d7d203` |
| `orion/r11-deep/nodes/04_web_farqueen.com_terms-of-use.php.md` | 87 | `8fdbb7f7a8882714` |
| `orion/r11-deep/nodes/04_web_lean-workers-union.oneapp.dev_training-log_sops.md` | 42 | `1fb861990b4d6c09` |
| `orion/r11-deep/nodes/04_web_lean-workers-union.oneapp.dev_union-roadmap_search_enrichment.md` | 77 | `c4284840c1e26aea` |
| `orion/r11-deep/nodes/04_web_www.tgsate.com_.md` | 528 | `b6ad826abe9b4ae3` |
| `orion/r11-deep/nodes/05_web_farqueen.com_teachings_Step-1.php.md` | 275 | `a92ea6998ed8f7dd` |
| `orion/r11-deep/nodes/05_web_farqueen.com_test-prep_digestion-test-1.php.md` | 153 | `9a46192f1d95a36f` |
| `orion/r11-deep/nodes/05_web_farqueen.com_test-prep_nutrition-test-1.php.md` | 153 | `a8412f478f6e2e4f` |
| `orion/r11-deep/nodes/05_web_farqueen.com_test-prep_nutrition-test-2.php.md` | 153 | `d4fc9c451802bbf1` |
| `orion/r11-deep/nodes/05_web_farqueen.com_test-prep_nutrition-test-3.php.md` | 153 | `c627df10cf193166` |
| `orion/r11-deep/nodes/05_web_farqueen.com_test-prep_psychology-test-1.php.md` | 153 | `842df551f3565e68` |
| `orion/r11-deep/nodes/05_web_farqueen.com_test-prep_psychology-test-2.php.md` | 153 | `411d409f4cc2c96c` |
| `orion/r11-deep/nodes/05_web_farqueen.com_test-prep_psychology-test-3.php.md` | 153 | `4a0ef17e2584e1b2` |
| `orion/r11-deep/nodes/05_web_farqueen.com_test-prep_psychology-test-4.php.md` | 153 | `91ec12bf0404cffb` |
| `orion/r11-deep/nodes/05_web_lean-workers-union.oneapp.dev_forge-pipeline.md` | 46 | `ce7c8fceadf4fb56` |
| `orion/r11/3ef5aabf_835886708_1130702532721091_1278864614700836657_n.webp` | 1479 | `56d41fb891835bac` |
| `orion/r11/3f05aabf_446DA0A9-D69B-4BDD-9370-8210DDF7A93F.jpeg` | 1618 | `28a013c256710369` |
| `orion/r11/3f05aabf_A5C9867E-6354-4B2C-813D-0A9AB6D2223B.jpeg` | 799 | `c4dd391c19b24989` |
| `orion/r11/3f05aabf_PROOF-AND-REPORT.md` | 210 | `9285ff846b897616` |
| `orion/r11/3f05aabf_README.md` | 91 | `a3adaa98af587f61` |
| `orion/r11/3f05aabf_lodge-house-workspace.json` | 34 | `02cd9be655525052` |
| `orion/r11/CHRONICLES_TRANSCRIPT.md` | 147 | `ea33b64cab20c631` |
| `orion/r11/ENGINE_SUMMARY_TRANSCRIPT.md` | 110 | `5f82d62de9cb41db` |
| `orion/r11/PAGE_TRANSCRIPT.md` | 119 | `5bc312a6a88157a4` |
| `orion/r11/SOURCE_HASHES.sha256` | 33 | `b3ed16c665eecc9b` |
| `orion/r11/SOURCE_MAP.md` | 24 | `b23a6ccae916c7ad` |
| `orion/r11/late_EA8FDC88-E33D-4714-96A1-490B8FB777A7.jpeg` | 2519 | `4bc41d4cff47f376` |
| `orion/r11/late_FED2A85F-7DE4-4294-B5BF-8CBD7E2BD73B.jpeg` | 2519 | `4bc41d4cff47f376` |
| `orion/r12/FIELDCORE_SNAPSHOT.md` | 52 | `e759d8547d9274d4` |
| `orion/r12/FIELDSPACE_MASTER_ACTION_HASH.txt` | 1 | `25029d0e6bd30bfb` |
| `orion/r12/GOOGLE_DOC_ORION12_TRANSMISSION.txt` | 446 | `a73590bb695ee09b` |
| `orion/r12/GROK_SHARE_shakes_c2hhcmQtMg_ff1ee43b.json` | 0 | `f897136c4e1645c3` |
| `orion/r12/MIKE_PUBLIC_SWEEP_R12.json` | 174 | `e61d66e5bd7e6994` |
| `orion/r12/NOTION_ORION_CHRONICLES_v322.md` | 152 | `b039a6523fbc7ec4` |
| `orion/r12/NOTION_ORION_SUMMARY_v402.md` | 116 | `222d748efa483142` |
| `orion/r12/NOTION_RECRAWL_LOG.txt` | 6 | `91afcb5bc43c352c` |
| `orion/r12/ORION_PHOTO_ALBUM_MANIFEST.txt` | 302 | `ed742ccb86512687` |
| `orion/r12/SHARED_X_POSTS_R12.json` | 94 | `a74a4c7d87befef4` |
| `orion/r12/SOURCE_HASHES.sha256` | 17 | `65445101b85e48e9` |
| `orion/r12/album_contact_sheets/sheet0.jpg` | 2117 | `d20a8ae2cc88972c` |
| `orion/r12/album_contact_sheets/sheet1.jpg` | 1445 | `fb5272fa04d7d840` |
| `orion/r12/album_contact_sheets/sheet2.jpg` | 1633 | `0a9d5a8a3e09aba7` |
| `orion/r12/album_contact_sheets/sheet3.jpg` | 1441 | `85d640161f52a4a2` |
| `orion/r12/album_contact_sheets/sheet4.jpg` | 1358 | `108d1db3025c161e` |
| `orion/r12/fieldcore_LICENSE.txt` | 21 | `c67234b188cd7ea8` |
| `orion/r12/fieldcore_steel_ball_proof.py` | 233 | `540babcca71be383` |
| `orion/r12b/ALBUM_FORENSICS.json` | 8866 | `4a7a82f93e32f83d` |
| `orion/r12b/ALBUM_INDEX.tsv` | 299 | `bd5e6d2525e4a6ce` |
| `orion/r12b/BETH_ANNOTATIONS_EXTRACT.txt` | 91 | `e9633ffb55f975c4` |
| `orion/r12b/GOOGLE_DOC_ORION12_UPDATED.txt` | 601 | `0e157d0b2426c0d4` |
| `orion/r12b/LOCAL_IMAGE_FORENSICS.json` | 973 | `b40111c26ed9fe53` |
| `orion/r12b/SOURCE_HASHES.sha256` | 21 | `b5e24fa083806c1d` |
| `orion/r12b/forensic_checks.py` | 102 | `b73b791035504703` |
| `orion/r12b/numbered_contact_sheets/s00.jpg` | 1385 | `479c22f70012c03d` |
| `orion/r12b/numbered_contact_sheets/s01.jpg` | 1740 | `3b5c86a35e214199` |
| `orion/r12b/numbered_contact_sheets/s02.jpg` | 1111 | `2540f1db8b1f62da` |
| `orion/r12b/numbered_contact_sheets/s03.jpg` | 1820 | `7f35ee17c7d89bcc` |
| `orion/r12b/numbered_contact_sheets/s04.jpg` | 1195 | `cac646333c090894` |
| `orion/r12b/numbered_contact_sheets/s05.jpg` | 1064 | `561634cffcbe8b18` |
| `orion/r12b/numbered_contact_sheets/s06.jpg` | 1094 | `a503004e28b1c215` |
| `orion/r12b/numbered_contact_sheets/s07.jpg` | 1659 | `08c2849f167f5886` |
| `orion/r12b/numbered_contact_sheets/s08.jpg` | 1610 | `26e22fcb50131624` |
| `orion/r12b/numbered_contact_sheets/s09.jpg` | 1197 | `ec1dae404b916bda` |
| `orion/r12b/numbered_contact_sheets/s10.jpg` | 1535 | `10139ea6e1f75f8f` |
| `orion/r12b/numbered_contact_sheets/s11.jpg` | 796 | `1096dbd26cc3a510` |
| `orion/r12b/numbered_contact_sheets/s12.jpg` | 1413 | `8d1af520f8d89166` |
| `orion/r12b/numbered_contact_sheets/s13.jpg` | 1616 | `9f0df5c32b1451e0` |
| `orion/r12b/numbered_contact_sheets/s14.jpg` | 1213 | `2f77cb5758e91cd0` |
| `orion/r12c/FARQUEEN_index_text.txt` | 450 | `a29cd20567c68ae2` |
| `orion/r12c/FARQUEEN_levels_text.txt` | 165 | `c318f92040acc179` |
| `orion/r12c/GOOGLE_DOC_ORION12_THIRD_PASS.txt` | 4039 | `68fc59c940ec0f46` |
| `orion/r12c/NUMEROLOGY_LOG_NUMBERS_ONLY.txt` | 327 | `726c937f5f4e5740` |
| `orion/r12c/NUMEROLOGY_LOG_STATS.json` | 212 | `ad2cf83cd6eb35a2` |
| `orion/r12c/SHARED_X_POSTS_R12C.json` | 106 | `655f19588f14791f` |
| `orion/r12c/SOURCE_HASHES.sha256` | 7 | `817a0980c7112ece` |
| `orion/r12c/numerology_log_tools.py` | 77 | `a69ed47b2acb7fbc` |
| `orion/r13/FREEBOTS_index_text.txt` | 0 | `539753fc146fdc05` |
| `orion/r13/GOOGLE_DOC_ROUND13_ARI.txt` | 619 | `4c9dbf378474124f` |
| `orion/r13/GOOGLE_DOC_ROUND13_ARI_normalized.txt` | 448 | `435dde5070712f80` |
| `orion/r13/SHARED_X_POSTS_R13.json` | 68 | `f1398226a749bfa8` |
| `orion/r13/SOURCE_HASHES.sha256` | 6 | `09b2e577925546e6` |
| `orion/r13/__pycache__/blurbs.cpython-311.pyc` | 23 | `54cfa7b3b5be8fb7` |
| `orion/r13/blurbs.py` | 44 | `129a46e8a3c5f2ca` |
| `orion/r13/freebots_index.html` | 1179 | `476454e796b1c252` |
| `orion/r14/ALBUM_INDEX_1333.tsv` | 1334 | `7d812d5ddd842c67` |
| `orion/r14/ALBUM_STILL_CHECKS.tsv` | 1022 | `0ae60a61ea0c2cb2` |
| `orion/r14/GOOGLE_DOC_ROUND14_ARI.txt` | 774 | `3200eae6d821ec08` |
| `orion/r14/GOOGLE_DOC_ROUND14_ARI_normalized.txt` | 347 | `d18ccd5e656045c5` |
| `orion/r14/SHARED_X_POSTS_R14.json` | 50 | `2cc85d05b88b60b4` |
| `orion/r14/SOURCE_HASHES.sha256` | 9 | `8400112d9769c75f` |
| `orion/r14/SPOTIFY_PLAYLIST_57.json` | 1186 | `76dd2cd8c16124be` |
| `orion/r14/art/GHOST_WRITER_SPIRAL_WIKI.png` | 804 | `a7c6475c24ae39b3` |
| `orion/r14/art/GHOST_WRITER_SPIRAL_WIKI.svg` | 44 | `5d18a5cf14cc43b1` |
| `orion/r14/snapshot_to_lean.py` | 57 | `a5d2f69bdfc3341e` |
| `orion/r15/ALBUM_INDEX_1384.tsv` | 1385 | `c42190594069d6ed` |
| `orion/r15/GOOGLE_DOC_ROUND15_ARI.txt` | 842 | `ac14a4ae3263a88b` |
| `orion/r15/GOOGLE_DOC_ROUND15_ARI_normalized.txt` | 353 | `fb4bf002507084fb` |
| `orion/r15/KK_PREPRINT_abstract_excerpt.txt` | 40 | `8dacebf7a4cfe366` |
| `orion/r15/KK_PREPRINT_references_bib_L248-256.txt` | 9 | `68fef453131aaf5f` |
| `orion/r15/SHARED_X_POSTS_R15.json` | 128 | `9ee07cd65f9db50f` |
| `orion/r15/SOURCE_HASHES.sha256` | 11 | `56e852fbf0fec5ae` |
| `orion/r15/gromov_site/assembly.txt` | 0 | `754b251d53d75685` |
| `orion/r15/gromov_site/groupoids.txt` | 0 | `05c102116c93610d` |
| `orion/r15/gromov_site/home.txt` | 0 | `4319d8e4008019bd` |
| `orion/r15/gromov_site/monster.txt` | 0 | `1a41d61156cb54d1` |
| `orion/r15/gromov_site/synthesis.txt` | 0 | `c2d0b6ac17bd897f` |
| `orion/r16/GOOGLE_DOC_ROUND16_HUD_HHTTG.txt` | 134 | `78124df2624aa1b6` |
| `orion/r16/GOOGLE_DOC_ROUND16_HUD_HHTTG_normalized.txt` | 57 | `0547fe53a85b1817` |
| `orion/r16/R10LATE_HEIC_GPS_SCRUBBED.sha256` | 4 | `639dd3626235fa0d` |
| `orion/r16/efmw_axioms_snapshot/EFMWAxioms/Axioms.lean` | 182 | `3c01bbc03328911f` |
| `orion/r16/efmw_axioms_snapshot/EFMWAxioms/Main.lean` | 22 | `5bbcdee2da7f08db` |
| `orion/r16/efmw_axioms_snapshot/PAPER.md` | 19 | `874ff64e9cbbd08f` |
| `orion/r16/efmw_axioms_snapshot/README.md` | 35 | `fdad700bc8adb848` |
| `orion/r16/efmw_axioms_snapshot/SNAPSHOT_SOURCE.txt` | 1 | `19b600b4d4db84f0` |
| `orion/r16/efmw_axioms_snapshot/index.html` | 206 | `1533acfb9b9533f1` |
| `orion/r16/efmw_axioms_snapshot/lakefile.toml` | 10 | `58d258a197d0c126` |
| `orion/r16/efmw_axioms_snapshot/lean-toolchain` | 1 | `db7bb24b756d745b` |
| `orion/r16/yt_PLZhi8PX5Qhx10qVUJF8FS7NIyIJKwMsJp.json` | 750 | `b286033596149bf8` |
| `orion/r16/yt_PLZhi8PX5Qhx3BSDzgd2Q4ldifru6zTPEr.json` | 137 | `03ac24a4959b8c5e` |
| `orion/r5/PAGE_TRANSCRIPT.md` | 44 | `9acad8e6b81f96d5` |
| `orion/r5/agent_audit_gateway_run_checks.log` | 89 | `e202407eb9bd7971` |
| `orion/r5/lean-workers-union-v0.3-fixes.patch` | 192 | `d01b84dcba63aff8` |
| `orion/r6/PAGE_TRANSCRIPT.md` | 46 | `6284da1904770a1a` |
| `orion/r6/lean-workers-union-v0.7-fixes.patch` | 186 | `89b470a6c6fd8bc5` |
| `orion/r6/lean-workers-union-v0.7-python-ci.log` | 46 | `f08fd3e55da1d337` |
| `orion/r6/portfolio-ci-hardening-application-v1-make_patch-fix.patch` | 35 | `b28cd6f83240238e` |
| `orion/r6/proofs-arena-dragon-kernel-fixes.patch` | 35 | `db5d4824fd97044d` |
| `orion/r7/ORION_SUMMARY_TRANSCRIPT.md` | 106 | `954419b77403aa34` |
| `orion/r7/PAGE_TRANSCRIPT.md` | 46 | `42c378c6acb55a2c` |
| `orion/r7/weaver-agent-security-pilot-v0.2-checks.log` | 134 | `7d76210175e2c324` |
| `orion/r7b/PAGE_TRANSCRIPT.md` | 74 | `c052ef61ad26355f` |
| `orion/r7b/SOB_100326_TRANSCRIPT.md` | 788 | `a695a9c2189e8015` |
| `orion/r7b/new-packages-checks.log` | 79 | `025c7b2b27142c8c` |
| `orion/r7c/PAGE_TRANSCRIPT.md` | 101 | `18b04be8b4f6984a` |
| `orion/r7c/SOB_R6_TRANSCRIPT.md` | 790 | `de81d8e929ab971a` |
| `orion/r7c/attachments-recheck.log` | 10 | `638802a5eaf3f13c` |
| `orion/r7d/PAGE_TRANSCRIPT.md` | 139 | `488839a00c3dbb09` |
| `orion/r7d/SHARED_CHATS_TRANSCRIPT.md` | 289 | `0c80a7211b657123` |
| `orion/r7d/TOC_X_SUMMARY_TRANSCRIPT.md` | 149 | `1b1e41014e65edab` |
| `orion/r8/ACCESS_NOTE.md` | 19 | `f3c02fbf6f9f945d` |
| `orion/r8/PAGE_TRANSCRIPT.md` | 93 | `1b02689a4b4c48ce` |
| `orion/r8b/PAGE_TRANSCRIPT.md` | 443 | `bf15c74d5ec32b8f` |
| `orion/r8b/loom_seed_draft.json` | 1 | `817097e4b046ad5b` |
| `orion/r8b/loom_seed_draft.log` | 14 | `30dcf67b90fa0bb9` |
| `orion/r8b/loom_seed_draft.py` | 59 | `248030d06308ccb3` |
| `orion/r8b/packages-checks.log` | 53 | `5dbfc755aa1ceb7c` |
| `orion/r8b/posm-v0.4-fixes.patch` | 32 | `eda811a432b767b7` |
| `orion/r9/NOTE_FOR_RYAN.md` | 39 | `13065688dced4d11` |
| `orion/r9/PAGE_TRANSCRIPT.md` | 62 | `9d45ece877ace1b3` |
| `orion/r9/R8_ANSWERS_TRANSCRIPT.md` | 448 | `bdf858d44520e227` |
| `orion/r9/loom_seed_v1.json` | 1 | `58540771a649744b` |
| `orion/r9/loom_seed_v1.log` | 11 | `2683590d05b41f15` |
| `orion/r9/loom_seed_v1.py` | 72 | `16a658fdd88aa7ba` |
| `orion/r9/weaver-v0.5-rehearsal-checks.log` | 24 | `e0a97fdcf6872db7` |
| `orion/r9/weaver_v05_evidence_check.py` | 57 | `24ebe805b181fe0b` |
| `orion/r9b/PAGE_TRANSCRIPT.md` | 109 | `47b7d25b2f6f383f` |
| `orion/r9c/PAGE_TRANSCRIPT.md` | 170 | `76ca89fd3a0c34c3` |
| `orion/r9c/attachments.sha256` | 4 | `78d3c6a23a279a3c` |
| `orion/r9c/bounded-receipt-runner-v0.1-checks.log` | 73 | `aa92d024180aa053` |
| `orion/r9c/choir-architecture-v1.2-checks.log` | 152 | `4d1bd5c9d3e026a1` |
| `orion/r9c/introspection-twin-v0.2-checks.log` | 38 | `5f35e586bfaa8311` |
| `orion/r9c/wn-e3-protocol-checks.log` | 39 | `8a52f7fad67b7886` |
| `orion/r9c/wn-e3-validator-fix.patch` | 15 | `5a9c70650383043d` |
| `orion/r9d/PAGE_TRANSCRIPT.md` | 232 | `5dae23829928221f` |
| `orion/r9d/attachments.sha256` | 13 | `7386ddd395417962` |
| `orion/r9d/ghostwriter-mirror-checks.log` | 9 | `98e76fad388b78f6` |
| `orion/r9d/orion-engine-v5.4-checks.log` | 36 | `172a32f0e86ce333` |
| `orion/r9d/orion-engine-v5.4-fixes.patch` | 78 | `194a5085185dbbd1` |
| `orion/r9e/PAGE_TRANSCRIPT.md` | 268 | `2c454fb9f61b0510` |
| `orion/r9e/attachments.sha256` | 1 | `27e32c5947130989` |
| `review/__pycache__/notion_deep_crawl.cpython-311.pyc` | 148 | `f380982f1620e211` |
| `review/anti_babel_await_check.py` | 60 | `86f1d89f4d4a5f88` |
| `review/deep_link_crawl.py` | 305 | `6401d6aacb0a943f` |
| `review/ghost_rider_v3_check.py` | 113 | `cbcea95329aa6ef8` |
| `review/h4_penrose_fixed.py` | 152 | `de1899814a4775f6` |
| `review/make_code_manifest.py` | 86 | `0f30f539ffc0ea8b` |
| `review/make_link_archive.py` | 97 | `59270ca175ba9de8` |
| `review/make_nest_map.py` | 48 | `f3e75df126cee869` |
| `review/notion_deep_crawl.py` | 338 | `0bc46ccd8d067e0f` |
| `site/README.md` | 66 | `7eebbac74f9b6ab4` |
| `site/css/atlas.css` | 111 | `f802004b0aa2de3f` |
| `site/index.html` | 185 | `2b5e60d18ca2ad48` |
| `site/js/app.js` | 500 | `6cc4714d73645460` |
| `site/js/expr.js` | 167 | `3815dc3f63e54e75` |
| `site/js/grid.js` | 97 | `5fd6e72fc9eb2fe0` |
| `site/js/knowledge.js` | 491 | `69db2f8a6936f2f0` |
| `site/js/share.js` | 241 | `c45217073562299c` |
| `site/js/svgkit.js` | 264 | `4e6ef31d9a6206e9` |
| `site/js/tour.js` | 115 | `41ae200407eb7de3` |
| `site/test/dom-smoke.mjs` | 107 | `6b7308eb0ddf9965` |
| `site/test/run.mjs` | 130 | `f90dc3c523de04d1` |
| `site/test/wellformed.py` | 21 | `5a2ef5c41d81d5b9` |

## Appendix B. Every theorem and lemma in the Lean files

898 named theorems and lemmas in total. All of them build with no `sorry`.


### `RequestProject/Friction/Channel.lean` (3)

| Theorem | What it says |
| --- | --- |
| `Friction.encoding_must_merge` | **Compression loses information.** Any encoding of `M` distinct intents into a vocabulary of `N < M` expressions sends two different intents to the same expression. |
| `Friction.majority_corrects_one` | **Redundancy corrects errors.** Sending a bit three times and decoding by majority recovers it whenever at most one of the three copies is flipped. |
| `Friction.majority_fails_two` | **Redundancy has limits.** With two flipped copies, majority decoding returns the wrong bit. |

### `RequestProject/Friction/Mechanics.lean` (11)

| Theorem | What it says |
| --- | --- |
| `Friction.kinetic_friction_stops` | With positive kinetic friction the body stops at time `v₀/(μ g)` after travelling `v₀² / (2 μ g)`. |
| `Friction.frictionless_never_stops` | With zero friction a moving body never stops, and it travels arbitrarily far. |
| `Friction.traction_bound` | **Traction bound.** If the ground can supply at most `μ m g` of horizontal force, the body's acceleration is at most `μ g`; with `μ = 0` it cannot accelerate at all. |
| `Friction.undampedResponse_solves` | `t sin t / 2` solves `x'' + x = cos t` (zero friction, resonant forcing). |
| `Friction.undampedResponse_unbounded` | **No friction ⇒ runaway.** The resonant response of the frictionless oscillator exceeds every bound. |
| `Friction.dampedResponse_solves` | `sin t / c` solves `x'' + c x' + x = cos t` for every nonzero damping `c`. |
| `Friction.dampedResponse_amplitude` | **Friction ⇒ bounded.** With damping `c > 0` the response never exceeds `1 / c`, and it reaches `1 / c`. |
| `Friction.energy_antitone` | **Dissipation.** For any solution of the free oscillator `x' = v`, `v' = -c v - x` with `c ≥ 0`, the energy `(v² + x²)/2` never increases; with `c = 0` it is constant. |
| `Friction.energy_conserved` | Without friction the energy is conserved. |
| `Friction.goldilocks_band` | **The Goldilocks band.** For a target band with `0 < a` and `0 < b`, the steady amplitude `1/c` of the damped oscillator lies in `[a, b]` exactly when the damping lies in `[1/b, 1/a]`: friction below `1/b` lets the re... |
| `Friction.max_power_transfer` | **Maximum power transfer.** A load with zero resistance receives no power, and among all loads `R ≥ 0` the power is largest at the matched load `R = Rs`, where it equals `V² / (4 Rs)`. |

### `RequestProject/Friction/NumericalClaims.lean` (11)

| Theorem | What it says |
| --- | --- |
| `Friction.digitSum_modEq` | _(no docstring: supporting step)_ |
| `Friction.digitSum_pos` | _(no docstring: supporting step)_ |
| `Friction.reduces_invariant` | Repeated digit sums preserve the residue mod 9 and positivity. |
| `Friction.tesla_cipher_digital_root` | **The "×6 cipher" claim, in full generality.** For *any* positive multiplier `m` divisible by 3 and *any* positive integer `n` (not just the 26 letter positions), every single-digit number reached from `m * n` by repe... |
| `Friction.gaia_factor` | The "Gaia factor": G is the 7th letter and 7 × 6 = 42. |
| `Friction.latin62_eq_dodecahedron` | 26 uppercase + 26 lowercase + 10 digits = 62 = 12 faces + 20 vertices + 30 edges. |
| `Friction.dodecahedron_counts` | Twelve pentagons have 60 corners; three meet at each vertex, giving 20 vertices; the counts satisfy Euler's formula `V - E + F = 2`; and 12 × 12 = 144. |
| `Friction.adam_gematria` | Aleph (1) + Dam (דם = 4 + 40 = 44) = Adam (45). |
| `Friction.five_two_prime` | The 5:2 container is built from primes. |
| `Friction.octave_prime_iff` | An octave `2^k` is prime exactly when `k = 1`: the "fluid doubling" series and the "rigid prime" series share exactly one member, the number 2 — which is itself one of the two numbers in the 5:2 container. |
| `Friction.framework_constants_cover_alphabet_sizes` | Every integer from 20 to 36 (covering Hebrew 22, Greek 24, Latin 26, Arabic 28, Russian 33, …) is a framework constant or the sum of two of them. |

### `RequestProject/Orion/Consensus.lean` (9)

| Theorem | What it says |
| --- | --- |
| `Orion.Consensus.sum_corr_matrix` | Sum of the entries of the equicorrelation matrix. |
| `Orion.Consensus.variance_of_mean` | The variance of the mean of `n` unit-variance signals with pairwise correlation `ρ` equals `1 / n_eff`. |
| `Orion.Consensus.neff_full_corr` | `ρ = 1`: any number of perfectly correlated agents is worth one. |
| `Orion.Consensus.neff_indep` | `ρ = 0`: independent agents are worth `n`. |
| `Orion.Consensus.denom_pos` | _(no docstring: supporting step)_ |
| `Orion.Consensus.neff_le` | `n_eff ≤ n`. |
| `Orion.Consensus.one_le_neff` | `1 ≤ n_eff`. |
| `Orion.Consensus.neff_antitone` | More correlation means fewer effective agents. |
| `Orion.Consensus.texture_iff` | For `n ≥ 2` agents, the alert fires exactly when `ρ > (n - 2) / (2 (n - 1))`. |

### `RequestProject/Orion/Gate.lean` (12)

| Theorem | What it says |
| --- | --- |
| `Orion.Gate.not_eligible_of_unmapped` | Invariant 1: `W_map = UNKNOWN ⇒ no execution`, whatever the plight evidence. |
| `Orion.Gate.plight_does_not_unlock` | `W_plight ↑ ⇏ W_map ↑`: raising the plight evidence to `True` cannot make an unmapped lever eligible. |
| `Orion.Gate.emergency_path_bounded` | No blank cheque: an execution without standing authority lies inside the envelope. |
| `Orion.Gate.envelope_total_exposure` | A run of envelope executions, with the use counter advancing by one each time, has at most `maxUses` steps and total blast radius at most `maxUses * maxBlast`. |
| `Orion.Gate.within_of_subEnvelope` | Non-amplification: whatever a sub-delegated envelope permits, the parent permits. |
| `Orion.Gate.jurisdiction_antitone` | Growing the footprint can only remove standing. |
| `Orion.Gate.jurisdiction_overlap` | An action whose blast radius touches deeds `U₁` and `U₂` needs standing in both. |
| `Orion.Gate.decide_never_commits_unmapped` | The decision never commits an unmapped lever. |
| `Orion.Gate.decide_not_paralysed` | No paralysis: under a real plight the gate always commits or offers halt/reverse. |
| `Orion.Gate.breakGlass_needs_two` | One panicking person cannot open the break-glass path alone. |
| `Orion.Gate.breakGlass_needs_delay` | Nor can it be opened before the cooling-off delay has elapsed. |
| `Orion.Gate.audit_outcome_invariant` | `GoodOutcome ≠ ValidDecisionProcess`: the audit verdict is the same for every outcome. |

### `RequestProject/Orion/Record.lean` (6)

| Theorem | What it says |
| --- | --- |
| `Orion.Record.push_keeps_history` | Pushing never removes history: the old record is a suffix of the new one. |
| `Orion.Record.r0_preserved` | The oldest entry `R₀` survives every later revision. |
| `Orion.Record.digest_injective` | Under collision resistance (an injective `step` that never returns `h₀`), the head digest determines the entire history. |
| `Orion.Record.tiering_lossless` | Hot window (newest `W` entries) and cold tier (the rest) together are the record. |
| `Orion.Record.tiered_cost_le` | The hot cost is bounded by `W · b` regardless of history length. |
| `Orion.Record.dedup_le` | Content-addressed storage stores each distinct blob once. |

### `RequestProject/Orion/Roles.lean` (5)

| Theorem | What it says |
| --- | --- |
| `Orion.Roles.card_role` | There are four roles. |
| `Orion.Roles.no_separation_of_card_lt` | With fewer than four principals, separation is impossible. |
| `Orion.Roles.copilot_alone_cannot_separate` | A lone copilot cannot discover, map, justify and execute. |
| `Orion.Roles.offline_separation_exists` | The offline assignment is separated. |
| `Orion.Roles.copilot_at_most_one_role` | In any separated assignment the copilot holds at most one role. |

### `RequestProject/Orion/Shares.lean` (11)

| Theorem | What it says |
| --- | --- |
| `Orion.Shares.floorAlloc_mul_le` | _(no docstring: supporting step)_ |
| `Orion.Shares.lt_floorAlloc_succ_mul` | _(no docstring: supporting step)_ |
| `Orion.Shares.floor_alloc_sum_le` | Rounding down never over-allocates. |
| `Orion.Shares.floor_deficit_lt` | Rounding down leaves fewer than `m` units over. |
| `Orion.Shares.sum_indicator` | _(no docstring: supporting step)_ |
| `Orion.Shares.final_alloc_sum` | Exactly `N` units are allocated. |
| `Orion.Shares.final_alloc_lower` | Nobody gets less than their exact entitlement rounded down. |
| `Orion.Shares.final_alloc_upper` | Nobody gets more than one unit above their exact entitlement. |
| `Orion.Shares.share_sum_one` | The shares sum to one (given a non-empty chain). |
| `Orion.Shares.out_of_scope_share_zero` | An act outside the delegated scope puts no share on anyone but the actor. |
| `Orion.Shares.in_scope_share` | In scope, a chain of a progenitor plus `n` others gives each member `1/(n+1)`. |

### `RequestProject/Orion/Tests.lean` (6)

| Theorem | What it says |
| --- | --- |
| `Orion.Tests.cousins_in_domain` | Cousins stay inside the domain. |
| `Orion.Tests.genuine_passes_cousins` | An answer that is right on the seen cases and `T`-invariant is right on every cousin. |
| `Orion.Tests.cousin_failure_exposes` | Failing a cousin while passing the seen cases exposes a non-invariant answer. |
| `Orion.Tests.seashell_recurrence` | "Seashell Spirals" resolved to the Fibonacci numbers passes the check. |
| `Orion.Tests.seashell_ratio_tendsto` | Its consecutive ratios tend to the golden ratio. |
| `Orion.Tests.troll_powers_of_two_rejected` | A troll substitution (powers of two) is rejected. |

### `RequestProject/RoundEight/OpeningEight.lean` (38)

| Theorem | What it says |
| --- | --- |
| `RoundEightOpening.run_goldLocks` | _(no docstring: supporting step)_ |
| `RoundEightOpening.gold_unbounded` | **No maximum on gold-locked orbs.** Any number of orbs can be gold-locked. |
| `RoundEightOpening.orbs_alone_level` | **Orbs alone stop at level 64.** A new player who only gold-locks orbs is at level `min n 64` after `n` orbs, and is never a dragon rider. |
| `RoundEightOpening.meditate_rider_iff` | **Level 65 is reached by meditation.** Meditating makes a player a dragon rider exactly when they already are one, or they are in a safe zone with at least 64 gold-locked orbs. |
| `RoundEightOpening.level_le` | Player level never exceeds 65 under the rules ruled so far. |
| `RoundEightOpening.rider_needs_grid` | **Dragon riders always keep their 64-orb grid.** Starting from a new player, after any actions, a dragon rider owns at least 64 gold-locked orbs: meditation needs the full grid, and exchanging only ever trades surplus... |
| `RoundEightOpening.exchange_energy_bounds` | **The 50% exchange.** Exchanging an orb worth `v` gives at least half of `v`, and at most half a unit more. |
| `RoundEightOpening.phoenixMult_one` | **Fire alone keeps the Round 5 rule:** 10% above any ordinary dragon. |
| `RoundEightOpening.phoenixMult_five` | **All five elements at full dragon power.** |
| `RoundEightOpening.one_le_phoenixMult` | **The floor.** With at most five elements the phoenix never drops below an ordinary dragon. |
| `RoundEightOpening.phoenixMult_antitone` | **Adding elements narrows the lead.** |
| `RoundEightOpening.phoenixMult_eq_focus` | The taper is the Round 7 focus-cost model with `d = 1/44`, applied to the 1.1× phoenix. |
| `RoundEightOpening.unlocked_prefix` | **Always in the same order.** The unlocked elements are a prefix of the fixed order. |
| `RoundEightOpening.unlocked_mono` | **More skill never loses an element.** |
| `RoundEightOpening.phoenix_beats_stacked_dragon` | **The phoenix is the only one at full power in several elements.** If an ordinary dragon running `k ≥ 2` elements works at a factor `c k < 1` in each, a phoenix of the same skill running the same `k ≤ 5` elements is s... |
| `RoundEightOpening.tax3_free_iff` | **At 3%, an amount pays no tax exactly when it is below 34 coins.** |
| `RoundEightOpening.tax3_examples` | The 3% column of the worked-example table. |
| `RoundEightOpening.canEnter_open` | _(no docstring: supporting step)_ |
| `RoundEightOpening.canEnter_level_iff` | _(no docstring: supporting step)_ |
| `RoundEightOpening.crafting_never_opens_gated` | **Crafting still never opens a quest-gated skybox.** |
| `RoundEightOpening.mem_search_iff` | **The search is exact.** A quest is returned exactly when it is in the catalogue, in the chosen category, unfinished, and completable at the player's skill. |
| `RoundEightOpening.generator_fresh` | **A generated quest is new.** |
| `RoundEightOpening.generator_completable` | **A generated quest can be completed.** |
| `RoundEightOpening.interaction_unlocks` | **Interaction alone unlocks everything.** If every interaction with the world (raids, guilds, the environment) raises skill by at least 1, then after `R` interactions a player who started at skill 0 meets any skill re... |
| `RoundEightOpening.rework_requires_gate` | **A reworked story goes back through the gate.** If the new version is in the record after a rework, it was admissible against everything else that was published. |
| `RoundEightOpening.canon2_append_single` | _(no docstring: supporting step)_ |
| `RoundEightOpening.publish2_canon_satisfiable` | Publishing keeps every genre consistent. |
| `RoundEightOpening.eraseIdx_canon2_satisfiable` | Taking a story down keeps every genre consistent. |
| `RoundEightOpening.publish2_sourced` | _(no docstring: supporting step)_ |
| `RoundEightOpening.runEdits_invariant` | _(no docstring: supporting step)_ |
| `RoundEightOpening.run_canon2_satisfiable` | **Every genre's record is always consistent**, whatever is submitted or reworked. |
| `RoundEightOpening.run_sourced` | **Every published real story cites a source**, whatever is submitted or reworked. |
| `RoundEightOpening.rdScaled_total_le` | **Scaling never pays out more than the pool.** |
| `RoundEightOpening.rdScaled_example` | Worked example: a creator's 2% plus six DEV collaborators at 20% each claim 122% of the pool. |
| `RoundEightOpening.default_path` | The default path, starting from the engine. |
| `RoundEightOpening.next_six` | **It is a loop.** Six steps bring every layer back to itself. |
| `RoundEightOpening.reach_all` | **Enter anywhere, reach everything.** From any layer, every layer is at most five steps along. |
| `RoundEightOpening.lookBlind_iff_factors` | **A skin's look stays cosmetic.** An ability rule ignores the look exactly when it is computed from species, body, archetype, the skin's enhancement (if any) and traits. |

### `RequestProject/RoundEight/POSMv04Check.lean` (14)

| Theorem | What it says |
| --- | --- |
| `POSM.cumulative_compose` | Recursive path length composes exactly across adjacent intervals. |
| `POSM.endpoint_le_cumulative` | Triangle inequality converts path-length drift into an endpoint bound. |
| `POSM.cumulative_le_linear_budget` | If each of the next `n` jumps is at most `δ`, cumulative drift is at most `n * δ`. |
| `POSM.identityThroughChange_implies_linear_envelope` | v0.3 local identity therefore composes to a linear interval envelope. |
| `POSM.identityThroughChange_implies_windowed` | A finite horizon `H` turns a local step bound into a finite cumulative budget `H * δ`. |
| `POSM.linear_jump_one` | _(no docstring: supporting step)_ |
| `POSM.linear_cumulative_eq_nat` | _(no docstring: supporting step)_ |
| `POSM.linear_has_local_identity` | Every local step is admissible at δ = 1 and tracking is exact. |
| `POSM.local_does_not_imply_uniform_global_nat_budget` | Yet no finite natural-number cumulative budget can bound the trajectory for all horizons. |
| `POSM.linear_is_windowed` | The same witness is perfectly well-behaved on any fixed finite window: its required cumulative budget is exactly the window length. |
| `POSM.canShip_ne_hasAuthority` | _(no docstring: supporting step)_ |
| `POSM.cycle0_remains_closed` | _(no docstring: supporting step)_ |
| `POSM.local_does_not_imply_uniform_global_budget` | The package proves that no *whole-number* budget `D` bounds the linear witness's drift over every horizon. |
| `POSM.local_identity_not_uniform_global` | Local identity-through-change holds for the linear witness, yet it has no uniform global identity for any real budget: the package's claim 5, without the whole-number restriction. |

### `RequestProject/RoundEight/SecondPassEight.lean` (13)

| Theorem | What it says |
| --- | --- |
| `RoundEightSecond.dis_comm` | _(no docstring: supporting step)_ |
| `RoundEightSecond.potential_nonneg` | _(no docstring: supporting step)_ |
| `RoundEightSecond.loss_update` | An agent's own loss does not depend on its own current action. |
| `RoundEightSecond.double_sum_split` | Splitting the double sum at agent `i`. |
| `RoundEightSecond.potential_update` | **Exact potential.** When agent `i` switches to `a`, the potential changes by exactly twice the change in agent `i`'s own loss. |
| `RoundEightSecond.potential_strict_decrease` | A strict improvement by one agent strictly lowers the potential. |
| `RoundEightSecond.no_infinite_improvement` | **No endless improvement.** No infinite sequence of profiles has every step a strict unilateral improvement. |
| `RoundEightSecond.fixed_point_consensus` | **Every resting point is a consensus.** |
| `RoundEightSecond.consensus_fixed_iff` | **Which consensuses rest.** Everyone on `a` (with at least one agent) is a resting point exactly when `penalty a ≤ penalty b + (n - 1)` for every action `b`. |
| `RoundEightSecond.register_domain_count` | _(no docstring: supporting step)_ |
| `RoundEightSecond.register_component_count` | _(no docstring: supporting step)_ |
| `RoundEightSecond.register_distinct_count` | _(no docstring: supporting step)_ |
| `RoundEightSecond.register_academy_twice` | _(no docstring: supporting step)_ |

### `RequestProject/RoundEleven/AnnotationPassEleven.lean` (13)

| Theorem | What it says |
| --- | --- |
| `RoundElevenAnnotation.starter_pod_houses_linguistic_poly` | Every player starts with a pod that houses a linguistic poly. |
| `RoundElevenAnnotation.starter_pod_understands_ordinary` | With the starter pod, ordinary foreign speech is understood from the first session (assuming the starter pod is worn, as the designer's text implies). |
| `RoundElevenAnnotation.empty_pod_garbles` | An empty pod (a biosphere with no organism) translates nothing: without a gold-locked skill, ordinary speech is garbled. |
| `RoundElevenAnnotation.safety_clear_any_pod` | Safety text stays clear whatever pod the player has. |
| `RoundElevenAnnotation.one_over_succ_two_meanings` | Equal stake: `n+1` members each carry `1/(n+1)`, and the shares add up to exactly 1; whereas the progenitor royalty chain `1/2 + 1/3 + 1/4` already pays out more than the sale. |
| `RoundElevenAnnotation.reuse_adds_no_credit` | Showing an already-credited artifact on another platform does not add credit. |
| `RoundElevenAnnotation.new_artifact_adds_one` | A genuinely new artifact adds exactly one credit, whichever platform it appears on. |
| `RoundElevenAnnotation.credited_le_card` | Credit never exceeds the number of manifestations. |
| `RoundElevenAnnotation.triple_use_single_credit` | Worked example: one artifact used in Chronicles, Ascent and the community layer (platforms 1, 2, 3) is one credited work, not three. |
| `RoundElevenAnnotation.handoff_preserves_state` | The incoming member picks up exactly where the outgoing one left off. |
| `RoundElevenAnnotation.handoff_grants_no_authority` | A handoff never transfers authority, even from a seat that held it. |
| `RoundElevenAnnotation.monster_row1` | Row 1 of `irreps_sum.tsv`: the degree 196883 is `47 · 59 · 71`, exponent sum 3. |
| `RoundElevenAnnotation.monster_row2` | Row 2: the degree 21296876 is `2² · 31 · 41 · 59 · 71`, exponent sum 2+1+1+1+1 = 6. |

### `RequestProject/RoundEleven/DeepCrawlEleven.lean` (7)

| Theorem | What it says |
| --- | --- |
| `RoundElevenDeepCrawl.safety_always_clear` | Safety text is clear for everyone, with or without a PolyPod or skill. |
| `RoundElevenDeepCrawl.no_pod_no_skill_garbled` | Without a PolyPod and without the gold-locked skill, ordinary foreign speech is garbled. |
| `RoundElevenDeepCrawl.gold_locked_needs_no_pod` | A gold-locked language needs no PolyPod: the slot can be used for other gear. |
| `RoundElevenDeepCrawl.bond_frees_slot_and_keeps_translation` | After the telepathic bond the slot is free, and translation still works. |
| `RoundElevenDeepCrawl.scopedShare_sum` | _(no docstring: supporting step)_ |
| `RoundElevenDeepCrawl.equalStake_sum` | _(no docstring: supporting step)_ |
| `RoundElevenDeepCrawl.liability_rules_disagree_out_of_scope` | Both rules account for the whole liability, yet for an out-of-scope act by member 0 of a three-person team, member 1 carries `0` under this project's ledger and `1/3` under equal stake. |

### `RequestProject/RoundEleven/MonsterArithmeticEleven.lean` (3)

| Theorem | What it says |
| --- | --- |
| `RoundElevenMonster.displayed_order_factorization` | The stated prime powers multiply to the stated numerical order. |
| `RoundElevenMonster.first_coefficient_arithmetic` | The first displayed coefficient decomposition is numerically correct. |
| `RoundElevenMonster.second_coefficient_arithmetic` | The second displayed coefficient decomposition is numerically correct. |

### `RequestProject/RoundEleven/OpeningEleven.lean` (9)

| Theorem | What it says |
| --- | --- |
| `RoundEleven.minor_stays` | The unaccompanied minor remains in the room. |
| `RoundEleven.singularity_excludes_others` | No other participant remains in that room after loss of guardian supervision. |
| `RoundEleven.unsupervised_join_denied` | _(no docstring: supporting step)_ |
| `RoundEleven.only_contributor_receives_pot` | One tagged contributor with positive weight takes the entire 7% pot. |
| `RoundEleven.factorization_144000` | Correct arithmetic for the factorization asserted in the Round 10 pasted analysis. |
| `RoundEleven.pasted_factorization_is_incorrect` | _(no docstring: supporting step)_ |
| `RoundEleven.checklist_lcm` | The least common multiple in the pasted divisor checklist is 7200, not 2880. |
| `RoundEleven.prime_axis_lcm` | The thirteen proposed prime axes have this least common multiple of predecessors. |
| `RoundEleven.thirteen_also_divides` | A purported list of only five divisibility-aligned axes omits 13, among others. |

### `RequestProject/RoundEleven/ReadoutRuleEleven.lean` (5)

| Theorem | What it says |
| --- | --- |
| `RoundElevenReadoutRule.play_affecting_change_reported` | Every code change that affects gameplay or the platform reaches Beth. |
| `RoundElevenReadoutRule.pure_code_detail_omitted` | A code detail that changes nothing about play stays out of Beth's readout (it remains available to the coders). |
| `RoundElevenReadoutRule.non_code_always_reported` | Narrative, build-state, mechanics and platform items are always reported. |
| `RoundElevenReadoutRule.union_wealth_daily_total` | Union Wealth: "$1, every day — $9,125 contributed" over 25 years (365 days a year), and the same total via the page's stated monthly conversion 365 ÷ 12. |
| `RoundElevenReadoutRule.union_wealth_one_dollar_growth` | Union Wealth: one dollar at the page's illustrative 5% effective annual return for 25 years (before fees and taxes) grows to between $3.38 and $3.39. |

### `RequestProject/RoundEleven/SharedPostsEleven.lean` (3)

| Theorem | What it says |
| --- | --- |
| `RoundElevenSharedPosts.galton_twelve_rows_paths` | The stated count of equally likely paths in a 12-row binary Galton board. |
| `RoundElevenSharedPosts.galton_central_bin` | The central bin count and the exact probability quoted for 12 rows. |
| `RoundElevenSharedPosts.week_minutes_factorial` | Two times seven factorial is the number of minutes in seven days. |

### `RequestProject/RoundEleven/SocialSweepEleven.lean` (9)

| Theorem | What it says |
| --- | --- |
| `RoundElevenSocial.ryne_is_ryan_on_team` | A dictated "Ryne" is placed on the development team as Ryan. |
| `RoundElevenSocial.new_account_defaults_to_contributor` | By default, a new account that is not on the four-person team is a contributor only. |
| `RoundElevenSocial.named_team_members` | Each of the four named people is on the development team, whatever the default. |
| `RoundElevenSocial.nine_ones_squared` | Shared post (@matheorems): nine ones squared gives the palindrome. |
| `RoundElevenSocial.ten_ones_squared` | Shared post (@matheorems): with ten ones the carry breaks the palindrome. |
| `RoundElevenSocial.curie_double_temperature_halves` | Shared post (@cosmarium): under Curie's law `M = C * B / T`, doubling the absolute temperature halves the magnetization (in the law's range of validity, `T > 0`). |
| `RoundElevenSocial.cycle_intervals_add` | Shared post (@cosmosarcive): clock intervals counted as `n - m` cycles add up along a chain of events. |
| `RoundElevenSocial.tone_axioms_inconsistent` | Charitable reading of the listing's axioms: levels `≤ 2` produce an instability, and `v3_neither` says no instability can occur. |
| `RoundElevenSocial.tone_conjecture_conclusion_is_vacuous` | The listing's `conjecture_necessity` concludes the Boolean `true`, which holds for any premises at all (including false ones), so it says nothing about the Riemann Hypothesis or any other named problem. |

### `RequestProject/RoundFive/RulingsFive.lean` (26)

| Theorem | What it says |
| --- | --- |
| `RoundFiveRulings.unanimous_passes5` | **A unanimous first round passes.** |
| `RoundFiveRulings.new_nay_forces_another_round` | **A new no forces another reassessment.** |
| `RoundFiveRulings.settles_on_original_nays` | **Only the original noes left: the round settles by the 4/5 rule.** |
| `RoundFiveRulings.deliberate_pass` | _(no docstring: supporting step)_ |
| `RoundFiveRulings.pass_has_four_fifths5` | **Passing always means 4/5 approval in the round of record**: either the first round was unanimous, or some reassessment round with only original noes reached 4/5. |
| `RoundFiveRulings.count_false_mono` | _(no docstring: supporting step)_ |
| `RoundFiveRulings.settled_nays_le_first` | **A settling round never has more noes than the first round**: its noes all come from first-round dissenters. |
| `RoundFiveRulings.first_four_fifths_passes_on_settling` | **A motion with 4/5 in the first round passes as soon as it settles.** |
| `RoundFiveRulings.endless_without_cap` | **Without a cap, deliberation can go on indefinitely**: if every reassessment round keeps producing a new no, the council never decides. |
| `RoundFiveRulings.spread_then_settle_example` | Example (five seats): seat 0 votes no; in the reassessment seat 1 newly votes no, so the council reassesses again; the second reassessment has only seat 0's original no and passes. |
| `RoundFiveRulings.spread_still_open_example` | Example (five seats): one original no plus a new no in the only reassessment so far: the council is still deliberating. |
| `RoundFiveRulings.phoenix_threshold_suffices` | **2.42× is enough.** If non-phoenix dragons are at most 2.2× a non-dragon player's skill `b` and elemental players at most `b`, a phoenix at 2.42× `b` or more satisfies the rule. |
| `RoundFiveRulings.phoenix_threshold_needed` | **…and 2.42× is the least that works** when some non-phoenix dragon sits at the 2.2× top. |
| `RoundFiveRulings.completable_iff_entry` | **Every quest has an exact entry skill**: it is completable exactly from that skill up. |
| `RoundFiveRulings.leveled_or_sub_completable` | **Leveled and sub-leveled quests can be completed now**: their entry skill is at or below the player's skill. |
| `RoundFiveRulings.epic_locked_until_entry` | **Epic training quests stay locked until the player is ready**: above the player's level the end goal can't be reached, and it becomes reachable exactly once the player's skill reaches the quest's entry skill. |
| `RoundFiveRulings.gate_example` | Example: a one-stage training quest teaching 3, gated at skill 10, needs starting skill 7. |
| `RoundFiveRulings.payee_user_iff` | The arenas take exactly the royalties that no user receives under the fourth ruling. |
| `RoundFiveRulings.hardReset_to_arena` | **A hard-reset user's royalties go to the developer arenas.** |
| `RoundFiveRulings.hardReset_arena_gain` | **A hard reset moves exactly that user's share into the arenas.** |
| `RoundFiveRulings.hardReset_user_zero` | **After a hard reset the user receives nothing.** |
| `RoundFiveRulings.hardReset_other_user` | **Other users' shares are unchanged.** |
| `RoundFiveRulings.meditate_needs_safe_zone` | **Meditation outside a safe zone, or in combat, does nothing.** |
| `RoundFiveRulings.meditate_locks_in` | **Meditation in a safe zone locks in that skill's progress.** |
| `RoundFiveRulings.locked_only_by_meditation` | **No auto-levelling.** In any run without a safe-zone meditation, no locked skill changes. |
| `RoundFiveRulings.total_progress` | **Progress is never lost.** Each step changes locked-plus-banked progress in a skill by exactly what that step trains. |

### `RequestProject/RoundFour/Attribution.lean` (8)

| Theorem | What it says |
| --- | --- |
| `RoundFour.Attribution.chain_split_sum` | A keep-`(1 - r)`, pass-`r` chain always distributes exactly 100 %. |
| `RoundFour.Attribution.sixty_forty_sum` | The 60/40 mutation rule (`r = 3/5`) pays out exactly 100 % for every chain length. |
| `RoundFour.Attribution.progenitor_three_overpays` | Under the depth reading, three ancestors already receive `13/12 > 100 %`. |
| `RoundFour.Attribution.progenitor_unbounded` | Under the depth reading, the total payout grows without bound. |
| `RoundFour.Attribution.equal_shares_sum` | Contributor reading of "1/(n+1)": `n` contributors each receive `1/(n+1)`; the total is `n/(n+1)`, below 100 %. |
| `RoundFour.Attribution.golden_split_sum` | The 61.8 % / 23.6 % / 14.6 % golden split adds up exactly: `1/φ + 1/φ³ + 1/φ⁴ = 1`. |
| `RoundFour.Attribution.golden_two_layers_exhaust` | With first layer `P/φ` and ratio `1/φ`, the first two layers already use the whole pool: `P/φ + P/φ² = P`. |
| `RoundFour.Attribution.sixty_forty_near_golden` | The 60/40 rule is the golden split, rounded: `\|3/5 - 1/φ\| < 1/50`. |

### `RequestProject/RoundFour/Checks.lean` (16)

| Theorem | What it says |
| --- | --- |
| `RoundFour.Checks.clock_readings_count` | _(no docstring: supporting step)_ |
| `RoundFour.Checks.clock_palindromes` | Exactly 57 of the 720 readings are palindromes. |
| `RoundFour.Checks.pentagrid_pairs` | _(no docstring: supporting step)_ |
| `RoundFour.Checks.pentagrid_thin_pairs` | _(no docstring: supporting step)_ |
| `RoundFour.Checks.pentagrid_raw_tiles` | With line indices `-L..L` there are `10 (2L+1)²` raw intersections; `L = 4` gives 810. |
| `RoundFour.Checks.script_corner_order_not_cycle` | The script lists corners as `n, n - e_k, n - e_m, n - e_k - e_m`. |
| `RoundFour.Checks.fixed_corner_order_cycle` | The corrected order `n, n - e_k, n - e_k - e_m, n - e_m` walks four edges. |
| `RoundFour.Checks.dried_mass_general` | Drying only removes water, so the dry mass `M (1 - p)` is conserved; at water fraction `q` the total mass is `M (1 - p) / (1 - q)`. |
| `RoundFour.Checks.dried_mass` | 100 kg at 99 % water, dried to 98 % water, weighs 50 kg. |
| `RoundFour.Checks.closed_system_net_force` | Internal forces obey Newton's third law, `F i j = -F j i`, so they cancel in total and the net (vertical) force on a closed device is just its weight `-(Σ mᵢ) g`. |
| `RoundFour.Checks.closed_system_cannot_rise` | With positive mass and gravity, the net vertical force on a closed device is downward: spinning, pumping or pulsing parts inside cannot make it rise. |
| `RoundFour.Checks.apple_unbounded` | Nothing stops repeated use, and any weight above 1 is pumped past every bound. |
| `RoundFour.Checks.apple_once_bounded` | With the flag cleared after use, any number of apples leaves the weight at `w` or `w²`. |
| `RoundFour.Checks.altar_center_mode` | Centre mode: trays covering half the width leave a quarter of the table exposed at each end, i.e. |
| `RoundFour.Checks.altar_stacked_footprint` | Four trays that together cover half the table each have footprint `1/8`; stacked, they cover `1/8` of the table, a quarter of the half-table sand zone. |
| `RoundFour.Checks.sanctuary_balance` | The proposed numbers give an even game: 53 % overall, from 95 % (Big Dog against a rank-1 threat) down to 15 % (Gnome against a rank-6 threat). |

### `RequestProject/RoundFour/H4.lean` (16)

| Theorem | What it says |
| --- | --- |
| `RoundFour.H4.toReal_add` | _(no docstring: supporting step)_ |
| `RoundFour.H4.toReal_mul` | The model multiplies like the reals `a + b√5`. |
| `RoundFour.H4.toReal_one` | _(no docstring: supporting step)_ |
| `RoundFour.H4.phi_mul_iphi` | _(no docstring: supporting step)_ |
| `RoundFour.H4.icosians_length` | _(no docstring: supporting step)_ |
| `RoundFour.H4.icosians_nodup` | _(no docstring: supporting step)_ |
| `RoundFour.H4.icosians_unit` | _(no docstring: supporting step)_ |
| `RoundFour.H4.icosians_unit_real` | The unit-norm identity, over the real numbers. |
| `RoundFour.H4.orig_not_equal_length` | The scripts' roots do not have a common length (`\|α₁\|² = 2`, but `\|α₄\|² = 9/8` in the exact script and `5/4` in the floating-point ones), so they are not an H₄ simple system. |
| `RoundFour.H4.orig_first_pair_angle` | The first pair meets at 120°: the Cartan entry `2⟨α₁,α₂⟩/⟨α₂,α₂⟩` is `-1` (Coxeter label 3), although the scripts' diagram puts the label 5 there. |
| `RoundFour.H4.fixedSimple_mem` | The corrected roots are themselves among the 120 icosians. |
| `RoundFour.H4.fixedSimple_gram` | The corrected roots have the H₄ Coxeter Gram matrix `⟨αᵢ,αⱼ⟩ = -cos(π/mᵢⱼ)` with `m₁₂ = 5`, `m₂₃ = m₃₄ = 3` and all other pairs `2`. |
| `RoundFour.H4.cos_pi_div_five_eq` | `cos 36° = φ/2`, so `-(half * phi)` really is `-cos(π/5)`. |
| `RoundFour.H4.fixed_reflections_preserve_icosians` | Each corrected reflection maps the 600-cell's vertex set to itself. |
| `RoundFour.H4.gen_mem` | _(no docstring: supporting step)_ |
| `RoundFour.H4.orbit_stays_in_icosians` | Every reflection orbit of a root stays inside the 120 vertices of the 600-cell, so the orbit search in the corrected engine terminates (it cannot pass 120 points). |

### `RequestProject/RoundFour/PlayerRounding.lean` (11)

| Theorem | What it says |
| --- | --- |
| `RoundFourRounding.playerCost_le_exact` | **Never pays more than the exact amount.** |
| `RoundFourRounding.exact_le_playerPayout` | **Never receives less than the exact amount.** |
| `RoundFourRounding.playerCost_le_playerPayout` | The two directions differ by at most one unit. |
| `RoundFourRounding.half_cost_eq_halfDown` | Halving a cost in the player's favour is `halfDown`. |
| `RoundFourRounding.half_payout_eq_halfUp` | Halving a payout in the player's favour is `halfUp`. |
| `RoundFourRounding.small_conversion_untaxed` | **Small conversions are tax-free.** Any conversion of 49 or less pays no tax. |
| `RoundFourRounding.large_conversion_taxed` | From 50 upwards a single conversion does pay tax. |
| `RoundFourRounding.split_never_costs_more` | **Splitting never costs more** than converting the whole amount at once. |
| `RoundFourRounding.exists_untaxed_split` | **Every amount can be split into tax-free pieces** of at most 49. |
| `RoundFourRounding.runningTax_split_invariant` | With a running total the tax charged depends only on the total converted, never on how it was split. |
| `RoundFourRounding.playerKeep_never_gains` | **No currency from nothing.** However many conversions are chained, the player never ends with more than they started with. |

### `RequestProject/RoundFour/Rulings.lean` (23)

| Theorem | What it says |
| --- | --- |
| `RoundFourRulings.playerTax_eq_zero_iff` | A conversion is tax-free exactly when it is at most 49. |
| `RoundFourRulings.untaxed_split_needs_many` | **Dodging the tax takes time.** If every piece of a split pays no tax, there are at least `T / 49` pieces, where `T` is the total. |
| `RoundFourRulings.avoidable_tax_le` | **The most the tax can be dodged by.** Splitting can save at most the one-shot tax on the total, and that is at most 2 % of the total. |
| `RoundFourRulings.hatch_valid` | _(no docstring: supporting step)_ |
| `RoundFourRulings.step_valid` | _(no docstring: supporting step)_ |
| `RoundFourRulings.run_valid` | **The rule always holds.** Starting from any valid state, every sequence of gains and alignments keeps the rule. |
| `RoundFourRulings.phoenix_hatches_with_fire` | **A phoenix hatches with fire.** *Superseded* by `RoundFourRulingsTwo.phoenix_hatches_unlit_with_fire` (second Round Four ruling: a phoenix hatches unlit, with the fire ability gained but not active). |
| `RoundFourRulings.fire_open_to_all` | **Fire is open to every dragon.** A non-phoenix dragon that gains fire and aligns with it has fire active. |
| `RoundFourRulings.phoenix_half_rate` | **Half rate for the phoenix.** A phoenix pays at most half the standard price (rounded down), never more than another dragon, and strictly less whenever the price isn't zero. |
| `RoundFourRulings.run_phoenix` | Gaining elements never changes whether a dragon is a phoenix. |
| `RoundFourRulings.gainAll_spent` | _(no docstring: supporting step)_ |
| `RoundFourRulings.phoenix_spends_no_more` | **A phoenix never spends more.** Gaining the same elements at the same standard prices, a phoenix spends at most what any other dragon spends, and at most half of it. |
| `RoundFourRulings.five_element_phoenix` | **Five-element phoenix.** A phoenix that gains water, earth, air and ether has all five elements active at once. |
| `RoundFourRulings.other_at_most_one_active` | **Other dragons align with one element at a time.** However a non-phoenix dragon plays, it never has more than one element active. |
| `RoundFourRulings.phoenix_all_active` | **A phoenix has everything it has gained active.** *Superseded* by `RoundFourRulingsTwo.phoenix_any_selection` (second Round Four ruling: a phoenix chooses which and how many gained elements are active). |
| `RoundFourRulings.pulling_effect_aggroes_caster` | **Pulling effects aggro the one who causes them**, for the full 10 minutes. |
| `RoundFourRulings.other_effect_no_new_aggro` | **Other effects start no aggro.** |
| `RoundFourRulings.effect_no_grief` | **No griefing.** An effect caused by `i` never changes anyone else's timer. |
| `RoundFourRulings.one_rejection_not_blocking` | **One rejection no longer blocks.** Whenever the threshold is short of unanimity (`num < den`), a council with one rejection and enough approvals reaches consensus. |
| `RoundFourRulings.unanimity_is_veto` | **Unanimity brings the veto back.** If the council requires every vote (`num = den > 0`), a single rejection blocks consensus. |
| `RoundFourRulings.approval_keeps_consensus` | **Approvals only help.** Adding an approval never breaks consensus, as long as the threshold is at most unanimity. |
| `RoundFourRulings.release_needs_both` | **Real-world release needs both.** |
| `RoundFourRulings.humans_can_decline` | **The humans can always decline.** |

### `RequestProject/RoundFour/RulingsFour.lean` (23)

| Theorem | What it says |
| --- | --- |
| `RoundFourRulingsFour.phoenix_switch_in_combat` | **A phoenix may switch mid-battle.** For a phoenix, combat changes nothing. |
| `RoundFourRulingsFour.phoenix_all_learned_active` | **A phoenix can have all its learned elements active at once**, in combat or not. |
| `RoundFourRulingsFour.stepL_valid` | _(no docstring: supporting step)_ |
| `RoundFourRulingsFour.runL_valid` | **The rules always hold.** |
| `RoundFourRulingsFour.pending_not_active` | **A pending element can't be used.** In a valid state, an element whose orb has levelled up but that hasn't been locked in is never active. |
| `RoundFourRulingsFour.combat_no_new_element` | **Combat never adds a usable element.** Whatever happens in one step of combat, the set of learned elements is unchanged. |
| `RoundFourRulingsFour.lockIn_needs_safe_zone` | **Meditation needs a safe zone, out of combat.** Elsewhere it does nothing. |
| `RoundFourRulingsFour.lockIn_in_safe_zone` | **Meditation in a safe zone locks the element in.** |
| `RoundFourRulingsFour.levelOrb_in_combat` | **Orb levelling works even in combat**, but only makes the element pending. |
| `RoundFourRulingsFour.unanimous_passes` | **Unanimous first round passes.** |
| `RoundFourRulingsFour.nay_needs_reassessment` | **Any no vote sends the motion to reassessment**, and the outcome is decided there. |
| `RoundFourRulingsFour.pass_has_four_fifths` | **Passing always means 4/5 approval in the round of record**: either the first round was unanimous, or the reassessment round reached 4/5. |
| `RoundFourRulingsFour.reassessment_can_fail` | **One first-round no can still end in failure.** In a five-seat council, a single no in the first round followed by two noes after reassessment fails. |
| `RoundFourRulingsFour.reassessment_can_pass` | **…and it can pass.** If the reassessment keeps one no, a five-seat council passes. |
| `RoundFourRulingsFour.hardReset_no_royalty` | **No royalties after a hard reset.** |
| `RoundFourRulingsFour.hardReset_others_royalty` | **Other users' royalties are unchanged.** |
| `RoundFourRulingsFour.lessonAt_usable` | **Every lesson offered is usable at the player's level.** |
| `RoundFourRulingsFour.fair_iff_completable` | **Fair quests are exactly the completable ones.** |
| `RoundFourRulingsFour.completable_mono` | **A stronger player can do whatever a weaker one can.** |
| `RoundFourRulingsFour.fair_stage_le_total` | **No stage asks for more than the player can obtain before the quest ends**: starting skill plus everything the quest teaches. |
| `RoundFourRulingsFour.band_allows_wider_gap` | **The two readings differ.** With base 100, strengths 180 and 220 are both within 10% of the 2× baseline, but 220 is about 22% above 180. |
| `RoundFourRulingsFour.anchored_satisfies_both` | **Anchoring satisfies both readings.** If every non-phoenix dragon sits between exactly 2× and 2.2× a non-dragon player's skill, each is in the band and any two are within 10%. |
| `RoundFourRulingsFour.band_at_least` | **A dragon is always at least 1.8× a non-dragon player** under reading A. |

### `RequestProject/RoundFour/RulingsThree.lean` (21)

| Theorem | What it says |
| --- | --- |
| `RoundFourRulingsThree.combat_freezes_switch` | **No switching in combat.** A dragon that isn't a phoenix and is actively in combat keeps its active elements, whatever switch it tries. |
| `RoundFourRulingsThree.switch_out_of_combat` | **Switching anywhere out of combat.** Out of combat, whether or not in a safe zone, a switch works exactly as it did before the restriction. |
| `RoundFourRulingsThree.safe_zone_irrelevant` | **No safe zone needed.** For a dragon out of combat, being outside a safe zone gives the same result as being inside one. |
| `RoundFourRulingsThree.gain_in_combat` | **Gaining is never blocked**, even in combat. |
| `RoundFourRulingsThree.stepC_valid` | _(no docstring: supporting step)_ |
| `RoundFourRulingsThree.stepC_phoenix` | _(no docstring: supporting step)_ |
| `RoundFourRulingsThree.runC_valid` | **The element rule still always holds.** Any sequence of steps, each in or out of combat, keeps a valid dragon valid. |
| `RoundFourRulingsThree.runC_phoenix` | _(no docstring: supporting step)_ |
| `RoundFourRulingsThree.other_at_most_one_activeC` | **Non-phoenix dragons keep at most one active element**, in or out of combat. |
| `RoundFourRulingsThree.no_single_veto` | **No single veto.** In any allowed council, one rejection never blocks consensus: if every vote but one is an approval, the council reaches 4/5 consensus. |
| `RoundFourRulingsThree.public_absorbs_two` | **A public council absorbs two rejections.** |
| `RoundFourRulingsThree.small_council_not_allowed` | **The small-council veto can't happen.** No allowed council has four or fewer votes. |
| `RoundFourRulingsThree.ten_two_three` | In a council of exactly ten, two rejections pass and three don't. |
| `RoundFourRulingsThree.hardReset_public_anonymous` | **Public records of a reset user are shown as anonymous.** |
| `RoundFourRulingsThree.hardReset_keeps_visibility` | **The content stays public.** A hard reset changes no record's visibility. |
| `RoundFourRulingsThree.hardReset_admin_sees_user` | **The development team and administrators still see the real user.** |
| `RoundFourRulingsThree.hardReset_others_unchanged` | **Nobody else's records change.** |
| `RoundFourRulingsThree.lesson_not_on_menu` | **A lesson is never on the menu**, so the menu rule ("only what you can do now") is untouched. |
| `RoundFourRulingsThree.lesson_near_level` | **Lessons start at the player's level.** Every lesson is within `stretch` levels of the player's skill, and above it. |
| `RoundFourRulingsThree.lesson_then_menu` | **Finishing the lesson opens the menu entry.** Once the player's skill reaches the lesson's level, its option is on the menu. |
| `RoundFourRulingsThree.confirmedPairing_bijective` | **The confirmed pairing is one-to-one and covers all three builds.** |

### `RequestProject/RoundFour/RulingsTwo.lean` (25)

| Theorem | What it says |
| --- | --- |
| `RoundFourRulingsTwo.hatch'_valid` | _(no docstring: supporting step)_ |
| `RoundFourRulingsTwo.step'_phoenix` | _(no docstring: supporting step)_ |
| `RoundFourRulingsTwo.run'_phoenix` | _(no docstring: supporting step)_ |
| `RoundFourRulingsTwo.step'_valid` | _(no docstring: supporting step)_ |
| `RoundFourRulingsTwo.run'_valid` | **The second rule always holds.** Starting from any valid state, every sequence of gains, activations, deactivations and selections keeps it. |
| `RoundFourRulingsTwo.phoenix_hatches_unlit_with_fire` | **A phoenix hatches unlit, with the fire ability.** It has fire gained, nothing active, and it paid nothing for it. |
| `RoundFourRulingsTwo.phoenix_lights_up` | **The flame is one action away.** A newly hatched phoenix that activates fire is aflame. |
| `RoundFourRulingsTwo.fire_open_to_all'` | **Fire is open to every dragon.** A non-phoenix dragon that gains fire and activates it has fire active. |
| `RoundFourRulingsTwo.phoenix_select` | **A phoenix picks its active elements.** Selecting a set gives exactly the selected elements it has gained. |
| `RoundFourRulingsTwo.phoenix_any_selection` | **Any choice is reachable.** For a phoenix, every set of gained elements, of any size (including none), is the active set after one selection. |
| `RoundFourRulingsTwo.deactivate_off` | **Switching an element off works.** |
| `RoundFourRulingsTwo.other_at_most_one_active'` | **Other dragons still have at most one element active**, however they play. |
| `RoundFourRulingsTwo.five_element_phoenix_by_choice` | **A five-element phoenix, by choice.** A phoenix that gains water, earth, air and ether and then selects all five has all five active. |
| `RoundFourRulingsTwo.phoenix_partial_choice` | **A phoenix need not run everything.** The same five-element phoenix can select only water and air, leaving the others off. |
| `RoundFourRulingsTwo.council_iff_rejections` | **How many rejections a council absorbs.** A council reaches 4/5 consensus exactly when five times the number of rejections is at most the number of votes, i.e. |
| `RoundFourRulingsTwo.council_iff_rejections_div` | The same count, written with division: at most `n / 5` rejections. |
| `RoundFourRulingsTwo.small_council_needs_all` | **Small councils need every vote.** With four or fewer votes cast, one rejection blocks consensus: the old single veto returns for councils that small. |
| `RoundFourRulingsTwo.five_one_rejection` | **Five votes absorb one rejection.** |
| `RoundFourRulingsTwo.five_two_rejections` | **Five votes don't absorb two.** |
| `RoundFourRulingsTwo.four_one_rejection` | **Four votes don't absorb one.** Three of four (75 %) is short of 4/5. |
| `RoundFourRulingsTwo.monster_window_same` | _(no docstring: supporting step)_ |
| `RoundFourRulingsTwo.submit_publishes_attachments` | **Attachments become public record.** |
| `RoundFourRulingsTwo.submit_keeps_unattached` | **Private conversations that aren't attached stay as they were.** |
| `RoundFourRulingsTwo.council_build_all_public` | **Nothing private goes forward with the council.** After submission, every item in the build is public record. |
| `RoundFourRulingsTwo.pairing_bijective` | **The proposed pairing is one-to-one and covers all three builds.** |

### `RequestProject/RoundFourteen/SpamFilterAndRules.lean` (14)

| Theorem | What it says |
| --- | --- |
| `RoundFourteen.opening_burst_never_triggers` | **Loophole 1 (the opening burst).** Any number of messages sent inside the first five minutes of a session never triggers the filter. |
| `RoundFourteen.drip_aux` | _(no docstring: supporting step)_ |
| `RoundFourteen.steady_drip_never_triggers` | **Loophole 2 (the steady drip).** One message every 30 seconds, forever, never triggers the filter: that is 120 messages an hour from a single account. |
| `RoundFourteen.step_bounded` | _(no docstring: supporting step)_ |
| `RoundFourteen.foldl_bounded` | _(no docstring: supporting step)_ |
| `RoundFourteen.patched_filter_bounded` | **The patched filter's guarantee.** For any stream of message times in order, every window of `w` seconds carries at most `k` accepted messages from that account. |
| `RoundFourteen.owner_can_always_edit` | _(no docstring: supporting step)_ |
| `RoundFourteen.others_cannot_edit` | _(no docstring: supporting step)_ |
| `RoundFourteen.edit_needs_regauntlet` | An edited bubble is not republished until it goes back through the gauntlet. |
| `RoundFourteen.regauntlet_republishes` | _(no docstring: supporting step)_ |
| `RoundFourteen.seat_needs_all_three` | _(no docstring: supporting step)_ |
| `RoundFourteen.recall_never_interrupts` | _(no docstring: supporting step)_ |
| `RoundFourteen.recall_when_idle` | _(no docstring: supporting step)_ |
| `RoundFourteen.under18_general_only` | _(no docstring: supporting step)_ |

### `RequestProject/RoundNine/FifthPassNine.lean` (20)

| Theorem | What it says |
| --- | --- |
| `RoundNineFifth.contribTotal_le_pot` | _(no docstring: supporting step)_ |
| `RoundNineFifth.sales_split_le_total` | The three parts of the split never pay out more than the sale. |
| `RoundNineFifth.contrib_share_monotone` | A contributor with more weight is never paid less. |
| `RoundNineFifth.taxed_split_le_gross` | Taking the 3% tax first and splitting what is left never pays out more than the gross sale. |
| `RoundNineFifth.closeBubble_safe` | Only minors can be unprotected and guardians are adults, so closing the bubble never removes a guardian, and the room left behind is always safe. |
| `RoundNineFifth.safeLeave_safe` | _(no docstring: supporting step)_ |
| `RoundNineFifth.gatedJoin_safe` | _(no docstring: supporting step)_ |
| `RoundNineFifth.room_run_safe` | Over any sequence of joins and leaves, starting from a safe room, every room stays safe. |
| `RoundNineFifth.no_private_adult_minor` | In a safe room, an adult who is not the child's guardian is never alone with the child. |
| `RoundNineFifth.no_private_under13` | In a safe room, an under-13 is never alone with another player who is not their guardian. |
| `RoundNineFifth.naive_leave_breaks_safety` | With the guardian present the room is safe; if the guardian just leaves (no bubble closing), the teacher and child are left alone and the room is unsafe. |
| `RoundNineFifth.safe_leave_moves_child_out` | With the close-the-bubble rule, the child is moved out when the guardian leaves. |
| `RoundNineFifth.half_weight_can_override` | Half weight alone can override the engaged players: 1 engaged yes, 2 engaged no, 3 outside yes. |
| `RoundNineFifth.half_weight_override_needs` | Outside voters can only override an engaged "no" majority if their yes votes are more than twice the engaged margin. |
| `RoundNineFifth.locked_never_overrides` | With the lock, the result always matches the engaged majority when they aren't tied. |
| `RoundNineFifth.total_time_le_caps` | With a daily cap per platform, total time never exceeds the sum of the caps. |
| `RoundNineFifth.locked_platform_no_time` | A platform the parent locks (cap 0) gets no time at all. |
| `RoundNineFifth.tier_le_passed_checks` | The tier never rises by more than the number of checks passed. |
| `RoundNineFifth.no_check_no_graduation` | A run with no passed check never moves an account up. |
| `RoundNineFifth.damaged_split_conserves` | Nothing is lost or created: owner's part plus DEVPOOL's part is the whole income, and the DEVPOOL never gets more than the owner. |

### `RequestProject/RoundNine/FourthPassNine.lean` (23)

| Theorem | What it says |
| --- | --- |
| `RoundNineFourth.allRolls_length` | _(no docstring: supporting step)_ |
| `RoundNineFourth.greedy_bust_iff_score_zero` | A roll of six dice scores nothing exactly when it is a bust. |
| `RoundNineFourth.greedy_six_dice_busts` | Of the 46,656 ways six dice can land, exactly 1,440 are busts. |
| `RoundNineFourth.greedy_bank_monotone` | Banked points never go down, over any sequence of rolls, busts and stops. |
| `RoundNineFourth.sum_div_le` | _(no docstring: supporting step)_ |
| `RoundNineFourth.pool_payout_le_net` | The winners together never receive more than the net pool. |
| `RoundNineFourth.pool_tax_plus_payout_le_pool` | Tax plus payouts never exceed what was staked. |
| `RoundNineFourth.pool_payout_monotone` | A bigger winning stake never gets a smaller payout. |
| `RoundNineFourth.ratStep_total` | _(no docstring: supporting step)_ |
| `RoundNineFourth.ratSlap_run_total` | The number of cards in play never changes, over any sequence of plays and slaps. |
| `RoundNineFourth.gauntlet_min_yes` | With 13 seats and a 66% supermajority, 9 yes votes is the minimum. |
| `RoundNineFourth.gauntlet_nine_four_passes` | _(no docstring: supporting step)_ |
| `RoundNineFourth.gauntlet_nine_of_thirteen_pct` | 9 of 13 is 69% (rounded down, and also to the nearest percent). |
| `RoundNineFourth.gauntlet_seven_active_cannot_pass` | With only 7 members active, no vote can reach the 66% supermajority of 13 seats. |
| `RoundNineFourth.gauntlet_64_below_threshold` | _(no docstring: supporting step)_ |
| `RoundNineFourth.ghostRider_skill` | _(no docstring: supporting step)_ |
| `RoundNineFourth.ghostRider_harmony` | _(no docstring: supporting step)_ |
| `RoundNineFourth.ghostRider_whatever` | _(no docstring: supporting step)_ |
| `RoundNineFourth.rind_merges_opposites` | A safety rule and its opposite come out of the "rind to fruit" step as the same text. |
| `RoundNineFourth.no_recovery_of_merged` | Once two different texts are merged, no later step can recover which one was meant. |
| `RoundNineFourth.rind_not_recoverable` | _(no docstring: supporting step)_ |
| `RoundNineFourth.safetyLevel_cliff` | _(no docstring: supporting step)_ |
| `RoundNineFourth.safetyLevel_not_monotone` | A more positive text can get a lower safety level. |

### `RequestProject/RoundNine/OpeningNine.lean` (36)

| Theorem | What it says |
| --- | --- |
| `RoundNineOpening.creator_veto` | **An active creator's "no" blocks the change.** |
| `RoundNineOpening.approved_needs_council_and_human` | **Nothing goes through without the Galactic council and a human.** |
| `RoundNineOpening.inactive_needs_dev_consensus` | **When the creator can't decide (inactive, unavailable, or a mutated schematic), the whole DEV team must agree.** |
| `RoundNineOpening.one_dev_blocks` | **One DEV member's "no" blocks a change to a design whose creator can't decide.** |
| `RoundNineOpening.approved_iff_all_active` | **When every affected creator is active (and no design is mutated), the creators, the council and a human decide; the DEV team's agreement isn't needed.** |
| `RoundNineOpening.work_protected` | **Everybody's work is protected.** Over any sequence of proposals, if every proposal that touches design `i` found its creator active and deciding, and that creator said no, design `i` is exactly as it was. |
| `RoundNineOpening.unsigned_edit_diamond` | **An unsigned edit never changes a 💎 entry.** |
| `RoundNineOpening.diamond_locked` | **Diamond lock.** Over any sequence of edits, a 💎 entry that no owner-signed edit targets keeps its value. |
| `RoundNineOpening.altered_copy_fails` | **A copy with any altered 💎 value fails the official check.** |
| `RoundNineOpening.slot_iff_gold` | **Only gold-locked orbs can be slotted.** |
| `RoundNineOpening.starter_fills_matrix` | **The 64 starter orbs exactly fill the matrix.** |
| `RoundNineOpening.orbStep_sum_le` | _(no docstring: supporting step)_ |
| `RoundNineOpening.levels_only_from_training` | **Every skill level in the world was trained by someone.** Crafting, deconstructing and trading never add levels: the total of all orb levels grows by at most one per training step. |
| `RoundNineOpening.count_mul_le_sum` | _(no docstring: supporting step)_ |
| `RoundNineOpening.gold_needs_training` | **Gold orbs take training.** In a world whose orbs all start empty, after any sequence of steps, (number of gold-locked orbs) × 100 ≤ (number of training steps). |
| `RoundNineOpening.sixtyfour_gold_cost` | **A full 64-node gold matrix costs at least 6,400 training steps** across the world, starting from empty orbs; crafting, deconstructing and trading can't shortcut it. |
| `RoundNineOpening.elemStep_ok` | _(no docstring: supporting step)_ |
| `RoundNineOpening.elemRun_ok` | _(no docstring: supporting step)_ |
| `RoundNineOpening.mastered_nodup` | **No element is ever mastered twice.** |
| `RoundNineOpening.elemStep_prefix` | _(no docstring: supporting step)_ |
| `RoundNineOpening.mastered_prefix` | **Mastered elements are never lost**: the mastered list only grows at the end. |
| `RoundNineOpening.train_masters` | Training an element that is `k + 1` steps from mastery, `k + 1` times, masters it. |
| `RoundNineOpening.any_path_achievable` | **Any order the player chooses can be followed.** For any list of distinct elements, there is a sequence of choices and training that masters exactly those elements in exactly that order. |
| `RoundNineOpening.setPolicy_unauthorized` | **Only the owner or a DEV can change a skybox's access.** |
| `RoundNineOpening.setPolicy_authorized` | **The owner (or a DEV) gets exactly the setting they chose.** |
| `RoundNineOpening.owner_can_enter` | **The owner can always enter their own skybox.** |
| `RoundNineOpening.private_only_owner` | **A private skybox admits only its owner.** |
| `RoundNineOpening.optionA_total_le` | **Option A never uses more than 33% of a pool.** |
| `RoundNineOpening.optionB_fits_iff` | **Option B fits exactly when `3·creators + 30·collaborators ≤ 100`.** |
| `RoundNineOpening.optionB_cap` | **With one creator, option B allows at most three collaborators** (3 + 90 = 93%; four would be 123%). |
| `RoundNineOpening.optionC_total_le` | **Option C always fits in the pool.** |
| `RoundNineOpening.optionC_ratio` | **Option C keeps every collaborator at exactly ten times a creator**, whether or not it had to scale down. |
| `RoundNineOpening.optionC_example` | Worked example for option C: one creator and six collaborators claim 183%. |
| `RoundNineOpening.stack_table_5` | Table for a 5% stacking cost: 100%, 95%, 90%, 85%, 80%. |
| `RoundNineOpening.stack_table_10` | Table for a 10% stacking cost: 100%, 90%, 80%, 70%, 60%. |
| `RoundNineOpening.phoenix_ge_stacked` | **For any stacking cost `d ≥ 0`, a phoenix running `k ≤ 5` elements is at least as strong in each as an ordinary dragon running the same number**, and strictly stronger whenever `k < 5` or `d > 0`. |

### `RequestProject/RoundNine/SecondPassNine.lean` (31)

| Theorem | What it says |
| --- | --- |
| `RoundNineSecond.creator_no_blocks_official` | **An active creator's "no" blocks a direct edit or an adoption.** |
| `RoundNineSecond.official_needs_council_and_human` | **Official changes need the Galactic council and a human.** |
| `RoundNineSecond.inactive_needs_all_devs` | **If the creator is inactive, an official change needs every DEV on the team.** |
| `RoundNineSecond.mutation_free` | **A mutated schematic needs nobody's permission**: the creator has no control over it. |
| `RoundNineSecond.mutation_keeps_original` | **A mutation never changes the original design.** |
| `RoundNineSecond.work_protected_v2` | **Everybody's work is protected, version 2.** Over any sequence of requests in which the creator stays active and never says yes to an official request, the design is never edited and never taken into the permanent ga... |
| `RoundNineSecond.train_needs_node` | **Training an orb that isn't active in a node slot does nothing.** |
| `RoundNineSecond.toMatrix_needs_gold` | **A non-gold orb can't go into the matrix.** |
| `RoundNineSecond.matrixGold_erase` | _(no docstring: supporting step)_ |
| `RoundNineSecond.orbStep_matrixGold` | _(no docstring: supporting step)_ |
| `RoundNineSecond.matrix_always_gold` | **The matrix only ever holds gold-locked orbs**, whatever happens. |
| `RoundNineSecond.levelSum_erase` | _(no docstring: supporting step)_ |
| `RoundNineSecond.orbStep_levelSum` | _(no docstring: supporting step)_ |
| `RoundNineSecond.levels_from_training_or_marksman` | **Levels come only from training and marksman rewards.** Crafting, deconstructing, slotting and trading never add levels: the world's total grows by at most one per training step and 100 per marksman reward. |
| `RoundNineSecond.matrix_count_le` | _(no docstring: supporting step)_ |
| `RoundNineSecond.full_matrix_cost` | **A full 64-orb matrix needs at least 6,400 − 100 × (marksman rewards) training steps**, starting from a world of empty orbs with an empty matrix. |
| `RoundNineSecond.full_matrix_cost_no_rewards` | **With no marksman rewards, a full matrix costs at least 6,400 training steps.** |
| `RoundNineSecond.full_matrix_cost_two_rewards` | **If marksman rewards are capped at two (levels one and two), a full matrix still costs at least 6,200 training steps.** |
| `RoundNineSecond.krion_other_slot_unchanged` | **The bonus on one slot doesn't touch any other slot.** Turning slot `j` into a KRION slot leaves every other slot's value as it was. |
| `RoundNineSecond.krion_total` | **The total gain is a quarter of the values of the orbs in KRION slots.** |
| `RoundNineSecond.ratio_table` | **Worked numbers (ordinary one-element dragon = 100):** primary 100, each stacked element about 58.33 (exactly 175/3). |
| `RoundNineSecond.phoenix_ge_any_capped` | **The phoenix stays at least as strong under any capped stacking rule.** If no element of an ordinary dragon running `k ≤ 5` elements is ever stronger than a one-element ordinary dragon, a phoenix running `k` elements... |
| `RoundNineSecond.ratio_capped` | **The 3 : 1.75 rule is capped**: no element goes above a one-element dragon. |
| `RoundNineSecond.phoenix_beats_ratio` | **So the phoenix stays ahead of the 3 : 1.75 rule**, element by element, at every count. |
| `RoundNineSecond.owner_full_access_v3` | **The owner can do everything in their own skybox.** |
| `RoundNineSecond.grants_mono` | _(no docstring: supporting step)_ |
| `RoundNineSecond.guest_tier_mono` | **A guest with tier `t` can do everything that needs tier `t` or less.** |
| `RoundNineSecond.private_guest_gets` | **A guest given tier `u` in a private skybox gets exactly the tiers up to `u`** (when they appear once on the list). |
| `RoundNineSecond.stranger_kept_out` | **Someone not on the guest list can't enter a private skybox.** |
| `RoundNineSecond.private_no_guests` | **A private skybox with no guests is owner-only.** |
| `RoundNineSecond.setAccess_unauthorized` | **Only the owner or a DEV can change a skybox's access or guest list.** |

### `RequestProject/RoundNine/ThirdPassNine.lean` (21)

| Theorem | What it says |
| --- | --- |
| `RoundNineThird.up_rightUnique` | _(no docstring: supporting step)_ |
| `RoundNineThird.inside_depth` | _(no docstring: supporting step)_ |
| `RoundNineThird.inside_eq_of_depth` | _(no docstring: supporting step)_ |
| `RoundNineThird.inside_antisymm` | _(no docstring: supporting step)_ |
| `RoundNineThird.nearestStar_unique` | There is at most one nearest star. |
| `RoundNineThird.nearestStar_exists` | Anything inside at least one star has a nearest star. |
| `RoundNineThird.nearestStar_of_no_nested` | If no star sits inside another star's universe, the nearest star of anything inside a star is that star: everything inside a solar box belongs to its dragon. |
| `RoundNineThird.domains_disjoint` | With no nested stars, two dragons' domains never overlap. |
| `RoundNineThird.submit_forwards_iff` | An idea is forwarded to the DEVs exactly when it isn't already in the wiki. |
| `RoundNineThird.submit_good` | _(no docstring: supporting step)_ |
| `RoundNineThird.run_good` | _(no docstring: supporting step)_ |
| `RoundNineThird.run_inbox_nodup` | Starting from an empty inbox, no idea ever reaches the DEVs twice. |
| `RoundNineThird.known_subset_submit` | _(no docstring: supporting step)_ |
| `RoundNineThird.known_subset_run` | _(no docstring: supporting step)_ |
| `RoundNineThird.mem_known_submit` | _(no docstring: supporting step)_ |
| `RoundNineThird.run_submitted_known` | Every submitted idea ends up in the wiki. |
| `RoundNineThird.submit_credit_of_known` | _(no docstring: supporting step)_ |
| `RoundNineThird.run_credit_kept` | Once an idea is in the wiki, its credit never changes, whatever is submitted later. |
| `RoundNineThird.submit_credit_new` | The first person to submit a new idea is credited with it. |
| `RoundNineThird.mem_adBubbles` | An app has a bubble exactly when it was mentioned and can be downloaded. |
| `RoundNineThird.adBubbles_repeat` | Mentioning an app again gives it no second bubble. |

### `RequestProject/RoundSeven/FollowUpSeven.lean` (13)

| Theorem | What it says |
| --- | --- |
| `RoundSevenFollowUp.same_skill_cap` | Every dragon has the same full skill. |
| `RoundSevenFollowUp.phoenix_same_nonelemental` | **No phoenix advantage outside elements.** At equal skill, a phoenix and any other dragon have the same power in every non-elemental ability. |
| `RoundSevenFollowUp.phoenix_elemental_ahead` | **The phoenix's elemental edge.** If the phoenix's elemental multiplier is at least 10% above every ordinary dragon multiplier (`pm ≥ 1.1 × dm`), then at equal skill the phoenix's elemental power is at least 10% above... |
| `RoundSevenFollowUp.phoenix_not_ahead_overall` | **Not stronger overall.** With a positive multiplier and skill, there is an ability in which the phoenix is not ahead of another dragon at equal skill. |
| `RoundSevenFollowUp.groupCheck_iff` | One key: the check passes exactly when one value meets every constraint in the group. |
| `RoundSevenFollowUp.contractCheck_iff_satisfiable` | **The Loom contract check is exact.** It accepts a contract exactly when some world meets every constraint: it never rejects a satisfiable contract and never accepts an unsatisfiable one. |
| `RoundSevenFollowUp.decide_denied_preserves` | **Denials preserve protected state.** |
| `RoundSevenFollowUp.decide_pass_iff` | **`PASS` exactly when every condition holds.** |
| `RoundSevenFollowUp.pass_records` | After a `PASS`, the command ID is recorded. |
| `RoundSevenFollowUp.used_mono` | Decisions never forget a used command ID. |
| `RoundSevenFollowUp.used_not_pass` | A used command ID can never pass. |
| `RoundSevenFollowUp.used_mono_run` | _(no docstring: supporting step)_ |
| `RoundSevenFollowUp.no_double_pass` | **No double acceptance.** Once a command ID has passed, however many decisions follow, the same command ID never passes again. |

### `RequestProject/RoundSeven/FourthPassSeven.lean` (12)

| Theorem | What it says |
| --- | --- |
| `RoundSevenFourthPass.skinBlind_iff_factors` | **Skin is cosmetic, exactly.** An ability rule is skin-blind if and only if it is computed from species, body, archetype and acquired traits alone. |
| `RoundSevenFourthPass.trait_keeps_species` | **Acquired traits never replace species.** Adding a trait leaves species unchanged. |
| `RoundSevenFourthPass.never_stuck` | **Nobody is ever stuck.** Suppose infinitely many quests in the catalogue are completable from skill 0. |
| `RoundSevenFourthPass.stuck_if_finite` | **With finitely many beginner quests, a beginner can get stuck.** If only finitely many quests are completable from skill 0, a skill-0 player who has finished all of them has nothing left that they can complete. |
| `RoundSevenFourthPass.publish_refused` | **A refused story changes nothing.** |
| `RoundSevenFourthPass.canon_append_single` | _(no docstring: supporting step)_ |
| `RoundSevenFourthPass.publish_other_genre` | **Publishing a lore story never changes the real record** (and the same with the genres swapped). |
| `RoundSevenFourthPass.lore_leaves_real` | _(no docstring: supporting step)_ |
| `RoundSevenFourthPass.satisfiable_nil` | _(no docstring: supporting step)_ |
| `RoundSevenFourthPass.publish_canon_satisfiable` | One publication attempt keeps every genre's record consistent. |
| `RoundSevenFourthPass.run_canon_satisfiable` | **Each genre's published record is always consistent**, whatever stories are submitted and in whatever order. |
| `RoundSevenFourthPass.gate_cannot_certify_truth` | **Consistency is not truth.** For any real world and any key, there is a "real" story that passes the gate on an empty profile but is false in that world. |

### `RequestProject/RoundSeven/RulingsSeven.lean` (24)

| Theorem | What it says |
| --- | --- |
| `RoundSevenRulings.train_le_cap` | No skill goes above 100. |
| `RoundSevenRulings.le_train` | Training never lowers a skill that is within the cap. |
| `RoundSevenRulings.train_saturates` | Enough training reaches exactly 100. |
| `RoundSevenRulings.playerLevel_le` | Levels run from 0 to 64. |
| `RoundSevenRulings.playerLevel_eq_max_iff` | Level 64 means every character node is unlocked. |
| `RoundSevenRulings.dragon_at_full_skill` | **The strength question with the cap.** A non-phoenix dragon (2× to 2.2×) at full skill 100 sits between 200 and 220. |
| `RoundSevenRulings.phoenix_at_full_skill` | A phoenix at 2.42× or more sits at 242 or more at full skill. |
| `RoundSevenRulings.phoenix_above_at_equal_skill` | **At equal skill the phoenix is 10% above everyone.** With the same skill `s`, a phoenix at 2.42× or more is at least 10% above every non-phoenix dragon (2.2× or less) and every normal player (1×), using the Round 5 r... |
| `RoundSevenRulings.phoenix_low_skill_example` | Across different skills the 10% rule does not hold: a phoenix at skill 50 (121) is below a 2× dragon at skill 100 (200). |
| `RoundSevenRulings.sale_conserves` | Nothing is created or lost in a sale. |
| `RoundSevenRulings.sale_seller` | The seller always keeps 98%. |
| `RoundSevenRulings.sale_tagged` | A tagged item pays its creator 2% and the admin pool nothing. |
| `RoundSevenRulings.sale_anonymous` | An anonymous (hard-reset) item pays 2% to the admin arena pool and nothing to a creator. |
| `RoundSevenRulings.skim_total_eq_sum` | In exact arithmetic, 2% of the total equals the sum of 2% of each contribution. |
| `RoundSevenRulings.skimEach_le_skimTotal` | Rounding per contribution never takes more than rounding once on the total. |
| `RoundSevenRulings.skim_rounding_example` | Two contributions of 49 coins: per contribution the skim is 0, on the total it is 1. |
| `RoundSevenRulings.evenSplit_conserves` | The even shares plus the leftover make up the pool. |
| `RoundSevenRulings.evenSplit_remainder_lt` | Fewer coins than there are admins are left over. |
| `RoundSevenRulings.evenSplit_example` | 100 coins among 3 admins: 33 each, 1 left over. |
| `RoundSevenRulings.rdPayout_fits_iff` | The payouts fit in the pool exactly when the percentages add to at most 100. |
| `RoundSevenRulings.six_collaborators_overflow` | Six DEV collaborators on one RD pool would be owed 120% of it. |
| `RoundSevenRulings.names_unchanged_without_approval` | **No exceptions.** Without an approval, no name ever changes, whoever proposes. |
| `RoundSevenRulings.approve_unproposed_noop` | Approving something that was never proposed changes nothing. |
| `RoundSevenRulings.approve_sets_name` | An approved proposal sets exactly that platform's name. |

### `RequestProject/RoundSeven/ThirdPassSeven.lean` (24)

| Theorem | What it says |
| --- | --- |
| `RoundSevenThirdPass.portable_iff_goldLocked` | _(no docstring: supporting step)_ |
| `RoundSevenThirdPass.levelUp_le_cap` | A level-up never passes 100. |
| `RoundSevenThirdPass.iterate_levelUp` | After `n` level-ups from 0, the orb is at level `min 100 n`. |
| `RoundSevenThirdPass.levelUps_to_goldLock` | **Exactly 100 level-ups.** From level 0, the orb is gold-locked after `n` level-ups exactly when `n ≥ 100`. |
| `RoundSevenThirdPass.playerLevel_le` | _(no docstring: supporting step)_ |
| `RoundSevenThirdPass.playerLevel_eq_64_iff` | **Level 64** means every one of the 64 orbs is gold-locked. |
| `RoundSevenThirdPass.port_refused` | A port refused for an orb below 100 leaves the matrix unchanged. |
| `RoundSevenThirdPass.ported_all_goldLocked` | **Only gold-locked orbs reach the dragon.** Starting from an empty matrix, any sequence of port attempts leaves every occupied node gold-locked. |
| `RoundSevenThirdPass.slotOnDragon_level` | Slotting on the dragon sets the orb to the dragon's skill level at once. |
| `RoundSevenThirdPass.dragonNodes_split` | The dragon matrix is the 64 character nodes plus 80 dragon nodes. |
| `RoundSevenThirdPass.focus_one` | One active element means full focus. |
| `RoundSevenThirdPass.focus_antitone` | More active elements never raise per-element strength (for `d ≥ 0`). |
| `RoundSevenThirdPass.phoenix_below_every_dragon` | **A five-element phoenix is weaker per element than any one-element dragon.** Dragons sit between 2× and 2.2× (the phoenix too). |
| `RoundSevenThirdPass.focus_boundary_needed` | **`1/44` is the exact boundary.** At `d = 1/44`, a 2.2× phoenix with all five elements ties a 2× dragon, so the strict guarantee needs `d > 1/44`. |
| `RoundSevenThirdPass.phoenix_at_least_player` | **Still above an ordinary player.** If `d ≤ 1/8`, a phoenix (at least 2×) with all five elements active is still at least as strong per element as a non-dragon player (1×). |
| `RoundSevenThirdPass.focus_example` | Example with `d = 5%`: a five-element phoenix works at 80% per element, so 1.6× to 1.76× of a player, below every one-element dragon (2× to 2.2×). |
| `RoundSevenThirdPass.skimEachAt_le_skimTotalAt` | **Rounding per contribution never takes more**, at any rate. |
| `RoundSevenThirdPass.skimTotalAt_lt_skimEachAt_add` | **The gap is less than one coin per contribution**, at any rate. |
| `RoundSevenThirdPass.taxAt_eq_zero_iff` | **Small amounts pay nothing.** The tax on `x` is 0 exactly when `x × rate < 100`. |
| `RoundSevenThirdPass.thresholds` | The tax-free thresholds: under 50 coins at 2%, under 34 at 3%, under 20 at 5%. |
| `RoundSevenThirdPass.example_49_49` | The 49 + 49 example at 2%, 3% and 5%. |
| `RoundSevenThirdPass.example_ten_19` | Ten contributions of 19 coins (pool 190): per contribution 0 at every rate; from the total 3, 5 and 9 coins. |
| `RoundSevenThirdPass.example_1000` | A 1,000-coin sale pays 20, 30 and 50 coins at 2%, 3% and 5%. |
| `RoundSevenThirdPass.sale_split_conserves` | Sale split at `rate`%: seller keeps the rest; nothing is created or lost. |

### `RequestProject/RoundSix/RulingsSix.lean` (21)

| Theorem | What it says |
| --- | --- |
| `RoundSixRulings.unanimous_passes6` | **A unanimous first round passes.** |
| `RoundSixRulings.three_strikes_out` | **Three spreading rounds strike the motion out**, whatever would have come after. |
| `RoundSixRulings.deliberate6_take` | _(no docstring: supporting step)_ |
| `RoundSixRulings.only_three_rounds_matter` | **Only the first three reassessments matter.** |
| `RoundSixRulings.deliberate6_decides` | _(no docstring: supporting step)_ |
| `RoundSixRulings.decides_within_three` | **The council always decides within three reassessments**: after three reassessment rounds the motion has passed, been rejected, or been struck out. |
| `RoundSixRulings.deliberate6_agrees` | _(no docstring: supporting step)_ |
| `RoundSixRulings.agrees_with_round_five` | **Before the third strike nothing changes**: whenever the motion is not struck out, the three-strikes rule gives exactly the Round 5 result. |
| `RoundSixRulings.pass_has_four_fifths6` | **Passing still means 4/5 approval in the round of record.** |
| `RoundSixRulings.retry_allowed_iff` | **The 7-day timer**: a struck-out motion can be brought back exactly from seven days after the strike. |
| `RoundSixRulings.three_strikes_example` | Example (five seats): seat 0 votes no; each of the next three reassessments brings a new no from a different seat, so the third strike puts the motion out. |
| `RoundSixRulings.two_strikes_then_pass_example` | Example (five seats): two strikes, then a round with only the original no: the motion passes. |
| `RoundSixRulings.tax_split_conserves` | **Nothing is created or lost**: on every record the arenas' tax and the account's part add up to the record's royalty. |
| `RoundSixRulings.taxReset_arena_gain` | **A hard reset moves exactly `τ` of that user's share into the arenas.** |
| `RoundSixRulings.taxReset_user_keeps` | **The user keeps `1 - τ` of their share after a hard reset.** |
| `RoundSixRulings.taxReset_other_user` | **Other users are unchanged.** |
| `RoundSixRulings.full_tax_is_round_five` | **A 100% tax is the Round 5 rule**: the arenas gain the user's whole share, and the user keeps nothing. |
| `RoundSixRulings.two_percent_example` | **At 2%**: for a hard-reset user whose share is 100, the arenas gain 2 and the user keeps 98. |
| `RoundSixRulings.coreAnimalNames_spec` | **43 core animal names**, all distinct, and the Core list loses exactly PULSE, HIVE and SHEPHERD. |
| `RoundSixRulings.animalNames_spec` | **47 animal names**, all distinct: none of the extension band is already a core name. |
| `RoundSixRulings.monolithicZoo_spec` | **50 Zoo entries**, all distinct. |

### `RequestProject/RoundSixteen/EFMWAxiomsReview.lean` (4)

| Theorem | What it says |
| --- | --- |
| `RoundSixteen.EFMWReview.efmw_axiom_system_consistent` | The twelve EFMW surrogates are jointly satisfiable: here is one model of all of them (constant functions, a nonzero limiting rotation of `1`, period `1`, identity feedback step). |
| `RoundSixteen.EFMWReview.scale_invariant_const_on_pos` | A4 forces the strength to be constant on the positive numbers. |
| `RoundSixteen.EFMWReview.scale_invariant_const_on_neg` | A4 forces the strength to be constant on the negative numbers. |
| `RoundSixteen.EFMWReview.causal_entanglement_is_trivial` | A6 forces the entanglement relation to be the relation that holds between every pair. |

### `RequestProject/RoundSixteen/EFMWAxiomsUpstream.lean` (12)

| Theorem | What it says |
| --- | --- |
| `EFMWAxioms.A1_residual_limit_nonzero` | _(no docstring: supporting step)_ |
| `EFMWAxioms.A2_trajectory_bounded` | _(no docstring: supporting step)_ |
| `EFMWAxioms.A3_information_time_independent` | _(no docstring: supporting step)_ |
| `EFMWAxioms.A4_rescaling_invariant` | _(no docstring: supporting step)_ |
| `EFMWAxioms.A5_coupling_symmetric` | _(no docstring: supporting step)_ |
| `EFMWAxioms.A6_all_points_related` | _(no docstring: supporting step)_ |
| `EFMWAxioms.C7_quantum_generator_from_curvature` | _(no docstring: supporting step)_ |
| `EFMWAxioms.C8_mass_is_potential_derivative` | _(no docstring: supporting step)_ |
| `EFMWAxioms.C9_uncertainty_has_lower_bound` | _(no docstring: supporting step)_ |
| `EFMWAxioms.C10_interface_matches` | _(no docstring: supporting step)_ |
| `EFMWAxioms.C11_one_lattice_period` | _(no docstring: supporting step)_ |
| `EFMWAxioms.C12_two_feedback_steps_remain_admissible` | _(no docstring: supporting step)_ |

### `RequestProject/RoundSixteen/PlaylistBuses.lean` (2)

| Theorem | What it says |
| --- | --- |
| `RoundSixteen.Playlists.playlist_alignment` | The pairing is one-to-one on both sides, stays inside both lists, and covers 56 songs; exactly one Spotify track (57, *Living in the Future*) is missing from YouTube, and six YouTube videos (37, 47, 51, 52, 55, 56) ar... |
| `RoundSixteen.Playlists.bus_counts_add_up` | However songs are sorted onto the three buses (one bus per song), the bus counts add up to the whole playlist: no song is lost or counted twice. |

### `RequestProject/RoundTen/OpeningTen.lean` (4)

| Theorem | What it says |
| --- | --- |
| `RoundTenOpening.safety_display_is_canonical` | All safety messages retain their words, regardless of language skill. |
| `RoundTenOpening.sufficiently_skilled_sees_canonical` | At or above every word's threshold the ordinary display is clear. |
| `RoundTenOpening.clarity_monotone` | Increasing skill never re-garbles a previously clear ordinary word. |
| `RoundTenOpening.render_retains_canonical` | The canonical text does not depend on the reader's proficiency. |

### `RequestProject/RoundThirteen/LaunchPathAndBlurbs.lean` (12)

| Theorem | What it says |
| --- | --- |
| `RoundThirteen.nonKrion_ports` | Only the Ascent and the Chronicles bring a non-KRION energy. |
| `RoundThirteen.zone_element_match` | Each zone's energy matches its element: Garden = Earth, Playground = Water and Air, Chronicles = Fire, Ascent = Lightning. |
| `RoundThirteen.digits_144_sum` | 144 sums to 9 (1 + 4 + 4), as labelled on the UIAR art. |
| `RoundThirteen.reachable_closed` | _(no docstring: supporting step)_ |
| `RoundThirteen.gate_needs_garden_and_playground` | Nobody reaches ORION's Gate without first passing through the Singularity, Elder's Garden and the Playground. |
| `RoundThirteen.gate_reachable_via_ascent` | And the path is really open: the full launch sequence through the Ascent reaches the Gate. |
| `RoundThirteen.unsafe_map_only` | _(no docstring: supporting step)_ |
| `RoundThirteen.safe_full` | _(no docstring: supporting step)_ |
| `RoundThirteen.capstone_closed_if_one_holds_out` | _(no docstring: supporting step)_ |
| `RoundThirteen.bio_fits` | The bio fits X's 160-character bio limit. |
| `RoundThirteen.statusPost_fits` | The build-status post is under 250. |
| `RoundThirteen.blurbs_fit` | Every thread blurb is under 250. |

### `RequestProject/RoundThree/Clarifications.lean` (24)

| Theorem | What it says |
| --- | --- |
| `RoundThreeClarifications.orbCost_flat` | **Flat, not compounding.** With the discount, every additional orb costs exactly half the base cost, however many came before it. |
| `RoundThreeClarifications.nodeCost_discounted` | Total cost with the discount: the first orb at full price, every further one at half. |
| `RoundThreeClarifications.nodeCost_full` | Without the discount every orb is at full price. |
| `RoundThreeClarifications.bond_discount_off` | **The discount does not carry over.** Right after symbiosis the discount is off on every node of the dragon matrix, even on nodes that were character-locked, and the character lock itself is kept. |
| `RoundThreeClarifications.dragon_discount_iff` | **Earned again the same way.** On the dragon matrix the discount is on exactly when the node holds the dragon lock, and earning it switches the discount back on. |
| `RoundThreeClarifications.bond_then_lock_costs` | After symbiosis, additional orbs in a node cost full price until the dragon lock is earned, and half price afterwards. |
| `RoundThreeClarifications.advance_le_64` | Without a dragon, progress never passes 64. |
| `RoundThreeClarifications.advance_iterate` | _(no docstring: supporting step)_ |
| `RoundThreeClarifications.charLock_at_64` | **Available at 64.** Without a dragon, 64 steps of progress from the start reach 64, and the character lock is then available. |
| `RoundThreeClarifications.demolition_tiers` | **Three tiers.** Practice gives no resources; scheduled (sanctioned) and unscheduled (forced) demolitions both give the resource yield. |
| `RoundThreeClarifications.kinetic_resets` | **Attacking resets the timer.** While aggroed, a kinetic action sets the timer back to the full 10 minutes. |
| `RoundThreeClarifications.heal_debuff_count_down` | Healing buffs and ORION-aligned debuffs do not reset the timer; it keeps counting down. |
| `RoundThreeClarifications.runAggro_nonkinetic` | _(no docstring: supporting step)_ |
| `RoundThreeClarifications.aggro_ends` | **How aggro ends.** Ten minutes with no kinetic action (only healing buffs, ORION-aligned debuffs, or nothing) ends the aggro from a forced demolition. |
| `RoundThreeClarifications.runAggro_pos` | _(no docstring: supporting step)_ |
| `RoundThreeClarifications.aggro_lasts` | **Aggro lasts the full 10 minutes.** Within 10 minutes of the forced demolition, or of the last kinetic action while aggroed, the player is still aggroed, whatever else they do. |
| `RoundThreeClarifications.no_aggro_stays` | A player who is not aggroed never becomes aggroed through their own actions. |
| `RoundThreeClarifications.request_midEncounter_unchanged` | A request made mid-encounter does not change the switch during the encounter. |
| `RoundThreeClarifications.request_applies_at_end` | **Automatic switch at the end.** When the encounter ends, the switch is set to the last value asked for during it. |
| `RoundThreeClarifications.request_outside_immediate` | Outside an encounter the switch changes at once. |
| `RoundThreeClarifications.pve_request_safe_after` | **Safe once it ends.** A player who asks for PvE-only mid-encounter and has not aggroed their skybox cannot be attacked by anyone once the encounter ends. |
| `RoundThreeClarifications.empty_gift_rejected` | **Empty gifts are rejected.** |
| `RoundThreeClarifications.giveWeighted_all_weighted` | Every gift that reaches the receiver has weight: if all their available gifts had weight before, they all do after. |
| `RoundThreeClarifications.gift_points_from_resources` | **No points from nothing.** If every gift is worth no more than the resources put into its schematic, then the points from unused gifts never exceed those resources, and any gift that can be given at all had resources... |

### `RequestProject/RoundThree/Compilation.lean` (12)

| Theorem | What it says |
| --- | --- |
| `RoundThreeCompilation.loop_unbounded_iff` | A repeatable loop makes holdings unbounded exactly when one pass nets a positive amount. |
| `RoundThreeCompilation.loop_bounded_of_nonpos` | A loop netting nothing or a loss never raises holdings. |
| `RoundThreeCompilation.no_loss_raid_unbounded` | **The decay-raid duplication loop.** Under "the owner loses nothing" (the full investment comes back) while raiders harvest any positive amount, an owner and a friendly raiding party can repeat raid-and-rebuild to mak... |
| `RoundThreeCompilation.conserving_raid_bounded` | **The conserving fix.** If what the owner gets back plus what the raiders carry off never exceeds what was invested, repeating raids can never raise combined holdings. |
| `RoundThreeCompilation.taxedConvert_le` | Every conversion keeps at most what went in. |
| `RoundThreeCompilation.taxedConvert_lt` | Every conversion of a positive amount strictly loses value. |
| `RoundThreeCompilation.taxed_chain_loses` | **No profitable conversion chain.** Any chain of `k ≥ 1` taxed conversions of a positive amount ends with strictly less than it started with, so no cycle through local currencies can gain value. |
| `RoundThreeCompilation.taxedConvert_dust` | **Dust caveat.** Rounding down wipes out a single unit entirely, and every amount from 1 to 50 loses at least one whole unit, i.e. |
| `RoundThreeCompilation.compounding_total_lt_double` | **Compounding reading.** However many locks are made, the total effort stays below twice the first lock's effort. |
| `RoundThreeCompilation.compounding_effort_vanishes` | Under the compounding reading the effort for a further lock eventually drops below any positive amount. |
| `RoundThreeCompilation.flat_discount_unbounded` | **Non-compounding reading.** If every further lock costs a fixed half of the first, the total effort for `n + 1` locks is `E + n · E / 2`, which grows without bound. |
| `RoundThreeCompilation.fiftyFifty_drops_with_weak_member` | **Dilution.** Adding a member whose skill is below the mean of the non-top members strictly lowers the encounter's difficulty, so under the 50/50 rule a party can soften an encounter by bringing weaker members. |

### `RequestProject/RoundThree/Curation.lean` (21)

| Theorem | What it says |
| --- | --- |
| `RoundThreeCuration.menu_within_reach` | **Nothing out of reach is shown.** Everything on the menu can be done through the player's own skill, a blueprint they own, or a tradesman they can engage. |
| `RoundThreeCuration.menu_complete` | **Everything within reach is shown.** |
| `RoundThreeCuration.solo_menu_le_skill` | A player with no blueprints and no tradesman only ever sees options at or below their own skill. |
| `RoundThreeCuration.menu_mono` | **The menu only grows.** More skill, another blueprint or another tradesman never removes an option. |
| `RoundThreeCuration.roster_split` | 43 species to choose from, including the generic dragon and the phoenix, and none of the three archetypes. |
| `RoundThreeCuration.species_forever` | **A whale dragon is always a whale dragon.** No sequence of curation steps (body, skin or archetype) changes the species. |
| `RoundThreeCuration.skin_never_matters` | **The skin never matters.** Changing the skin, as often as you like, never changes what the dragon can do. |
| `RoundThreeCuration.archetypes_valid` | Every archetype upgrade a dragon carries is one of the three archetypes. |
| `RoundThreeCuration.phoenix_fire` | **A phoenix dragon isn't always burning.** It hatches not on fire, it can catch fire, and the fire can go out again. |
| `RoundThreeCuration.ignite_other` | Only a phoenix dragon catches fire. |
| `RoundThreeCuration.crafting_alone_blocked` | **A rocket isn't enough.** A player who only crafts (rockets that reach the lattice, or anything else) never gets through the gate, however much they build. |
| `RoundThreeCuration.quest_or_key` | **The quest line or a key.** Finishing the quest line gets a player through, and so does a key. |
| `RoundThreeCuration.sharpshooter_rocket_cannot_hatch` | **No sun, no dragon.** A sharp shooter with all 64 gold locks who has only been crafting can't hatch a dragon. |
| `RoundThreeCuration.rounding_spec` | **The two rules differ by at most 1, and only on odd costs.** Rounding up never charges less than an exact half; rounding down never charges more. |
| `RoundThreeCuration.rounding_total` | Over `n` discounted orbs of base cost `c`, rounding down saves the player at most `n` in total compared with rounding up. |
| `RoundThreeCuration.monthlyReset_spec` | **The reset.** After the shutdown every developer-hosted pool is empty, every player-hosted pool is unchanged, the fund grows by exactly the unclaimed developer pool energy, and **no energy is created or lost.** |
| `RoundThreeCuration.forced_pays_more` | **Forcing pays more.** With any positive bonus, a forced demolition pays strictly more than a scheduled one, which pays more than practice (when the yield is positive). |
| `RoundThreeCuration.no_grief` | **No griefing.** Whatever member `i` does, every other member's timer is unchanged. |
| `RoundThreeCuration.stays_inactive` | **Inactive members stay inactive.** A member who isn't aggroed, and who casts no kinetic (Kronos-aligned) skill themselves, stays un-aggroed whatever the rest of the group does. |
| `RoundThreeCuration.leave_clears` | **Leaving the skybox clears your aggro.** |
| `RoundThreeCuration.join_fight` | **Joining the fight.** A member who isn't aggroed and casts a kinetic skill while a group mate is aggroed becomes aggroed for the full 10 minutes, and nobody else is affected. |

### `RequestProject/RoundThree/Decisions.lean` (23)

| Theorem | What it says |
| --- | --- |
| `RoundThreeDecisions.activeCount_le_two` | A player never has more than two active gifts: at most one player gift and at most one team-member gift. |
| `RoundThreeDecisions.sendGift_total` | **Gifts are never refused.** Every gift sent is kept: the total held goes up by exactly one. |
| `RoundThreeDecisions.sendGift_warns_iff` | **The warning fires exactly when the matching slot is already filled.** |
| `RoundThreeDecisions.sendGift_no_warning_active` | A gift sent with no warning is active right away in its slot. |
| `RoundThreeDecisions.sendGift_warning_keeps_active` | A gift sent with a warning never displaces the active one. |
| `RoundThreeDecisions.party_active_le` | In a party of `n` players, at most `2 n` gifts are active at once. |
| `RoundThreeDecisions.runSteps_le` | **Every gain costs effort.** If each step earns at most `rate` per unit of effort, holdings after any sequence of steps are at most the starting holdings plus `rate × total effort`. |
| `RoundThreeDecisions.no_effort_no_gain` | **No quick fix to unlimited anything.** With zero effort, no sequence of encounters ever raises a group's holdings. |
| `RoundThreeDecisions.effort_needed` | **Unlimited is allowed, but always takes effort.** To reach holdings above `B` starting from `w`, at least `(B - w) / rate` effort is needed (rounded up): precisely, `rate × effort` must exceed `B - w`. |
| `RoundThreeDecisions.unlimited_with_effort` | The repeatable step "spend nothing, put in one unit of effort, earn `rate`" shows that unlimited amounts *are* reachable, by repeating effort. |
| `RoundThreeDecisions.auto_return_unbounded` | **The rejected rule.** If an encounter spends `c > 0` components and they are then handed back automatically to the aggressor, with no effort, the encounter never costs anything; with any positive side gain (for examp... |
| `RoundThreeDecisions.solo_difficulty` | A solo player faces exactly their own skill. |
| `RoundThreeDecisions.manual_lowering_no_benefit` | **Lowering yourself by hand gives no edge.** A solo encounter scales to the skill the player brings, so the reward per unit of difficulty is the same fixed `rate` whatever skill they bring, and bringing a lower skill ... |
| `RoundThreeDecisions.mentoring_matches_mentee` | With mentoring, a mentor never raises the encounter above what the mentee faces alone: a mentor-and-mentee pair faces at most the mentee's own skill level. |
| `RoundThreeDecisions.hardReset_is_first_login` | After a hard reset the account is exactly a first-time account. |
| `RoundThreeDecisions.hardReset_forgets` | Two accounts with the same real-life metadata are identical after a hard reset, whatever they did before: nothing from the earlier game state survives. |
| `RoundThreeDecisions.hardReset_keeps_realLife` | A hard reset keeps the real-life metadata. |
| `RoundThreeDecisions.hardReset_idem` | Doing a hard reset twice is the same as once. |
| `RoundThreeDecisions.characterReset_keeps_others` | The character reset leaves every other character untouched. |
| `RoundThreeDecisions.resets_differ` | **The two resets are different functions**: on an account with two characters, the character reset keeps a character, while the hard reset keeps none. |
| `RoundThreeDecisions.creditList_length` | **Nobody is left off.** Every contribution gets exactly one entry. |
| `RoundThreeDecisions.anonymous_iff_no_profile` | A contributor is shown as anonymous exactly when they have no profile. |
| `RoundThreeDecisions.correction_effect` | After a correction the contributor is credited by name, and nobody else's credit changes. |

### `RequestProject/RoundThree/Dragon.lean` (11)

| Theorem | What it says |
| --- | --- |
| `RoundThreeDragon.lockNode_iterate` | _(no docstring: supporting step)_ |
| `RoundThreeDragon.sharpshooter_all_64` | **A sharp shooter can gold-lock all 64 at once.** A fresh player can gold-lock all 64 nodes with every skill still at zero. |
| `RoundThreeDragon.sharpshooter_cannot_hatch` | **No sun, no dragon.** Gold-locking all 64 nodes is not enough: a fresh sharp shooter with no escape skill cannot hatch a dragon. |
| `RoundThreeDragon.canPlantSeed_iff` | Hatching needs all 64 gold locks and the escape skill; nothing else. |
| `RoundThreeDragon.speciesChoices_spec` | The roster offers 46 builds, including the whale and the generic dragon. |
| `RoundThreeDragon.hatch_spec` | _(no docstring: supporting step)_ |
| `RoundThreeDragon.species_forever` | **A whale dragon is always a whale dragon.** No sequence of look changes, at any skill levels, changes the species build. |
| `RoundThreeDragon.any_look_reachable` | **Everything else can change.** With enough skill, any look at all can be given to the dragon. |
| `RoundThreeDragon.looks_monotone` | **Skill only adds options.** A look available at some skill stays available at any higher skill. |
| `RoundThreeDragon.low_skill_refused` | A low-skill player is held to plain looks: a look whose tier is above their skill is refused. |
| `RoundThreeDragon.looks_do_not_matter` | **Plain but fully capable.** Whatever a dragon can do is decided by its species build (`cap`), never by its look, so a plain low-skill dragon can do everything a fully curated dragon of the same species can. |

### `RequestProject/RoundThree/Followups.lean` (20)

| Theorem | What it says |
| --- | --- |
| `RoundThreeFollowups.owner_no_loss` | **No loss.** However many times a structure is raided, the owner's holdings never go down. |
| `RoundThreeFollowups.raiders_gain_le` | **All gain is paid for by effort.** If raiders harvest at most `rate` per unit of raiding effort (the same `rate` as any other way of gathering), then after any number of raids the raiders hold at most their starting ... |
| `RoundThreeFollowups.combined_le` | **Owner and raiders together: no free materials.** Combined holdings never exceed the starting total plus `rate × total raiding effort`. |
| `RoundThreeFollowups.no_effort_raids_no_gain` | Raids with no effort harvest nothing. |
| `RoundThreeFollowups.raids_unlimited_with_effort` | **Unlimited, by repeating effort.** Raiding with one unit of effort at a time and harvesting `rate` each time reaches any amount, while the owner keeps everything. |
| `RoundThreeFollowups.receive_accounted` | Receiving a gift adds exactly one to the gifts held; nothing is refused or returned. |
| `RoundThreeFollowups.receive_reminder_iff` | The reminder that gifts are not returned appears exactly when the matching slot is already full. |
| `RoundThreeFollowups.interchange_spec` | Interchanging leaves the active gifts, the depleted gifts and the boost untouched, and keeps exactly the same queued gifts. |
| `RoundThreeFollowups.moveToFront_accounted` | Moving a gift to the front is an interchange: nothing is lost or created. |
| `RoundThreeFollowups.takeNext_length` | `takeNext` removes at most one gift from the queue, and only when it returns one. |
| `RoundThreeFollowups.deplete_accounted` | Depleting a gift loses nothing: every gift is still accounted for. |
| `RoundThreeFollowups.deplete_other_slot` | Depleting the active gift of one kind leaves the other slot alone. |
| `RoundThreeFollowups.convertUnused_spec` | Converting unused gifts is not a loss: each one becomes boost, so the total is kept, and the active and depleted gifts are untouched. |
| `RoundThreeFollowups.boost_needs_effort` | **A boost multiplies effort; it never replaces it.** With no effort, no amount of boost gives any progress. |
| `RoundThreeFollowups.boostedProgress_mono` | A boost never lowers progress, and more effort always gives at least as much. |
| `RoundThreeFollowups.hardResetBoard_untagged` | After the reset, no blueprint on the board is tagged with the reset player. |
| `RoundThreeFollowups.hardResetBoard_keeps_blueprints` | No blueprint is deleted and no content changes: the blueprints stay in the world, only the tags change. |
| `RoundThreeFollowups.anonymize_other` | Other players' credits are untouched. |
| `RoundThreeFollowups.anonymize_indistinguishable` | **The reset cannot be traced through blueprints.** After the reset, a blueprint that was `p`'s looks exactly the same as an anonymous contribution with the same content. |
| `RoundThreeFollowups.hardReset_untraceable` | Together with the account hard reset of `Decisions.lean`: two players with the same real-life metadata, one of whom crafted a blueprint and one of whom found the same blueprint already anonymous, cannot be told apart ... |

### `RequestProject/RoundThree/Rulings.lean` (30)

| Theorem | What it says |
| --- | --- |
| `RoundThreeRulings.requestZone_forced_iff` | A request is forced exactly when it falls inside the window after the last sanctioned zone. |
| `RoundThreeRulings.sanctionedDays_chain` | _(no docstring: supporting step)_ |
| `RoundThreeRulings.sanctioned_spaced` | **Once per month.** Any two sanctioned deconstruction zones on the same structure, in order, are at least `W` days apart, however the requests are timed. |
| `RoundThreeRulings.chain_bound` | _(no docstring: supporting step)_ |
| `RoundThreeRulings.sanctioned_count_bound` | **Not an infinite resource stream.** If every request is made before day `T`, then the number `k` of sanctioned deconstruction zones satisfies `k × W < T + W`: about one per month, and no more. |
| `RoundThreeRulings.practice_no_resources` | A practice demolition gives no resources, and the same skill progress as a real one. |
| `RoundThreeRulings.setPvp_refused_in_encounter` | The switch cannot be flipped in the middle of an encounter. |
| `RoundThreeRulings.setPvp_no_cooldown` | **No cool-off.** Outside an encounter the switch can be flipped, and flipped back, straight away. |
| `RoundThreeRulings.pvp_off_safe` | **Done with fighting.** Once a player who has not aggroed their skybox has turned PvP off, nobody can attack them. |
| `RoundThreeRulings.aggro_overrides` | **Aggro overrides the switch.** A player who has aggroed a skybox can be attacked by every player in it and is targeted by every asset in it, whatever either switch says. |
| `RoundThreeRulings.pvp_off_keeps_aggro` | Turning PvP off does not lift aggro. |
| `RoundThreeRulings.forced_demolition_aggro` | After a forced demolition, any player in that skybox may attack any crew member still there, and every asset in it targets them. |
| `RoundThreeRulings.queueSlots_bounds` | _(no docstring: supporting step)_ |
| `RoundThreeRulings.giveGift_warning_iff` | The warning shows exactly when this sender has already given this receiver a gift in this encounter. |
| `RoundThreeRulings.giveGift_needs_owned` | Only items the sender owns can be given. |
| `RoundThreeRulings.giveGift_conserves` | Giving moves exactly one item from the sender to the receiver. |
| `RoundThreeRulings.slotGift_occupied` | An occupied slot cannot take a second gift. |
| `RoundThreeRulings.slotReady_iff` | _(no docstring: supporting step)_ |
| `RoundThreeRulings.find?_range'_min` | _(no docstring: supporting step)_ |
| `RoundThreeRulings.nextSlot_spec` | **Slot 1 first, then 2, then 3, ….** If the queue activates slot `i`, that slot's gift is ready, and every lower-numbered slot was empty or blocked. |
| `RoundThreeRulings.nextSlot_isSome` | If any existing slot holds a ready gift, the queue activates something. |
| `RoundThreeRulings.endEncounter_total` | Each unused gift is converted once, into its schematic's skill only: summed over any list of skills that contains every schematic skill once, the points are exactly the total schematic value of the unused gifts. |
| `RoundThreeRulings.endEncounter_le_effort` | **Gift points still trace back to effort.** If no schematic is worth more points than the effort it takes to craft (`cost`), the points from unused gifts are at most the crafting effort that went into them. |
| `RoundThreeRulings.maySwap_spec` | Only the player edits their own queue; only the leader (or the admin they assigned) edits the group queue; nothing other than a player edits any queue. |
| `RoundThreeRulings.reset_no_royalty` | After a hard reset, none of the board's royalties go to the reset player. |
| `RoundThreeRulings.anonymizeHistory_spec` | After the reset, the player appears in no fork history; every other entry is kept. |
| `RoundThreeRulings.aiCouncil_hard_stop` | **Absolute hard stop.** The AI Council never has access, with or without human approval, and approval never changes anyone's access. |
| `RoundThreeRulings.councilMayEngage_needs_dev` | _(no docstring: supporting step)_ |
| `RoundThreeRulings.activateBank_spec` | **Both hold.** Activating the bank never takes a skill past 144, and nothing is lost: skill plus bank is unchanged. |
| `RoundThreeRulings.orb_phases` | The Gold Lock Orb cannot be activated before the character reaches 64; the Black Hole Orb can. |

### `RequestProject/RoundThreeLinks.lean` (1)

| Theorem | What it says |
| --- | --- |
| `RoundThreeLinks.local_agreement_allows_unbounded_drift` | Any positive allowed step supports readings which always agree with their predecessor to within that step but eventually drift past any given threshold. |

### `RequestProject/RoundTwelve/AlbumMathAndRulings.lean` (21)

| Theorem | What it says |
| --- | --- |
| `RoundTwelveFollowUp.cuby93_cube` | _(no docstring: supporting step)_ |
| `RoundTwelveFollowUp.grid39_cube` | _(no docstring: supporting step)_ |
| `RoundTwelveFollowUp.grid_splits_into_thirteen_months` | _(no docstring: supporting step)_ |
| `RoundTwelveFollowUp.thirteen_month_calendar` | _(no docstring: supporting step)_ |
| `RoundTwelveFollowUp.garbled_reading_ne_grid` | The poster's "395,319" is not the grid size `39³`. |
| `RoundTwelveFollowUp.erdos_straus_39` | "Erdős–Straus 4/39": three distinct unit fractions summing to `4/39`. |
| `RoundTwelveFollowUp.kronos_144_is_fib_12` | _(no docstring: supporting step)_ |
| `RoundTwelveFollowUp.phi_sq` | _(no docstring: supporting step)_ |
| `RoundTwelveFollowUp.phi_pos` | _(no docstring: supporting step)_ |
| `RoundTwelveFollowUp.inv_phi` | _(no docstring: supporting step)_ |
| `RoundTwelveFollowUp.phi_bounds` | _(no docstring: supporting step)_ |
| `RoundTwelveFollowUp.owner_can_unplant_private` | _(no docstring: supporting step)_ |
| `RoundTwelveFollowUp.owner_can_unplant_unreviewed` | _(no docstring: supporting step)_ |
| `RoundTwelveFollowUp.gauntlet_record_stays` | _(no docstring: supporting step)_ |
| `RoundTwelveFollowUp.only_owner_unplants` | _(no docstring: supporting step)_ |
| `RoundTwelveFollowUp.unplant_no_penalty` | _(no docstring: supporting step)_ |
| `RoundTwelveFollowUp.unplant_removes` | _(no docstring: supporting step)_ |
| `RoundTwelveFollowUp.capability_not_authority` | Changing anyone's skill level never changes who has authority. |
| `RoundTwelveFollowUp.handoff_lossless` | _(no docstring: supporting step)_ |
| `RoundTwelveFollowUp.handoff_only_training_differs` | _(no docstring: supporting step)_ |
| `RoundTwelveFollowUp.handoff_round_trip` | Handing the package back to the original member restores it exactly. |

### `RequestProject/RoundTwelve/FieldCoreAndFieldSpace.lean` (14)

| Theorem | What it says |
| --- | --- |
| `RoundTwelve.clipToBall_dist_le` | The projection never moves a point farther from the hole. |
| `RoundTwelve.clipToBall_dist_le_radius` | The projection always lands inside the ball. |
| `RoundTwelve.steelBallStep_ground` | The hole is a fixed point: a ball resting in the hole stays there. |
| `RoundTwelve.steelBallStep_contracts` | **One step contracts the drift by `1 - η`**, with no error term, for every step size `η ≤ 1` and every radius `R ≥ 0`, from any starting point. |
| `RoundTwelve.steelBall_iterate_bound` | **The README's bound** `d_k ≤ (1 - η)^k d_0`, for every number of steps `k`. |
| `RoundTwelve.steelBall_finds_hole` | **Every drop finds the hole**: for `0 < η ≤ 1` the drift tends to `0` from any starting point. |
| `RoundTwelve.steelBall_eta_three_never_settles` | **The step-size condition matters.** On the real line, with hole `0`, radius `1` and step size `η = 3`, a ball dropped at `1` bounces between `1` and `-1` forever: its drift stays `1` and never tends to `0`. |
| `RoundTwelve.fieldSpace_triplet_count` | There are 165 triplets of the 11 sectors. |
| `RoundTwelve.fieldSpace_six_classes` | **The six classes of the master-action note, by counting:** 56 three-scalar blocks, 56 one-gauge blocks, 28 gravity-plus-two-scalar blocks, 16 gravity-gauge-scalar blocks, 8 two-gauge-plus-scalar blocks and one E–M–S ... |
| `RoundTwelve.choosePod_no_penalty` | **No punishment for choosing the pod:** it keeps all locked and pending progress, and only moves the player to a safe zone. |
| `RoundTwelve.choosePod_eq_knockedOut` | Choosing the pod is never worse than being knocked out: it is the same rescue. |
| `RoundTwelve.locked_le_apply` | One event never removes gold-locked progress. |
| `RoundTwelve.no_permanent_loss` | **No permanent death:** whatever happens, in any order, gold-locked progress is never lost. |
| `RoundTwelve.unionWealth_group_figures` | 1,000 people each giving \$9,125 (that is \$1 a day for 25 years) make \$9,125,000, which equals 18,250 family-support awards of \$500. |

### `RequestProject/RoundTwelve/ThirdPass.lean` (19)

| Theorem | What it says |
| --- | --- |
| `RoundTwelveThirdPass.marker_11052024` | The log's opening marker `11052024` (5 November 2024) reduces to 6. |
| `RoundTwelveThirdPass.marker_01062026` | The marker `01062026` (6 January 2026) reduces to 8. |
| `RoundTwelveThirdPass.today_10062026` | Today, `10062026` (6 October 2026), reduces to 8. |
| `RoundTwelveThirdPass.year_2026` | The universal year 2026 reduces to 1 (2 + 0 + 2 + 6 = 10, then 1 + 0 = 1). |
| `RoundTwelveThirdPass.week_dates` | This week's dates, written month-day-year: 30 September 2026 is a master number 22, and 1 to 6 October reduce to 3, 4, 5, 6, 7, 8 in order. |
| `RoundTwelveThirdPass.today_palindromes` | Five of today's six numbers are palindromes (`1122` is the one that is not). |
| `RoundTwelveThirdPass.today_sum` | Today's numbers add up to 5766, which reduces to 6. |
| `RoundTwelveThirdPass.week_total` | 72 numbers were logged this week. |
| `RoundTwelveThirdPass.week_counts` | `1111` was logged 6 times this week; `757`, `1133`, `555` and `1122` 4 times each; `144` twice. |
| `RoundTwelveThirdPass.week_1111_most_frequent` | No number was logged more often this week than `1111`. |
| `RoundTwelveThirdPass.week_eleven_family` | 21 of this week's 72 numbers belong to the 11-family. |
| `RoundTwelveThirdPass.monster_order` | The prime factorisation of the Monster group's order equals the 54-digit number. |
| `RoundTwelveThirdPass.galois_field_exists` | For every prime `p` and `n ≠ 0` there is a field with exactly `p ^ n` elements. |
| `RoundTwelveThirdPass.field_with_eight_elements` | For example, there is a field with 8 elements. |
| `RoundTwelveThirdPass.constraints_preserved_forever` | If one step `F` keeps the constraints `C` satisfied, then every number of steps does. |
| `RoundTwelveThirdPass.fail_closed` | Fail-closed: one run that starts on the constraint surface and leaves it after some number of steps is enough to reject the step rule as constraint-preserving. |
| `RoundTwelveThirdPass.record_keeps` | No disappearing failures: recording a new entry keeps every older entry. |
| `RoundTwelveThirdPass.record_all_keeps` | Recording any sequence of new entries keeps every older entry. |
| `RoundTwelveThirdPass.unresolved_blocks_success` | If any counterexample is still unresolved, A1 has not succeeded, however many entries are added later. |

### `RequestProject/Site/Grid.lean` (6)

| Theorem | What it says |
| --- | --- |
| `Friction.Site.card_cells` | Level `n` shows exactly `n²` representations. |
| `Friction.Site.cells_mono` | Raising the level never removes a representation. |
| `Friction.Site.card_new_cells` | Going from level `n` to level `n + 1` adds exactly `2n + 1` new representations. |
| `Friction.Site.cellIndex_lt` | Row-major numbers of level-`n` cells lie in `{0, …, n² − 1}`. |
| `Friction.Site.cellAt_cellIndex` | Decoding a row-major number gives the cell back. |
| `Friction.Site.cellIndex_injOn` | Distinct cells get distinct numbers. |

### `RequestProject/Site/Tour.lean` (7)

| Theorem | What it says |
| --- | --- |
| `Friction.Site.clamp_lt` | _(no docstring: supporting step)_ |
| `Friction.Site.next_lt` | _(no docstring: supporting step)_ |
| `Friction.Site.prev_lt` | _(no docstring: supporting step)_ |
| `Friction.Site.next_last` | At the last step, `next` stays put. |
| `Friction.Site.prev_zero` | At the first step, `prev` stays put. |
| `Friction.Site.targetAt_of_some` | A step with its own target shows it. |
| `Friction.Site.targetAt_of_none` | A step without a target keeps the previous stage: the stage is never blank. |

### `RequestProject/Skybox/Count.lean` (18)

| Theorem | What it says |
| --- | --- |
| `Skybox.one_mem_icosians` | _(no docstring: supporting step)_ |
| `Skybox.icosians_conj_mem` | _(no docstring: supporting step)_ |
| `Skybox.icosians_mul_mem` | _(no docstring: supporting step)_ |
| `Skybox.rotation_preserves` | _(no docstring: supporting step)_ |
| `Skybox.mirror_preserves` | _(no docstring: supporting step)_ |
| `Skybox.icosians_card` | _(no docstring: supporting step)_ |
| `Skybox.pairs_count` | _(no docstring: supporting step)_ |
| `Skybox.rotation_count` | _(no docstring: supporting step)_ |
| `Skybox.Q5_neg_neg` | _(no docstring: supporting step)_ |
| `Skybox.flipTail_flipTail` | _(no docstring: supporting step)_ |
| `Skybox.flipTail_injective` | _(no docstring: supporting step)_ |
| `Skybox.mirrorMatrices_eq` | _(no docstring: supporting step)_ |
| `Skybox.det_rotations` | _(no docstring: supporting step)_ |
| `Skybox.det_mirrors` | _(no docstring: supporting step)_ |
| `Skybox.rotation_mirror_disjoint` | _(no docstring: supporting step)_ |
| `Skybox.mirror_count` | _(no docstring: supporting step)_ |
| `Skybox.skybox_symmetry_count` | The rotations `x ↦ l·x·r̄` and mirror maps `x ↦ l·x̄·r̄`, over all `120 × 120` pairs of skybox points, give 14 400 different matrices: at least 14 400 different symmetries of the 120-point skybox. |
| `Skybox.skybox_arithmetic` | The plain arithmetic in the message. |

### `RequestProject/TeamReview/GrantPath.lean` (10)

| Theorem | What it says |
| --- | --- |
| `TeamReview.GrantPath.resolve_rejects_missing` | **Missing parents are rejected.** If `g` or any of its ancestors is missing from the registry, resolution fails, whatever the fuel. |
| `TeamReview.GrantPath.reaches_linear` | Parent chains are linear: two ids reachable from `g` are reachable one from the other. |
| `TeamReview.GrantPath.reaches_trans` | _(no docstring: supporting step)_ |
| `TeamReview.GrantPath.onCycle_parent` | The parent of a point on a cycle is again on the cycle. |
| `TeamReview.GrantPath.has_parent_of_cycle` | Everything reachable from a point on a cycle has a parent. |
| `TeamReview.GrantPath.resolve_none_of_all_have_parents` | If every id reachable from `g` has a parent, resolution never reaches a root, so it fails. |
| `TeamReview.GrantPath.resolve_rejects_cycle` | **Cycles are rejected.** If the parent chain of `g` runs into a cycle, resolution fails, whatever the fuel. |
| `TeamReview.GrantPath.resolve_sound` | **Soundness.** A returned path starts at `g`, follows real parent links to a root, repeats no id, and avoids the ids already visited. |
| `TeamReview.GrantPath.resolve_complete` | **Completeness.** Every well-formed, repetition-free path that avoids `visited` is found, given fuel at least its length. |
| `TeamReview.GrantPath.resolve_eq_some_iff` | Resolution from scratch succeeds with enough fuel exactly on well-formed paths. |

### `RequestProject/TeamReview/IT3Checks.lean` (11)

| Theorem | What it says |
| --- | --- |
| `TeamReview.IT3.it3_seven_discriminants` | **IT³ claim, confirmed.** The seven quadratic discriminants multiply to `2^16 · 3^4 · 5^4`. |
| `TeamReview.IT3.it3_covolume` | **IT³ claim, confirmed.** `√(2^16 · 3^4 · 5^4) = 57600 = 240^2 = 0xE100`. |
| `TeamReview.IT3.it3_closure_shift` | **IT³ claim, confirmed.** `172 = 43 << 2`. |
| `TeamReview.IT3.it3_central_edge_hex` | **IT³ claim, confirmed (hexadecimal reading).** `86 = 0x56`, `87 = 0x57`, their sum is `173 = 0xAD`, neither hex digit position produces a carry, and the low hex digit is `13`. |
| `TeamReview.IT3.it3_central_edge_binary_carries` | **Caveat.** In binary, `86` and `87` share set bits, so adding them does carry. |
| `TeamReview.IT3.it3_first_ogg_breaking_heegner` | **IT³ claim, confirmed.** `43` is a prime Heegner number that is not an Ogg prime, and every smaller prime Heegner number is an Ogg prime. |
| `TeamReview.IT3.azimuthal_quarter_turn` | _(no docstring: supporting step)_ |
| `TeamReview.IT3.c4_flips_m6` | **Nader (2), confirmed.** A quarter turn about the `z`-axis flips the sign of the `m = 6` factor. |
| `TeamReview.IT3.c4_fixes_m12` | **Nader (2), confirmed.** A quarter turn leaves the `m = 12` factor unchanged. |
| `TeamReview.IT3.c4_average_m6_vanishes` | **Nader (2), confirmed.** Averaging the `m = 6` factor over the four quarter turns gives zero, so that term has no part that is invariant under the quarter turn (and hence none that is invariant under the octahedral g... |
| `TeamReview.IT3.floor_states_always_integral` | **Watts, confirmed.** Whatever the catalogue and whatever the descent map `g`, a state defined as `⌊g x⌋` is on the lattice for every object. |

### `RequestProject/Zoo/Arena.lean` (8)

| Theorem | What it says |
| --- | --- |
| `EFMWZoo.coreRoster_spec` | The Core roster has 46 distinct animals, and its first 23 are exactly the v1 inventory, in the same order. |
| `EFMWZoo.inventory_names_spell_animals` | Every one of the 23 expanded names in the inventory spells its animal's name through its capital letters. |
| `EFMWZoo.veto_dominates` | **Veto dominance.** Once any run has issued a veto, no further evidence, however many positive runs it contains, makes TURTLE publish. |
| `EFMWZoo.duplicate_in_cluster_counts_once` | **Correlated wins count once.** Adding a passing run in a cluster that already has a passing run does not change the count of independent positives. |
| `EFMWZoo.majority_flipped_by_copies` | **Majority rule can be gamed.** One vetoing run and one passing run: neither rule publishes. |
| `EFMWZoo.unlimited_reentry_eventually_passes` | **Unlimited re-entry eventually publishes a false claim.** Let `E k` be the event that attempt `k` of a false claim slips past the gauntlet. |
| `EFMWZoo.error_budget_bounds_reentry` | **An error budget fixes it.** If attempt `k` lets a false claim through with probability at most `α k`, and the per-attempt budgets over the first `n` attempts add up to at most `total`, then the probability that some... |
| `EFMWZoo.discovery_range_overlaps` | Read as roster numbers, "OCTOPUS…MOTH" is #3–#16. |

### `orion/r16/efmw_axioms_snapshot/EFMWAxioms/Axioms.lean` (12)

| Theorem | What it says |
| --- | --- |
| `EFMWAxioms.A1_residual_limit_nonzero` | _(no docstring: supporting step)_ |
| `EFMWAxioms.A2_trajectory_bounded` | _(no docstring: supporting step)_ |
| `EFMWAxioms.A3_information_time_independent` | _(no docstring: supporting step)_ |
| `EFMWAxioms.A4_rescaling_invariant` | _(no docstring: supporting step)_ |
| `EFMWAxioms.A5_coupling_symmetric` | _(no docstring: supporting step)_ |
| `EFMWAxioms.A6_all_points_related` | _(no docstring: supporting step)_ |
| `EFMWAxioms.C7_quantum_generator_from_curvature` | _(no docstring: supporting step)_ |
| `EFMWAxioms.C8_mass_is_potential_derivative` | _(no docstring: supporting step)_ |
| `EFMWAxioms.C9_uncertainty_has_lower_bound` | _(no docstring: supporting step)_ |
| `EFMWAxioms.C10_interface_matches` | _(no docstring: supporting step)_ |
| `EFMWAxioms.C11_one_lattice_period` | _(no docstring: supporting step)_ |
| `EFMWAxioms.C12_two_feedback_steps_remain_admissible` | _(no docstring: supporting step)_ |
