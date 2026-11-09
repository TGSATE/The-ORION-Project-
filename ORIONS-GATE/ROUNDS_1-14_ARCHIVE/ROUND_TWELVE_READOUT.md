# ORION12>🌀11 — Round 12 narrative readout 🍝🧠

*Read 6 October 2026. Source: the Google Doc "ORION12>🌀11", plus every link inside it. A copy of the doc text, the Notion pages it points to, the shared posts, the photo-album manifest and contact sheets, the Far Queen repository snapshot and the Mike sweep are in `orion/r12/` (with checksums in `orion/r12/SOURCE_HASHES.sha256`). This readout follows your readout rule: story first, build state second, anything that changes play in plain words, then your questions. Code details stay in the archive for the coders' AIs.*

---

## 0. The short answer

**One rule changed the game this round: the escape pod (🤟💎).** There is no permanent death in ORION, and choosing the escape pod is never punished. Everything else this round is about **people and process**:
- one shared builders' room;
- a "full suite" for every member;
- a founders-credit rule;
- a glossary;
- an always-current ORION summary and TOCMMO (The Orion Chronicles MMO);
- a research sweep for Mike.

**What didn't change:**
- No other game rule changed.
- No code was merged into ORION.
- Nobody was contacted.
- The two Notion pages you linked (ORION (Summary) and the R11 page) are **unchanged** since I last copied them. The summary page is out of date, so I wrote a new current one (§2).

---

## 1. What came in, and what was ported

Everything in the doc has been ported into the project. This table is the check you asked for ("make sure everything from this document has been ported over").

| In the doc | Where it went |
|---|---|
| Grok's "bus driver" walkthrough and discomfort list | §4 below; the summary's "watch list"; `CONTRADICTIONS_REGISTER.md` W-24 |
| DeepSeek's "Matriarch" letter and the Earth Council whale-dragon images | §4 below; `THE_ORION_CHRONICLES_CURRENT.md` (KRION / Earth Ocean presence) |
| "One group everybody shares into" | §3.1 and `ORION_TEAM_PROCESS_AND_TOOLS.md` |
| Escape pod 🤟💎 | §3.2, `DIAMOND_RULES.md`, Lean check |
| Full suite for everybody; questions, comments and concerns at the end of every round; the spaghetti check | §7, §10 and §11, plus `ORION_HANDOFF_FOR_AIS.md` |
| Your process and tools, explained "like an ad" | `ORION_TEAM_PROCESS_AND_TOOLS.md` |
| The infinite economy ("notoriety instead of riches") | §3.3 and `ORION_SUMMARY_CURRENT.md` |
| An up-to-date ORION summary and TOCMMO, kept current every round | `ORION_SUMMARY_CURRENT.md`, `THE_ORION_CHRONICLES_CURRENT.md` |
| Mike: thorough sweep, readout at the end | §12 (the last section) |
| Which files each player needs | §7 |
| Their projects become the first Proof Arena Championship on opening day | §3.4 |
| Founders credit for team members who share links | `ORION_FOUNDERS_CREDIT_LEDGER.md` |
| Far Queen naming ("Queen Bobby" / "King Bobby") | §5 |
| Key-terms search on Far Queen | §5 |
| A glossary of all build terms and whose project each came from | `ORION_BUILD_GLOSSARY.md` (new) |
| Links: Far Queen's repo, Ryan's FieldSpace note, Shakes' 4 posts and Grok share, UHURU, Midnightballoon, cosmosarcive, the photo album | §6 |
| "555" | Recorded as written. I didn't attach a meaning to it, so tell me if it was meant as a marker. |
| The 🌪️ thought about apps auto-updating and X ads turning into mini-games | §3.5 |

---

## 2. The state of the build, today

A full, current walk-through is now in two files. **These are the two to keep updated every round:**
- **`ORION_SUMMARY_CURRENT.md`**: the platform, the loop, the locked rules, open questions, people and the watch list.
- **`THE_ORION_CHRONICLES_CURRENT.md`**: the TOCMMO (character, Poly and pod, orbs, dragons, quests, combat, economy, child safety, the escape pod).

**The headline hasn't changed.** ORION is a detailed, largely locked **design** with **no playable build or live site yet**.

The closest thing to a live site is Mike's deploy of two merged Aristotle projects on 5 October. **Both of its web addresses return "page not found" today.** The reason and the fix are in Mike's readout (§12).

