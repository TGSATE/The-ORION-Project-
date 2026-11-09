# 05. How games get made: a guide for non-coders 🛠️

*Round 16, 7 October 2026. General knowledge about game development, written for Beth ("girl around to game development", as dictated, which I've read as "getting around game development") and anyone else new to it.*

## 1. The stages

| Stage | What happens | ORION today |
|---|---|---|
| **Concept** | The big idea, the feeling, who it's for | ✅ Done, many times over |
| **Pre-production** | Design documents, art style, choosing tools, a tiny prototype to test the fun | 🟡 **We are here.** Lots of design; no prototype yet |
| **Vertical slice** | One short, polished, playable piece that shows the final quality | ❌ Next (04, M2) |
| **Production** | Building the full game, piece by piece, in short cycles | ❌ |
| **Alpha** | Everything is in, but rough and buggy | ❌ |
| **Beta** | Mostly finished; outside players test it | ❌ |
| **Launch** | Released to the public | ❌ |
| **Live operations** | Updates, events, moderation, fixing things, for as long as it runs | ❌ (big for an MMO) |

Most teams work in **short cycles (sprints)** of one or two weeks: pick a few tasks, build them, show them, adjust. That fits a volunteer team well.

## 2. The roles

One person can wear several hats. A small team usually has:

| Role | What they do | Words you'll hear |
|---|---|---|
| **Creative director / game designer** | Decides what the game *is*; writes the rules; says yes or no | GDD, mechanics, core loop |
| **Producer** | Keeps the plan, the task list and the people moving | roadmap, milestone, sprint, backlog |
| **Programmer / engineer** | Writes the code | repo, commit, bug, build, merge |
| **Technical artist / artist** | Makes the look: characters, places, menus | assets, sprites, models, art bible |
| **Writer / narrative designer** | Story, dialogue, lore | narrative bible, canon |
| **Sound designer / composer** | Music, effects, voices | SFX, licensing |
| **QA / playtester** | Plays to find bugs and boring bits | bug report, repro steps |
| **Community manager / moderator** | Looks after players and their safety | code of conduct, reports |
| **Trust and safety** | Protects players, especially children; privacy | moderation, compliance |

**Beth's natural roles:** creative director and community builder. The project already treats her 💎 as the design authority.

## 3. Words you'll meet (mini dictionary)

- **Core loop:** the thing players do again and again (in ORION's first day: explore → train → celebrate).
- **GDD (game design document):** the master description of the game.
- **Prototype:** a rough, playable test of one idea.
- **Vertical slice:** a short, polished piece at final quality.
- **Engine:** the software you build a game in (Godot, Unity, Unreal). Not the same as the "ORION Engine", which is the name of your welcome page and whole system.
- **Repository (repo):** the folder of code and files on GitHub, with its full history (T03).
- **Commit:** a saved change, with a note saying what changed.
- **Branch / pull request (PR):** a separate copy to work on, and the request to merge it back after review.
- **Build:** a runnable version of the game made from the code.
- **Bug:** something that doesn't work as intended. A good bug report says what you did, what you expected, and what happened.
- **Backlog:** the list of everything not done yet.
- **Asset:** any piece of art, sound or text used in the game.
- **Placeholder:** temporary art or text, swapped out later.
- **Playtest:** watching real people play, without helping them.
- **Scope:** how much you're trying to make. "Scope creep" is when it keeps growing.

## 4. How the ORION team can work week to week

1. **Monday:** the producer posts the week's 3–5 tasks on the board.
2. **During the week:** people pick tasks, work on their own branch, and open a pull request when done.
3. **Friday:** a short show-and-tell; Beth gives 💎 / 🤟 / 🌀 on design questions.
4. **Every few weeks:** Beth's annotated doc goes through Aristotle for the big cross-check (T04), and this guide gets updated.

## 5. How Aristotle fits

- **Reads and cross-checks** everything you send (docs, links, code, images) against the project, and writes it down.
- **Builds and reviews public code** the devs share (T03).
- **Checks written rules mathematically** in Lean (voting, spam filters, game rules), which can catch contradictions before they're coded.
- **Doesn't:** contact team members, post anything, spend money, give legal advice, or claim a feature works when it isn't built.
