module

public import Mathlib

public section

/-!
# Round 16 · Level 4: three small facts from the links Beth shared

1. **Stochastic %K stays between 0 and 100** (the `stochastic_k` line Northern
   Chuck joked about). If the latest close lies between the window's low and
   high, and the high is above the low, then
   `100 * (close - low) / (high - low)` is between 0 and 100.
2. **Euler's rotation has size exactly 1** (Eron's post): for every real `θ`,
   `‖exp(θ i)‖ = 1`.
3. **A 2×2 rotation matrix is orthogonal** (ScieVision's post): for the rotation
   by `θ`, `Qᵀ Q = I`.

These are standard mathematical facts. They do not check any claim in those
posts beyond what is stated here.
-/

namespace R16L4

/-- The stochastic oscillator's %K value for a closing price inside a window. -/
noncomputable def stochasticK (close low high : ℝ) : ℝ :=
  100 * (close - low) / (high - low)

/-- %K is never below 0 when the close is at or above the window's low. -/
theorem stochasticK_nonneg {close low high : ℝ} (hlow : low ≤ close) (hlh : low < high) :
    0 ≤ stochasticK close low high := by
  unfold stochasticK
  apply div_nonneg <;> linarith

/-- %K is never above 100 when the close is at or below the window's high. -/
theorem stochasticK_le_100 {close low high : ℝ} (hhigh : close ≤ high) (hlh : low < high) :
    stochasticK close low high ≤ 100 := by
  unfold stochasticK
  rw [div_le_iff₀ (by linarith)]
  linarith

/-- Euler's formula lands on the unit circle: `‖exp(θ i)‖ = 1` for every real `θ`. -/
theorem euler_rotation_norm_one (θ : ℝ) : ‖Complex.exp (θ * Complex.I)‖ = 1 :=
  Complex.norm_exp_ofReal_mul_I θ

/-- The 2×2 rotation matrix by angle `θ`. -/
noncomputable def rotation (θ : ℝ) : Matrix (Fin 2) (Fin 2) ℝ :=
  !![Real.cos θ, -Real.sin θ; Real.sin θ, Real.cos θ]

/-- A rotation matrix is orthogonal: `Qᵀ Q = I`. -/
theorem rotation_transpose_mul_self (θ : ℝ) :
    (rotation θ).transpose * rotation θ = 1 := by
  have h := Real.sin_sq_add_cos_sq θ
  ext i j
  fin_cases i <;> fin_cases j <;>
    simp [rotation, Matrix.mul_apply, Fin.sum_univ_two] <;> nlinarith

end R16L4
