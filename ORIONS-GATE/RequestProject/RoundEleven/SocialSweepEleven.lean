module

public import Mathlib.Tactic

/-!
# Round Eleven, page version 1559: roster rule and checks of shared posts

* A formal model of the roster rule written on the page: the development team is
  Mike, Matthew, Lucian and Ryan (a dictated "Ryne" means Ryan); everyone else newly
  added is a contributor unless the designer says otherwise.
* Exact checks of three statements made in the shared public posts (repunit squares,
  Curie's law scaling, and clock-cycle intervals).

These model written rules and check arithmetic only. They are not running game
code and do not vet the posts' broader claims.
-/

@[expose] public section

namespace RoundElevenSocial

/-! ## Roster rule -/

/-- Roles on the roster. -/
inductive Role where
  | developmentTeam
  | contributor
  deriving DecidableEq, Repr

/-- The development team as written on the page (version 1559). -/
def developmentTeam : List String := ["Mike", "Matthew", "Lucian", "Ryan"]

/-- Dictation correction: "Ryne" means Ryan. All other names are kept as written. -/
def normalizeName (name : String) : String :=
  if name = "Ryne" then "Ryan" else name

/-- Role of a newly added person. `designerSaysDev` records an explicit instruction
from the designer to place someone on the development team. -/
def roleOf (name : String) (designerSaysDev : Bool) : Role :=
  if normalizeName name ∈ developmentTeam ∨ designerSaysDev = true then
    .developmentTeam
  else
    .contributor

/-- A dictated "Ryne" is placed on the development team as Ryan. -/
theorem ryne_is_ryan_on_team (b : Bool) : roleOf "Ryne" b = .developmentTeam := by
  simp [roleOf, normalizeName, developmentTeam]

/-- By default, a new account that is not on the four-person team is a contributor only. -/
theorem new_account_defaults_to_contributor (name : String)
    (h : normalizeName name ∉ developmentTeam) :
    roleOf name false = .contributor := by
  simp [roleOf, h]

/-- Each of the four named people is on the development team, whatever the default. -/
theorem named_team_members (b : Bool) :
    ∀ n ∈ developmentTeam, roleOf n b = .developmentTeam := by
  intro n hn
  simp only [developmentTeam, List.mem_cons, List.not_mem_nil, or_false] at hn
  rcases hn with rfl | rfl | rfl | rfl <;> simp [roleOf, normalizeName, developmentTeam]

/-! ## Checks of statements in shared posts -/

/-- Shared post (@matheorems): nine ones squared gives the palindrome. -/
theorem nine_ones_squared : (111111111 : ℕ) ^ 2 = 12345678987654321 := by norm_num

/-- Shared post (@matheorems): with ten ones the carry breaks the palindrome. -/
theorem ten_ones_squared : (1111111111 : ℕ) ^ 2 = 1234567900987654321 := by norm_num

/-- Shared post (@cosmarium): under Curie's law `M = C * B / T`, doubling the absolute
temperature halves the magnetization (in the law's range of validity, `T > 0`). -/
theorem curie_double_temperature_halves (C B T : ℝ) (hT : 0 < T) :
    C * B / (2 * T) = (C * B / T) / 2 := by
  field_simp

/-- Shared post (@cosmosarcive): clock intervals counted as `n - m` cycles add up
along a chain of events. -/
theorem cycle_intervals_add (l m n : ℤ) : (n - m) + (m - l) = n - l := by ring

/-! ## Review of the Lean listing in the shared T.O.N.E. PDF

The listing printed in the PDF linked from @OverThePlaces's profile does not
elaborate as printed: its first `axiom` uses a constructor where a type is
expected. Below is the most charitable well-typed reading of its three axioms,
stated as hypotheses (no axioms are added here). -/

/-- The two instability kinds named in the listing. -/
inductive Instability where
  | statics
  | regress

/-- Charitable reading of the listing's axioms: levels `≤ 2` produce an instability, and
`v3_neither` says no instability can occur. These hypotheses are contradictory, so
anything at all follows from them. -/
theorem tone_axioms_inconsistent
    (low_levels_statics : ∀ n : ℕ, n ≤ 2 → Instability)
    (v3_neither : Instability → False) : False :=
  v3_neither (low_levels_statics 0 (by norm_num))

/-- The listing's `conjecture_necessity` concludes the Boolean `true`, which holds for
any premises at all (including false ones), so it says nothing about the Riemann
Hypothesis or any other named problem. -/
theorem tone_conjecture_conclusion_is_vacuous (P Q R : Prop) :
    R → (P ∧ Q) → (true = true) := fun _ _ => rfl

end RoundElevenSocial
