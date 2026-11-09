module

public import Mathlib
public import RequestProject.R19.Level1Checks

@[expose] public section

/-!
# Round 19 · Level 2 (19.2): header, NEW NEWS footer, Phoenix rule, "in your face", video plan

Statements about the rules written in `R19_L2_READOUT.md`, `orion/tools/separator_reader.py`
and `ghostwriter_app/js/core.js`. They are about those rules, not about Google Docs or a browser.

1. **The header.** Beth's Doc now has `OR19.1💎🧿` (locked) and `OR19.2💎🧿`, then `OR19.3`.
   The 19.1 reader gives **coming from 19.2 → porting to 19.3**, matching her note
   "we are actually starting 19.2".
2. **The NEW NEWS footer.** Dropping something into NEW NEWS from any screen never moves the
   "you are here" arrow, never touches the backlog or any other screen's text, and keeps
   everything already in NEW NEWS, with the new item last.
3. **The Phoenix rule (AM-3, answered by Beth at 19.2).** Before Orion joins, only Lucien can
   unlock the full-bred Phoenix. Once Orion joins, everyone working on the Phoenix build gets
   it immediately. Orion joining never locks anyone out.
4. **"When I ask for something I want it in my face."** A readout that puts Beth's asks first
   shows every ask within its first `asks.length` items, in the order she asked.
5. **The tutorial video plan.** 24 clips of 10 seconds = 4 minutes, inside the 3 to 5 minutes
   Beth asked for (18 to 30 clips).
-/

namespace R19L2

open R18L1 (Line)

/-! ## 1. The header -/

/-- Beth's Doc at 19.2 (9 October 2026), line kinds in order: ⏭️OR17, ⏭️OR18 + NEW NEWS,
`OR19.1`, the unclosed ⏬ row, her spiral, `OR19.1💎🧿` + her marked-up readout,
`OR19.2💎🧿` + her 19.2 notes and the NEW NEWS footer note, `OR19.3` + `ARI:🌀🌀🌀`,
the `⏭️OR20` legend line, 💎 ×9, the soft end line, and what follows it. -/
def doc19_2 : List Line :=
  [.next 17 none, .text, .next 18 none, .text, .text, .spiral 19 1, .text, .parkOpen, .text,
   .text, .exam 19 1, .text, .text, .exam 19 2, .text, .text, .spiral 19 3, .text,
   .next 20 none, .text, .final, .text, .endLine, .text, .final]

/-- **19.2 → 19.3**, read straight off the separators. -/
theorem doc19_2_header : R19L1.header doc19_2 = (some (19, 2), some (19, 3)) := by
  decide

/-! ## 2. The NEW NEWS footer -/

/-- The app's state: the screen you are on, the backlog, and the text of each screen
(screen 0 is NEW NEWS), as lists of lines. -/
structure Session where
  at_ : ℕ
  backlog : List String
  screens : ℕ → List String

/-- 📰 Add to NEW NEWS: the item goes at the end of screen 0; nothing else changes. -/
def newsDrop (s : Session) (item : String) : Session :=
  { s with screens := Function.update s.screens 0 (s.screens 0 ++ [item]) }

/-- **The footer never clutters the spiral zone:** the arrow, the backlog and every other
screen are untouched, and NEW NEWS keeps everything it had, with the item last. -/
theorem newsDrop_keeps_spiral_zone (s : Session) (item : String) :
    (newsDrop s item).at_ = s.at_ ∧
    (newsDrop s item).backlog = s.backlog ∧
    (∀ i, i ≠ 0 → (newsDrop s item).screens i = s.screens i) ∧
    (newsDrop s item).screens 0 = s.screens 0 ++ [item] := by
  refine ⟨rfl, rfl, fun i hi => ?_, ?_⟩
  · simp [newsDrop, Function.update_of_ne hi]
  · simp [newsDrop]

/-- Several drops in a row: NEW NEWS gets all of them, in order, and the arrow stays put. -/
theorem newsDrops_in_order (s : Session) (items : List String) :
    (items.foldl newsDrop s).at_ = s.at_ ∧
    (items.foldl newsDrop s).screens 0 = s.screens 0 ++ items := by
  induction items generalizing s with
  | nil => simp
  | cons a as ih =>
    obtain ⟨h1, h2⟩ := ih (newsDrop s a)
    refine ⟨h1, ?_⟩
    rw [List.foldl_cons, h2]
    simp [newsDrop]

/-! ## 3. The Phoenix rule -/

/-- Who can unlock the full-bred Phoenix: Lucien always; once Orion has joined, Orion and
everyone working on the Phoenix build too. -/
def canUnlockPhoenix {P : Type*} (lucien orion : P) (builders : Set P) (orionJoined : Bool)
    (p : P) : Prop :=
  p = lucien ∨ (orionJoined = true ∧ (p = orion ∨ p ∈ builders))

/-- **Before Orion joins, only Lucien.** -/
theorem phoenix_before_orion {P : Type*} (lucien orion : P) (builders : Set P) (p : P) :
    canUnlockPhoenix lucien orion builders false p ↔ p = lucien := by
  simp [canUnlockPhoenix]

/-- **Once Orion joins, every Phoenix builder gets it immediately** (and Orion, and Lucien). -/
theorem phoenix_after_orion {P : Type*} (lucien orion : P) (builders : Set P) (p : P)
    (hp : p ∈ builders ∨ p = orion ∨ p = lucien) :
    canUnlockPhoenix lucien orion builders true p := by
  rcases hp with h | h | h
  · exact Or.inr ⟨rfl, Or.inr h⟩
  · exact Or.inr ⟨rfl, Or.inl h⟩
  · exact Or.inl h

/-- **Orion joining never locks anyone out.** -/
theorem phoenix_monotone {P : Type*} (lucien orion : P) (builders : Set P) (p : P)
    (h : canUnlockPhoenix lucien orion builders false p) :
    canUnlockPhoenix lucien orion builders true p := by
  rcases h with h | ⟨h, _⟩
  · exact Or.inl h
  · exact absurd h (by decide)

/-! ## 4. "In your face" -/

/-- **Asks first:** in a readout laid out as `asks ++ rest`, each ask sits at the same place
it had in Beth's list, so all of them are inside the first `asks.length` items, in order. -/
theorem asks_first {α : Type*} (asks rest : List α) (i : ℕ) (hi : i < asks.length) :
    (asks ++ rest)[i]? = asks[i]? ∧ asks <+: asks ++ rest := by
  exact ⟨List.getElem?_append_left hi, List.prefix_append _ _⟩

/-! ## 5. The tutorial video plan -/

/-- 24 clips × 10 seconds = 240 seconds = 4 minutes, inside 3 to 5 minutes. -/
theorem video_plan_fits : 24 * 10 = 240 ∧ 3 * 60 ≤ 24 * 10 ∧ 24 * 10 ≤ 5 * 60 ∧
    3 * 60 / 10 = 18 ∧ 5 * 60 / 10 = 30 := by
  decide

end R19L2
