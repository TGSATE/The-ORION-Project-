module

public import Mathlib
public import RequestProject.R18.Level1Checks

@[expose] public section

/-!
# Round 19 · Level 1 (19.1): reading fix, the spiral flow, and the Ghost Writer app

Statements about the rules written in `orion/tools/separator_reader.py`,
`ghostwriter_app/js/core.js` and `R19_L1_READOUT.md`. They are about those rules,
not about Google Docs or a browser.

1. **The arrows fix.** At 19.1 the ⏬ row opened Beth's spiral and no 🆙 row ever closed it.
   The 18.1 reader then skipped everything after it, including the `OR19.1🧿` line. The new
   rule: a ⏬ row counts as a parking block only if a 🆙 row follows before the end line.
   A ⏬ that is never closed hides nothing; a closed block is still skipped.
2. **The header.** With a 🧿 readout-examination line, "coming from" is its level and
   "porting to" is the first separator after it. On the 19.1 Doc: **19.1 → 19.2**.
3. **Organize, don't cut** (the Ghost Writer app). Sorting lines into sections keeps every line
   exactly once, and each section keeps the order the lines were written in.
4. **The spiral flow.** Interjecting never moves the "you are here" arrow and never loses a
   note; from any screen you reach the end in a known number of Ready presses (never stuck).
5. **Dropping a link** at any position keeps everything already written, in order.
6. **The code-to-image script** (`sntre/code-to-image`): its 40,000-pixel cap holds at most
   2,857 rows of 240 characters, i.e. 685,680 characters; anything after that is cropped.
-/

namespace R19L1

open R18L1 (Line)

/-! ## 1. The arrows fix -/

/-- Is there a 🆙 row before any end line? -/
def closesBeforeEnd : List Line → Bool
  | [] => false
  | .endLine :: _ => false
  | .parkClose :: _ => true
  | _ :: rest => closesBeforeEnd rest

/-- The 19.1 reader: like 18.1's, except an unclosed ⏬ row does not start a parking block. -/
def readLines : Bool → List Line → List Line
  | _, [] => []
  | _, .endLine :: _ => []
  | _, .parkOpen :: rest => readLines (closesBeforeEnd rest) rest
  | _, .parkClose :: rest => readLines false rest
  | true, _ :: rest => readLines true rest
  | false, l :: rest => l :: readLines false rest

/-- What the 19.1 reader reads from a Doc. -/
def read (doc : List Line) : List Line := readLines false doc

/-- No marker lines: no ⏬, 🆙 or end line. -/
def Plain (xs : List Line) : Prop := ∀ l ∈ xs, l ≠ .parkOpen ∧ l ≠ .parkClose ∧ l ≠ .endLine

lemma closesBeforeEnd_plain (xs : List Line) (h : Plain xs) : closesBeforeEnd xs = false := by
  induction xs with
  | nil => rfl
  | cons x xs ih =>
    obtain ⟨_, h2, h3⟩ := h x (by simp)
    have := ih (fun l hl => h l (by simp [hl]))
    cases x <;> simp_all [closesBeforeEnd]

lemma readLines_false_plain (xs : List Line) (h : Plain xs) : readLines false xs = xs := by
  induction xs with
  | nil => rfl
  | cons x xs ih =>
    obtain ⟨h1, h2, h3⟩ := h x (by simp)
    have := ih (fun l hl => h l (by simp [hl]))
    cases x <;> simp_all [readLines]

/-- **An unclosed ⏬ hides nothing.** If no 🆙 (and no end line) follows a ⏬ row, every
line before and after it is read, in order. -/
theorem unclosed_park_hides_nothing (before rest : List Line) (hb : Plain before)
    (hr : Plain rest) : read (before ++ .parkOpen :: rest) = before ++ rest := by
  unfold read
  induction before with
  | nil =>
    simp only [List.nil_append, readLines, closesBeforeEnd_plain rest hr]
    exact readLines_false_plain rest hr
  | cons x xs ih =>
    obtain ⟨h1, h2, h3⟩ := hb x (by simp)
    have := ih (fun l hl => hb l (by simp [hl]))
    cases x <;> simp_all [readLines]