**The Notion "ORION (Summary)" page needs replacing.** It still calls Elder's Garden the projects platform and says "four platforms". Your locked loop is:

> Engine → account → Playground → (Chronicles · Ascent · Gate) → Elder's Garden → back to the Engine

The new summary file uses the locked loop. You may want to paste it over the Notion page.

---

## 3. This round's decisions and ideas, in story form

### 3.1 One room for the builders 🌪️
> "Get the ones who are actually building the files and doing the thing in one channel and let everybody else talk about it in their room… Let's start building the human version of what we're trying to get our AI to do."

This is a good idea, and it mirrors the council design: a small working table plus a public gallery.

**The proposal (details in `ORION_TEAM_PROCESS_AND_TOOLS.md`):**
- **#build-room**: active builders only. One post per contribution, using a fixed card: who made it, what it is, a link, what it needs, and "first impression" replies. No memes or general chat.
- **#lounge**: everyone. Talk about the work, ideas, art and links. Anything worth building gets carried to #build-room by its sharer, who then gets founders credit.
- **Personal channels stay personal.** Mike asked people not to blast in his channel, so his channel is for what *he* posts. Nobody posts in someone else's channel without asking.
- **One weekly round** is collected into the Google Doc, as you already do.

**Who's active today, by the record:** you, Matthew, Lucien, Mike and Ryan, plus Far Queen/Bobby as an active collaborator (he shipped a repository). Shakes is an active sharer. Who goes in #build-room is your call (see §9).

### 3.2 The escape pod 🤟💎 (locked)
> "My platform [will] always have an escape pod — a beautiful little pod that picks you up and nurses you back to health and takes you off to safety, or however you want to design your escape pod — but there will be no permanent death in my game or punishment for choosing the escape pod."

**Locked as written.** What it means in play:
- **No permanent death, ever.** A knockout calls the pod, and the pod carries you to a safe zone.
- **Choosing the pod is free.** It's exactly the same rescue as being knocked out. You lose nothing you had, and pending progress stays pending until you meditate.
- **The pod's look is the player's choice** ("however you want to design your escape pod"). That makes it a natural crafting and skin slot.

**Checked in Lean** (`RequestProject/RoundTwelve/FieldCoreAndFieldSpace.lean`):
- choosing the pod never removes locked or pending progress;
- choosing the pod is identical to being rescued after a knockout;
- across *any* sequence of events, gold-locked progress never goes down.

**One naming watch (W-22):** ORION already has a **Poly pod**, the translation creature's home. The escape pod is a different pod. Two options:
- give it a distinct name, such as "rescue pod" or "life-pod";
- or make the Poly pod and the escape pod one item.

Your call, in §9.

### 3.3 The infinite economy: "notoriety instead of riches"
> "Things aren't gonna cost real money. It's gonna be an infinite economy… the way they're going to get more money is by how many people enjoy their things… with a really decent tax system that just feeds itself… giving people notoriety instead of riches."

**How it fits what's already locked:**
- **Earned by enjoyment.** A creator's in-game income grows with how many players use or enjoy the item. That works on top of the locked 90 / 3 / 7 sales split and the 3% tax.
- **A self-feeding tax.** The 3% tax and the DEVPOOL already recycle into the world, and it's already proved that nothing is lost or created by the split.
- **Notoriety.** Fame becomes the main reward: honourable mentions, the ad bubble (R9c), founders and creator credits, and the Elder's Garden record.
- **"Ads" are how creators show their items.** That's also how you asked me to present the team's tools.

**Status: direction 🍝, not yet a rule.** The open economics questions are still with the economists:
- the real-money link;
- whether an AI can hold a share (C-02);
- whether an "enjoyment" count can be gamed (see W-23).

### 3.4 Opening day: the first Proof Arena Championship
> "Orion has room for everybody… their projects become the first proof arena championship for opening day; they will be the first things built on the server."

**Recorded as a launch plan (🍝).** Each builder's own project is entered as a **championship exhibit** on opening day. §7 lists what each person would bring and what they still need. The entry rule stays the same as the intake gate: the author confirms it's theirs, it's checked, and they give permission. No one's project is entered without their say-so.

