module

public import Mathlib.Tactic

/-!
# Page v1843: the new readout instruction and the Union Wealth arithmetic

1. Beth's instruction (page v1843): her readout is the detailed *narrative*
   readout of the build, the game mechanics and the platform. Code details are
   left out of it (teammates' AIs can pull those for themselves), **but** any
   code change that interferes with gameplay or platform mechanics must still be
   reported to her, in plain words.
2. Two figures displayed on the shared Union Wealth planning page.

These model a written rule and check arithmetic; they are not game code.
-/

@[expose] public section

namespace RoundElevenReadoutRule

/-- What an item reported in a round is about. -/
inductive Topic
  | narrative
  | buildState
  | mechanics
  | platform
  | codeDetail
  deriving DecidableEq, Repr

/-- One reported item: its topic, and whether it changes how the game plays or
how the platform works. -/
structure Item where
  topic : Topic
  affectsPlay : Bool
  deriving DecidableEq, Repr

/-- The v1843 rule: an item goes into Beth's readout when it is not a code
detail, or when (even though it is about code) it affects gameplay or platform
mechanics. -/
def inBethReadout (i : Item) : Bool :=
  i.topic != Topic.codeDetail || i.affectsPlay

/-- Every code change that affects gameplay or the platform reaches Beth. -/
theorem play_affecting_change_reported (i : Item) (h : i.affectsPlay = true) :
    inBethReadout i = true := by
  simp [inBethReadout, h]

/-- A code detail that changes nothing about play stays out of Beth's readout
(it remains available to the coders). -/
theorem pure_code_detail_omitted (i : Item) (ht : i.topic = Topic.codeDetail)
    (hp : i.affectsPlay = false) : inBethReadout i = false := by
  simp [inBethReadout, ht, hp]

/-- Narrative, build-state, mechanics and platform items are always reported. -/
theorem non_code_always_reported (i : Item) (ht : i.topic ≠ Topic.codeDetail) :
    inBethReadout i = true := by
  simp [inBethReadout, ht]

/-- Union Wealth: "$1, every day — $9,125 contributed" over 25 years (365 days a
year), and the same total via the page's stated monthly conversion 365 ÷ 12. -/
theorem union_wealth_daily_total :
    (365 * 25 : ℕ) = 9125 ∧ ((365 : ℚ) / 12) * 12 * 25 = 9125 := by
  norm_num

/-- Union Wealth: one dollar at the page's illustrative 5% effective annual
return for 25 years (before fees and taxes) grows to between $3.38 and $3.39. -/
theorem union_wealth_one_dollar_growth :
    (3.38 : ℚ) < (1.05 : ℚ) ^ 25 ∧ (1.05 : ℚ) ^ 25 < 3.39 := by
  norm_num

end RoundElevenReadoutRule
