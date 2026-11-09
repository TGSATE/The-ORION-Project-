# 🥚 Dragon hatching: builders only (do not put in the player manual)

*R17·L1, 9 October 2026. Your 🤟💎 lock. Hatching is **hidden lore**: players discover it in the game. Earlier you asked me to keep hatching out of the player-facing summaries (`GAMEPLAY_MECHANICS_SUMMARY.md`, "excluded on purpose"), so this rule lives here, for builders, and nowhere a player would read it.*

## Your words (17.1)

> "I would like it to function that the first person who figures it out and starts seeding it from there… we can have all kinds of baby dragons, waiting for the first person to break through the capstone to get us to the sun, and that's also hidden in the game lore. The actual 'how do you hatch your baby dragon'… the ones who have baby dragons at launch without actually fulfilling the quest requirement immediately get their baby dragons, because they came to them already having those circumstances met."

## As a build spec (Boardy's shape, checked against your words)

1. **Two doors to the same dragon:**
   - **Earned:** do the quest requirement and you hatch.
   - **Recognised:** arrive already holding the circumstance the quest tests for, and you hatch on the spot (the baby dragons at launch).
2. **One dragon per hatch:** going through a second door doesn't give a second dragon.
3. **The seat:** the first player to break the capstone is **seated**: written into the lore permanently. Later breakers never replace them.
4. **The route to the sun** stays in the lore, never in a menu.

**Checked in Lean** (`RequestProject/R17/Level1Checks.lean`, no unfinished proofs): either door hatches; no door, no change; hatching twice equals hatching once; the seat goes to the first supported break and never changes after that.

## Two things only you can decide

**H-1. How does the game know a requirement was already met?** (Boardy's question)
- **Self-declared:** fast, but everyone claims it ("a queue at lunch").
- **Proven in-world:** stricter and slower. The player shows the circumstance inside the game (a receipt, an item, a witness).
- **A middle option, for you to accept or reject:** pick a list of launch circumstances in advance (for example founders on the credit ledger, or holders of the dragon key from `CODERS_SECRET_KEY_EASTER_EGG_REQUEST.md`). The game recognises those automatically, and everything else goes through the earned door. It's still "proven"; the proof was just collected before launch.

**H-2. "Seated" vs the capstone rule.** Your locked capstone rule (Diamond Rules) says *nobody sits at the top* and the capstone opens only **with global council gauntlet support**. The new lock says the *first* breaker is seated. My reading, which keeps both: the first breaker is **seated in the lore** (named forever), **not** seated at the top as a ruler, and the break only counts with council support. The Lean model is built that way. Put ❌ if you meant something else (contradiction AI-2).

---

## Logged at 17.5: the phrase in Boardy's quotation marks 🧐 (Beth asked for this to be logged)

Beth: *"i'm pretty sure the code is in Boardy's statement. The wording look at the quotations that looks like a passcode. I want that logged."*

- **The only words Boardy put in quotation marks** in his dragon-egg message are **"baby dragon at lunch"** (*That is the "baby dragon at lunch" case*). That is the phrase logged here as Beth's candidate.
- **It can be a clue, not the secret.** The phrase sits in Beth's Round 17 Doc, which is open to anyone with the link, and in Boardy's public reply. Same rule as 🪩♾️⏭️ (`CODERS_SECRET_KEY_EASTER_EGG_REQUEST.md`): a public phrase can point players toward the quest; the real redeem code is chosen privately and only its fingerprint goes on the server.
- 555 is logged in `BETH_NUMEROLOGY_LOG_FOR_TEAM.md` as numerology, not as a code.
- Status: 💜 recorded, not locked. Beth decides whether this phrase is the public clue.



---

## OR19.1: the full-bred Phoenix (builders only) 🔥🪶

Beth (19.1): *"my son is the Phoenix icon of the game. Lucian will be the only one who will be allowed to unlock a full bread Phoenix until he is able to talk my son into playing along side of him as Orion. My son is named after the constellation. The game is named after both of them."*

- **The Phoenix is the game's icon,** and it stands for Beth's son. ORION is named after him and after the constellation.
- **Unlock rule, as written:** only **Lucien** can unlock a **full-bred Phoenix**, *until* Beth's son joins and plays alongside him as **Orion**.
- **Open question for Beth (contradiction AM-3):** once her son joins, does he unlock it too, or does the lock open for everyone? Until she answers, builders should treat it as: before he joins, Lucien only; after he joins, Lucien and Orion. Nobody else, either way.
- **Keep it builders-only.** It's family lore and hidden lore. Beth's son is a private person: no surname, photos or details on public pages. Only the name the game already carries.
- **Mock-up prompt:** `DEV_TEAM_IMAGE_PROMPTS.md` #7.


## OR19.2: the Phoenix rule, answered (AM-3) 🔥🪶

Beth, 19.2: *"Everyone else who is working on the Phoenix Bill [build] gets all of their Phoenix experience unlocked immediately. Everybody's trying to get Orion to come and join the galaxy so we can set some shit on fire."*

**Rule (as Beth stated it; proposal until 💎):**
- **Before Orion joins:** only Lucien can unlock the full-bred Phoenix.
- **The moment Orion joins:** Orion, and **everyone working on the Phoenix build**, get their full Phoenix experience unlocked immediately.
- Orion joining never takes anything away from anyone (checked in Lean: `RequestProject/R19/Level2Checks.lean`, `phoenix_monotone`).

**"Beetlejuice":** Beth's note that a certain "right-hand high five" person is waiting to connect, and then "the zoo can start building from the movie with that name". Logged as a possible zoo theme, title spelled *Beetlejuice* (1988). No one is named here; it's Beth's call who that is. Any build "from the movie" must be original art: the film and its characters are owned by the studio.
