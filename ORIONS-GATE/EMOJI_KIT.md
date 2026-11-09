# The ORION emoji kit: a base set anyone can start from 🌀👾🧿🤟

*Started R19·L3, 9 October 2026. Beth: "🌀🌀🌀processing 👾👾👾gathering 🧿🧿🧿examining. I'm not sure why that tripped red flag in my brain but I wanna make sure that we get this cleared up and how we're gonna utilize the different emoji con systems so the people can set them up with their own and have a base set to start from."*

**Status: 💜 proposal, built from Beth's own marks. Nothing is locked until she 💎s it.**

## Why it tripped the red flag

At 19.2 I made a status light that used **👾 for "done"** and **🧿 for "still working"**. But in your system **👾 already means gathering** and **🧿 means examining**. So one mark had two meanings. Your brain caught it, and it was right. (Lean check: `oldKit_clash`.)

**Fixed:** every mark now means one thing, and "done" gets its own mark, **🤟**, which you already use for "yes, good".

Picture: `orion/or19_3/EYES_ON_2_status_light.png`.

## 1. The status light (Ari's four stages)

| Mark | Stage | What Ari is doing |
|---|---|---|
| 🌀🌀🌀 | **processing** | spinning on your feed |
| 👾👾👾 | **gathering** | pulling the links, code, posts and pictures |
| 🧿🧿🧿 | **examining** | reading closely, line by line |
| 🤟🤟🤟 | **ready** | done, your turn |

**How to use it in your Doc:** when you send me a feed, change the top line to **🌀🌀🌀**. My finished readout always opens with **🤟🤟🤟 ARI: ready, your turn**, because you only ever see it when I've finished.

## 2. The rest of the base set

| Mark | Means | Where it goes |
|---|---|---|
| 💎 | locked: everything above it is final | on a separator (`OR19.3💎`); nine 💎 in a row = final audit |
| ⏭️ | the next level or round starts here | on a separator (`⏭️OR19.4`) |
| ☢️ | stop: nothing after the end line is read | `☢️☢️☢️🧿☢️☢️☢️` on its own line |
| 😈 | **Beth's own stamp:** "I had an (evil) idea, hold on a second", a pause, not a lock (clarified ☂️1.7; earlier read as "I already grabbed this") | after a pasted item |
| 🧿🧿🧿 line | **Beth's break:** above = closely examined, below = still swirling (☂️1.7) | its own line in the Doc |
| 🤦‍♀️ | correction: "that's wrong, here's the fix" | next to a readout line |
| 📰 | a news drop (NEW NEWS footer) | in the app's footer button |

**Speaker marks are separate from the kit** (they say *who*, not *what*): 🐶🐲 Grok, 🐗 Boardy, and everyone picks their own.

## 3. Make it yours

Copy the table, keep the **meanings**, and swap in your own marks. One rule: **one mark, one meaning.** If you swap marks one-for-one, your kit stays clear (Lean check: `relabel_clear`).

| Meaning | Base mark | Your mark |
|---|---|---|
| processing | 🌀 | |
| gathering | 👾 | |
| examining | 🧿 | |
| ready | 🤟 | |
| locked | 💎 | |
| next starts here | ⏭️ | |
| stop | ☢️ | |
| hold on a second (idea, paused) | 😈 (Beth's) | |
| correction | 🤦‍♀️ | |
| news drop | 📰 | |

## 4. Checked in Lean

`RequestProject/R19/Level3Checks.lean`, §2:
- the 19.2 light plus your base set gave one mark two meanings (`oldKit_clash`);
- the new kit gives every mark exactly one meaning (`newKit_clear`, `newKit_complete`), and no two marks share a meaning (`meaningOf_injective`);
- "ready" is none of the three working stages (`ready_is_separate`);
- any one-for-one swap of marks keeps a kit clear (`relabel_clear`).

These are statements about the kit as written, not about how any phone draws emoji.
