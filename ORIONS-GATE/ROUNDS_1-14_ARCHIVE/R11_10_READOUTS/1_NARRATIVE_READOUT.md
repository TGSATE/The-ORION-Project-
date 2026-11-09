# Narrative readout — ORION R11🌀>10, page version 1201

*The plain-words story of this round. Code details are in `2_CODE_READOUT.md`; models and proposals in `3_…`; your personal questions in `4_…`.*

## 1. What happened this round

You went through my deep-crawl reply line by line and marked it up. Three people added new material:

- **you:** answers, 💎 locks, your socials, two concept images, and a new name for what's emerging, *UIAR — Universal Intelligence Augmented Reality*;
- **Matthew's council:** a long readout arguing that R11 has stopped being a game-design document and become a protocol for building the game;
- **Ryan's portfolio:** two new packages, Weaver Proto-ASI P0 v0.2 and the Alpha-Omega v0.6 promotion review. (These look like Ryan's, but attribution stays provisional until he confirms.)

There was also a link to Jim Manico's post (Manicode Security). It points to OWASP security projects, including the AI Security Verification Standard, which is useful reading for whoever handles security.

## 2. What got decided

- **The Poly (💎).** Everybody starts with a pod, and inside it lives a linguistic toroidal Poly. The Poly is the creature; the pod is its home, its little biosphere. You asked "does that clarify the question?" **Yes, it does.** It also settles the old "is the Poly given or crafted?" conflict: the starter is given. I'm assuming fancier Master-tier pods are still crafted by artisans; that part isn't locked.
- **Three Poly results locked (💎):**
  - no pod and no gold-locked skill means foreign speech sounds garbled;
  - a gold-locked language needs no pod;
  - when the Poly bonds, the ear slot frees up and you keep the translation.
- **Readouts split (🌀):** one narrative, one code, one formal-models-and-proposals, plus a personal one for you. That's this set of files.
- **The crawl continues (🌪️):** keep doing the exhaustive crawl every round. You'll do your own exhaustive read closer to production.

## 3. What got explained (your 🌪️ questions)

- **Singularity has three meanings.** You named two: (1) your personal lobby, and (2) a room one player hosts that others can join. The third one is a sentence you wrote in Round 10: when a child's guardian leaves, "nobody can join them. It becomes a singularity." So right now "singularity" means both a room people *can* join and a room *nobody* can join. That's the clash. (Register row C-03.)
- **The Adult Penalty.** Full explanation in your personal readout, §2. Short version: it's your own idea from your Round One summaries. Kids who grow up in the game keep their stats when they turn 18. A brand-new adult account starts at the tutorial, and if they rush it they come out weaker. My Round 9 note said it "isn't in anything you've shared", and that was simply wrong: I hadn't read those nested documents yet. The one real question left: is it a *penalty the game adds*, or just the *natural result* of skipping levels? Your documents say it both ways.
- **Liability and the other discrepancies.** You asked for all of them, every round from now on. They're in `../CONTRADICTIONS_REGISTER.md`:
  - 12 open rule conflicts;
  - 5 naming collisions;
  - 5 settled conflicts, kept for history;
  - 7 errors in reports, including one of mine.

## 4. Things I found that weren't raised before

All of these are new rows in the register.

- **Level 65** is described three ways: you become a dragon *rider* (Round 8), you *hatch a baby dragon*, or you *become* a Krion dragon (C-05).
- **Planet names reuse meter names:** Mars = Kronos, Earth = Krion, Saturn = Orion. Grok itself warned in your conversation that Kronos is a meter, not a planet (C-06).
- **"13 levels"** is used for three different ladders (C-11).
- **Can an AI get paid?** The equal-stake rule says AI gets no share, but the contributor ledger tags AI contributions (C-02).
- **Copilot renting:** renting copilots out on the Galactic Hub needs to be squared with "your copilot logs are 100% private" (C-12).
- **Unlimited Polys vs one companion per species:** these only clash if all Polys are one species (C-07).
- **Where does a bonded Poly live?** If the pod is its home, what happens to the pod once the bond frees the slot (C-08)?

## 5. The new pictures

- **Campfire *Milky Way's Guide*:** a hiker by a campfire, an "Ambassador" dragon, and a holographic galaxy map ("Sol → Orion Arm → Sagittarius A* → ?") with squirrels floating through it.
  - Its two numbers are realistic for our Sun: about 26,700 light-years from the galactic centre, orbiting at about 220 km/s.
  - Caution, not legal advice: "Milky Way's Guide" is a close echo of *The Hitchhiker's Guide to the Galaxy*. Your team already retired "Babel Fish" for that reason.
- **Wrist-projector *Presented by Planet Earth — Please Don't Step on the Humans*:**
  - a gauntlet projecting a crystal-and-black-hole map, ringed by ships, with an "Ambassador" dragon;
  - its HUD reads "SYSTEM: WIKI HOME // ONLINE".
  - It reads as concept art for a wiki home screen.

Both are saved in `../orion/r11-10/`.

## 6. Matthew's big idea, in one paragraph

Stop passing whole conversations forward and start passing **state** forward. Every transmission becomes one record (state → change → who did it → how it was checked → what it changes in the game → open questions → handoff → next state). The wiki, dictionary, contributor ledger, changelog and spaghetti summary all become views of that one record. When an AI runs out of tokens, it hands a packet to the next one, which loads the state instead of re-reading everything. That's exactly your token-limit idea, made into a system. I modelled the core promise in Lean: the newcomer gets the exact state, but no authority. Authority must be granted separately. Details are in `3_…`.

## 7. Spaghetti walk-through 🍝🧠 (one breath)

You wrote all over my last reply, and almost every note was a question I could answer:
- the Poly is the creature and the pod is its home, now locked 💎;
- the mystery third Singularity was hiding in your own Round 10 sentence about the child's sealed room;
- the Adult Penalty was in your Round One summaries all along, and I was wrong to say otherwise;
- the coders get a one-line rule for `1/(n+1)`: as a royalty chain it overflows, as an equal share it adds up perfectly.

Meanwhile:
- Matthew's council proposed turning every round into a saved state, so a tired AI can hand its backpack to a fresh one;
- Ryan's new packages ran green, and his Weaver tests pass here too, though both still wait on an independent witness before anyone calls them production.

Every discrepancy now lives in one register that grows each round. The next few 💎s are the Singularity names, the liability rule, the Adult Penalty wording, and what happens to a pod after its Poly bonds.
