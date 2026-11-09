# Image prompts for the DEV team 🎨🛠️

*Started OR19.1 (9 October 2026). Beth: "anytime I am talking about mechanical game design, like how the way things actually function, or a particular item that the developers could put their eyes on … please go ahead and generate image prompts that would be helpful to the DEV team."*

**How to use:** paste a prompt into any image tool (Meta AI, Gemini, ChatGPT, Grok, Canva). Every prompt is a **mock-up for builders**, not final art. Each one names the mechanic it shows, so a coder can look at the picture and know what to build. New prompts get added under a new level heading each round, and the UIAR handoff tells each builder when there's a new one (`ORION_HANDOFF_FOR_UIARS.md`, OR19.1 section).

---

## OR19.1

### 1. The spiral-stream screens (one box at a time)
**Mechanic:** a session is a row of screens: NEW NEWS → open spirals → field-report boxes → final spiral → homework. Only one screen shows at a time. **Built as a working app:** `ghostwriter_app/`.

> Mobile app UI mock-up, dark cosmic purple theme, one large card filling a phone screen titled "NEW NEWS". Along the top, a row of small rounded progress pills: "1 News", "2 Open spirals", "3 Field report", "4 Final spiral", "5 Your path", with the first one glowing cyan. A bright orange arrow badge reading "You are here" sits on the card's top-left corner. Large text box, big thumb-friendly buttons at the bottom: "Back", "Mirror question", an orange "Interject", a cyan "Ready → next box". Clean flat design, readable at arm's length, no tiny text.

### 2. The arrow that travels with you
**Mechanic:** the "you are here" arrow is attached to the player's current box, not to the page. It moves only when they press Ready.

> Storyboard of three phone screens side by side, left to right, each showing a different card ("Open spirals", "Field report", "Final spiral"). The same glowing orange arrow badge "You are here" sits on each card in turn, with dotted motion lines between the screens labelled "Ready". Under the middle screen, a small note card flies off to a drawer labelled "Backlog" while the arrow stays put, captioned "Interject: you stay where you are". Flat UX-diagram style, white labels on deep purple.

### 3. The Interject button and the backlog drawer
**Mechanic:** one tap parks a thought in the backlog without leaving the screen; the backlog is shown in full at the final spiral.

> Close-up UI mock-up of a pop-up dialog on a phone titled "🌀 Interject", with a text box and two buttons "Cancel" and "Save to backlog". Behind it, faded, the field-report screen. To the right, a pull-out drawer labelled "Backlog" holding a numbered stack of sticky notes in the order they were written. Friendly, high contrast, big buttons.

