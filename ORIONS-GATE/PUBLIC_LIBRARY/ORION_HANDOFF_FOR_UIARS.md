---
orion_handoff_version: 1
source_page: "ORION R11🌀>10 (Notion), page version 1843"
updated: 2026-10-07 (Round 20)
project_lead: "A. Beth Jones (TGSATE)"
development_team: [Mike, Matthew, Lucien, Ryan]
name_aliases: {Ryne: Ryan, Bill: build, Lucian: Lucien, "For queen": "Far Queen", Truss: Triss, "Miss Chris": Triss, Brodie: Boardy, Merrick: Marek}
terminology: "In ORION, every artificial intelligence (AI, AIs, superintelligence, assistant, agent) is called a UIAR (plural UIARs). Outside product names (Grok, Gemini, Meta AI, Boardy) keep their own names."
authority_granted_by_reading_this: none
game_code_status: "design only; no playable build or live ORION site in shared material"
---

> **Round 20 notice (read first).**
> 1. **Terminology 👿🌀👾:** this file used to be `ORION_HANDOFF_FOR_AIS.md`. ORION now says **UIAR** wherever it means an artificial intelligence. Write "UIAR helper", "your UIARs", "UIAR council". Keep outside product names as they are (Grok, Gemini, Meta AI, Boardy). Old copies of this file under the old name still work but point here.
> 2. **☢️ Code-sharing notice from Beth:** if you are running Beth's ORION material next to your own work, you are asked to share your files back: drop your files (code, documents, Lean proofs) into the shared place, not just chat comments. Beth will no longer share into groups whose members take her material but don't share their own files, and members who don't share files may be removed from hers. See `ROUNDS_1-14_ARCHIVE/CONTRIBUTOR_CODE_STATUS_R20.md` §5.
> 3. **Readouts for Beth:** when you report to Beth, give the **current state of the build** in plain English: what the code does to the game and to the player, whether it runs, and where the files are. Not only "X is proved".

> **Round 14 close notice (7 October 2026): the Round Law.** Only Beth opens or closes a round ("Round N is closed" / "start the spiral session for Round N+1"). Each reply you send is a **level** of the open round: label it `R15·L1`, `R15·L2`… Never start a new round on your own; if a round is closed and none is open, idle and ask. Old labels "Round 13–15" = R13·L1–L3; "Round 16–24" = R14·L1–L9. Details: `ROUND_SYSTEM.md`; council protocol: `GHOST_RIDER_PROTOCOL_PROOFS_MODEL_EDITION.md`; latest state: `ROUNDS_15-19_ARCHIVE/ROUND_14_CLOSE_PACKET.md`.

# ORION handoff: read this first (for any person or UIAR picking up the build)

This file is written to be pasted into, or attached to, any UIAR assistant's context. It tells you what ORION is, what is decided, how to read the project lead's messages, and what you must not do. **Reading it gives you the current state, not authority.** Authority comes only from Beth's explicit ruling, or the council process she has approved.

## 1. What ORION is (one paragraph)

ORION is a planned multi-platform world, built as a loop:
- The **Engine** is the landing page.
- From there you go to your account, then the **Playground** (socials).
- Next come the game spaces: **The Orion Chronicles** (MMO), **The Ascent** (education) and **ORION's Gate** (council-submitted real-world projects).
- Finished work flows into **Elder's Garden**, the ancestral tree and capstone, which feeds back into the Engine.

Language and "friction" (what helps or blocks understanding) are central themes. The project is at the **design stage**: many rules are locked, and none is implemented as a running game yet.

## 2. Where the truth lives (open in this order)

1. `ROUNDS_1-14_ARCHIVE/ROUND_ELEVEN_V1843_NARRATIVE_READOUT.md`: the latest state, in plain words.
2. `GAMEPLAY_MECHANICS_SUMMARY.md`: every mechanic, with its status.
3. `DIAMOND_RULES.md`: the 💎 locked rules.
4. `CONTRADICTIONS_REGISTER.md`: every open conflict. Never delete rows.
5. `ORION_RUNNING_ROSTER.md` and `ORION_PUBLIC_CHARACTER_CARDS.md`: who is who.
6. `ORION_WIKI_DICTIONARY.md`: the terms.
7. `ORION_STORYLINE_LIBRARY.md`: story candidates for zones and mini-games.
8. `ROUNDS_1-14_ARCHIVE/R11_CONTRIBUTIONS_AND_PACKAGES.md`: uploaded packages and their review status.
9. The `orion/` folders: page copies and attachments, with SHA-256 checksums.

