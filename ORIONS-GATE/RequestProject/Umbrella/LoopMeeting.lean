module

public import Mathlib

/-!
# The Loop Meeting Theorem (☂️1.9, `MATH.md` §1)

The one pattern that keeps coming back across the research: two loops run side by side
(13 levels and a stride, the ×6 cipher on 26 letters, coprime waves, the 5:2 core, heart and
breath, the Gateframe and the Routing Chorus). This file proves the general rule they all follow.

* `loop_pair_periodic`: the pair of positions `(n mod m, n mod k)` repeats every `lcm m k` turns.
* `loop_pairs_injective`: within one period, no pair repeats.
* `loop_meeting_count`: running a loop of length `m` beside a loop of length `k` reaches
  **exactly `lcm m k` different pairs**, out of `m * k` possible.
* `loop_meeting_times_gcd`: so pairs reached × `gcd m k` = `m * k`. The loops meet every pair
  exactly when `gcd m k = 1` (`loop_meeting_full_iff`), and two loops of the same length meet only
  `m` of the `m * m` pairs (`loop_meeting_same_length`).
-/

@[expose] public section

namespace Umbrella.LoopMeeting

/-- The pair of positions repeats every `lcm m k` turns. -/
theorem loop_pair_periodic (m k n : ℕ) :
    ((n % Nat.lcm m k) % m, (n % Nat.lcm m k) % k) = (n % m, n % k) := by
  rw [Nat.mod_mod_of_dvd n (Nat.dvd_lcm_left m k), Nat.mod_mod_of_dvd n (Nat.dvd_lcm_right m k)]

/-- Within one period no pair of positions repeats. -/
theorem loop_pairs_injective (m k : ℕ) :
    Set.InjOn (fun n => (n % m, n % k)) (Finset.range (Nat.lcm m k) : Set ℕ) := by
  intro a ha b hb hab
  simp only [Finset.coe_range, Set.mem_Iio] at ha hb
  simp only [Prod.mk.injEq] at hab
  have h : a ≡ b [MOD Nat.lcm m k] :=
    Nat.mod_lcm hab.1 hab.2
  unfold Nat.ModEq at h
  rwa [Nat.mod_eq_of_lt ha, Nat.mod_eq_of_lt hb] at h

/-- **The Loop Meeting Theorem.** Running a loop of length `m` beside a loop of length `k`,
the turns `0, 1, …, m * k - 1` reach exactly `lcm m k` different pairs of positions. Every later
turn repeats one of them (`loop_pair_periodic`). -/
theorem loop_meeting_count (m k : ℕ) :
    ((Finset.range (m * k)).image (fun n => (n % m, n % k))).card = Nat.lcm m k := by
  have hsub : (Finset.range (m * k)).image (fun n => (n % m, n % k)) =
      (Finset.range (Nat.lcm m k)).image (fun n => (n % m, n % k)) := by
    rcases Nat.eq_zero_or_pos m with rfl | hm
    · simp
    rcases Nat.eq_zero_or_pos k with rfl | hk
    · simp
    have hl : 0 < Nat.lcm m k := Nat.lcm_pos hm hk
    have hle : Nat.lcm m k ≤ m * k := Nat.le_of_dvd (Nat.mul_pos hm hk) (Nat.lcm_dvd_mul m k)
    ext p
    simp only [Finset.mem_image, Finset.mem_range]
    constructor
    · rintro ⟨n, -, rfl⟩
      exact ⟨n % Nat.lcm m k, Nat.mod_lt _ hl, loop_pair_periodic m k n⟩
    · rintro ⟨n, hn, rfl⟩
      exact ⟨n, lt_of_lt_of_le hn hle, rfl⟩
  rw [hsub, Finset.card_image_of_injOn (loop_pairs_injective m k), Finset.card_range]

/-- Pairs reached × `gcd m k` = all `m * k` possible pairs. -/
theorem loop_meeting_times_gcd (m k : ℕ) :
    ((Finset.range (m * k)).image (fun n => (n % m, n % k))).card * Nat.gcd m k = m * k := by
  rw [loop_meeting_count, mul_comm, Nat.gcd_mul_lcm]

/-- Two loops meet every pair of positions exactly when their lengths share no factor. -/
theorem loop_meeting_full_iff {m k : ℕ} (hm : 0 < m) (hk : 0 < k) :
    ((Finset.range (m * k)).image (fun n => (n % m, n % k))).card = m * k ↔ Nat.Coprime m k := by
  rw [loop_meeting_count]
  constructor
  · intro h
    have h1 := Nat.gcd_mul_lcm m k
    rw [h] at h1
    exact Nat.eq_of_mul_eq_mul_right (Nat.mul_pos hm hk) (by rw [h1, one_mul])
  · exact Nat.Coprime.lcm_eq_mul

/-- Two loops of the same length `m` lock: they meet only `m` of the `m * m` pairs. -/
theorem loop_meeting_same_length (m : ℕ) :
    ((Finset.range (m * m)).image (fun n => (n % m, n % m))).card = m := by
  rw [loop_meeting_count, Nat.lcm_self]

end Umbrella.LoopMeeting