/-- **A closed parking block is still skipped:** whatever is parked between ⏬ and 🆙 never
changes what is read. -/
theorem closed_park_still_skipped (before after parked₁ parked₂ : List Line)
    (hb : Plain before) (hp₁ : Plain parked₁) (hp₂ : Plain parked₂) :
    read (before ++ .parkOpen :: parked₁ ++ .parkClose :: after) =
    read (before ++ .parkOpen :: parked₂ ++ .parkClose :: after) := by
  have closes : ∀ p : List Line, Plain p → closesBeforeEnd (p ++ .parkClose :: after) = true := by
    intro p hp
    induction p with
    | nil => rfl
    | cons x xs ih =>
      obtain ⟨_, h2, h3⟩ := hp x (by simp)
      have := ih (fun l hl => hp l (by simp [hl]))
      cases x <;> simp_all [closesBeforeEnd]
  have skip : ∀ p : List Line, Plain p →
      readLines true (p ++ .parkClose :: after) = readLines false after := by
    intro p hp
    induction p with
    | nil => simp [readLines]
    | cons x xs ih =>
      obtain ⟨h1, h2, h3⟩ := hp x (by simp)
      have := ih (fun l hl => hp l (by simp [hl]))
      cases x <;> simp_all [readLines]
  unfold read
  induction before with
  | nil =>
    simp only [List.nil_append, List.cons_append, readLines]
    rw [closes parked₁ hp₁, closes parked₂ hp₂, skip parked₁ hp₁, skip parked₂ hp₂]
  | cons x xs ih =>
    obtain ⟨h1, h2, h3⟩ := hb x (by simp)
    have := ih (fun l hl => hb l (by simp [hl]))
    cases x <;> simp_all [readLines]

/-! ## 2. The header -/

/-- The level named by a separator, if it is one. -/
def sepLevel : Line → Option (ℕ × ℕ)
  | .spiral r l => some (r, l)
  | .exam r l => some (r, l)
  | .next r none => some (r, 1)
  | .next r (some l) => some (r, l)
  | _ => none

/-- The last 🧿 line read, with everything read after it. -/
def lastExam : List Line → Option ((ℕ × ℕ) × List Line)
  | [] => none
  | .exam r l :: rest =>
    match lastExam rest with
    | some x => some x
    | none => some ((r, l), rest)
  | _ :: rest => lastExam rest

/-- The 18.1 header rule (last spiral level; a final ⏭️ line wins), applied to what was read. -/
def headerNoExam (rd : List Line) : Option (ℕ × ℕ) × Option (ℕ × ℕ) :=
  let coming := (rd.filterMap fun
    | .spiral r l => some (r, l)
    | _ => none).getLast?
  let port := match (rd.filter (fun l => l ≠ .text ∧ l ≠ .final)).getLast? with
    | some (.next r none) => some (r, 1)
    | some (.next r (some l)) => some (r, l)
    | _ => coming.map fun (r, l) => (r, l + 1)
  (coming, port)

/-- "Coming from → porting to". With a 🧿 line: its level, then the first separator after it
(or the next level number). Without one: the 18.1 rule. -/
def header (doc : List Line) : Option (ℕ × ℕ) × Option (ℕ × ℕ) :=
  match lastExam (read doc) with
  | some ((r, l), rest) => (some (r, l), some (((rest.filterMap sepLevel).head?).getD (r, l + 1)))
  | none => headerNoExam (read doc)