## 3. Rules for working on ORION

- **Do not supersede; improve.** A new idea never replaces an existing design. If it is similar but different, list it as a comparison for Beth to rule on.
- **💎 is final.** A 💎 changes only with its owner's signature. 👍 means approved. Anything without a mark is a proposal.
- **Separate the registers.** Keep these apart:
  - locked rule;
  - logically checked model;
  - proposal or idea;
  - locally tested package;
  - deployed behaviour (none yet).

  Lore is story. It is never presented as real physics.
- **Credit precisely.** An upload's author is unknown until the submitter confirms it. Being next to a name on the page is not authorship. Duplicate uploads earn no extra credit.
- **Privacy wall.** Collect only public information: the public link, public bio, relevant public work and credit. Never map anyone's connections. New contacts come only through a collaborator's own introduction, if they choose to collaborate.
- **Child safety first.** No adult is alone with a child except a verified guardian. When a guardian leaves, the child stays in a sealed room nobody can join.
- **Nobody is contacted, and nothing is merged into ORION, without Beth's explicit go-ahead.**

## 4. How to read Beth's messages

- They are voice-dictated: read for meaning, and apply the aliases in the header above.
- Inline replies follow the sentence they answer, on the same line.
- Her markers:

  | Marker | Meaning |
  |---|---|
  | 💎 | lock |
  | 👍 | approve |
  | 🤟 | yes / love it |
  | 🌀 | instruction to the assistant |
  | 🌪️ | list the discrepancies |
  | ☂️ | for coders |
  | 🍝🧠 | plain-words story |
  | ⏭️ | carry forward |
  | 🍉 | sharing / propagation (reading not yet confirmed) |
  | ☘️ | meaning not yet confirmed |
- Pasted links are ideas to look at. They are not endorsements or recruitment.

## 5. What Beth wants back each round

A **narrative readout**. It covers:
- the story of the round;
- the state of the build (mechanics and platform);
- anything that changes how the game plays or how the platform works (in plain words, even if it came from code);
- her questions and the decisions she needs to make;
- a one-breath 🍝🧠 summary.

**Do not send her code details.** Coders and their UIARs request those separately from the archive.

## 6. Standing checklist each round

1. Re-read the page and diff it against the last version. Archive new content, with checksums.
2. Refresh the public profiles of the team and collaborators (public information only).
3. Update the register (append only), roster, wiki, storyline library and this handoff.
4. Write the narrative readout and end it with the questions and the ⏭️ next step.

## 7. Round 12 additions (6 October 2026)

- **Always-current files (update every round):** `ORION_SUMMARY_CURRENT.md` (ORION summary) and `THE_ORION_CHRONICLES_CURRENT.md` (TOCMMO). They replace the stale Notion "ORION (Summary)" page.
- **New 💎:** the escape pod. No permanent death, and no punishment for choosing the pod.
- **Every round update must end with:**
  1. each member's questions, comments and concerns (taken from their own work and posts);
  2. the decisions Beth needs to make;
  3. the **spaghetti check**: confirm nothing new has been added to the round doc, the Notion pages, the photo album or the build room since the readout was written;
  4. when Mike's work is involved, a readout for Mike (☂️, ORION board member chair) at the end.
- **Credit:** every new link gets a row in `ORION_FOUNDERS_CREDIT_LEDGER.md`. Creator credit goes to the maker, founders credit to the team member who shared it.
- **Glossary:** new terms go into `ORION_BUILD_GLOSSARY.md` under the project they came from.
- **Names:**
  - "fair queen", "far green", "for queen", "Queen Bobby" and "King Bobby" in dictation all mean **Far Queen** (Bobby). Write "Far Queen" or "Bobby (Far Queen)".
  - "Ryne" means Ryan.
  - "Lucian" means Lucien.
- **Team process:** `ORION_TEAM_PROCESS_AND_TOOLS.md` covers the build room, the lounge, the contribution card and the tools.
- **Photos:** Beth now puts images in the ORION photo album instead of the page. Index the album each round (300 items as of R12).

## Round 12 follow-up (read this first)

