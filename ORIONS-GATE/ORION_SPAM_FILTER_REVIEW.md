# ORION anti-spam filter: written-rule review for the coders

*Round 14. Beth: “I want the game to have hard spam filters. I’ve already tried to put a lock in there … have the coders examine my spam filter … ask for that to be put into their readouts.” Source: `orion/r14/GOOGLE_DOC_ROUND14_ARI_normalized.txt` line 14. This reviews **the written design**, not an implementation: no deployed MMO, chat server or filter source was supplied. Please send this to the coding team for an implementation-level review.*

## 1. What exists in the submitted writing

The “Volvabard Collab 09.30.26” document (`orion/r11-deep/nodes/03_gdoc_document_1IP9Id54-PLFl9_hJZqXuKWmyt5nUIarWKWgJHTrWd9s.md`, section IV; around line 60) describes the **Nuclear Spam Protocol**:

- After **five minutes of continuous chat**, sending **more than one message in 30 seconds** triggers a **one-minute global cooldown**.
- A **third infraction** limits messages to **one per minute**, lifted through a council clearance request.
- If that lock is ignored for **ten additional minutes**, the account loses public channels and retains private one-to-one and group chat until appeal.
- AI council watches for macros evading a one-second buffer. Private Guild Halls may use their own settings; *public* skyboxes cannot weaken the public filter. Beth reiterated this in the same source around lines 623–656.
- Round 12 added **no ads / spam loops in the Playground** and an opt-in **Recruitment Skybox**. Round 14 extends the no-ads/no-spam requirement to the **MMO** (not only the Playground).

This is a specification in a conversation, not a program or a tested anti-abuse service. **No server code was found in the submitted repository.**

## 2. Findings under the literal threshold

| Finding | Reproducer (whole seconds) | Why it matters | Check |
|---|---|---|---|
| **Uncapped opening burst** | Begin at second 0; post 1,000 messages at second 0. All are before second 300. | “After five minutes” suppresses the trigger; a bot can flood a new session or restart. | `opening_burst_never_triggers` in `RequestProject/RoundFourteen/SpamFilterAndRules.lean`. |
| **120/hour steady drip** | Begin at second 0; post at 0, 30, 60, 90, … . | Exactly 30 seconds apart never meets “more than one in 30 seconds”; high-volume copy-paste can keep going. | `steady_drip_never_triggers`. |
| **Ambiguous “continuous”** | Send a message before five minutes, leave for a moment, return. | If the clock resets on inactivity, an attacker can repeatedly get a free burst. Define session boundaries and persist strikes across reconnects. | Specification question; no implementation to test. |
| **Private-channel spillover** | After blackout, send a template to many 1:1s or newly created groups. | Blackout shifts bulk spam to private messaging if not rate-limited separately; don't strand users needing support. | Threat scenario, not a claim of a verified exploit. |
| **Link and account evasion** | Repeat slightly changed links from many accounts. | Per-account message pacing alone doesn't address near-duplicates, mentions, links, cross-channel amplification or coordinated accounts. | Needs live-system tests and privacy-aware moderation. |
| **Permanent sanction without appeal details** | A user is wrongly classified by the macro detector. | Council clearance and indefinite public blackout need clear evidence, timeframe, human appeal, and a safe route to help. | Governance gap; ask Beth for rules. |

**Important distinction:** a Lean proof about the formula does not demonstrate a vulnerability in software that may implement additional protections. It does show the *written* rules are insufficient to guarantee no spam.

## 3. A proposed base patch (not a locked game rule)

A simple, predictable first barrier: for each account and public channel, keep the last `w` seconds of **accepted** message timestamps. Accept a new message only while that rolling window contains fewer than `k` accepted messages; otherwise reject or queue and show the wait time. This applies **from the first message**, including a reconnect. Define an interval convention, e.g. the window `[t, t + 60)` for `w = 60`, so the 60-second edge is unambiguous. In the Lean model (`step`, `run`, `inWindow`), **every** such window contains at most `k` accepted messages for nondecreasing timestamps (`patched_filter_bounded`); `k = 5, w = 60` passes only 5 of 1,000 messages sent at second 0. `5/minute` is an *example to discuss*, not Beth's approved quota. Safeguards must be validated for simultaneous sends, clock skew, server restarts and channel boundaries.

Keep a separate small human-friendly burst allowance for a normal conversation, with an overall hourly cap to avoid the steady drip; use graduated prompts and short reversible holds *before* severe sanctions. Require a review before long restrictions. Exempt **emergency/help messages and appeals** through a monitored route without allowing that route to become a bulk-mail tool. **Do not block a child from seeking a guardian or assistance.** Public skyboxes and MMO chat use the same minimum protections. Private groups and DMs need recipient-side controls, anti-harassment protection and quotas that respect consent and privacy; “private filters off” must not mean anyone can unsolicitedly mass-message others.

No ads and no recruitment loop in ordinary public chat: put opt-in team invitations in the separate Recruitment Skybox, label them, let recipients mute/leave. False positives must be handled for assistive devices, dictation bursts, translations, lagged send queues and fast ordinary conversation. Never equate fast speech, a learning difference or an unfamiliar language with malicious automation.

## 4. Acceptance checks to request in each coder's readout

1. Point to the **actual source file(s), commit and deployed version**, if any. Say explicitly “design only” if no code exists.
2. Run tests for 1,000-at-once; exactly every 30s; 30s±1s; reconnect just before five minutes; messages across Playground/MMO/public skybox/Recruitment Skybox; 10 accounts reusing the same link; near-duplicate text; concurrent submissions. Include the accepted/rejected sequence and the configured limits.
3. Test clock skew, restarts, simultaneous writes and atomic updates; no lost counter increments. Limit both account and recipient/group abuse. Define what happens to an attempted post that was queued, delayed or rejected.
4. Show **emergency/guardian contact**, safe support/appeal, child-protection, translation, accessibility and privacy scenarios. No permanent sanction from an unexplained classifier; a human can review mistakes.
5. Provide an abuse metric (spam caught / legitimate messages blocked), minimal logging/retention, a rollback path and deployment sign-off. Do not publish rule thresholds that enable evasion without the moderation team's agreement; the conceptual tests above are safe for team review.

**For Beth in plain words:** your lock is a start, but a spammer can send many messages before the five-minute trigger, or patiently post exactly every 30 seconds without hitting it. A sliding “basket of recent messages” starts counting immediately and caps each window, regardless of the order of the other activities. Ask the coders to check **your real code**, not just this note; that source is not in the materials here.
