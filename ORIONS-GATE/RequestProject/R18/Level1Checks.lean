module

public import Mathlib

@[expose] public section

/-!
# Round 18 · Level 1: Beth's separator template

These are statements about the reading rules written in `SEPARATOR_TEMPLATE.md` and
`orion/tools/separator_reader.py`, not about Google Docs itself.

1. **The soft end line.** `☢️☢️☢️🧿☢️☢️☢️` ("nothing left to see here") or the old nine ☢️ is an end
   line only when it stands alone on its line. A line that just *contains* ☢️ next to other text
   never stops the reading.
2. **Nothing after the end line is read.**
3. **The parking block** (a ⏬ row, your blank working space, a 🆙 row) is skipped. Whatever is
   parked there never changes which separators are read.
4. **The header.** "Coming from" is the last level separator before the end line; "porting to"
   is the next level, unless a later ⏭️ line opens a new round. For Beth's template, read
   literally, that gives 19.2 → 20.1.
-/

namespace R18L1

/-! ## 1. The end line, character by character -/

/-- The new soft end line, as characters (☢ and the emoji variation selector, then 🧿). -/
def endSoft : List Char := "☢️☢️☢️🧿☢️☢️☢️".toList

/-- The old stop line: nine ☢️. -/
def endOld : List Char := "☢️☢️☢️☢️☢️☢️☢️☢️☢️".toList

/-- A line is an end line exactly when it is one of the two patterns and nothing else. -/
def isEnd (s : List Char) : Bool := decide (s = endSoft) || decide (s = endOld)

/-- Writing anything after the soft end pattern on the same line means it is not an end line. -/
theorem soft_end_with_extra_text_is_not_end (t : List Char) (ht : t ≠ []) :
    isEnd (endSoft ++ t) = false := by
  simp only [isEnd, Bool.or_eq_false_iff, decide_eq_false_iff_not]
  refine ⟨fun h => ?_, fun h => ?_⟩
  · have := congrArg List.length h
    simp only [List.length_append] at this
    exact ht (List.length_eq_zero_iff.mp (by omega))
  · have h2 : (endSoft ++ t).take endSoft.length = endSoft := List.take_left
    rw [h] at h2
    exact absurd h2 (by decide)

/-- An ordinary note with a ☢️ in it, like the ones Beth writes inline, is not an end line. -/
theorem inline_radiation_is_not_end : isEnd "☢️ check this".toList = false := by decide

/-! ## 2–4. Reading a Doc -/

/-- The kinds of line the reader knows. Separators carry round and level. -/
inductive Line where
  | spiral (round level : ℕ)
  | exam (round level : ℕ)
  | next (round : ℕ) (level : Option ℕ)
  | parkOpen
  | parkClose
  | final
  | endLine
  | text
  deriving DecidableEq

/-- Read a Doc: stop at the end line, and skip everything inside a parking block. -/
def readLines : Bool → List Line → List Line
  | _, [] => []
  | _, .endLine :: _ => []
  | _, .parkOpen :: rest => readLines true rest
  | _, .parkClose :: rest => readLines false rest
  | true, _ :: rest => readLines true rest
  | false, l :: rest => l :: readLines false rest

/-- What is read from a Doc. -/
def read (doc : List Line) : List Line := readLines false doc

/-- Nothing after the end line is ever read. -/
theorem after_end_ignored (before after₁ after₂ : List Line)
    (h : ∀ l ∈ before, l ≠ .endLine) (b : Bool) :
    readLines b (before ++ .endLine :: after₁) = readLines b (before ++ .endLine :: after₂) := by
  induction before generalizing b with
  | nil => simp [readLines]
  | cons x xs ih =>
    have hx : x ≠ .endLine := h x (by simp)
    have hxs : ∀ l ∈ xs, l ≠ .endLine := fun l hl => h l (by simp [hl])
    cases x <;> cases b <;> simp_all [readLines]

