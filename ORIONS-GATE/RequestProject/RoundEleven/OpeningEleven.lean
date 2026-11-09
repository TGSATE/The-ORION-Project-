module

public import Mathlib
public import RequestProject.RoundNine.FifthPassNine

/-! Proposed room transition rule for Round 11. This is a rule model, not a deployed service. -/
@[expose] public section
namespace RoundEleven

/-- A protected room becomes a one-person room if its guardian leaves; the minor stays. -/
def guardianLeaves (minor : ℕ) (guardianPresent : Bool) (room : Finset ℕ) : Finset ℕ :=
  if guardianPresent then room else {minor}

/-- The unaccompanied minor remains in the room. -/
theorem minor_stays (minor : ℕ) (room : Finset ℕ) :
    minor ∈ guardianLeaves minor false room := by simp [guardianLeaves]

/-- No other participant remains in that room after loss of guardian supervision. -/
theorem singularity_excludes_others (minor x : ℕ) (room : Finset ℕ)
    (hx : x ≠ minor) : x ∉ guardianLeaves minor false room := by
  simpa [guardianLeaves] using hx

/-- Joining a one-person room requires a newly authorized, separately checked transition. -/
def joinIfSupervised (minor newcomer : ℕ) (supervised : Bool) : Finset ℕ :=
  if supervised then {minor, newcomer} else {minor}

theorem unsupervised_join_denied (minor newcomer : ℕ) (h : newcomer ≠ minor) :
    newcomer ∉ joinIfSupervised minor newcomer false := by
  simpa [joinIfSupervised] using h

/-- One tagged contributor with positive weight takes the entire 7% pot. -/
theorem only_contributor_receives_pot (sale weight : ℕ) (hw : 0 < weight) :
    RoundNineFifth.contribShare sale weight weight = RoundNineFifth.contribPot sale := by
  unfold RoundNineFifth.contribShare
  rw [Nat.mul_comm]
  exact Nat.mul_div_cancel_left _ hw

/-- Correct arithmetic for the factorization asserted in the Round 10 pasted analysis. -/
theorem factorization_144000 : 144000 = 2 ^ 7 * 3 ^ 2 * 5 ^ 3 := by norm_num

theorem pasted_factorization_is_incorrect : 144000 ≠ 2 ^ 5 * 3 ^ 2 * 5 ^ 3 * 7 := by norm_num

/-- The least common multiple in the pasted divisor checklist is 7200, not 2880. -/
theorem checklist_lcm :
    ([360, 100, 3, 4, 5, 6, 10, 12, 16, 18, 32, 36, 40, 60, 72, 96] : List ℕ).foldl Nat.lcm 1 = 7200 := by
  decide

/-- The thirteen proposed prime axes have this least common multiple of predecessors. -/
theorem prime_axis_lcm :
    (([2, 3, 5, 7, 11, 13, 17, 19, 23, 29, 31, 37, 41] : List ℕ).map (· - 1)).foldl Nat.lcm 1 = 55440 := by
  decide

/-- A purported list of only five divisibility-aligned axes omits 13, among others. -/
theorem thirteen_also_divides : (13 - 1 : ℕ) ∣ 144000 := by decide

end RoundEleven