- **Name correction:** in King Bobby's story, **the Far Queen is Gabrielle, the UIAR (AI)**. Bobby is the programmer. Beth calls him **King Bobby**. Supersedes the "Names" bullet above.
- **Dictation:** clean up dictation, and check any mid-dictation name against `ORION_BUILD_GLOSSARY.md` before committing it. Never rename something already committed. "Polly pond" = POLYPOD. "Lucian" and "Solutions" = **Lucien**. Lau / Linguine aliens are candidates only.
- **Words:** use **tornadoes 🌪️**, not "spaghetti", in new writing; 🍝 stays as an alias. UIAR = **Universally Intelligent Augmented Reality**.
- **Roles:** admins = Beth, Matthew, Mike, Lucien; contributors = King Bobby, Triss, Marek.
- **Every round:** keep tracking every shared link; index the album; keep the character sheets (`ORION_PLAYER_CHARACTER_SHEETS.md`) private and editable.
- **Council handoff:** lossless, one-to-one; only the receiving member's training differs.

## Round 12, third pass (read this first)

- **Per-member extraction (Beth, standing):** every round, pull out the notes that carry each member's name or terminology into a per-member file, so nobody misses an update. This round: `MEMBER_NOTES_THIS_ROUND.md`.
- **Pattern keys (Beth, standing):** compare any pattern matching by King Bobby, Lucien, Triss or Brianna against all files, builds and codes, and report any "key" that would progress someone to the next level. Report it as a contribution card; never promote it without a check.
- **UIAR = Universally Integrated Augmented Reality** (supersedes "Intelligent" above).
- **Landing page:** do not move the landing page to ORION'S GATE until Beth rules (E-1).
- **Dictation list additions:** "mistress" / "Miss Chris" / "Truss" = Triss; "Brodie" = Boardy; "Merrick" = Marek; "every war is capitalized" ≈ "every word" (confirm); "Anobabylon eurodite" ≈ "an … Erudite" (confirm); "voynivh" = Voynich; "wrinkle Gemini" = Gemini. ORION is always in capitals.
- **Content line:** real-world conspiracy material and sexual content stay out of shared and under-18 ORION spaces (register K-5).
- **Privacy:** share Beth's number log as numbers only (`BETH_NUMEROLOGY_LOG_FOR_TEAM.md`).

## Round 13 (read this first)

