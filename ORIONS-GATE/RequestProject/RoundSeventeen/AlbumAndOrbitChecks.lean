module

public import Mathlib

/-!
# Round 17: album recount and the orbit formulas on Lucien's "Dragon MAD" field notebook

* The shared ORION album, re-read on 7 October 2026, has 1,417 items: the 1,384 of Round 15,
  minus the 6 that were removed, plus 39 new pictures. Images went from 1,304 to 1,337; the 80
  short videos are unchanged.
* The "Field Notebook" on the *Dragon MAD, Earth Ambassador Scientist* poster (album #1396)
  writes `h = r × v (const)`. That is right for any central force: if the acceleration always
  points along the position vector, the angular momentum `r × v` does not change.
* The same notebook writes `E = −GMm / 2a`. For a circular orbit of radius `a` (speed
  `v² = GM/a`) the kinetic plus potential energy is exactly that.

These check the arithmetic and the mathematics printed in the picture, nothing more.
-/

namespace RoundSeventeen

/-- Album recount: 1,384 − 6 removed + 39 new = 1,417 items, of which 1,337 are images. -/
public theorem album_recount :
    1384 - 6 + 39 = 1417 ∧ 1304 - 6 + 39 = 1337 ∧ 1337 + 80 = 1417 := by
  decide

open Matrix in
/-- **`h = r × v` is constant under a central force.** If a path `r` in space has velocity
`r'` and acceleration `r'' t = k t • r t` (always along the position vector), then the angular
momentum `r × r'` has derivative zero. -/
public theorem angular_momentum_const_of_central
    (r r' r'' : ℝ → Fin 3 → ℝ) (k : ℝ → ℝ) (t : ℝ)
    (hr : HasDerivAt r (r' t) t) (hr' : HasDerivAt r' (r'' t) t)
    (hcentral : r'' t = k t • r t) :
    HasDerivAt (fun s => r s ⨯₃ r' s) 0 t := by
  have hcomp : ∀ i : Fin 3, HasDerivAt (fun s => r s i) (r' t i) t := fun i =>
    (hasDerivAt_pi.1 hr) i
  have hcomp' : ∀ i : Fin 3, HasDerivAt (fun s => r' s i) (r'' t i) t := fun i =>
    (hasDerivAt_pi.1 hr') i
  have key : (0 : Fin 3 → ℝ) =
      ![r' t 1 * r' t 2 + r t 1 * r'' t 2 - (r' t 2 * r' t 1 + r t 2 * r'' t 1),
        r' t 2 * r' t 0 + r t 2 * r'' t 0 - (r' t 0 * r' t 2 + r t 0 * r'' t 2),
        r' t 0 * r' t 1 + r t 0 * r'' t 1 - (r' t 1 * r' t 0 + r t 1 * r'' t 0)] := by
    rw [hcentral]
    ext i; fin_cases i <;> simp <;> ring
  rw [key]
  refine hasDerivAt_pi.2 fun i => ?_
  fin_cases i
  · simpa [cross_apply] using
      (((hcomp 1).mul (hcomp' 2)).sub ((hcomp 2).mul (hcomp' 1)))
  · simpa [cross_apply] using
      (((hcomp 2).mul (hcomp' 0)).sub ((hcomp 0).mul (hcomp' 2)))
  · simpa [cross_apply] using
      (((hcomp 0).mul (hcomp' 1)).sub ((hcomp 1).mul (hcomp' 0)))

/-- **`E = −GMm / 2a` for a circular orbit.** With orbital speed `v² = GM/a`, kinetic energy
`½ m v²` plus potential energy `−GMm/a` equals `−GMm/(2a)`. -/
public theorem circular_orbit_energy (G M m a v : ℝ) (ha : a ≠ 0) (hv : v ^ 2 = G * M / a) :
    (1 / 2) * m * v ^ 2 - G * M * m / a = -(G * M * m) / (2 * a) := by
  rw [hv]
  field_simp
  ring

end RoundSeventeen
