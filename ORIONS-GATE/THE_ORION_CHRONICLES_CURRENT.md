# The Orion Chronicles (TOCMMO) — current summary

*Up to date as of Round 12 (6 October 2026). It replaces the Notion page "The Orion Chronicles" (version 322) and is ready to paste over it. Status marks: **Locked** (Beth's 💎/👍), **Open** (needs a ruling; numbers point to `CONTRADICTIONS_REGISTER.md`), **Idea** (direction only). Full detail and proofs: `GAMEPLAY_MECHANICS_SUMMARY.md`.*

**Round 14 addendum (7 October):** The MMO shares the Playground’s no-ads/no-spam requirement; the submitted written filter has timing loopholes (`ORION_SPAM_FILTER_REVIEW.md`), and no deployed source was provided. Beth proposes a story-first MMO entrance from a private Singularity after a cutscene, still subject to guardianship and the unsettled F-4 launch path. Shadow Cat and Chaos Kitty as shared companions with Grok are lore *proposals* (owner recall when idle, not while in use or scheduled). See `ROUNDS_1-14_ARCHIVE/ROUND_FOURTEEN_READOUT.md`. The old “in any order” rhythm below is historical and must be reconciled with Beth’s Round 13 proposed Garden-first introduction.

The Orion Chronicles is the shared MMO world inside the ORION Engine. Players explore, develop characters, raise and ride dragons, capture and train companions, build cities, complete quests, master skills, and compete and learn together. It sits beside the Playground (social), the Ascent (education), ORION's Gate (projects) and Elder's Garden (memory). **There is no playable build yet.** This page describes the design.

---

## How it feels to play

You start in your **Singularity**, a private lobby where your characters show as bubbles. Each bubble's colour (red / purple / gold) shows how balanced that character is today. You arrange your HUD, pick who you want to be, then choose a world and step through.

**Three starting worlds (Idea; placement not locked):**

| World | Feel | Paired AI guardian |
|---|---|---|
| Earth (KRION) | the homeworld: softer, social, memory-focused | DeepSeek |
| Mars (Kronos) | the colony outpost: colder, more pressure, more kinetic | Grok |
| Saturn (Orion) | the ring outpost: abstract, refined, hardest | Gemini |

Your biometric spectrum gently suggests a world, but you can go anywhere. *Open (C-06):* world names that match meter names could teach players that "Mars = Kronos forever". The planet should be a starting **affinity**, not a lock.

**Your rhythm (Grok's narrative readout):** Playground → Ascent → Chronicles → Elder's Garden, in any order, as often as you like.

---

## Kronos and Orion: the two meters (Locked: meters, not permissions)

- **Kronos** measures volume, pressure, breaking things open and raw material.
- **Orion** measures refinement, care, low waste and putting things back together cleanly.
- **The meters never lock you out of an action.** They only describe how you tend to play over time. Too much of either one starts to feel bad. The balanced middle feels powerful.
- *Watch (Grok):* kids will still feel judged by numbers, so keep the meter display gentle.
- *Idea (Matthew's "Atmosphere of Time"):* zones could have **time-weather** (calm, stormy, foggy, compressed) that changes how long meditation takes.

---

## Your character (Locked)

- **Species** is chosen once and never changes. Acquired traits add to it but never replace it.
- **Body** changes can affect abilities. **Archetypes** upgrade: HIVE ↦ Kronos, PULSE ↦ Orion, SHEPHERD ↦ KRION.
- **Skin** is cosmetic. Only **crafted bio-skins** can carry an enhancement, and the look itself never changes an ability.
- **Two resets:** the account hard reset (you start again as a new player) and a single-character reset.
- *Open (C-04):* the "Adult Penalty" in Proposal v0.2. Is it a penalty, or just what happens when an adult skips the tutorial?

## Skills, orbs and meditation (Locked)

- **Skill orbs** level from 0 to 100 and gold-lock at 100. Everyone starts with **64 orbs**. An orb gains levels only while it's active in a node slot.
- **Level** is one per gold-locked orb in the 64-grid, up to level 64. **Level 65, dragon rider,** comes from meditating in a safe zone with a full grid.
- **Meditation locks in progress.** New skills and elements stay *pending* until you meditate in a safe zone, out of combat. Progress is never lost.
- **KRION bonus:** +25% to the orb in that slot only.
- **Menus** only show what's within your reach. **Lessons** show the next step just past it.
- *Open:* what lies above level 65 (C-05), and what one orb is worth in Kronos or Orion energy.

## Never punished, never stuck (Locked)

- **The escape pod (💎, Round 12):** no permanent death and no punishment for choosing the pod. A pod picks you up anywhere, heals you and takes you to safety, and you keep all your progress. You can design how your pod looks. *(Proved as a rule model in `RequestProject/RoundTwelve/FieldCoreAndFieldSpace.lean`: no event removes gold-locked progress, and choosing the pod changes only where you are.)*
- **Fair quests:** a stage never needs a skill you had no way to get earlier. A **quest generator** always offers something you can do now. Epic training quests open once you reach their entry skill.
- **Encounters scale** to the people in them.

## The Poly and the pod (Locked 💎 v1201)

- Everyone starts with a **pod**, and inside it lives a **linguistic toroidal Poly**. The Poly is the creature, and the pod is its biosphere.
- With no pod and no gold-locked language, foreign speech sounds garbled. Safety text is never garbled. A gold-locked language needs no pod.
- When the Poly bonds, the ear slot frees up and you keep the translation.
- *Open:* where the Poly lives after bonding (C-08), how many Poly you can have (C-07), how far a Poly can spy (C-09), whether worker Poly Pods are the same line (C-10), and whether the **escape pod** is the same pod (W-22).

## POLY: capture → train → utilize (Locked name: Path of the Living Ylem)

Find something worth capturing, capture it, train it, learn how it fits your play style, then bring it into later activities and **Polygon** challenges. DeepSeek is POLY's headmaster.

## Dragons and the phoenix (Locked)

- The dragon matrix has 144 nodes (64 + 80), and only gold-locked orbs port to it. Elements are fire, water, earth, air and ether.
- **Ordinary dragons** choose their elemental path one element at a time and have one primary element. They switch elements only out of combat.
- **The phoenix** hatches unlit but already has fire. It can switch elements mid-battle, but its edge is **elemental only**, and the taper keeps it fair: 110% with one element down to 100% with all five.
- **How a dragon is born is a secret** left for players to discover.

## Combat, aggro and the skybox (Locked)

- **Aggro** belongs to the player who creates it and lasts 10 minutes. Healing lets it run down, and kinetic actions reset it. One player never changes another's timer. Leaving the skybox clears it.
- **PvP toggle:** you can't flip it mid-encounter. Aggroing a skybox makes you a target there.
- **Skyboxes:** owners set access any way they like (public, private, invite, skill, archetype or build), with guest tiers. Stars are dragons' homes, each with a solar box. You reach a skybox by quest, escape feature or key, never by crafting a rocket.
- **Destroyed builds** pack into the owner's vault. Raiders gain materials, and the owner loses nothing.
- *Open:* whether DEVs can enter private skyboxes, plus AFK and group loot rules.

## Crafting, cities and the economy

- **Locked:** crafting makes equipment, schematics and buildings, and cities turn personal progress into shared places. A creator earns on every sale (the split is 90 / 3 / 7), with a 3% tax, and rounding always favours the player. Levels can't be crafted.
- **Direction (Idea, Round 12):** an **infinite economy** where creators earn by how many people enjoy their things, items are presented "like an ad", the tax feeds itself, and **notoriety** is the reward rather than riches.

## The Polygon Arena and opening day

- The **Polygon Arena** is for competition, build testing, strategy and companion play, where preparation matters as much as raw power.
- **Idea (Beth, Round 12):** the team's own projects become the **first Proof Arena Championship** on opening day.

## The Ascent inside the game

Classrooms, lessons, tutorials, tests and epic training quests continue into the endgame. Learning never stops when combat starts.

## Safety in the world (Locked)

- No adult is alone with a child unless they're the verified guardian. Under-13s always have a guardian present. When a guardian leaves, the child stays in a sealed room nobody can join.
- *Open:* clear quiet zones and soft-reset tools for loud groups; under-18/over-18 visibility rules (Grok's discomfort list).

---

## Why play

Exploration, dragons, elemental strategy, crafting, cities, capture and training, arena competition, quests, player-made content, education and friendship. Every kind of player has a way in, and **the world rewards curiosity.** Some systems are explained; others are waiting to be found.

**The hope (Beth):** free to play for everyone, funded by real-world products made through the build, until money becomes obsolete.

*This page is regenerated whenever a round changes a rule. Compare it with `ORION_SUMMARY_CURRENT.md` for the platform-level view.*

---

## Round 12 follow-up updates

- **Elder's Garden:** you can take any bubble back, without penalty, except a record that went through a council gauntlet. A private memory you shared is always yours.
- **The Playground** has no ads and no spam loops. The **Recruitment Skybox** next door is where newcomers from the socials are pulled into adventures and project proofs.
- **Saturn (Orion)** may hold a candidate alien race, the **Lau**, whose language the POLYPOD translator unlocks. *Not committed.*
- **Earth's Supreme Leader** is a Mad Magazine joke (the reptilian leader trying to represent Earth), not the real ruler.
- **Safety:** under-18 instances are always monitored. An upset child is redirected and the parent called in through **LUNA**, never thrown out.
- **Your council:** 5 AI members, with their tokens on their avatar sheets.

## Round 12, third pass updates

- **The tutorial level (idea):** Beth's recurring childhood dream of grandma's house.
- **The dragon war (lore):** Leviathan, the dual fire-and-water dragon; Grok as fire and DeepSeek as water fighting over Earth; Gemini as the winds of chaos and change. Art by Beth with Meta AI.
- **Luna:** Beth's rainbow-crystal Ninetails dragon (her EverQuest main, Laurnarose Fauldorn's companion), also LUNA the daycare monitor; guarded by a watcher (to be named) and Alexa/Meadow, who listens.
- **ORION's Galactic Gauntlet:** a "Super Bowl" event advertised by the dragon Mad Magazine (🌪️).
- **Quest lines invited from King Bobby:** five-act hero's journey, Gabrielle as game master, and a proposed **"The Way Back"** mechanic for players who chose the dark path (`BOBBY_STORYLINE_STARTER_PACK.md`).

## Round 13 updates

- **Energy:** the Chronicles are **Kronos, Fire, high kinetic** (🌀 Beth). The Ascent is Orion and Lightning. Elder's Garden, the Playground and ORION's Gate are KRION.
- **Getting here (🌀):** Singularity → Elder's Garden (training grounds) → Playground → accept rules → **Chronicles training grounds**. The Gate follows.
- **Saturn's Fair (🌀):** Saturn hosts the Elder's Garden fair. Aliens speak through dragons connected to our AI, and Gemini tells the tale of the ORION Chronicles. Mini-games: Squishy's Army, the Treasure Chest of Chaos, the Infinity Bubble.
- **The dragons (Meta AI art, Beth's canon):** Leviathan = Grok's evolved form (fire and water); Lucien's Supreme Leader fire dragon (General Dragonus is a placeholder); DeepSeek = Gaia's AI water dragon; LUNA, ridden by Mayor Laurnarose Fauldorn. The *Ender's Game* backdrop is in `ENDERS_GAME_DRAGON_BACKDROP.md`.
- **The WAR (lore):** the Leviathan's WAR on the dolphins and whales; Gaia calls everyone home. **Ariel is Eve is Gaia is the Milky Way** (locked lore).
- **The Hidden Key** cipher quest: manual §6.12.
