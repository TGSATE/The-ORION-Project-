# News report and link check, Round 24 📰

*7 October 2026. You asked (line 668) for a deep dive on the informational posts you sent, plus an up-to-date news report on the fields involved in building an AI-assisted game. I opened all **19 X posts** you linked, plus the paper and article two of them point to, Mike's NixWars page and Matt's new repository.*

**Caveats:**
- **Read here** means I saw the post text (and any linked paper or article). I didn't watch videos or read whole books.
- **Not verified** means the claim needs an original source before ORION uses it.
- A full feed of "every field" changes daily; the end of this report has the reliable feeds to follow.

## 1. Headlines that matter for ORION

1. **Turbulence: which way energy flows is decided by geometry and nonlinearity, not stored in the "amplitudes".**
   - A paper posted today, *Erasing and Regenerating the Turbulent Cascade Arrow* (Zhao, Zhou, Zhang; arXiv:2610.07449, with code on GitHub), scrambles the phases of a turbulent flow while keeping its energy spectrum. The direction of the energy cascade disappears, and only the full nonlinear Navier–Stokes evolution rebuilds it.
   - Separately, *Quanta Magazine* (2 October 2026) reports that Lei Fang's lab at the University of Pittsburgh, prompted by watching brine shrimp ("sea monkeys"), **reversed** the energy cascade in a 2-D flow using a small, correctly angled obstacle. Their line: "The geometry matters."
   - **For ORION:** this is the cleanest real-science match yet for your *necessary vs problematic friction* theme. The same energy can flow toward chaos (Kronos) or toward order (Orion), depending on the shape of the obstacle. That is a design analogy, not a physical law of the game.
   - The **@Akitti** post about the paper is dense commentary about the account's own "hive" model; its extra numbers (for example "scar-floor ~0.041") **aren't in the paper's abstract**, so treat them as that account's own claims.
2. **AI agents that don't get stuck.**
   - **@Lummox_eth** describes giving an agent system 12 tasks and one rule ("don't ask me what to do next"): 9 finished, 2 waited for approval and 1 failed. The key move: an agent that **wrote down what it couldn't prove, isolated it, and passed the usable work forward**. The model name in the post isn't something I could verify.
   - **@0xTrackmind** proposes "LLM writes, judge checks, code decides": a six-step loop ending in **auto / review / stop** gates and a **receipt**.
   - **For ORION:** both match ORION's gates and the new never-stuck tutorial rule (`TUTORIAL_NEVER_STUCK_RULES.md`). The Lean checks in this project already work this way: anything unproved is marked unproved, and everything else moves on.
3. **Protein design.** **@thesupermannx** describes "AlphaProtein Novo", a DeepMind model said to design enzymes for brand-new reactions. **Not verified:** I couldn't confirm a DeepMind release with that name. The field is real (2024 Nobel Prize in Chemistry), but wait for the paper.
4. **Space propulsion.** **@latestincosmos**: Russian scientists unveiled a plasma-engine prototype, with a claimed 30-day trip to Mars. Plasma propulsion is real; the 30-day figure is a **projection, not a flight result**.
5. **Learning resources (good for the Ascent and the skills academies you mentioned, line 653).** I'm reading "advent" as **Ascent**, ORION's education title. Tell me if you meant something else.
   - ***A Spiral Workbook for Discrete Mathematics*** (via **@antoniolupetti**): a **free, open textbook** on logic, proofs, sets, number theory, combinatorics and induction. Its "spiral" method revisits topics at rising depth, which matches your spiral language.
   - **@KirkDBorne**: *Topological Data Analysis with Applications* and *The Moscow Puzzles: 359 Mathematical Recreations* (a classic by Boris Kordemsky). Both posts use Amazon affiliate links, which is normal for him. The puzzle book could feed a puzzle library, but get permission before copying any puzzle.
   - **@mathemetica**: a clear explainer of angle of attack vs angle of incidence and the stall (lift rises to about 16°, then the flow separates). This could feed a stall warning in flight navigation.
   - **@SciencesKL**: a "physics equations" image post. The 111 likes you noticed were a coincidence of the moment; it now shows more.

## 2. Collab checks you asked for

