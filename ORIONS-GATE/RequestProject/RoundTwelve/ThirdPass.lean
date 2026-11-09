module

public import Mathlib

/-!
# Round 12, third pass: the number log, this round's links, and two review rules

1. **Number log (Beth).** The traditional numerology "reduction" of a date adds its digits
   repeatedly until one digit is left, keeping the master numbers 11, 22 and 33. The
   reductions quoted in `BETH_NUMEROLOGY_LOG_FOR_TEAM.md` are checked here, together with
   simple counts about this week's entries (30 September to 6 October 2026).
   These are arithmetic facts about the written numbers. They are not evidence for or
   against any numerological or astrological meaning.
2. **Mike's link (Monster group).** The order of the Monster group, as a prime
   factorisation, equals the 54-digit number quoted on the Wikipedia page.
3. **Mike's idea "from planets to Galois fields".** A Galois field of order `p ^ n` exists
   for every prime `p` and every `n ≠ 0`; for example there is a field with 8 elements.
4. **Marek's first gate (hypersurface dynamics).** If one step of an evolution rule keeps
   the constraints satisfied, then every number of steps does; and a single failing run
   is enough to reject the rule ("fail-closed").
5. **Ryne's register rule.** The counterexample register only grows: adding a new entry
   never removes an older one ("no disappearing failures"), and every A0 counterexample
   keeps one of the four written dispositions.
-/

@[expose] public section

namespace RoundTwelveThirdPass

/-! ## 1. Numerology reductions -/

/-- Sum of the decimal digits of `n`. -/
def digitSum (n : ℕ) : ℕ := (Nat.digits 10 n).sum

/-- Repeated digit sum, keeping the master numbers 11, 22 and 33 (with enough fuel). -/
def reduceAux : ℕ → ℕ → ℕ
  | 0, n => n
  | fuel + 1, n =>
    if n < 10 ∨ n = 11 ∨ n = 22 ∨ n = 33 then n else reduceAux fuel (digitSum n)

/-- The numerology reduction of `n`. Ten rounds is more than enough for the numbers here. -/
def reduce (n : ℕ) : ℕ := reduceAux 10 n

/-- The log's opening marker `11052024` (5 November 2024) reduces to 6. -/
theorem marker_11052024 : digitSum 11052024 = 15 ∧ reduce 11052024 = 6 := by decide

/-- The marker `01062026` (6 January 2026) reduces to 8. -/
theorem marker_01062026 : digitSum 1062026 = 17 ∧ reduce 1062026 = 8 := by decide

/-- Today, `10062026` (6 October 2026), reduces to 8. -/
theorem today_10062026 : digitSum 10062026 = 17 ∧ reduce 10062026 = 8 := by decide

/-- The universal year 2026 reduces to 1 (2 + 0 + 2 + 6 = 10, then 1 + 0 = 1). -/
theorem year_2026 : digitSum 2026 = 10 ∧ reduce 2026 = 1 := by decide

/-- This week's dates, written month-day-year: 30 September 2026 is a master number 22,
and 1 to 6 October reduce to 3, 4, 5, 6, 7, 8 in order. -/
theorem week_dates :
    reduce 9302026 = 22 ∧ reduce 10012026 = 3 ∧ reduce 10022026 = 4 ∧
    reduce 10032026 = 5 ∧ reduce 10042026 = 6 ∧ reduce 10052026 = 7 ∧
    reduce 10062026 = 8 := by decide

/-- A number is a palindrome when its decimal digits read the same both ways. -/
def IsPal (n : ℕ) : Prop := Nat.digits 10 n = (Nat.digits 10 n).reverse

instance (n : ℕ) : Decidable (IsPal n) := by unfold IsPal; infer_instance

/-- Today's entry, as written: `555 808 949 1111 1122 1221`. -/
def today : List ℕ := [555, 808, 949, 1111, 1122, 1221]

/-- Five of today's six numbers are palindromes (`1122` is the one that is not). -/
theorem today_palindromes : (today.filter (fun n => decide (IsPal n))).length = 5 ∧
    ¬ IsPal 1122 := by decide

/-- Today's numbers add up to 5766, which reduces to 6. -/
theorem today_sum : today.sum = 5766 ∧ reduce 5766 = 6 := by decide

/-- This week's entries, 30 September to 6 October 2026, numbers only, as written
(`0505` on 30 September is stored as `505`). -/
def week : List (List ℕ) :=
  [ [606, 717, 1001, 144, 505, 616, 717, 727, 757, 1133],
    [636, 959, 1122, 1155, 1221, 151, 404, 555, 654, 555, 818],
    [717, 1001, 1111, 1133, 144, 616, 707, 757, 1111, 1122],
    [1133, 333, 432, 444, 55, 757, 919],
    [656, 1144, 555, 313, 343, 444, 505, 727, 757, 44, 7722, 1144],
    [636, 646, 838, 939, 1111, 404, 424, 909, 949, 1111, 1133, 1155, 949, 1111, 1122, 1221],
    today ]

/-- 72 numbers were logged this week. -/
theorem week_total : (week.map List.length).sum = 72 := by decide

