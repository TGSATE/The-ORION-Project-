module

public import Mathlib

/-!
# Zhang Heng's seismoscope (候風地動儀, 132 CE): the checkable parts

Umbrella level ☂️1.5. The original device is lost; what survives is a 196-character
description in the *Book of Later Han*. These lemmas check the simple mechanics behind
that description, not any particular reconstruction:

* a ball resting in a dragon's mouth is held by friction and stays put exactly when the
  ground's acceleration is at most `μ * g` (`ball_stays_iff`);
* a release threshold can ignore every local tremor up to the noise level yet still
  respond to a distant signal exactly when the signal is above the noise
  (`threshold_works_iff`, `threshold_exists_iff`);
* with eight dragons spaced 45° apart, the dragon nearest to any direction is off by at
  most 22.5° (`nearest_dragon_error`).
-/

public section

namespace Umbrella.Seismoscope

/-- A ball of mass `m > 0` held by friction with coefficient `μ` under gravity `g`
needs a force `m * a` to follow ground acceleration `a`; friction supplies at most
`μ * m * g`. The ball stays in the dragon's mouth exactly when `a ≤ μ * g`. -/
theorem ball_stays_iff (m μ g a : ℝ) (hm : 0 < m) :
    m * a ≤ μ * m * g ↔ a ≤ μ * g := by
  rw [show μ * m * g = m * (μ * g) by ring]
  exact mul_le_mul_iff_right₀ hm

/-- A release threshold `t` *works* when every local tremor up to the noise level stays
at or below it (the ball stays) and the distant signal goes above it (the ball drops). -/
def ThresholdWorks (noise signal t : ℝ) : Prop :=
  (∀ a : ℝ, a ≤ noise → a ≤ t) ∧ t < signal

theorem threshold_works_iff (noise signal t : ℝ) :
    ThresholdWorks noise signal t ↔ noise ≤ t ∧ t < signal := by
  constructor
  · rintro ⟨h1, h2⟩
    exact ⟨h1 noise le_rfl, h2⟩
  · rintro ⟨h1, h2⟩
    exact ⟨fun a ha => ha.trans h1, h2⟩

/-- Some threshold works exactly when the distant signal is stronger than the local
noise. Too tight a grip (threshold at or above the signal) misses the quake; too loose a
grip (threshold below the noise) drops balls on every footstep. -/
theorem threshold_exists_iff (noise signal : ℝ) :
    (∃ t, ThresholdWorks noise signal t) ↔ noise < signal := by
  simp only [threshold_works_iff]
  constructor
  · rintro ⟨t, h1, h2⟩
    exact h1.trans_lt h2
  · intro h
    exact ⟨noise, le_rfl, h⟩

/-- Eight dragons sit at multiples of 45°. For any direction `θ` (in degrees), the
nearest dragon `45 * round (θ / 45)` is at most 22.5° away. -/
theorem nearest_dragon_error (θ : ℝ) :
    |θ - 45 * (round (θ / 45) : ℝ)| ≤ 45 / 2 := by
  have h := abs_sub_round (θ / 45)
  have e : θ - 45 * (round (θ / 45) : ℝ) = 45 * (θ / 45 - round (θ / 45)) := by ring
  rw [e, abs_mul, abs_of_pos (by norm_num : (0 : ℝ) < 45)]
  linarith

end Umbrella.Seismoscope

end
