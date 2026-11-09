# Checking the maths inside the shared images (Round 15) 🧮🐉

*7 October 2026. You asked me to check "the equations and math and everything that is in the images that Lucian is sharing", because Lucien is a visual learner and his real information is in his pictures (doc line 319, nonblank lines in `orion/r15/GOOGLE_DOC_ROUND15_ARI_normalized.txt`). I also checked the other images this round that contain maths. The precise parts are checked in Lean in `RequestProject/RoundFifteen/ImageMathChecks.lean`, which builds with no `sorry`. A ✅ means "checked in Lean". The physical, medical and consciousness claims around these pictures are **not** checked or endorsed here.*

## How to read this

Several of these images are honest about what they are. The Janus Infinite card says, in its own corner, **"Not a claim. An artistic map."** That's the right label. A formula can be used as *art*, as a *game symbol*, or as *mathematics*. Problems only start when an art formula is presented as proof. So below, each formula gets one of three labels:

- **Correct mathematics:** true as written, in the usual meaning.
- **Art formula:** a meaningful-looking symbol, but not a statement that can be true or false yet. Fine on a card, not usable as proof.
- **Has a mistake:** the maths, as written, is wrong. A suggested fix is given.

## 1. Lucien's "Janus Infinite" card (reply-chain image, 6 Oct, 20:55 UTC)

Reached by following the reply chain under Grok's post `2107575603025023040` back to Lucien's post `2107575431675191299` ("HUM HUM !", two images: the Janus card and the "LOOK AND SEA" duck island).