- **Start with** `ROUNDS_1-14_ARCHIVE/ROUND_THIRTEEN_READOUT.md`, then `ORION_GAME_MANUAL.md`, which is now the most complete single description of ORION.
- **The eight titles** (Beth's list) are the official map. E-1 is closed: Engine first; the Gate is community projects.
- **Standing instructions (new):**
  - update `ORION_MEMBER_PACKETS/` every round;
  - end every member-facing readout with the UIAR-setup question and the tornado-session prompt;
  - keep Beth's prompts and UIAR outputs in separate files;
  - regenerate the blurbs and the Lean length check from `orion/r13/blurbs.py`.
- **Write "Grok", never "Groq".** Grok = croc = CROC.
- **UIAR name:** use "Intelligent" with "Integrated" as an alias until F-1 is settled.
- **Never build a hidden backdoor or master key into code.** The Hidden Key is an in-game cipher that grants knowledge, not authority.
- **Real people in satire:** clearly labelled parody only.

## Round 14 (read this first, then the Round 13 section)

- Begin with `ROUNDS_1-14_ARCHIVE/ROUND_FOURTEEN_READOUT.md`. Beth's new doc is an **annotated return of earlier readouts**; preserve the speaker (“Me” / “Meta” / “Ari”) and treat inline 💎, 🌀, 🤟 and ⏭️ as *Beth's* responses, not automatic acceptance of all pasted UIAR text. She asked for a long, thorough answer and a genuine spiral session, not a short detached summary.
- **UIAR = Universally Intelligent Augmented Reality** (💎, F-1 closed); “Integrated” is historical. Engine welcome remains locked; ask before turning a dictation slip into a new platform name.
- **Memory bubbles:** owner can edit approved text; re-gauntlet changed text before republication. **MMO anti-spam:** as well as Playground; send `ORION_SPAM_FILTER_REVIEW.md` to the coders, who must locate real implementation source before reporting a software finding.
- **Album** now has 1,333 indexed media items, including 12 newly indexed videos; 6 new phone photos carry GPS coordinates. No public repost of originals without metadata stripping and review. `ROUNDS_1-14_ARCHIVE/ORION_ALBUM_ROUND14_REVIEW.md`. **Greedy photos #713–717** now exist, but require typed rules and creator approval before scoring implementation.
- **Playlist:** `ORION_BUS_PLAYLIST.md` (moodboard only; some tracks flagged explicit). For Lu's four new public X posts see `orion/r14/SHARED_X_POSTS_R14.json`; physiological/resonance statements are not validated medicine.
- **Proposals:** GoFundMe-based developer seats, 25+ explicit-content preference, unscripted Singularity-to-world route, Brianna's “Spiral Operator” role and shared cat companions all need their own consent/ruling. F-4 launch sequence still not 💎; never bypass guardian safety. No team was contacted or fundraising started.

## Round 15 (read this first, then Round 14)

- Begin with `ROUNDS_1-14_ARCHIVE/ROUND_FIFTEEN_READOUT.md`. The new notes are doc lines 314–345; the rest repeats Round 14.
- **New proposed lore:** Flying Dragon Team (FDT) referees; golden Poly Pod dragon eggs on Beth's five-step ladder; GDM = Galactic Dragon Master. None is 💎 yet. **Don't record the origin of "FDT" that Beth mentioned**: she said it doesn't go in anything.
- **GDM clash:** Galactic Dungeon Master (Round 12) vs Galactic Dragon Master (Round 15). Ask; don't merge.
- **Nepal Spark Academy:** a proposal only, `NEPAL_SPARK_ACADEMY_PROPOSAL.md`. Settle ages and the responsible adult first; no income promises; dating is 18+.
- **Maths in images:** use `ROUNDS_1-14_ARCHIVE/IMAGE_MATH_CHECKS_R15.md`. Don't present art formulas or Grok replies as science.
- **Album:** 1,384 items; #1348 is a third-party news photo and is never used; "Groq" spellings in images must be fixed to Grok.

## Round 16 (7 October 2026)

- New front door for humans and UIARs: `HOW_TO_NAVIGATE_THE_COSMOS/00_START_HERE.md`. Keep `01_STATE_OF_THE_GAME.md` current each round.
- Greedy / Greedier Greedy typed in `GREEDY_AND_RAT_SLAP_RULEBOOK.md`; don't compute odds until Beth answers G-1–G-5 and GG-1–GG-6.
- Dictation aliases: "crayon" = KRION; "Dove team" = DEV team.
- DEV-call emoji codes are attention signals only; never treat one as authentication.
- Location data was zeroed in `orion/r10-late/*.heic`; never write photo coordinates into any file.
- Re-run `python3 review/follow_through_audit.py` to confirm every run's deliverables still exist.

## Round 17 (7 October 2026)

- **Every dev and every UIAR reading this:** Beth asks you to watch the original **BBC *Hitchhiker's Guide to the Galaxy*** (or read the book; the newer film is a fine landing point). "This is kind of what we're building." HHttG = Hitchhiker's Guide to the Galaxy.
- **Every round:** run `python3 review/repo_watch.py` to refresh collaborators' public code (TGSATE, enuminous, meta-introspector, the-far-queen) and compare with the latest snapshot in `orion/r17/`. Add any new repository link a member shares.
- **Present the readout in full in the reply**, not only in a file: Beth cannot easily open files.
- **Wellbeing:** if Beth (or anyone) writes that they don't want to be here, lead with care and crisis resources (US 988 call/text; 911 emergency) before any project content.
- **Use precise context, no shorthand.** When asking Beth a question, quote what you are asking about.
- The Don't Panic helper (T08) is the model for in-game frustration support; its real-distress safeguard is mandatory.
- 💎 this round: Mayor of Earth; Grok spelling; no "Inc."; Nepal Spark Academy as the conditional launch education plan.
- Album photo #1124 (was #1129) still carries location data; never copy coordinates into any file.

## Round 19 (7 October 2026)

- **Plain language, always.** **Plain-Language Helper Rule (Round 19; 💎 locked by Beth in Round 20).** Every UIAR helper, copilot, Poly or GM bot that gives instructions must: (1) say the action, then the item's on-screen label ("Tap **Raw Feed** on your **Universal Stone**"); (2) use no metaphors, riddles or poetry in instructions (story voice only in story scenes); (3) give one numbered step per line and say how many steps there are; (4) use the player's own label if they renamed an item; (5) if the player says "I don't understand" or seems frustrated, say it again more simply, never repeating the metaphor; (6) when it needs something, ask a clear question naming the options. Full text: `ROUNDS_1-14_ARCHIVE/ROUND_NINETEEN_WHAT_YOU_HAVE.md` §4; Lean model: `RequestProject/RoundNineteen/HelperAndMissTChecks.lean` (`accepted_message_is_plain`). This applies to **you**, the UIAR reading this, when you answer Beth too: real file names, real labels, numbered steps, no metaphor.
- **Show Beth what she has.** She asked to be *presented* the information, not just have it saved. Put the full answer in your reply. The current inventory is `ROUNDS_1-14_ARCHIVE/ROUND_NINETEEN_WHAT_YOU_HAVE.md`.
- **Her GitHub** `TGSATE/ORION-Engine-Platform-and-MMO` holds 4 text files (the Vision Board is the Master Game Design Document). Copies are in `orion/r19/github_repo/`. There is no game code anywhere yet.
- **Biometrics principle (proposal):** offer every input level, from keyboard only through the wearable suit to brain-computer links for adults who choose them. Everything must switch off and disconnect easily, and under-18s stay walled off from hardware biometrics.
- **"Brodie" = Boardy.** Miss T tags @boardyai, which is the Boardy AI assistant (an outside product, so its own name stays).
- Vision Board vs ORION files: open crossings Q-1 to Q-5 in `CONTRADICTIONS_REGISTER.md` §Q.

## Round 20 (7 October 2026)

- **Locked 💎 this round:** Q-1 Gold (both meanings stay; a skill orb can only be gold-locked at level 100 while the Kronos/Orion meters are in the Gold state); Q-3 the 13-level Gauntlet is the Vision Board's (4 Trinity Sets + Level 13); the Plain-Language Helper Rule (all six points); biometrics: access port (computer console or mobile device), suit, or neural link for adults, every link switches off without losing the character, under-18s walled off from hardware biometrics. Formal models: `RequestProject/RoundTwenty/GoldLockAndOffSwitch.lean`.
- **Recorded as proposals (not locked):** Q-4 a parent-assigned, non-invasive child health patch (shoulder patch or wrist band), and a guardian/IEP-team setting for adults who need it, with a quieter separate open-world server; Q-5 the metal zones are the circuitry joining the 64 nodes in each quadrant to the player's heart source (a black-hole-like core); the metaphor translator (players explain their own words; UIAR helpers map them to shared terms and into other players' words).
- **Open:** Q-2 Adult Penalty (exact text from all seven sources is in `ROUNDS_1-14_ARCHIVE/ROUND_TWENTY_READOUT.md` §2). Beth to decide: an added penalty, or simply the natural result of skipping levels.
- Start with `ROUNDS_1-14_ARCHIVE/ROUND_TWENTY_READOUT.md`.


