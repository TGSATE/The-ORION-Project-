# Contributor code status, Round 20 🧑‍💻

*7 October 2026. I checked everything below myself today. Plain English, one section at a time.*

You asked for three things: (1) flag everyone who has contributed without dropping files, (2) take the public code people have shared and explain in plain English what it does to gameplay and the player, and (3) give you a ☢️ notice and a "current state of the build" request you can send.

**One limit up front:** I can only see code people have made **public on GitHub**. Other people's Aristotle projects are private to them, so I can't open them. I also can't push anything into anyone else's system. What I *can* do is write the notice for you to post (§5).

---

## 1. The short answer

- I re-checked **173 GitHub repositories** linked to the team. None has changed since Round 17 (list: `orion/r20/REPO_WATCH_R20.tsv`).
- I downloaded the **55 repositories the team members own themselves** and searched every file in them (yours 2, Matthew 33, Mike 8, Bobby 12), and read the READMEs and main code of the game-like ones (results: `orion/r20/CONTRIBUTOR_REPO_SCAN_R20.tsv`).
- **Not one file in a teammate's own repository is about your ORION.** The only time "ORION" appears is on Matthew's `medium` website, and that's the delivery company UPS's route-planning system, which has nothing to do with your game.
- Some teammates have built **real, runnable things**. They just aren't ORION. Details in §3.
- **Their stuff is now in your project too:** the front page (README) of every one of those repositories, plus the exact version I read, is saved in `orion/r20/contributor_readmes/` (`COMMITS.txt` lists the versions). I didn't copy whole repositories: Matthew's blog alone is over 1,000 files. The links take you to the full code.
- **Mike's copy of your GitHub repository** is the only place outside this project where ORION code exists. Details in §4.

---

## 2. Everyone, flagged

| Person | Has dropped code or files for ORION? | What they *have* given | Flag |
|---|---|---|---|
| **Beth (you)** | Yes: the GitHub repo (4 design files) and this project | Vision Board, all design | — |
| **Ryan (@ArchitectWeaver)** | **Yes:** ZIP packages in Rounds 5–9 | Gameplay packages | ✅ contributed files |
| **Mike (meta-introspector)** | **Partly:** a copy of your repo with a website added (§4) | Tools for working with Lean and Aristotle | ✅ but the website doesn't load (§4) |
| **Matthew (enuminous)** | **No ORION files** | 33 public repos of his own physics, math and game prototypes | 🚩 no ORION drop |
| **Bobby (the-far-queen)** | **No ORION files** | 12 public repos, including a game "gate" pipeline and a Godot avatar | 🚩 no ORION drop |
| **Miss T (Trista)** | **No.** Nothing uploaded to the album or GitHub | 40 X posts of art and esoteric charts | 🚩 no files dropped |
| **Marek** | **No code.** Posted one register in Round 8 | Ideas and a register | 🚩 no code |
| **Lucien** | **No code** | Art only | 🚩 art only |
| **Shakes** | **No code** | Shares links | 🚩 links only |
| **Brianna** | **No code** | — | 🚩 no code |
| **Dane / Geminatrix** (wider roster) | 6 public repos, **none is ORION** | Their own projects | 🚩 no ORION drop |

**Your policy, written down as you said it:** *"I won't share in groups whose members don't share code, and they will be removed."* I've put it in the ☢️ notice in §5. Whether and when to remove someone is your call; I haven't removed anyone from anything.

---

## 3. What each teammate's public code does, in plain English

For each one: what it is, whether it runs, and what it would mean for **gameplay and the player** if it were brought into ORION.

### Matthew (enuminous), 33 repos
| Repo | What it is | Runs? | What it would mean for ORION's gameplay and the player |
|---|---|---|---|
| **Archimedes-Field-Lab** | A "playable prototype": a first-person 3D lab you walk around in and build puzzles | Yes, in a browser | The closest thing on the team to an ORION **walk-around world**. A player could walk, pick things up and do physics puzzles. It isn't ORION art or rules |
| **Archimedes-3D** / **Archimedes-Engine** | A small simulated room: a few computer "agents" move through a field around obstacles | Yes, in a browser | Could be a starting point for **non-player characters** that move on their own. There are no players or quests |
| **Borges-Library-CollapseOmega** | A walkable library in the browser. You type a title and a question, and it builds a room of text that changes with your choices | Yes, in a browser | A model for a **story room** or a quest that branches on your choices. Very close to how a Library or Codex zone in ORION could feel |
| **simself** | Python code for an "identity that persists and recovers" | Yes, as Python | The idea matches ORION's "your character is never lost" rule. It isn't connected to any game |
| **EFMW-…, Zoo, Nightengale, Woodpecker, Chimera, FieldSpace, …** (about 20 repos) | His own physics theory (EFMW), with Lean proofs and test plans | Proofs and scripts | **Nothing for gameplay.** This is his research, not the game |
| **Alchemy-of-Emergence, Avenue5, Verbinski-Protocol, Backrooms** | Book and film analysis written as math | Text and math | Nothing for gameplay. It could inspire lore |
| **medium / Medium2** | His blog site (about 1,000 files) | Website | Nothing for ORION. This is where the unrelated "UPS ORION" mention is |