| Account | What I saw | My read |
|---|---|---|
| **@Divine_Emissary ("Alumirah")**, 2 posts | Long devotional posts: "The Elemental Lattices", Pleiadian fae and fluidic beings, "the 144,000 nodes" | A lore-rich writer; good for Chronicles inspiration. ⚠️ **Open question from earlier rounds (L-10):** is this Lucien's account? Some of these posts were filed under Lucien. Please confirm before treating it as a new collaborator. |
| **@Earstohearyou ("WhatdoIknow")** | "The Way Home: The S'tori of Two Trees": one structure, two poles, a boundary and choice | Philosophically close to the Kronos/Orion poles. Could fit as a guest storyline. **Ask about permission to use their art.** |
| **@jtpduffe (Joseph Paul Duffey)** | Replying to Earstohearyou: "a torus is at least a 7 pole structure"; credits @paul4jennii's "Uniphysics" | His claims about poles, QCD/QED and a "7 color map theorem" aren't standard physics. (A real theorem says **7 colours suffice for maps on a torus**, Heawood's result, but that is about colouring regions, not physical poles.) Your Gemini list has a chat titled **"Uniphics Theory: Misinformatio…"** and one called **"Identifying Joseph Paul Duffy"**. Please share what Gemini concluded before a collab. |
| **@GetTheFabulous** | An advert for *The Fabulous*, a habit app for "neurospicy brains" (December 2025 post) | A commercial company. Worth a conversation about routines, but check its **pricing and data privacy**, and remember ORION's rule that payment never unlocks progress. |
| **@AshwinKalyandu2** | Claims singing do-re-mi beats dementia drugs at clearing plaques | **Not supported by evidence.** Music therapy helps mood and quality of life in dementia, but there's no evidence it clears plaques better than the medicines. Don't repeat this claim in ORION. |
| **Mike (@introsp3ctor)**, 2 posts | "Behold the ogg surface of the monster primes fields" and "The #supersingular j in F_{p^d} monster torus" | Mike's maths art about the Monster group's primes and supersingular elliptic curves. The maths terms are real; the pictures are art. |
| **Mike's NixWars** (nixwars-v3 site) | A working browser **arcade**: "fifteen doors", WebAssembly games described as emitted from Lean, a 3-D voxel hall, a trading game whose exchange is "proved not to be a money pump" | **This is runnable software from your team.** It's Mike's, not the ORION game, but it answers Grok's "nobody has runnable code" (§3). I didn't audit its proofs. |
| **Matt: `enuminous/Aristotle-102-Monolithic-Lean`** (created today) | 5 Lean files, **42 theorems**, a law table and a web page: "What actually follows from EFMW-102?" | I **rebuilt it here**, on the same Lean and Mathlib versions as this project: **it builds, with no `sorry` and no warnings**. Its own scope note is right: these are maths consequences of the equations, not evidence that EFMW describes nature. **"EFMW + Zoo + 102Monolithic + 165EinsteinianTriplets = ???"** The answer is a library of separately checked pieces, not yet one combined theory. Linking them would need shared definitions across the repos. |

## 3. Grok's inventory of your project, fact-checked (lines 682–729)

| Grok said | Correct? |
|---|---|
| "239 properties PROVED, 0 negated, 0 in progress" | **It was correct at Round 19**, when the project page showed 239. The table has grown every round since, and this round adds 16 more. The Lean code now has over 1,000 proved statements in 72 files, none unfinished. |
| It's real formal verification work, not story documents | ✅ |
| Examples (Miss T timeline, album counts, buses, Lucien's orbit and angular momentum, EFMW axiom consistency, φ powers, no field with one element) | ✅ these are all in the project |
| "There is a CODE tab… some actual formal code (Lean or similar)" | ✅ it's Lean 4, the whole `RequestProject/` folder |
| Not a playable game, not a backend, not Unity/Unreal/Godot | ✅ correct for this project. (Mike's NixWars is a separate runnable arcade.) |
| "The gap is between proven design fragments and working product" | ✅ a fair summary |

I'm glad it helped you feel steadier. The one-page "what you actually have" card Grok offered already exists here: `ROUND_NINETEEN_WHAT_YOU_HAVE.md`.

## 4. Reliable feeds for "every field" (to follow yourself)

| Field | Feed |
|---|---|
| Maths and physics news, written for non-specialists | *Quanta Magazine* (quantamagazine.org) |
| New research the day it appears | arXiv listings: `cs.AI`, `cs.HC` (human–computer interaction), `physics.flu-dyn`, `quant-ph` |
| Space | NASA (nasa.gov/news), ESA |
| Science overall | *Nature* News, *Science* News |
| AI products | the official blogs of Google DeepMind, OpenAI, Anthropic and xAI. Trust these over viral posts. |
| Games and engines | Godot and Unity release notes; the Game Developers Conference (GDC) talks archive |
| Neurotech ethics | the OECD Recommendation on Responsible Innovation in Neurotechnology (2019) |

Snapshot of the 19 posts (author, date, first 200 characters): `orion/r24/X_POSTS_R24.tsv`.
