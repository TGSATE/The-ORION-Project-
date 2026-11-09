# ORION image deep dive: is there math or code buried in the pictures?

*6 October 2026. Requested in the Round 12 doc: "A lot of the images have actual mathematical code buried inside of them, if you could go and do a deep dive in all of the images we have shared and see if you can recognize any patterns."*

**Round 14 correction (7 October):** This is a **historical snapshot of 300 album records**, not a statement about the current album. The live album now lists **1,333 items** and **six newly indexed original phone photos carry precise GPS location metadata**. The unqualified “no hidden data” claim in §1 applies only to the limited older checks and should **not** be applied to the new album, nor treated as a proof of absence of steganography. See `ROUNDS_1-14_ARCHIVE/ORION_ALBUM_ROUND14_REVIEW.md` for a corrected scope, privacy warning and typed-rule request.

**What was examined:**
- all **300** images in the shared ORION photo album, downloaded as originals;
- the **33** images already stored in the project.

**Where the evidence is (`orion/r12b/`):**
- `ALBUM_INDEX.tsv`: image number → album ID → source type → size;
- `ALBUM_FORENSICS.json` and `LOCAL_IMAGE_FORENSICS.json`: per-image results;
- `forensic_checks.py`: the script that ran the checks;
- `numbered_contact_sheets/`: sheets `s00`–`s14`, 20 images each. Image *n* is on sheet ⌊(n−1)/20⌋.

---

## 1. The short answer

- **No hidden data was found.** None of the 300 images hides a message, file or code inside it. Section 2 lists the checks.
- **The math is in plain sight.** The real "math in the images" is drawn visibly on the art: cube numbers, the 13-month calendar, the golden ratio, sacred-geometry figures and physics formulas. The numbers that can be read clearly are **correct**, and they are now checked in Lean (§4).
- **Most small text is not real.** Most tiny "equations" and lettering on the AI-generated posters are AI pseudo-writing: shapes that look like symbols but don't spell anything. They carry no encoded meaning.
- **One genuinely invisible mark.** Four images contain Google's **SynthID** watermark. It marks the picture as AI-made and can't be read as a message.

---

## 2. Hidden-data checks (all 300 + 33 images)

| Check | What it looks for | Result |
|---|---|---|
| Data after the image ends | files or text glued onto the end of the image file | **none** in any image |
| Text in the lowest bit of each pixel | the classic way to hide a message in a picture | **no readable text** |
| Statistical "pairs of values" test | tell-tale evenness that appears when data is packed into the low bits | **no sign** of embedding |
| QR codes and barcodes | anything scannable | **none decodable**. Image 5's "QR NODE, Newkin Council" square is drawn by an AI and is not a working code. |
| Metadata (EXIF, XMP, IPTC, C2PA) | text, coordinates, notes, the creator tool | provenance only (§3); no hidden notes |

---

## 3. Where the images came from (from their metadata)

| Count | What the metadata says | Notes |
|---|---|---|
| 4 | Google generative AI (C2PA certificate + SynthID watermark) | images 1–4 |
| 2 | ChatGPT / OpenAI image generator (C2PA) | |
| 31 | tagged "AI-generated" (IPTC) and exported via Facebook/Meta | most likely Meta AI |
| 59 | WEBP tagged "trainedAlgorithmicMedia" (AI) | |
| 1 | PNG tagged AI (IPTC) | |
| 62 | phone screenshots | |
| 6 | Picasa-tagged JPEG | |
| 108 + 27 | no metadata (JPEG / PNG) | many are 1168×784, Grok's usual size; images 25 and 208 show a visible Grok mark |

**Third-party watermarks.** These can't be credited to Beth as-is. Check permission or replace them before public use. This is a flag, not legal advice.

| Image(s) | Visible mark |
|---|---|
| 110, 113, 114, 117, 118, 126, 147, 149 | **dreamstime** (stock-photo watermark) |
| 145 | stablediffusionweb.com |
| 139 | x.com/0kncn |
| 133 | AIONTHEFLY |
| 136, 137 | "NEW EARTH" |
| 96 | the Grusch-claims poster (third-party) |
| 140 | looks like a microscope photograph; source unknown |
| 82–106 | a **French-language series** (Janus cube, "4 Piliers du Temps", "9 = Complétude", "Triskaideka 13"); author unknown |

---

## 4. The patterns that *are* there (visible)

| Pattern | Where | What it is | Checked |
|---|---|---|---|
| **93³ = 804,357; 39³ = 59,319** | image 46 (Cuby poster) | the Cuby-93 and 39-grid cube numbers | ✅ Lean `cuby93_cube`, `grid39_cube` |
| **13 months × 28 days + Year Day** | image 46 | the 13-month calendar: 13 × 28 + 1 = 365 | ✅ `thirteen_month_calendar` |
| **4,563 nodes each** | image 46 | 59,319 = 13 × 4,563, so the grid splits evenly into 13 months | ✅ `grid_splits_into_thirteen_months` |
| **"Erdős–Straus 4/39"** | image 46 | 4/39 = 1/13 + 1/40 + 1/1560 (three different unit fractions) | ✅ `erdos_straus_39` |
| "395,319" and "393" | image 69 | AI rendering slips of 59,319; **not** 39³ | ✅ `garbled_reading_ne_grid` |
| **144 → 000** (Kronos → Orion) | several | 144 is the 12th Fibonacci number | ✅ `kronos_144_is_fib_12` |
| **φ labels** 1.618…, 0.618… | image 25 | golden ratio: φ² = φ + 1, 1/φ = φ − 1 | ✅ `phi_sq`, `inv_phi`, `phi_bounds` |
| Metatron's Cube, Flower of Life | many | sacred-geometry figures (13 circles / 19 circles) | figure only |
| **64-node suits (4 × 16)** | card art | 4 suits of 16 | figure only |
| **20 constitutional axes; H₁ → 0** | images 76–77 | match Far Queen's **twenty vows** and FieldCore's "holes close" ground state | ties to FieldCore proof (Round 12) |
| **Far Queen's seven rooms** | **images 75–81** | Octave, Last-Approach, Bridge, Higher-Watch, Gate (1-bit governor / Psi-zero return), Far-Seeing, Working-Interval: the same seven rooms as in the story *Gabrielle: The Far Queen Wakes* | matches the text |
| Schrödinger equation, uncertainty principle, spacetime interval, E = hν | several posters | standard physics formulas, drawn as decoration | correct as drawn where legible |
| Schumann resonance **7.83 Hz**; "**47.77 Hz**" | posters | 7.83 Hz is the real Earth–ionosphere resonance; 47.77 Hz has no standard meaning I could confirm | — |

All Lean checks are in `RequestProject/RoundTwelve/AlbumMathAndRulings.lean`. The file builds with no `sorry`.

---

## 5. What this means for platform art

- **Good to use (Beth's, per her 💎 rule):** album images that weren't shared in from someone else's link, with the AI generator named where the metadata shows one.
- **Lucien's:** the Mad Magazine style art, the "high-context coded dragon math", the "Karen manager" art and the QB art (Beth's 💎). See `ORION_FOUNDERS_CREDIT_LEDGER.md`.
- **Don't use without permission:** the watermarked images in §3.
- **Art that shows numbers:** prefer the legible, checked numbers (§4). Garbled AI digits (such as image 69) should be redrawn before the art is used as "official math".