/-- Beth's 19.1 Doc (9 October 2026), line kinds in order: ⏭️OR17, ⏭️OR18 + NEW NEWS,
`OR19.1`, the ⏬ row that never closes, her spiral (including "☢️not a lvl end just a field
report for Loggie", which is ordinary text), `OR19.1🧿` + `ARI:RO🌀`, the `OR19.2` and
`⏭️OR20` legend lines, 💎 ×9, the soft end line, and what follows it. -/
def doc19_1 : List Line :=
  [.next 17 none, .text, .next 18 none, .text, .text, .spiral 19 1, .text, .parkOpen, .text,
   .text, .text, .exam 19 1, .text, .spiral 19 2, .text, .next 20 none, .text, .final, .text,
   .endLine, .text, .final]

/-- **The bug, formally:** the 18.1 reader never sees the `OR19.1🧿` line in the 19.1 Doc. -/
theorem old_reader_missed_the_exam_line :
    (R18L1.read doc19_1).contains (.exam 19 1) = false := by
  decide

/-- **Fixed:** the 19.1 reader sees it, and the header is **19.1 → 19.2**. -/
theorem doc19_1_header :
    (read doc19_1).contains (.exam 19 1) = true ∧
    header doc19_1 = (some (19, 1), some (19, 2)) := by
  decide

/-- Beth's 18.1 template now reads 19.1 → 19.2 too (its 🧿 line is 19.1, then OR19.2). -/
theorem template_header_now : header R18L1.bethTemplate = (some (19, 1), some (19, 2)) := by
  decide

/-! ## 3. Organize, don't cut -/

/-- **Nothing is cut and nothing is doubled:** sort lines into sections `0 … k-1` by a
classifier `c` (section `i` = the lines with `c line = i`, as `organize` in `core.js` does).
If every line gets a real section, the sections together hold exactly the lines written. -/
theorem sections_keep_every_line {α : Type*} (c : α → ℕ) (k : ℕ) (xs : List α)
    (hc : ∀ x ∈ xs, c x < k) :
    ∑ i ∈ Finset.range k, (xs.filter fun x => c x = i).length = xs.length := by
  induction xs with
  | nil => simp
  | cons x xs ih =>
    have hx := hc x (by simp)
    have ih' := ih (fun y hy => hc y (by simp [hy]))
    simp only [List.filter_cons, decide_eq_true_eq]
    have : ∀ i, (if c x = i then x :: List.filter (fun y => decide (c y = i)) xs
        else List.filter (fun y => decide (c y = i)) xs).length =
        (if c x = i then 1 else 0) + (List.filter (fun y => decide (c y = i)) xs).length := by
      intro i; split_ifs <;> simp [add_comm]
    simp only [this, Finset.sum_add_distrib, ih', Finset.sum_ite_eq, Finset.mem_range, hx,
      if_true, List.length_cons]
    omega

/-- **Each line lands in exactly one section, and each section keeps the written order**
(it is a sub-list of what was written). -/
theorem sections_exactly_once_in_order {α : Type*} (c : α → ℕ) (xs : List α) (i : ℕ) :
    (xs.filter fun x => c x = i).Sublist xs ∧
    ∀ x ∈ xs, (x ∈ xs.filter (fun y => c y = i) ↔ c x = i) :=
  ⟨List.filter_sublist, fun x hx => by simp [hx]⟩

/-! ## 4. The spiral flow -/

/-- The flow: which screen you are on (screens `0 … n`), and the backlog of interjections. -/
structure SpiralFlow where
  n : ℕ
  at_ : ℕ
  backlog : List String

/-- 🌀 Interject: the note goes to the end of the backlog; the screen does not change. -/
def interject (f : SpiralFlow) (note : String) : SpiralFlow :=
  { f with backlog := f.backlog ++ [note] }

/-- Ready: one screen forward (stays on the last). -/
def ready (f : SpiralFlow) : SpiralFlow := { f with at_ := min (f.at_ + 1) f.n }

/-- **Interjecting never moves the arrow, and never loses or reorders a note.** -/
theorem interjects_keep_place_and_notes (f : SpiralFlow) (notes : List String) :
    (notes.foldl interject f).at_ = f.at_ ∧
    (notes.foldl interject f).backlog = f.backlog ++ notes := by
  induction notes generalizing f with
  | nil => simp
  | cons a as ih =>
    simp only [List.foldl_cons]
    obtain ⟨h1, h2⟩ := ih (interject f a)
    exact ⟨h1, by rw [h2]; simp [interject]⟩

/-- **Never stuck:** from any screen `a ≤ n`, exactly `n - a` presses of Ready reach the last
screen, and the backlog is untouched on the way. -/
theorem ready_reaches_the_end (f : SpiralFlow) (h : f.at_ ≤ f.n) :
    (ready^[f.n - f.at_] f).at_ = f.n ∧ (ready^[f.n - f.at_] f).backlog = f.backlog := by
  obtain ⟨n, a, b⟩ := f
  simp only at h ⊢
  induction hk : n - a generalizing a with
  | zero => simp; omega
  | succ k ih =>
    rw [Function.iterate_succ_apply]
    have := ih (min (a + 1) n) (by omega) (by omega)
    simpa [ready] using this

/-! ## 5. Dropping a link -/

/-- **A dropped link keeps everything already written, in order,** wherever it goes
(top = position 0, bottom = the end, under NEW NEWS or at the cursor = anywhere between):
one line longer, removing the link gives back exactly what was there, and the old lines are
still all there in the same order. -/
theorem drop_link_keeps_everything (lines : List String) (link : String) (pos : ℕ)
    (hpos : pos ≤ lines.length) :
    (lines.insertIdx pos link).length = lines.length + 1 ∧
    (lines.insertIdx pos link).eraseIdx pos = lines ∧
    lines.Sublist (lines.insertIdx pos link) := by
  have he : (lines.insertIdx pos link).eraseIdx pos = lines := List.eraseIdx_insertIdx_self _
  refine ⟨List.length_insertIdx_of_le_length hpos _, he, ?_⟩
  conv_lhs => rw [← he]
  exact List.eraseIdx_sublist _ _

/-! ## 6. The code-to-image crop -/

/-- Rows the script draws: it starts at y = 12 px and adds 14 px per row while y < 40,000. -/
def rowsDrawn : ℕ := ((40000 - 12) + 13) / 14

/-- At most 2,857 rows of 240 characters: 685,680 characters, then the image is cropped. -/
theorem code_to_image_capacity : rowsDrawn = 2857 ∧ rowsDrawn * 240 = 685680 := by decide

/-- The last row drawn starts at y = 39,996; the next one would start at 40,010. -/
theorem code_to_image_last_row : 12 + 14 * 2856 < 40000 ∧ 40000 ≤ 12 + 14 * 2857 := by decide

end R19L1