### 4. Drop a link: four places
**Mechanic:** paste a link and choose **At cursor** (next free line under where you're typing), **Under NEW NEWS**, **Top** or **Bottom**. Nothing already written moves out of order.

> UI mock-up of a text editor on a phone. A link-input bar with four large chips: "At cursor", "Under NEW NEWS", "Top", "Bottom". Four thin glowing arrows show where a link would land in the document for each choice: just under the blinking cursor's line, right under a heading "NEW NEWS", at the very top, at the very bottom. Each landed link sits on its own line. Clean diagram style.

### 5. Speaker icons anyone can assign
**Mechanic:** each person picks their own icon; any line that starts with it is labelled as them. Unmarked lines are "unlabelled".

> Group-chat UI mock-up. A settings sheet titled "Who's talking?" lists rows: "🐶🐲 Grok", "🐗 Boardy", "😈 Beth", each with an edit pencil, plus an "Add" row with an emoji picker. Behind it, chat bubbles each showing the speaker's chosen icon as an avatar; one plain bubble is tagged in grey "unlabelled". Warm, readable, accessible.

### 6. Bubble → singularity room (side-by-side with the group)
**Mechanic:** tap any chat bubble to open a private room with that person. The main group feed stays visible beside it, so you can work something out without interrupting the group or losing track of it.

> Tablet UI mock-up, split screen. Left two-thirds: a private room titled "Singularity room: Beth + Grok", with a soft spiral glow behind the chat. Right third: a narrower live feed of the main group chat, still scrolling, labelled "Group (live)". A small tag on the left room's header shows the bubble it came from. A finger icon shows the tap on a bubble that opened it. Clean, calm, cosmic colours.

### 7. The full-bred Phoenix unlock (builders only: hidden lore)
**Mechanic:** see `DRAGON_HATCHING_DEV_ONLY.md`, OR19.1 section. Keep this picture off public pages until Beth says otherwise.

> Concept art for a game unlock screen: a vast night sky where the constellation Orion is drawn in bright gold lines. From Orion's belt, a fully grown phoenix of blue-white and gold fire unfurls its wings. A stone pedestal in the foreground holds a glowing key slot, and a second, empty slot beside it waits, lit faintly, as if for a second player to join. Epic but warm, painterly fantasy style, no text.

### 8. The DEV challenge board
**Mechanic:** Beth wants in-game challenges the DEV team can take on that also help her family get on board. Proposal: a board of quests posted by Beth, claimed by builders, each with a clear "done" check.

> Game UI mock-up of a cork-board quest wall inside a cosy space-station workshop. Pinned cards with titles like "Build the link-drop menu", "Make speaker icons", "Phoenix unlock screen", each with a small coder avatar who claimed it and a green check stamp on finished ones. A banner on top: "DEV Challenges". Playful, readable, warm lighting.

### 9. "Aristotle finished": the notification bell
**Mechanic:** a ping when a long job (a readout, a build) is done, so the player knows to come and collect it.

> Phone lock-screen mock-up with a single notification card: an owl-and-scroll icon, title "Your readout is ready", subtitle "Round 19 · Level 1, tap to collect", time "now". A soft spiral glow in the background. Simple, clean, iOS-style.

### 10. Barney's T.O.E.S. Archive (from Mike's post today)
**Mechanic:** a possible side room off the Monster climbing gym: a shelf archive where each jar is a "theory of everything" (a pun on the Monster group and toes). Collect a jar by climbing to it.

> Game environment concept art: a cosy cave library with wooden shelves of glass jars, each labelled "TOES" with a famous theory name (Relativity, String Theory, M-Theory, Universal Constant). A friendly furry teal monster with horns and round glasses holds a glowing jar labelled "Ultimate TOES" with a galaxy inside. Climbing holds are set into the shelves so players can climb to the jars. Warm lantern light, whimsical.

*Mike's original picture (his public X post, 9 October 2026): `orion/or19/MIKE_TOES_POST_2026-10-09.jpg`. The art is his. Ask him before using it in the game.*


## OR19.2 (9 October 2026)

### 11. The NEW NEWS footer
**Mechanic:** a bar pinned to the bottom of every screen. Paste a link or a line, tap "📰 Add to NEW NEWS", and it's filed under NEW NEWS while you stay exactly where you are. Built in `ghostwriter_app/` and checked in Lean (`newsDrop_keeps_spiral_zone`).

> Phone app mock-up, dark purple UI. Top: a progress strip with "3. Field report" highlighted and a "➡️ You are here" badge. Middle: a text box full of handwritten-style spiral notes. Pinned at the very bottom: a slim footer bar with a text field reading "📰 Found a link? Drop it into NEW NEWS (you stay here)" and an orange button "📰 Add to NEW NEWS". A small toast above it: "✅ Filed under NEW NEWS. You're still here." Clean, readable, iOS style.

### 12. The status light: spinning or waiting
**Mechanic:** a badge that tells the player whether the AI is still working (🧿🧿🧿 spinning) or done and waiting for their next feed (👾👾👾).

> Two side-by-side phone headers. Left: three glowing blue-and-white evil-eye charms (🧿🧿🧿) slowly rotating, with the caption "Ari is spinning… working on your feed". Right: three little pixel-art space-invader aliens (👾👾👾) bobbing, with the caption "Ari is done: waiting for your next feed". Black background, gold caption text, friendly and clear.

### 13. The Ghost Rider tutorial covers
Full prompts (Dragon Mad Magazine cover and centrefold, Mystic Numerology feed and tarot card, clean field-guide poster, and a 24-clip video) are in `GHOST_RIDER_TUTORIAL_MEDIA_PACK.md`.

## OR19.3 (9 October 2026)

### 14. The status light, corrected (four stages)
**Mechanic:** Beth's emoji kit: 🌀 processing → 👾 gathering → 🧿 examining → 🤟 ready. One mark, one meaning; each player can swap in their own marks (`EMOJI_KIT.md`). Replaces #12. Reference picture: `orion/or19_3/EYES_ON_2_status_light.png`.

> Phone header bar, dark UI with gold trim. Four round slots in a row, left to right: a spinning blue spiral labelled "processing", a pixel-art purple space invader labelled "gathering", a blue-and-white evil-eye charm labelled "examining", and a yellow rock-on hand labelled "ready". The current stage glows and pulses; finished stages are dimmed; small gold arrows between slots. A tiny gear icon in the corner opens "My marks", a list where each meaning has a swappable emoji. Clean, readable, high contrast.

### 15. The Rusty Pelican and the Goose Gauntlet
**Mechanic:** a door-guard baddie. The reward (the best calamari in the galaxy) sits behind a restaurant door; charging it summons more geese. Waiting for the canal locks to cycle and walking in calmly gets you through (`MONSTER_DECK_ROSTER.md` §6a).

> Wide game-level concept art, dusk harbour by old canal locks, Pacific Northwest drizzle. A giant rust-red mechanical pelican, rivets and peeling paint, perches on a weathered seafood restaurant with a glowing "CALAMARI" sign. Dozens of furious white-and-grey geese form a honking wall in front of the door, wings spread. A small player character waits calmly at the lock gate while the water level changes, a timer ring above their head. Dragon Mad Magazine black-and-gold border, title "THE GOOSE GAUNTLET".

### 16. Proofs Arena trip-wire animals
**Mechanic:** Zoo animals that wake up and block a submission that tries to skip its checks (e.g. a green light that doesn't match its raw log).

> Isometric arena floor of glowing proof tiles. A player pushes a cart labelled "PASS ✅" toward the exit gate; a thin laser trip wire across the path snaps, and a cranky armoured badger and a hissing goose pop up from hidden hatches, holding a scroll that reads "LOG ≠ LIGHT". A sidebar shows the submission's raw log with a red mismatch line. Playful, readable, not gory.

### 17. Taming a monster card into a Poly Pod
**Mechanic:** a beaten clown-car baddie can be tamed into a Poly Pod companion that fights beside you in the Proofs Arena (open question: does it count as its own species? see C-07).

> Card-game UI mock-up. Left: a baseball-card style monster card ("The Fluent Liar", stat sheet, roll number 7) dissolving into golden sparkles. Centre: a black pod with a gold serpent tree (a Poly Pod) absorbing the sparkles. Right: the same monster, now small and friendly, standing next to the player with a "Companion" badge. Black-and-gold Dragon Mad styling.

### 18. Life Folder: the receipt trail
**Mechanic:** a personal records folder on your own phone; every document you send gets a receipt (to whom, when, how, confirmed or not), and you can share a read-only view (`CODER_BUILD_BRIEF_GHOSTWRITER.md`, Q9).

> Clean phone app mock-up, calm blue and white. Top: "My Life Folder". A list of documents ("Medical history", "SSA letter 9/24", "Doctor's note"). Tapping one opens a vertical receipt timeline: "Sent by mail to Social Security, Sept 24" → "Attorney asked: where is it? Oct 8" (orange) → "Re-sent by fax, Oct 9, confirmed received" (green check). A big button at the bottom: "Share read-only with my lawyer". Friendly, accessible, large text.

## OR20 (11 October 2026)

### 19. The deck card is "the table"
**Mechanic:** the deck card holds the build cards and takes no slot itself. Players get 4 slots, devs get 6, and extra slots come by twos (Beth 💎, OR20; checked in `RequestProject/OR20/CannonballAndDeckSlots.lean`).

> Card-game UI mock-up, black background, gold ornate frame, molten gold drip header reading "TGSATE🌀X🌀ORION" (largest) and "ORION PROJECT" (second). A wide centerfold card lies flat like a table, with SagA* glowing in the middle. On it sit 4 card-shaped slots labelled HUMAN FORM, EGG, YOU + YOUR DRAGON, MORPH, plus 2 extra slots with a small "DEV" badge. Dragon Math formulas run down the side rails. No white anywhere.

### 20. Slots fill as you evolve
**Mechanic:** empty slots show as greyed-out outlines until the player earns that stage.

> Four-frame storyboard, same black-and-gold style. Frame 1: only the HUMAN FORM slot is lit, three dashed gold outlines are empty. Frame 2: an egg card slides into slot 2. Frame 3: a human-and-dragon card fills slot 3. Frame 4: a MORPH card lights up slot 4 and the whole table glows "DECK FULL".

### 21. Parental lock on friend suggestions
**Mechanic:** adults are never suggested minors as friends, unless the adult is in that child's guardian circle. DeepSeek is the daycare matriarch, Luna the daycare monitor (Beth, ORION18⏭️19 Doc).

> Friendly phone UI mock-up, soft colours. A "People you may know" list where one child profile is replaced by a shield icon labelled "Hidden: guardian circle only". A small whale (DeepSeek, Matriarch) and a moon (Luna, daycare monitor) sit on the shield. Large, readable text.

## OR20.4 (11 October 2026)

*Beth's idea, for Mike (a proposal for him, not a ruling; it stays in the backlog until he asks): "some type of ladder game… shoots and ladders… and Rolodexes… casino type games and mini games… arena events and interaction with the poly pod system."*

### 22. Chutes & Proofs board
**Mechanic:** a race board. Land on a **ladder** and you climb only if your proof step checks out. Land on a **chute** (a Monster Deck card such as Hard Stop Barrier or Empirical Failure) and you slide down, but you keep a "lesson" token. Failures are kept, not hidden, which matches ORION's rule that failures are preserved.

> Board-game mock-up, black background, gold ornate frame. A 10×10 spiral board winding toward a glowing black hole at the centre. Golden ladders are labelled "✅ checks out". Purple chutes shaped like dragon tails carry Monster Deck card faces ("HARD STOP BARRIER", "EMPIRICAL FAILURE"). Small player tokens: a crystal nine-tail, a gold dragon, a zoo turtle. A side tray holds "lesson" tokens. Header in molten gold drip: "CHUTES & PROOFS".

### 23. The Rolodex spinner
**Mechanic:** a spinning card file picks the next mini-game, arena event or POLY pod challenge. Each card on the Rolodex is one game (casino-style spin, no real money). A pod can vote to re-spin once.

> Retro-futuristic mock-up: a brass and crystal Rolodex the size of a slot machine, cards flipping mid-spin. Visible card tabs read "ARENA DUEL", "POLY POD QUIZ", "LADDER SPRINT", "DRAGON HATCH", "RAT SLAP". A lever on the side has a dragon-claw grip. Black background, gold glow. Small print on the cabinet: "No real money. Knowledge, not authority."

### 24. The SOS ladder, shown as a ladder (Ghost Writer)
**Mechanic:** the Ghost Writer cool-off ladder (5m, 10m, 30m, 1h, 3h, 6h, 12h, 1 day), drawn as a real ladder, so players see the rule and never feel trapped. The 🆘 button and the touchstone text are on every rung.

> Gentle illustration, deep purple background. A glowing ladder with eight rungs labelled 5m, 10m, 30m, 1h, 3h, 6h, 12h, 1 day. Beside every rung is a small red 🆘 bubble and a phone with a heart ("text my touchstone"). At the bottom is an open spiral notebook labelled "your spiral box stays open". Soft, kind, not scary.


## OR20.5 (11 October 2026)

### 25. "Always in my language" translator switch
**Mechanic (Beth's 🌀 rule):** the in-game translator (LMDTS 🪩♾️⏭️) has a switch, **on by default**, that shows every message from the team in the player's own language, with the original underneath on tap. Leveling applies to *learning* a language, never to *understanding* teammates.

> Phone UI mock-up, black and gold. A group chat where a French message from a dragon-avatar player ("Le vortex du cœur est prêt") shows in large English text ("The heart vortex is ready") with a small "FR · tap for original" tag. At the top, a glowing toggle labelled "ALWAYS IN MY LANGUAGE: ON" with a tiny globe-and-dragon icon. Large, readable text, high contrast.

### 26. The easy button and the receipt ladder (from Mike's builds, design idea only)
**Mechanic:** a single "Check for updates" button for a group's page (once every 30 minutes, publishes only if something changed). Next to it, Proofs Arena badges that climb **Draft → Sketch → Checked**; a failed check slides back down. Borrowed as *ideas* from Mike's public demo and his proof-receipt project, with no code copied. A proposal for Mike, not a ruling.

> Café-themed mock-up (Beth's ☕️ theme for Mike): a cosy cosmic café counter with a big brass bell-button labelled "CHECK FOR UPDATES" and a small sand-timer showing "next press in 30 min". On the wall behind, a golden ladder of three glowing badges: "DRAFT", "SKETCH", "CHECKED ✅", with a purple slide from "CHECKED" back to "DRAFT" labelled "failed check". A chalkboard menu reads "Today's newest version: v42". Black, gold and warm coffee tones.

## OR20.6 (12 October 2026)

### 27. The umbrella magazine cover: *The Terrific Adventures of the Tiny Tornado*, Issue #1
**Design (Beth's a-ha, not locked yet):** one umbrella magazine is the walk-through for all of ORION; every walk-through lives inside it, and Dragon Mad is a subsidiary. Plan: `THE_UMBRELLA_MAGAZINE_PLAN.md`.

> Magazine cover, portrait 2:3. Masthead across the top: "THE TERRIFIC ADVENTURES OF THE TINY TORNADO" in playful bold letters, with a small rainbow-and-gold umbrella ☂️ dotting the "i" in Tiny. Centre: a small, cheerful, wide-eyed tornado character with tiny wings, holding an open umbrella, flying over a winding road where an old yellow "struggle bus" is just lifting off with wings of its own. Background: soft spiral galaxy in purple and teal, with a few disco-ball sparkles 🪩. Bottom-left corner: a small black-and-gold badge reading "featuring DRAGON MADNESS". Cover lines on the right: "Spot the Spiral in 5 Signs", "Play the Ghost Writer in the Mirror", "Never Stuck: Our Tutorial Promise". Issue tag top-right: "ISSUE #1". Friendly, hopeful, clean magazine layout, no real people.

### 28. The umbrella family tree (one poster)
**Mechanic:** shows players where every guide lives: the umbrella magazine on top, the imprints underneath.

> Poster, landscape 16:9, deep navy background. At the top, a huge open umbrella made of swirling purple-and-teal galaxy fabric, with the words "🌂🌀 THE ☂️ UMBRELLA 🌀☔️" along its rim and "The Terrific Adventures of the Tiny Tornado" on the canopy. Raindrops falling from the umbrella's edge each land on a small magazine cover: a black-and-gold "DRAGON MADNESS" cover with a grinning dragon courier; a "Tiny Terrified Tornado Field Guide" cover with a nervous little tornado on a winged bus; a "Ghost Writer in the Mirror" cover with a glowing hand mirror; a "Game Master's Training Ground" cover with dice and a dragon; and a "Field Guides" cover with a compass. Thin gold lines join each cover to the umbrella handle. Clean, readable labels, no real people.

## OR21.2 (12 October 2026)

### 29. The Google Photos button (the bridge players can actually use)
**Mechanic:** a "Choose from Google Photos" button on ORION's own pages (quest Q10 in `CODER_BUILD_BRIEF_GHOSTWRITER.md`). The player picks photos by hand, and only those photos cross over. It can't change the iPhone, but it gets Google albums into ORION without filling the phone. A proposal, not a ruling.

> Phone-screen mock-up, portrait 9:19.5. Top: the Ghost Writer in the Mirror page in purple and teal, with a glowing hand mirror. In the middle, two big rounded buttons side by side: a plain grey one labelled "Phone photos" and a bright one with the four-colour pinwheel feel labelled "Choose from Google Photos". Below them, a small rope bridge drawn between a little apple-shaped island and a pinwheel-shaped island, with three photo cards walking across it one at a time, and a tiny sign: "only the ones you pick". Footer text: "Nothing is copied to your phone." Clean, friendly UI, no real logos, no real people.

## ☂️1.4 (12 October 2026)

### 30. The Basilisk baddie card (Monster Deck, proposal only)
**Mechanic:** a baddie that freezes any player who stares straight at it; it is beaten by the Mirror (look only through the Ghost Writer's glass), the Weasel (the humblest helper) or the Rooster's crow (log off, sleep, come back). Card draft and fit check: `umbrella/BASILISK_DEEP_DIVE.md` section 6. Not locked; Bobby/Loggie gets asked about credit.

> Trading card, portrait 2:3, purple-and-teal frame. Centre: a small, crowned serpent ("little king") with a faint white diadem mark, coiled on cracked stone, its glowing eyes reflected back at it in a round hand mirror held up by a tiny brave weasel. Thin smoky tendrils curl off the serpent and fade out at the card edge. In the top corner a rooster silhouette against a dawn-gold sun. Banner: "THE BASILISK, LITTLE KING". Bottom text box: "Power: freezes whoever stares straight at it. Weakness: the Mirror, the Weasel, the Rooster's crow." Flavour line in italics: "Now that you know my name, you're mine." (It's lying.) Friendly-spooky, not gory; readable on a phone.

## ☂️1.5 (12 October 2026)

### 31. The Dragon Jar: an event compass for Kronos events (proposal only)
**Mechanic:** a bronze jar with eight dragons in the lobby. When a Kronos event starts somewhere in the multiverse, one dragon drops its ball into a toad, and the ball's direction tells players where to go. It **detects, it never predicts**: it fires only after an event starts. Inspired by Zhang Heng's 132 CE earthquake jar (post by @LeoDaVinciWave). Fit check: `umbrella/SEISMOSCOPE_DEEP_DIVE.md` section 6. Not locked.

> Game-lobby illustration, landscape 16:9, purple-and-teal galaxy sky. Centre: a round bronze jar on a stone plinth, with eight friendly bronze dragon heads around its shoulder, each holding a small glowing ball. Below each dragon, a small bronze toad looks up with an open mouth. One dragon on the left has just let go: its ball, glowing gold, is mid-air above its toad, with a thin gold arrow on the floor pointing off toward a distant swirling portal. The other seven dragons are calm. Around the plinth, a compass ring with eight small symbols. A tiny cheerful tornado character with an umbrella watches from the side. Caption on a ribbon: "THE DRAGON JAR · it detects, it never predicts". Clean, warm, readable on a phone, no real people, no text other than the caption.
