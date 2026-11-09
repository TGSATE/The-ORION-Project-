# Playground call-out board: storyboard threads and volunteer replies 🎬

*Round 24, 7 October 2026. From your doc line 662. This is a design spec drafted from your description, not 💎-locked. The size limits are checked in `RequestProject/RoundTwentyFour/PlaygroundTutorialAndPrivacy.lean` §1.*

## 1. What it's for

A Playground board where anyone can post a **call-out**:
- a **storyline thread** (a Chronicles request);
- an **Ascent** request (a learning project);
- a **guild recruitment**.

Each call-out is a launchpad from the Playground into that project. Replies underneath work like a **volunteer sheet / request to collaborate**.

## 2. The main call-out post

| Part | Limit | Notes |
|---|---|---|
| Full explanation | no fixed limit | Why the call-out exists, with full access to the reasoning |
| Images | **up to 10** | Proved: an 11th image makes the post invalid (`callOut_image_cap`) |
| Storyboard | **exactly 4 panels** | Like your X storyboard threads: four images that tell the call-out |
| Shout-out | **250 characters** | The line people see in the board list |
| Link type | Chronicles / Ascent / Guild | Where "Join" takes you |

## 3. A reply (the volunteer sheet)

| Part | Limit | Notes |
|---|---|---|
| Summary | **250 characters** | Why you want to join and why you're a good fit |
| Player cards | **exactly 4** | Four cards from your profile, put down in the order you choose. Proved: three or five cards is never valid (`reply_needs_four_cards`). |

**Fit-it helper:** if a summary runs long, the board offers to trim it to 250 characters. Proved: trimming always fits and never touches the cards (`trimSummary_fits`, `trimSummary_cards`), so a reply with four cards is always postable after trimming (`trimSummary_valid`).

## 4. What happens next

1. The poster reviews the replies (summary plus four cards).
2. **Engage**: open a private conversation, under the existing under-18 rules: no adult-to-minor contact unless it is verified and allowed.
3. **Recruit**: the volunteer joins the thread, guild or Ascent project, and is credited in the project's credit ledger.
4. **Decline** is silent and kind. No public rejection.

## 5. Safety and fairness (from locked rules)

- Under-18 Playground areas follow `ORION_UNDER18_STRUCTURE.md`. A call-out can be marked 18+ only; minors never see it.
- Player cards show only what the player chose to make public.
- **No paying to be seen.** Boosting a call-out with money is blocked by the locked rule that payment never unlocks progress.

## 6. Open questions for you

1. Can one player post more than one reply to the same call-out?
2. Do call-outs expire (for example after 30 days), or stay until closed?
3. Can the four panels be video clips, or only still images?
4. Who can see the replies: everyone, or only the poster?