### Bobby (the-far-queen), 12 repos
| Repo | What it is | Runs? | What it would mean for ORION's gameplay and the player |
|---|---|---|---|
| **simself** (his copy) | Same project as Matthew's, plus **Godot game-engine files** (`AvatarController`) | Python runs. The Godot part needs Godot | A **Godot avatar controller** is a real game piece: it moves a character. If ORION chooses Godot, this is the nearest thing to a usable part |
| **far-games** | A "gate" that checks a game design before it's accepted: does it name a mechanic, a source, a royalty mode, and avoid banned things like ads and microtransactions? | Yes, Python | Could protect ORION's **no ads / no microtransactions** rule. **But it has a hole** (below) |
| **far-art, far-film, far-music, far-writing, far-law, far-medicine, far-mysteries, far-apps** | The same kind of gate for art, film, music, writing, law, medicine and esoteric topics | Python | Content checking for the team's pipelines. Not gameplay |
| **fieldcore** | Theory: "a ball on a curved surface always finds the hole" | Documents | Lore and inspiration only |
| **sunrise-startup** | The public face of his media company | Documents | None |

**🐞 The far-games hole (I proved it in Lean, and you can check it yourself):** the gate blocks a banned word only when **that exact word** appears in the text. Bobby's own example lists the banned words `microtransactions`, `ads` and `always_online`. It then tests the text *"buy gems and coins to unlock more levels"*, with the comment "verify banned motif is caught". That sentence **is** a microtransaction, but none of those exact words is in it, **so the gate lets it through.** In plain English: if ORION used this gate as-is, a pay-to-unlock shop could slip past. The fix is to check for the *meaning* (buy, coins, gems, unlock, pay) as well as the exact words. File: `examples/example-sokoban-clone.py`, lines 54–57.

### Mike (meta-introspector), 8 repos
| Repo | What it is | Runs? | What it would mean for ORION's gameplay and the player |
|---|---|---|---|
| **aristotle-cli-rs, lean-worker, lean-workers-union, lean-worker-gh-twin, aok** | Tools for running Aristotle and Lean projects automatically | Yes, for programmers | Behind-the-scenes tooling. The player never sees it |
| **kant-zk-pastebin** | A paste-sharing website | Yes | Could become a place where players **share text and code**. Not gameplay |
| **vesper-studio** | An animation/"playbook" studio page | Yes, in a browser | Could help make **trailers and cut scenes** |
| **meta-introspector** | A very large analysis of other people's code (15,525 files) | Scripts | None for gameplay |
| **ORION fork** | His copy of your repo, with a website added | See §4 | See §4 |

---

## 4. Mike's copy of your repository (the only outside ORION code)

`meta-introspector/ORION-Engine-Platform-and-MMO`, last changed **5 October 2026**, and unchanged since.

- **The website doesn't load.** The deploy is still broken: the folder that should hold the site is a shortcut (a symlink), the published bundle is only 150 bytes, and the web addresses are dead.
- **Inside it are copies of two Aristotle projects:** this one, and a **second one I don't have**. I saved that second copy here: `orion/r20/from_mike_fork/`.
- **The second copy has its own single-page web app, the "ORION Hub"** (`webapp/index.html`). **I ran its built-in tests and they all pass:** core tests, the atlas tests (10,110 checks) and the "golden vectors". It also has about 480 Lean statements and a status file that says, in its own words, *"verified rulebook, not running software"*.
- **I don't know who made that second project.** It may be one of your earlier Aristotle projects. **Can you tell me?** If it's yours, I'll fold it in.

---

## 5. ☢️ Notices you can post (copy and paste)

### 5a. ☢️ Code-sharing notice
> ☢️ **ORION code-sharing notice (Round 20)**
>
> If you are running, copying or building on ORION material (the Vision Board, the rulebook, the art, or the ORION Hub), please share what you've built back with the group: a public GitHub link or the files themselves.
>
> **The rule:** I share ORION work only in groups where the members share their code too. Members who keep taking without sharing back will be removed.
>
> When you share, please say plainly **what it does**, **whether it runs**, and **what's still missing**. All ORION material keeps its credit to TGSATE / Beth.
>
> In ORION, we call our AI helpers **UIARs**.

### 5b. "Current state of the build" request (to put in everyone's readouts)
> Hi! For the next ORION round, please add a short **"Current state of the build"** to your readout, in plain words:
> 1. **What I built** (one line per piece)
> 2. **Where it is** (link or file name)
> 3. **Does it run?** (yes / no / partly, and how to open it)
> 4. **What part of ORION it's for** (which zone, rule or system)
> 5. **What's missing or broken**
>
> If you haven't built anything for ORION yet, just say so. That's useful to know too. Thank you! 🙏

---

## 6. What I'd suggest next
1. Send 5a and 5b.
2. Tell me whether the "ORION Hub" project in Mike's copy is yours.
3. If ORION picks **Godot**, ask Bobby whether his `AvatarController` can be the first shared piece, and ask Matthew whether Archimedes-Field-Lab can host a first ORION room.
4. Ask Bobby to close the far-games hole before anyone relies on it for the no-ads rule.
