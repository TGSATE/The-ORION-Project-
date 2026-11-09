# 03. What we have versus what we need 📦

*Round 16, 7 October 2026. This builds on the 20-piece production list in `COLLABORATOR_PRODUCTION_PROPOSALS.md` §8 (Round 13) and updates it.*

**Key:** ✅ have it · 🟡 started / partly there · ❌ missing. **Priority:** P1 = needed before a prototype, P2 = needed before anyone outside the team plays, P3 = later.

## 1. The outline

### A. Vision and design

| Piece | Have | Need | Priority |
|---|---|---|---|
| Vision / pitch | ✅ Manifesto, one-page pitch, X thread blurbs, `02_GAME_SUMMARY.md` | Keep current | — |
| Game design document (GDD) | ✅ Manual, summary, Chronicles, lore codex, diamond rules | **One combined, versioned GDD** with a table of contents; retire the outdated pages | P1 |
| Rules for the first playable piece | 🟡 Locked first-day walkthrough; Rat Slap; Greedy typed this round | Beth's check of Greedy (G-1–G-5, GG-1–GG-6); written acceptance tests | **P1** |
| Narrative bible | 🟡 Codex, storylines, Chronicles, character sheets | One canon file with a timeline; decisions N-2, N-3, N-5, N-6 | P2 |
| Open decisions | 🟡 Register with 106 rows | The 15 blocking rulings in §3 | **P1** |

### B. Art, audio and video

| Piece | Have | Need | Priority |
|---|---|---|---|
| Concept art | ✅ 1,384-item album; 11 concept-art clips | Sort into "canon / draft / reject"; record prompts | P2 |
| Art bible | 🟡 Prompt library style sections | Logo, colour codes, fonts, do's and don'ts, one page per place | P1 |
| Game-ready assets (models, sprites, UI) | ❌ | Made in the chosen engine, by artists, with written ownership | P1 for the slice only |
| Music and sound | 🟡 Moodboard playlists (57 Spotify / 62 YouTube) | **Licensed or original** music for anything in-game; sound effects. A playlist link isn't a licence | P2 |
| Trailers / clips | 🟡 Concept-art clips | A 30–60 second clip of the prototype | P2 |

### C. Technology

| Piece | Have | Need | Priority |
|---|---|---|---|
| Game engine choice | ❌ | Pick one with the developers (Godot is free and open source; Unity and Unreal are free to start, with revenue terms) | **P1** |
| Code repository | 🟡 This project is in git; members have their own GitHub repos | **One shared ORION repository** the whole dev team can see (tutorial T03) | **P1** |
| Prototype code | ❌ | The vertical slice (04, milestone M2) | **P1** |
| Rule models | ✅ 700+ Lean theorems on written rules | Turn the key ones into automated tests for the real code | P2 |
| Accounts, logins, servers | ❌ | Later; the first prototype can be single-player, offline | P3 |
| Spam filter | 🟡 Written rule reviewed; gaps found (M-4) | Implemented filter + tests | P2 |

### D. People and process

| Piece | Have | Need | Priority |
|---|---|---|---|
| Team | ✅ Four admins, three contributors, many leads | **Named roles** (producer, tech lead, art lead, community lead, safety lead) | **P1** |
| Way of working | ✅ Beth's annotate-and-return loop (T04) | A weekly rhythm: one short call or post, a shared task board | P1 |
| Credit | ✅ Founders' credit ledger | Keep updated with each contribution | ongoing |
| Communication calls | 🟡 DEV-call icon idea (T05) | Members choose their icons | P2 |

### E. Safety, legal and money

| Piece | Have | Need | Priority |
|---|---|---|---|
| Child-safety design | ✅ Detailed (`ORION_UNDER18_STRUCTURE.md`) | **Review by a lawyer and a trust-and-safety expert before any child signs up** | P2 (before any outside player) |
| Privacy | 🟡 Location data removed from project copies | Album clean-up (T01); a privacy policy before launch | P1 for the album |
| Legal set-up | ❌ | Company or project entity; **contributor agreements (who owns what)**; trademark checks. A lawyer, not an AI, should advise | P1 for agreements |
| Funding | ❌ | Options once there's a prototype: grants, crowdfunding, publishers, sponsors. No promises of income to anyone | P2 |
| Age rating, platform rules | ❌ | Before store release | P3 |
| Accessibility | ❌ | Captions, colour-blind palettes, dyslexia-friendly fonts, remappable controls, built in from the start | P2 |

## 2. The short version

**You have:** a big, careful design; a lot of art; a team; rule models; a working way of writing things down.

**You're missing, in this order:**
1. **15 decisions** (§3).
2. **An engine choice and one shared code repository.**
3. **A tiny playable piece.**
4. **Contributor agreements** (one hour with a lawyer).
5. **An art bible.**
6. **Safety and privacy review**, before anyone outside the team plays.

## 3. The 15 decisions that block production

These come from the register. The rest of the 106 rows can wait.

| # | ID | Decision | Why it blocks |
|---|---|---|---|
| 1 | F-4 / M-3 | Lock the launch path (Engine → Singularity → Garden → Playground → …)? Which parts can be skipped? | The prototype *is* this path |
| 2 | C-03 | Separate names for the three "Singularities" (home hub, sealed child room, third idea) | Code needs one name per thing |
| 3 | G-1–G-5, GG-1–GG-6 | Confirm the Greedy and Greedier Greedy rules | They're the first mini-games |
| 4 | R-1, R-2 | Rat Slap online fairness and the false-slap penalty | Same |
| 5 | C-06 / O-3 | Kronos / KRION / Orion: energies (this round's music buses suggest energies) | Used everywhere in the UI |
| 6 | C-05 | Level 65: rider, hatchling or dragon? | Progression system |
| 7 | C-07–C-10 | The Poly: one or many, where it lives, spying range, worker pods versus earpiece | Core companion system |
| 8 | N-2 / N-3 | Pod stages and the name "Golden Poly Orb" | Same |
| 9 | C-11 | "13 levels" means three different things | Progression and UI |
| 10 | C-12 | Copilot privacy versus copilot renting | Privacy design |
| 11 | M-4 | Spam filter: adopt the sliding-window proposal? | Playground rule 💎 needs a working filter |
| 12 | M-8 | Adult-content age line (18+ or 25+) | Safety design |
| 13 | E-2 | Is it "ORION Engine Inc." or not? | Legal set-up, art text |
| 14 | M-7 | Developer seats: how does someone earn one? | Team formation |
| 15 | J-6 | Ryan's role | Team formation |

**How to answer:** in your next annotated doc, write the ID and your answer (for example "C-03 💎 Singularity = home hub; Sanctuary = child room"). I'll update everything else.
