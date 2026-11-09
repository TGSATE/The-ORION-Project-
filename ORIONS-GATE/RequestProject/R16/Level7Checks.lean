module

public import Mathlib

public section

/-!
# Round 16 · Level 7: small checks for this level

1. **Organize, don't cut** (Beth's 🆘☢️🆘 correction to the Ghost Writer prompt). If the
   ghost writer only *reorders* a player's thoughts, every thought comes back, the same
   number of times. A word cap does not have this property: as soon as the dump is longer
   than the cap, something is lost.
2. **Mike's "One" repo, re-checked here.** The map `stepU` (even `n ↦ n + 3`, odd
   `n ↦ n + 1`) never moves a number by more than 3, yet its orbit from `0` grows without
   bound. This restates the claim in Mike's README in this project's Lean version and
   proves it from scratch; it is a fact about that one map, nothing more.

These are statements about the rules as written here, not about any running app.
-/

namespace R16L7

/-! ## 1. Organizing keeps everything; a cap does not -/

/-- Reordering a list of thoughts keeps every thought, with the same multiplicity. -/
theorem reorder_keeps_every_thought {α : Type*} [DecidableEq α] {dump reply : List α}
    (h : reply.Perm dump) (t : α) : reply.count t = dump.count t :=
  h.count_eq t

/-- Reordering never drops a thought. -/
theorem reorder_drops_nothing {α : Type*} {dump reply : List α}
    (h : reply.Perm dump) {t : α} (ht : t ∈ dump) : t ∈ reply :=
  h.symm.subset ht

/-- A cap of `n` items on a dump longer than `n` always loses something: the capped reply
is shorter, so it cannot be a reordering of the whole dump. -/
theorem cap_loses_something {α : Type*} (dump : List α) (n : ℕ) (hlong : n < dump.length) :
    ¬ (dump.take n).Perm dump := by
  intro h
  have := h.length_eq
  simp [List.length_take] at this
  omega

/-! ## 2. Mike's "One": bounded steps, unbounded orbit -/

/-- Even numbers move up by 3, odd numbers by 1. -/
def stepU (n : ℕ) : ℕ := if n % 2 = 0 then n + 3 else n + 1

/-- The orbit of `0` under `stepU`. -/
def orbitU : ℕ → ℕ
  | 0 => 0
  | k + 1 => stepU (orbitU k)

/-- Every single step moves by at most 3. -/
theorem stepU_bounded (n : ℕ) : n ≤ stepU n ∧ stepU n ≤ n + 3 := by
  unfold stepU; split_ifs <;> omega

/-- Two steps from an even number add exactly 4. -/
theorem stepU_two_steps_even (n : ℕ) (h : n % 2 = 0) : stepU (stepU n) = n + 4 := by
  unfold stepU
  rw [if_pos h, if_neg (by omega)]

/-- After `2k` steps the orbit of `0` is at `4k`. -/
theorem orbitU_double (k : ℕ) : orbitU (2 * k) = 4 * k := by
  induction k with
  | zero => rfl
  | succ k ih =>
    have h2 : 2 * (k + 1) = 2 * k + 1 + 1 := by ring
    rw [h2, orbitU, orbitU, ih, stepU_two_steps_even _ (by omega)]
    ring

/-- The orbit is unbounded: it passes every bound. -/
theorem orbitU_unbounded (B : ℕ) : ∃ k, B < orbitU k :=
  ⟨2 * (B + 1), by rw [orbitU_double]; omega⟩

end R16L7
