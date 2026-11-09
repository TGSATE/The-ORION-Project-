# ORION shared photo album: Round 14 recount and review

*7 October 2026. Beth said she updated the [shared ORION album](https://photos.app.goo.gl/dpuRnsEEQP4gi9FL9) after the earlier 300-image pass. This is a new snapshot, not a statement that the live album cannot change again. The earlier report remains in `ORION_IMAGE_DEEP_DIVE.md`. This report does not prove the provenance, correctness or clearance of any picture.*

## 1. What changed

The album's public listing exposed **1,333 media records** in this snapshot. The first 300 media IDs from the Round 12 index are still present (the earlier report called them “images”; the current album metadata also includes video poster frames among the older records). Comparing ID sets finds **1,033 additional records**: **1,021 stills + 12 videos**. Of those new records, 224 were added on 1 October, 552 on 5 October and 257 on 6 October (album metadata, US Eastern time). The old 300 were added in two batches of 74 and 226. The counts of old/new IDs and new videos in the copied index are **checked in Lean** (`RequestProject/RoundFourteen/SnapshotCounts.lean`); collection from the external live site is not formally verified. A live album count may shift while work continues.

`orion/r14/ALBUM_INDEX_1333.tsv` contains *all* IDs and their displayed order, whether previously reviewed, upload and capture timestamps, image/video indicator and dimensions. An ID is not an authorship or publication permission. The entire **new still-image set** was downloaded temporarily for this review; it was **not** committed to the project. Numbered contact sheets covering all 1,033 newly indexed records were viewed; for videos, only their displayed poster frames were viewed, **not the clips themselves**.

## 2. Important privacy alert — inspect before reposting

**Six photographs embed precise GPS coordinates in their original files: album numbers #713, #714, #715, #716, #717 and #1129.** #713–717 show Beth's handwritten Greedy rules (photo paper, not AI art), and #1129 is another phone photo. The album link is shareable; **the metadata may disclose a location to anyone who obtains the originals**. This project deliberately contains neither those originals nor the coordinates. Remove GPS before forwarding to the team or adding these files to a public website; preserve unmodified originals privately if needed. Also review names, faces, personal histories and third-party marks across the other items before bulk export. A contact sheet is **not** an approval to publish someone else's work.

There are **7 HEIC files** among the new stills (including these photographs). They require a HEIC-compatible metadata reader; an earlier PNG/JPEG/WebP scanner alone would have missed the coordinates. The preliminary still-image container check found **no trailing appended bytes** on the 1,014 PNG/JPEG/WebP files scanned; it cannot rule out embedded data elsewhere, and it did **not** parse HEIC internals or scan video streams. Two low-bit printable runs in stills (#323, #876) looked repetitive rather than intelligible, but this is not a comprehensive steganography analysis. Please do **not** repeat the earlier unconditional “no hidden data in any image” claim for this newly expanded album. GPS in six originals is a concrete hidden-metadata finding.

Provenance strings in downloaded originals: 902 contained `trainedAlgorithmicMedia` in image bytes; **that does not say who commissioned the art, that every other image was non-AI, or that publication rights are clear.** Photo numbers and specific third-party branding require their own review. The images inside the paper photos are physical notes, not “a mathematically proved game.”

## 3. What can be seen (visual index, not a transcription of every pixel)

| Album number (snapshot) | Visible theme | Consequence |
|---|---|---|
| #301–#373 | cube / calendar / math-lore illustrations, energy diagrams, headers | Many symbols are illustrative; verify any number before calling it a scientific or mathematical result. |
| #374–#510 | collage of identity, AI imagery, world, writing and astrology/geometry | Treat charts as design concepts; scientific claims require independent evidence. |
| #511–#713 | language diagrams, colorful notes, diagrams of game routing, character art | If included on a wiki, credit each creator and separate speculative lore from checked mechanics. |
| #713–#717 | five camera photos of **Greedy** handwritten sheets | These are new source material for the Game Master training ground. They describe six dice, scoring combinations and rounds; text remains partly ambiguous. Don't compute payout/bust odds or implement as a canonical rule from an incomplete transcription. **Remove location metadata before sharing.** |
| #718–#900 | UIAR / figures / world art and screenshots; several watermarked or sourced-looking visuals | Require a per-image provenance check and selective redaction before public use. |
| #901–#1130 | diagrams, mathematical/linguistic art, motto/character sheets, platform screenshots | The middle of this set includes further safety, academy and game material, with #1129 a geotagged photo. |
| #1131–#1303 | character and platform art, device/console mockups, writing/game diagrams, short video poster frames | Story and interface references only, not an executable UI or a verified prototype. |
| #1304–#1308 | five large, readable “GREEDY GAME / 2026” scoring mockups | Some printed versions disagree or have nonsensical columns (“2 pair”/“3 of a kind” in six-dice sets, different units). Treat as **draft mockups**, not proof that the handwritten rulebook has been accurately digitized. |
| #1309–#1333 | music/dragon/lore posters, short clip posters, personal imagery | Separate music moodboard and game assets from publication/third-party permissions. |

In particular, #1305 says a three-pair combination scores 1,000 while a printed “SIX OF A KIND” line says 5,000 and some cards give overlapping labels; #1307 includes a baffling “two pair” table. These are **visual mockups**, not a fully consistent canonical rule sheet. The photos #713–717 are the stronger source; ask Beth for a **typed** full base-rules version, including whether a 2-of-a-kind pair scores, what happens on bust/re-roll/bank, and how a round ends. Earlier Round 9 “Greed” odds were explicitly for a *different assumed game*.

## 4. What remains

- Upload a **metadata-stripped** copy of #713–717 (or a typed transcription) and clarify ambiguous scoring; do not publish the originals with GPS.
- Have each maker approve art used on a public page and mark images containing copyrighted marks, stock watermarks, personal data or speculative scientific statements for review. Prior 13 flagged watermarks are in `ORION_IMAGE_DEEP_DIVE.md` §3; new images have **not** been individually rights-cleared.
- Review all 12 videos if their contents matter, not only thumbnails. Analyze any specific suspect file at full resolution rather than asserting universal absence of hidden material. The original stills were held outside the deliverable during this review for privacy; the project keeps only the index and metadata summary without GPS.
- Recount the live album after further additions, rather than reusing the 1,333 figure as a permanent invariant. The Lean arithmetic in `RequestProject/RoundFourteen/SpamFilterAndRules.lean` verifies the **sum of the recorded counts**, not the externally hosted album's current state.

## Round 15 recount (7 October 2026)

The album now lists **1,384 media records**. All 1,333 Round 14 IDs are still present, and **51 are new (33 stills + 18 videos of about 10 seconds each)**, all added on 6 October 2026. Index: `orion/r15/ALBUM_INDEX_1384.tsv`; the arithmetic is checked in Lean (`RoundFifteen.album_recount`). The 33 new stills were downloaded as originals and checked for metadata: **none contains GPS or camera-location data**. The 9 phone screenshots carry only a screenshot timestamp, and the Meta-style images carry editing (XMP) metadata. The six Round 14 photos with GPS (#713–717, #1129) are still in the album, so that warning stands. The new videos were seen as poster frames only. **#1348 is a news photograph of a real politician:** remove it before the album is shared publicly. Item-by-item notes: `ORION_BREADCRUMB_TRAIL_R15.md`, Trail G.
