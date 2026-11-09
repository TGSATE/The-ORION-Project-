# ORION team process and tools — "the human version of what we want our AI to do"

*Round 12, 6 October 2026. Beth asked for three things:*
- *one shared channel for the people actually building;*
- *her process written out, so anyone who wants to use it can;*
- *each member's tools explained "like an ad". Nothing here costs real money; it's notoriety, not riches.*

*This is a **proposal** until Beth rules on it. Nobody has been contacted.*

---

## 1. The rooms

| Room | Who | What goes in | What doesn't |
|---|---|---|---|
| **#build-room** | Active builders. Proposed: Beth, Mike, Matthew, Lucien, Ryan, Bobby (Far Queen). Beth decides. | One **contribution card** per piece of work (template below), plus replies to cards | Memes, general links, long chat |
| **#lounge** | Everyone in the group (about 15 people) | Talk, art, links, ideas, reactions, questions | Files for merging (carry them to #build-room) |
| **Personal channels** | Each owner | Whatever the owner posts | Posts from others unless the owner asks. Mike has asked for this. |
| **The round doc** (Google Doc / Notion) | Beth | The round's collection, which Aristotle reads | — |

**The carry rule:** if something in #lounge should be built, the person who found it posts a card in #build-room. They get **founders credit** and the maker gets **creator credit** (see `ORION_FOUNDERS_CREDIT_LEDGER.md`).

### The contribution card (copy and paste)
```
WHO MADE IT:      (name / handle — the maker, not just the poster)
SHARED BY:        (if different — gets founders credit)
WHAT IT IS:       (one line, plain words)
LINK / FILE:
TYPE:             code · art · text · lore · tool · question
WHAT IT NEEDS:    (review, a test, a ruling, a home in ORION, nothing)
PERMISSION:       may ORION use it?  yes / ask first / no
FIRST IMPRESSION: (replies: one line each, right away, "before they're lost")
```

This is the same thing the AI council is designed to do: a clear handoff packet, a named author, and no work that silently takes authority over anyone else's.

---

## 2. Beth's process (anyone may use it)

1. **Collect everything in one stream.** Voice-dictate into the round doc, paste links, and drop photos into the ORION photo album. Don't stop to label everything.
2. **Mark with emoji:**
   - 💎 lock;
   - 👍 approve;
   - 🤟 "yes, love it";
   - 🌀 instruction to Aristotle;
   - 🌪️ "find the discrepancies";
   - ☂️ for the coders and for Mike as board chair;
   - 🍝🧠 "plain-words story, please";
   - ⏭️ carry forward.
3. **Send the round to Aristotle.** It reads every link, archives copies with checksums, checks what can be checked (and proves rules in Lean where it can), and writes:
   - a narrative readout;
   - updated summary and TOCMMO files;
   - updated registers.
4. **Reply inline.** Beth types answers right after the line they answer, and that becomes the next round.
5. **Nothing is locked until Beth 💎s it.** Metaphors (spaghetti, toroids, friction) are turned into plain rules and shown back first.
6. **Every round ends with:**
   - each member's questions, comments and concerns;
   - the decisions needed;
   - the **spaghetti check**: "has anything new been added since this readout?"

**Members are welcome to explain their own process the same way.** Add a section 4 entry below.

---

## 3. The tools, presented like ads 📣

> Each ad says what the tool does and what it's good for in ORION. Claims are the makers' own unless marked "checked". Nothing here is endorsed for production.

**🧠 Aristotle (Harmonic) — Beth's reader and checker**
*"Paste your round. Get back the story, the open questions and proofs."* Reads links and documents, keeps an archive, writes the readouts, and proves written rules in Lean (a proof assistant). *Checked:* every Lean file in this project builds. Good for: rulings, consistency checks and the always-current summary.