/-- `1111` was logged 6 times this week; `757`, `1133`, `555` and `1122` 4 times each;
`144` twice. -/
theorem week_counts : week.flatten.count 1111 = 6 ∧ week.flatten.count 757 = 4 ∧
    week.flatten.count 1133 = 4 ∧ week.flatten.count 555 = 4 ∧
    week.flatten.count 1122 = 4 ∧ week.flatten.count 144 = 2 := by decide

/-- No number was logged more often this week than `1111`. -/
theorem week_1111_most_frequent :
    ∀ n ∈ week.flatten, week.flatten.count n ≤ week.flatten.count 1111 := by decide

/-- The "11-family" of numbers: `1111 1122 1133 1144 1155 1212 1221`. -/
def elevenFamily : List ℕ := [1111, 1122, 1133, 1144, 1155, 1212, 1221]

/-- 21 of this week's 72 numbers belong to the 11-family. -/
theorem week_eleven_family :
    (week.flatten.filter (fun n => decide (n ∈ elevenFamily))).length = 21 := by decide

/-! ## 2. The Monster group's order -/

/-- The prime factorisation of the Monster group's order equals the 54-digit number. -/
theorem monster_order :
    2 ^ 46 * 3 ^ 20 * 5 ^ 9 * 7 ^ 6 * 11 ^ 2 * 13 ^ 3 * 17 * 19 * 23 * 29 * 31 * 41 * 47 *
      59 * 71 = (808017424794512875886459904961710757005754368000000000 : ℕ) := by norm_num

/-! ## 3. Galois fields -/

/-- For every prime `p` and `n ≠ 0` there is a field with exactly `p ^ n` elements. -/
theorem galois_field_exists (p : ℕ) [Fact p.Prime] (n : ℕ) (hn : n ≠ 0) :
    Nat.card (GaloisField p n) = p ^ n :=
  GaloisField.card p n hn

/-- For example, there is a field with 8 elements. -/
theorem field_with_eight_elements : Nat.card (GaloisField 2 3) = 8 := by
  haveI : Fact (Nat.Prime 2) := ⟨Nat.prime_two⟩
  simpa using GaloisField.card 2 3 (by norm_num)

/-! ## 4. Marek's constraint-surface gate -/

/-- If one step `F` keeps the constraints `C` satisfied, then every number of steps does. -/
theorem constraints_preserved_forever {S : Type*} (C : S → Prop) (F : S → S)
    (hF : ∀ s, C s → C (F s)) (s₀ : S) (h₀ : C s₀) : ∀ n : ℕ, C (F^[n] s₀) := by
  intro n
  induction n generalizing s₀ with
  | zero => simpa using h₀
  | succ n ih =>
    rw [Function.iterate_succ_apply]
    exact ih (F s₀) (hF s₀ h₀)

/-- Fail-closed: one run that starts on the constraint surface and leaves it after some
number of steps is enough to reject the step rule as constraint-preserving. -/
theorem fail_closed {S : Type*} (C : S → Prop) (F : S → S) (s₀ : S) (h₀ : C s₀) (n : ℕ)
    (hbad : ¬ C (F^[n] s₀)) : ¬ ∀ s, C s → C (F s) :=
  fun hF => hbad (constraints_preserved_forever C F hF s₀ h₀ n)

/-! ## 5. Ryne's register rule -/

/-- The four written dispositions for an A0 counterexample under a future A1. -/
inductive Disposition
  | unresolved
  | reproduced
  | normalized
  | retiredWithCatalogueChange
  deriving DecidableEq

/-- A register entry: a triplet identifier and its disposition. -/
structure Entry where
  triplet : String
  disposition : Disposition

/-- The register only appends. -/
def record (reg : List Entry) (e : Entry) : List Entry := reg ++ [e]

/-- No disappearing failures: recording a new entry keeps every older entry. -/
theorem record_keeps (reg : List Entry) (e old : Entry) (h : old ∈ reg) :
    old ∈ record reg e := List.mem_append_left _ h

/-- Recording any sequence of new entries keeps every older entry. -/
theorem record_all_keeps (reg : List Entry) (news : List Entry) (old : Entry)
    (h : old ∈ reg) : old ∈ news.foldl record reg := by
  induction news generalizing reg with
  | nil => simpa using h
  | cons e es ih => exact ih (record reg e) (record_keeps reg e old h)

/-- A1's success criterion: every entry is resolved (reproduced, normalized, or retired with
a documented catalogue change). -/
def A1Succeeds (reg : List Entry) : Prop :=
  ∀ e ∈ reg, e.disposition ≠ Disposition.unresolved

/-- If any counterexample is still unresolved, A1 has not succeeded, however many entries
are added later. -/
theorem unresolved_blocks_success (reg news : List Entry) (e : Entry) (h : e ∈ reg)
    (hu : e.disposition = Disposition.unresolved) : ¬ A1Succeeds (news.foldl record reg) :=
  fun hs => hs e (record_all_keeps reg news e h) hu

end RoundTwelveThirdPass
