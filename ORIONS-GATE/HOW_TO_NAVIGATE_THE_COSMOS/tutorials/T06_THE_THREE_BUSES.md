# T06. The three buses: Kronos, KRION and Orion playlists 🚌🚌🚌 (proposal)

*Round 16, 7 October 2026. From Beth's note: "The idea for the playlist was that it would load with what I have and split into three different buses … if I say crayon I mean KRION … so the playlist would be Kronos, KRION and Orion based builds and people could add to the playlist their music that they're listening to from those … energy fields, so the people who enjoy those types of energy fields could hop to different genres to experience, and we could all get to know each other a little bit better by sharing things we enjoy with people who like similar things. 🤷‍♀️ wow, we're all trying to save the world together."*

**Glossary note:** "crayon" in dictation = **KRION**. Recorded in `ORION_BUILD_GLOSSARY.md`.

## The design, as I understand it

1. **The starting load:** your 57-track playlist (the "Bus" moodboard).
2. **Three buses**, one per **energy field**, not per genre:

| Bus | Energy (from the place energies in `ORION_GAME_MANUAL.md`) | Feels like |
|---|---|---|
| 🔥 **Kronos bus** | Fire, high kinetic (the Chronicles) | drive, protest, fight songs, momentum |
| 🌍 **KRION bus** | Earth, water and air; community (Elder's Garden, the Playground, the Gate) | roots, togetherness, healing, gratitude |
| ⚡ **Orion bus** | Lightning, whimsical knowledge flow (the Ascent) | wonder, curiosity, the strange and beautiful |

3. **Anyone can add** songs they're listening to that carry that energy, whatever the genre.
4. **People ride the bus whose energy they like**, and meet others there. That's the point: getting to know each other through what you enjoy.

**These descriptions are my starting guesses from the manual. You define the energies; please correct them (O-3).**

## How to set it up today (no game needed)

1. On Spotify (and YouTube if you like), make **three new playlists**: "ORION Bus: Kronos 🔥", "ORION Bus: KRION 🌍", "ORION Bus: Orion ⚡".
2. Copy each of your 57 songs onto the bus whose energy it carries. Or ask three friends to sort them, one bus each.
3. Turn on **collaboration** for each bus (T02) and share the three invite links.
4. Keep your original 🔥🌎🔥💜🌎💜 as the **master** that only you edit.
5. Make a **fourth, clean bus** for under-18s later, checked song by song.

## The maths of sorting (checked)

If every song rides exactly one bus, the three bus counts always add up to the whole playlist: no song lost, none counted twice. That's proved in Lean for any playlist and any sorting (`RequestProject/RoundSixteen/PlaylistBuses.lean`, theorem `bus_counts_add_up`). **O-4:** can a song ride **more than one** bus? If yes, the counts can add up to *more* than the playlist, and the game should say "this song also rides the Orion bus" rather than counting it twice.

## In the game (later)

- The Bus that brings players to the Engine plays from one of the three, based on the energy the player picks at the start.
- Players can add songs to a bus from their Singularity, with credit ("added by…") shown on the track.
- The music in the game itself needs licences or original music; until then, buses link out to Spotify or YouTube.
- Moderation: the spam filter applies to song adds, and the under-18 bus only shows checked songs.