**🤖 The AI Council (Grok, DeepSeek, Gemini, Meta AI, ChatGPT…) — perspectives on tap**
*"Need a bus driver's eye or a matriarch's heart? Ask the council."* Grok gives narrative walkthroughs and discomfort lists. DeepSeek gives readouts on care and safety. Meta AI makes images (Beth's concept art). Good for: viewpoints and art, but they aren't sources of truth.

**🧰 lean-workers-union (Mike) — receipts for every claim**
*"Every contribution, one envelope: Subject, Claim, Witness, Receipt, Gate."* A registry and a portable evidence envelope (AGPL). Good for: the opening-day championship's entry desk.

**🖥️ agentaps (fork by Mike) — every coding agent in one window**
*"Nested agent sessions, split panes, one GUI."* Good for: seeing the build room's agent work without channel spam.

**🌙 Moonfield & 🔢 FRACTRAN Forager (Mike) — make your own fields**
*"Discover finite-field orbits as play."* Live at `fielding.oneapp.dev` and `fractran-forager.oneapp.dev`. Good for: Ascent mini-games.

**🕸️ Weaver tools (Ryan) — the security and continuity loom**
*"Receipts, replays and tamper checks for everything you ship."* Choir Architecture, Bounded Receipt Runner, Weaver Core and the Loom. *Checked in earlier rounds:* their own test suites pass. Ryan marks them all "not authorized for production". Good for: lore continuity and audit trails.

**🦁 EFMW, Monolithic Zoo, Proofs Arena (Matthew) — the arena where ideas are tested**
*"Bring your claim; the Zoo checks it."* EFMW is Matthew's process ontology of recursive emergence, with Lean "zoo" catalogues. Good for: hosting the Proof Arena Championship.

**⚙️ FieldCore (Bobby / Far Queen) — the steel ball that always finds the hole**
*"Deterministic, no noise, every drop converges."* *Checked:* the demo runs (50/50 drops). The convergence claim is **proved in Lean** (`RequestProject/RoundTwelve/FieldCoreAndFieldSpace.lean`). The README's comparisons with AI models aren't covered. Good for: an engine-physics exhibit.

**🐉 Dragon math and art (Lucien) — the cosmic artist**
*"Dragons, done with numbers."* Art, lore, the dragon matrix and Earth's Supreme Leader. Good for: dragons, factions and mascots.

**📸 The ORION photo album (Beth) — one place for every image**
*"Drop it in, it's archived."* 300 items as of Round 12. Good for: concept art and the source of loading screens.

---

## 4. Members' own process notes

*(Empty. Members can add "how I work" here, in the same plain style.)*

## 5. Beth's process, Round 13 (suggestions, not rules)

> "Let's keep track of all of Orion rules, processes and instructions … I can't make them follow these. This is just my process. I'm offering it to them if they find it helpful, so no rules or anything. Just: hey guys, try this." (doc line 47)

- **Take your packet:** `ORION_MEMBER_PACKETS/<YOUR NAME>.md` lists just your files.
- **Answer the AI-setup question** in your packet, so Beth can design a dashboard.
- **Tornado / spaghetti sessions:** have your AI end its run with *"Would you like to join a tornado session for ORION? If yes, compile your notes back to Beth."*
- **Images from X can't be saved by Beth.** Drop them in the shared media, or share an album link (public or private).
- **👿 on a post** means Beth has downloaded it and its creator gets credit.
- **Keep prompts and outputs separate:** prompts in one file, AI outputs in another, so anyone can reuse the prompts with their own art (`ORION_IMAGE_PROMPTS_BETH.md` / `ORION_IMAGE_READOUTS_META_AI.md`).
- **Tag who's talking** in shared docs ("Me" / "Meta" / "Ari"), so readouts can be sorted.

## Round 14: access seats and team autonomy (new proposal, not a rule)

Beth proposed that teams restrict **developer seats** to accepted collaborators who demonstrate value **and contribute to that team's GoFundMe**; she mentioned an existing ORION campaign aiming at $50,000 for equipment (`orion/r14/GOOGLE_DOC_ROUND14_ARI_normalized.txt`, line 8). This is a **proposal to ask the teams**, not proof that a team accepted it; no money was requested, transferred or collected here, and nobody set up a fundraiser. An ability to donate cannot stand in for a security review, competence or creator credit. The member who made useful work keeps credit even without an access seat. Ask Beth and each team to specify which roles require technical access, who controls credentials, contribution criteria, the accessibility/affordability exception, voluntary financial support and budget oversight. Do not tie an under-18 developer's permissions to donations. The donation, if any, should never grant rights over others' accounts.

Beth confirmed **Matthew** is responsible for decisions within his Proof Arena and Zoo team (doc line 309); that delegation does not silently override child-safety rules or launch a live service. **Brianna** is provisionally the visual-learning “Spiral Operator” trying the Ghost Writer/Rider practice (line 310); ask her before locking that role or publishing a job description. Existing packets remain suggestions, not commands. For the Loop/Spiral practice, keep original inputs, AI replies and Beth's inline 🌀 corrections distinguished (`GHOST_WRITER_IN_THE_MIRROR.md`).
