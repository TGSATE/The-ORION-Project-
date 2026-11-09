# T08: "Don't Panic": the frustration helper (and Beth's simple path)

*Round 17. This answers doc line 110, which asked for an in-game guide that offers immediate next steps when a player hits "Kronos distress" (frustration, overwhelm). The name comes from The Hitchhiker's Guide to the Galaxy (HHttG, doc line 79): the Guide has **DON'T PANIC** printed on its cover.*

> **This helper is a game feature. It is not a crisis service.** If a real person (player, dev or Beth) says they don't want to be here or can't go on, the helper stops the game talk and shows real help first. **US: call or text 988** (Suicide & Crisis Lifeline). **Emergency: 911.** Outside the US: findahelpline.com.

---

## Part 1: How the helper works in the game

### When it appears
- A player taps the **🧭 Don't Panic** button. It is always visible and always free.
- Or the game notices signs of being stuck: 3 failed attempts in a row, 10 minutes with no progress, or the player types words like "stuck", "I give up" or "this is stupid". The helper then *offers* itself once. It never pops up again unasked in the same session.

### What it says: three steps, never more
1. **Breathe (Kronos cools down).** "Your Kronos heat is high. That's normal; it's what pushes you forward. Take 3 slow breaths, or tap 'Pause the world' for 2 minutes." The world truly pauses: no timers, no score lost.
2. **One next step (Orion lights the path).** Show only **one** small concrete action, for example "Talk to Spark the guide dragon at the gate", never a list of ten.
3. **Ask a friend (KRION connects).** "Want a hand? Ring a teammate, open the Clutch chat, or read the hint scroll." Asking for help earns a small **Synergy** badge. Asking is a strength, not a failure.

### Real-distress safeguard (mandatory)
If the player types anything suggesting self-harm or "I don't want to be here":
- the game pauses;
- it shows: "You matter more than any game. If you're in the US, you can call or text **988** any time. If you're in danger, call **911**." It also links to findahelpline.com for other countries;
- for under-18 accounts, it also notifies the guardian or teacher contact set in `ORION_UNDER18_STRUCTURE.md`;
- the game never makes jokes and never shows lore at this point.

### Rules for devs
- **Plain-Language Helper Rule (Round 19, Beth's instruction 🤟, not yet 💎).** Every AI helper, copilot, Poly or GM bot that gives instructions must: (1) say the action, then the item's on-screen label ("Tap **Raw Feed** on your **Universal Stone**"); (2) use no metaphors, riddles or poetry in instructions (story voice only in story scenes); (3) give one numbered step per line and say how many steps there are; (4) use the player's own label if they renamed an item; (5) if the player says "I don't understand" or seems frustrated, say it again more simply, never repeating the metaphor; (6) when it needs something, ask a clear question naming the options. Full text: `ROUNDS_1-14_ARCHIVE/ROUND_NINETEEN_WHAT_YOU_HAVE.md` §4; Lean model: `RequestProject/RoundNineteen/HelperAndMissTChecks.lean` (`accepted_message_is_plain`).
- The helper never takes away points, lives or progress.
- Its text is short (under 40 words per step) and readable at a 3rd-grade level.
- The DEV-call urgency icon can be raised to show a threat level (doc line 102), but the helper never forces a player, and a DEV call never forces a dev.
- The guide character is **Spark**, Lucien's sticker dragon (album #1383, #1410, #1414). Ask Lucien's permission before public use.

---

## Part 2: Beth's own "Don't Panic" path

You said you're overwhelmed and want a step-by-step path. Here is the whole project in **five doors**. Open one at a time. The rest can wait.

| Door | Open this file | What you get |
|---|---|---|
| 1 | `ROUNDS_1-14_ARCHIVE/ROUND_SEVENTEEN_READOUT.md` | what changed this round, line by line from your doc |
| 2 | `ORION_PLAYER_CHARACTER_SHEETS.md`, your card | **your card is the example**: point other members to it |
| 3 | `NEPAL_SPARK_ACADEMY_IMAGE_PROMPTS.md` | the fun part: prompts to paste into Meta AI or Grok |
| 4 | `FOLLOW_UPS.md` | the short to-do list; only items marked **Beth** are yours |
| 5 | `HOW_TO_NAVIGATE_THE_COSMOS/00_START_HERE.md` | everything else, when you're ready |

**If you only do one thing this week:** remove the location from album photo #1124 (taken 6 October, 10:46). Steps are in T01.

**Things that are NOT your job:** code, GitHub merges, checking other people's repos. The devs do those, and the repo watch list is refreshed for you every round.
