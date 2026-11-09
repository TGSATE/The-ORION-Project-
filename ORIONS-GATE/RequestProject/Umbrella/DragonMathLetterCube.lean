module

public import Mathlib

/-!
# Lucien's Dragon Math and the language counts (☂️1.9, Chapter 2)

Beth asked: "how does Lucian's Dragon math work into all of the language counts?"

Lucien has not written down how to read Dragon Math. What we have is his own label,
*"Inventeur du 9 au cube par 3 (93)"*, and the numbers in his pictures (5, 93, 55, a 9-to-1
countdown, "Heartcore 9999"). This file checks the plain arithmetic behind one *proposed*
reading. It is our reading, not Lucien's, until he confirms it.

* **"9 au cube" is 9³ = 729**, and "93" is how 9³ looks when the small 3 is typed flat.
  `nine_cubed_three_ways`: 9³ = 27² = 3⁶ = 729, and 9 × 3 = 3³ = 27.
* **"par 3" gives a 3 × 3 × 3 cube of 27 cells** (`letterCube`): every cell number below 27
  matches exactly one triple of coordinates, each 0, 1 or 2.
* **27 is the size of the old alphabet-numeral systems.** Greek and Hebrew letter-numbers use
  nine signs for units, nine for tens and nine for hundreds. `rankSign` gives those 27 values,
  `rankSign_injective` shows they are all different, and `rankSign_values` lists them.
* **9³ = 729 again:** exactly 729 numbers from 1 to 999 need one sign from each of the three
  ranks (`three_sign_numbers`).
* **The ×6 cipher reads only one axis of the cube** (`times_six_root_by_cube_axis`): the
  3-6-9 digital root of 6n depends only on n mod 3.

These are Level B results (mathematics) only.
-/

@[expose] public section

namespace Umbrella.DragonMath

/-- "9 au cube" three ways: 9³ = 27² = 3⁶ = 729, and "par 3": 9 × 3 = 3³ = 27. -/
theorem nine_cubed_three_ways :
    9 ^ 3 = 729 ∧ 27 ^ 2 = 729 ∧ 3 ^ 6 = 729 ∧ 9 * 3 = 27 ∧ 3 ^ 3 = 27 := by
  norm_num

/-- The 3 × 3 × 3 letter cube: the 27 cells numbered 0 to 26 match the coordinate triples
one-to-one (the base-3 digits of the cell number). -/
def letterCube : Fin 27 ≃ Fin 3 × Fin 3 × Fin 3 where
  toFun i := (⟨i.val / 9, by omega⟩, ⟨i.val / 3 % 3, by omega⟩, ⟨i.val % 3, by omega⟩)
  invFun p := ⟨9 * p.1.val + 3 * p.2.1.val + p.2.2.val, by omega⟩
  left_inv := by decide
  right_inv := by decide

/-- The cube has exactly 27 cells, and 27 cells is exactly 3 × 3 × 3. -/
theorem letter_cube_card :
    Fintype.card (Fin 3 × Fin 3 × Fin 3) = 27 ∧ Function.Bijective letterCube :=
  ⟨by simp, letterCube.bijective⟩

/-- The value of sign number `i` in a three-rank letter-numeral system (Greek, Hebrew):
signs 0–8 are 1–9, signs 9–17 are 10–90, signs 18–26 are 100–900. -/
def rankSign (i : Fin 27) : ℕ := (i.val % 9 + 1) * 10 ^ (i.val / 9)

/-- No two of the 27 signs have the same value. -/
theorem rankSign_injective : Function.Injective rankSign := by
  decide

/-- The 27 sign values are exactly 1–9, 10–90 and 100–900. -/
theorem rankSign_values :
    (List.finRange 27).map rankSign =
      [1, 2, 3, 4, 5, 6, 7, 8, 9,
       10, 20, 30, 40, 50, 60, 70, 80, 90,
       100, 200, 300, 400, 500, 600, 700, 800, 900] := by
  decide

/-- The alphabets fill the 27 cells in the traditional way: Greek 24 letters + 3 archaic
numeral signs, Hebrew 22 letters + 5 final forms, Arabic abjad 28 = 27 + one sign for 1000,
and Latin 26 letters + 1 (only a blank, no historical numeral sign). -/
theorem alphabets_in_the_cube :
    24 + 3 = 27 ∧ 22 + 5 = 27 ∧ 28 = 27 + 1 ∧ 26 + 1 = 27 := by
  norm_num

/-- Exactly 9³ = 729 numbers from 1 to 999 have no zero digit, so they need one sign from each
of the three ranks. -/
theorem three_sign_numbers :
    ((List.range 1000).filter
      (fun n => 100 ≤ n ∧ n % 10 ≠ 0 ∧ n / 10 % 10 ≠ 0)).length = 9 ^ 3 := by
  decide +kernel

/-- The ×6 cipher's 3-6-9 digital root of `6 * n` depends only on `n % 3`, which is the last
cube coordinate of the cell numbered `n`: 9 when `n % 3 = 0`, 6 when `n % 3 = 1`, 3 when
`n % 3 = 2`. (The digital root of a positive `m` is `(m - 1) % 9 + 1`.) -/
theorem times_six_root_by_cube_axis (n : ℕ) (hn : 0 < n) :
    (6 * n - 1) % 9 + 1 = if n % 3 = 0 then 9 else if n % 3 = 1 then 6 else 3 := by
  split_ifs <;> omega

/-- The cube coordinate that the ×6 cipher reads is the last base-3 digit of the cell number. -/
theorem last_cube_coordinate (i : Fin 27) : ((letterCube i).2.2 : ℕ) = i.val % 3 := by
  rfl

/-- The other numbers in Lucien's pictures, as plain arithmetic: 55 = 1 + 2 + ⋯ + 10, the
9-to-1 countdown adds to 45, 93 = 3 × 31, and 9999 = 10⁴ − 1 = 9 × 1111. -/
theorem dragon_numbers :
    (List.range 11).sum = 55 ∧ (List.range 10).sum = 45 ∧ 93 = 3 * 31 ∧
      9999 = 10 ^ 4 - 1 ∧ 9999 = 9 * 1111 := by
  decide

/-- Honest limit: Cyrillic's 33 letters do not fit one cube, and every alphabet up to 27
letters fits once padding is allowed, so the cube only means something if the padding signs are
named in advance. -/
theorem cube_fit_limits : ¬ (33 ≤ 27) ∧ ∀ n ≤ 27, ∃ pad, n + pad = 27 :=
  ⟨by norm_num, fun n hn => ⟨27 - n, by omega⟩⟩

end Umbrella.DragonMath