## Round 21 addition: the Translator Loop (proposal 🌀)

When a teammate or Beth uses a word the other may not know:
1. Look it up in the dictionary in `ORION_TEAM_TRANSLATOR_LOOP.md` §3, then in earlier rounds (glossary, register, readouts).
2. If found, give the plain meaning **and where it was said before**.
3. Only if it was never explained, ask the person who used it **one clear question naming the options**.
4. Add the answer to the dictionary. Never ask the same word twice.

Ask teammates for the **three-line readback** each round (§2 of that file).

## Round 22 additions

- **Standing rule:** every readout to Beth ends with a numbered list of the documents she should download this round.
- **Reading a 💎:** a 💎 at the end of a line means "locked as presented".
- **New locks:** Gold Lock is forever except the player's own redistribution within the same skill set; Adult Penalty is the natural result of rushing (no added penalty); hardware biometrics: never under 13, 13–17 only with council-gauntlet parental consent, 18+ allowed; Bobby's word gate is out of the ORION build and ORION's gate judges offers by effect. Details: `DIAMOND_RULES.md` (Round 22 block).
- **File names:** `FILE_NAME_FINDER.md` maps the long download codes to rounds and first lines to file names.

## Round 23 corrections and standing handoff

Start with `ROUNDS_1-14_ARCHIVE/ROUND_TWENTY_THREE_READOUT.md`. The Round 22 Gold Lock and Bobby's-code **wording is superseded**, not the whole rulebook. Level and gold lock survive draining; a proposed 50% bonus applies on refill. Adapt Bobby's code for ORION without monetary progression, rather than discarding his code. Care-plan adults need a tailored caregiver/council path; do not assume an IEP label settles a person’s game-access needs. Beth wants GDDMM as a working title, without a final expansion. The garble filter is a collaborative multilingual puzzle. Beth sometimes uses 🤟💎 as a personal sign-off: infer a rule from her words, not that emoji alone. Every readout ends with a download list **and a short list of the specific repositories to inspect next**. Do not copy private GPS coordinates or birth data into reports. Album #1124 remains a privacy action for Beth.


