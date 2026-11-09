# 04. Production plan 🗺️

*Round 16, 7 October 2026. A proposal for the team to adjust, not a schedule anyone has agreed to. There are no dates on purpose: this is a volunteer team, so the plan is ordered by **what has to happen before what**. Put dates on it together once roles are named.*

## The principle: small, playable, then bigger

Big online worlds are built by first making **one small piece that people can actually play**, learning from it, and growing outwards. Trying to build all eight places at once is the most common way volunteer game projects stall. So the plan has one aim at a time.

## Milestones

### M0. Get organised ("the Engine room")
**Goal:** everyone knows who does what and where the files are.
- [ ] Name five roles (people can hold more than one; see `05_HOW_GAMES_GET_MADE.md` §2):
  - **Producer / creative director:** Beth (vision, decisions, the yes/no on design).
  - **Tech lead:** one of Mike, Matthew, Lucien or Ryan.
  - **Art lead.**
  - **Community and safety lead.**
  - **Education lead** (for the Ascent).
- [ ] Create **one shared ORION GitHub organisation or repository** (tutorial T03). This project's files can go into it.
- [ ] Agree a weekly rhythm: one short check-in (a call, a thread or a doc), and one shared task board (GitHub Projects, Trello or a simple doc).
- [ ] **One hour with a lawyer about contributor agreements** (who owns what each person makes). Do this before much code or art is made.
- [ ] Album clean-up: remove the six geotagged photos and #1348 (T01).

**Done when:** roles are named in `ORION_RUNNING_ROSTER.md`, the repo exists, and the dev team can see it.

### M1. Decide ("the Gauntlet of choices")
**Goal:** enough decisions to build the first piece.
- [ ] Beth answers the 15 blocking decisions (`03_HAVE_VS_NEED.md` §3), at least #1–#5.
- [ ] Dev team picks the **game engine** and the **first platform** (suggestion: web or desktop first, single-player, no accounts).
- [ ] Write a one-page **art bible** for the slice: colours, fonts, the UIAR look.
- [ ] Turn the slice's rules into **acceptance tests** ("when a player does X, Y happens"). The Lean models already cover several (launch path, capstone, UIAR safety cap).

**Done when:** a one-page "slice spec" is agreed and 💎 by Beth.

### M2. The vertical slice ("first light")
**Goal:** a 10–15 minute playable piece that shows what ORION *feels* like.

Suggested slice (from the locked first-day walkthrough):
1. **The Engine:** a welcome screen with the credits and a "begin" button.
2. **The Singularity:** step out of the black pod; arrange a simple HUD.
3. **Elder's Garden:** walk to the Ren Fair commons; meet one mentor.
4. **One training-ground station:** play **Rat Slap** (cards) or **Greedy** (dice) against a computer player.
5. **A life-bubble** appears on the tree when you finish.

- [ ] Placeholder art is fine. Use album art only where its creator agrees.
- [ ] No real biometric data, no chat, no accounts, no children's data.

**Done when:** five people outside the core team have played it, and someone wrote down what was fun and what was confusing.

### M3. Playtest and fix ("the Proving Grounds")
- [ ] Two or three rounds of small playtests with adults, with a short survey each time.
- [ ] Fix the top problems; cut what isn't fun.
- [ ] Record a 30–60 second clip (`FREE_VIDEO_EDITING_GUIDE.md`).

### M4. Show it ("ORION's Gate opens a crack")
- [ ] A simple public page on the ORION Engine with the clip, the summary (02) and how to get involved.
- [ ] Use the prototype to approach partners and funders (`COLLABORATOR_PRODUCTION_PROPOSALS.md`).

### M5. Grow ("the Playground")
- [ ] Accounts and a small multiplayer space (the Playground) with the spam filter and moderators.
- [ ] **Before any under-18 player:** legal and trust-and-safety review of `ORION_UNDER18_STRUCTURE.md`, guardian verification, reporting tools, named moderators.

### Later
The Chronicles MMO, the Ascent curricula, ORION's Gate councils, UIAR, mobile and consoles. Each one gets its own small slice first.

## Who does what (a starting suggestion)

| Area | Lead (suggested) | Help |
|---|---|---|
| Vision, rules, story, the 💎 | Beth | everyone |
| Engine choice, repo, prototype code | the dev team's chosen tech lead | Mike, Matthew, Lucien, Ryan |
| Rule models and tests | Matthew, Mike (Lean experience) | Aristotle |
| Art bible, assets | an art lead (Lucien and Triss have art interests) | Meta AI drafts, artists |
| Music and sound | Beth (buses), a volunteer music lead | Lu's links |
| Community, Playground rules, moderators | a community lead | Bobby, Marek |
| Education (Ascent, Nepal Spark Academy) | an education lead | Bobby, educators |
| Safety, privacy, legal | a safety lead + outside lawyer and expert | — |

**Everyone should confirm their own role.** These are suggestions from the files, not assignments.

## Risks to watch

- **Scope creep:** new ideas arrive every round. Keep a "later" list and protect the slice.
- **Volunteer fatigue:** small wins keep people going. Celebrate each milestone in Elder's Garden style.
- **Ownership confusion:** fix with contributor agreements early.
- **Safety:** never let a feature that involves children go ahead of its safety review.