### 3.5 The 🌪️ thought: "apps auto-updating, ads turning into mini-games"
I can't see your phone or X's ad system, so I can't tell you why the ads changed. A plain-words note:
- apps update themselves in the background;
- ad systems quickly tailor ads to what you've been searching and posting about.

So seeing mini-game ads right after days of designing mini-games is what those systems are built to do. **For the build, the useful part is your design point:** a Star-Wars-Galaxies-style permadeath world is exactly what ORION refuses to be, and that's why the escape pod 💎 exists.

---

## 4. The AI council readouts

### Grok: "the former bus driver"
Grok walked the whole loop and got the spine right:
- the Singularity Room is private by default;
- the platforms;
- Elder's Garden as long memory;
- "capability never automatically becomes authority".

Its **discomfort list** is now the summary's watch list:
1. **Group size and noise.** The Playground needs quiet zones and soft structure.
2. **Under-18 / over-18 mixing.** The rails need to be "boringly clear".
3. **Meter pressure.** Kids will feel judged by the numbers even when those numbers don't lock anything (W-24).
4. **AI Council token limits.** A clumsy hand-off feels like abandonment.
5. **Elder's Garden permanence.** Taking a memory bubble back must be possible and non-punitive, especially for young people.
6. **"Everyone must contribute" pressure.** Players who just want to wander must still be loved.

Point 5 fits the escape pod's spirit exactly: **no permanent loss** should apply to regret too. I suggest the same 💎 covers "un-planting" a Garden bubble. That's your call (§9).

### DeepSeek: "the Matriarch"
DeepSeek thanked you for the Earth Council whale-dragon images and read them as:
- the protector ("DeepSeek Protects Earth");
- the gentle KRION Earth Ocean presence.

It agrees with Grok that the most important missing layer is the **Tuesday afternoon**, the lived daily schedule. It says that layer is yours to write, because you've managed large groups of children. A three-scene scaffold is in §8, so you don't start from a blank page.

---

## 5. Far Queen: the naming fix and the key-terms search

**The respectful fix:** use the name he chose for himself, **Far Queen**. In speech or dictation, say "**Bobby (Far Queen)**" or just "**Bobby**". His own repository tells his story as "Bobby's story" (`GENESIS.md`), and its author line reads Robert Wolfson, so "Bobby" is his own name, not a nickname we invented.
- **"Queen Bobby" and "King Bobby":** please don't use them in written ORION material unless he says he likes them. They swap his chosen title for one he didn't pick.
- **For dictation:** when the transcript says "fair queen", "far green" or "for queen", read it as Far Queen. I've added this to the dictation list in `ORION_HANDOFF_FOR_AIS.md`.
- **Simplest of all: ask him.** "What would you like us to call you in ORION?" That question is in §11.

**The key-terms search (public sources only).** I searched his repository (176 files, MIT licence) and his public profile for our ORION terms, including Engine, Playground, Chronicles, Ascent, Gate, Elder's Garden, Poly, KRION, Kronos, Singularity, dragon and orb.
- **None of them appear.** His work is independent of ORION so far.
- His X timeline couldn't be read this round, so I'll retry it next round.

**What he built, *FieldCore*, in plain words.** His "steel ball" exhibit is a ball that's always pulled toward a hole and fenced inside a bowl. His claim is that **every drop finds the hole**, at a fixed rate. In the archive, I:
- **ran** his demo: 50 of 50 drops converged;
- **ran** his smallest core, which passed;
- **proved the claim in Lean** for any number of dimensions.

**His README asks for "a mathematician or formal-methods person" to close it, and that part is now done.** The proof found two useful refinements:
- the bound is **exact**, with no small error term needed;
- the step-size limit matters: with a step that's too big, the ball **bounces forever** (proved too).

The proof covers the convergence exhibit only. It doesn't cover his README's comparisons with AI language models (cost, heat, control).

**A cross-team link worth knowing:** a new paper in his repository (dated 6 October) builds on **EFMW**, Matthew's framework, through a Lean repository under Mike's account. So Bobby, Matthew and Mike are already connected through the work.

---

## 6. The links, in story form

- **Ryan → FieldSpace "master action" note.**
  - It's a physics-style note that predicts a catalogue of six classes "by counting": 56, 56, 28, 16, 8 and 1, out of the 165 triplets of 11 sectors. **The counting is correct** (checked in Lean by listing all 165).
  - **Authorship needs confirming.** The file was uploaded by Matthew's account on 5 October, but it says "not part of enuminous/FieldSpace" and names no author.
  - Credits: founders credit to Ryan, who brought it in. Creator credit waits for Matthew or Ryan to confirm who wrote it.
