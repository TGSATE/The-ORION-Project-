module

public import Mathlib

/-!
# Round 24: Beth's new rules, written down and checked

* **Playground call-outs and replies (Beth).** A call-out post on the Playground has a full
  explanation, **up to 10 images**, a **four-panel storyboard** and a **250-character
  shout-out**. Each reply underneath works like a volunteer sheet: a **250-character summary**
  of why you want to join, plus **exactly four player cards**.
* **Never stuck in the tutorial (Beth).** The tutorial is a stress test of "how to get people
  moving and not frustrated". Modelled here as a help ladder: every failed try raises the help
  level, help never goes back down, and after a fixed number of tries the player is always
  offered the full walkthrough.
* **Photo metadata (Beth).** Only flag a photo when its metadata carries identity details
  (legal name, home address, Social Security number, phone number). GPS position, phone model
  and time stamps are *not* flagged under Beth's rule.
* **The v5.7.1 torus patch (from Beth's Gemini summary).** Major radius `R = 3`, minor radius
  `r = 1`. Every point of that torus stays at least distance 2 from the axis, so the plot is a
  ring with a hole and never folds through its own centre.

These are models of written rules, not running game code.
-/

namespace RoundTwentyFour

/-! ## 1. Playground call-outs and replies -/

/-- The character limit Beth set for shout-outs and reply summaries. -/
public def charLimit : ℕ := 250

/-- The maximum number of images on a main call-out post. -/
public def maxImages : ℕ := 10

/-- A main Playground call-out (an Ascent or Chronicles request, or a guild recruitment). -/
public structure CallOut where
  explanation : String
  images : List String
  panels : List String
  shoutOut : String
  deriving Repr

/-- A reply under a call-out: a short summary and the player cards put down. -/
public structure Reply where
  summary : String
  cards : List String
  deriving Repr

/-- A call-out is valid when it has at most 10 images, exactly four storyboard panels
and a shout-out of at most 250 characters. -/
public def CallOut.valid (c : CallOut) : Bool :=
  decide (c.images.length ≤ maxImages) && decide (c.panels.length = 4) &&
    decide (c.shoutOut.length ≤ charLimit)

/-- A reply is valid when its summary has at most 250 characters and it puts down exactly
four player cards. -/
public def Reply.valid (r : Reply) : Bool :=
  decide (r.summary.length ≤ charLimit) && decide (r.cards.length = 4)

/-- Help a player fit a reply: keep the first 250 characters of the summary. -/
public def trimSummary (r : Reply) : Reply :=
  { r with summary := String.ofList (r.summary.toList.take charLimit) }

/-- Trimming always brings the summary within the 250-character limit. -/
public theorem trimSummary_fits (r : Reply) : (trimSummary r).summary.length ≤ charLimit := by
  simp [trimSummary, String.length_ofList]

/-- Trimming never changes the player cards. -/
public theorem trimSummary_cards (r : Reply) : (trimSummary r).cards = r.cards := by
  simp [trimSummary]

/-- So a reply with exactly four cards is always valid after trimming. -/
public theorem trimSummary_valid (r : Reply) (h : r.cards.length = 4) :
    (trimSummary r).valid = true := by
  simp [Reply.valid, trimSummary_fits, trimSummary_cards, h]

/-- A reply with a number of cards other than four is never valid, however short its summary. -/
public theorem reply_needs_four_cards (r : Reply) (h : r.cards.length ≠ 4) :
    r.valid = false := by
  simp [Reply.valid, h]

/-- A call-out with eleven or more images is never valid. -/
public theorem callOut_image_cap (c : CallOut) (h : maxImages < c.images.length) :
    c.valid = false := by
  have : ¬ c.images.length ≤ maxImages := by omega
  simp [CallOut.valid, this]

/-! ## 2. Never stuck in the tutorial -/

/-- The help level after `fails` failed tries, on a ladder whose top rung `top` is the full
walkthrough. -/
public def helpLevel (top fails : ℕ) : ℕ := min fails top

/-- Help never goes down as failed tries add up. -/
public theorem helpLevel_mono (top : ℕ) {a b : ℕ} (h : a ≤ b) :
    helpLevel top a ≤ helpLevel top b := by
  unfold helpLevel; omega

/-- Help never goes past the full walkthrough. -/
public theorem helpLevel_le_top (top fails : ℕ) : helpLevel top fails ≤ top := by
  unfold helpLevel; omega

/-- After `top` failed tries the player is always at the full walkthrough. -/
public theorem walkthrough_reached (top fails : ℕ) (h : top ≤ fails) :
    helpLevel top fails = top := by
  unfold helpLevel; omega

/-- Each failed try below the top rung moves the player up exactly one rung. -/
public theorem helpLevel_step (top fails : ℕ) (h : fails < top) :
    helpLevel top (fails + 1) = helpLevel top fails + 1 := by
  unfold helpLevel; omega

/-! ## 3. Photo metadata: flag identity, not location -/

/-- The kinds of metadata a photo can carry. -/
public inductive MetaField where
  | gps
  | deviceModel
  | timestamp
  | legalName
  | homeAddress
  | ssn
  | phoneNumber
  deriving DecidableEq, Repr

/-- The fields that identify Beth personally, under her rule. -/
public def MetaField.identifying : MetaField → Bool
  | .legalName | .homeAddress | .ssn | .phoneNumber => true
  | _ => false

/-- Flag a photo exactly when one of its metadata fields is identifying. -/
public def flagPhoto (fields : List MetaField) : Bool := fields.any MetaField.identifying

/-- A photo with only GPS, phone model and time stamp is not flagged. -/
public theorem gps_model_time_not_flagged :
    flagPhoto [.gps, .deviceModel, .timestamp] = false := by decide

/-- Any photo carrying a Social Security number is flagged. -/
public theorem ssn_flagged (fields : List MetaField) (h : MetaField.ssn ∈ fields) :
    flagPhoto fields = true := by
  simp only [flagPhoto, List.any_eq_true]
  exact ⟨.ssn, h, rfl⟩

/-- Adding more metadata never removes a flag. -/
public theorem flag_mono (fields extra : List MetaField) (h : flagPhoto fields = true) :
    flagPhoto (fields ++ extra) = true := by
  simp only [flagPhoto, List.any_append, Bool.or_eq_true] at h ⊢
  exact Or.inl h

/-- A photo is flagged exactly when it carries a name, address, SSN or phone number. -/
public theorem flag_iff (fields : List MetaField) :
    flagPhoto fields = true ↔
      (.legalName ∈ fields ∨ .homeAddress ∈ fields ∨ .ssn ∈ fields ∨ .phoneNumber ∈ fields) := by
  simp only [flagPhoto, List.any_eq_true]
  constructor
  · rintro ⟨f, hf, hid⟩
    cases f <;> simp_all [MetaField.identifying]
  · rintro (h | h | h | h) <;> exact ⟨_, h, rfl⟩

/-! ## 4. The v5.7.1 torus: R = 3, r = 1 -/

/-- Distance from the axis of the point at tube angle `v` on a torus with major radius `R`
and minor radius `r`. -/
public noncomputable def axisDistance (R r v : ℝ) : ℝ := R + r * Real.cos v

/-- When `0 ≤ r`, every point is at least `R - r` from the axis. -/
public theorem axisDistance_ge {R r : ℝ} (hr : 0 ≤ r) (v : ℝ) :
    R - r ≤ axisDistance R r v := by
  unfold axisDistance
  have := Real.neg_one_le_cos v
  nlinarith

/-- For the Whale-Song patch values `R = 3`, `r = 1`, every point is at least 2 from the
axis: the plotted torus is a ring with a hole of radius 2. -/
public theorem whaleSong_ring (v : ℝ) : 2 ≤ axisDistance 3 1 v := by
  have := axisDistance_ge (R := 3) (r := 1) zero_le_one v
  linarith

/-! ## 5. Arithmetic in the Gemini summaries and the album count -/

/-- The 144 digit sum, `144 / 4 = 36 = 12 × 3`, and `1.5 + 1.5 + 1.5 = 4.5`, as quoted in
Beth's Gemini summaries. These check the arithmetic only. -/
public theorem watermelon_arithmetic :
    1 + 4 + 4 = 9 ∧ 144 / 4 = 36 ∧ 36 = 12 * 3 ∧ (1.5 : ℚ) + 1.5 + 1.5 = 4.5 ∧
      (1.5 : ℚ) + 1.5 = 3 := by
  norm_num

/-- The album count this round: 1,459 at the Round 23 check plus 17 new screenshots. -/
public theorem album_count_r24 : 1459 + 17 = 1476 := by norm_num

/-! ## 6. Update batch: the 2026 Chemistry prize and a "tiny bias grows" mechanic

A toy model of *asymmetric autocatalysis* (the kind of self-amplifying reaction recognised
in the post Beth linked). `e` is the excess of one mirror form over the other, between `-1`
and `1`. One round of amplification sends `e` to `2e / (1 + e²)`. This is a teaching model,
not the chemistry itself. -/

/-- One round of the toy amplification. -/
public noncomputable def amplify (e : ℝ) : ℝ := 2 * e / (1 + e ^ 2)

/-- A perfectly balanced (racemic) start stays balanced: no bias, nothing to amplify. -/
public theorem amplify_zero : amplify 0 = 0 := by simp [amplify]

/-- Mirror symmetry: flipping the starting bias flips the result. -/
public theorem amplify_neg (e : ℝ) : amplify (-e) = -amplify e := by
  unfold amplify; rw [neg_sq]; ring

/-- A small positive bias strictly grows but never passes total purity `1`. -/
public theorem amplify_grows {e : ℝ} (h0 : 0 < e) (h1 : e < 1) :
    e < amplify e ∧ amplify e < 1 := by
  unfold amplify
  have hpos : 0 < 1 + e ^ 2 := by positivity
  constructor
  · rw [lt_div_iff₀ hpos]; nlinarith
  · rw [div_lt_one hpos]; nlinarith [sq_pos_of_pos (sub_pos.mpr h1)]

/-! ## 7. The governance "healthy band" from Emergence World Season 1

The researchers read a share of FOR votes between 55% and 85% as healthy: below is gridlock,
above is rubber-stamping. Percentages are whole numbers here. -/

/-- The researchers' healthy band for the share of FOR votes. -/
public def healthyBand (forPct : ℕ) : Bool := 55 ≤ forPct && forPct ≤ 85

/-- The reported FOR shares: the mixed world (63%) is in the band; the 98% world is above it
(rubber-stamping). -/
public theorem healthyBand_examples :
    healthyBand 63 = true ∧ healthyBand 73 = true ∧ healthyBand 80 = true ∧
      healthyBand 98 = false := by decide

/-! ## 8. Fibonacci from the matheorems post, and the updated album count -/

/-- Binet's formula, which the hyperbolic-sine form in the post rewrites:
`F m = (φ^m - ψ^m) / √5`. -/
public theorem fib_binet (m : ℕ) :
    (Nat.fib m : ℝ) = (Real.goldenRatio ^ m - Real.goldenConj ^ m) / Real.sqrt 5 :=
  Real.coe_fib_eq m

/-- The album after Beth's update: 1,476 plus two new golden "9" images. -/
public theorem album_count_r24_update : 1476 + 2 = 1478 := by norm_num

end RoundTwentyFour
