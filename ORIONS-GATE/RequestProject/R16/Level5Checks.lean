module

public import Mathlib

public section

/-!
# Round 16 · Level 5: small facts from the links Beth shared

1. **The arrow on the sphere turns by 90°** (Matheorems' post). The triangle from the
   equator to the north pole has three right angles. Its angle sum is `3π/2`, so the
   excess over a flat triangle is `π/2`, and that equals its area (one eighth of the
   sphere, `4πR²/8`) divided by `R²`.
2. **The "spider in my AI setup" numbers add up** (razeden0's post): 1,860 pages × 8
   questions = 14,880 decisions; 1,791 + 55 + 11 + 3 = 1,860; 1,860 pages × 45 s =
   23 h 15 min; and that hand-reading time divided by 11.2 s is between 7,473 and 7,474.
3. **The "$13 a day" sum** (yurshevv's post): `13 × 250 = 3,250`, and `3,250 / 135,980`
   is between 2.3% and 2.4%.
4. **Three copies of one voter are no better than one** (alpha404ai's "3 of 3 must
   agree" desk). If all three votes come from the same reading, a unanimous vote is
   wrong exactly when the single reading is wrong. Agreement only adds safety when the
   voters can disagree.

These are arithmetic and textbook geometry. They do not check any trading result,
cost saving or other claim in those posts beyond what is stated here.
-/

namespace R16L5

/-! ## 1. Angle excess of the octant triangle -/

/-- The three right angles of the octant triangle add up to `3π/2`. -/
theorem octant_angle_sum : Real.pi / 2 + Real.pi / 2 + Real.pi / 2 = 3 * Real.pi / 2 := by
  ring

/-- The excess over a flat triangle (`π`) is `π/2`, i.e. 90°. -/
theorem octant_excess : 3 * Real.pi / 2 - Real.pi = Real.pi / 2 := by
  ring

/-- Gauss–Bonnet for the octant: excess = area / R², with area = 4πR²/8. -/
theorem octant_excess_eq_area_div_sq {R : ℝ} (hR : R ≠ 0) :
    (4 * Real.pi * R ^ 2 / 8) / R ^ 2 = 3 * Real.pi / 2 - Real.pi := by
  field_simp
  ring

/-! ## 2. The crawler numbers -/

theorem crawler_decisions : 1860 * 8 = 14880 := by norm_num

theorem crawler_routing_total : 1791 + 55 + 11 + 3 = 1860 := by norm_num

/-- 1,860 pages at 45 seconds each is 23 hours and 15 minutes. -/
theorem crawler_hand_time : 1860 * 45 = 23 * 3600 + 15 * 60 := by norm_num

/-- 83,700 s ÷ 11.2 s lies between 7,473 and 7,474, so "7,473×" is right. -/
theorem crawler_speedup :
    (7473 : ℝ) ≤ (1860 * 45) / 11.2 ∧ (1860 * 45) / 11.2 < (7474 : ℝ) := by
  constructor <;> norm_num

/-! ## 3. The $13-a-day sum -/

theorem claude_code_year : 13 * 250 = 3250 := by norm_num

theorem claude_code_share :
    (0.023 : ℝ) < 3250 / 135980 ∧ (3250 : ℝ) / 135980 < 0.024 := by
  constructor <;> norm_num

/-! ## 4. Correlated voters -/

/-- A unanimous vote of three voters. -/
def unanimous (a b c : Bool) : Bool := a && b && c

/-- If all three voters copy one reading `r`, the unanimous vote is just `r`. -/
theorem unanimous_copies (r : Bool) : unanimous r r r = r := by
  cases r <;> rfl

/-- With three copies, the vote is wrong exactly when the single reading is wrong. -/
theorem unanimous_copies_wrong_iff (r truth : Bool) :
    (unanimous r r r ≠ truth) ↔ (r ≠ truth) := by
  rw [unanimous_copies]

/-- With independent voters, one dissent blocks a wrong unanimous call. -/
theorem unanimous_blocked_by_dissent (a b : Bool) : unanimous a b false = false := by
  cases a <;> cases b <;> rfl

end R16L5
