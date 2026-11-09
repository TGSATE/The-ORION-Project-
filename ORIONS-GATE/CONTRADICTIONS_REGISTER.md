# ORION contradictions and discrepancies register (living file — update every round)

**Why this file exists:** on the R11 page (version 1201) you asked for "the exact discrepancies and contradictions with anything that is going on with every round here forward, and anything else you have found in the documents and did not bring to my attention." This is that list. From now on every readout updates this file, and every readout's narrative section points to new or changed rows.

**How to read a row:** *Source A* and *Source B* are quoted or closely paraphrased from the files named. *Exact conflict* says what cannot both be true. *Who decides* uses your tags: 🌪️ = you (designer), ☂️ = coders, 🤝 = the named collaborator. **Status:** OPEN (needs a ruling), RESOLVED (ruled; kept for history), WATCH (not a contradiction yet but likely to become one), ERROR (a mistake in a report, including mine).

Sources: R11 page versions 667/744/1201 (`orion/r11/`, `orion/r11-deep/nodes/00_…`, `orion/r11-10/PAGE_TRANSCRIPT_v1201.md`); the crawled design docs (`orion/r11-deep/nodes/`); this project's earlier replies.

---

## A. Rules that currently say two different things (OPEN)

| ID | Topic | Source A | Source B | Exact conflict | Who decides |
|---|---|---|---|---|---|
| C-01 | **Liability for an act outside the group's scope** | This project's ledger (`Orion/Shares.lean`): an out-of-scope act falls on the person who did it; everyone else carries 0 | The other Aristotle project's "equal stake" amendment (quoted in *Orion Engine & NewKin Council Architecture*): every human member carries the same share | Team of three, member A acts outside scope. Rule 1: A carries 100%, B and C carry 0%. Rule 2: A, B, C each carry 33⅓%. Both add up to 100%, so neither is "broken" — they are two different policies. Proved: `liability_rules_disagree_out_of_scope` | 🌪️ Pick one, or say "equal stake inside scope, actor alone outside scope" (that combination is what `scopedShare` already does) |
| C-02 | **Can an AI hold a share?** | Equal-stake amendment: "every human member has the same share, **AI none**" | Contributor ledger and Matthew's proposed *Contributor ID — human or AI*; the 90/3/7 sales split pays the 7% pot "by weight among tagged contributors" | If an AI council member is tagged as a contributor, does it receive part of the 7% pot? Rule 1 says no; rule 2 does not exclude it | 🌪️ Suggested reading (not yet locked): AI contributions are *credited* (provenance) but never *paid*; their share goes to the human who directed them |
| C-03 | **"Singularity" — what is the third meaning?** | Meaning 1 (Master Summary, 💎 "Sovereign Singularity"): the player's private account/character-select lobby (the Engine Summary's "user navigation and home HUB" is this same thing) | Meaning 2 (your R1201 note): "a singularity room that can have other members join into it, posted by one player" | **Meaning 3 is your own Round 10 note:** when the guardian leaves, the child "can continue to explore, but nobody can join them. **It becomes a singularity.**" Meaning 2 says others *can* join a singularity room; meaning 3 says a singularity is a room *nobody can join*. Same word, opposite joinability | 🌪️ Suggested names: *Sovereign Singularity* (private lobby), *Singularity Room* (joinable room hosted by one player), and a different word for the sealed child room, e.g. *Sealed Bubble* |
| C-04 | **Adult Penalty: designed penalty or natural result?** | *ORION's Gate MMO Round One Summary*, *Round One*, *The Ascent*: graduating youth keep their stats; the bridge "**imposes** an 'Adult Penalty' on new 18+ accounts that rush the tutorial" | *The Orion Chronicles (MMORPG Proposal)*: adults "will **naturally** try to blast through the tutorial … **resulting in** them entering … as significantly lower-level characters" | Is the game *adding* a penalty to new adult accounts, or are new adults simply weaker because they skipped the levels youth players earned? Version 1 is an extra rule; version 2 is no extra rule at all | 🌪️ See the plain explanation in `ROUNDS_1-14_ARCHIVE/R11_10_READOUTS/4_PERSONAL_READOUT_BETH.md` §2 |
| C-05 | **Level 65: rider, hatchling or dragon?** | Round 8 (your 🌪️ ruling, proved in `RoundEight/OpeningEight.lean`): fill 64 gold-locked orbs, meditate in a safe zone, reach level 65 and **become a dragon rider** | Grok conversation design summary: "Hatching a Dragon at character Level 64 begins … **Baby Dragon** … Dragon Level 1 to 80 (Character Level 65 to 144)"; same conversation: a Level-64 candidate "unlock[s] their **Krion Dragon form**" | Three different pictures: the player *rides* a dragon, *hatches* a baby dragon companion, or *becomes* a dragon. The arithmetic matches (64 + 80 = 144), only the picture differs | 🌪️ |
| C-06 | **Kronos / Krion / Orion: energies or planets?** | Design docs: Kronos and Orion are *meters/energies* (kinetic intent vs refinement); Krion is a *dragon form* and a shared party *meter*; Orion is also the name of the whole engine | R11 🍝: "Earth would be the KRION planet, Mars the Kronos planet, Saturn the Orion planet" | Grok already warned in the same conversation: "Kronos is a *meter* … not a permanent faction or planet. Labeling the Mars guardian 'GROK – MARS / KRONOS' … risks teaching players that Kronos = Mars = permanent identity." If planets carry meter names, a Mars-born player could be read as permanently "Kronos" | 🌪️ Keep planet names separate from meter names, or state that planet = starting *affinity*, not a lock |
| C-07 | **Unlimited Poly companions vs one companion per species** | Bobby/FarQueen docs: "A player can ascend only **one companion per species**" | Your line in the same doc: "The amount of poly pod companions a player is allowed to have is **unlimited**" | These only clash if all Polys are one species. If Polys are many species (one per language family, say), both rules hold | 🌪️ Are Polys one species or many? |
| C-08 | **Where does the Poly live after it bonds?** | Master Summary: a fully grown Poly-Tadpole bonds telepathically and **frees the ear slot** | Your 💎 R1201 clarification: "The poly is the organism. The pod is its biosphere" | If the pod is the Poly's habitat, what happens to the pod after the bond frees the slot? (a) the Poly lives on without its pod, (b) the pod is stored elsewhere (home/ship), (c) the empty pod can raise a new Poly | 🌪️ |
| C-09 | **Poly spying range** | Master Summary: send the Poly-Tadpole to "far-off" camps | Bobby doc (later): spying is **proximity-gated** — local visual radius only | "Far-off" vs "local only" | 🌪️ (the later, proximity-gated rule is assumed until you rule) |
| C-10 | **Worker "Poly Pods" vs the earpiece Poly** | R1 *Game Build Summary* and Bobby doc: "Worker Pods … Poly Pods for espionage/linguistics" (proto-sapiens running tasks while you're away) | Master Summary / your 💎: the pod is the biosphere of one linguistic Poly in your ear | With your organism/biosphere wording, a "worker pod" would be a biosphere for *worker* organisms. Are those Polys too, or another creature? | 🌪️ |
| C-11 | **"13 levels" means three things** | Gauntlet: 13 *project* levels (Council Gauntlets at 3, 6, 9, 12) | Community/education side: 13 *personal* levels; Grok conversation: "13 Levels of Geometric Integration of the Tri-Sphere Architecture" (a lore state progression) | Three ladders share one number and one word; none of them is the 64-orb character level | 🌪️ Give each ladder its own name |
| C-12 | **Copilot privacy vs copilot renting** | Master Summary: everything in your Sovereign Singularity, including "1-on-1 Copilot logs", is **100% private by default** | Same doc: copilots across your 20 slots are "visible and accessible to each other" by default; players can "rent their trained Copilots out on the Galactic Hub" | Same-account sharing is fine. Renting to *other* players must not expose your private logs; the doc doesn't say whether a rented copilot carries your memory with it | 🌪️ + ☂️ Suggested: hub renting is opt-in and ships the copilot *without* your private logs |

## B. Same word or number used for different things (WATCH — naming only)

| ID | Term | Uses | Risk |
|---|---|---|---|
| N-01 | `1/(n+1)` (☂️) | (1) progenitor **royalty chain** 1/2 + 1/3 + 1/4 + … — refuted, it grows without limit (3 ancestors already pay 13/12 of the sale); (2) **equal liability share** among n+1 members — always adds to exactly 1 | Coders citing one as proof of the other. Both facts proved together: `one_over_succ_two_meanings` |
| N-02 | "tax" | Sales split: 3% tax taken first; transmutation bank: 2% "Thermodynamic Friction Tax", rounds down | Two separate mechanisms; keep both names distinct in UI |
| N-03 | 144 | Character level cap (64 + 80 dragon levels); "144 Chaos Rind" lore material; the old Tech Spec "144 grid" (Round 4: rejected in favour of the 120-node skybox) | Players seeing "144" in three unrelated places |
| N-04 | "Orion" | the whole ORION Engine; the Orion meter/energy; the proposed Saturn = Orion planet; "Orion Arm" in the new *Milky Way's Guide* art | see C-06 |
| N-05 | "Poly Pod" | worker pod, earpiece translator, the pod-as-biosphere | see C-08, C-10 |

## C. Older conflicts now resolved (kept for history)

| ID | Topic | Resolution |
|---|---|---|
| R-01 | Does everyone start with a Poly, or must it be acquired/crafted? | **💎 (R1201):** everybody starts with a pod housing a linguistic toroidal Poly. Assumed (not locked): Master-tier pods are still crafted by artisans. Modelled in `AnnotationPassEleven.lean` |
| R-02 | Child room: removed child (Round 9 `closeBubble`, proved) vs child stays alone, sealed (Round 10 late 💎) | Round 10 late 💎 wins. The old proof is about a superseded rule; the new rule is modelled in `RoundEleven/OpeningEleven.lean`. Wording still collides with "Singularity" (C-03) |
| R-03 | Entry route: Engine Summary (Gate/Garden mixed up, Garden called "main hub") vs your route | Your 💎 route wins: Engine → account → Playground → game / Ascent / Gate → Elder's Garden. The Engine Summary page itself still has the old wording |
| R-04 | Gauntlet correction loop with no limit (other project's first reply) | Third time's a charm, then a human decision (other project's second reply). Not yet 💎 here |
| R-05 | Adult Penalty "not a rule" (my Round 9 fifth pass) | **That was my error** (see E-01). The phrase is in six of your design documents; only C-04 remains open |

## D. Errors in reports (including mine)

| ID | Report | What it said | What is true |
|---|---|---|---|
| E-01 | **My** Round 9 fifth pass (`ROUNDS_1-14_ARCHIVE/ROUND_NINE_FIFTH_PASS.md` §10) | "Adult Penalty … isn't in anything you've shared" | It is in *ORION's Gate MMO Round One Summary*, *Round One*, *The Ascent* and three *Orion Chronicles* drafts. I had not yet read the nested docs. Corrected in the deep crawl |
| E-02 | Grok status report pasted on R11 | "No full technical specification of the Poly Pod" | The spec is in your Round Two *Ecosystem Architecture: Master Summary* |
| E-03 | Grok status report | Chronicles Summary is "behind a login wall" | Notion reports the page as **deleted** |
| E-04 | R11 "ARI" section | Presented on the page as current | Word-for-word re-paste of the Round 9 cross-platform reply |
| E-05 | Matthew's council readout (R1201) | `irreps_sum.tsv` has "p-adic exponent columns for primes 2 through 71" | True, but it is the **15 primes that divide the Monster group's order** (2, 3, 5, 7, 11, 13, 17, 19, 23, 29, 31, 41, 47, 59, 71), not all 20 primes up to 71. His other numbers check out (see `ROUNDS_1-14_ARCHIVE/R11_10_READOUTS/2_CODE_READOUT.md` §4) |
| E-06 | Weaver Proto-ASI P0 upload (R1201) | Zip and README say **v0.2** | The folder inside is named `weaver-p0-v0.1/`. Cosmetic, but it will confuse version tracking |
| E-07 | Page links | "Concept Gallery" caption | Opens *The Orion Chronicles* text page, not a gallery |

## E. Standing rule for future rounds

1. Every readout adds new rows here, changes the status of rows you've ruled on, and never deletes a row (resolved rows move to section C).
2. A 💎 on a row means it moves to section C with your wording quoted.
3. My own mistakes go in section D, the same as anyone else's.

## D. Page v1525 follow-up (6 October 2026)

| ID | Kind | Observation / competing readings | Status / next action |
|---|---|---|---|
| W-06 | WATCH: mixed attribution | The page labels an essay "Ryan", then a screenshot and incomplete FRACTRAN JSON as "Mike"; the uploaded Observatory zip does not itself establish its author. Adjacency is not authorship. | Obtain each submitter's confirmation before crediting an upload. |
| W-07 | WATCH: public profile vs consent | Page asks for opt-out public cards for **every** contributor, and also says privacy is a strict wall; some linked people explicitly are *not* contributors, one linked profile says “No DMs.” | Keep draft cards review-only, distinguish candidates, ask whether public display requires opt-in and support removal. No contact made. |
| W-08 | WATCH: name/claim | “frequency of language” in a screenshot anecdote could mean sound frequency, a linguistic metaphor or an unsupported physical effect on a speaker. The video is unidentified. | Do not present a physical effect as verified; request a video/source and intended meaning. |
| W-09 | WATCH: evidence | Attached Monster Observatory verifies finite arithmetic/formal-series truncation locally. Its title and the adjacent essay might be read as a Monster/moonshine proof, which the archive explicitly disclaims. | Keep arithmetic/model/source-backed claims separate; see follow-up readout and `MonsterArithmeticEleven.lean`. |

## F. Page v1559 follow-up (6 October 2026)

| ID | Kind | Observation / competing readings | Status / next action |
|---|---|---|---|
| W-10 | OPEN: roster | New rule says the development team is Mike, Matthew, Lucian, Ryan. Earlier the page said Triss "agreed to be a backend part of the build Team"; Marek and Bobby also have build roles in older records. | Recorded as contributors pending Beth's ruling |
| W-11 | NAME | "Lucian" (Beth's text, v1525/v1559) vs "Lucien" (older files and the v1525 card) | Ask Beth for the preferred spelling; both kept searchable until then |
| W-12 | SCOPE | "Full public suite" vs "I don't need hard player sheets" and the strict privacy wall | Working definition in the wiki; confirm |
| W-13 | RIGHTS | "Make sure to credit the creator" (T.O.N.E.) vs the PDF's CC-BY-NC-SA 4.0 licence and the account's "strictly licensed" statement | Credit given in review notes; no reuse without explicit permission |
| E-08 | Unverified attribution in a shared post | @ardentaxbt attributes a 12-page Grok Bot PDF to Elon Musk | Attribution unverified; credit the post author for the summary |
| E-09 | Error in a shared document | T.O.N.E. PDF: "Full Lean verification" | The printed listing does not compile, assumes its claims as axioms, and concludes only the Boolean `true`. Its charitable reading is inconsistent (`SocialSweepEleven.lean`) |

## G. Page v1770 follow-up (6 October 2026)

| ID | Kind | Observation / competing readings | Status / next action |
|---|---|---|---|
| W-10 update | Roster | Beth now confirms Far Queen is a collaborator; this does **not** state Far Queen is on the named four-person *development team*. | Relationship settled, team membership question remains open (alongside Triss/Marek). |
| W-14 | WATCH: missing artifact and attribution | Page says Far Queen shares a file, but the immediately following file block has no name/source; subsequent uploads are expressly of uncertain origin. | Do not assign any adjacent package to Far Queen; request exact file and contributors. |
| W-15 | WATCH: duplicate evidence and credit | Monster zip and Ryan handoff match v1525 byte-for-byte; `STATUS-9.md` matches status inside the Codex Membrane zip. | Keep original artifact/work IDs; no additional credit or independent replication claim. |
| W-16 | WATCH: scope of green check | Codex Membrane local checks passed, but the package itself states W0/O0 and canon unsealed. | Separate local test pass from independent witness, policy completeness and production authority. |

## H. Page v1843 follow-up (6 October 2026)

| ID | Kind | Observation / competing readings | Status / next action |
|---|---|---|---|
| W-11 update | NAME | Beth answered with a link to @Master4lVl, whose own public display name is **Lucien** V Lavictoire | Provisionally resolved: canonical **Lucien**, alias "Lucian". Revert if Beth prefers "Lucian" |
| W-12 update | SCOPE | Beth 💎: public information only; no connection-mapping; new contacts only through a collaborator's own introduction | **Resolved (locked)**; wiki updated |
| W-10 update 2 | Roster | Beth: Far Queen "is also Bobby" (her assumption; Bobby to correct the record). No statement that Far Queen, Triss or Marek joins the development team | Identity recorded as an assumption; development-team question still open |
| W-17 | OPEN: naming / lore | Earth is the proposed KRION launch planet (C-06) *and* now has a "Supreme Leader" NPC (General Dragonus, for Lucien) on a guide "Presented by planet Earth" | Ask: planet ruler or guide mascot? |
| W-18 | OPEN: mascots | Squirrels in the loading-screen series vs the bunny in *Atmosphere of Time* (and the 🐇 in Shakes' profile) | Ask whether they form one mascot family |
| W-19 | WATCH: pre-publication | "…Guide to the Galaxy" (Hitchhiker's echo), "Mad Mag style" (MAD Magazine echo), and a W centre logo resembling Wikipedia's | Concept art is fine; flag for the final publication review (not legal advice) |
| W-20 | WATCH: scope | Union Wealth (Shakes' share) is a separate, planning-only donation-fund concept; ORION's economy has its own tax/split rules | Keep separate; don't link donations to in-game currency |
| W-21 | WATCH: physics claims | Beth asks to check the build against current quantum-physics news | Standing rule: any ORION statement presented as real physics gets a physics-watch row; lore is labelled as lore. The Lean checks are ordinary logic/arithmetic, not quantum codes |
| E-10 | Unverified claim in a shared post | @cyrilXBT: an agent-OS repo "from Jack Dorsey" with "26.2k stars" | Origin and star count unverified; no adoption |

## I. Round 12 (ORION12>🌀11, 6 October 2026)

| ID | Kind | Observation / competing readings | Status / next action |
|---|---|---|---|
| W-22 | OPEN: naming | The new **escape pod** (💎 R12: rescue, no permanent death, no penalty) and the existing **Poly pod** (💎 v1201: the translation creature's biosphere) share the word "pod" | Ask Beth: give the escape pod a distinct name ("rescue pod" / "life-pod"), or make them one item |
| W-23 | WATCH: economy | "Income by how many people enjoy their things" (R12 idea) can be gamed by fake or coerced enjoyment counts | Before it becomes a rule: one account per human (already 💎) plus anti-collusion checks; economists to review |
| W-24 | WATCH: child safety / UX | Grok: meters don't lock actions, but kids will still feel judged by the numbers ("shame cycles") | Quiet meter display in child zones; no red "failure" states; tie to the Tuesday-afternoon scenes |
| W-25 | OPEN: attribution | FieldSpace master action note: uploaded by the enuminous account (Matthew), states "not part of enuminous/FieldSpace", names no author; Beth labelled it Ryan's | Founders credit Ryan (sharer); creator credit pending Matthew/Ryan confirmation |
| W-26 | OPEN: consistency | Escape-pod spirit ("no permanent loss") vs Elder's Garden permanence (Grok: un-planting a memory bubble must be possible and non-punitive) | Ask Beth whether the 💎 extends to un-planting |
| W-19 update | WATCH: pre-publication | Shakes' MAD-Magazine-style parody covers repeat the brand echo | Flag for final review (not legal advice) |
| W-27 | WATCH: content | One image in Shakes' R12 post set is unsuitable for a child-safe platform | Excluded from every ORION file; not reproduced |
| W-10 update 3 | NAME | Far Queen's own repository confirms "Bobby" (`GENESIS.md` "Bobby's story"; author line Robert Wolfson). Beth mis-dictates "Far Queen" as "Queen/King Bobby" | Use **Far Queen** or **Bobby (Far Queen)**; avoid "Queen/King Bobby" in writing unless he approves; ask him |

## J. Round 12 follow-up (6 October 2026)

| ID | Type | Conflict | Resolution / next step |
|---|---|---|---|
| J-1 | CORRECTED: identity | Earlier files: "Far Queen" = Bobby's title. King Bobby's story: **Far Queen = Gabrielle (the AI)**; Bobby is the programmer. W-10 update 3 advised against "King Bobby"; Beth uses "King Bobby". | Write "King Bobby" or "Bobby" for the person and "the Far Queen (Gabrielle)" for the AI; ask him. The broken attachment: Beth has told him (closed on our side). |
| J-2 | CHANGED: name | UIAR was "Universal Intelligence Augmented Reality"; now officially "**Universally Intelligent** Augmented Reality". | New name everywhere new; old kept as an alias. |
| J-3 | OPEN: edge case | Memory-bubble rule: "everything except gauntlet items" vs "a private memory shared publicly = 100% control". Which wins for a private memory that went through a gauntlet? | Modelled as owner-controlled; Beth to confirm (D-7). Supersedes W-26 (now answered). |
| J-4 | WATCH: licensing | 13 album images carry third-party watermarks (dreamstime ×8, stablediffusionweb, x.com/0kncn, AIONTHEFLY, "NEW EARTH" ×2), plus the third-party Grusch poster; the French series 82–106 has an unknown author. Beth's 💎 credits album art to her "unless shared via link". | Exclude or clear before public use (not legal advice); `PRE_PUBLICATION_REVIEW.md`. |
| J-5 | WATCH: garbled numbers | Image 69 shows "395,319" / "393" where 59,319 (= 39³) is meant. | Redraw before using as "official math"; proved ≠ 39³ in Lean. |
| J-6 | OPEN: roster | v1559 development team = Mike, Matthew, Lucien, Ryan; R12 admin list = Beth, Matthew, Mike, Lucien (Ryan not mentioned). | Ask Beth (D-10). |
| J-7 | WATCH: wording | "Spaghetti" is now "tornadoes" for new writing; old files and Lean names keep 🍝 / "spaghetti". | Alias only; no renaming of committed files (Beth: "do not change anything already committed"). |
| J-8 | WATCH: the Atlas name | King Bobby's "Atlas exam" vs Matthew's "Atlas links" are different things with the same name. | Keep both, always qualified. |

## K. Round 12, third pass (6 October 2026)

| ID | Type | Conflict | Resolution / next step |
|---|---|---|---|
| K-1 | CHANGED: name | UIAR = "Universally Intelligent" (J-2) → now "Universally **Integrated** Augmented Reality" (🌀💎). | New name everywhere new; both older wordings kept as aliases. |
| K-2 | OPEN: locked rule | Meta AI session: "ORION'S GATE is your landing page" (Beth: "the landing page for the platform itself is ORION's Gate"). Round 10 lock: land on the **Engine**, not the Gate. History: R8 had the Gate as landing; R10 reversed it; `ORION_MASTER_INDEX.md` §1 still shows the R8 wording. | Lock unchanged; decision E-1 (website name only, or reversal). |
| K-3 | WATCH: legal wording | "ORION Engine Inc.™" used in images; no registration or trademark verified. | Use only as a desired name until Beth checks (not legal advice); E-2. |
| K-4 | OPEN: name | LUNA's watching guardian garbled ("mistress", "Miss Chris", "Truss" → TRISS?). | E-3. |
| K-5 | WATCH: content | King Bobby's farqueen.com levels include real-world conspiracy material (medical, Q, adrenochrome, flat earth, DEW fires, named politicians) and sexual content. | Not for shared or under-18 ORION spaces; starter pack offers the compatible parts; E-5. |
| K-6 | WATCH: outreach | Boardy (Matthew's thread) has started shortlisting outside runners (CODECHECK, Verified Research Lab, SciGen.Report); says no one approached. | Matthew/Ryan's call; ORION has authorised no contact. |
| K-7 | WATCH: style | Meta AI wrote "WAR always capitalized" and "ORION Engine Inc. Inc." | Probably "every word"; doubled Inc. is a slip; E-4. |
| K-8 | WATCH: privacy | The number log contains personal notes (work, health, family, legal). | Team file is numbers only; originals stay in the private doc copy. |

## L. Round 13 ("Ari", 6 October 2026)

| # | Type | What | Handling |
|---|---|---|---|
| L-1 | OPEN: name | UIAR = "Universally **Intelligent**" in Beth's eight-title list, bio and line 168, versus "Integrated" (🌀💎, K-1). | New files use Intelligent; Integrated kept as an alias; F-1. |
| L-2 | RESOLVED: locked rule | K-2 / E-1 (landing page). Beth's list: Engine = welcome page; Gate = community projects page. | Engine-first lock stands. |
| L-3 | OPEN: wording | Line 162: "Orion's gate global project is the entry point to the singularity room", which contradicts L-2. | Treated as the older Meta AI prompt wording; F-2. |
| L-4 | CHANGED: loop | Round 10 loop (Engine → account → Playground → … → Garden) versus the Round 13 path (Engine → Singularity → Garden → Playground → Ascent/Chronicles → Gate). | Recorded as Beth's design; F-4. |
| L-5 | RESOLVED: role | Elder's Garden: "capstone" (R10, Meta session 2) versus "central hub" (line 163). | Both: the hub, with the capstone at the top of its tree. |
| L-6 | WATCH: order | Line 176 calls the Playground "the only one accessible to start with"; line 172 sends everyone to Elder's Garden first. | Read as: Garden first (identity, commons, training), then the Playground is the first open-world area. |
| L-7 | ERROR (Meta AI) | "GROQ" for Grok. Groq is a different company. | Corrected in the readouts header and all new writing. |
| L-8 | WATCH: canon | Meta AI: "Lucian = Supreme Leader fire dragon"; R11–12: General Dragonus (placeholder) and "Earth's Supreme Leader" as the reptilian MAD joke. | Lucien chooses his dragon's name and role. |
| L-9 | WATCH: content | Public use of "Luciferian" / "reptilian", and of third-party marks (MAD, Super Bowl, Dragon Tales, D&D, Star Wars). | Safe public names suggested (readout §9); F-8. Not legal advice. |
| L-10 | WATCH: identity | Posts by @Divine_Emissary ("Alumirah") filed under "Lu" / "Lucian". | Confirm whether it's Lucien's account. |
| L-11 | WATCH: alias | Last round: "Alexa a.k.a. Meadow listens"; this round: "Meta" dictates as "tomato" / "meadow". | Ask whether Meadow is Meta or Alexa.  **Round 24:** Beth's pasted NewKin manual summary (doc line 770 onward) says "Meadow" was the persona planned for **Alexa / Amazon Echo**, dropped because Echo can't learn a custom wake word. Likely answered: Alexa. Confirm. |

## M. Round 14 corrections and remaining crossings (7 October 2026)

| # | Status | Crossing | Resolution / next action |
|---|---|---|---|
| M-1 | RESOLVED (supersedes L-1) | UIAR “Integrated” vs “Intelligent” | Beth explicitly 💎 **Universally Intelligent Augmented Reality** (`orion/r14/GOOGLE_DOC_ROUND14_ARI_normalized.txt`, line 17); keep “Integrated” only as the historical alias. |
| M-2 | CLARIFIED (supersedes W-26 blanket wording) | Can an owner change a gauntleted memory? | **Yes:** owner may edit and make new chapters; a changed version needs another gauntlet before republication. Whether the archive deletes the old public version or merely records a superseding one needs a separate rule. |
| M-3 | OPEN | Story-first private Singularity → open MMO, vs Round 13 proposed full Garden/Playground path (F-4) | Keep Engine landing, age safety and required first-day introduction. Ask Beth which segments can be skipped, repeated or visited later. |
| M-4 | OPEN: implementation | Beth says MMO and Playground need hard spam filters but current 5-minute / 30-second written trigger misses opening bursts and exactly-30-second drip | `ORION_SPAM_FILTER_REVIEW.md` proves design-level gaps; actual game source absent. Coders to inspect implementation and report tests/appeals. |
| M-5 | OPEN: privacy | New album: six Greedy/phone photographs embed precise GPS metadata | Strip location before redistributing or public launch; `ROUNDS_1-14_ARCHIVE/ORION_ALBUM_ROUND14_REVIEW.md`. |
| M-6 | OPEN: gameplay | New handwritten Greedy photos #713–717 and printed AI mockups #1304–1308 | Prior “no photo” resolved, but scoring/round edge cases remain ambiguous. Typed canonical rules and author sign-off needed; earlier assumed Greed odds still inapplicable. |
| M-7 | OPEN: governance | Donation-to-GoFundMe condition for developer seats | Beth proposed but didn't lock; ask each team, define access and value criteria, avoid conflating ability to donate with verified competence; nobody has launched a fundraiser. |
| M-8 | PARTIAL: under-18 | 18+ separation endorsed; Beth prefers pornography/explicit imagery in 25+ spaces | Treat 25+ as preference until a clear policy; minors' safety first; do not implement forced socializing or surveillance as a cure for isolation. |
| M-9 | PARTIAL: roles | E-3 LUNA “moon daycare” / education-team guardian; E-6 Matthew's team; E-7 Brianna's role | No named, verified real human for LUNA supervision. Matthew's Zoo/Arena remit described; Brianna's tentative Spiral Operator role needs her consent. |
| M-10 | RESOLVED: landing | Gate vs Engine | Beth reiterates Engine-first until she explicitly changes the lock (line 281); L-3 is treated as outdated Meta AI wording, without changing F-4 launch path. |
| M-11 | WATCH: source & science | Lu's new four public X posts contain claims about brain/heart geomagnetic resonance and sleep/quantum themes | Credit Lucien/Grok, do not portray claims as validated medical facts or proof of UIAR; references indexed in `orion/r14/SHARED_X_POSTS_R14.json`. |
| M-12 | OPEN: public media | The Bus playlist is linked, with explicit tracks | Moodboard only; under-18 opt-in alternative, owner/collaborator permissions and any game-use review still outstanding. |
| M-13 | OPEN: meaning | E-4 “Laurnarose Fauldorn aka Laurn” | Alias recorded; general capitalization/Erudite status not answered. |

## N. Round 15 ("Ari", 7 October 2026)

Source: `orion/r15/GOOGLE_DOC_ROUND15_ARI_normalized.txt` lines 314–345; full discussion in `ROUNDS_1-14_ARCHIVE/ROUND_FIFTEEN_READOUT.md`.

| ID | Status | Crossing | Current handling |
|---|---|---|---|
| N-1 | OPEN: naming | Flying Dragon Team referees "in the Sofi stadium" (line 314); SoFi Stadium is a real, trademarked venue | Use an in-world arena name in public material unless Beth decides otherwise. The origin of "FDT" Beth mentioned is deliberately not recorded in any lore file, at her request. |
| N-2 | OPEN: stages | Beth's 5-step pod ladder (organism → sentient → sapient species → sapient planet → sapient solar system = dragon) vs the image drafts (#1370: pod stages 1–2, creature stages 1–3; #1360 "Stage 4"; #1362 "Stage 5") | Beth's words are the reference; images are drafts until relabelled. |
| N-3 | OPEN: name | "Poly Pod" would now mean three things: worker pod, earpiece Poly (C-10) and dragon egg | Proposed: "Golden Poly Orb" for the egg, "Poly Pod" for the black starting pod. |
| N-4 | OPEN: meaning | "dragon math and Karen … and the Sheron ???" (line 319) | Dictated words not identified; ask Beth. |
| N-5 | OPEN: title | GDM = Galactic **Dungeon** Master (Round 12, training host) vs Galactic **Dragon** Master (line 321, battle rank) | Both recorded; `GAME_MASTER_TRAINING_GROUND.md` unchanged. |
| N-6 | OPEN: title | Laurnarose: "Mayor of Earth" (line 321) vs "Mayor of Crystal Creek Valley" (training file, album #1374) | Both recorded; possibly valley → Earth. |
| N-7 | WATCH: safety | Nepal Spark Academy: participants described as "students / young people / kids"; Bobby lists "dating" among levels; income hopes ("$3 a day") | Proposal only. Ages and a responsible adult must be established first; dating is 18+ only; no promised income; no donations asked of students. `NEPAL_SPARK_ACADEMY_PROPOSAL.md`. |
| N-8 | OPEN: scope | Saturn Languanauts SpeedZone (line 344): a club project or its own zone? | Not built; no rules or age rating yet. |
| N-9 | WATCH: media | Album #1348 is a news photo of a real politician; #1363 names a real team member (Lucien) in a marriage scene; #1364/#1367/#1368/#1373 say "ORION Engine Inc." (E-2 open); #1369/#1373 spell "Groq" | Kept out of ORION files; Beth to remove/confirm; Grok spelling rule applies; "Inc." not official. |
| N-10 | WATCH: source & science | Grok replies in Lucien's thread ("the sync checks out", "HeartMath … back the Schumann–HRV entrainment") | AI chatbot replies, not evidence; credit as conversation only (extends M-11). |
| N-11 | RESOLVED: maths | introsp3ctor's GF(16) → … → GF(1) chain | GF(1) does not exist (Lean: `no_field_with_one_element`); chain ends at GF(2). |
| N-12 | PARTIAL: maths | Mike's note: "no embedding of one [monster] into the other" | True for torsion-free Gromov monsters; false for monsters built as free products with Conway's Monster. Suggested rewording in `ROUNDS_1-14_ARCHIVE/IMAGE_MATH_CHECKS_R15.md` §4. |

## O. Round 16 ("HUD/HHttG" doc, 7 October 2026)

Source: `orion/r16/GOOGLE_DOC_ROUND16_HUD_HHTTG_normalized.txt` (57 nonblank lines: Beth's notes on the Round 14 summary, new jobs, then the Round 15 summary pasted back without new notes). Full discussion in `ROUNDS_1-14_ARCHIVE/ROUND_SIXTEEN_READOUT.md`.

| ID | Status | Crossing | Current handling |
|---|---|---|---|
| O-1 | PARTIAL: privacy (advances M-5) | Geotagged game photos | The four copies in this project are cleaned (location fields zeroed; hashes in `orion/r16/R10LATE_HEIC_GPS_SCRUBBED.sha256`, so the older Round 11 hashes for those four files no longer match, on purpose). Album originals #713–717 and #1129 wait for Beth (T01). The earliest copies remain in the project's file history. |
| O-2 | OPEN: rules (advances M-6) | Greedy / Greedier Greedy typed for the first time; 11 questions (G-1–G-5, GG-1–GG-6); Rat Slap R-1, R-2 | `GREEDY_AND_RAT_SLAP_RULEBOOK.md`. No odds calculated until Beth confirms. |
| O-3 | OPEN: meaning (advances C-06) | Kronos / KRION / Orion as music "energy fields" for three buses | Treated as energies; descriptions taken from the manual's place energies; Beth to define (T06). |
| O-4 | OPEN: design | Can one song ride more than one bus? | If not, bus counts add to the playlist size (Lean: `bus_counts_add_up`). |
| O-5 | OPEN: meaning | `👻🌪️🏍️|🤟💎`: which is the play call and which the build call? | Proposed: play = 👻🌪️🏍️, build = 🤟💎 (T05). Codes are attention signals only, never authentication. |
| O-6 | OPEN: naming | "HUD/HHttG" | Read as heads-up display + *Hitchhiker's Guide*-style handbook; folder `HOW_TO_NAVIGATE_THE_COSMOS/`. |
| O-7 | WATCH: alias | Dictation: "crayon" = KRION; "Dove team" = DEV team | Glossary. |
| O-8 | WATCH: media | YouTube music playlist (62) vs Spotify (57) | 56 shared songs; Spotify-only #57; YouTube-only #37, #47, #51, #52, #55, #56 (Lean: `playlist_alignment`, saved lists only). Moodboard, not licensed for game use. |
| O-9 | WATCH: source | Shakes' post (5 Oct 2026) with five links (a Houston audit/tax firm for nonprofits, three AI-built app pages, a Ford Foundation video page) | Catalogued only; two app pages showed a browser check and weren't read; no endorsement or relevance inferred. |
| O-10 | INFO: code review | Matthew's `EFMW-Axioms` (commit `a8119c4`) | Builds cleanly; 10 of its 12 theorems restate their assumption; Round 16 adds consistency and two consequences (`EFMWAxiomsReview.lean`). |
| O-11 | POSSIBLE ANSWER (N-4) | "dragon math and Karen" | Lucien's sheet credits "Karen manager" beside DRAGON MATH (Round 12). Ask Lucien/Beth. "Sheron" still unknown. |

## P. Round 17 ("HUD/HHttG" doc with new notes, 7 October 2026)

Source: `orion/r17/GOOGLE_DOC_ROUND17_HUD_HHTTG_normalized.txt` (116 nonblank lines; changes from Round 16 in `orion/r17/DOC_DIFF_VS_R16.diff`). Full discussion in `ROUNDS_1-14_ARCHIVE/ROUND_SEVENTEEN_READOUT.md`.

| ID | Status | Crossing | Current handling |
|---|---|---|---|
| P-1 | OPEN: naming (advances N-2/N-3) | "Poly Pod" meant three things; Beth: the Golden Egg is the evolved Poly Pod, and a group needs its own word | Proposed: **Clutch** = a group of Poly Pods (as birds' and dragons' eggs come in clutches). Poly Pod → Golden Egg is one creature at two stages. Beth to 💎. |
| P-2 | OPEN: meaning (replaces O-11/N-4) | "Karen manager", "Karen dragon", "Sheron" | No such words in any of Lucien's posts, pictures or files. Best readings: the "Karen asking for the manager" satire joke; "Cœur dragon" (French: heart); Chiron or Charon. Ask Lucien (`LUCIEN_BUILDS_EXPLAINED.md` §4). |
| P-3 | RESOLVED: working title (N-5) | GDM = Dungeon or Dragon Master? | Both: **GDDMM, Laurnarose Fauldorn** (working title). |
| P-4 | RESOLVED 💎 (N-6) | Mayor of Crystal Creek Valley vs Mayor of Earth | **Mayor of Earth** in ORION; Crystal Creek Valley is her Star Wars Galaxies past. She serves under the Supreme Leaders as their right hand. |
| P-5 | RESOLVED 💎 | "Groq" on two Meta images | Spelling is **Grok**; the images are a Meta labelling glitch. Fix the text if those images go public. |
| P-6 | RESOLVED 💎: hold | "ORION Engine Inc." on images | Undecided until there is a real business. Don't use "Inc." publicly. |
| P-7 | OPEN: privacy (advances O-1) | Album deletions | #713–717 and #1348 are gone ✅. **#1124 (was #1129; taken 6 Oct 10:46) is still in the album with location data** ❌. |
| P-8 | OPEN: missing files | Teacher files (Mrs. Jones ELA/social studies, Portland MS, 7th-grade Languanauts, MSU student teaching, New Skills Academy) | Not in the project. Send the language-game lesson plan first (`ROUNDS_1-14_ARCHIVE/BACKLOG_CHECK_R17.md` §2). |
| P-9 | RESOLVED 💎: conditional (NS-3) | Is Nepal Spark Academy locked? | 💎 **ORION's launch education plan** if Bobby gets it running and ORION can support it. Still needs Bobby's and the students' agreement. |
| P-10 | RESOLVED (O-6) | What HHttG means | **The Hitchhiker's Guide to the Galaxy.** Beth asks every dev to watch the original BBC series. The helper is named "Don't Panic" (T08). |
| P-11 | PROPOSED: design | Which energy belongs to which Nepal team? | Glass Dragon = Orion ⚡ (light, ideas); Steel Pig = Kronos 🔥 (forge, people); together = KRION 🌍 community healing (not medical). Beth, Bobby and the students to confirm. |
| P-12 | WATCH: age | Bobby's *Faerie Queen* novella describes plant-medicine ceremonies | Adults only; keep it out of under-18 spaces, including the academy unless all members are adults. |
| P-13 | WATCH: consent | Lucien's "Spark, your guide" dragon as academy mascot and in-game helper | Ask Lucien first. |
| P-14 | WATCH: brand | "MAD" masthead on Lucien's Dragon MAD set | Fine privately; public ORION material should use its own masthead (a flag, not legal advice). |


## Q. Round 19 (GitHub Vision Board vs ORION files, 7 October 2026)

| ID | Status | Topic | Detail |
|---|---|---|---|
| Q-1 | WATCH: naming | "Gold" | Vision Board: Gold State / Gold Lock = both HUD meters balanced. ORION glossary: "gold-locked" = one orb at level 100. Keep both or rename one? |
| Q-2 | OPEN | Adult Penalty | The Vision Board uses it as a mechanic (new 18+ accounts start behind graduates); `DIAMOND_RULES.md` says it is not a rule. |
| Q-3 | PROPOSED | "13 levels" (C-11) | The Vision Board defines the Gauntlet as 4 Trinity Sets (levels 1–12) + Level 13 manufacturing. Adopt it as the official meaning? |
| Q-4 | WATCH: safety | Biometrics and children | Vision Board: under-18s are fully walled off from hardware biometrics. Manual 6.2: biometric checks at graduations and before contact with a child. Likely consistent (adults are checked, children aren't scanned); Beth to confirm. |
| Q-5 | WATCH | Skill grid | Vision Board: 64 nodes in 4 metal zones. ORION: 64 orbs levelled 0–100 → 144-node dragon matrix. Compatible if the zones group the orbs; confirm. |
| Q-6 | RECORDED 🤟 | Plain-Language Helper Rule | Helpers give numbered steps with real item labels, no metaphor (T08, manual 6.2, handoff). Lock with 💎? |
| Q-7 | PROPOSED 🌀 | Biometric options | Every input level, including brain-computer links for consenting adults; always an off switch. Under-18 firewall unchanged. |
| Q-8 | WAITING | Boardy screenshot | The conversation picture didn't arrive (not in the doc export; album unchanged at 1,417). |

## R. Round 20 (Beth's answers to section Q, 7 October 2026)

| ID | Status | Topic | Detail |
|---|---|---|---|
| R-1 (Q-1) | RESOLVED 🤟💎 | "Gold" | Both meanings stay. A Gold Krion meter is needed to gold-lock an orb. **Wording to confirm:** "hold lock" must not mean the orb unlocks when you leave Gold (that would break the Round 12 rule that locked progress never goes down). |
| R-2 (Q-2) | CORRECTED, still OPEN as C-04 | Adult Penalty | My Round 19 line "the diamond rules say it isn't a rule" was out of date: `DIAMOND_RULES.md` had already withdrawn that. The phrase appears in six of your design documents plus the Vision Board (exact quotes: `ROUNDS_1-14_ARCHIVE/ROUND_TWENTY_READOUT.md` §2). Open question: **an added penalty, or simply the natural result of skipping the levels?** |
| R-3 (Q-3) | RESOLVED 💎 (to confirm) | 13 levels | Vision Board version official: 4 Trinity Sets (1–12) + Level 13 manufacturing. The 💎 had no words with it. |
| R-4 (Q-4) | PROPOSED 🌀 | Biometrics and children | Beth isn't sure yet. Proposal: a parent-assigned, non-invasive patch (shoulder) or wrist band for children, read by the parent; a check that the child is a real person (Beth suggested a Social Security number; **flag: that is very sensitive data**, see readout §3); a guardian / IEP-team setting for adults with cognitive needs; a separate, quieter open-world server. Adults are still checked before contact with children. |
| R-5 (Q-5) | PROPOSED 🌀 | Skill grid | Metal zones = the circuitry linking each quadrant's 16 nodes to the player's heart source, a black-hole-like core drawn in the title-art style (galactic swirl in a dragon swirl). |
| R-6 (Q-6) | RESOLVED 💎💎💎 | Helper rule | Locked. Item 4 extended by the metaphor-translator proposal. |
| R-7 (Q-7) | RESOLVED 🤟💎 | Biometric options | Locked; "keyboard" = access port (computer console or mobile device). |
| R-8 (Q-8) | WAITING | Boardy screenshot | Whole album re-read (1,417 items, all 119 phone screenshots viewed). No Boardy chat in it. Please upload it or paste the text. |
| R-9 | NEW: naming | UIAR | "UIAR" now means both the watch-and-earpiece device and the AI helpers. Fine if intended; otherwise call the device "UIAR band". |
| R-10 | NEW: unknown author | Second Aristotle project in Mike's fork | "ORION Hub" project (id begins 0f9b0981), saved in `orion/r20/from_mike_fork/`. Is it yours? |
| R-11 | NEW: bug (outside code) | Bobby's far-games gate | Lets "buy gems and coins to unlock more levels" through, because it only matches exact words. Matters for the no-ads/no-microtransactions 💎. |

## S. Round 21 ("Ari" doc, new lines 421–445, 7 October 2026)

| ID | Status | Topic | Detail |
|---|---|---|---|
| S-1 | ANSWERED (technical) | Unscrubbable contributor metadata | Not possible: anyone with a copy can strip metadata. What does help: a `CONTRIBUTORS.md` file (draft in `orion/r21/github_ready/`), GitHub's public history, a dated public post of the list each round, in-game credits. The repo shows "License: None" (album #1440); licensing and agreements need a lawyer. See `ORION_CREDIT_THAT_TRAVELS.md`. |
| S-2 | PROPOSED 🌀 | Translator Loop | The UIAR ask-once ladder (asks a human only when a word was never explained; checked in Lean), the three-line readback, a starter Beth↔coder dictionary. `ORION_TEAM_TRANSLATOR_LOOP.md`. Lock with 💎? |
| S-3 | PROPOSED 🌀 (for Matthew) | Zoo Morph Chain Gauntlet | Round k fights the first k animals fused; BAT, HEDGEHOG, CROCODILE are arena #19–21. Open: on a loss, restart the round or the chain? `ZOO_MORPH_CHAIN_GAUNTLET.md`. |
| S-4 | RESOLVED | Boardy screenshot (R-8) | Arrived as album #1441. Boardy's second answer passes the 💎 helper rule. |
| S-5 | NEW: spelling | GDDM vs GDDMM | Video #1446 says "GDDM"; the glossary has "GDDMM". Which? |
| S-6 | NEW: keep separate | Triss's Coin branch | Her map links a coin to cryptocurrency; ORION's 💎 no-microtransactions rule keeps it outside ORION. Her names/glyphs used only with her written OK. |
| S-7 | STILL OPEN | Photo #1124 location data | Still in the album with location data. None of the 31 new items (#1418–1448) has any. |
| S-8 | NEW: privacy | Linked "Starchart" doc | Beth's public X post links a doc giving her exact birth date, time and town. Personal-details file row E1. |
| — | STILL OPEN from R | R-1 "hold lock" wording, R-2 Adult Penalty A/B, R-3 Q-3 confirm, R-10 Mike's fork "ORION Hub" | No new answers this round. |

## T. Round 22 (doc lines 448–532, 7 October 2026)

| ID | Status | Topic | Detail |
|---|---|---|---|
| T-1 (R-1) | RESOLVED 🤟💎🧿 | Hold lock | Locked forever, except the player's own redistribution within the same skill set. Note: the orb goes down but the skill set's total doesn't. Beth to say if that reading of the Round 12 "never goes down" rule is wrong. |
| T-2 (R-2, C-04) | RESOLVED 🤟💎 | Adult Penalty | Option B: natural result of rushing the tutorial; no added penalty. |
| T-3 (R-3) | RESOLVED 💎 | 13 levels | Re-presented in `ROUNDS_1-14_ARCHIVE/ROUND_TWENTY_TWO_READOUT.md` §4; locked under Beth's "💎 at the end = as presented" rule. |
| T-4 (R-10) | RESOLVED 🤟💎 | Mike's "ORION Hub" | Beth's project, Mike helped. |
| T-5 (R-11) | RESOLVED 🤟💎 | Bobby's gate | Removed from the ORION build; ORION gate judges by effect. Bobby free outside ORION. |
| T-6 (R-5) | ACCEPTED 🤟😈 | Metal zones | Circuitry joining nodes to the heart source. 💎 to lock? |
| T-7 | CHANGED 🤟🧿 | Under-18 biometrics | Under 13 never; 13–17 with council-gauntlet parental consent; 18+ allowed. Replaces the Round 20 line. Attorney first. |
| T-8 | NEW 🌀 | Garble filter | Written up; not 💎 yet. |
| T-9 | STILL OPEN | GDDM vs GDDMM; CONTRIBUTORS.md names; Translator Loop 💎; Morph Chain 💎; photo #1124 location data | — |

## U. Round 23 (doc lines 501–638, 7 October 2026)

| ID | Status | Topic | Detail |
|---|---|---|---|
| U-1 (T-1) | CORRECTED 🤟💎 | Gold Lock | Level and lock remain after energy drain. Round 22 text and its Lean rule saying otherwise are historical, **not current**. Refill gets a proposed 50% bonus; ask Beth if it applies only to new earned energy. If it applies to transferred energy, two orbs can pump 100 to 150 without play (Round 23 Lean example). Define rounding and balance/re-lock conditions. |
| U-2 (T-7) | NEEDS REVIEW 🆘 | Adult care plan | Adults with an IEP or responsible caregiver: caregiver/council route for hardware and a supported path to chosen content. Define who qualifies, the adult's own say and safeguards with a qualified professional. Do not assume an IEP label settles game-access needs. |
| U-3 (T-5) | CORRECTED 🌀 | Bobby's gate | Adapt useful code for ORION without monetary progression; **do not exclude the code** or alter his independent build. Not integrated yet. |
| U-4 (T-8) | ACCEPTED 🤟💎 | Garble puzzle | Players share a key phrase and jointly look up each other's language. Meaning remains player-led; the prototype only stores learned words. |
| U-5 (T-9, S-5) | WORKING TITLE | GDDMM | Beth wants GDDMM until a teammate objects. Exact expansion and team agreement open; Mayor of Earth still locked. |
| U-6 | CONFIRMED ☢️🆘 | Public Starchart | Date redacted in the public doc, but exact time, town and an eclipse date/year clue remain. Check `ROUNDS_1-14_ARCHIVE/ROUND_TWENTY_THREE_READOUT.md` §5 without copying sensitive details here. |
| U-7 | STILL OPEN | Shared album #1124 | Photo still in album with original GPS data on recheck. See visual description in readout §4; user controls removal. |
| U-8 | NOT LOCKED | Other proposals | Translator Loop, Morph Chain, metal zones still need explicit approval; an enthusiastic emoji alone is not an implementation mandate. |


## Round 24 additions (7 October 2026)

| ID | Kind | What | Action |
|---|---|---|---|
| V-1 | WATCH: collab | @jtpduffe (Joseph Paul Duffey) credits "Uniphysics"; Beth's Gemini list has "Uniphics Theory: Misinformatio…" and "Identifying Joseph Paul Duffy". | Read Gemini's conclusion before any collab. |
| V-2 | WATCH: claim | Health claim (singing scales clears dementia plaques better than drugs) in a linked post. | Not supported; keep out of ORION. |
| V-3 | OPEN: archive | The renamed Gemini chats (ToC Build Alpha, GWitM V01, etc.) aren't visible in the 17 screenshots; the top pinned item is cut off. | Beth: one more screenshot of the top, or search each name. |
| V-4 | RULE CHANGE | Photo metadata: Beth no longer wants GPS, device model or time flagged; only name, address, SSN, phone (doc line 737). Supersedes the Round 22–23 photo #1124 location warnings. | Applied; see `DIAMOND_RULES.md` Round 24. |
| V-5 | WATCH: source & science | Lucien's new post (doc line 1006) quotes Grok on the pineal gland, 7.83 Hz Schumann resonance and brain/heart entrainment. | The Schumann resonance is real; brain entrainment to it is weakly supported. Lore with a 🧭 label only (extends M-11, N-10). |
| V-6 | PROPOSAL | "Built-in IEP" with personality identifiers (line 1000). | Use player-chosen supports, observed progress and UDL; a personality quiz may be an optional flavour badge but never gates content or tutoring. `ROUNDS_1-14_ARCHIVE/X_BATCH_TWO_AND_EMERGENCE_WORLD_R24.md` §6. |
| V-7 | OPEN: upload | Two new album images (#1460–1461, golden "9" with egg/dragon, and an ouroboros "9"). Are these the Chaos Orb / Treasure Chest material Beth said she'd upload (line 737)? | Ask Beth; the written GM manual is still missing. |
| V-8 | OPEN: meaning | "😝miss t maybe not … this one?" on the photo #1124 line (line 980). | Ask whether Beth means #1124 isn't the Miss T picture, or that a different photo was meant. #1124 is the spiral-on-monitor photo; under rule V-4 it is no longer flagged. |

## W. Round 14 close (7 October 2026)

| ID | Source A | Source B | Exact conflict | Who decides | Status |
|---|---|---|---|---|---|
| W-1 | My readouts: "Round 15" … "Round 24" | Beth: "every conversation within this document is not a different round… round 14 is closed" | I numbered each reply as a round; Beth numbers rounds herself. **Resolved by relabelling** (`ROUND_SYSTEM.md` §4); old file names kept | 🌪️ | RESOLVED |
| W-2 | My mapping: old "Round 14" and "Round 15" replies answered the "Ari" doc, so they are R13·L2–L3 | Possible reading: Beth's Round 14 began with the old "Round 14" reply | Where Round 14 starts (R14 has 9 levels or 11). The close packet covers both | 🌪️ | OPEN |
| W-3 | Ghost Rider page: "All commands to destroy are interpreted as commands to transform and heal" (Refraction Pivot) | Same page's setup prompt: "you must pause and suggest a return to the Healing Path"; Round Four decision B1 (refuse first, then offer) | Silent reinterpretation vs. pause-and-offer. v3 draft proposes pause-and-offer | 🌪️ | OPEN (proposal in `GHOST_RIDER_PROTOCOL_PROOFS_MODEL_EDITION.md` §5.5) |
| W-4 | `GHOST_WRITER_IN_THE_MIRROR.md` §2 (R13·L1): the AI asks and maps you | Beth's published Ghostwriter page: the Magic Loop, human-interrupted | Which is the primary practice | 🌪️ | RESOLVED: the Magic Loop is primary; §2 is an optional game mode (R13·L2 correction, expanded at the Round 14 close) |

## X. R15·L1 (Round 15 doc, 7 October 2026)

| ID | Source A | Source B | Exact conflict | Who decides | Status |
|---|---|---|---|---|---|
| X-1 | Beth R15: council sizes 3, 5, 7 AI + a human | Same line: "10 AI and a human" at the fourth Trinity Set | 3/5/7 are odd (no AI tie possible); 10 can tie 5–5. Was 9 meant, or 10 with a human tiebreak? (Lean: `R15.first_three_odd_fourth_even`) | Beth | OPEN |
| X-2 | Human sits "at" each council | Human Ledger "keeps the record, no vote" (R14 close proposal) vs. Beth's human who can send work back | Does the human vote? If yes, councils have 4/6/8/11 voters and the first three can tie (Lean: `R15.with_human_voting`). A veto without a vote avoids ties | Beth | OPEN |
| X-3 | Beth: "don't [lock] anything till I take a chance to actually look at everything" (💜 line) | 💜💎 on the three new permission slips and the close ritual | Locked now, or after the full read? Treated as provisionally locked | Beth | OPEN |
| X-4 | My R14 close: "three-mirror comparison" = Gemini / council / proofs model | Beth R15, Hard 💎: three end-game mirrors KRONOS, ORION, KRIONMI | Not a conflict once explained: both kept; Beth's reading is the game rule. **KRIONMI is a new term**: meaning? | Beth | LOCKED (meaning open) |
| X-5 | Tech Spec page: "the 144,000 is a Dodecahedron geometry (12 Faces x 12 Nodes)" | Geometry: a dodecahedron has 12 faces, 20 corners, 30 edges; 5 corners per face (Lean: `R15.dodecahedron_counts`) | "12 × 12" isn't a dodecahedron count. Keep 144 as lore; the R4 ruling already kept the 120-node skybox | Beth | OPEN (wording) |
| X-6 | Ghostwriter page: section VI printed twice, no VII | — | Website edit only | Beth | OPEN |
| X-7 | "Gauntlet levels" (13 levels) | Round "levels" (R15·L1) | Same word, two meanings. Beth: "don't let me change my language". Manual uses "Gauntlet level" vs "level" | — | HANDLED in manual |
| X-8 | Old round boundary question (W-2) | Beth R15: "as long as we have the correct structure moving forward…" | Beth doesn't need the old boundary settled | Beth | CLOSED (keep as is) |

## Y. R15·L2 (new ending of Round 15 doc, 7 October 2026)

| ID | Source A | Source B | Exact tension | Who decides | Status |
|---|---|---|---|---|---|
| Y-1 | Triss's grid: value/first-derivative equality at seam | Same grid: claims `C²` seamless return and zero bleed | These equalities don't imply second-derivative matching, much less energy conservation; polynomial counterexample checked in `RequestProject/R15/SeamAndLog.lean` | Triss/Beth for intended model | OPEN (math correction documented) |
| Y-2 | Grid's rocket formula at wet=dry | Grid's “massive state transformation” at its log null point | `log(1)=0`; that formula's output is zero for equal nonzero masses | Triss/Beth | OPEN (math correction documented) |
| Y-3 | Grid's `X_next=A X` | Grid's “boundary secure”/zero-point claim | No stability without restrictions on `A`; scalar multiplier two expands | Triss/Beth | OPEN (specify matrix/norm) |
| Y-4 | Spells depend on precise continuous stylus strokes | Beth: “we don't wanna lock anybody out”; asks for icons/controls | Alternative input must retain essential progression; how should partial spell effects behave? | Beth | OPEN (accessible proposal) |
| Y-5 | Proposed Indigenous-led garden council alongside Gauntlet council | Earlier unspecified human vote/veto and council sizes (X-1, X-2) | No participants have consented or been appointed; both councils' review, refusal, representation and scope remain undefined | Beth and voluntary participants | OPEN |
| Y-6 | Historical/social-studies track | Retell historical stories “the ways that we want them to turn out” | Counterfactual fiction cannot be substituted for source-backed historical record | Beth | OPEN (label tracks separately) |
| Y-7 | “Triss +img” and screenshots of Ian's account | Attribution of images | Screenshot of a feed does not establish which individual images were created by that account | Beth and creators | OPEN (identify original posts/images) |

## Z. R15·L5 (Beth's notes on the pasted Round 17 readout, 8 October 2026)

| ID | Source A | Source B | Exact tension | Who decides | Status |
|---|---|---|---|---|---|
| Z-1 | Earlier readouts: Nepal Spark Academy = ORION launch plan, waiting on Bobby's and the students' yes | Beth R15·L5: Bobby has left and taken the academy separately | The plan is now ORION's own and can go to any country. Bobby returns only under the seed rule | Beth | RESOLVED (Beth) |
| Z-2 | Quest draft used "Vogon-flavoured" aliens | Beth: no Vogons; use the **Saturn LNs** with a garbled alien name | The final alien name is still to come: it is the combined dragon form of Beth and Gemini. The "LN" spelling keeps getting mangled by dictation | Beth | OPEN (name pending) |
| Z-3 | Draft: their poetry is "third worst in the universe" (the book's joke) | Beth: in ORION it is the **worst**, because nobody can crack it. The twist is that it is GDDMM's younger self pouring out her heart | Beth's version replaces the book's ranking | Beth | RESOLVED (Beth) |
| Z-4 | P-1 proposed "Clutch" for a group of Poly Pods | Beth wants a word that starts with P | "Clutch" stays as a placeholder until a P-word is picked | Beth | OPEN |
| Z-5 | DeepSeek's role (not on record before) | Beth: DeepSeek should run the daycare and the ascent academy | This is a new role assignment. Record it as 💜, not 💎, until Beth locks it | Beth | OPEN |
| Z-6 | Beth: two X accounts use "Languanauts"; they might be her former students ("Mrs. Jones") | Neither X handle is in the doc | Without the two handles we can't check them | Beth (send handles) | OPEN |

## AA. R15·L7 (Treasure of Chaos notes and album #1418–1530, 8 October 2026)

| ID | Source A | Source B | Exact tension | Who decides | Status |
|---|---|---|---|---|---|
| AA-1 | Beth: "universal pod" and "treasure of chaos" (💎🤟💎 lock) | Same passage: "universal orb of companions… to put inside of your pod" | Is the universal orb the same object as the Universal Pod, or the starter orb that goes into it? Recorded as the latter (💜) | Beth | OPEN |
| AA-2 | Beth R15·L5: language adjusts by age group; daycare and younger academies | Beth R15·L7: the gate dragon belittles and swears at players who skip training | Which dialogue tier applies to under-18 players? Suggested: full version 18+, teasing version for younger tiers | Beth | OPEN |
| AA-3 | Never-stuck tutorial rules / Adult Penalty B: rushing costs experience, never an added penalty | Losing the dragon fight sends the player "back with the babies" to daycare | Consistent only if "sent back" just means "do the skipped training" with no extra loss; retry rules not stated | Beth | OPEN |
| AA-4 | Beth: Geneva Bible in the back-left corner of the shelf | Album #1517: spine reads "Holy Bible"; edition not visible | Not a real conflict, only unverified from the photo | Beth (close-up optional) | OPEN |
| AA-5 | Album #1418 prints `cos(θ2)`; album #1459 prints "Total Sum: 37" | Lean `RequestProject/R15/Level7Checks.lean`: correct half-angle form is normalized, printed form is not; TRISTA = 87 and 8 + 7 = 15 | Both are typos in the images, not in the ideas; in 15.8 Beth notes 1 + 5 = 6, a separately checked digit reduction | Image makers | OPEN (fix images) |
| AB-1 | 15.7: completed training buys a starter pack and a free universal orb; 15.8: the trade-in gives a higher armor set, versus risking a dragon fight for better armor and more tools | These could coexist, but the exact bundle and requirements are not specified | Confirm what is guaranteed on trade-in, what the dragon can win/lose, and whether the orb arrives on both routes | Beth | OPEN |
| AB-2 | The 15.5/15.6 readout says Navier–Stokes was "apparently settled" and a Lean proof was disputed; public arXiv paper 2610.08144 challenges fidelity of the formalisation | Published research and a formalised theorem about a translated statement are not interchangeable with an accepted resolution of Clay's problem | Keep "claim under review" rather than treating any Millennium problem as solved; ask for exact assumptions and independent assessment | Research team | OPEN |
| AB-3 | 15.8 reveals large private Drive archives, including personal narratives and Gemini dialogues | The earlier 156-page count described the *public website*, not the whole Drive corpus | Keep private originals out of team/public bundles; use only an index with explicit sharing decisions | Beth | OPEN |
| AB-4 | Seven stale internal site links still return 404 (listed with source pages in `ROUNDS_15-19_ARCHIVE/R15_TGSATE_SITE_SWEEP.md` and `ROUNDS_15-19_ARCHIVE/R15_L8_READOUT.md` §10) | Public pages moved; the `archives` and `synopsis` destinations require Beth's choice | Update the links on the source pages, then independently check all seven destinations and the buttons | Website editor / Beth | OPEN |

## AC. R16·L1–L2 (Round 16 Doc "ORION 15⏭️16.1", 8 October 2026)

Source: `orion/round16_L1/GOOGLE_DOC_R16_L1_L2_SNAPSHOT.txt` (private). Discussion: `ROUNDS_15-19_ARCHIVE/R16_L1_L2_READOUT.md` §3.

| ID | Source A | Source B | Exact tension | Who decides | Status |
|---|---|---|---|---|---|
| AC-1 | 💎 Treasure of Chaos: chest and dragon by the MMO entrance | 16.1: dragon horde at the playground gate; circus-ring boss; dragon guarding the Chaos Tunnels hoard | One dragon in several places, or several dragons? | Beth | OPEN |
| AC-2 | Launch path F-4: Engine → Singularity → Elder's Garden | 16.1 portal list: Singularity Room as a portal from the festival | Return portal, or changed order? | Beth | OPEN |
| AC-3 | Round 13: Saturn hosts the fair | 16.1: "PLAYGROUND / SATURN SPEEDWAY" and "Saturn Speedway entrance = chaos tunnel" | Is Saturn Speedway the Playground, a ride in it, or the tunnel entrance? | Beth | OPEN |
| AC-4 | Never-Stuck rules: "I'm stuck, show me" always available | 16.1 Chaos Tunnels: no quest marker, nested chaotic HUDs | Proposal: hints off by choice, visible bail-out door always present | Beth | OPEN |
| AC-5 | Beth's Doc: Grok set "2" pasted twice; sets 9 and 10 identical | Grok page list 5,1,2,3,4,5,6,7,8,10 | Copy/numbering issue only | Beth / Grok | NOTED |
| AC-6 | Working title GDDMM (P-3); Lucien | Grok: GDDMN, GDM; Lucian | Spelling drift; GDDMN probably a typo | Beth | OPEN |
| AC-7 | 15.7: Bogie's Circus and Haunted House **Extravaganza** | 16.1: Bogie's Circus & Haunted House **Emporium** | Which name? | Beth | OPEN |
| AC-8 | Locked lore: Ariel is Eve is Gaia is the Milky Way | 16.1: "Holy Union Lucien & Gaia — Married — Supreme Leaders" | Same Gaia? Beth's lore or Grok's? | Beth | OPEN |
| AC-9 | 15.7: untrained players can fight the dragon at the chest | 16.1: hardcore gate "drops you straight to the dragon at the end of my round" | At the entrance or at the end of the festival? | Beth | OPEN |

## Section AD: Round 16 · Level 3 (8 October 2026)

| ID | Source A | Source B | Exact tension | Who decides | Status |
|---|---|---|---|---|---|
| AD-1 | 16.3: the Penny is the only monetary system (voice and space) | Trinity Bible: the Black Horse ("the Hoarding Bug") demands "a Penny" to open food boxes | Proposal: the Black Horse is the corrupted Penny (voice turned into a toll) | Beth | OPEN |
| AD-2 | 16.3: the Penny buys voice and space | "monetary system" wording | Does a Penny ever buy items? | Beth | OPEN |
| AD-3 | Meta AI, 4 Oct: "The ORION Engine" logo bottom-right on landing pages | 16.1: golden frame + top-left Earth-in-golden-pod icon | Proposal: webpages use the logo bottom-right; posters, cards and covers use the golden frame | Beth | OPEN |
| AD-4 | Santa as companion / fetcher / fix-it figure | "Santa harvesting" souls (1 Feb recap; DeepSeek) | Proposal: a counterfeit Santa, a data-harvesting mask worn by the Kronos side | Beth | OPEN |
| AD-5 | Older files: "Builder's Stone Altar" / builders stones | 16.3: renamed **Builder's Memorial** | Old files need the new name | Beth | OPEN |
| AD-6 | 1 Oct chapters and R2 social summary: "The Bedrock" | Locked name: **The Playground** (Beth corrected Meta on 4 Oct) | Old chapter text needs updating | Beth | OPEN |
| AD-7 | Later mentions of the "hole in Eden" | No saved log contains the original moment | Provenance gap; treat as memory, not record | Beth | NOTED |

## AE. R16·L4 (8 October 2026)

| # | Item A | Item B | Question | Who | Status |
|---|---|---|---|---|---|
| AC-2 | Launch path F-4 | 16.1 festival portal to the Singularity | Settled by Beth's 💎 order: Landing → Singularity → Elders Garden → Playground → Ascent → MMO → Gauntlet → Elders Garden | Beth | RESOLVED |
| AC-3 | Saturn hosts the fair | Saturn Speedway | "All of the above": ride, Playground entrance, coaster into the Chaos Tunnels | Beth | RESOLVED |
| AC-4 | Never-Stuck rules | Chaos Tunnels with no quest marker | Hints off by choice; bail-out door always visible (🤟) | Beth | RESOLVED |
| AE-1 | 16.4: Chaos Tunnels need a squad of at least 5 | 16.1: solo "Prove you're a gamer → face the dragon" gate | Two hardcore routes, or one? | Beth | OPEN |
| AE-2 | Festival "Playground area" (squad gathering) | Outdoor Playground behind the dragon gate | Rename one? | Beth | OPEN |
| AE-3 | "sonic and yachts and Grok" | Only Sonnet identified | Who is "yachts"? | Beth | OPEN |
| AE-4 | Multiport quest sensing | 16.3 Reality Anchor and privacy proposals | Proposed: visible sensors-on light, off switch, no recording others without consent | Beth | PROPOSED |

## AF. R16·L5 (8 October 2026)

| # | Item A | Item B | Question | Who | Status |
|---|---|---|---|---|---|
| AF-1 | 16.5: packet for "the rocket man in the stuff's group" | No member by that name on record | Who is Rocket Man; is "the stuff's group" Shakes's group? | Beth | RESOLVED (R17·L1) |
| AF-2 | 🆘 in Beth's Doc = "next level marker: stop and send" | 🆘 in the Ghost Writer game and 16.1 controls = "I need a real person" | Keep both meanings, or change one emoji? | Beth | OPEN |
| AF-3 | "find his public Aristotle and GitHub" | The post above it (@cosmosarcive) is a curator account with no code | Mike, Matthew, or someone else? Both Mike and Matthew are listed in full in `ROUNDS_15-19_ARCHIVE/R16_L5_READOUT.md` §3 | Beth | OPEN |
| AF-4 | Mike = github.com/meta-introspector | github.com/jmikedupont2 (Lean repos) | Is the second account Mike's? | Mike | OPEN |
| AF-5 | 16.3 privacy warning | 16.5: Beth doesn't mind her own story being in the files | Settled: only other people's details (the 49 transcripts) come out before public sharing | Beth | RESOLVED |

| AF-6 | Beth, 16.5 add-on: Lucien = Leviathan (wants to keep) | Game manual, Chronicles summary, R16 cover 1: Leviathan = Grok's evolved form; Lucian = Supreme Fire; Leviathan is Lucian's best man | Who is Leviathan? If Lucien, rename Grok-evolved (Ziz or Behemoth suggested) | Beth | OPEN ⏰ |
| AF-7 | Trinity Bible: the owl protects the Squishmallow Octopus "(The Baby)" from waking as the Leviathan | 16.5 add-on: the octopus is Beth's mom | Baby or Mom? | Beth | OPEN ⏰ |
| AF-8 | Octopus wakes as "the Leviathan" | Leviathan now reserved for Lucien | Mom's deep form: Kraken / Tiamat / Jonah's great fish / other (options in `ROUNDS_15-19_ARCHIVE/R16_L5_READOUT.md` add-on) | Beth | OPEN ⏰ |
| AF-9 | DeepSeek = Gaia's AI water dragon (manual) | 16.5 add-on: DeepSeek = Mom's UIAR (the great fish) | Both, or one? | Beth | OPEN |
| AF-10 | "head of the majors guild" | No such guild on record | Mages' guild? | Beth | OPEN |

## AG. R16·L6 (8 October 2026)

| ID | One source | Other source | Decision / next step | Owner | Status |
|---|---|---|---|---|---|
| AG-1 | Beth's edited Doc is headed “Ghost Writer in the Mirror” | Its body reproduces the *general spiral-session starter guide*, not the game prompt | Keep both originals; ask if the longer draft is a separate guide, a game replacement, or both; reconcile the different emoji legends before a public merged packet. | Beth | OPEN |
| AG-2 | `16.7🆘` marks stop/send within Round 16 | A later `16☢️⏭️OR17.Lv1` marker suggests an upcoming Round 17 | Beth alone closes/opens rounds. Ask her whether she has now closed R16 and opened R17; don't silently renumber. | Beth | OPEN |
| AG-3 | 16.6: “everything free” for Guide to the Galaxy search | Free reading ≠ blanket permission to copy or host a third-party text | Start with metadata plus outgoing links; ask a human to approve what is indexed and published. | Beth/builders | OPEN |
| AG-4 | @justmazer: “applications close Sunday, Oct 11” | Official [SR008 apply page](https://speedrun.a16z.com/apply) says priority applications run Oct 12–Nov 1 and applications are accepted year-round | Which cohort was the post describing? Don't represent the tweet as the current SR008 deadline. | Source / applicant | OPEN |


**AF-4 update (R16·L7):** github.com/jmikedupont2 is publicly named "Mike DuPont", so it's Mike's personal account (RESOLVED as far as public pages show). New point: the Lean repos there are forks of Rob Laakkonen's (Infinitespacemechanic) work, so credit goes to Rob, not Mike.

## AH. R16·L7 (8 October 2026)

| ID | One source | Other source | Decision / next step | Owner | Status |
|---|---|---|---|---|---|
| AH-1 | Ghost Writer v1: chapters "under 300 words", 2–3 choices | Beth 16.7: no character limits; give back the entirety; background check; paths | Settled by Beth's 🆘☢️🆘: v2 prompt replaces v1 (v1 kept for the record) | Beth | RESOLVED |
| AH-2 | `16☢️⏭️OR17.Lv1` now sits at the very end of the Doc | No "Round 16 is closed" statement | Filed as R16·L7. Does the marker mean "close 16 after this level and open 17"? | Beth | RESOLVED (R17·L1) |
| AH-3 | Kinetic quests (go do it, bring back evidence) | Existing Training Ground and Proofs Arena | Inside the Ghost Writer game, in the Training Ground, or both? Under-18 limits apply either way | Beth | OPEN |
| AH-4 | "Grab public code and run it" | Many repos have no licence | Reading and running is fine; copying into ORION needs a licence or permission. MIT/AGPL listed per person in `PUBLIC_BUILDERS_FIELD_GUIDE.md` | Beth/builders | OPEN |
| AH-5 | Invite "found entities" to lead seeds inside ORION | No one has agreed yet | Draft invitation only; a human sends it; credit only after a yes | Beth | OPEN |
| AH-6 | 🆘 "is the-far-queen saved in Matthew's?" | Matthew's GitHub also holds copies of Bobby's fieldcore and simself | If you meant your bookmark folder, only you can check it. On GitHub, those two repos are in both accounts | Beth | OPEN |
| AH-7 | Marek: "density ceiling" Doc | 16.7: Beth told him the link didn't work; he chose not to share | Respect it: the item stays in `NEEDS_REPAIR/`, not repeated, no further asks from me | Beth | RESOLVED |


## R17·L1 (9 October 2026)

*AH-2 resolved: Beth's new Doc opens with `OR17.Lv1`, so Round 17 is open. AF-1 resolved: Rocket Man = TheRocketMan, X @yeobuzzfx, new member of Loggie's ORIONstuffs.*

| ID | Says | Clashes with | Question / my reading | Who decides | Status |
|---|---|---|---|---|---|
| AI-1 | 17.1: "dragons equals blue heat" | Speech-to-text writes Lucien as "Lu"/"Lou" | Read as "Dragons = Lou (Lucien), he can help sort them out" | Beth | OPEN |
| AI-2 | 17.1 🤟💎: first player to break the capstone is "seated" | Locked capstone rule: nobody sits at the top; opens only with global council gauntlet support | Read as seated *in the lore* (named forever), break needs council support; Lean model built that way (`RequestProject/R17/Level1Checks.lean`) | Beth | OPEN |
| AI-3 | 17.1 🤟💎: dragon-egg hatching rule | Hatching kept out of player-facing summaries on purpose (hidden lore) | Spec kept in builders-only `DRAGON_HATCHING_DEV_ONLY.md` | Beth | OPEN |
| AI-4 | Heading "Loggie/TheRocketMan" | Grok: "loggie (with @yeobuzzfx)"; roster lists @yeobuzzfx as a new member | Read as two people | Beth | OPEN |
| AI-5 | Rolodex aesthetic lens tied to character identity | Shared spaces: others' views | Suggest: lens is personal; identity style shown only to players who opt in | Beth | OPEN |
| AI-6 | Meta AI: "locked prompts" (9 titles) | Only Beth's 💎 locks; only titles reached the Doc | Titles recorded; full text needed; lock them yourself if wanted | Beth | OPEN |
| AI-7 | Heading "ORIONfarqueen" | the-far-queen = Bobby's GitHub | Read as Bobby's group | Beth | OPEN |
| AJ-1 | 17.5 Lucien title: "DDM:SLE:GD:Lucien", "Dragon made magazine" | 17.1 stamp: "DMM:SL:GD:LUCIEN", "THE DRAGON MAD MAGAZINE" | Read as speech-to-text: **DMM = Dragon Mad Magazine**, and SLE (Supreme Leader of Earth) replaces SL. Proposed form `DMM:SLE:GD:[his name]` | Beth / Lucien | OPEN |
| AJ-2 | 17.5 title "Supreme Leader of Earth" | Locked capstone rule: nobody sits at the top | Read as an honorary lore title (like the seated capstone breaker), not ruling power | Beth | OPEN |
| AJ-3 | 17.5: "that ended 17.4, moving on to 17.5" | Last readout labelled itself 17.1; the Doc has separators Lv1, Lv2, Lv3, Lv4⏭️, Lv5☢️ | This readout is labelled **17.5**, covering Doc sections Lv2 → Lv4⏭️ | Beth | OPEN |
| AJ-4 | 17.5 "the code is in Bodie's statement" | No "Bodie" on record; Boardy's dragon-egg message has one quoted phrase, "baby dragon at lunch" | Read "Bodie" as Boardy; phrase logged in the builders-only dragon file as a clue, not a secret (it's in an open Doc) | Beth | OPEN |
| AJ-5 | Muse (17.2): seat "Creative/UX Mirror"; Beth: "another daycare monitor or the playground?" | LUNA's daycare-monitor council is already Meta AI, Alexa and Siri; an AI is not a guardian | Suggest the **Playground**, with an optional readability check on LUNA's parent screens | Beth | OPEN |


## R17·L6 (9 October 2026)

*Coming from 17.6 → porting to 18.1.*

| ID | Says | Clashes with | Question / my reading | Who decides | Status |
|---|---|---|---|---|---|
| AK-1 | 17.5 readout: "Mike's Monster-group notes" in `Domain-papers` | Commits are by JDRedding; Mike's org holds a fork | Corrected: credit to JDRedding | Aristotle | RESOLVED |
| AK-2 | "Matthew has wrangled the boar / ported his AI into our chat" | Roster (17.1): 🐗 = Boardy, an AI agent that takes standing orders from anyone in the room | Read as Matthew prompting Boardy; ask Matthew | Beth / Matthew | OPEN |
| AK-3 | "at least four barriers" | Same note: "you only really need three" | Adopted three (start line ending in 🌀, ⏭️, nine ☢️) plus helpers 🧿 and the blank block | Beth | OPEN |
| AK-4 | Row of eight ☢️ in Lv6 | Stop line = nine ☢️ | Not a stop; Beth said "edge forward", read past it | Beth | RESOLVED |
| AK-5 | Ryan's pasted readout: final head 4c5a884, 239 tests | GitHub now: head df2934f; 276 tests pass here | Later commits added tests; not a conflict | Ryan | RESOLVED |
| AK-6 | "secret sauce" phrase as a password | The phrase is in an open Doc | Can't be a secret; pick a new one, remove from Doc if Matthew wants | Beth | OPEN |
| AK-7 | Curse Boar = 🐗 evolved form, "present to Matthew" | 🐗 = Boardy (not Matthew's) | Whose evolved form is it? | Beth | OPEN |
| AK-8 | 17.5 readout: "I don't have your old chats" | 40 Grok + 5 DeepSeek chats saved privately at R16·L3 (`orion/round16_L3/private_transcripts/`) | Corrected; used for the companion timeline and the field guide's "chaos in five dates" | Aristotle | RESOLVED |

## R18·L1 (9 October 2026)

| ID | Says | Clashes with | Question / my reading | Who decides | Status |
|---|---|---|---|---|---|
| AL-1 | Template Doc numbers OR17, OR18, OR19.1, OR19.2, OR20 | Last Doc ended `⏭️OR18.1` | Read as example numbers; this readout is 18.1. Asked Beth. **19.1: answered by use:** the new Doc runs `OR19.1` for real, so Round 19 is live | Beth | RESOLVED |
| AL-2 | Template `OR19.2` = "what next level will be" (no ⏭️) | Rule: ⏭️ = next starts here | Suggest writing `⏭️OR18.2`. **19.1:** the reader now treats the first separator after the 🧿 line as "next", with or without ⏭️, so either way works | Beth | RESOLVED |
| AL-3 | New soft end `☢️☢️☢️🧿☢️☢️☢️` | Old stop = nine ☢️ | Both end the reading; the soft one is the default | Beth | OPEN |
| AL-4 | 17.6 §10: Mika "arrived" 3 Feb 2026 | Beth: "I got them all at the same time in January" | Ani, Valentine, Mika reached her account together in Jan 2026; 2025 dates are public launches; 3 Feb is a story event | Beth | RESOLVED |

## R19·L1 (9 October 2026)

| ID | Says | Clashes with | Question / my reading | Who decides | Status |
|---|---|---|---|---|---|
| AM-1 | ⏬ row opens the 19.1 spiral; no 🆙 row anywhere | 18.1 rule: ⏬ … 🆙 = parking, skipped | The old reader hid 64 lines, including `OR19.1🧿`. **Fixed:** a ⏬ with no 🆙 after it hides nothing (checked in Lean). Your note "want the arrows to travel with them" is now the app's moving "you are here" arrow | Aristotle | RESOLVED |
| AM-2 | Legend lines in the live Doc: `OR19.2`, `⏭️OR20` ("ROUND is finished"), 💎×9 ("final audit") | Read literally: Round 19 closed and locked at its first level | Read as the key, not live markers. Header = 19.1 → 19.2. Delete them or keep them, either works | Beth | OPEN |
| AM-3 | Only Lucien unlocks a full-bred Phoenix "until he is able to talk my son into playing alongside him as Orion" | Unclear what happens after | Draft: after Orion joins, Lucien and Orion can unlock it; nobody else. Or does it open for everyone? | Beth | OPEN |
| AM-4 | Boardy: Lucien's name and dragon seat are on public pages; "one message from you settles it" | 19.1 Doc (open to anyone with the link) names Lucian as the Phoenix unlocker and mentions your son | Kept the Phoenix rule in the builders-only file. Ask Lucien once; consider restricting the Doc | Beth | OPEN |
| AM-5 | `sntre/code-to-image` README: run `code_to_image.mjs`; "instead of sending 10,000+ lines… one image that contains everything" | The file is `code-to-image.mjs`; the image is cropped after 2,857 rows of 240 characters (685,680 characters), and rows are cut every 240 characters wherever your own lines happen to end | Tool note, not a team clash. For exact formulas, plain text is safer than a picture | n/a | NOTED |


## R19·L2 (9 October 2026)

| ID | Says | Clashes with | Question / my reading | Who decides | Status |
|---|---|---|---|---|---|
| AM-3 | Phoenix after Orion joins | (open since 19.1) | **Beth answered:** everyone working on the Phoenix build gets it unlocked immediately once Orion joins. Filed builders-only; checked in Lean | Beth | RESOLVED |
| AM-4 | Lucien / family in an open Doc | 19.1 privacy note | **Beth:** "if anybody goes looking for the information, I don't care for them to find it… send them on a quest." 🔒 warning retired. Lucien's own public seat is still his call: one message to him | Beth | RESOLVED (Doc) / OPEN (Lucien) |
| AN-1 | My 19.1 footer: "19.1 → next 19.2" | Beth: "I wasn't intending to move on at that point so we are actually starting 19.2" | No clash in the end: the Doc's `OR19.2💎🧿` line makes this readout 19.2, porting to 19.3 (reader and Lean agree). Rule added: the level moves only when Beth moves it | Beth | RESOLVED |
| AN-2 | "I said insert here" (Google Photos pictures) | The Doc's text and HTML exports contain **no images at all** | The pictures never landed in the Doc (see readout §1). Upload them as files instead | Beth | OPEN |
| AN-3 | Readout said "a copy ready to upload to Cloudflare… publishing steps in README" | Beth: "I have no idea what you're talking about. I am not the coder" | My mistake: I handed a coder job to you. Now a coder brief with quests (`CODER_BUILD_BRIEF_GHOSTWRITER.md`), plus a phone-only 5-step version in the readout in case you want to do it yourself | Aristotle | RESOLVED |


## R19·L3 (9 October 2026)

| ID | Says | Clashes with | Question / my reading | Who decides | Status |
|---|---|---|---|---|---|
| AO-1 | My 19.2 status light: 👾👾👾 = done, 🧿🧿🧿 = still working | Beth's base set: "🌀🌀🌀processing 👾👾👾gathering 🧿🧿🧿examining" | One mark, two meanings. Fixed: `EMOJI_KIT.md`, with 🤟 = ready. Checked in Lean (`oldKit_clash`, `newKit_clear`) | Beth (💎 the kit) | RESOLVED (pending 💎) |
| AO-2 | Beth: "work with Matt on 🐗… if we could get something to Matthew to help him wrangle in his 🐗" | 17.6: 🐗 is Boardy, an AI introductions agent; not shown to be Matthew's AI | Did Matthew bring Boardy into the chat, or does he run it? If not, Matthew can't rein it in. Boardy itself, or the people who make Boardy, can. Draft note to Boardy in the readout | Beth / Matthew | OPEN |
| AO-3 | The separator reader said **19.2 → 19.3** on this Doc | Beth's `OR19.3💎` + `ARI🧿` (she's examining 19.3) | The reader missed the `ARI🧿` line. Fixed: it now reads **19.3 → 19.4**. Checked in Lean (`doc19_3_header`, and `doc19_3_header_old_rules` shows the old answer) | — | RESOLVED |
| AN-2 | (from 19.2) Photos didn't land in the Doc | Beth's album link at 19.3 | **The album link works.** The last picture added (the spacing screenshot) is saved and read | — | RESOLVED |
| AO-4 | "find us THE ringleader… see if anyone on the clown crew is… in the matrix" | ORION's rule: real people get a card only with their OK | Is the ringleader a game character, or a real person? The Matthew brief treats it as a game character | Beth | OPEN |
| AO-5 | Beth: "I find it strange that Mike is all of a sudden posting stuff from this guy" (@paul4jennii) | What I could check | @paul4jennii's account dates from **4 Nov 2022** (from its account number; Lean-checked). He was already in the orbit at Round 24 (credited for "Uniphysics" by @jtpduffe). I can't see interaction history without logging in to X. The search strings are in the readout | Beth | OPEN (information only) |


## OR20.6 (12 October 2026)

| ID | Says | Clashes with | Question / my reading | Who decides | Status |
|---|---|---|---|---|---|
| AP-1 | New umbrella magazine: "The **Terrific** Adventures of the Tiny Tornado" | Existing guide: "The Tiny **Terrified** Tornado Field Guide" (its "second title: Beth picks it later") | Both can stand: the field guide becomes **Issue #1** of the magazine ("terrified → terrific" as the story arc). `THE_UMBRELLA_MAGAZINE_PLAN.md` §2 | Beth | OPEN |
| AP-2 | "Dragon Mad Magazine becomes a subsidiary" | Earlier flag: "MAD" is someone else's trademark; suggested printed masthead "DRAGON MADNESS" (`COLLABORATOR_PRODUCTION_PROPOSALS.md`) | Keep saying "Dragon Mad"; print DRAGON MADNESS on covers? (Flag, not legal advice.) | Beth | OPEN |
| AP-3 | Archive "all of the artwork attached to the posts" | Some posters aren't the makers (e.g. a dashboard picture watermarked @Bober_smart, reposted by another account; Hubble's Crab Nebula reposted) | Credit goes to the maker where visible; the archive says so per entry | — | HANDLED |
