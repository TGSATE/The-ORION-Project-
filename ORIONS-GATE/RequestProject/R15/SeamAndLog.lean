module

public import Mathlib

public section

namespace R15.SeamAndLog

/-- A polynomial whose value and first derivative match at the ends of `[0, 1]`,
but whose second derivatives do not match. -/
def seamWitness (t : ℝ) : ℝ := t ^ 5 - 2 * t ^ 4 + t ^ 3

def seamFirst (t : ℝ) : ℝ := 5 * t ^ 4 - 8 * t ^ 3 + 3 * t ^ 2

def seamSecond (t : ℝ) : ℝ := 20 * t ^ 3 - 24 * t ^ 2 + 6 * t

private lemma witness_first (t : ℝ) : HasDerivAt seamWitness (seamFirst t) t := by
  convert ((hasDerivAt_id t).pow 5 |>.sub
    (((hasDerivAt_id t).pow 4).const_mul 2)).add ((hasDerivAt_id t).pow 3) using 1
  simp only [seamFirst, id_eq]
  ring

private lemma witness_second (t : ℝ) : HasDerivAt seamFirst (seamSecond t) t := by
  convert (((hasDerivAt_id t).pow 4).const_mul 5 |>.sub
    (((hasDerivAt_id t).pow 3).const_mul 8)).add
    (((hasDerivAt_id t).pow 2).const_mul 3) using 1
  simp only [seamSecond, id_eq]
  ring

/-- Equality of endpoint values and first derivatives alone does not imply equality
of endpoint second derivatives (the needed extra seam condition for a `C²` return). -/
theorem matching_first_order_not_second :
    seamWitness 0 = seamWitness 1 ∧
    deriv seamWitness 0 = deriv seamWitness 1 ∧
    deriv (deriv seamWitness) 0 ≠ deriv (deriv seamWitness) 1 := by
  have d1 : deriv seamWitness = seamFirst := funext fun t => (witness_first t).deriv
  have d2 : deriv seamFirst = seamSecond := funext fun t => (witness_second t).deriv
  rw [d1, d2]
  norm_num [seamWitness, seamFirst, seamSecond]

/-- The logarithmic term in the stated rocket equation vanishes, rather than
becoming large, at equal wet and dry masses. -/
theorem rocket_equal_masses (isp g mass : ℝ) (hm : mass ≠ 0) :
    isp * g * Real.log (mass / mass) = 0 := by
  simp [hm]

/-- Under positive masses and a nonnegative specific impulse and gravity, the
stated formula gives nonnegative change in velocity if wet mass is at least dry mass. -/
theorem rocket_nonnegative (isp g wet dry : ℝ) (hi : 0 ≤ isp) (hg : 0 ≤ g)
    (hd : 0 < dry) (hwd : dry ≤ wet) :
    0 ≤ isp * g * Real.log (wet / dry) := by
  have hratio : 1 ≤ wet / dry := (one_le_div hd).2 hwd
  exact mul_nonneg (mul_nonneg hi hg) (Real.log_nonneg hratio)

/-- The unit-circle velocity `(-sin θ, cos θ)` is perpendicular to its radius
`(cos θ, sin θ)`. This is a geometric identity, not a proof of self-sustaining motion. -/
theorem circle_velocity_tangent (theta : ℝ) :
    Real.cos theta * (-Real.sin theta) + Real.sin theta * Real.cos theta = 0 := by
  ring

/-- An unrestricted state-update matrix need not pull its state toward zero:
the scalar update `x ↦ 2*x` doubles the magnitude of a positive state. -/
theorem unconstrained_update_can_expand :
    0 < (1 : ℝ) ∧ (1 : ℝ) < 2 * (1 : ℝ) := by
  norm_num

end R15.SeamAndLog
