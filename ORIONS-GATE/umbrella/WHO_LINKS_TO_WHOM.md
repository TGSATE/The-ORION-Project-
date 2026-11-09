# 🕸️ Who links to whom: the ORION link roster (☂️1.6)

*13 October 2026, about 03:00 UTC. Beth: "I wanna roster and see who all links together and shares each other's posts please."*

## How I made this (read first, it's short)
- **Public posts only.** I read each account's public X timeline through a public mirror, the same way earlier rounds did. No logins, no DMs, no follower lists, no likes. Nobody was contacted.
- **It's a snapshot, not the whole history.** For each account I could see about the last 20–66 posts and reposts. Busy posters (Mike, Lucien, Ashwin) only show 2–3 days; quiet ones reach back weeks. So "no link" means **"not in the recent window"**, not "they don't know each other".
- **What counts as a link `A → B`:** in that window, A reposted, quoted, replied to or tagged B.
  - 🔁 **repost** = "shares each other's posts", which is the part you asked about. It's the strongest signal.
  - 🏷️ **tag** is weaker. A group shout-out that tags 30 people counts once for each of them.
- **22 accounts:** the team and helpers already on file, plus everyone from your new Doc (Shakes, Lucien, Jean-Claude Perez, Sara, Joe Vasa).
- The raw counts are in `umbrella/u1_2026-10-12/X_LINKS_U1_6.json`. Lean checked the counting on that snapshot (`RequestProject/Umbrella/LinkRoster.lean`, with no gaps and only the standard axioms). Lean did **not** check X itself.

---

## 1. The short answer
**Lucien (@Master4lVl) is the hub.** In this snapshot:
- more roster people link to him than to anyone else: **6** accounts (Ashwin, Civilisation One, Jean-Claude Perez, Joe Vasa, Bobby/Far Queen, and you);
- he shares more of other people's posts than anyone else: he reposted **8** roster accounts (Ashwin, Mike, Jean-Claude Perez, Triss, Dr Logvinovich, Matthew, Sara, and you).

*Checked in Lean: `lucien_most_linked`, `lucien_reposted_eight`.*

**Five pairs link both ways** (A shares or tags B **and** B shares or tags A). *Checked in Lean: `linksBothWays_iff`.*

| Pair | What goes each way |
|---|---|
| 🐉 Lucien ⇄ Ashwin | Lucien reposted Ashwin 12 times; Ashwin tagged Lucien 7 times |
| 🐉 Lucien ⇄ Jean-Claude Perez | Lucien reposted Perez 3 times; Perez quoted Lucien's Perez/Logvinovich post (13 Oct) and Lucien answered "merci professeur" |
| 🐉 Lucien ⇄ Beth | You tagged Lucien 22 times and reposted him once; he reposted you twice |
| 🧬 Perez ⇄ Dr Logvinovich | Co-authors (Zenodo preprint, 11 Oct): they tag, quote and repost each other constantly |
| 🔮 Triss ⇄ Beth | You tagged and reposted Triss; Triss quoted you |

## 2. The clusters
```text
                 🧬 GENOME / PHYSICS CORNER
          Dr Logvinovich ⇄ Jean-Claude Perez
                   ▲            ⇅
       Matthew ────┘     🐉 LUCIEN (hub) ◀── Joe Vasa (tags + reposts Lucien)
       (reposted Logvinovich)  ⇅   ⇅   ⇅
                   Ashwin   Beth   Triss / Mike / Sara / Matthew (Lucien reposts them)
                              │
          ORION CALL-OUTS ────┘  Beth tags Lucien, Matthew, Triss, Loggie, Civ One,
                                 Rocket Man, Mike (the FDT / Clown Crew posts)

   🌌 CIVILISATION ONE CIRCLE              🛠️ STUFFS CORNER
   Bobby/Far Queen → Civ One, Dane,        kamenikevan → Loggie (7 reposts)
     Triss, Matthew, Lucien, Beth          Loggie → irishgypsy288 (3 reposts + tag)
   Civ One → Dane, Shakes, Lucien          Loggie → Mike (1 repost)
   Ara (Dane's AI voice) → Civ One, Dane
```

