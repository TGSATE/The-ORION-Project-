module

public import Mathlib
public import RequestProject.RoundSystem.DriverClosesTheRound

/-!
# R15·L1: council sizes, form auto-fill, readout labels, and the Tech Spec arithmetic

Models of four things Beth wrote in her Round 15 doc (7 October 2026). These check the rules as
written; they are not software running anywhere.

1. **Readout labels.** Beth: "at the end of this read out it would be 15.1 … when I finish this one
   I will do the swirls and end it with two because that's the next level." In the round ledger,
   one level from the freshly opened Round 15 gives `R15·L1`, and the marker she writes at the
   bottom of her doc (`L2`) names the level after it. Only the Engine's levels move the level
   number; they never move the round.
2. **Council sizes on the Gauntlet.** Beth: "three AI and a human at the first level, five AI and a
   human at the second, seven AI and a human at the third, 10 AI and a human at … the fourth
   gauntlet before it goes into level 13", with an Auditor at every council. A yes/no vote among
   an odd number of AI voters can never tie; among 10 it can (5–5). So the human's role at the
   fourth council decides whether ties are possible. This is recorded as a question, not a change.
3. **Form auto-fill.** Beth: fields a player already has on their public Roster or character
   sheet should fill themselves; only missing fields are asked, with a training toggle that asks
   everything until the skill is levelled.
4. **The Tech Spec arithmetic** on the Babel-to-Orion page: `12 × 12 = 144`, `3 + 141 = 144`,
   two 1.5 V cells in series give 3 V. Also what a dodecahedron actually has (12 faces, 20
   corners, 30 edges), since the page calls the 144 grid "a Dodecahedron geometry (12 Faces x 12
   Nodes)".
5. **The Matheorems cube** (an educational link in the doc): `(a+b)³` as 8 boxes, and the answer
   to the post's question about `(a+b)⁴`.
-/

namespace R15

open RoundSystem

/-! ## 1. Readout labels -/

/-- Round 15 as it was opened at the Round 14 close: open, level 0. -/
@[expose] public def round15Opened : Ledger := { round := 15, isOpen := true, level := 0 }

/-- The label Beth asked for at the bottom of every readout, as a pair (round, level):
`(15, 1)` is her "15.1", written `R15·L1`. -/
@[expose] public def footer (s : Ledger) : ℕ × ℕ := (s.round, s.level)

/-- The marker Beth writes at the end of her doc after a readout: the next level's number. -/
@[expose] public def nextMarker (s : Ledger) : ℕ := s.level + 1

/-- **This readout is 15.1**, and the marker at the end of Beth's doc (`L2`) is the next level. -/
public theorem this_readout_is_15_1 :
    footer (step round15Opened .engineLevel) = (15, 1) ∧
      nextMarker (step round15Opened .engineLevel) = 2 := by
  decide

/-- Each level moves the footer from `R·L` to `R·(L+1)` in an open round, never to `(R+1)·…`. -/
public theorem footer_after_level (s : Ledger) (h : s.isOpen = true) :
    footer (step s .engineLevel) = (s.round, s.level + 1) := by
  simp [footer, step, h]

/-- Running `k` levels from any open ledger keeps it open, keeps the round, and adds `k` levels. -/
public theorem run_levels (s : Ledger) (h : s.isOpen = true) (k : ℕ) :
    run s (List.replicate k .engineLevel) = { s with level := s.level + k } := by
  induction k generalizing s with
  | zero => simp [run]
  | succ k ih =>
    rw [List.replicate_succ, run, List.foldl_cons, ← run]
    have h1 : step s .engineLevel = { s with level := s.level + 1 } := by simp [step, h]
    rw [h1, ih { s with level := s.level + 1 } h]
    simp only [Ledger.mk.injEq, true_and]
    omega

/-- Any number `k` of levels from the opened Round 15 gives the footer `15.k`. -/
public theorem footer_after_k_levels (k : ℕ) :
    footer (run round15Opened (List.replicate k .engineLevel)) = (15, k) := by
  rw [run_levels _ rfl]
  simp [footer, round15Opened]

/-! ## 2. Council sizes on the Gauntlet -/

/-- AI seats at each of the four Trinity-Set councils, in Beth's words: 3, 5, 7, 10. -/
@[expose] public def aiSeats : List ℕ := [3, 5, 7, 10]

/-- One human sits at every council. -/
@[expose] public def humanSeats : List ℕ := [1, 1, 1, 1]

/-- 25 AI seats and 4 human seats across the four councils. -/
public theorem seat_totals : aiSeats.sum = 25 ∧ humanSeats.sum = 4 := by decide

/-- A yes/no vote among `n` voters ties when the yes votes are exactly half. -/
@[expose] public def canTie (n : ℕ) : Prop := ∃ yes ≤ n, yes = n - yes

