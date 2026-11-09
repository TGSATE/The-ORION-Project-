module

public import Mathlib

public section

/-!
# Round 17 · Level 1: small checks for this level

1. **Mike's "Monster climbing gym" (X post, 8 October 2026).** Mike wrote that ChatGPT got the
   primes wrong and gave the correct factorisation
   `2^46 · 3^20 · 5^9 · 7^6 · 11^2 · 13^3 · 17 · 19 · 23 · 29 · 31 · 41 · 47 · 59 · 71`.
   We check the arithmetic: that product is the 54-digit number below, its prime factors are
   exactly those 15 primes, and the picture's list of 15 "Ogg primes" is wrong (it has 37 and 43,
   which do not divide the number, and it is missing 59 and 71). That this number is the order of
   the Monster group is the standard published value; Lean's library has no Monster group, so the
   check here is about the number only.
2. **Hatching a baby dragon: two doors and a seat (Beth's 🤟💎, 17.1).** A player hatches by
   doing the quest (*earned*) or by arriving with the circumstance the quest tests for
   (*recognised*). Either door gives the same dragon, nobody gets two, and the first player to
   break the capstone is the one seated in the lore: later breakers never overwrite them. In
   keeping with the existing capstone rule, a break only counts with council support.

These are statements about the rules as written here, not about any running app.
-/

namespace R17L1

/-! ## 1. The Monster climbing gym -/

/-- Mike's corrected factorisation, as a natural number. -/
def monsterOrder : ℕ :=
  2^46 * 3^20 * 5^9 * 7^6 * 11^2 * 13^3 * 17 * 19 * 23 * 29 * 31 * 41 * 47 * 59 * 71

/-- The product works out to this 54-digit number. -/
theorem monsterOrder_eq :
    monsterOrder = 808017424794512875886459904961710757005754368000000000 := by
  unfold monsterOrder; norm_num

/-- The 15 primes in Mike's correction (the supersingular or "Ogg" primes). -/
def oggPrimes : Finset ℕ := {2, 3, 5, 7, 11, 13, 17, 19, 23, 29, 31, 41, 47, 59, 71}

/-- The 15 primes printed on the picture's "15 primes (Ogg primes)" panel. -/
def picturePrimes : Finset ℕ := {2, 3, 5, 7, 11, 13, 17, 19, 23, 29, 31, 37, 41, 43, 47}

/-- The primes dividing Mike's number are exactly his 15 primes. -/
theorem primeFactors_monsterOrder : monsterOrder.primeFactors = oggPrimes := by
  unfold monsterOrder oggPrimes
  repeat rw [Nat.primeFactors_mul (by positivity) (by positivity)]
  rw [Nat.primeFactors_pow _ (by norm_num), Nat.primeFactors_pow _ (by norm_num),
    Nat.primeFactors_pow _ (by norm_num), Nat.primeFactors_pow _ (by norm_num),
    Nat.primeFactors_pow _ (by norm_num), Nat.primeFactors_pow _ (by norm_num)]
  simp only [Nat.Prime.primeFactors (by norm_num : Nat.Prime 2),
    Nat.Prime.primeFactors (by norm_num : Nat.Prime 3),
    Nat.Prime.primeFactors (by norm_num : Nat.Prime 5),
    Nat.Prime.primeFactors (by norm_num : Nat.Prime 7),
    Nat.Prime.primeFactors (by norm_num : Nat.Prime 11),
    Nat.Prime.primeFactors (by norm_num : Nat.Prime 13),
    Nat.Prime.primeFactors (by norm_num : Nat.Prime 17),
    Nat.Prime.primeFactors (by norm_num : Nat.Prime 19),
    Nat.Prime.primeFactors (by norm_num : Nat.Prime 23),
    Nat.Prime.primeFactors (by norm_num : Nat.Prime 29),
    Nat.Prime.primeFactors (by norm_num : Nat.Prime 31),
    Nat.Prime.primeFactors (by norm_num : Nat.Prime 41),
    Nat.Prime.primeFactors (by norm_num : Nat.Prime 47),
    Nat.Prime.primeFactors (by norm_num : Nat.Prime 59),
    Nat.Prime.primeFactors (by norm_num : Nat.Prime 71)]
  decide

/-- There are 15 of them: one climbing wall per prime. -/
theorem oggPrimes_card : oggPrimes.card = 15 := by decide

/-- The picture's 37 and 43 do not divide the number. -/
theorem picture_extra_primes_do_not_divide :
    ¬ 37 ∣ monsterOrder ∧ ¬ 43 ∣ monsterOrder := by
  unfold monsterOrder; constructor <;> norm_num

/-- The picture's prime list is wrong: it has 37 and 43 and is missing 59 and 71. -/
theorem picture_list_is_wrong :
    picturePrimes \ oggPrimes = {37, 43} ∧ oggPrimes \ picturePrimes = {59, 71} := by
  decide

/-! ## 2. Hatching a baby dragon: two doors and a seat -/

/-- What the hatching rule needs to know about a player. -/
structure Hatchling where
  /-- Did the quest requirement (the *earned* door). -/
  questDone : Bool
  /-- Arrived already holding the circumstance the quest tests for (the *recognised* door). -/
  arrivedWith : Bool
  /-- Has a baby dragon. -/
  hasDragon : Bool
  deriving DecidableEq

/-- A player may hatch through either door. -/
def canHatch (p : Hatchling) : Bool := p.questDone || p.arrivedWith

/-- Hatching: if a door is open, the player gets their dragon; otherwise nothing changes. -/
def hatch (p : Hatchling) : Hatchling :=
  if canHatch p then { p with hasDragon := true } else p

/-- The earned door works. -/
theorem earned_door_hatches (p : Hatchling) (h : p.questDone = true) :
    (hatch p).hasDragon = true := by
  simp [hatch, canHatch, h]

/-- The recognised door works without doing the quest again ("baby dragon at lunch"). -/
theorem recognised_door_hatches (p : Hatchling) (h : p.arrivedWith = true) :
    (hatch p).hasDragon = true := by
  simp [hatch, canHatch, h]

/-- With neither door open, hatching changes nothing. -/
theorem no_door_no_change (p : Hatchling) (h1 : p.questDone = false)
    (h2 : p.arrivedWith = false) : hatch p = p := by
  simp [hatch, canHatch, h1, h2]

/-- Hatching twice is the same as hatching once: nobody gets a second dragon this way. -/
theorem hatch_twice (p : Hatchling) : hatch (hatch p) = hatch p := by
  unfold hatch canHatch
  by_cases h : (p.questDone || p.arrivedWith) = true <;> simp [h]

/-- The capstone seat in the lore: empty, or the player id of the first breaker. A break counts
only with council support (the existing capstone rule); the first counted break is seated and is
never overwritten. -/
def breakCapstone (seat : Option ℕ) (who : ℕ) (councilSupport : Bool) : Option ℕ :=
  match seat with
  | some first => some first
  | none => if councilSupport then some who else none

/-- Run a sequence of break attempts `(player, council support?)` from an empty seat. -/
def seatAfter (attempts : List (ℕ × Bool)) : Option ℕ :=
  attempts.foldl (fun s a => breakCapstone s a.1 a.2) none

/-- Once someone is seated, later attempts never change the seat. -/
theorem seated_stays_seated (first : ℕ) (attempts : List (ℕ × Bool)) :
    attempts.foldl (fun s a => breakCapstone s a.1 a.2) (some first) = some first := by
  induction attempts with
  | nil => rfl
  | cons a rest ih => simpa [breakCapstone] using ih

/-- Without council support a break does not count. -/
theorem no_support_no_seat (who : ℕ) : breakCapstone none who false = none := by
  simp [breakCapstone]

/-- The seat goes to the first player whose break had council support. -/
theorem seat_is_first_supported (attempts : List (ℕ × Bool)) :
    seatAfter attempts = ((attempts.filter (fun a => a.2)).head?).map Prod.fst := by
  unfold seatAfter
  induction attempts with
  | nil => rfl
  | cons a rest ih =>
    obtain ⟨who, sup⟩ := a
    cases sup
    · simpa [breakCapstone] using ih
    · simpa [breakCapstone] using seated_stays_seated who rest

end R17L1
