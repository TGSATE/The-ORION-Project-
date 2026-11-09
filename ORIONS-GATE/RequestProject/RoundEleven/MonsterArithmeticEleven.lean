module

public import Mathlib.Tactic

/-!
# Round Eleven: arithmetic checks for the Monster / moonshine discussion

These are arithmetic facts about numerals appearing in the page, **not** a
construction of the Monster group, its representations, or the modular invariant.
The interpretation of the numerals as group orders or representation dimensions
requires separate mathematical sources and proofs.
-/

@[expose] public section

namespace RoundElevenMonster

/-- The stated prime powers multiply to the stated numerical order. This verifies
multiplication, not that the number is the order of a particular group. -/
theorem displayed_order_factorization :
    (808017424794512875886459904961710757005754368000000000 : ℕ) =
      2 ^ 46 * 3 ^ 20 * 5 ^ 9 * 7 ^ 6 * 11 ^ 2 * 13 ^ 3 *
      17 * 19 * 23 * 29 * 31 * 41 * 47 * 59 * 71 := by
  norm_num

/-- The first displayed coefficient decomposition is numerically correct. -/
theorem first_coefficient_arithmetic :
    (196884 : ℕ) = 1 + 196883 := by norm_num

/-- The second displayed coefficient decomposition is numerically correct. -/
theorem second_coefficient_arithmetic :
    (21493760 : ℕ) = 1 + 196883 + 21296876 := by norm_num

end RoundElevenMonster
