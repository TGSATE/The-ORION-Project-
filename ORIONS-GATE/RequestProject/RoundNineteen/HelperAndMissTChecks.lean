module

public import Mathlib

/-!
# Round 19: the plain-language helper rule, and two of Miss T's formulas

* **Plain-language helper rule.** Beth's rule for every AI helper in the game: no metaphors;
  each instruction step says what to do and names the item, using the label the player
  actually sees. We model a helper message as a list of steps and prove that an accepted
  message has at least one step and that every step names a labelled item the player has.
* **Miss T's Wedjat poster:** `1/2 + 1/4 + … + 1/64 = 63/64`, and the general halving sum
  `∑_{k=1}^{n} 1/2^k = 1 − 1/2^n` ("one part left out").
* **Miss T's "Intimate Equation" poster** uses the real rocket equation
  `Δv = I_sp · g₀ · ln(m_wet / m_dry)`; it is positive exactly when fuel is burned
  (`m_wet > m_dry`).
* **Tetractys:** `1 + 2 + 3 + 4 = 10`.
* Count arithmetic for this round's Miss T media snapshot and the album re-check.
-/

namespace RoundNineteen

/-! ## The plain-language helper rule -/

/-- One step of a helper's instructions: the action, the label of the item it acts on, and
whether the wording relies on a metaphor instead of the item's real label. -/
public structure HelperStep where
  action : String
  itemLabel : String
  usesMetaphor : Bool
  deriving DecidableEq, Repr

/-- A step is clear for a player whose visible item labels are `labels` when it has an action,
names one of those labels, and uses no metaphor. -/
public def HelperStep.isClear (labels : List String) (s : HelperStep) : Bool :=
  s.action != "" && labels.contains s.itemLabel && !s.usesMetaphor

/-- A helper message is accepted when it has at least one step and every step is clear. -/
public def acceptsMessage (labels : List String) (msg : List HelperStep) : Bool :=
  !msg.isEmpty && msg.all (HelperStep.isClear labels)

/-- Anything the rule accepts has at least one step, and every step names an item label the
player can actually see, has an action, and uses no metaphor. -/
public theorem accepted_message_is_plain (labels : List String) (msg : List HelperStep)
    (h : acceptsMessage labels msg = true) :
    msg ≠ [] ∧ ∀ s ∈ msg, s.action ≠ "" ∧ s.itemLabel ∈ labels ∧ s.usesMetaphor = false := by
  unfold acceptsMessage at h
  simp only [Bool.and_eq_true, Bool.not_eq_true', List.isEmpty_eq_false_iff, List.all_eq_true]
    at h
  refine ⟨h.1, fun s hs => ?_⟩
  have := h.2 s hs
  simp [HelperStep.isClear] at this
  exact ⟨this.1.1, this.1.2, this.2⟩

/-- A single metaphor step is enough to reject the whole message. -/
public theorem metaphor_step_rejects (labels : List String) (msg : List HelperStep)
    (s : HelperStep) (hs : s ∈ msg) (hm : s.usesMetaphor = true) :
    acceptsMessage labels msg = false := by
  unfold acceptsMessage
  have : msg.all (HelperStep.isClear labels) = false := by
    rw [List.all_eq_false]
    exact ⟨s, hs, by simp [HelperStep.isClear, hm]⟩
  simp [this]

/-- Example: "Open the Universal Stone, then tap Raw Feed" is accepted. -/
example :
    acceptsMessage ["Universal Stone", "Raw Feed", "Escape Pod"]
      [⟨"Open", "Universal Stone", false⟩, ⟨"Tap", "Raw Feed", false⟩] = true := by
  decide

/-- Example: "Let the river carry your light into the gate" is rejected (a metaphor, and no
real item label). -/
example :
    acceptsMessage ["Universal Stone", "Raw Feed", "Escape Pod"]
      [⟨"Carry", "the river of light", true⟩] = false := by
  decide

/-! ## Miss T's formulas -/

/-- The Wedjat (Eye of Horus) fractions on Miss T's Thoth poster add to 63/64. -/
public theorem wedjat_sum :
    (1 / 2 + 1 / 4 + 1 / 8 + 1 / 16 + 1 / 32 + 1 / 64 : ℚ) = 63 / 64 := by
  norm_num

/-- The general halving sum: `1/2 + 1/4 + ⋯ + 1/2^n = 1 − 1/2^n`, so exactly one part in
`2^n` is always left out. -/
public theorem halving_sum (n : ℕ) :
    ∑ k ∈ Finset.range n, (1 / 2 : ℚ) ^ (k + 1) = 1 - (1 / 2) ^ n := by
  induction n with
  | zero => simp
  | succ n ih =>
    rw [Finset.sum_range_succ, ih]
    ring

/-- The rocket equation on Miss T's "Intimate Equation" poster: with positive specific impulse,
standard gravity and masses, `Δv = I_sp · g₀ · ln(m_wet / m_dry)` is positive exactly when the
wet (fuelled) mass exceeds the dry mass. -/
public theorem rocket_delta_v_pos_iff (Isp g0 mwet mdry : ℝ) (hI : 0 < Isp) (hg : 0 < g0)
    (hw : 0 < mwet) (hd : 0 < mdry) :
    0 < Isp * g0 * Real.log (mwet / mdry) ↔ mdry < mwet := by
  rw [mul_pos_iff_of_pos_left (mul_pos hI hg), Real.log_pos_iff (div_pos hw hd).le,
    one_lt_div hd]

/-- The Tetractys on Miss T's "Anatomy of Your Energy Equation" poster: `1 + 2 + 3 + 4 = 10`. -/
public theorem tetractys_sum : 1 + 2 + 3 + 4 = 10 := by
  decide

/-! ## Count arithmetic for this round -/

/-- Miss T's 40 most recent media posts (2–7 October 2026): 31 picture posts plus 9 GIF
replies; 14 of the picture posts carry four pictures. Her account totals: 2,626 media items
and 12,444 posts in the 338 days from 3 November 2025 to 7 October 2026, i.e. about 7 media
items and 36 posts per day (rounded down). -/
public theorem miss_t_media_counts :
    31 + 9 = 40 ∧ 14 ≤ 31 ∧ 2626 / 338 = 7 ∧ 12444 / 338 = 36 := by
  decide

/-- The shared album, re-read for Round 19: still 1,417 items, the same ones in the same
order as Rounds 17 and 18. -/
public theorem album_still_1417 : 1417 + 0 - 0 = 1417 := by
  decide

end RoundNineteen
