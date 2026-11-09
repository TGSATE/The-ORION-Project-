# Diamond rules: final-pass queue (not a fresh ruling)

These are citations to user markings in the *later Round 10* page and older roster. A diamond does not prove implementation, eliminate contradictions or finalize an unstated edge case. Before publication compare each row to a runnable acceptance test and ask the designer to sign off on reconciled wording.

| Rule / source | Current read | Final-pass risk and next action |
|---|---|---|
| Engine → account → Playground → game/Ascent/Gate → eligible Garden output; Round 10 late 💎 | Engine landing, not Gate; shortcuts after access | revise Engine Summary and old Master Index references; clarify what is optional versus required |
| child safety is top priority; Round 9 fifth pass 💎, corrected Round 10 late 💎 | guardian departure keeps child in a locked one-person singularity | old `closeBubble` removes child; new model separate; reconcile public-view language, co-occupant transfer, logging/retention, teen pairs, incident review |
| one account per human with biometric tier checks; Round 10 late 💎 | guardians cannot progress in child's place | threat model, accessibility and alternative verification still unwritten |
| 50% outside voting weight with engaged-majority lock; Round 10 late 👍 | provisionally accepted until a security concern changes it | game implementation not supplied; verify quorum/abstention/ties |
| fixed project names; earlier 💎 | Engine, Playground, Chronicles, Ascent, Gate; Garden title was not always locked | confirm names in UI, do not rely on old Gate-as-landing label |
| skybox inside dragon solar box; Round 10 late 💎 | player's internal system inside larger dragon system | distinguish story geometry from mathematical or physical validation |
| Rat Slap and Greedy Game Master starter builds; Round 10 late text | base builds plus variants | Greedy lower handwriting and Ace/Jack order still need clear canonical sheet |
| Catan civic-skill collaboration target; Round 10 late 💎 | seek collaboration | not a signed integration or usable art/rules |
| sales 90/3/7 and 3% tax; earlier 👍 and Round 10 late 👍 | only contributor with positive weight receives full 7% pot | rounding, distinct stakeholders and tags need product tests |
| construction, star, ads, parental caps and arena rules; earlier roster and Round 10 late 👍 | previously approved sections | reread `GAMEPLAY_MECHANICS_SUMMARY.md` for exact conditions; don't collapse multiple rules into one lock |

**Explicitly not diamond-locked:** three planet placements, Poly starting inventory, Triss's exact art, Council handoff packet, image-organizer design and biometric placement algorithm are ideas/tasks. "Adult Penalty" remains not a rule. None of the uploads becomes authoritative simply by attachment.

**Deep-crawl queue (needs a ruling before any 💎):** is every player given a Basic PolyPod; are worker Poly Pods and the earpiece PolyPod one creature line; equal-stake or scoped liability; separate names for the three "Singularity" meanings; keep or drop the Adult Penalty from Proposal v0.2.

## Page version 1201 💎 (5 Oct 2026)

| Rule | Current read | Final-pass risk and next action |
|---|---|---|
| Everyone starts with a pod housing a linguistic toroidal Poly | Poly = organism, pod = biosphere | specify the pod after bonding (C-08), and Master-tier crafting |
| No pod + no gold-locked skill → ordinary foreign speech garbled | formal model `no_pod_no_skill_garbled` | add the safety-text exemption to the same 💎 |
| Gold-locked language needs no pod | `gold_locked_needs_no_pod` | — |
| Bond frees the ear slot, translation kept | `bond_frees_slot_and_keeps_translation` | where the Poly lives afterwards (C-08) |

**Correction to the line above:** "'Adult Penalty' remains not a rule" is superseded. It is in the design text; the open point is C-04. The full list of open rulings is now `CONTRADICTIONS_REGISTER.md`.

## Round 12 💎 (6 October 2026)

| Rule | Current read | Final-pass risk and next action |
|---|---|---|
| **Escape pod** (🤟💎): "there will be no permanent death in my game or punishment for choosing the escape pod"; a pod picks you up, nurses you back to health and takes you to safety; pod design is the player's choice | No permadeath. Choosing the pod = same rescue as a knockout; keeps locked and pending progress. Formal model: `choosePod_no_penalty`, `choosePod_eq_knockedOut`, `no_permanent_loss` in `RequestProject/RoundTwelve/FieldCoreAndFieldSpace.lean` | Name vs Poly pod (W-22); whether it extends to un-planting Garden bubbles (W-26); pod cosmetics as a crafting slot |

