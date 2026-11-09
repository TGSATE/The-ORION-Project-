module

public import Mathlib

public section

/-!
# Round 16: torus, hourglass and sphere (pure geometry)

Beth wants to show how a torus and an hourglass "together make the sphere".
These are exact, elementary geometric facts that a picture of that idea can
rely on. They are statements about shapes in ordinary 3-space only; they say
nothing about physics, biology or any particular published framework.

* A torus is described by `(√(x²+y²) - R)² + z² = r²` (ring radius `R`, tube radius `r`).
* An hourglass (double cone) with apex at the origin is `z² = k²(x²+y²)`.
* A sphere of radius `ρ` about the origin is `x²+y²+z² = ρ²`.
-/

namespace R16.TorusHourglassSphere

/-- The torus with ring radius `R` and tube radius `r`. -/
def OnTorus (R r x y z : ℝ) : Prop :=
  (Real.sqrt (x ^ 2 + y ^ 2) - R) ^ 2 + z ^ 2 = r ^ 2

/-- The sphere of radius `ρ` centred at the origin. -/
def OnSphere (ρ x y z : ℝ) : Prop :=
  x ^ 2 + y ^ 2 + z ^ 2 = ρ ^ 2

/-- The hourglass (double cone) with apex at the origin and slope `k`. -/
def OnHourglass (k x y z : ℝ) : Prop :=
  z ^ 2 = k ^ 2 * (x ^ 2 + y ^ 2)

/-- **Fact 1.** Shrink the ring radius of a torus to zero and it *is* a sphere:
the two descriptions pick out exactly the same points. -/
theorem torus_zero_ring_eq_sphere (r x y z : ℝ) :
    OnTorus 0 r x y z ↔ OnSphere r x y z := by
  unfold OnTorus OnSphere
  rw [sub_zero, Real.sq_sqrt (by positivity)]

/-- **Fact 2.** A horn torus (ring radius equal to tube radius `r ≥ 0`) lies inside
the sphere of radius `2r`: every point of it is at distance at most `2r` from the
centre. -/
theorem horn_torus_inside_sphere {r x y z : ℝ} (hr : 0 ≤ r) (h : OnTorus r r x y z) :
    x ^ 2 + y ^ 2 + z ^ 2 ≤ (2 * r) ^ 2 := by
  unfold OnTorus at h
  have hs0 : 0 ≤ Real.sqrt (x ^ 2 + y ^ 2) := Real.sqrt_nonneg _
  have hss : Real.sqrt (x ^ 2 + y ^ 2) ^ 2 = x ^ 2 + y ^ 2 := Real.sq_sqrt (by positivity)
  have hz : 0 ≤ z ^ 2 := sq_nonneg z
  have hsle : Real.sqrt (x ^ 2 + y ^ 2) ≤ 2 * r := by nlinarith
  nlinarith

/-- **Fact 3.** The hourglass meets the sphere of radius `ρ` exactly at the two
heights with `z² = k²ρ²/(1+k²)`, i.e. in two circles, one above and one below
the waist. -/
theorem hourglass_meets_sphere {k ρ x y z : ℝ}
    (hh : OnHourglass k x y z) (hsph : OnSphere ρ x y z) :
    z ^ 2 = k ^ 2 * ρ ^ 2 / (1 + k ^ 2) := by
  unfold OnHourglass at hh
  unfold OnSphere at hsph
  have hpos : (0 : ℝ) < 1 + k ^ 2 := by positivity
  rw [eq_div_iff hpos.ne']
  have : x ^ 2 + y ^ 2 = ρ ^ 2 - z ^ 2 := by linarith
  rw [this] at hh
  linarith

/-- The waist of the hourglass (its apex, the origin) is the centre of the sphere,
and it is also the point where the horn torus's hole pinches shut. -/
theorem waist_on_horn_torus_and_hourglass (r k : ℝ) :
    OnTorus r r 0 0 0 ∧ OnHourglass k 0 0 0 := by
  unfold OnTorus OnHourglass
  norm_num

end R16.TorusHourglassSphere