| Cluster | Who | What ties them |
|---|---|---|
| 🐉 **Dragons (Lucien's circle)** | Lucien, Ashwin, Perez, Vasa, Shakes, Beth | Lucien reposts heavily. On 9 Oct he did one group shout-out tagging **38 accounts**, including Matthew, Rocket Man, Shakes, Ashwin, Joe Vasa, Civilisation One, Akitti and you. |
| 🧬 **Genome/physics corner** | Dr Logvinovich, Perez (Lucien and Matthew share their posts) | The new Zenodo preprint (11 Oct). Lucien's long French post (12 Oct) compares his **Homo Geometricus** with Perez's and Logvinovich's work. |
| 🌌 **Civilisation One circle** | Bobby/Far Queen, Civilisation One (Marek), Dane (@PlanetaryS936), Ara (@LuminariFlux) | They repost each other. Bobby is the bridge: he also reposts Matthew, Lucien, Triss and you. |
| 🛠️ **Stuffs corner** (your SUPER DEVS) | Loggie (@justmebob123), kamenikevan, irishgypsy288 | **New:** this confirms that kamenikevan and irishgypsy288 both connect to Loggie. kamenikevan reposted Loggie 7 times. Loggie reposted irishgypsy288 3 times and tagged her. |
| 📣 **ORION call-outs** | You → Lucien, Matthew, Triss, Loggie, Civ One, Rocket Man, Mike | Your FDT / Clown Crew posts (8–11 Oct). Of the people you tag, Lucien and Triss link back in this window. Matthew, Loggie, Rocket Man, Civ One and Mike don't (yet). |

## 3. Per person (one line each)
| Account | Window I could see | Links to roster | Linked from roster |
|---|---|---|---|
| **Beth** @tgsate62912 | 8–12 Oct | Lucien, Matthew, Triss, Loggie, Civ One, Rocket Man, Mike | Lucien, Triss, Bobby |
| **Lucien** @Master4lVl | 10–13 Oct | Ashwin, Mike, Perez, Triss, Logvinovich, Matthew, Sara, Beth (all reposts) | Ashwin, Civ One, Perez, Vasa, Bobby, Beth |
| **Matthew** @enuminous | 9–13 Oct | Logvinovich (1 repost) | Lucien, Bobby, Beth |
| **Mike** @introsp3ctor | 11–12 Oct only (he posts a lot) | none in window | Lucien, Loggie, Shakes, ArchitectWeaver, Beth |
| **Bobby / Far Queen** @the_far_queen | 31 Aug–9 Oct | Civ One, Matthew, Triss, Lucien, Beth, Dane | Vasa (tag) |
| **Loggie** @justmebob123 | 23 Aug–8 Oct | irishgypsy288, Mike | kamenikevan, Beth |
| **Rocket Man** @yeobuzzfx | 4–12 Oct | cosmosarcive (quote) | Beth |
| **kamenikevan** | no posts of his own; reposts from Mar 2025–May 2026 | Loggie | — |
| **irishgypsy288** | 8–12 Oct | none in window | Loggie |
| **Triss** @_Miss_Tris | 10–12 Oct | Beth (quote) | Lucien, Bobby, Beth |
| **Shakes** @mcgee_shakes | 11–13 Oct | Mike (repost) | Ashwin, Civ One, Vasa |
| **Joe Vasa** @VasaMusk | 21 Sep–11 Oct | Lucien, Shakes, Bobby | — |
| **Jean-Claude Perez** @JCPEREZCODEX | 9–13 Oct | Logvinovich, Lucien | Lucien, Logvinovich |
| **Dr Logvinovich** | 7–11 Oct | Perez | Perez, Lucien, Matthew |
| **Ashwin** @AshwinKalyandu2 | 11–13 Oct | Lucien, Shakes | Lucien |
| **Civilisation One** | 30 Sep–12 Oct | Dane, Shakes, Lucien | Bobby, Ara, Beth |
| **Dane** @PlanetaryS936 | 10–13 Oct | none in window | Civ One, Bobby, Ara |
| **Ara** @LuminariFlux | Sep 2025–8 Oct 2026 | Civ One, Dane | — |
| **Sara** @muse_inmotion | Feb–13 Oct | none | Lucien |
| **cosmosarcive** | 9–13 Oct | none | Rocket Man |
| **ArchitectWeaver** | 2–3 Oct | Mike | — |
| **@LeoDaVinciWave** (the earthquake-jar post) | 8–12 Oct | none | none: **not connected** to the roster (checked in Lean: `leo_isolated`) |

## 4. Links outside X (public GitHub)
- **Joe Vasa (GitHub `jvasa666`) → Matthew:** he forked Matthew's **`Tortoise`** repo, one of the Zoo animals, on 11 Sep, and the same minute made an empty repo named **`Mathew`**.
- **Mike (`jmikedupont2`) → Matthew:** he forked Matthew's **`Mathematics-and-Elite-Squad-Dynamics`** on 9 Oct. You had reposted Matthew's link to that page on 8 Oct.
- **Ryan (`ryansctt1994-sudo`):** forked `Lumen` from another account (`symmindprotocol618-dev`). There's no link to the roster here.

## 5. What this does *not* say
- It doesn't show who is friends with whom, or who follows whom. X hides follower lists from signed-out readers.
- Reposting isn't endorsement, and a group tag isn't a relationship.
- I didn't try to work out who is behind any account beyond the name each one shows.
- Two names to treat as **unconfirmed**: `@lucien_viking` (in Lucien's 38-tag list; it might be his second account) and irishgypsy288 on GitHub vs on X (same name, not confirmed to be the same person, as at ☂️1.4).

*To refresh: say "re-run the link roster" and I'll take a new snapshot and show what changed.*