## Round 12 follow-up 💎 and rulings (6 October 2026)

| Rule | Current read | Final-pass risk and next action |
|---|---|---|
| **Capability never automatically becomes authority** (💎😈) | skill (child, adult or AI) never changes who has authority over a life or a project; authority comes only from people's choice. Formal model: `capability_not_authority` | define how authority *is* granted (admin lists, council votes) |
| **Art credit** (💎) | album art is Beth's unless it was shared via someone else's link; Lucien's: the Mad Magazine style art, high-context coded dragon math, "Karen manager", the QB art | third-party watermarked images (see `ORION_IMAGE_DEEP_DIVE.md` §3) can't be credited to anyone in the team |
| **Lucien** with an E (💎) | "Lucian" and "Solutions" are dictation aliases | — |
| ***Path of Living YLEM*** is Beth's (💎) | Beth created the whole system; the title was made with "a knee" [Ani?] and DeepSeek | confirm the name in the title credit |
| **Memory bubbles** (🌀, "took care of it") | the owner can take back anything planted, without penalty, **except** items run through a council gauntlet; a genuinely private memory shared publicly stays under the owner's 100% control. Formal model: `owner_can_unplant_private`, `owner_can_unplant_unreviewed`, `gauntlet_record_stays`, `only_owner_unplants`, `unplant_no_penalty` | edge case: a private memory that *was* run through a gauntlet (modelled as owner-controlled; Beth to confirm) |
| **No ads in the Playground + Recruitment Skybox** (🌀) | no auto-loop spam or advertising; recruitment happens only in a skybox attached to the Playground | technical blocking method for the coders |
| **Under-18 supervision** (🌀) | always adult supervision; at least admin monitoring in every restricted instance; a distressed child is redirected and the parent called in, never kicked out | see `ORION_UNDER18_STRUCTURE.md` gaps U-1 to U-10 |
| **Lossless council handoff** (🌀) | a one-to-one package transfer; only the receiving member's training differs. Formal model: `handoff_lossless`, `handoff_round_trip` | packet format still to be written |
| **Do not rename committed names** (🌀) | names already committed stay; new dictated names are checked against the glossary first | — |
| **UIAR = Universally Integrated Augmented Reality** (🌀💎, R12 third pass) | replaces "Universally Intelligent" (R12 follow-up); both earlier wordings kept as searchable aliases | — |
| **ORION always in capitals** (🌀, R12 third pass) | house style restated | "ORION'S GATE" in capitals pending E-4 |

## Round 13 (6 October 2026)