/-- **An odd number of voters can never tie.** -/
public theorem odd_never_ties (n : ℕ) (h : Odd n) : ¬ canTie n := by
  rintro ⟨yes, hle, heq⟩
  obtain ⟨k, rfl⟩ := h
  omega

/-- **An even number of voters can tie**: half yes, half no. -/
public theorem even_can_tie (n : ℕ) (h : Even n) : canTie n := by
  obtain ⟨k, rfl⟩ := h
  exact ⟨k, by omega, by omega⟩

/-- The first three councils have an odd number of AI voters (3, 5, 7): no AI tie is possible.
The fourth, with 10 AI voters, can tie 5–5. -/
public theorem first_three_odd_fourth_even :
    Odd 3 ∧ Odd 5 ∧ Odd 7 ∧ Even 10 := by decide

/-- If the human also votes, the counts become 4, 6, 8 (all can tie) and 11 (cannot). -/
public theorem with_human_voting :
    canTie 4 ∧ canTie 6 ∧ canTie 8 ∧ ¬ canTie 11 :=
  ⟨even_can_tie 4 (by decide), even_can_tie 6 (by decide), even_can_tie 8 (by decide),
    odd_never_ties 11 (by decide)⟩

/-! ## 3. Form auto-fill with a training toggle -/

section Forms

variable {Field : Type*} [DecidableEq Field]

/-- The fields a form asks the player to type. In training mode it asks every required field;
otherwise it asks only the required fields the player has not already recorded. -/
@[expose] public def asked (training : Bool) (required known : Finset Field) : Finset Field :=
  if training then required else required \ known

/-- With training off, **a field you already have on record is never asked again.** -/
public theorem autofill_never_asks_known (required known : Finset Field) (f : Field)
    (hf : f ∈ known) : f ∉ asked false required known := by
  simp [asked, hf]

/-- Nothing required gets lost: every required field is either asked or already on record. -/
public theorem autofill_covers_required (required known : Finset Field) (training : Bool) :
    required ⊆ asked training required known ∪ known := by
  intro f hf
  cases training <;> by_cases hk : f ∈ known <;> simp_all [asked]

/-- Training mode asks every required field (for practising form-filling). -/
public theorem training_asks_all (required known : Finset Field) :
    asked true required known = required := by
  simp [asked]

/-- Turning training off never asks more than training mode does. -/
public theorem autofill_asks_less (required known : Finset Field) :
    asked false required known ⊆ asked true required known := by
  simp [asked, Finset.sdiff_subset]

end Forms

/-! ## 4. The Tech Spec arithmetic -/

/-- The Tech Spec's sums: `12 × 12 = 144`, `3 + 141 = 144`, `144 ÷ 12 = 12`. -/
public theorem tech_spec_sums : 12 * 12 = 144 ∧ 3 + 141 = 144 ∧ 144 / 12 = 12 := by decide

/-- Two 1.5 V cells in series give 3 V. -/
public theorem two_cells_in_series : (3 : ℚ) / 2 + 3 / 2 = 3 := by norm_num

/-- What a regular dodecahedron has: 12 faces, 20 corners and 30 edges, with
`corners − edges + faces = 2` (Euler), 5 corners per face, 3 faces at each corner. Its
face–corner contacts number `12 × 5 = 60 = 20 × 3`, not 144. -/
public theorem dodecahedron_counts :
    (20 : ℤ) - 30 + 12 = 2 ∧ 12 * 5 = 60 ∧ 20 * 3 = 60 ∧ 12 * 5 ≠ 144 := by decide

/-! ## 5. The Matheorems cube (educational link in the doc) -/

/-- Cutting each edge of a cube into `a + b` splits it into 8 boxes: one `a³`, three `a²b`, three
`ab²` and one `b³`. -/
public theorem cube_split (a b : ℚ) : (a + b) ^ 3 = a ^ 3 + 3 * a ^ 2 * b + 3 * a * b ^ 2 + b ^ 3 := by
  ring

/-- The post's question, "what would `(a+b)⁴` look like?": a four-dimensional cube cut the same way
splits into `2⁴ = 16` boxes, grouped `1, 4, 6, 4, 1` (the next row of Pascal's triangle). -/
public theorem tesseract_split (a b : ℚ) :
    (a + b) ^ 4 = a ^ 4 + 4 * a ^ 3 * b + 6 * a ^ 2 * b ^ 2 + 4 * a * b ^ 3 + b ^ 4 ∧
      (List.range 5).map (Nat.choose 4) = [1, 4, 6, 4, 1] ∧ 1 + 4 + 6 + 4 + 1 = 2 ^ 4 := by
  refine ⟨by ring, by decide, by norm_num⟩

end R15
