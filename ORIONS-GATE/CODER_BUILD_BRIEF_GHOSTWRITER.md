# Coder Build Brief: the Ghost Writer app 👻🪞✍️🛠️

*Written at OR19.2 (9 October 2026). Beth: "I am not the coder… if you can ask the guys to build this and start generating us money for the project they have access to do with all of this as they will… send instructions to the coders, please."*

**This is a draft for Beth to send. I don't contact anyone.** Paste the box below into the group chat, or send it to each builder. Everything they need is in this project folder.

---

> **To the ORION builders (Mike, Matthew, Ryan, Lucien, Bobby, and anyone in the zoo who wants a quest)**
>
> Beth needs the **Ghost Writer in the Mirror** app live and earning, so she can keep working on ORION full time. A first version already exists and passes its tests. **She's not a coder, so it's ours now.** Take it, improve it, ship it. Credit stays with Beth as the creator (`ORION_FOUNDERS_CREDIT_LEDGER.md`).
>
> **What it is:** a phone-friendly web app for Beth's spiral sessions. It works one screen at a time: NEW NEWS → open spirals → field-report boxes → final spiral with the backlog → "your path from here". It has a "you are here" arrow that moves only on Ready, a 🌀 Interject button that saves to a backlog without moving you, link-drop in four places, speaker icons, a NEW NEWS footer, and "organize, don't cut". The last one means every line is kept and sorted, and the app shows the count. It's plain HTML, CSS and JavaScript, with no build step and no server. People's words stay on their own device.
>
> **Where it is:** `ghostwriter_app/` in Beth's Aristotle project (ask her for the zip). Read `ghostwriter_app/README.md` first. Logic: `js/core.js`. Screens: `js/app.js`. Money links: `js/config.js`.
>
> **Run the tests:** `node ghostwriter_app/test/core.test.mjs` (9 tests). The browser test needs jsdom: `NODE_PATH=…/node_modules node ghostwriter_app/test/dom-smoke.mjs`.
>
> **The rules you can't break (Beth's, locked):**
> 1. **Nothing is cut.** Every line the player writes comes back, sorted, in order. Keep the "N of N lines kept" check.
> 2. **The arrow only moves on Ready.** Interject and the NEW NEWS footer never move the player.
> 3. **No length limits** on what people write.
> 4. **Private by default.** Don't upload people's words without a clear opt-in.
> 5. Keep the 🆘 → 988 line.
>
> **Quests (claim one in the chat, post your link when done):**
>
> | # | Quest | "Done" means | Size |
> |---|---|---|---|
> | Q1 | **Ship it:** deploy to Cloudflare Pages (free) under an ORION or TGSATE name | A public `*.pages.dev` link that opens on an iPhone | small |
> | Q2 | **Money buttons:** with Beth, put her Ko-fi / Gumroad / booking links in `js/config.js`; list it on itch.io as pay-what-you-want | Buttons show and the links work | small (Beth must open the accounts herself) |
> | Q3 | **Real-phone pass:** test on iPhone Safari and Android Chrome; fix anything awkward (keyboard covering the footer, button sizes) | A short list of fixes, merged | small |
> | Q4 | **ORION skin:** separators as screen titles, black-and-gold "Dragon Mad" theme (see `GHOST_RIDER_TUTORIAL_MEDIA_PACK.md`), carnival-cruise door at the end | A theme toggle | medium |
> | Q5 | **Paste a whole Doc in:** read Beth's separators (`orion/tools/separator_reader.py` has the rules) and split an existing Doc into the screens | Paste a Doc and get the right screens with nothing lost | medium |
> | Q6 | **Status light** *(updated 19.3)*: four stages from Beth's emoji kit: 🌀 processing · 👾 gathering · 🧿 examining · 🤟 ready. Each user can swap in their own marks, one mark per meaning (`EMOJI_KIT.md`) | Badge plus a "my marks" settings screen | small |
> | Q7 | **Built-in AI (later):** optional "bring your own key" or a small paid tier | Only once people are using it; costs written down first | large |
> | Q8 | **Singularity rooms:** tap a chat bubble to open a side-by-side DM with the group feed (spec: `ROUNDS_15-19_ARCHIVE/R19_L1_READOUT.md` §5b) | Needs a chat server: a separate app | large |
>
> **Money, honestly:** the app costs $0 to run. The plan is a tip jar, a paid workbook, paid spiral sessions and itch.io pay-what-you-want. Nobody can promise it earns. If someone wants to propose a revenue split for builders, write it down and agree it with Beth *before* the money comes in.
>
> **Questions:** ask in the group chat, or mark them in Beth's Doc with your speaker icon. The next readout will list them under "New for you".