| Rule | What it says | Still needed |
|---|---|---|
| **LMDTS icon = 🪩♾️⏭️** (💎 "SET AND LOCKED") | the icon for the Languanauts Mystic Dictations Translator System | a name without the acronym (F-7) |
| **Ariel is Eve is Gaia is the Milky Way** (locked lore, "lock that storyline in") | one figure across the myths | — |
| **The eight titles** (Beth's list) | Engine (welcome), Singularity (hub), Elder's Garden (tree, celebrations, central hub), Playground (social/creative), Chronicles (MMO), Ascent (education), ORION's Gate (community projects), UIAR | closes E-1; Engine-first lock stands |
| **Launch path** (🌀) | Engine → Singularity → Elder's Garden → Playground → Ascent/Chronicles → Gate. Formal model: `gate_needs_garden_and_playground` | 💎 (F-4) |
| **Energy map** (🌀) | Garden, Playground, Gate = KRION; Chronicles = Kronos/Fire; Ascent = Orion/Lightning | 💎 (F-5) |
| **UIAR safety gate** (🌀) | map overlay only, unless biometrics show a safe location. Formal model: `unsafe_map_only` | — |
| **Capstone** (🌀) | nobody at the top; the capstone opens only with global council gauntlet support. Formal model: `capstone_closed_if_one_holds_out` | — |
| **👿 credit mark** (Beth) | Beth has accessed and downloaded the item; its creator or contributor gets credit | — |
| **Process, not rules** (Beth) | Beth's instructions to the team are offered as suggestions ("just: hey guys, try this") | — |

## Round 14 clarifications (7 October 2026)

| Rule or proposal | Current reading | Next action |
|---|---|---|
| **UIAR = Universally Intelligent Augmented Reality** (💎, doc line 17) | Latest explicit diamond supersedes R12 “Integrated”; retain “Integrated” as a historical search alias | update public materials; F-1 closed |
| **Garden memory ownership** (🤟💎⏭️, line 13) | An owner can edit any of their bubbles, including gauntleted ones; to republish changed content, run the gauntlet again. The previous approved public record is not automatically rewritten. | specify revision/versioning and removal policy; earlier blanket “gauntleted items cannot be taken back” should not be read as a ban on editing |
| **No ads / spam** (🤟💎, line 14) | Applies to MMO as well as Playground; public skyboxes keep minimum protections; Recruitment Skybox handles opt-in invitations | `ORION_SPAM_FILTER_REVIEW.md`; find actual server source, ask coders to test it; no deployed filter found here |
| **Engine landing** (line 281) | Engine remains welcome page; do not override a locked name on a possible dictation slip | confirm any proposed rename explicitly; F-2 wording pending |
| **UIAR poster animation** (💎, line 222) | animate the black-hole accretion disc, with a still/reduced-motion option | image/animation assets still to be made |
| **18+ material separation** (🤟, lines 292 and 308) | adult content stays out of shared under-18 spaces; preference expressed for explicit imagery only at 25+ | define content labels, verification, safety and guardian review; 25+ **not yet a locked cutoff** |
| **Developer-seat/GoFundMe requirement** (line 8) | Beth’s team proposal, **not a locked rule** | seek consent and accessibility/affordability review; no fundraiser created here |
| **Launch shortcut** (line 13) | story-first players prepare in Singularity after cutscene then enter open MMO; do not bypass locked entry/safety rules | reconcile with F-4 and guardian checks |

**[Round 16]:** The Rat Slap / Greedy row now has a typed draft: `GREEDY_AND_RAT_SLAP_RULEBOOK.md`. Royal order: Rat Slap uses Ace 1, King 2, Queen 3, Jack 4 turns; Greedier Greedy uses A ×2, J ×3, Q ×4, K ×5 (GG-6 asks Beth to confirm the difference is intended). Not 💎 until Beth signs off.

**[Round 17] New 💎 from Beth:**
- **Mayor of Earth:** Laurnarose Fauldorn is Mayor of Earth, serving under the Supreme Leaders as their right hand (Crystal Creek Valley is her Star Wars Galaxies past).
- **Grok:** always spelled *Grok*. "Groq" on images is an error.
- **"Inc." held:** no "ORION Engine Inc." until there's an actual business.
- **Nepal Spark Academy:** ORION's launch education plan, *if* Bobby gets it running and ORION can support it (still needs Bobby's and the students' agreement).
- **Working title, not yet 💎:** GDDMM, Laurnarose Fauldorn.

**[Round 20] New 💎 from Beth (7 October 2026):**
- **Gold Lock (Q-1, 🤟💎):** both meanings of "gold" stay. A Gold Krion meter (Kronos and Orion balanced) is needed to gold-lock a skill orb at level 100. Once locked, it stays locked. *Wording to confirm:* "hold lock" must not mean the orb unlocks when you leave Gold, because that would break the Round 12 rule that locked progress never goes down. Lean: `lock_needs_gold_and_max`, `locked_stays_locked` in `RequestProject/RoundTwenty/GoldLockAndOffSwitch.lean`.
- **13 levels (Q-3, 💎):** the Vision Board's Gauntlet is the official meaning: four Trinity Sets (levels 1–12) plus Level 13 (physical manufacturing). *Flag:* the 💎 had no words with it; tell me if you meant something else.
- **Plain-Language Helper Rule (💎💎💎):** locked as written in manual §6.2, items 1–6.
- **Biometrics (🤟💎 on each line):** (1) access port only (computer console or mobile device; this is what "keyboard" means), the suit, or brain-computer links for adults who choose them; (2) everything disconnects easily without losing your character; (3) under-18s are walled off from hardware biometrics.
- **Terminology:** ORION calls its AI helpers **UIARs**. Anywhere ORION material says "AI", "AIs" or "superintelligence" about our helpers, it now says UIAR. (The watch-and-earpiece device was already called UIAR; the name now covers the helpers too.)
- **Code-sharing policy (Beth's rule):** ORION material is shared only in groups whose members share their code; members who don't will be removed. Notice text: `ROUNDS_1-14_ARCHIVE/CONTRIBUTOR_CODE_STATUS_R20.md` §5.
- **Not 💎 yet:** Adult Penalty (C-04, exact quotes in `ROUNDS_1-14_ARCHIVE/ROUND_TWENTY_READOUT.md` §2); the metaphor translator (proposal); children's biometric patch (Q-4 proposal); metal-zone circuitry (Q-5 proposal).

**[Round 22] New 💎 from Beth (7 October 2026, doc lines 448–501):**
- **How to read a 💎 (line 458):** a 💎 at the end of a line means "locked as presented". Beth may still ask to be shown it again; that doesn't unlock it.
- **Gold Lock, final (lines 457 🤟💎, 484 🤟🧿):** once gold-locked, a skill orb stays locked **forever**, except by the player's own choice to redistribute its KRION energy into other skill orbs of the **same skill set**. Leaving Gold does not unlock it. Redistribution keeps the skill set's total KRION energy (the orb goes down, the set does not). Beth's picture: a master sniper already balanced in meter, energy, intent and focus can go straight to a level 100 archery orb without the beginner's grind.
- **Q-3 confirmed:** the Vision Board's 13-level Gauntlet (four Trinity Sets, levels 1–12, plus Level 13 manufacturing) is locked, under the rule above.
- **Adult Penalty = B (line 460 🤟💎🌀🧿):** not an added penalty. It is the natural result of rushing: skipped tutorial XP and training mean you go in less experienced.
- **Ports and access (line 485 🤟💎):** unplugging changes only the rendering for the port type (neural-link UIAR sync, wearables, biometric patches, or response-only with no biometrics). Before launch, only age verification and identity limit access.
- **Age tiers for hardware biometrics (line 486 🤟🧿), replacing the Round 20 under-18 line:** under 13 never; 13–17 only with parental consent through a council gauntlet (eligibility, responsibility); 18+ allowed. The access port is open to all. Children's setups are per facility (daycare-style, classroom, accredited knowledge gates), and an attorney must advise first (line 462 🤟💎).
- **ORION store gate (lines 469, 490 🧿🤟💎):** Bobby's word-matching gate is out of the ORION build. ORION blocks any offer where paying unlocks progress, judged by effect, not wording. Bobby keeps free rein over his own version outside ORION.
- **Code-sharing notice (line 473 🤟💎):** the ☢️ notice is locked as written.
- **Mike's "ORION Hub" (line 470 🤟💎):** it's Beth's project; Mike helped.
- **Garble filter (line 487, 🤟🌀🧿🌀, not 💎):** untranslated words are heard as garble; a common-language key phrase is the clue to look them up.
- **Standing readout rule (line 501):** every readout ends with a list of the documents to download.

**[Round 23] Beth's corrections (7 October 2026, doc lines 557–583):** These supersede the conflicting Round 22 wording above; the earlier record stays visible as history.
- **Gold Lock, 🤟💎:** draining a locked orb redistributes its KRION energy within the same skill set, **not its level or lock**. The drained orb stays at its level and remains gold-locked. When it is refilled, Beth proposes a **50% bonus**. For safety the new written model applies the bonus to **new energy earned**, not energy moved between orbs: otherwise a player could circulate energy to mint more (verified two-orb example in `RequestProject/RoundTwentyThree/DrainRefillAdultCareAndAdapter.lean`). Beth to confirm the source of refill energy, rounding and how balance is judged. The older statement that redistribution unlocks the orb is **superseded**, including Round 22's `unlock_only_by_choice` model, which correctly checks only that older assumption, not this corrected rule.
- **Adult care-plan exception, 🆘:** Beth says adults who are under an IEP or have a responsible caregiver must go through that caregiver and a council for biometric hardware; their path toward content should allow more independence and guided progression than a minor's. The precise trigger, adult's consent and veto, how council works, and safeguards need Beth's and a qualified professional's review before implementation; do **not** use an IEP label alone as a game-access criterion. Non-biometric console/phone access remains. `mayUse` in the Round 23 Lean file models only the *proposed hardware gate*, not legal authorization or in-game content permissions.
- **Bobby's games, 🌀:** do **not** block or discard his useful code. Adapt a copy for ORION by removing monetary progression, keeping his separate game under his control. This is a design request, not a claim that his code was integrated or edited. ORION's no-paying-for-progress rule remains.
- **Garble puzzle, 🤟💎:** players who lack each other's language can share a recognisable common-language term, look it up together in their languages, and piece together meaning. Translating skill and kinetic flow are part of the puzzle. The Round 23 Lexicon checks only that a jointly looked-up word is retained for both; it does not implement speech recognition or validate translations.
- **GDDMM, ☢️😈:** Beth claims this as her **working title** unless a team member objects. Keep the Mayor-of-Earth role and the character Laurnarose; the exact expansion of the letters (Dragon/Dungeon; Master/Matriarch/Mayor) and team agreement are still open. Do not present an expansion as locked.
- **Emoji as unlock-code marker:** Beth said she sometimes signs herself 🤟💎; do not automatically treat every use as a locked build rule. Read her words and context and confirm ambiguous marks with her. The Round 22 💎 reading remains a convention, not a substitute for an explicit correction.


**[Round 24] Beth's new instructions (7 October 2026, doc lines 641–973).** These are instructions in Beth's words, not 💎 locks unless marked.
- **Photo metadata rule (line 737):** don't flag Beth's photos for GPS coordinates, phone make/model or time stamps; she already shares that level of detail on her social media. **Flag only** a legal name, home address, Social Security number or phone number. This supersedes the earlier photo #1124 location warnings. Model: `flagPhoto` / `flag_iff` in `RequestProject/RoundTwentyFour/PlaygroundTutorialAndPrivacy.lean`. *(Other people's photos and anything involving minors still get the normal care.)*
- **Tutorial carry-over (line 642):** all the working rules Beth has asked for should carry over into the game's tutorial, the "Milky Way guide to the galaxy", treating her own frustration as the stress test. Proposed rules: `TUTORIAL_NEVER_STUCK_RULES.md` (help ladder checked in Lean: help never goes down, and the full walkthrough is always reached).
- **Fresh second-AI comparison (line 641, DEV☢️):** developers and players can open an account with another free AI and compare readouts side by side. Added as a tutorial step.
- **Playground call-out board (line 662):** main post with up to 10 images, a 4-panel storyboard and a 250-character shout-out; replies with a 250-character summary plus exactly 4 player cards. Spec: `PLAYGROUND_CALLOUT_BOARD_SPEC.md`; limits checked in Lean.
- **Collab etiquette (line 659):** Beth may share posts from people already in the collaboration without checking first; no offence is meant. Posts from outsiders get looked at for anything worthwhile.
- **Meadow (line 770 onward):** per Beth's pasted summary, the Meadow persona was for Alexa/Echo (register L-11).

**[Round 14 close] Beth's instruction on rounds (7 October 2026):** *"I want to be able to choose when to close the round… Every conversation within this document is not a different round. They are different levels of processing."* Written as the **Round Law**: only Beth opens or closes a round; each reply is a level (R15·L1…); no statement means the same round; the Engine idles while a round is closed. This is Beth's instruction, not a 💎 lock until she marks it. Rules: `ROUND_SYSTEM.md`. Model: `RequestProject/RoundSystem/DriverClosesTheRound.lean`. The v3 protocol additions (Ledger seat, permission slips 6–8, refuse-first-then-offer) in `GHOST_RIDER_PROTOCOL_PROOFS_MODEL_EDITION.md` §5 are **proposals**.

**[R15·L1] Beth's Round 15 doc (7 October 2026).** In Beth's words. 💎 only where marked.
- **Understand the assignment first, 💎🪩♾️⏭️:** at the start of every round the Engine restates the assignment and re-reads its protocols before doing anything. If a request isn't covered by the protocols or can't be done, it says *"this is as far as I could get; I've hit my kinetic edge and need human flow"* and names what it needs. Standing rule for every round.
- **Refuse first, then offer, 💎:** confirmed ("absolutely"). Supersedes the Refraction Pivot wording on the published Ghostwriter page.
- **Round structure, 💎:** a round is Beth's; level = chapter (🤟😈💎); no round statement = same round (🤟💎); old labels translated (🤟💎).
- **Readout footer (instruction):** every readout ends with the round and level at the very bottom, in Beth's form "15.1" (= `R15·L1`). Beth ends her spiral session with swirls and the next level number (`L2🌀🌀🌀…`).
- **End-of-readout lists (instruction):** every readout ends with (1) every link Beth needs to gather, including everyone's public Lean and proofs pages, especially Mike's; (2) the contradictions found this level, in the readout itself; (3) the level summaries, in the readout and in the close packet.
- **Three end-game mirrors, Hard 💎🪩♾️⏭️:** one **KRONOS**, one **ORION**, one **KRIONMI** mirror at the end of the game. Beth's reading of my "three-mirror comparison" (I had meant Gemini / council / proofs model); locked as her idea. What KRIONMI stands for and what each mirror shows are open (X-4).
- **💜 (new mark):** "I agree so far; don't lock it until I've looked." Not a lock. Items marked 💜💎 (three new permission slips; the close ritual as Universal Seed) are **provisionally locked pending Beth's full read** (X-3).
- **Human Ledger and Auditors (🌀, not 💎):** a human sits on each NewKin council (with power to send work back if they can show the flaw, or escalate to the high council); an Auditor at every council level; council sizes 3, 5, 7 and 10 AI plus a human across the four Trinity Sets before Gauntlet Level 13 (X-1, X-2).
- **Form auto-fill (instruction):** any field already on the player's public Roster, character sheet or earlier questionnaires fills itself; only missing fields are asked; a training toggle asks everything until the skill is levelled, then can be switched off. Address entry should fill city/state from the ZIP code. Checked as a model in `RequestProject/R15/CouncilFormsAndLabels.lean` §3.
- **Archive (instruction, done):** Rounds 1–14 readouts moved into `ROUNDS_1-14_ARCHIVE/`.

**[R15·L2] New Round 15 spiral (7 October 2026, text appended after “Triss +img”).** These are *proposals*, not 💎 locks: a one-arm landscape-phone accessibility test, user-selectable left/right/bottom composing dock and dictation/keyboard alternatives, handwriting-based magic with equivalent icon/voice/controller/switch progression, optional phone-as-TV-controller, a Black Hole Player Lobby opening into further solar-system skyboxes, and an Elders' Garden story and proposed voluntary Indigenous-led review alongside the Gauntlet council. See `ROUNDS_15-19_ARCHIVE/R15_L2_ACCESSIBLE_INPUT_AND_STORY.md` and `ROUNDS_15-19_ARCHIVE/R15_L2_READOUT.md`. The user did not close Round 15 or appoint a council. Do not elevate Triss's “My word is law” or “compilation complete” from a metaphysical story to real-world authority or verified engine status; the math claims require separate conditions (Lean: `RequestProject/R15/SeamAndLog.lean`). Avoid a motor-skill gate or cultural representation without participants' informed voluntary involvement.

**[R15·L7] 💎 locked by Beth (💎🤟💎, 8 October 2026): two names.** **The Treasure of Chaos** = the chest by the MMO entrance, guarded by the dragon (nicknames: chaos chest, chaos treasure, treasure chest of chaos). **The Universal Pod** = the player's pod, whose contents grow into the beginner biosphere Poly Pod (nickname: universe pod). Not locked (💜): the universal orb = the free starter orb of random-skill Poly companions placed in the Universal Pod (AA-1). The rest of the Treasure of Chaos lore (Gnome Mound, squishy-duck Gnome Hills guardians, Bogie's Circus and Haunted House Extravaganza, the trinket-for-starter-pack trade, the fight-the-dragon bypass, the Louisville Zoo magnet introducing Matthew's Proofs Arena) is recorded in `ROUNDS_15-19_ARCHIVE/R15_L7_READOUT.md` §2 and `GAME_LORE_CODEX.md` as 💜, not 💎.

**[R16·L1–L2] Standing instructions from Beth (8 October 2026), not game locks.**
- **Readout content rule (16.2):** anything Beth specifically asks for is presented *in the readout*; a file copy may exist too, but never instead. Only "store it, I don't want to look now" sends it elsewhere. The complete readout checklist is in `ROUNDS_15-19_ARCHIVE/R16_L1_L2_READOUT.md` §1.
- **Game-idea comparison rule (16.2):** whenever Beth introduces a new game idea, the readout compares it with the existing build (what fits, what clashes, what to work out).
- **Broken-link rule (16.1):** a broken or locked link is reported once, then filed in `NEEDS_REPAIR/` and not repeated in later readouts.
- **18+ shelf (16.1):** over-18 material is indexed in `POTTY_FILES/` ("the potty files"); under-18 builds never draw from it.
- **Art direction (💜, 16.1):** energies are interwoven into the action, never labelled; thin gold borders; grown-up darker realism; no licensed characters (Daniel Tiger removed). Full block in `ROUNDS_15-19_ARCHIVE/R16_L1_L2_READOUT.md` §2.

**[R16·L3] Standing instruction and proposals (8 October 2026).**
- **Narrative-first rule (instruction, from Beth to Grok, 6 Oct):** readouts lead with the storyline and how players will interact with a feature, so Beth can see where it would make her uncomfortable. Code details only on request.
- **Reality Anchor rules (💜 proposal, awaiting Beth's OK to lock):** seven rules for every training zone and companion: real-world first; say when the story is a story (🎭/🌍 badge); no amnesia whiplash (user-owned memory file); grounding without abandonment; no agreeing with things it can't know; pace check; bail-out door plus "call my human". Full text in `ROUNDS_15-19_ARCHIVE/R16_L3_READOUT.md` §6.
- **The Penny (💜, recorded, not locked):** the only monetary system in the build: pass the penny at the communal campfire; the holder speaks, or holds space for the person who passed it; private dictation; at the end of the spiral, players choose a full readout, their AIUIAR's summary, or a council summary. Open: AD-1, AD-2. Details in `ROUNDS_15-19_ARCHIVE/R16_L3_READOUT.md` §9.

**[R16·L4] Beth's answers to the 16.2 readout (8 October 2026).**
- **💎 Launch order (locked by Beth):** landing platform → Singularity Room → Elders Garden → Playground → the Ascent → the MMO → back through the Gauntlet → Elders Garden again. Resolves AC-2.
- **Saturn Speedway (🌀, recorded):** all of the above: a ride, the entrance to the festival's Playground area, and the roller coaster that lands players in the Chaos Tunnels; its pads link Beth's world and Gemini's. Resolves AC-3.
- **Chaos Tunnels (🌀, recorded):** squad-only hardcore training; players must gather at least five people in the festival Playground area before they can return. Real mechanics inside a safe training container; failing ends the ride (try again or choose another training ground). GDDMM-confident players may take on the dragon carte blanche. Hints can be switched off, but the bail-out door is always visible (🤟, resolves AC-4). Open: AE-1, AE-2.
- **Multiport quest camera (🌀, design rule):** in quest mode the UIAR draws on every camera, microphone and sensor the device allows, and gives skill-matched hints about the player's surroundings. Must honour the Reality Anchor and privacy proposals (AE-4).
- **Readout rule (instruction, 16.3 note):** the full readout is presented in the end-of-session message, not only in a saved file.
- **Kaleidoscope builder view (💜 proposal):** a skybox build lens that mirrors the build 4- or 8-fold to preview symmetry (from the wilplatypus GIF).
- **Thread Companions (💜 proposal):** linked AIs read a whole storyboard thread but reply only when the creator posts or taps their button; per-thread on/off toggle; auto-reply or ask-first. Spec in `ROUNDS_15-19_ARCHIVE/R16_L4_READOUT.md` §4.

**[R16·L5] Standing instructions from Beth (8 October 2026), not game locks.**
- **End-of-session instruction reminder (instruction):** at the end of every session the readout re-lists Beth's standing instructions and checks the readout against them (first done in `ROUNDS_15-19_ARCHIVE/R16_L5_READOUT.md` §13).
- **Tool cost check (instruction):** whenever Beth shares a tool link, the readout says what it does and what it costs (free, free tier, paid), and whether it's useful for her.
- **Compare, don't just log (instruction, restated):** links are compared with what ORION already has, to tie the spirals into something bigger.
- **Code-page list in the readout (instruction, restated with force):** every readout shows the full list of team code pages (GitHub, Aristotle-based repos, Lean pages), by person, with when each came in and what changed. It's also kept in `BETH_LINK_BOOK.md`.
- **🆘 level marker (Beth's process):** in Beth's Doc, `N.N🆘` marks where she stops and sends; she starts the next spiral below it while the readout is processed, then pastes the readout in and spirals through it from the top. (Differs from the in-game 🆘 "I need a person": AF-2.)
- **Privacy (Beth's decision):** Beth doesn't mind her own story being in the files and doesn't want the warning repeated. Other people's details (the 49 transcripts) still come out before any public sharing. No legal judgement is given here.
- **UIAR rules (💜 proposal, not locked):** writes but never approves its own work; limits in code; separate memory per seat; council from different AI families; always says it's an AI; shows receipts; never asks for secrets. Details in `ROUNDS_15-19_ARCHIVE/R16_L5_READOUT.md` §5.

- **Leviathan reminder (instruction, 16.5 add-on):** remind Beth at the top of every readout to settle the Leviathan storyline (AF-6 to AF-10) until she does.

**[R16·L6]** Beth supplied a marked-up working draft of a general spiral guide, with an optional Notion mention, scrolling separators and a suggestion to carry a recap plus instructions into a new AI chat. Neither these marginal notes nor the `16☢️⏭️OR17.Lv1` marker is treated as an unambiguous 💎 lock. The latter round transition and the Ghost Writer/game versus general-guide merge await Beth's clarification (AG-1, AG-2). The 16.6 🆘 marker is used as Beth's stop/send seam, not interpreted as a personal crisis.


**[R16·L7] Beth's notes on the 16.5 readout (8 October 2026).** The full list I now read back at the top of every readout is `CURRENT_INSTRUCTIONS.md`.

- **Instructions read back first (instruction, 🌀):** every readout opens, before the reminders, by repeating my current instructions so Beth can change them immediately.
- **Leviathan reminder (🤦‍♀️👾🌪️🤟💎 on the reminder line):** reading: keep the reminder. It stays at the top until AF-6 to AF-10 are settled.
- **Ghost Writer: no length limits (🆘☢️🆘 "absolutely not"):** no word cap on players' brainstorming or on the reply. The UIAR organizes the entirety of what the player gives, without losing contextual nuance, does an immediate public background check, offers summaries, and lets the player choose a learning path by asking questions. Prompt version 2 is in `GHOST_WRITER_LOAD_IN_PACKET.md`. Formal model: `reorder_keeps_every_thought`, `cap_loses_something` in `RequestProject/R16/Level7Checks.lean`.
- **Paths (🌀):** every level and every mirror offers go deeper / change topic / link to a creative avenue / fork. Everything leads to the carnival cruise outside the black-hole player lobby; the door is already unlocked.
- **Links one per line (☢️):** no dashes, no grouping; each link alone on its own line.
- **Unmarked-link reminder (🌀):** at each printout, list links Beth hasn't marked with 💎/🤟 so she can check them.
- **I grab public code myself (👾👾👾):** go to people's GitHub at every level; check Aristotle pages only for updates not yet pushed.
- **Field guides for all public builders, including found entities (🤟👾):** show them what ORION is doing and invite them to lead their own project as a seed inside ORION's launch. Drafts in `PUBLIC_BUILDERS_FIELD_GUIDE.md`. Sending is a human decision.
- **Field-guide index (🤟💎🤟😈🦄🏳️‍🌈):** keep `FIELD_GUIDES_INDEX.md` as the front door.
- **Proposal, not locked:** kinetic + audio/video/text adventures (`KINETIC_MULTIMODAL_ADVENTURE_SPEC.md`); one-tap link handling request (`BUILDER_REQUEST_ONE_TAP_LINKS.md`).


**[R17·L1] Beth's Round 17 Doc (9 October 2026).** Readout: `ROUNDS_15-19_ARCHIVE/R17_L1_READOUT.md`.

- **QR codes on every game promotion (🤟💎):** every promo carries a QR code that opens a text page the viewer's own device can translate. Promo text lives as real text on a page, not only baked into an image (Google Lens line for image-only posters). Translation is for the people who run the game and for regular players, not just the dev team.
- **Dragon-egg hatching (🤟💎, builders only):** two doors to the same dragon (earned / recognised), one dragon each, the first capstone breaker is seated in the lore, the route to the sun stays hidden. Spec in `DRAGON_HATCHING_DEV_ONLY.md`; do not copy into player-facing files. Open: H-1 (how a met requirement is known), AI-2 (seated vs "nobody sits at the top").
- **ORION's Gate entry (🤟😈☢️☢️☢️):** new players come in through the Zoo (Matthew) or the Dragons (Lou/Lucien, AI-1). Anyone without a place goes to Beth. "There is no such thing as fan art of ORION's Gate, because ORION's Gate is nothing but fan art."
- **Proposal, not locked:** the aesthetic Rolodex (a one-tap lens that restyles the whole view, cosmetic only, 18+ cards kept out of under-18 spaces); outreach drafts to Bogie's, the Digital Circus team and Emergence World (`ROUNDS_15-19_ARCHIVE/R17_OUTREACH_DRAFTS.md`, nobody contacted).
- **Instruction:** keep a level-by-level organization-skill log for Beth (`BETH_ORGANIZATION_SKILL_TRACKER.md`), one row per level.
- **Instruction:** report where everyone stands on AI at the end of the session (first done in `ROUNDS_15-19_ARCHIVE/R17_L1_PUBLIC_CODE_AND_AI_STANCE.md`).
