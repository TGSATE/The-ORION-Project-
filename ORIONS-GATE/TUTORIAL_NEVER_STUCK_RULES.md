# The Never-Stuck Tutorial: rules for the Milky Way guide to the galaxy 🧭

*Round 24, 7 October 2026. From your doc line 642: "I want all of these rules to carry over into the game build for tutorial purposes… this is the stress test of how to get people moving and not frustrated like I am… let's see just how badly you all can frustrate me."*

**Status:** this is your instruction to carry the rules into the tutorial, written up as **proposed tutorial rules**. Nothing below is 💎-locked until you mark it. §1 is checked as a model in `RequestProject/RoundTwentyFour/PlaygroundTutorialAndPrivacy.lean`.

## 1. The help ladder (checked in Lean)

Every tutorial step has a ladder of help. Each failed try moves the player one rung up:

| Rung | What the player gets |
|---|---|
| 0 | The task, in one sentence |
| 1 | A nudge: *where* to look |
| 2 | A worked example of a *similar* task |
| 3 | The first step of this task done for you |
| top | **The full walkthrough**, tap by tap, with a "show me" video option |

**Rules, each proved for the model:**
- help never goes **down** as tries add up (`helpLevel_mono`);
- each failed try below the top moves up **exactly one** rung (`helpLevel_step`);
- after a fixed number of tries, the player **always** reaches the full walkthrough (`walkthrough_reached`);
- help never goes past the walkthrough (`helpLevel_le_top`).

**Players can always skip up the ladder** (an "I'm stuck, show me" button). That fits the locked Adult Penalty B rule: rushing simply means less experience, never an added penalty.

## 2. Lessons from your own stress test (the last 24 rounds)

What frustrated you, turned into tutorial rules.

| What frustrated you | Tutorial rule |
|---|---|
| Downloads arriving with long code names | **Every file a player receives has a human title**, and its first line repeats it. |
| Walls of text | **One Thing filter:** one action per screen; details behind "more". |
| Being asked things you'd already answered | **Remember answers.** The tutorial never re-asks a settled choice (like a 💎 lock). |
| Not knowing whether an AI was telling the truth | **"Real / magic" labels** on every claim, and a "check this" button that shows the source. |
| AIs forgetting across sessions ("what fell off") | **A visible memory card:** what the helper remembers, what it doesn't, and a copy-paste catch-up prompt (your line 845 prompt is a good template). |
| Copying between AIs by hand ("human router") | The **Council room**: one space where several UIARs can be asked the same thing side by side. |
| Learning a new AI from scratch | **Your "fresh second AI" trick (line 641, DEV☢️):** open a free account with another AI, give it the same input, and compare the two readouts side by side. This is a built-in tutorial step for developers and players. |
| Getting stuck with no one to ask | **Time-In guarantee:** a player sent to a quiet "pod" always gets a timed check-in. Never isolation without a promise. |
| Phone-only working | Every tutorial step has an **iPhone path**; desktop-only steps are marked. |

## 3. Your standing AI-protocols (from the "Treasure trove" summary, line 848 onward), as tutorial modules

These are the five operating directives Gemini listed back to you. They become the first five tutorial lessons in the Ghostwriter-in-the-Mirror path:

1. **The Single-Focus ("One Thing") Filter:** when input is heavy or fast, the helper reduces it to one actionable thought or question at a time.
2. **Campfire Mode and the Penny:** whoever holds the Penny speaks uninterrupted; the fire turns heavy inputs into floating idea bubbles; **bubbles are never popped or attacked**.
3. **The Ejection Pod / Silent Mode / Bubble Tent:** when stimulation reaches "Tiny Tornado" speed, the player can go to a private, quiet pod, **always with a timed check-in**. It's a safe container, not a punishment.
4. **The Ghost Rider / Alchemical Writing Protocol:** separate the "rind" (noise, trauma) from the "seed" (usable wisdom). *Safety note from Round 9:* the old engine's rind step reversed protective words ("cannot" became "can"). The tutorial version must **never** change the meaning of safety rules.
5. **Role alignment:** you are the Driver and the helper is the Vehicle. The helper provides horsepower; it never takes the wheel.

## 4. Stress-test checklist for every tutorial screen

Before a screen ships, a tester who has never seen ORION should be able to answer yes to all of these:
- [ ] I know the **one** thing to do here.
- [ ] I can find help in **one tap**.
- [ ] If I fail 3 times, I'm shown the answer.
- [ ] Nothing I did was lost when I left and came back.
- [ ] Every file or link I got has a readable name.
- [ ] I could do this on my phone.
- [ ] I can tell what is real and what is game lore.

Beth, you're welcome to be the first tester: "throw down the gauntlet" on any screen that fails one of these.