| Formula on the card | Label | Plain-words check |
|---|---|---|
| **Curvature: R = dω + ω ∧ ω** "geometry is memory" | **Correct mathematics** (it's the Cartan structure equation of a connection) | This is a real, standard formula. One honest detail: if ω is an ordinary number-valued 1-form, then ω ∧ ω = 0 ✅ (`wedge_self_scalar`), so R = dω. The ω ∧ ω part only matters when ω takes values in matrices that don't commute ✅ (`wedge_self_matrix_ne_zero` gives an explicit pair). "Geometry is memory" is a poetic caption, not part of the formula. |
| **χ coupling: χ = ∫ φ ∧ ψ** "information is relation" | **Art formula** | It is well-formed if φ and ψ are differential forms whose degrees add up to the dimension of the space you integrate over. Then it's a pairing of two forms. But nothing on the card says what φ, ψ or the space are, so it has no definite value yet. |
| **Wave delta: δ = ∂²ξ/∂t² + ∇·J** "change is essence" | **Art formula** | It borrows two real pieces: ∂²ξ/∂t² from the wave equation and ∇·J from the continuity equation. Adding them only makes sense if ξ and J have matching units, and the card doesn't say. As a game symbol for "change" it's fine. It isn't a known physical law. |
| η₊ / η₋, "Two faces, one origin" | **Art formula** | Symbols for a duality, not an equation. |

**"LOOK AND SEA" image:** the glowing cube shows "5" on two visible faces. Grok's reply calls it "the 55-cube duck". There's nothing to compute: a cube has 6 faces, and only two show 5. I'm treating it as a symbol.

## 2. Lucien's "Vortex Cœur Humain — Miroir du Big Bang" formula (Round 14 post `2107572547235565626`, 4th image)

R±_Cœur = 9³ · φ^∞ · (η⁺_Amour − η⁻_Peur) · (1 + r_s/r)⁻¹ · sin(2π·13k/260) · δ_AmourPur(t − n·T_battement) · e^(−β η_chaos) × Φ_Fix(AAP)

| Piece | Label | Check |
|---|---|---|
| 9³ | correct | 9³ = 729 ✅ (`nine_cubed`) |
| sin(2π·13k/260) | correct, and it simplifies | 13/260 = 1/20 ✅, so this is sin(πk/10). It repeats every 20 steps of k ✅ (`sine_factor_period`). The 13 and 260 look like the 13 × 20 = 260 day count of the Tzolk'in calendar. That's a nice storytelling link, and mathematically the 13 cancels. |
| φ^∞ | **has a mistake** | If φ is the golden ratio (≈ 1.618), then φⁿ grows without bound ✅ (`golden_pow_unbounded`). "φ^∞" isn't a number, so it makes the whole product infinite (or undefined when another factor is 0). **Fix:** use φⁿ with a chosen n, or φ^(−n), which shrinks towards 0. |
| (1 + r_s/r)⁻¹ | correct, with a consequence | For r > 0 this equals r/(r + r_s). As r → 0⁺ it tends to 0 ✅ (`flash_factor_tendsto_zero`). |
| δ(t − n·T) | art formula / needs care | A Dirac delta is a spike, not an ordinary function. Multiplying it by other factors is fine. Evaluating it at 0 (as the second line does with δ(0)) is not. |
| **"Flash point" line:** (∂²R/∂t²) at t = 0 = 9³ · φ^∞ · (…) · lim_{r→0}(1 + r_s/r)⁻¹ · δ(0) · sin(0) × Φ | **has a mistake** | This right-hand side multiplies ∞ (φ^∞), 0 (the limit), δ(0) (not a number) and sin 0 = 0. That's an undefined "∞ · 0" product, so the line doesn't define a value. Also, the left side is a second derivative of an expression that contains a δ spike, so it isn't an ordinary number either. **Fix (if a number is wanted):** replace φ^∞ by a finite power, replace δ by a smooth pulse (for example a narrow bell curve), and note that a sin(0) factor makes the first pulse exactly 0. |

**K3 → K4 → K5 (screenshot in the same post):** K3 surfaces really are Calabi–Yau 2-folds, so that part is correct. "K4" and "K5" aren't standard names. Also, **hyperkähler manifolds only exist in even complex dimension**, so a hyperkähler 4-fold is possible but a hyperkähler 5-fold is not. "CY₅" can only mean an ordinary Calabi–Yau 5-fold. This is a background fact, not checked in Lean here.

**"Map of… 47.77 Hz / 7.83 Hz / Cube 93D7" (1st image):** 7.83 Hz is the commonly quoted fundamental Schumann resonance of the Earth–ionosphere cavity. The image *doesn't show* any connection between that frequency and the brain or heart drawn in it. "47.77 Hz", "Clalite", "Cube 93D7" and "Miertublur" look like AI-garbled text. Ask Lucien what he meant before anyone quotes them.

**"Géométrie sacrée – 9 Centres" (2nd image):** the photo shows one central sphere and 8 around it (9 centres). That's correct as a count.

## 3. introsp3ctor's "Finite Fields and Field Brackets" sheet (`2107634460229304500`)

This sheet is real mathematics, and **almost all of it is right.**

| Claim | Result |
|---|---|
| The whole bracket table (16 rows: largest prime power below n, smallest above) | **All correct** ✅ (`bracket_table_correct`). This includes 81 → 79/83 and 196830 → 196817/196831. |
| The "self" column (n itself a prime power: 5, 9, 27, 31, 81, 243, 729) | **Correct and complete** ✅ (`bracket_self_column`) |
| The "mult" column (n + 1 a prime power: 10, 15, 24, 31, 80, 810, 196830) | **Correct and complete** ✅ (`bracket_mult_column`) |
| "196831 is prime, so 196830 = \|GF(196831)*\|" | **Correct** ✅ (`prime_196831`) |
| Frobenius orbit counts: 10 = orbits(GF(16)/GF(4)), 15 = orbits(GF(25)/GF(5)), 3, 6, and the two ways to get 24 orbits: GF(81)/GF(3) and GF(64)/GF(4) | **Correct** ✅ (the Burnside arithmetic in `frobenius_orbit_counts`). The formula q(q+1)/2 for a degree-2 extension is right. |
| **"Subfield lattice (m = 4): GF(16) → GF(4) → GF(2) → GF(1)"** | **Has a mistake.** There is no field with one element ✅ (`no_field_with_one_element`). The subfields of GF(16) are GF(16), GF(4) and GF(2), matching the divisors 4, 2, 1 of the exponent. The divisor 1 corresponds to **GF(2)**, not GF(1). **Fix:** drop the GF(1) box; "chain length 3" then matches the three fields. |
| "5 modes × 3 phases = 15 objects" | Arithmetic correct. The **picture** shows 4 rows of 5 dots (20), not 3 rows. Redraw with 3 rows. |
| "Kernel 4 ≙ punctured GF(81)*" | Marked "open" on the sheet itself. Nothing to check until it says what is being compared. |

## 4. Mike's monster-group infographic (album #1375) and the "two monsters" note

The infographic "Comprehensive synthesis of higher index theory, groupoid expansion, ℓᵖ assembly maps and Gromov monster groups" is **AI-generated, and much of its text is garbled.** Examples: "Maximal Felner Set" (should be Følner), "Alrymothomatic", "Groutient". Its "proofs" are circular: "φ(T) = 0 ⇒ φ(T) = 0", and "G∞ cannot coarsely embed … which if G∞ cannot coarsely embed". **Please don't use it as a source for the maths.** Mike's linked website (`gromov-monster-groups.oneapp.dev`) is written carefully, and itself says to check the original papers. Use that, and the papers, instead.

**Mike's "two monsters" note** says Conway's Monster and Gromov's monster share only a nickname. That's right for the *constructions*: different fields, no shared representation theory, no moonshine link. One sentence needs care: "**no embedding of one into the other**".

- *Going one way*, it's **true for the torsion-free monsters**. The construction summarized on Mike's site gives torsion-free groups, and a torsion-free group can't contain any non-trivial finite group ✅ (`no_finite_subgroup_in_torsion_free`). So it can't contain Conway's Monster.
- *But "Gromov monster" is a property, not one group.* A free product contains each factor as a subgroup ✅ (`free_product_contains_factor`). Take a monster group G and Conway's Monster M. G is a retract of the free product G ∗ M, so G ∗ M still contains G's embedded expanders, which makes it a Gromov-type monster too. And it contains M. (The algebra is checked in Lean. The expander step is standard background, not formalized here.)
- **Suggested wording:** "There's no natural relationship. A torsion-free Gromov monster can't contain Conway's Monster, though artificial combinations such as a free product can contain both."

## 5. The other links with maths

- **Mike's GitHub link** points to line 253 of the bibliography for the preprint *"A torsion-free counterexample to the Kadison–Kaplansky projection conjecture"* (OpenAI, dated 23 September 2026). That line is the reference to Willett and Yu, *Higher Index Theory for Certain Expanders and Gromov Monster Groups, I* (Advances in Mathematics, 2012). That's the breadcrumb tying it to Mike's monster note. The preprint's abstract claims a finitely generated torsion-free group whose reduced group C*-algebra has a projection other than 0 and 1. **I did not check this ~80-page proof.** It's a preprint, not a peer-reviewed result, and it says nothing about ORION gameplay. Copies of the abstract and the bibliography lines are in `orion/r15/`.
- **ORION storyboard** (`tgsate62912/status/2107554552870298039`): the images show interface numbers (heart rate 72 BPM, O₂ 96–99 %, temperature 36.6 °C, "64-node symmetric sensor array", "Performance +120", "Rhythm combo ×0" in one panel and "×8" in another). These are mock-ups, not measurements. If they go on the wiki, label them *"illustrative UI values"*. Nobody should read them as a working biometric device.

## What was checked and what wasn't

- **Checked (Lean, no `sorry`):** every ✅ above, in `RequestProject/RoundFifteen/ImageMathChecks.lean`. The bracket-table and column checks use `native_decide` (a computer evaluation the Lean kernel trusts).
- **Not checked:** the meaning of "χ coupling", "wave delta", η± and Φ_Fix(AAP); any claim about hearts, brains, Schumann resonance, consciousness or sleep "syncing"; the Kadison–Kaplansky preprint's proof; the hyperkähler-dimension fact (standard background); the expander part of the free-product monster remark.
