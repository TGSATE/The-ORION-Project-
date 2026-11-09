module

public import Mathlib.Tactic

/-!
# Two arithmetic checks from the additional Round Eleven shared posts

These verify numerical claims in the posts, not their scientific or historical
interpretations and not the behavior of a running game.
-/

@[expose] public section

namespace RoundElevenSharedPosts

/-- The stated count of equally likely paths in a 12-row binary Galton board. -/
theorem galton_twelve_rows_paths : (2 : ℕ) ^ 12 = 4096 := by
  norm_num

/-- The central bin count and the exact probability quoted for 12 rows. -/
theorem galton_central_bin :
    (Nat.choose 12 6 = 924) ∧
      (Nat.choose 12 6 : ℚ) / 2 ^ 12 = 231 / 1024 := by
  constructor <;> norm_num [Nat.choose]

/-- Two times seven factorial is the number of minutes in seven days. -/
theorem week_minutes_factorial :
    2 * Nat.factorial 7 = 7 * 24 * 60 := by
  norm_num [Nat.factorial]

end RoundElevenSharedPosts