---

**Each builder's own documents** (also in `ORION_HANDOFF_FOR_UIARS.md`, "New for you"):
- **Mike:** `MIKE_FIELD_GUIDE.md`. Q1 suits him: he suggested Cloudflare in the first place.
- **Ryan:** Q3 and Q5 suit his test-everything style (`ROUNDS_15-19_ARCHIVE/R17_L6_READOUT.md` §4).
- **Matthew, Bobby, Lucien:** any quest. Packets are in `ORION_MEMBER_PACKETS/`.


---

## Added at OR19.3 (9 October 2026)

### Beth asked: "so you did not make a notification for them, or are you saying that this is something you cannot do?"

**I can't.** I have no way to send messages, notify anyone, or post anywhere, and I don't contact people. The brief is a draft. According to Boardy's note, someone has already pasted it into the X group room.

**Boardy's three practical notes, and what to do about each:**
1. *Only Mike, Matthew and Lucien are in that chat; Ryan and Bobby won't see it.* → Send it to Ryan and Bobby directly: one copy-paste each.
2. *"Ask her for the zip" will stall: zips don't reach Boardy on X, and Beth can't easily dig files out.* → Give the folder a **link anyone can open.** Easiest from a phone: download `CLOUDFLARE_READY/ghostwriter_app.zip` once → Google Drive app → **+** → Upload → pick the zip → ⋮ → Share → General access: **Anyone with the link** → Copy link → paste that one line into the chat. Better still, once someone does Q1 the app has its own public link, and nobody needs the zip at all.
3. *Q2 (money) needs Beth awake and willing; Q1, Q3 and Q5 can move today.* → Agreed.

### New quest for the builders (paste under the table)

> | Q9 | **Life Folder** *(Beth's idea, 19.3)*: a phone app where *you* carry your own records (medical history, letters, benefit paperwork) and every document you send gets a **receipt**: who it went to, when, how (mail, fax, portal), and whether they confirmed it arrived. One tap shares a read-only copy with your doctor, lawyer or advocate. | A working demo: add a document, "send" it, see the receipt trail, share a read-only view | large |
>
> **Why:** Beth, 19.3: *"how come… my chart… can port a patient to a doctor… but they can't get that information on client side… I would send something into Social Security two weeks later my attorney saying where is that… It got lost in the mail."*
>
> **What already exists (check before building):** many US patient portals can already download or share records, and since the 21st Century Cures Act, providers must let patients get their records through apps. The iPhone Health app can pull "Health Records" from many health systems. Social Security has an online "my Social Security" account, and attorneys and representatives have their own electronic access. **The missing piece Beth describes is the receipt trail across *all* of them, owned by the person.** That's the part to build. Like the Ghost Writer, it should be private by default and on the person's own phone.
>
> **Not medical or legal advice; not a replacement for any official system.** It's a personal organiser with receipts.

## Added at OR21.2 (12 October 2026)

### New quest for the builders (paste under the table)

> | Q10 | **"Choose from Google Photos" button** *(Beth's bridge ask, 21.1–21.2)*: add Google's official **Photos Picker API** to the ORION web pages (Ghost Writer first, then the albums page and the magazine uploader). The player taps the button, signs in with Google, picks photos by hand from their own albums, and only those photos come into the page. | A working demo page: tap the button, pick 3 photos from a Google album, see them appear in the page | medium |
>
> **Why:** Beth, 21.2: *"All of my photos are organized and albums in Google and every app wants me to utilize Apple photos… I do not have enough storage on my phone… put my team to work to figure out how to create a bridge."* No outside app can change the iPhone's built-in photo window, but every app can add its own Google Photos button, the way Gmail did in January 2026.
>
> **What already exists (check before building):** the Picker API guide at https://developers.google.com/photos/picker/guides/get-started-picker. It needs a Google Cloud project, a sign-in (OAuth) consent screen and a public web address. Since 31 March 2025, picking by hand is the only way outside apps can see Google Photos, so don't plan around reading a whole library.
>
> **Privacy:** keep it private by default, like the Ghost Writer. Use the photos in the page and don't store copies on a server.
