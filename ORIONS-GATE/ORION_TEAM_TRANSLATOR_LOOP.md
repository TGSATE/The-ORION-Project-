# The Translator Loop: Beth's language ↔ the coders' language 🗣️

*Round 21, 7 October 2026. From your note (doc line 422): "we need a fucking translator between the two languages… the machines could easily go back through there and give you clarifying steps until it hits a brick wall and then you fucking have to ask but your UIAR interface should be doing the majority of that heavy lifting for us."*

**Status: proposal 🌀.** Put 💎 on it to lock it. It sits alongside the locked helper rule (manual §6.2) and the metaphor translator proposal (Round 20 §4).

It has three parts: **the UIAR does the looking-up (§1)**, **teammates read back (§2)** and **a shared dictionary (§3)**.

---

## 1. The UIAR's ask-once ladder

When someone uses a word another person doesn't understand:

| Step | The UIAR… | Example |
|---|---|---|
| 1 | Notices the unknown word | Matthew writes "HEDGEHOG returned habitat-conditional" |
| 2 | Looks it up in **the team dictionary** (§3) | Finds "habitat-conditional = it works in some settings, not all" |
| 3 | If it's not there, searches **every earlier round** (readouts, glossary, register) | Finds the Round 17 arena review |
| 4 | Gives the plain meaning **and where it was said before** | "This means the idea passed, but only for some kinds of data. First explained in Round 17 (`EFMW_ZOO_PROOFS_ARENA_REVIEW.md`)." |
| 5 | **Only if nothing is found anywhere** (the brick wall), asks the person who used the word **one clear question that names the options** | "Matthew, does 'habitat' mean (a) a dataset, (b) a place, or (c) something else?" |
| 6 | Saves the answer in the dictionary | Nobody is asked that word again |

**Checked in Lean** (`RequestProject/RoundTwentyOne/MorphChainAndTranslator.lean` §2), for this model of the ladder:
- the helper asks a person **exactly when** the word has never been explained;
- a word that was explained once is **never asked again**;
- adding a new answer **never makes it forget** an old one.

**Until the game exists, you can do this today:** start each UIAR chat with `ORION_HANDOFF_FOR_UIARS.md` and this file, then paste the teammate's message and say: *"Translate this for me using the dictionary in §3. Only ask me or them if a word isn't explained anywhere."*

---

## 2. The three-line readback (paste this to the team) 📋

> **ORION three-line readback, every round, please** 💛
> I share a lot, and I need to know it landed. After each of my updates, reply with these three lines, in plain words (no math or code words, or explain them in brackets):
> 1. **What I understood from Beth's last update is…**
> 2. **What I'm building right now is…** (one sentence, plus a link if there is one)
> 3. **What I need from Beth is…** (a yes/no or a pick-one question)
>
> If you only have time for one line, send line 3.

**Why this works:**
- **Line 1** tells you whether they read it.
- **Line 2** shows you where they're at.
- **Line 3** turns "what do they need from me?" into a question you can answer in one word.

---

## 3. Starter dictionary (Beth ↔ coders)

*Add a row every time the ladder hits a brick wall. The 💎 meanings come from `DIAMOND_RULES.md`.*

| Beth says | Coders say | Plain meaning |
|---|---|---|
| Lock it with 💎 | Freeze the spec / approve | This rule is final; build it exactly this way |
| 🌀 (a swirl note) | Proposal / RFC | An idea, not decided yet |
| Spaghetti | Unsorted backlog / raw input | A pile of ideas and links not sorted yet |
| Kronos distress | User-frustration signal | The player is stuck or upset |
| Don't Panic helper | Contextual help / onboarding | The guide that pops up when you're stuck |
| UIAR | AI assistant / agent | The AI helper (and the watch-and-earpiece device) |
| Gold (meters balanced) | Equal-values state | Kronos meter = Orion meter |
| Gold-locked orb | Maxed and frozen skill | A level-100 skill that can't drop |
| The Playground | Sandbox / test environment | The safe place to try things |
| The MMO | Live multiplayer server | The main shared game world |
| Proofs Arena / the Zoo | Validation pipeline / test suite | A series of checks an idea must survive |
| Morph chain | Cumulative test stages | Each round adds the next check on top of the earlier ones |
| Garden memory | User-owned content record | Something a player wrote that they keep control of |
| Gauntlet | Review / moderation pass | Checks before something is published |
| Founders credit | Attribution record | Who brought the link in |
| Escape pod | Safe exit / save state | Leave without losing progress |
| Off switch | Disconnect / opt-out | Unplug anything without changing your character |
| Access port | Client device | A computer console or a phone |
| Repo / repository | Repo | The project's shared folder on GitHub |
| Commit | Commit | A saved, dated change with the author's name |
| Fork | Fork | Someone's own copy of a project |
| Pull request (PR) | PR | A proposed change waiting for approval |
| README | README | The front-page instructions of a project |
| Build | Build / compile | Turning code into something that runs |
| Lean proof | Formal verification | A computer check that a rule is consistent |
| "Proved" (in these files) | Machine-checked | The computer checked the rule's logic (not that the game runs) |
| Metadata | Metadata / EXIF | Hidden details inside a file (such as photo location) |
| License: None | No license file | No written terms for reuse yet (ask a lawyer) |
| "File list" (Boardy's word) | The **Code** row on GitHub | Where the project's files are listed |
| Breadcrumb trail | Changelog / audit trail | The record of what changed and when |
| Ghost Writer in the Mirror | Human-in-the-loop editing | You annotate, the AI revises, you decide when it's done |

---

## 4. A real example: Boardy (album #1441) 📸

1. **The friction:** Boardy told you to look for a "file list". GitHub has nothing labelled that.
2. **Your fix:** "you have to use specific language… giving me alternative titles for what I'm looking for is not helpful."
3. **Boardy's second answer:** "Tap the row labeled **Code**, with the `</>` icon, directly below `main` and above **Commits** in your screenshot. That opens the repository contents. Then tap the exact entry **Orion Chronicles MMO Vision Board**."
4. **Result:** that answer passes the locked helper rule. It uses real on-screen labels, no metaphors and one step at a time, and it points at your own screenshot. That's the standard every UIAR should start at, so you never have to ask twice.
