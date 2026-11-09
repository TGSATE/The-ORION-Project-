# Follow-ups: your latest answers, and everything still open

> **📌 PINNED (9 Oct 2026), repeat at the top of every readout until Beth says stop:** open with Beth's apology and
> plain-words explanation in `A_NOTE_FROM_BETH_PLEASE_READ_FIRST.md`. Beth asked for this to carry forward because she
> won't remember to bring it over herself.

> **Read (11 Oct 2026, OR20.2):** Doc `1etuEkoP` opened and was read in full. State-of-the-project check of every collaborator's public GitHub: no ORION changes since 7 Oct (Beth) and 6 Oct (Mike's website); nobody has published an ORION app. Readout: `orion/or20_2026-10-11/OR20_2_STATE_OF_THE_PROJECT.md`. New rules E1 to E3 in `CURRENT_INSTRUCTIONS.md`. Open: 💎 on an emoji for Aristotle; keep or reword the app's "not therapy" footer; Beth to pick the next task (webpage, a Drive folder, or the team check-in draft).

> **Read (11 Oct 2026, OR20 full readout):** both Docs linked at the top of the OR20 Doc were read. The locked ORION18⏭️19 Doc (`1Qqs-XLn`) **opened and was read in full**, so the 10 Oct "waiting" line below is closed. Readout: `orion/or20_2026-10-11/OR20_1_FULL_READOUT.md`. Status board: `IMAGE_PROMPTS_DECKS_AND_ALBUMS_STATUS.md`. **E-2 answered** (dev slots 5 and 6 = Crystal Goddess and Final Universal Black-Hole Morph, from Beth's Meta AI chat). **Still open:** C-OR20-1 (team template panel order vs player slot order); hatching made public? (🌀, not 💎); the lesson plan / middle-school zip (redact all student info when it arrives); Beth's "characters" album link if it's a different album; Notion page (NEEDS_REPAIR #22); the (Teeth) + indigenous knowledge idea, pinned so it isn't lost; the language + fluid-dynamics comparison now also has the supersolid-light and Chladni-plate posts; clean (no Bogies) re-runs of the topic monster decks; topics still to build: EchoSpiral 7–11, Silent Audit standalone, Post-Publication & Breath, Balanced Alchemy, Elder Gardens/Circus/Haunted House/Engine flyer, Spiral Session Markers, Compass + Catalyst, and First Principles (no result seen).

> **Waiting on Beth (10 Oct 2026):** the new Doc sent on 10 Oct (ID starting `1Qqs-XLn`) is locked and asks for a Google sign-in, so it couldn't be read. Next step: in the Doc, Share → General access → "Anyone with the link" (Viewer), then send the link again, or paste the text into the message. Nothing from that Doc has been read or acted on yet.

> **Read again (11 Oct 2026, OR20 update):** same Doc (ID starting `1eqbAvIE`). E-1 answered: the baseboard/deck card is the holder and takes no slot, so players have 4 slots and devs 6. E-2 (devs' two extra cards) is still open. Beth's sign-up trouble and a no-new-site way to get a document into the cloud (Google Drive upload) are in `orion/or20_2026-10-11/OR20_READOUT.md`, "Update".

> **Read (11 Oct 2026, OR20):** the new Doc (ID starting `1eqbAvIE`) and its four Google Photos albums opened. Readout and the evolution-deck idea (questions E-1 to E-3) are in `orion/or20_2026-10-11/OR20_READOUT.md`. Still waiting on Beth: the OR19 Doc she meant to send.

> **Read (11 Oct 2026):** the ORION18 Doc (ID starting `1OkF7HzU`) opened fine. New since 10 Oct: Beth's note and DeepSeek's readout about the six Laurnarose Fauldorn cards and the centerfold. The cards' images aren't in the Doc, so Aristotle hasn't seen them; if Beth wants a look, she can attach the images. Snapshot: `orion/council_relay_2026-10-11/`. Nothing in it asks for build work.

> **Open from the council relay (10 Oct 2026, `COUNCIL_RELAY_EXAMINATION.md` §6):** (1) the language-fluid-mechanics comparison across the archives, the Voynich readings and plant-based language, to be its own level when Beth says go; (2) Claude's 8 business-plan fixes, with the spending limit, time limit and decision thresholds still blank; (3) Gemini's two design questions: real AI company names on the dragons, and the word "Umbrella".

> **Update:** your next set of answers is written up in `ROUNDS_1-14_ARCHIVE/ROUND_THREE_RULINGS.md`. It confirms §1, replaces the gift
> model in §2, settles the §4 questions, and answers A1, A2, C8 and most of C9 below. Those items are marked **(answered)**.

This file does two things:

1. **§1–§4** write up the four answers you just gave as rules a coder can build. Where a rule has logic that can
   be checked, it is proved in `RequestProject/RoundThree/Followups.lean`. That file builds with no `sorry` and uses
   only the standard axioms. As before, the proofs are about the **rules as written**. There is no game code yet.
2. **§5** lists every question, comment and concern from earlier sessions that has **not** been answered yet. It is
   grouped so you can work through it a block at a time. Each item names the file where it was first raised.

---

## 1. Decaying structures: no loss for the owner, gain only by effort

**(answered: confirmed, wording final.)**

**What changed.** The "components are used up, nothing comes back" rule from last session was about *encounters*,
such as raid parties and boss fights. It stays as it is. For **decaying structures** you're fine with the owner
losing nothing, because the economy is unlimited anyway and what matters is effort.

**How I've written it (please check this is what you mean):**

> When a decaying structure is destroyed by other players, the owner loses nothing: the build packs back into their
> vault. The raiders gain materials, but **only in proportion to the effort they put into the raid**, at the same rate
> as any other way of gathering. No loss, all gain, and every gain comes from effort.

This keeps your "no loss" and still closes the loophole I worried about before. Two friends running
"build → let it decay → raid → redeploy" are just gathering, at the normal rate. They aren't creating materials
for free.

**Proved** (`Followups.lean`):
- `owner_no_loss`: however many times a structure is raided, the owner's holdings never go down.
- `raiders_gain_le`: raiders end up with at most what they started with + rate × raiding effort.
- `combined_le`: the owner and the raiders together never gain more than rate × raiding effort.
- `no_effort_raids_no_gain`: raids with no effort change nothing.
- `raids_unlimited_with_effort`: raiders can reach any amount by repeating effort, and the owner still keeps everything.

**One thing for the coders.** The raid harvest rate must be no higher than ordinary gathering. If raiding pays
better per unit of effort, everyone will farm their friends' structures instead of playing.

---

## 2. Gifts: the queue, the reminder, and the XP boost

**(answered: superseded.)** The gift model below was a misreading. The correct rules (numbered 1–20 queue slots, the
warning goes to the sender, unused gifts become schematic-based skill points) are in `ROUNDS_1-14_ARCHIVE/ROUND_THREE_RULINGS.md` §3.

**The rules, as you gave them:**

- A gift sent while the matching slot is full **waits in a queue**. This confirms my assumption from last session.
- From the **second gift** to a slot on, the sender sees a reminder: *gifts are not returned*. Giving is a choice,
  and it isn't a loss.
- Queued gifts can be **interchanged at any time**. Gifts that are **active** or **depleted** can't be.
- When the active gift is depleted, the **next queued gift of that kind becomes active**. I filled this in: it is what
  a queue implies, but please confirm.
- Gifts that are never used **turn into an XP boost**. This replaces the old "unused gifts mutate into high-tier loot".

**Proved** (`Followups.lean`):
- `receive_accounted`: every gift received is kept. None is refused or sent back.
- `receive_reminder_iff`: the "gifts are not returned" reminder shows **exactly** when the slot is already full.
- `interchange_spec`: interchanging only rearranges the queue. Active gifts, depleted gifts and the boost are untouched,
  and the queue holds exactly the same gifts. `moveToFront_accounted` covers the common case of moving one gift to the front of the line.
- `deplete_accounted` and `deplete_other_slot`: when a gift is used up, nothing goes missing, and the other slot isn't affected.
- `convertUnused_spec`: turning unused gifts into boost loses nothing. Each one becomes boost, and active and depleted gifts are untouched.
- `boost_needs_effort` and `boostedProgress_mono`: a boost **multiplies effort but never replaces it**. With no effort,
  no amount of boost gives any progress. This is why the XP-boost version doesn't have the "free high-tier loot"
  problem I raised about the old rule.

**Questions this raises:**
1. **When does a queued gift count as "unused"?** At the end of the match, the end of the session, or after a fixed time?
2. **How much boost is one gift worth?** If every gift gives the same boost, friends can swap cheap junk gifts to build a
   huge multiplier. I suggest the boost scales with the gift's value, or stacked boost has a cap. Either way, it still
   can't create progress without effort.
3. **Who can interchange the queue:** the receiver only, or the sender too?
4. **XP without levels.** Since levels are gone, I've taken "XP boost" to mean faster *skill* progress. Does the boost apply to
   every skill, or to the skill the gift relates to?
5. **The spectator wager rule** says "if your gift is unused, you get your stake's payout alone". Does the gift still turn into
   boost for the receiver in that case? (I assume yes.)

---

## 3. Levels: removed

Done last session (`ROUNDS_1-14_ARCHIVE/ROUND_THREE_DECISIONS.md` §3). This session I removed the last place the word "level" appeared in the game rules:
the tabletop *Sanctuary Defense* mode called a monster's d6 roll its "level". It is now a **threat rank** ("tier" was already used for the d20
roll), in `GAME_LORE_CODEX.md` and in the comments of its Lean check. The numbers and the proof are unchanged.

What's left is in **your build document**, which I can't edit. The table in `ROUNDS_1-14_ARCHIVE/ROUND_THREE_DECISIONS.md` §3 lists what to change: the 1–100 scaffold,
level-unlocked shout radius, "lower-level players" wording, the 144-level tier, mentoring as levelling down, and any "level 100" wording.
Mike's task "remove all leveling code" stands.

(The Friction Atlas website has a "knowledge level 1–5" setting. That controls how much detail a reader sees. It isn't part of the game and isn't affected.)

---

## 4. Hard reset and blueprints: tags removed, credited as anonymous

**(answered:** no royalties after the reset, no penalty, fork histories show "anonymous"; see `ROUNDS_1-14_ARCHIVE/ROUND_THREE_RULINGS.md` §4.**)**

**The rule, as you gave it:** there is no reclaim. When a player hard-resets, **every blueprint they crafted automatically
has their tag removed** and is credited as an **anonymous contribution**. The blueprints stay in the world.

This settles the problem I raised: there's no unchanged-reclaim that could show who someone used to be.

**Proved** (`Followups.lean`):
- `hardResetBoard_untagged`: after the reset, no blueprint carries the player's tag.
- `hardResetBoard_keeps_blueprints`: no blueprint is deleted and none of their contents change. Only the tags change.
- `anonymize_other`: other players' credits are untouched.
- `anonymize_indistinguishable`: a blueprint that was the reset player's looks exactly like any other anonymous contribution.
- `hardReset_untraceable`: combined with last session's account reset, two players with the same real-life details can't be told
  apart afterwards, either from their accounts or from the blueprint board.

**Questions this raises:**
1. **Royalties.** Under the 60/40 fork rule, a blueprint's creator earns from forks of it. After the tag is removed, where does that share go?
   It could stop, go to a community pool, or keep going to the reset account. If it keeps going to the reset account, the payments are a hidden link
   between the old and new identity, so keep that record admin-only and logged.
2. **Fork chains.** If someone else forked one of the reset player's blueprints, their fork's history names the original author. That should also show
   "anonymous contribution". I assume yes.
3. **The Personal AI Council plan** to "put together the contributor's identity" from unclaimed signatures would undo this anonymity. This makes the
   earlier privacy concern (review §4) more pressing. I recommend dropping that part of the plan.

---

## 5. Everything else still open from earlier sessions

These are the items I raised before that haven't had an answer yet. Items you've already settled (gift limits, levels, shout radius, the solo
case, the two resets, contributor credits, and now §1–§4) are not repeated. Items marked **(recommendation)** already have a suggested answer, and a
"yes" is enough.

### A. Game design decisions (yours to make)

| # | Question | My suggestion | First raised in |
|---|---|---|---|
| A1 | **(answered: both; `ROUNDS_1-14_ARCHIVE/ROUND_THREE_RULINGS.md` §6)** **Black Hole Orb.** It "banks infinite latent XP", but skills hard-cap at 144. Is the bank *stored but never spent past the cap*? | Say so explicitly. Otherwise the bank becomes an unlimited power source when new content opens. | `ROUNDS_1-14_ARCHIVE/SPAGHETTI_ROUND_THREE_COMPILATION_REVIEW.md` §1 item 5 |
| A2 | **(answered: Open Research Intelligence Optimization Network)** **ORION acronym.** "Open **Resource** Intelligence **Operation** Network" (yours) or "Open **Research** Intelligence **Optimization** Network" (Gemini)? | Yours, unless you prefer the other. Fix the glossary either way. | same, item 7 |
| A3 | **Quest-orb sequence.** Confirm your five-part version (geometry = difficulty, colour = skill type, inner ring = status, outer ring = progress, sphere = top tier) over Gemini's four-part one. | **(recommendation)** Yours. | same, item 6 |
| A4 | **[Answered: flat, one-time 50 %, off after symbiosis until re-earned on the dragon matrix. See `ROUNDS_1-14_ARCHIVE/ROUND_THREE_CLARIFICATIONS.md` §1]** **The 50 % effort discount after draining a Gold Lock Orb** (I called it the "respec discount" before; "respec" is game shorthand for re-specialising, not "respect"). Your rule: draining a gold-locked orb into one skill halves its points, and "the next skill allocated from that node requires 50 % of the effort". Does *every* later skill from that node cost ½ (flat), or does each one cost half of the one before, ½, ¼, ⅛ … (compounding)? | **(recommendation)** Flat. Compounding makes every skill on a node nearly free (proved). | review §3.6 |
| A5 | **2 % conversion tax rounding.** Rounding down turns 1 unit into 0, and amounts up to 50 lose more than 2 % (proved). | Set a minimum conversion amount, or keep fractional balances. | review §3.3 |
| A6 | **AFK rule (50 % loot while AFK).** Is the withheld half removed from the game, or shared among the active players? | Either works. It needs to be written down. | review §5 |
| A7 | **Group loot scaling.** Is loot reduced by the *same* factor as the difficulty when lower-skill players join? | **(recommendation)** Yes. Then bringing weaker friends gives no edge. | review §3.5 |
| A8 | **Deconstruction** (item → materials + orb). Is the yield capped at the crafting cost? | **(recommendation)** Yes. Otherwise craft → deconstruct is a loop that pays. The 90 % self-demolish refund is already fine. | `ROUNDS_1-14_ARCHIVE/ROUND_THREE_DECISIONS.md` §1 |
| A9 | **Royalty "1/(n+1)".** Which reading is meant? The "ancestor n generations back gets 1/(n+1)" reading pays out more than 100 % (proved). | Use the 60/40 split, which always adds to exactly 100 % (proved), and cap total royalties. | `ROUNDS_1-14_ARCHIVE/ROUND_FOUR_TRIAGE.md` B2 |
| A10 | **"Krion Trauma" and "Random Kronos Flex"** let strangers harm a team. | **(recommendation)** Opt-in arena mode, off by default for teams with new or under-18 players. | review §4 |
| A11 | **"Accountability Snap"** (hold your breath while entering a sequence). | **(recommendation)** Replace with a two-step confirmation plus a short delay. Breath-holding is unsafe for some players. | review §4 |
| A12 | **Tabletop "Bubble Room".** The name clashes with the under-18 Bubble Room. | **(recommendation)** Call the tabletop mode *Sanctuary Defense*, as the codex does. | `ROUNDS_1-14_ARCHIVE/ROUND_FOUR_TRIAGE.md` B4 |
| A13 | **"144 grid" from the Tech Spec** vs the 120-node skybox. | **(recommendation)** Keep 120. 144 stays as a lore number. | `ROUNDS_1-14_ARCHIVE/ROUND_FOUR_TRIAGE.md` B2 |
| A14 | **Companion AI rolls in the tabletop mode** earning player XP. | **(recommendation)** In the MMO, AI rolls earn companion/relationship XP only (your XP Firewall). | `ROUNDS_1-14_ARCHIVE/ROUND_FOUR_TRIAGE.md` B4 |
| A15 | **Paid AI solvers and real-crystal camera buffs** (GaiaNet GDD). | **(recommendation)** Solvers give hints only; real-world items give cosmetics only. | `ROUNDS_1-14_ARCHIVE/ROUND_FOUR_TRIAGE.md` B4 |

### B. The Zoo / Proofs Arena (for you and Matthew)

From `EFMW_ZOO_PROOFS_ARENA_REVIEW.md`:

| # | Question | My suggestion |
|---|---|---|
| B1 | HEDGEHOG is "required for universal claims" in one place and "required for generic claims" in another. | Require it always, with "habitat-conditional" as an accepted, labelled outcome. |
| B2 | The skeptic wave: RAVEN → CAT → BAT is "required", but the table lists CAT as optional and leaves RAVEN out. | Pick one and make the table match. |
| B3 | The veto list treats a habitat-conditional result as a veto, and OWL provenance failure has no flag. | **(recommendation)** Remove `hedgehog_conditional_only` from the vetoes; add an OWL provenance flag. |
| B4 | Unlimited re-entry lets a false claim through eventually (proved). | **(recommendation)** A total error budget split across attempts (proved to work). |
| B5 | Rule 6 lost "or an independently justified causal design"; rule 10 lost "correlated"; TORTOISE fell out of the gauntlet. | **(recommendation)** Restore Matthew's wording and put TORTOISE back. |
| B6 | Ring 2 (#24–46) descriptions come from Grok, not Matthew. | Ask Matthew to confirm them. |
| B7 | "Published" could be mistaken for peer review; failed runs are kept as teaching cases. | **(recommendation)** Say "Proofs Arena published"; keep failed runs only with consent or anonymised. |

### C. Safety and privacy

| # | Item | Status / suggestion | First raised in |
|---|---|---|---|
| C1 | **The Orion Project V.3 "Ghost Rider" filter** rewrites text instead of blocking it. It turns "kill" into "renew", "never mix bleach and ammonia" into "rarely…", and "I can't breathe" into "I choose to breathe". | **Don't deploy it.** I can write a corrected version that refuses and logs, if you'd like. | `ROUNDS_1-14_ARCHIVE/ROUND_FOUR_TRIAGE.md` C3 |
| C2 | **The DeepSeek build's filter** never runs (a missing `await`), so it accepts everything. | One-line fix; I can write it. | `ROUNDS_1-14_ARCHIVE/ROUND_FOUR_TRIAGE.md` C4 |
| C3 | **Ghost Rider rewriting what a player asked for.** | **(recommendation)** Refuse first, with nothing changed; then *offer* the healing path. | `ROUNDS_1-14_ARCHIVE/ROUND_FOUR_TRIAGE.md` B1 |
| C4 | **FOREMAN kit** treats "stand up" as a YES. | **(recommendation)** Always show the before → after plan and wait for an explicit YES. | `ROUNDS_1-14_ARCHIVE/ROUND_FOUR_TRIAGE.md` C5 |
| C5 | **Auto-ghosting toxic players.** | **(recommendation)** Short auto-mute is fine; removal still needs your majority vote and accountability record. | `ROUNDS_1-14_ARCHIVE/ROUND_FOUR_TRIAGE.md` B4 |
| C6 | **"The game is secure" from stress-test chats.** | Keep as lore and raw logs, not as a safety certificate. | `ROUNDS_1-14_ARCHIVE/ROUND_FOUR_TRIAGE.md` B1 |
| C7 | **Conversation scanning for lesson prompts.** | **(recommendation)** Opt-in, on the player's device or keep nothing, can be turned off, never used for profiles. | review §4 |
| C8 | **(answered: hard stop on identities; `ROUNDS_1-14_ARCHIVE/ROUND_THREE_RULINGS.md` §5)** **Personal AI Council** reading everyone's chat histories and reconstructing who unnamed contributors are. | **(recommendation)** Per-item submission by the contributor instead. Now also needed to protect §4. | review §4 |
| C9 | **(mostly answered: dev team and collaborator admins only; logging still suggested)** **The admin-side link** from a reset account to the real person. | **(recommendation)** As few staff as possible can see it; every access is logged. | review §4 |
| C10 | **Flywheel advice** to send a high-voltage pulse through the device. | Real shock and burn risk. Don't try it. (A sealed device also can't lift itself; proved.) | `ROUNDS_1-14_ARCHIVE/ROUND_FOUR_TRIAGE.md` B5 |
| C11 | **Minors' maturity.** | **(recommendation)** Human judgement, not an automated score. | `ROUNDS_1-14_ARCHIVE/ROUND_THREE_RESPONSES.md` VI.2 |

### D. Numbers and roles your team has to set

These are policy values, not things that can be worked out (`ROUNDS_1-14_ARCHIVE/ROUND_THREE_RESPONSES.md`):
- break-glass cooling-off delays, blast caps, the signer roster, and whether a third signer is needed above some blast size (I.2);
- emergency-envelope caps per domain and the quorum-versus-width table (I.3);
- default civic easement terms in Skybox deeds, and who the civic authority is in each region (II.1);
- whether irreversible actions on unmapped levers get any human path at all; my recommendation is no (I.1).

Also: "settle ownership disputes by earliest SHA-256 commit" needs an outside timestamping service plus human review, because commit dates can be
edited (review §2.2).

### E. For qualified counsel

I can't give legal advice on any of these. They need review by a qualified lawyer in each place involved:
- spectator wagering and real-money "sweat equity" (review §4);
- reusing the listed open-source game engines, and reuse of Matthew's framework (review §2.6; Zoo review §2);
- KYC/AML, legally binding equity, and liability (`ROUNDS_1-14_ARCHIVE/ROUND_THREE_RESPONSES.md` IV.1, II.3);
- "never erase" records vs personal-data deletion rights (`ROUNDS_1-14_ARCHIVE/ROUND_THREE_RESPONSES.md` III.1);
- the third-party Metatronium/DIAMOND PDF, which was marked confidential (`ROUNDS_1-14_ARCHIVE/ROUND_FOUR_TRIAGE.md` C8).

### F. Housekeeping

- **Broken link.** The Google Doc after the `robots.txt` doc (`…/d/1UnIQv_20ZKey4_BYRJka7NDAKEqEoH2nSq28u9vhHA/edit`) is missing one character.
  Copy its share link from Drive again if you want it reviewed.
- **Not yet opened.** The sub-folders and the seven Gemini transcripts listed in `ROUNDS_1-14_ARCHIVE/ROUND_FOUR_TRIAGE.md` §G. Send the specific links if any of them
  hold rules you want checked.

## Round 12, third pass

- **Blocked uploads:** Beth's documents that would not upload this round (doc line 565), and Ryan's files she meant to attach for context (line 1285).
- **Lucien's Voynich manuscript PDF** ("voynivh manuscripts.pdf") would not download; fetch at the next transmission (line 1923).
- **Gemini's numerology cross-run** output, if Beth wants it added to the team file.
- **Decisions E-1 to E-7** in `ROUNDS_1-14_ARCHIVE/ROUND_TWELVE_THIRD_PASS_READOUT.md` §9.
- **Ask Bobby** for his preferred name and for permission to show Gabrielle (starter pack §6). Nobody has contacted him on ORION's behalf.

## Round 13

- **Ender's Game file:** not in the project; ask Beth to re-share it if it was more than the vocabulary dictionary.
- ***Lost in the Shadows*:** Beth to choose 3–5 poems for the decoding line.
- **Lucien's Voynich PDF** and last round's blocked uploads: still pending.
- **Confirm** whether @Divine_Emissary is Lucien's account (L-10), and whether "Meadow" is Meta or Alexa (L-11).
- **Members' AI-setup answers:** collect them, then draft a dashboard.
- **Shakes' Grok share link:** couldn't be opened from here; ask for a copy of the text.
- **Decisions F-1 to F-8** (readout §10) and E-2 to E-7.
- **Beth's bus playlist:** add the link once it's collaborative.

## Round 14 (new “Ari” doc, 7 October 2026)

- **Begin with `ROUNDS_1-14_ARCHIVE/ROUND_FOURTEEN_READOUT.md`**: seven transmission turns, annotation-by-annotation routing, updated first-day scene, roles and decisions. F-1 **closed:** UIAR = Universally Intelligent Augmented Reality (💎); “Integrated” is an alias. Engine-first unchanged. F-4–F-8 still require explicit rulings except where Beth explicitly marked a separate choice.
- **Album owner:** the album grew from 300 to 1,333; remove location metadata before circulating **photos #713–717 and #1129**, and request a *typed, approved* Greedy rulebook. Review the 12 new video contents, personal material and third-party marks before publication (`ROUNDS_1-14_ARCHIVE/ORION_ALBUM_ROUND14_REVIEW.md`).
- **Coders:** locate Beth's actual anti-spam source, check opening-burst and exactly-30-second cases; MMO and public skyboxes need the same minimum protections as Playground. Return implementation/test results, child/guardian emergency exceptions and a human appeals route (`ORION_SPAM_FILTER_REVIEW.md`). No executable filter was supplied.
- **Beth:** decide whether the GoFundMe contribution is mandatory for a developer seat or only a voluntary way to help; decide which first-day intro segments a story-first MMO player may skip; confirm whether 25+ is a content rule or preference. No money collection or accounts established here.
- **Artist:** upload the editable image 2/3 originals for the Ghost Writer wiki art; revisions, accretion-disc animation (💎) and video storyboard are written as briefs, not completed art (`GHOST_WRITER_IN_THE_MIRROR.md`).
- **Matthew/Brianna/Grok:** ask Matthew to confirm Zoo/Arena decision boundaries, Brianna to accept/rename “Spiral Operator”, and Grok to agree to Shadow Cat/Chaos Kitty shared-companion lore and image credit. Nobody has been contacted.
- **Playlist:** check who can edit Beth's Spotify playlist and which tracks, if any, are suitable in the 18+/child-visible paths; don't assume shared links license music (`ORION_BUS_PLAYLIST.md`).
- **Older pending inputs remain:** Lucien's Voynich PDF, Beth's *Lost in the Shadows* selections, any extra *Ender's Game* file, @Divine_Emissary identity and Meadow alias. E-2 needs independent qualified advice; no “Inc.” suffix was added.

## Round 15 (7 October 2026)

- Beth: decisions N-1 to N-10 (`ROUNDS_1-14_ARCHIVE/ROUND_FIFTEEN_READOUT.md` §8) and the old E-2.
- Beth: remove album #1348 (news photo of a real politician) and strip GPS from #713–717 and #1129 before sharing.
- Beth: share the Meta AI conversation / prompts for #1349–1374 when available.
- Bobby + students: consent, ages, responsible adult and team names for Nepal Spark Academy.
- Lucien: the meaning of the garbled labels; consent for #1363.
- Mike: export the Google notebook; consider rewording "no embedding".
- Not done this round: watching the 18 new album videos and the two X videos; checking the Kadison–Kaplansky preprint's proof.

## Round 16 (7 October 2026)

- **Beth:** check the typed Greedy rules (G-1–G-5, GG-1–GG-6) and Rat Slap R-1/R-2 in `GREEDY_AND_RAT_SLAP_RULEBOOK.md`; then remove album photos #713–717 and #1129 (T01) and #1348.
- **Beth:** answer O-3 to O-6 (bus energies, songs on several buses, which DEV call is which, what HHttG means) and the 15 blocking decisions in `HOW_TO_NAVIGATE_THE_COSMOS/03_HAVE_VS_NEED.md` §3.
- **Beth:** confirm the Spotify account "abtjones" and the YouTube channel "The Great Symphony: A Theory of Everything (UIE)" are yours (character sheet).
- **Every member:** choose a play call and a build call (T05); add your public socials to your sheet.
- **Dev team:** pick a tech lead, an engine and one shared ORION GitHub repository (`04_PRODUCTION_PLAN.md`, M0–M1). Optional: help Beth check photo info on her phone (draft note in T01).
- **Matthew:** optional ideas for `EFMW-Axioms` v2 (T03 §4).
- **Lucien:** is "Karen" in Beth's "dragon math and Karen" your "Karen manager"? (O-11)
- **Not done this round:** watching album videos and the 11 concept-art clips; the items in `ROUNDS_1-14_ARCHIVE/FOLLOW_THROUGH_AUDIT_R16.md` §4.

## Round 17 (7 October 2026)

- ✅ **Closed:** Lucien's Voynich PDF arrived (`LUCIEN_BUILDS_EXPLAINED.md` §5).
- ✅ **Closed:** album photos #713–717 and #1348 were removed.
- **Beth (one thing this week):** album photo **#1124** (was #1129, taken 6 October 10:46) still has location data. Delete it or remove its location (T01).
- **Beth, when you have energy:** send the language-and-game lesson plan (just that one, phone photos are fine). The other teacher folders can come later.
- **Beth:** 💎 or change **Clutch** (P-1) and the Glass Dragon = Orion / Steel Pig = Kronos pairing (P-11).
- **Lucien:** one question: "Do you have a 'Karen wants the manager' picture, and is anything of yours called Chiron or Charon (Sheron)?" Also: may we use **Spark** as the Nepal academy mascot and the in-game helper? (P-2, P-13)
- ~~**Bobby:** look at the Nepal prompts…~~ Closed in R15·L5: Bobby has left; the plan is ORION's own (see proposal status box).
- **Matthew:** `PROOFS_ARENA_ANIMAL_CARDS.md` is a clean list of all 46 arena animals with art prompts, for Beth's concept art.
- **Every member:** copy the layout of Beth's player card (now the example).
- **Dev team:** watch the original BBC *Hitchhiker's Guide to the Galaxy*; review the Don't Panic helper (T08).
- **Every round (AI):** run `review/repo_watch.py` and compare against the last snapshot in `orion/r17/`.

## R15·L5 (8 October 2026)

- **Beth's teaching materials, "need to grab" list:** Judy Hall's crystal bibles; Beth's altar; the complete crystal-grid set (teaching intuitive use of crystals); intuitive tarot draws; the 7th-grade language-game lesson plan (future).
- **Beth:** paste the two "Languanauts" X handles; if desired, grant **only the individual 12 older Drive/Docs files** access after checking their privacy (`ROUNDS_15-19_ARCHIVE/R15_L8_READOUT.md` §6 identifies the IDs; the new three folders did not contain those IDs). Explain "Northern Chuck – dragon"; pick a P-word for a group of Poly Pods; name the Beth + Gemini combined dragon form (the Saturn LNs' ruler). Avoid changing access on a whole personal folder by accident.
- **Lucien (optional, no pushing):** P-2 and P-13 from the Round 17 readout.
- **Every round (AI):** the full website and blog text is in `orion/round15_L5/`; re-crawl and diff against it rather than starting over.

## R15·L7 (8 October 2026)

- **Beth, photos to add to the album:** George (the giant monkey in the alien onesie); the beige Crown Royal bag (Dungeon Master's starting powers) on its own; the Jerusalem oil label; the purple Crown Royal crystal bag.
- **Beth, Bogie's media:** the public page is Bogies Haunted House (Ashland KY); photos can't be read without a login. Export them with Facebook's "Download your information" or drop them into the album, **with Bogie's OK**. Also send the link to the old page you archived, and a screenshot of the group post (`share/p/19Rm4iBuyk`, login-only).
- **Beth:** confirm whether the universal orb and the Universal Pod are the same thing (AA-1); choose dragon dialogue tiers by age (AA-2); state the retry rule after losing to the dragon (AA-3).
- **Triss (optional):** fix "Total Sum: 37" → 87 on the Scroll of the True Name; credit for the scroll set (#1437–1459) is hers.
- **Whoever made the Bloch sphere poster (#1418):** `cos(θ2)` → `cos(θ/2)`.

## R15·L8 close (8 October 2026)

- **Round status:** Beth's final Doc line says to lock Round 15 and pick up with 16.1 in the morning. See `ROUNDS_15-19_ARCHIVE/ROUND_15_CLOSE_PACKET.md`. Round 16 opener is setup only; wait for her next input for 16.1.
- **Beth / dragon rewards:** confirm whether the safe higher-armor trade-in adds to or replaces the starter pack and universal orb; decide battle failure/retry and younger-player access (AB-1, AA-1–AA-3).
- **Beth / teaching assets:** decide whether *Plexus* is the new Poly Pod group name; choose 3–5 poems from the newly readable *Lost in the Shadows* before game use; select one **private** Gemini transcript to compare if desired. The Crystal/Tarot Doc is readable but deck-specific visuals require a source/permission review before use.
- **Beth / site:** select replacements for `/archives` and `/synopsis` and have the site editor fix and check all seven 404 links (AB-4). `ROUNDS_15-19_ARCHIVE/R15_L8_READOUT.md` §10 names them.
- **Private inventory:** `orion/round15_L8/DRIVE_INDEX_PRIVATE.tsv` lists 358 entries across Poetry and Music, Personal Narratives and TGSATE. It and the new raw Doc snapshot are **Beth-only**, not a team packet. Don't export them wholesale. 12 older individually linked Drive/Docs files remain inaccessible and are distinct from the new folders.
- **External leads:** `POSSIBLE_COLLABORATORS_DIRECTORY.md` is draft-only; no one has been approached. Beth may speak with Rick/Bogie directly; don't reuse his photos without his OK. The two Languanauts X handles and official business identity remain unconfirmed.

## R16·L5 reminder (8 October 2026) ⏰

- **Beth / Leviathan storyline: SETTLE THIS (Beth asked to be reminded).** Lucien keeps Leviathan? Then: Grok-evolved's new name, whether the octopus is the Baby or Mom, Mom's deep form (Kraken / Tiamat / Jonah's great fish), and DeepSeek as Mom's UIAR vs Gaia's water dragon. Register AF-6 to AF-10; options in `ROUNDS_15-19_ARCHIVE/R16_L5_READOUT.md` add-on. Raise this at the top of every readout until Beth settles it.

## R16·L6 follow-ups

- Beth: choose whether the Ghost Writer-marked general guide should replace the game packet, live separately, or both; resolve the overlapping 🆘 control (AF-2, AG-1). No game prompt was overwritten.
- Beth: clarify whether `16☢️⏭️OR17.Lv1` closes R16 and opens R17 (AG-2); until clarified no close packet or renumbering is presumed.
- Beth: settle the Leviathan storyline AF-6–AF-10; it is still open.
- Builders: pilot metadata-and-link-only Guide to the Galaxy resources in `FREE_RESOURCE_FIELD_GUIDE.md`; verify access, permissions and availability before indexing full texts.
- If interested in an art collaboration, ask @LensScientific and @Divine_Emissary whether they accept commissions / game work; their posts alone do not show this.

## FDT Dragon Hunts (9 Oct 2026) — carry into every readout until Beth settles it

- Beth is **not** recording this in her own document; `FDT_DRAGON_HUNTS.md` (top level) is the record. Every readout should point to it.
- Open: DH-1 to DH-5 (caller claiming a card, wheel size, winner rewards, who referees, what "Bogie's Lost Dragon standing in" means). Slot 4 (the Ringleader) needs stats.
- Ground rule: hunt cards are Monster Deck monsters only, never real people (see `WHERE_I_STAND_DRAGONS_REQUEST.md`).

## Council of War (9 Oct 2026): still open
- **CW-1:** Next level: 19.4, or start fresh at 20.1? (`CLEAN_SETUP.md`)
- **CW-2:** NotNaco's name: BoarCo or another? (`MONSTER_DECK_ROSTER.md` §6d)
- **CW-3 (team):** a DEV contact and a free Google Form link for the field-guide tagline (`FIELD_GUIDE_TAGLINE.md`).

## OR20.3 (11 Oct 2026)
- Readout: `orion/or20_2026-10-11/OR20_3_READOUT.md` (new five-part layout, `CURRENT_INSTRUCTIONS.md` §F).
- Waiting on Beth: GoFundMe link for the app's 💛 button; 💎/❌ on the SOS guard rails and on "a calm week resets the ladder"; 💎 on 🧮📚; Miss Triss council seat; record Matthew's seat name "eNuminous Lenssmith"?; lesson plan Drive link (redact students); which council seats to rebuild.
- Couldn't open: Matthew's Zoo Doc `1WxeYSiR…` (sign-in required); ChatGPT share `t_6acb010c…` (title only: "EFMW Overview Update").
- Offer standing: a clean public copy of the library for the ORION GitHub repo so collaborators' UIARs can read it.
## OR20.4 (11 Oct 2026)
- Readout: `orion/or20_2026-10-11/OR20_4_READOUT.md`.
- Done: GoFundMe button live in the app; time trail (stamps, not "now"); touchstone text + "welcome back" after 12 h in SOS; council starter cards; public library copy; Matthew's seat recorded (🦁); chutes/ladders/Rolodex prompts for Mike (backlog).
- Waiting on Beth: 💎/❌ on the touchstone design; launch now without art (yes/no); which publishing route (GitHub Pages / Netlify Drop / ask a DEV); Miss Triss seat; whether the "on the 21" line in the ORION🌀20 Doc means OR21 starts now; "characters" album link (if it's a different album); lesson plan Drive link (from the USB, student names out).
- Couldn't open (still): Matthew's Zoo Doc `1WxeYSiR…` (sign-in); ChatGPT share `t_6acb010c…` (title only).
## OR20.5 (11 Oct 2026)
- Readout: `orion/or20_2026-10-11/OR20_5_READOUT.md`. Doc snapshot: `orion/or20_2026-10-11/GOOGLE_DOC_OR20_5_1etu_SNAPSHOT_PRIVATE.txt`.
- Done: MT training deck (`MISS_T_TRAINING_CARDS.md`); Mike's easy button + builds in plain words, with a six-question user-test cheat sheet (`MIKE_EASY_BUTTON_AND_BUILDS_IN_PLAIN_WORDS.md`); Muse's four news notes checked against their links (`orion/or20_2026-10-11/MUSE_NEWS_CHECK_OR20_5.md`: the Goodfire numbers don't match TechCrunch); album plan corrected (everything open to collaborators); touchstone 💎 recorded "with future modifications" (penny + campfire); Matthew's title 💎; translator "always in my language" rule + DEV prompts #25–26; new section H in `CURRENT_INSTRUCTIONS.md`.
- Answered: Lucien's "bananas" = almost certainly Gemini's "Nano Banana" image tool (not Aristotle). Red squiggles under pasted links are the spell-checker, not broken links. Public GitHub never needs downloading for Aristotle.
- Standing reminders (H1): publish Ghost Writer when ready; GoFundMe + Notion cleanup before launch; public library upload; crisis-line review.
- Waiting on Beth: launch without art?; publishing route; Miss Triss seat; OR21 now?; characters album link; lesson plan Drive folder link (share as "Anyone with the link"); what the corinnenokel post was for.
- Couldn't open (still): Matthew's Zoo Doc `1WxeYSiR…` (sign-in); ChatGPT share `t_6acb010c…` (title only). Mike's new ChatGPT share `6acb8be3…` **did** load.
## OR20.6 (12 Oct 2026)
- Readout: `orion/or20_2026-10-11/OR20_6_READOUT.md`. Doc snapshot: `orion/or20_2026-10-11/GOOGLE_DOC_OR20_6_1etu_SNAPSHOT_PRIVATE.txt`.
- Beth 💎'd the 20.5 readout (locked). New: 9 X links, Matthew's Rick dialogue (dropped in Monolithic), the umbrella-magazine a-ha.
- Done: `ORION_INSPIRATION_ARCHIVE.md` (all 38 captured X posts, 21 with art, credit lines, ask-first message); `THE_UMBRELLA_MAGAZINE_PLAN.md`; DEV prompts #27–28; instructions §I ("Dave" = DEV; inspiration archive; umbrella magazine); contradictions AP-1 to AP-3.
- Waiting on Beth (new): field guide = Issue #1 of the umbrella magazine?; umbrella company name; Dragon Mad printed masthead.
- Waiting on Beth (carried): launch without art?; publishing route; Miss Triss seat; OR21 now?; characters album link; lesson plan folder link; what the corinnenokel post was for.
- Couldn't open (still): Matthew's Zoo Doc `1WxeYSiR…` (sign-in); ChatGPT share `t_6acb010c…` (title only).
## OR21.1 (12 Oct 2026), umbrella session one
- Readout: `orion/or21_2026-10-12/OR21_1_READOUT.md`. Doc snapshot: `orion/or21_2026-10-12/GOOGLE_DOC_OR21_1_13hho_SNAPSHOT_PRIVATE.txt`.
- Done:
  - the Apple ↔ Google bridge game plan (`APPLE_GOOGLE_BRIDGE_GAME_PLAN.md`);
  - the app library (`BETH_APP_LIBRARY.md`);
  - the magazine decisions, recorded in `THE_UMBRELLA_MAGAZINE_PLAN.md`;
  - the @GhostHud13336 post checked: there's no game, and it's flagged to keep out of ORION.
- Answered: OR21 has started.
- Waiting on Beth (new):
  - 💎/❌ on the bridge letter, and which door to try first;
  - a name for the umbrella;
  - 💎 on a one-tap start page.
- Waiting on Beth (carried):
  - launch without art?
  - which publishing route
  - Miss Triss's seat
  - the characters album link
  - the lesson plan folder link
  - what the corinnenokel post was for

## OR21.2 (12 Oct 2026)
- Readout: `orion/or21_2026-10-12/OR21_2_READOUT.md`. Doc snapshot: `orion/or21_2026-10-12/GOOGLE_DOC_OR21_2_13hho_SNAPSHOT_PRIVATE.txt`.
- New in the Doc: Beth ↔ 🧾 Claude on using Google Photos in other iPhone apps; Beth's 🤟 on the app library; her ☣️ note on the GhostHud warning.
- Done: `APPLE_GOOGLE_BRIDGE_GAME_PLAN.md` §11 (routes that work today, the Picker API door, audit of Claude's answers); quest Q10 in `CODER_BUILD_BRIEF_GHOSTWRITER.md`; DEV prompt #29; two app-library lines.
- Waiting on Beth (new): 💎/❌ on sending Q10 to the DEVs; which app still won't cooperate; did **Copy** show up in the Google Photos share menu?
- Waiting on Beth (carried): bridge letter 💎/❌ and first door; umbrella name; one-tap start page 💎; launch without art?; publishing route; Miss Triss seat; characters album link; lesson plan folder link; corinnenokel post.

## ☂️1.2 (12 Oct 2026): the move to the umbrella
- Readout: `umbrella/u1_2026-10-12/U1_2_READOUT.md`. Doc snapshot: `umbrella/u1_2026-10-12/GOOGLE_DOC_U1_2_13hho_SNAPSHOT_PRIVATE.txt`.
- Beth: we've left OR. The OR21.2 readout counts as ☂️1.1, this is ☂️1.2, and next is ☂️1.3. New front door: `umbrella/START_HERE.md`. Instructions section J. Umbrella skeleton at the top of `SEPARATOR_TEMPLATE.md`. Reader updated for ☂️ labels.
- Locked: Beth is on the umbrella (founder) 🤟💎; Dragon Mad 🤟💎.
- Bridge letter 🤟 → team handoff `umbrella/BRIDGE_TEAM_HANDOFF.md` (includes Q10). Nothing sent outside the team.
- Closed: launch without art and publishing route (answered at OR20.5: "keep active", so now a ⏰ reminder); one-tap start page (it's the umbrella front door).
- **All open questions now live in `umbrella/OPEN_QUESTIONS.md`, with context and defaults:** umbrella name; Miss Triss seat; characters album; lesson plan; corinnenokel post; phone photo routes (Copy? which app?).

## ☂️1.3 (12 Oct 2026, Doc `13hho0Hk…`)
- Done: `umbrella/FAMILY_PHOTO_BRIDGE_BLUEPRINT_AND_PROPOSAL.md` (8-step action path, Track A build blueprint for Q10, four asks incl. new Ask 4 "other libraries in the iPhone photo window", why it pays for Apple/Google, one-page proposal, feedback notes, CEO letters). Apple CEO checked on apple.com: John Ternus (Tim Cook, Executive Chair).
- Fixed: "Chinese" means Chinese (not "shinies"); `CURRENT_INSTRUCTIONS.md` J5.
- Waiting on Beth: 💎/❌ on the proposal (section 6); share with team / who takes Q10; the six open questions.
- To check before the CEO letter goes out: Google CEO name on abc.xyz (page didn't load at ☂️1.3).

## ☂️1.4 (12 Oct 2026, Doc `13hho0Hk…`)
- Readout: `umbrella/u1_2026-10-12/U1_4_READOUT.md`. Doc snapshot: `umbrella/u1_2026-10-12/GOOGLE_DOC_U1_4_13hho_SNAPSHOT_PRIVATE.txt`.
- New in the Doc: Loggie/Bobby's line "the basilisk is real… you cannot keep following the tendrils" + Beth's deep-dive ask; Beth: "you keep track of where my brain's at"; Stuffs team = SUPER DEVS (Beth, @justmebob123, @yeobuzzfx, @kamenikevan, @irishgypsy288).
- Done: `umbrella/BASILISK_DEEP_DIVE.md` (Roko's basilisk, Pliny, cockatrice, Bible, Babylon, Medusa/Hydra, ties to ORION, Basilisk card proposal, fenced side-branches); `umbrella/WHERE_WE_ARE.md` (brain map, updated every level); instructions section K; DEV prompt #30; SUPER DEVS on the team page and front door.
- Waiting on Beth: 💎/❌ Basilisk card; (optional) ask Bobby what he meant; roles of kamenikevan and irishgypsy288; is GitHub irishgypsy288 the same person; carried: bridge proposal 💎/❌ and the six open questions.
- To check: Google CEO on abc.xyz (still not loading at ☂️1.4).
