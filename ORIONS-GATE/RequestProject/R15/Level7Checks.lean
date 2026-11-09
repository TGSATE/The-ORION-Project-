module

public import Mathlib

public section

namespace R15.Level7

/-! # Round 15 · Level 7 (15.7): checks of the maths printed in the new album pictures

These check only the mathematics as it is printed on the pictures; they say nothing
about any wider claim made around them. -/

open Real Complex

/-- Powers of the golden ratio reduce to Fibonacci numbers:
`φ^(n+1) = F(n+1)·φ + F(n)`. -/
theorem goldenRatio_pow_succ_eq_fib (n : ℕ) :
    goldenRatio ^ (n + 1) = (Nat.fib (n + 1) : ℝ) * goldenRatio + Nat.fib n := by
  induction n with
  | zero => simp
  | succ k ih =>
    rw [pow_succ, ih, Nat.fib_add_two]
    push_cast
    linear_combination (Nat.fib (k + 1) : ℝ) * goldenRatio_sq

/-- Album #1489 ("Comparaison"): `φ²³ = 28657 φ + 17711` is correct.
28657 and 17711 are the 23rd and 22nd Fibonacci numbers. -/
theorem goldenRatio_pow_23 : goldenRatio ^ 23 = 28657 * goldenRatio + 17711 := by
  have h := goldenRatio_pow_succ_eq_fib 22
  have h23 : Nat.fib 23 = 28657 := by decide
  have h22 : Nat.fib 22 = 17711 := by decide
  rw [h23, h22] at h
  exact_mod_cast h

/-- Squared length of the polarization state `a|R⟩ + b|L⟩`. -/
noncomputable def stateNormSq (a b : ℂ) : ℝ := ‖a‖ ^ 2 + ‖b‖ ^ 2

/-- Album #1418 (Bloch sphere poster), corrected form: with half-angles,
`cos(θ/2)|R⟩ + e^{iφ} sin(θ/2)|L⟩` always has length 1, for every `θ` and `φ`. -/
theorem bloch_halfAngle_normalized (θ φ : ℝ) :
    stateNormSq (Real.cos (θ / 2)) (Complex.exp (φ * I) * Real.sin (θ / 2)) = 1 := by
  unfold stateNormSq
  rw [norm_mul, Complex.norm_exp_ofReal_mul_I, Complex.norm_real, Complex.norm_real,
    Real.norm_eq_abs, Real.norm_eq_abs, one_mul, sq_abs, sq_abs]
  exact Real.cos_sq_add_sin_sq (θ / 2)

/-- Album #1418, as printed: the poster's formula reads `cos(θ2)`. Read as `cos(2θ)`,
it is **not** a valid state: at `θ = π/2`, `φ = 0` the squared length is `3/2`, not 1.
So the printed `cos(θ2)` is a typo for `cos(θ/2)`. -/
theorem bloch_printed_typo_not_normalized :
    stateNormSq (Real.cos (2 * (π / 2))) (Complex.exp ((0 : ℝ) * I) * Real.sin ((π / 2) / 2))
      = 3 / 2 := by
  unfold stateNormSq
  have h1 : 2 * (π / 2) = π := by ring
  have h2 : π / 2 / 2 = π / 4 := by ring
  rw [h1, h2, Real.cos_pi, Real.sin_pi_div_four]
  simp only [Complex.ofReal_zero, zero_mul, Complex.exp_zero, one_mul]
  rw [Complex.norm_real, Complex.norm_real, Real.norm_eq_abs, Real.norm_eq_abs, sq_abs,
    sq_abs, div_pow, Real.sq_sqrt (by norm_num : (0 : ℝ) ≤ 2)]
  norm_num

/-- Letter value `A = 1, …, Z = 26`. -/
def letterValue (c : Char) : ℕ :=
  if 'A' ≤ c ∧ c ≤ 'Z' then c.toNat - 'A'.toNat + 1 else 0

/-- Sum of letter values of a word. -/
def wordValue (s : String) : ℕ := (s.toList.map letterValue).sum

/-- Album #1459 ("Scroll of the True Name — Trista"): the full name TRISTA sums to 87,
and its digits give `8 + 7 = 15`, the scroll's "Flame Number". The scroll prints
"Total Sum: 37", and its own next line uses 8 and 7, so 37 is a typo for 87.
The five letters the scroll lists (T, R, I, S, T — the final A = 1 is left out)
sum to 86. -/
theorem trista_name_sum :
    wordValue "TRISTA" = 87 ∧ 8 + 7 = 15 ∧ wordValue "TRIST" = 86 ∧
      wordValue "TRISTA" ≠ 37 := by
  decide

/-- Album #1480–1482 (Geometry Camp comic, "the kernel dies at zero"): the kernel of
any linear map contains the zero vector, so it is never empty. -/
theorem kernel_contains_zero {K V W : Type*} [Field K] [AddCommGroup V] [Module K V]
    [AddCommGroup W] [Module K W] (A : V →ₗ[K] W) : (0 : V) ∈ LinearMap.ker A :=
  Submodule.zero_mem _

end R15.Level7
