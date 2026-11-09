module

public import Mathlib

public section

/-!
# Round 16 · Level 3: the classic "watermelon" percentage puzzle

In the shared Grok conversation of 6 January 2026 titled "Watermelon Equation:
Paradox and Solution", Beth typed "The watermelon equation, secret sauce" and
Grok answered with the well-known puzzle: a 100 kg watermelon is 99 % water;
after drying it is 98 % water; how heavy is it now? Grok's answer was 50 kg.

This file checks that arithmetic. It is a statement about percentages only.
It does not model Beth's own "Watermelon Equation" framework, which is a
different, symbolic idea.

The model: the dry (non-water) part does not evaporate, so
`(1 - q) * newWeight = (1 - p) * oldWeight`, where `p` and `q` are the water
fractions before and after.
-/

namespace R16.WatermelonPuzzle

/-- The dry part (everything that is not water) of a melon of weight `w`
whose water fraction is `p`. -/
def dryPart (w p : ℝ) : ℝ := (1 - p) * w

/-- General rule: if the dry part is unchanged and the new water fraction `q`
is not 100 %, the new weight is `w (1 - p) / (1 - q)`. -/
theorem new_weight_formula (w p q x : ℝ) (hq : q ≠ 1) :
    dryPart x q = dryPart w p ↔ x = w * (1 - p) / (1 - q) := by
  unfold dryPart
  have h : (1 - q) ≠ 0 := sub_ne_zero.mpr (Ne.symm hq)
  constructor
  · intro hx
    field_simp
    linarith
  · intro hx
    rw [hx]
    field_simp

/-- The classic numbers: 100 kg at 99 % water drying to 98 % water weighs
exactly 50 kg, not the "intuitive" 99 kg. -/
theorem classic_answer (x : ℝ) :
    dryPart x (98 / 100) = dryPart 100 (99 / 100) ↔ x = 50 := by
  rw [new_weight_formula 100 (99 / 100) (98 / 100) x (by norm_num)]
  norm_num

/-- The water that evaporated: 99 kg of water before, 49 kg after, so 50 kg
of water left the melon. -/
theorem water_lost : (99 / 100 : ℝ) * 100 - (98 / 100) * 50 = 50 := by
  norm_num

/-- The "intuitive" answer of 99 kg is wrong: at 99 kg the dry part would
have to grow from 1 kg to 1.98 kg. -/
theorem ninety_nine_is_wrong :
    dryPart 99 (98 / 100) ≠ dryPart 100 (99 / 100) := by
  unfold dryPart
  norm_num

end R16.WatermelonPuzzle
