module

public import Mathlib

/-!
# Round Eleven, deep-crawl pass: PolyPod translation and two liability rules

Two small, deliberately simplified models built from text found in the nested documents.
They are models of *written rules*, not claims about any running game.

**PolyPod (from the nested "Ecosystem Architecture: Master Summary", Round Two).**
A player understands another real-world language if an equipped PolyPod translates it, or the
player has gold-locked that language in the Linguistic / Polyglot skill tree.  Without either,
the language is garbled.  A grown Poly-Tadpole bonds telepathically and frees the earpiece slot.
Combined with the Round Ten rule (`RoundTenOpening`): safety messages are never garbled.

**Liability.**  This project's accountability ledger (`Orion.Shares`) gives an out-of-scope act
to the actor alone, while the separate project's "equal stake" amendment (quoted in the nested
"Orion Engine & NewKin Council Architecture" document) gives every human member the same share.
`liability_rules_disagree_out_of_scope` shows they differ for a concrete team of three.
-/

@[expose] public section

namespace RoundElevenDeepCrawl

/-- Where a translation comes from, per the Master Summary. -/
structure Translator where
  /-- a PolyPod (or bonded Poly-Tadpole) is translating for the player -/
  podActive : Bool
  /-- the language is gold-locked in the player's 64-node grid -/
  skillGoldLocked : Bool
  deriving DecidableEq, Repr

/-- Kinds of message; safety messages bypass translation entirely (Round Ten rule). -/
inductive Kind where
  | safety
  | ordinary
  deriving DecidableEq, Repr

/-- Whether the player sees the original words. -/
def understands (k : Kind) (t : Translator) : Bool :=
  k == .safety || t.podActive || t.skillGoldLocked

/-- Safety text is clear for everyone, with or without a PolyPod or skill. -/
theorem safety_always_clear (t : Translator) : understands .safety t = true := by
  simp [understands]

/-- Without a PolyPod and without the gold-locked skill, ordinary foreign speech is garbled. -/
theorem no_pod_no_skill_garbled :
    understands .ordinary ⟨false, false⟩ = false := by decide

/-- A gold-locked language needs no PolyPod: the slot can be used for other gear. -/
theorem gold_locked_needs_no_pod (pod : Bool) :
    understands .ordinary ⟨pod, true⟩ = true := by
  cases pod <;> decide

/-- Equipment slot occupancy: an in-ear pod occupies the slot until its tadpole bonds. -/
def earSlotOccupied (podEquipped tadpoleBonded : Bool) : Bool :=
  podEquipped && !tadpoleBonded

/-- After the telepathic bond the slot is free, and translation still works. -/
theorem bond_frees_slot_and_keeps_translation :
    earSlotOccupied true true = false ∧ understands .ordinary ⟨true, false⟩ = true := by
  decide

/-! ### Two liability rules for an out-of-scope act -/

/-- This project's ledger: an out-of-scope act is attributed to the actor alone. -/
noncomputable def scopedShare (inScope : Bool) {n : ℕ} (actor i : Fin n) : ℝ :=
  if inScope then 1 / n else if i = actor then 1 else 0

/-- The separate project's amendment: every human member carries the same share. -/
noncomputable def equalStake {n : ℕ} (_i : Fin n) : ℝ := 1 / n

theorem scopedShare_sum (inScope : Bool) {n : ℕ} (hn : 0 < n) (actor : Fin n) :
    ∑ i, scopedShare inScope actor i = 1 := by
  cases inScope <;> simp [scopedShare]
  field_simp

theorem equalStake_sum {n : ℕ} (hn : 0 < n) : ∑ i : Fin n, equalStake i = 1 := by
  simp [equalStake]
  field_simp

/-- Both rules account for the whole liability, yet for an out-of-scope act by member 0 of a
three-person team, member 1 carries `0` under this project's ledger and `1/3` under equal stake. -/
theorem liability_rules_disagree_out_of_scope :
    scopedShare false (0 : Fin 3) 1 = 0 ∧ equalStake (1 : Fin 3) = 1 / 3 := by
  simp [scopedShare, equalStake]

end RoundElevenDeepCrawl