/-- Whatever is parked inside the ⏬ … 🆙 block never changes what is read
(as long as the parked lines don't themselves contain ⏬, 🆙 or the end line). -/
theorem parked_lines_ignored (before after parked₁ parked₂ : List Line)
    (hp₁ : ∀ l ∈ parked₁, l ≠ .parkOpen ∧ l ≠ .parkClose ∧ l ≠ .endLine)
    (hp₂ : ∀ l ∈ parked₂, l ≠ .parkOpen ∧ l ≠ .parkClose ∧ l ≠ .endLine) :
    read (before ++ .parkOpen :: parked₁ ++ .parkClose :: after) =
    read (before ++ .parkOpen :: parked₂ ++ .parkClose :: after) := by
  have skip : ∀ (p : List Line), (∀ l ∈ p, l ≠ .parkOpen ∧ l ≠ .parkClose ∧ l ≠ .endLine) →
      readLines true (p ++ .parkClose :: after) = readLines false after := by
    intro p hp
    induction p with
    | nil => simp [readLines]
    | cons x xs ih =>
      obtain ⟨h1, h2, h3⟩ := hp x (by simp)
      have hxs : ∀ l ∈ xs, l ≠ .parkOpen ∧ l ≠ .parkClose ∧ l ≠ .endLine :=
        fun l hl => hp l (by simp [hl])
      cases x <;> simp_all [readLines]
  unfold read
  generalize false = b
  induction before generalizing b with
  | nil =>
    simp only [List.nil_append, List.cons_append, readLines]
    rw [skip parked₁ hp₁, skip parked₂ hp₂]
  | cons x xs ih =>
    cases x <;> cases b <;> simp_all [readLines]

/-- The level separators that are read, in order. -/
def levels (doc : List Line) : List (ℕ × ℕ) :=
  (read doc).filterMap fun
    | .spiral r l => some (r, l)
    | .exam r l => some (r, l)
    | _ => none

/-- "Coming from": the last level read. -/
def comingFrom (doc : List Line) : Option (ℕ × ℕ) := (levels doc).getLast?

/-- "Porting to": the level after "coming from", unless the last separator read is a ⏭️ line
opening a new round (then level 1 of that round, or the level written on it). The final 💎 row
does not count as a separator here. -/
def portingTo (doc : List Line) : Option (ℕ × ℕ) :=
  match ((read doc).filter (fun l => l ≠ .text ∧ l ≠ .final)).getLast? with
  | some (.next r none) => some (r, 1)
  | some (.next r (some l)) => some (r, l)
  | _ => (comingFrom doc).map fun (r, l) => (r, l + 1)

/-- Beth's separator template (her Doc of 9 October 2026), line kinds in order, with its
example round numbers read literally. -/
def bethTemplate : List Line :=
  [.next 17 none, .text, .next 18 none, .text, .spiral 19 1, .text, .parkOpen, .text, .text,
   .parkClose, .exam 19 1, .text, .spiral 19 2, .text, .next 20 none, .text, .final, .text,
   .endLine, .text, .final]

/-- Read literally, the template says: coming from 19.2, porting to 20.1. -/
theorem template_header :
    comingFrom bethTemplate = some (19, 2) ∧ portingTo bethTemplate = some (20, 1) := by
  decide

/-- The same layout with this round's numbers (18): coming from 18.1, porting to 18.2,
when the Doc stops right after the readout-examination section. -/
theorem round18_header :
    comingFrom [.next 17 none, .text, .next 18 none, .text, .spiral 18 1, .text,
      .parkOpen, .text, .parkClose, .exam 18 1, .text, .endLine] = some (18, 1) ∧
    portingTo [.next 17 none, .text, .next 18 none, .text, .spiral 18 1, .text,
      .parkOpen, .text, .parkClose, .exam 18 1, .text, .endLine] = some (18, 2) := by
  decide

/-- The recommended live layout: after the readout examination, one `⏭️OR18.2` line says what the
next level will be. Coming from 18.1, porting to 18.2, and the old-round header lines don't
interfere. -/
theorem round18_with_next_marker :
    comingFrom [.next 17 none, .next 18 none, .spiral 18 1, .text, .parkOpen, .text, .parkClose,
      .exam 18 1, .text, .next 18 (some 2), .endLine] = some (18, 1) ∧
    portingTo [.next 17 none, .next 18 none, .spiral 18 1, .text, .parkOpen, .text, .parkClose,
      .exam 18 1, .text, .next 18 (some 2), .endLine] = some (18, 2) := by
  decide

end R18L1
