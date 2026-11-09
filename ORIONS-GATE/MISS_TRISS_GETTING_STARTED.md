# Miss Triss: getting started with ORION 🌹 (phone + laptop + Google account)

*R17·L1, 9 October 2026. Beth's ask: "a thorough explanation of how somebody can get started. She has a phone and a laptop and a Google account and she has no idea how to interconnect them… a walk-through to get her to where I am right now, as well as steps along the way to branch her off if she would rather just do image and document generation and send it over to me for processing. Give her options… go through her player card and do a thorough examination of her style."*

**For Triss, from Beth's ORION team.** Pick the path that suits you. You can stop at any step and still be useful. Nothing here costs money unless it says so.

---

## Part 1: What your style already brings 🔮

*Built from your player card and your public posts (see `MISS_T_PROCESS_AND_RESPONSE.md` and `ROUNDS_1-14_ARCHIVE/ROUND_NINETEEN_WHAT_YOU_HAVE.md` §7).*

- **You think in symbols first and explain second.** You start from one word you notice ("Mu"), link it by sound, number and shape, and build a whole diagram around it.
- **You mix real science with old symbol systems on one poster:** muon spin next to the Abraxas Core, the rocket equation next to Thoth and the Wedjat, the Tetractys, John Dee's Monas. The maths on your Wedjat (63/64), rocket-equation and Tetractys posters is correct; it was checked in Lean.
- **You work in fours:** you build each poster in Grok, four versions at a time.
- **You sign your work TRISTA** and put yourself into it ("Trista's word is Law").
- **You're social:** about half your posts are replies inside conversations.

**Where that fits in ORION (suggestions, you choose):**
1. **Visual + language design** (what Beth asked you for): you're the one who can make the game's symbol language look like something.
2. **An "aesthetic lens" for the new Rolodex gallery** (readout §7): a *TRISTA Mystic Architect* lens that restyles the whole view in your look. Your four-version habit is exactly how a lens gets tested.
3. **The Garble puzzle and the translator (LMDTS 🪩♾️⏭️):** players piece together meaning from shared words and symbols. That's how you already work.
4. **Operating diagrams** like your *Routing Chorus*: a one-page picture of how a game system works.
5. **One care point:** your "Intimate Equation" poster is adult-themed, so it stays out of the under-18 areas.

---

## Part 2: Choose your path 🛤️

| Path | You need | You'll be able to | Time |
|---|---|---|---|
| **A. Create and send** | Your phone | Make images and notes and send them to Beth; she runs them through Aristotle | 10 minutes |
| **B. Connect your devices** | Phone + laptop + your Google account | Have the same files, photos and Docs on both, no more emailing yourself | 20 minutes |
| **C. Read the team's code** | B, plus a free GitHub account | Download the team's public projects onto your laptop | 15 minutes |
| **D. Run Aristotle yourself** | C, plus a Windows or Mac laptop (a Chromebook works with an extra step) | Send your own maths and proofs to Aristotle, like Beth does | 30–45 minutes |

You can stop after A or B and stay that way. That's a full role, not a lesser one.

---

## Path A: create and send (phone only) 📱

1. **Make your piece** the way you already do: Grok (or Meta AI) image, four versions.
2. **Write two lines with it:** what it shows, and which word or symbol started it. This is the part Beth needs most.
3. **Send it to Beth privately:**
   - add it to the **ORION photo album** you're already a member of ("Trista"), **or**
   - put it in a Google Drive folder you share **with Beth only** (Part B, step 4 shows how).
4. **Don't post private details in open Docs.** Anyone with the link can read an open Doc.

Beth (or I, through Beth) then checks any maths and folds it into the game files.

---

## Path B: connect your phone and laptop (the "Marty McFly" fix) 🔗

The trick: **use the same Google account on both, and keep your work in Google's apps.** Then whatever you do on one shows up on the other.

