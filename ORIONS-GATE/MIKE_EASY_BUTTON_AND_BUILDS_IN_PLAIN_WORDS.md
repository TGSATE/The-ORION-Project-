# Mike's "easy button" and his builds, in plain words ☕️

*OR20.5, Sunday 11 October 2026. Beth's asks (Doc `1etuEkoP…`):*
- *"There is another tool that he is directing me to, but I don't understand… he's wanting me to help run through the user end of it and I don't know how to do that… nobody is giving me any resources to learn with."*
- *"I want to see everything he is working on, what it does. If it is coding, I want to download it and see if we can utilize it in our build."*
- *"Please tell me if I am completely off with how my image processing is picking up what he's laying down… explain to me exactly what it does… in layman's terms, not coding terms, like a narrative."*

**What I opened today:** his demo page (https://site-updater.oneapp.dev), his ChatGPT plan link (**this time it loaded**: the title is "Cloudflare Deployment Architecture", and I could read most of the answer), his two X posts from today, his blog post, and every public repo on his organisation page (`meta-introspector`), his personal account (`jmikedupont2`) and his old account (`h4ck3rm1k3`).

---

## 1. The easy button, as a story

**Picture a bakery window.**

- **The recipe box** is a public download of the website's files. For ORION, that would be the "Download ZIP" of your ORION repo on GitHub.
- **The shop window** is the live website people visit.
- **The baker** is a little robot that lives on Cloudflare (or inside GitHub).

**What happens when someone presses the button:**
1. **The robot runs to the recipe box** and grabs the newest copy.
2. **It checks every file at the door.** Only approved website files get in (pages, pictures, styles). Anything odd or dangerous gets left outside.
3. **It compares with what's already in the window.** If nothing changed, it does nothing ("No changes found"). If something changed, it puts the new version in the window and gives it a number (v41, v42…).
4. **A timer stops button-mashing.** In the demo, anyone with the group's link can press it, but only once every 30 minutes. It also checks by itself once a day.

**The "layers and layers" part (the factory):** above the button sits a "factory" site that hands out **permission slips**. Each slip opens **one** shop window and nothing else. So if one group's slip ever leaked, nobody could use it to touch anyone else's site. A higher layer can make slips for lower layers, but never a slip stronger than its own.

**Where it stands:** **a picture of the idea, not a working tool yet.** The demo page says so at the bottom: "Prototype preview · Live deployment requires a secured server-side updater." Mike said the same in your Doc: "this is the demo, not working just a visual."

**What it would mean for you once it's real:** you (or anyone on the team) change files in GitHub, then press one button, and the website updates. No Cloudflare dashboards, no keys, no code. That's exactly the "I can't deal with Cloudflare" problem, solved for you. It's a kind thing for him to be building.

### "Run through the user end" means this, and here's your cheat sheet

He wants a **first-time user's** reaction: someone who isn't a coder clicking around and saying where they got lost. **You don't need to know how it works to do that. Being confused *is* the useful result.** Open the demo on your phone and answer these six (one word each is fine):

1. Without reading the small print, what do you think the big button does?
2. Do you know what "Public archive" means? (If not, say so. That's a finding.)
3. "Check for updates" and "Update now": are they the same thing or different? Could you tell?
4. Does "It can run once every 30 minutes" make sense, or does it feel like the button is broken?
5. "v42", "18 files published": helpful, or noise?
6. What would you want it to say after you press the button?

Then send him the six answers, as messy as they come. **That's the whole job.** You can tell him: *"I'm the non-coder test. Here's where I got lost."*

**Can Ari beat him to it?** Not to the button itself. I can't hold website keys or put anything live; a person has to do that step. What I already gave you (GitHub Pages / Netlify Drop, last level) is the **manual** version of the same job. His button would make it automatic. They don't compete: use whichever is ready first.

---

## 2. Everything public he's been working on (checked today)

### His own projects (not copies)

| Project | Last change | What it does, in a sentence or two | Useful for ORION? |
|---|---|---|---|
| **Site updater ("easy button")** | demo up now | The bakery robot above. No public code for it yet that I could find. | **Yes**: one-button publishing for the ORION site and Ghost Writer. |
| **`lean-workers-union`** | 10 Oct | **A receipt desk for proofs.** Every claim gets a receipt that climbs: **draft → sketch → "says it was checked"**, plus "foreign" for outside receipts. A gate stamps a receipt only if it's the right project, there are no gaps, and only allowed ingredients were used. It's careful to say a receipt is not proof by itself. | **Yes, as a game idea**: Proofs Arena badges (Draft → Sketch → Checked). |
| **`lean-worker`** | 10 Oct | **An AI helper with a time card.** A small AI agent running on a rented cloud computer, plus a written "twin" of itself whose claims (who asked it, what it ran, how much credit it spent) get checked against what actually happened. | As a story: an NPC that has to prove what it did. |
| **`kant-zk-pastebin`** | 10 Oct | **A public notepad.** You paste text and get a link. His version adds "paste to proof" (turn pasted maths into a proof attempt) and "sneakernet" (content travels as links, QR codes, even sound files, and can be rebuilt anywhere). | The QR side fits your QR-translation promo idea. |
| **`meta-introspector`** | 11 Oct | Weekly automatic activity reports, plus a very large study of which programs get used when software is built. | Not for the game. |

### Copies of other people's projects he saved this week (to study)

Cloudflare's own publishing tools (`wrangler-action`, `cloudflare-pages-action`, both 10 Oct), which line up with the easy button. Big maths projects (sphere packing, the DOZZ formula, Fröhlich–Spencer, Hörmander's theorem). Two code-reading tools (`carrick`, `fallow`) and a copy of `pi-anti-repeat` (11 Oct). **None of these is ORION**, and none of them is his own work.

### His personal account (`jmikedupont2`)
On 11 Oct he updated `Stuff` (his PDF dump). On 8 Oct he copied two other people's projects. Nothing ORION.

### About "they gave me access, that's the permission"
- **Looking is fine and done.** Everything above is public, so I read all of it.
- **Copying code into ORION depends on the licence file each project carries.** These are the facts I could see, not legal advice:
  - `lean-workers-union` is **AGPL-3.0**: you can use and change it, but if ORION uses it, ORION's version of that code has to be shared openly under the same terms.
  - `kant-zk-pastebin` and `meta-introspector` **have no licence file**. The usual reading is "look, but ask before copying."
  - Most of his copies of other people's projects carry **Apache or MIT** licences. Those allow reuse with credit to the *original* authors, not to Mike.
- **The easy-button idea doesn't need his code at all.** We can borrow the *idea* (one button, a 30-minute timer, one slip per site) for the game's design without copying a line.

---

## 3. Your café, ladders and roulette read: how close is it?

| Your read | What's actually in his public work | Verdict |
|---|---|---|
| **Ladders** | His receipt desk really is a ladder: draft → sketch → checked, with a gate at the top. | **Right.** It's a real ladder. |
| **Chutes** | A receipt can be marked "falsified", or fail the gate. That's a slide back down. | **Close enough.** Failed checks are his chutes. |
| **Roulette wheels** | I found **no wheel or spinner** in his code. | **Your design, not his.** It's still a good one: a roulette menu for picking code or Lean examples is fine as ORION art. |
| **Café** | I found **no "Lean Café" project** in his public work. ☕️ is the mark you gave him. | **An aesthetic choice.** It works as a theme; just don't tell him it's from his code. |
| **Ladder → newsletter page** | His **easy button** is the real newsletter fit: "press to publish the newest version". | **Swap the source.** Base the newsletter on the easy button, not the ladder. |

**So your eyes caught the right shape (ladders and failed-check chutes) in the right place (his proof-receipt work).** The roulette and café parts are yours, which is fine. Just call them ORION's design.

---

## 4. His two X posts today, and the artwork question

1. **"feelings are not load bearing"** (11 Oct, 13:45 UTC): a meme picture of a tired woman at a cluttered desk under a sign "MY FEELINGS ARE NOT LOAD BEARING". There's no text beyond the joke. **I can't tell who, if anyone, it's aimed at,** so I'm not reading it as about you.
2. **"The Meta-Meme / KALYPZOZOANAMYIZIADIZE Wordlist"** (11 Oct, 14:13 UTC): a cosmic infographic of his own invented words (Metanoogen, Pleroma, Event Horizon Café, Quine-meme…). It has neon hexagon tiles around a spiral galaxy with a black hole at the bottom.

**Compared with your cards (your GDDM album, opened at OR20):**
- **Alike:** cosmic background and black hole; a grid of labelled tiles, each with a title and a one-line meaning (much like your "THE ZOO" card); glowing linework.
- **Different:** his is a wide neon purple-and-blue infographic. Yours are tall black-and-gold framed cards with dragons, filigree and character art. His names no ORION, TGSATE, dragon or character of yours. **One small overlap:** his tile is called "Event Horizon Café", and café is the theme you'd picked for him.
- **Honest limit:** from a picture I can't tell whether someone learned from your work. AI image tools give this "cosmic infographic" look to a lot of people. If it matters to you, the gentle move is to ask: *"Love the new infographic style. Did my card layouts help? Happy to share the prompt structure."*

Saved: `orion/or20_2026-10-11/x_posts/MIKE_*.jpg` and the demo page's text `orion/or20_2026-10-11/MIKE_SITE_UPDATER_DEMO_TEXT.txt`.
