import Mathlib

/-!
# OR20 checks: the "24 and 42" sum of squares, and the evolution-deck slots

Two small, checkable things from Beth's OR18⏭️19 / OR20 Docs.

1. **24 vs 42.** A post Beth saved says `1² + 2² + ⋯ + 24² = 70²`, and Beth asked what happens
   if 42 is swapped for 24. We check the 24 fact, check that 42 does *not* give a perfect square,
   and check by computer that, among `2 ≤ n ≤ 1000`, 24 is the only `n` that works.
   (That 24 is the only one *for all* `n` is a classical theorem, G. N. Watson 1918; it is not
   proved here.)

2. **Evolution deck slots** (OR20, Beth 💎): the deck card holds the build cards and takes no slot;
   players have 4 slots; devs have 6; extra slots come "by twos".
-/

namespace OR20

/-- `squareSum n = 1² + 2² + ⋯ + n²`. -/
def squareSum (n : ℕ) : ℕ := ∑ k ∈ Finset.range (n + 1), k ^ 2

/-- The saved post is right: `1² + ⋯ + 24² = 70² = 4900`. -/
theorem squareSum_24 : squareSum 24 = 70 ^ 2 := by decide

/-- Swapping in 42: `1² + ⋯ + 42² = 25585`. -/
theorem squareSum_42 : squareSum 42 = 25585 := by decide

/-- 25585 is not a perfect square (159² = 25281, 160² = 25600). -/
theorem squareSum_42_not_square : ¬ ∃ m, squareSum 42 = m ^ 2 := by
  rintro ⟨m, hm⟩
  rw [squareSum_42] at hm
  have h1 : m ≤ 159 := by
    by_contra h
    have : 160 ^ 2 ≤ m ^ 2 := Nat.pow_le_pow_left (by omega) 2
    omega
  interval_cases m <;> omega

/-- Computer check: for `2 ≤ n ≤ 1000`, the sum `1² + ⋯ + n²` is a perfect square only at
`n = 24`. -/
theorem only_24_up_to_1000 :
    ∀ n ∈ Finset.Icc 2 1000, Nat.sqrt (squareSum n) ^ 2 = squareSum n → n = 24 := by
  native_decide

/-! ## Evolution deck slots -/

/-- Who holds the deck. -/
inductive Holder
  | player
  | dev
  deriving DecidableEq

/-- Slots inside the deck card. The deck card itself is the holder ("the table") and is not
counted. -/
def slots : Holder → ℕ
  | .player => 4
  | .dev => 6

/-- Devs have exactly one "by twos" step more than players. -/
theorem dev_slots_eq_player_add_two : slots .dev = slots .player + 2 := rfl

/-- Slot counts grow by twos: after `k` upgrades a player has `4 + 2k` slots. -/
def slotsAfter (k : ℕ) : ℕ := slots .player + 2 * k

theorem slotsAfter_even (k : ℕ) : Even (slotsAfter k) :=
  ⟨2 + k, by simp only [slotsAfter, slots]; ring⟩

theorem slotsAfter_one_eq_dev : slotsAfter 1 = slots .dev := rfl

end OR20
