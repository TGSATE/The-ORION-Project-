module

public import Mathlib

public section

namespace R15.Level5

/-! # Round 15 · Level 5 (15.5): arithmetic and physics checks of linked posts

These are checks of the mathematics *as stated* in posts Beth linked; they do not
verify any wider claim made around them. -/

/-- Beth's follower count, 144, is both `12²` and the 12th Fibonacci number. -/
theorem followers_144 : Nat.fib 12 = 144 ∧ (144 : ℕ) = 12 ^ 2 := by
  refine ⟨?_, by norm_num⟩
  decide

/-- Event-horizon diameter of a non-rotating black hole, `D = 4GM/c²`, in metres. -/
noncomputable def horizonDiameter (G M c : ℝ) : ℝ := 4 * G * M / c ^ 2

/-- The `@cosmosarcive` TON 618 figure checks out: with `G = 6.674 × 10⁻¹¹`,
a mass of 41 billion Suns (`1 Sun = 1.989 × 10³⁰ kg`) and `c = 2.998 × 10⁸ m/s`,
`D = 4GM/c²` lies between 240 and 245 billion kilometres. -/
theorem ton618_diameter_about_240_billion_km :
    (240e9 : ℝ) < horizonDiameter 6.674e-11 (41e9 * 1.989e30) 2.998e8 / 1000 ∧
      horizonDiameter 6.674e-11 (41e9 * 1.989e30) 2.998e8 / 1000 < 245e9 := by
  unfold horizonDiameter
  constructor <;> norm_num

/-- The `@matheorems` Chladni post: a standing-wave mode `sin(mπx)·sin(nπy)` of a square
plate is zero along every line `x = k/m` (`k` an integer), so these are stationary
nodal lines where sand can settle. -/
theorem chladni_nodal_line (m : ℕ) (hm : m ≠ 0) (k : ℤ) (n : ℕ) (y : ℝ) :
    Real.sin (m * Real.pi * (k / m)) * Real.sin (n * Real.pi * y) = 0 := by
  have hm' : (m : ℝ) ≠ 0 := by exact_mod_cast hm
  have : (m : ℝ) * Real.pi * (k / m) = (k : ℝ) * Real.pi := by
    field_simp
  rw [this, Real.sin_int_mul_pi, zero_mul]

/-- On a square plate, the mixed mode `sin(mπx)sin(nπy) − sin(nπx)sin(mπy)` is zero on the
whole diagonal `x = y`: the diagonal line in many Chladni figures. -/
theorem chladni_diagonal_node (m n : ℕ) (x : ℝ) :
    Real.sin (m * Real.pi * x) * Real.sin (n * Real.pi * x) -
      Real.sin (n * Real.pi * x) * Real.sin (m * Real.pi * x) = 0 := by
  ring

end R15.Level5
