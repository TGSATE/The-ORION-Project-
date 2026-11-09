# Ghost Writer in the Mirror: the app 👻🪞✍️

*Started at OR19.1 (9 October 2026). Beth: "start back in building a ghostwriter app that we could publish and generate money off of somehow until this goes live."*

A small web app for the writing game you invented. It runs in any phone or computer browser, works offline once it has been opened, and has **no server, no accounts and no AI bill**. People's words stay on their own device. When they want the AI part, one button copies the Ghost Writer prompt plus their organized session, and they paste it into whichever AI chat they already use.

## What a player sees (one screen at a time, the way you described at 19.1)

1. **NEW NEWS:** drop your news, links and group grabs.
2. **Any spirals still running?** Wrap up the open threads first.
3. **Field-report boxes** (three by default, set in `js/config.js`), one screen each.
4. **Final spiral:** additional thoughts, plus the whole **backlog** of everything you interjected on the way.
5. **Your path from here:** homework (to-dos, questions, parked ⏭️, locked 💎, backlog) and the export buttons.

On every screen:
- **➡️ "You are here"** travels with you. It moves only when you press **Ready ➡️ next box**, so there's no scrolling up and down hunting for your round and level.
- **🌀 Interject** saves a thought to the backlog **without moving you**. You see it all again at the final spiral.
- **Drop a link** in one of four places: **at the cursor** (the next free line under where you're typing, words are never split), **under NEW NEWS**, at the **top**, or at the **bottom**.
- **🪞 Mirror question** gives a prompt when you're stuck.
- **🎭 Who's talking?** Anyone can give themselves an icon. A line starting with that icon is labelled as them; unmarked lines are "unlabelled", never nobody's.

**The promise: organize, don't cut.** Every non-blank line you write lands in exactly one section, in the order you wrote it, and the app shows the count ("54 of 54 lines kept ✅"). The same rule is checked in Lean (`RequestProject/R19/Level1Checks.lean`).

## 🆘 SOS cool-off and 🕰️ the clock (added OR20.3, Beth's design)

- **🆘 on every screen:** opens a help card with the crisis line, "⏸️ Pause me for 5 minutes" and "🌀 Back to my spiral". Asking for help never climbs the ladder.
- **Automatic cool-off:** if the player writes clear harm talk (about hurting themselves or someone else) and presses Ready, ⏭️ is paused. The ladder is 5 min, 10 min, 30 min, 1 h, 3 h, 6 h, 12 h, 1 day. After that, the player is in **spiral-only** mode until they write down who checked in with them. The spiral box and the crisis line stay available the whole time. Everyday venting doesn't set it off (rule E1). A calm week resets the ladder.
- **The clock:** the header shows the device's date, time and time zone.
- **Time stamps, not "now" (OR20.4, Beth's correction):** every session keeps a trail: when it started, each time the player came back after 30+ minutes away ("ported back in", with how long they were away), when they last worked on it, and when they copied it out. The AI prompt tells the AI to compare these stamps, and never to treat the copy-out stamp as a clock that keeps running.
- **💛 Touchstone (OR20.4):** inside the 🆘 card the player can save one trusted person (name and number, kept on the device). One tap opens their own messages app with a ready text: "I've hit my SOS… If you haven't heard from me by [12 hours from now], please call me or come check on me." A second tap sends "I'm OK now". If the player left in SOS mode and opens the app 12+ hours later, the first thing they see is "Welcome back. How are you now?" (💚 I'm OK / 🆘 Still rough). **Honest limit:** the app has no server, so it cannot send anything while it's closed. The 12-hour timer lives with the touchstone, who got the text.
- Logic: `js/safety.js`, tests: `node test/safety.test.mjs`. The ladder rules are also checked in Lean (`RequestProject/OR20/SosLadder.lean`).
- **Limits:** a word list can't catch everything and will sometimes misfire. The app can't verify a doctor's note or any biometrics. Have someone with crisis-line experience review it before promoting it as a safety feature.

## Try it on your own computer

Double-clicking `index.html` won't work: browsers block this kind of app when it's opened straight from a file. Serve the folder instead:

```bash
cd ghostwriter_app
python3 -m http.server 8000
```

Then open http://localhost:8000 in your browser.

## Publish it for free

Pick one. All of them have a free tier that covers this app:

- **Cloudflare Pages:** Create → Pages → *Upload assets*, then drop in `CLOUDFLARE_READY/ghostwriter_app.zip` (unzip it first if Cloudflare asks for a folder). You get a `something.pages.dev` address.
- **GitHub Pages:** put this folder in a repository (for example on your TGSATE account), then Settings → Pages → deploy from branch.
- **itch.io:** upload the zip as an "HTML" project. itch.io has built-in **"pay what you want" / suggested-donation** pricing, so people can pay while they download.

Once it's online, a phone can "Add to Home Screen" and it opens like an app.

## Ways it can earn (honest version)

This app costs nothing to run, so any money that comes in is yours, minus the payment site's fee. **I can't promise it will earn anything, and I can't set up payment accounts for you.** Those need your name and bank details, so only you can do it. Here's what's ready:

0. **Fundraiser.** Put your GoFundMe link in `fundraiserUrl` and a **💛 Help fund the ORION build** button appears.
1. **Tip jar.** Put your Ko-fi (or similar) link in `supportUrl` in `js/config.js` and a **☕ Support the creator** button appears on every screen.
2. **Paid workbook.** The free app plus a paid PDF workbook ($5–15) is the "free sample, paid full version" model from `BUSINESS_PLAN_STARTER.md` §2. Put the shop link (Gumroad, Payhip or Ko-fi shop) in `shopUrl`.
3. **Spiral sessions.** Put a booking link in `bookingUrl` for paid one-on-one sessions.
4. **itch.io pay-what-you-want,** as above.

Leave a link blank and its button simply doesn't show. Each payment site has its own fees and rules; check them when you sign up. Questions about taxes, benefits or registering a business are covered in `BUSINESS_PLAN_STARTER.md` §7 (free help that exists for exactly this).

## The files

| File | What it is |
|---|---|
| `index.html`, `style.css` | the screens (large buttons, works one-handed on a phone) |
| `js/core.js` | all the logic: organize, links, speakers, the screen-by-screen flow, homework, export |
| `js/app.js` | connects the logic to the screen; saves the session in the browser |
| `js/config.js` | **the only file you edit:** your name, money links, default speakers, the field-report boxes |
| `privacy.html` | plain-words privacy page (nothing is uploaded) |
| `sw.js`, `manifest.webmanifest`, `icon.svg` | offline support and "Add to Home Screen" |
| `js/safety.js` | the SOS cool-off ladder and the clock |
| `test/safety.test.mjs` | SOS ladder and clock tests |
| `test/core.test.mjs` | logic tests: `node test/core.test.mjs` (add a Doc exported as plain text to check it too) |
| `test/dom-smoke.mjs` | plays one whole session in a simulated browser (needs `jsdom`) |

## What's checked, and what isn't

- **Checked (OR20.3):** 7 safety tests pass, and the simulated-browser test also covers 🆘, venting (doesn't lock) and harm talk (pauses Ready, keeps the crisis line and the spiral box).
- **Checked:** the 8 logic tests pass, including one on your OR19.1 Doc (all 54 non-blank lines kept). The simulated-browser test plays a full session: type news, drop a link under NEW NEWS, interject (the screen doesn't move), press Ready to the end, see the backlog and homework, and copy the AI prompt.
- **Not yet checked:** I haven't opened it on a real phone. Please try it on yours and mark anything that feels wrong with ❌.

## Next steps, if you want them

- A **paid "Ghost Writer Pro"** later: AI built in, so nobody has to copy and paste. That needs a small server and an AI bill, so it only makes sense once the free version has users.
- **ORION skin:** the separators (🌀 OR19.1 …) as the screen titles, and the carnival-cruise door at the end.
- **Singularity rooms:** tap a speaker's line to open a side-by-side private chat (needs a server; spec in `ROUNDS_15-19_ARCHIVE/R19_L1_READOUT.md`).