1. **On the laptop:** open the **Chrome** browser → click the profile circle (top right) → **Turn on sync** → sign in with your Google account. Your bookmarks, passwords and history now follow you.
2. **On the phone:** install **Chrome**, **Google Drive**, **Google Docs** and **Google Photos** (all free). Sign in to each with the **same** Google account.
3. **Photos:** in Google Photos on the phone → your profile picture → **Photos settings → Backup → on**. Your phone pictures now appear at photos.google.com on the laptop.
4. **A shared folder with Beth:** on the laptop go to drive.google.com → **New → New folder** (call it "TRISTA for ORION") → right-click it → **Share** → type Beth's email → **Editor** → **Send**. Leave "General access" on **Restricted**, so only Beth can open it.
5. **One working Doc:** make one Google Doc for your ORION notes, inside that folder. Open it on whichever device is in your hand; it's always the same Doc.
6. **Check it worked:** take a photo on the phone, wait a minute, refresh photos.google.com on the laptop. It's there? You're connected.

**Free limit to know:** a free Google account shares **15 GB** across Gmail, Drive and Photos. Big video files eat it fastest.

---

## Path C: download the team's public code 💻

1. Make a free account at **github.com** (Sign up). Use a username you're happy to be public.
2. Open a team project, for example Beth's: https://github.com/TGSATE/ORION-Engine-Platform-and-MMO
3. Click the green **Code** button → **Download ZIP** → open the ZIP on your laptop. That's it: you now have a copy.
4. **To grab everyone's at once** there's a one-step tool in Beth's project, `orion/tools/grab_team_code.py`. It needs Python (installed in Path D), so do Path D first if you want this.
5. **Reading is free; copying into ORION needs permission.** Many repos have no licence. Ask the owner before reusing their code or art.

---

## Path D: run Aristotle yourself 🧠

Aristotle (by Harmonic) takes a maths statement or a Lean file and returns a checked proof, or tells you it's false. These steps follow the official install guide: https://aristotle.harmonic.fun/docs/installation

1. **Check your laptop:**
   - **Windows or Mac:** go ahead.
   - **Chromebook:** first turn on Linux: open Settings, search for "Linux", choose **Linux development environment → Turn on**. Then do the steps below inside the Linux "Terminal" app.
2. **Install Python 3.10 or newer** from python.org (on Windows, tick **"Add python.exe to PATH"** during install).
3. **Open a terminal:** Windows → search "PowerShell"; Mac → search "Terminal".
4. **Install Aristotle:** type `pip install aristotlelib` and press Enter (on a Mac or Chromebook, try `pip3` if `pip` isn't found). If you get an "externally-managed-environment" error, use the guide's other route instead: install uv (https://docs.astral.sh/uv/getting-started/installation/), then `uv tool install aristotlelib`.
5. **Get your key:** sign up or log in at https://aristotle.harmonic.fun/ → go to https://aristotle.harmonic.fun/keys → create a key.
6. **Save the key** (so you don't type it every time):
   - Windows PowerShell: `setx ARISTOTLE_API_KEY "your-key"`, then close and reopen PowerShell.
   - Mac: `echo 'export ARISTOTLE_API_KEY="your-key"' >> ~/.zshrc` then `source ~/.zshrc`.
   - Chromebook (Linux): the same two commands with `~/.bashrc` in place of `~/.zshrc`.
7. **Test it:** `aristotle --version` should print a version number.
8. **Your first job:** `aristotle submit "Prove that 63/64 = 1/2 + 1/4 + 1/8 + 1/16 + 1/32 + 1/64" --wait` (the Wedjat sum from your own poster).

**⚠️ About free limits:** I can't confirm what the free allowance is. Aristotle's public docs don't list it. Check your account page after you sign up before you start a big job, so you don't burn through it on day one. If you run short, send your piece to Beth (Path A) and she can run it.

**🔑 Your key is like a password.** Never paste it into a Doc, a chat, a screenshot or an AI conversation.

---

## When you're stuck

- Stuck on a step? Screenshot it (crop out your email and key) and send it to Beth. Every step has a way back.
- Time zones: you're on the Sunshine Coast, **14 hours ahead** of Beth. Your 4 pm is her 2 am, so send things and expect answers the next morning.
- You can switch paths any time. **Path A is always open.**