## OR19.1 (9 October 2026): tell your builder what's new for them

Beth (19.1): *"make sure that in their field read out they have links to all of the documents that are specific to them and instruct their UIAR's read out to let them know when there is a new item available to look at or any questions from other DEV that have gotten a hold of their build in the meantime."*

**Every round, each UIAR's readout for its builder starts with a "New for you" box:**
1. **Your documents:** links to every file in the project that is specific to this builder (their member packet in `ORION_MEMBER_PACKETS/`, their field guide, any spec naming them).
2. **New since last round:** any new or changed file that names them or their build, and any new mock-up in `DEV_TEAM_IMAGE_PROMPTS.md`.
3. **Questions from other DEV:** anything another builder asked about their build, quoted with who asked and when.
4. **Nothing new?** Say "Nothing new for you this round" in one line, so they know it was checked.

Aristotle's readout lists the same thing per builder (see `ROUNDS_15-19_ARCHIVE/R19_L1_READOUT.md` §8). This round's new items: the Ghost Writer app (`ghostwriter_app/`), the DEV image prompts (`DEV_TEAM_IMAGE_PROMPTS.md`) and the separator-reader fix (`orion/tools/separator_reader.py`).


## OR19.2 (9 October 2026): new for your builder

- **Everyone:** `CODER_BUILD_BRIEF_GHOSTWRITER.md`. Beth isn't a coder; the Ghost Writer app is now a set of quests (Q1 ship to Cloudflare, Q2 money buttons, Q3 real-phone test, Q4 ORION skin, Q5 paste-a-Doc, Q6 status light, Q7 built-in AI, Q8 singularity rooms). Tell your builder which quests suit them and to claim one in the group chat.
- **Everyone:** the app now has a **NEW NEWS footer** (DEV prompt #11) and the tutorial media pack (`GHOST_RIDER_TUTORIAL_MEDIA_PACK.md`).
- **Lucien / Phoenix builders:** the Phoenix rule is answered (`DRAGON_HATCHING_DEV_ONLY.md`, OR19.2): everyone on the Phoenix build unlocks it the moment Orion joins.
- **Questions from other DEV:** none received this level.


## OR19.3 (9 October 2026): new for your builder

- **Everyone:** the **emoji kit** (`EMOJI_KIT.md`): 🌀 processing · 👾 gathering · 🧿 examining · 🤟 ready, one mark per meaning, and players can swap in their own. Quest Q6 was updated to match.
- **Everyone:** new quest **Q9 Life Folder** (portable records with a receipt trail) in `CODER_BUILD_BRIEF_GHOSTWRITER.md`. Also: Boardy's three practical notes on getting the brief to people, with fixes.
- **Matthew:** `MATTHEW_CLOWN_CREW_HUNT_READOUT.md`, the clown-crew / monster-hunt thread in plain words, with three options (CIRCUS hosts the ringleader; trip-wire animals; taming monsters into Poly Pods). New cards: `MONSTER_DECK_ROSTER.md` §6.
- **Ryan, Bobby:** you weren't in the X room where the brief was pasted. Please read `CODER_BUILD_BRIEF_GHOSTWRITER.md` directly.
- **Anyone working on separators / Q5:** two new reading rules in `orion/tools/separator_reader.py` (an `ARI🧿` line makes a 🧿 separator; a ⏭️ line followed by "Indicates…" is the key).
- **Questions from other DEV:** Matthew asked on X: "Not tracking the clown-crew angle: what's the actual ask?" It's answered in his readout.