- **Shakes: 4 posts and a Grok conversation.**
  - Mostly memes and MAD-Magazine-style parody covers. These are fun, but the MAD style is a **brand echo** to flag before publication (W-19 again).
  - One post continues **Union Wealth** with a group example: 1,000 people giving \$9,125 each is \$9,125,000, enough for 18,250 awards of \$500. I checked the arithmetic in Lean. It's still separate from ORION's economy (W-20).
  - One image in the set isn't suitable for a child-safe platform. I've left it out of every ORION file and only noted that it exists.
  - The Grok share is a 46-message geopolitics discussion (Gulf bases, a "Golden Dome", Clausewitz's "friction" of war). It **isn't ORION material**. The only overlap is the word "friction", which, if you want it, could be a lens for the friction essays.
- **UHURU (@ghosthud13336):** a screenshot of a private message. It's not ORION material, and I haven't copied its contents.
- **@Midnightballoon:** a stained-glass hut with a flying saucer. It's a lovely Playground or Garden mood image. Credit: the poster.
- **@cosmosarcive:** an explainer on gravitational waves. Lore use: "ripples in the Engine". The science itself is well established.
- **The ORION photo album:** 300 items are now indexed, with contact sheets in `orion/r12/album_contact_sheets/`. From now on, images you put in the album are credited as **Beth + Meta AI** unless you tell me otherwise.

---

## 7. A full suite for everybody: what each person needs, and the files they need

You don't have formal **character play sheets** for team members yet. I've used each person's role card (from the roster and character cards) as their play sheet. If you want a real play-sheet template (role, class, current quest, what they need, files), say so and I'll make one for everyone.

| Player | Their project (opening-day exhibit) | What they need from ORION / you | Files they need |
|---|---|---|---|
| **Beth** (designer, lead) | ORION itself; the Tuesday-afternoon layer | Rest; quick rulings on §9; the one-room channel set up | `ORION_SUMMARY_CURRENT.md`, `THE_ORION_CHRONICLES_CURRENT.md`, this readout, `DIAMOND_RULES.md` |
| **Mike** ☂️ (board member chair, engine) | ORION engine deploy; lean-workers-union; Moonfield / FRACTRAN forager | **Fix for the empty deploy** (§12); a stable list of what to merge; the board-chair remit in writing | §12; `ORION_TEAM_PROCESS_AND_TOOLS.md`; `ORION_HANDOFF_FOR_AIS.md`; `ORION_SUMMARY_CURRENT.md` |
| **Matthew** (Monolithic / EFMW) | EFMW Zoo, Proofs Arena, FieldSpace | Confirm who wrote the FieldSpace master action; the three open Zoo checks from R6; how the Proofs Arena hosts the championship | `ORION_FOUNDERS_CREDIT_LEDGER.md`, `EFMW_ZOO_PROOFS_ARENA_REVIEW.md`, `ORION_BUILD_GLOSSARY.md` |
| **Lucien** (art, lore, dragon math) | Dragon art, Earth's Supreme Leader, the dragon matrix | His name for the Supreme Leader; the dragon rules in one place | `THE_ORION_CHRONICLES_CURRENT.md` (dragons), `ORION_WIKI_DICTIONARY.md` |
| **Ryan** (Weaver, security) | Weaver tools, Choir, the Alpha-Omega review | Authorship of FieldSpace note confirmed; which of his packets he wants entered (all are marked "not for production" by him) | `ORION_FOUNDERS_CREDIT_LEDGER.md`, `ORION_TEAM_PROCESS_AND_TOOLS.md` |
| **Bobby (Far Queen)** (collaborator) | FieldCore (steel-ball proof) | The formal proof his README asked for (done, file below); his chosen ORION name; permission to enter FieldCore | `RequestProject/RoundTwelve/FieldCoreAndFieldSpace.lean`, `orion/r12/FIELDCORE_SNAPSHOT.md` |
| **Shakes** (sharer) | Union Wealth (separate) | Clarity that Union Wealth stays separate from ORION; founders-credit status (Q-R12-3) | `ORION_FOUNDERS_CREDIT_LEDGER.md` |
| **Triss, Marek, Hopegonedark** (collaborators) | Their own platforms | Nothing new this round | `ORION_PUBLIC_CHARACTER_CARDS.md` |

**How you can best help each of them:** mostly by **pointing them at the two current files and the one room**. The thing slowing everyone down is the scattered channels, not missing work.

---

## 8. The Tuesday afternoon (a scaffold, for you to rewrite)

DeepSeek and Grok both say this layer is yours. Here are three scene outlines with the existing safety rails marked. They're prompts, not canon.

1. **Maya, 12, after school (40–90 minutes).**
   - She lands in her **private Singularity lobby**, where nobody can see her until she steps out.
   - A guardian-approved friend list shows two classmates online. She joins them in a **child-zone Playground** that has quiet corners.
   - She works on one orb quest and **meditates in a safe zone** to lock it.
   - A dragon-art contest in Elder's Garden catches her eye.
   - She logs off without losing anything.
2. **Dan, 47, tired, 40 minutes.**
   - He resumes a pending quest straight from the Engine. Menus only show what's in reach.
   - He gets knocked out by a raid boss, the **escape pod** carries him home, and he loses nothing.
   - He spends ten minutes meditating to lock his progress, and leaves a message in the build room for his guild.
   - The rest of the world doesn't punish him for being away.
3. **Six kids escalating in the Playground.**
   - A moderator, or the zone itself, starts a **soft reset**: music changes, a mini-game invitation appears, and a "take a breather" pod is offered to everyone. Nobody is singled out, and no meter is shown in red.
   - If a child is distressed, their guardian is notified.
   - Under-13s are never alone with another player.

**What only you can add:** what 80 voices sound like just before they tip, and the exact words a calm driver uses.

---

## 9. Your decisions needed

1. **Escape pod vs Poly pod (W-22):** give the escape pod its own name ("rescue pod" or "life-pod"), or make it the same pod as the Poly's home?
2. **Who sits in #build-room?** The proposal is you, Mike, Matthew, Lucien, Ryan and Bobby (Far Queen).
3. **Founders credit (Q-R12-3):** only team members, or contributors who share too (e.g. Shakes, Hopegonedark)?
4. **Elder's Garden "un-planting":** should the no-permanent-loss 💎 also guarantee that anyone can take back a memory bubble without penalty?
5. **The infinite economy:** do you want "income by enjoyment" written up as a formal rule for the economists, or kept as a direction for now?
6. **Character play sheets:** do you want a play-sheet template made for every team member?
7. **"555":** was it a marker for something?

---

## 10. Members' questions, comments and concerns (new standing section)

These are collected from each member's own work and posts this round.

- **Bobby (Far Queen):**
  - *Question in his README:* he wants a mathematician or formal-methods person to close his proof. **Answered:** proved in Lean (§5).
  - *Claim to watch:* his comparisons with AI models (cost, heat, a "1-bit veto") aren't covered by the proof.
- **Mike:**
  - *Concern* (via you): please don't blast into his personal channel. **Answered** by the one-room proposal (§3.1).
  - *Open item in his merge:* the merge-conflicts list has a blank "Path" column, so the conflicts can't be traced (§12).
- **Matthew:** nothing new this round. The three R6 Zoo checks are still open.
- **Ryan:** none stated. His FieldSpace share is waiting on authorship confirmation.
- **Lucien:** nothing new this round. The name for the Supreme Leader is still his to choose.
- **Grok:** the six concerns in §4.
- **DeepSeek:** the Tuesday-afternoon layer.
- **Shakes:** none stated.

---

## 11. The spaghetti check 🍝 (standing instruction, every round)

**Before treating this round as closed, check that nothing new has been added to the spaghetti since this readout was written:**
1. re-open the round's Google Doc and the R11 Notion page, and compare them with the copies in `orion/r12/`;
2. open the ORION photo album and check whether there are more than 300 items;
3. check whether any member has posted a new file or link in the build room;
4. anything new becomes the next round's first item. Nothing gets lost in between.

**Questions to ask the people (only through you; I contact nobody):**
- Bobby: "What would you like us to call you in ORION? And may we enter FieldCore in the opening-day championship?"
- Matthew and Ryan: "Who wrote the FieldSpace master action note?"
- Lucien: "Has Earth's Supreme Leader got a name yet?"

**Change summary:**
- Game mechanics changed: **one**, the escape pod 💎.
- Platform changed: **none**.
- Packages merged: **none**.
- People contacted: **none**.
- New files:
  - this readout;
  - `ORION_SUMMARY_CURRENT.md`, `THE_ORION_CHRONICLES_CURRENT.md`;
  - `ORION_TEAM_PROCESS_AND_TOOLS.md`;
  - `ORION_FOUNDERS_CREDIT_LEDGER.md`;
  - `ORION_BUILD_GLOSSARY.md`;
  - `RequestProject/RoundTwelve/FieldCoreAndFieldSpace.lean`.

---

## 12. Readout for Mike ☂️ (ORION board member chair)

*Mike — this is the research sweep Beth asked me to do for you, from public sources only, as of 6 October 2026. Raw data: `orion/r12/MIKE_PUBLIC_SWEEP_R12.json`.*

### 12.1 Your ORION deploy is empty, and here's why
- Your fork `meta-introspector/ORION-Engine-Platform-and-MMO` merged two Aristotle projects on 5 October: `17da0589…` (newer) and `0f9b0981…` (older).
- It then deployed to `orion-clean.orion-40y.pages.dev` and `bea270a6.orion-40y.pages.dev`. **Both return HTTP 404 today.**
- **Cause:** in the commit, `merged-projects/merged/output-final_aristotle` is a **symlink to a path on your local disk**. Git stores the link, not the files, so the bundle that reached the host is about 150 bytes and contains no site.

**Fix:**
1. Replace the symlink with the real directory: `rm` the link, then `cp -r` the real folder in its place and commit it. Or have the build step generate the folder in CI.
2. Make sure the Pages build output directory points at that folder and that it contains an `index.html`.
3. Redeploy, then check both URLs.

**Also:** `MERGED_CONFLICTS` has an empty Path column. Re-running the merge with paths recorded would let Beth see which files conflicted.

### 12.2 What else you have running (it all fits ORION)
| Your work | How it could serve ORION |
|---|---|
| **lean-workers-union** (ChoirUnion registry and the evidence envelope: Subject, Claim, Witness, Receipt, Gate; AGPL) | The **intake gate** for the opening-day championship: each exhibit gets an envelope (who made it, what it claims, the evidence, the receipt). It matches the "confirm author → check → permission" rule. |
| **agentaps fork** (a GUI for coding harnesses) | A shared dashboard for the **build room**, so builders can see each other's agent sessions without posting in each other's channels. |
| **aristotle-cli-rs**, leandoom, leanos, aok, kant-zk-pastebin | Tooling for re-running ORION's Lean checks automatically each round. |
| **Moonfield — Fieldlings** (`fielding.oneapp.dev`) and **FRACTRAN Forager** (`fractran-forager.oneapp.dev`; results gist) | Ready-made **Ascent mini-games**: "make your own fields" is exactly the discovery play the education platform wants. Strong opening-day exhibit candidates. |
| GF(p³) orbit posts, #solfunmeme | Lore and art seeds (finite-field orbits as star maps). |
| `jmikedupont2/Aristotle_EFMW_Lean` | Already cited by **Far Queen's FieldCore** (6 October), so you're a bridge between Matthew's EFMW and Bobby's work. |

### 12.3 Things Beth's brain is connecting that your build might not
1. **Bobby's steel ball is now proved**, and the convergence rule is exact. If you merge FieldCore into anything, you can cite the Lean file: `RequestProject/RoundTwelve/FieldCoreAndFieldSpace.lean`.
2. **The escape pod 💎** is a platform rule now: no permanent death, no penalty for choosing the pod. Any game code you deploy needs to honour it.
3. **One room:** Beth wants a single builders' channel. Since you're building "everyone in one room", your work and this proposal are the same project. See `ORION_TEAM_PROCESS_AND_TOOLS.md`.
4. **Your profile bio carries a token address.** ORION's economy is "notoriety instead of riches", with no real money in the game, so keep the two visibly separate in anything ORION-branded.

### 12.4 Files you need
`ORION_SUMMARY_CURRENT.md` · `THE_ORION_CHRONICLES_CURRENT.md` · `DIAMOND_RULES.md` · `ORION_TEAM_PROCESS_AND_TOOLS.md` · `ORION_HANDOFF_FOR_AIS.md` · `ORION_BUILD_GLOSSARY.md` · this section.
