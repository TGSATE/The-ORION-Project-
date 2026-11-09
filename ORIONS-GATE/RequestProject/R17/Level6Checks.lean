module

public import Mathlib

public section

/-!
# Round 17 · Level 6: small checks for this level

These are statements about the rules as written in `R17_L6_READOUT.md`, not about any running app
or chat platform.

1. **Speaker marks (17.6).** Everyone in a room opens with their own mark (🐶🐲 for Grok, 🐗 for
   the boar, …). Copy-pasting messages into another place keeps every message's mark, in order.
   A message without a mark stays *unlabelled*: it is never credited to anyone. And a mark is a
   label, not proof: no rule that only looks at marks can always name the real author.
2. **Beth's 😈 stamp (17.6).** A message counts as "already grabbed" exactly when Beth stamped it.
   Stamps from anyone else never change what counts as grabbed.
3. **"Coming from / porting to" (17.6).** The readout opens by naming the level it is coming from
   (the last spiral separator before the stop line) and the level it is porting to (the last
   next-level separator). For this Doc's separators, that is 17.6 → 18.1.
4. **Monster deck as dice (17.6).** A deck with one card for each face, shuffled any way at all,
   holds every face exactly once, so drawing the top card is a fair roll.
-/

namespace R17L6

/-! ## 1. Speaker marks -/

/-- A chat message: who really typed it, the mark they opened with (if any), and the text. -/
structure Msg (Person Mark : Type) where
  author : Person
  mark : Option Mark
  body : String

variable {Person Mark : Type}

/-- Copy-paste relay: the selected messages are added, as they are, to the end of the other log. -/
def relay (target copied : List (Msg Person Mark)) : List (Msg Person Mark) :=
  target ++ copied

/-- Relaying keeps every message's mark, in the same order. -/
theorem relay_keeps_marks (target copied : List (Msg Person Mark)) :
    (relay target copied).map Msg.mark = target.map Msg.mark ++ copied.map Msg.mark := by
  simp [relay]

/-- Who a message is credited to, going only by its mark. -/
def creditedTo (m : Msg Person Mark) : Option Mark := m.mark

/-- An unmarked message is credited to nobody: it stays unlabelled. -/
theorem unmarked_stays_unlabelled (m : Msg Person Mark) (h : m.mark = none) :
    creditedTo m = none := h

/-- A mark is a label, not proof of authorship. If two different people can type the same mark,
no rule that only reads the mark can always name the real author. -/
theorem mark_is_not_proof (a b : Person) (hab : a ≠ b) (k : Mark) :
    ¬ ∃ f : Option Mark → Person, ∀ m : Msg Person Mark, f m.mark = m.author := by
  rintro ⟨f, hf⟩
  have ha := hf ⟨a, some k, ""⟩
  have hb := hf ⟨b, some k, ""⟩
  exact hab (ha.symm.trans hb)

/-! ## 2. Beth's 😈 stamp -/

/-- A stamp: who put 😈 on which message (by message number). -/
structure Stamp (Person : Type) where
  by_ : Person
  msgId : ℕ

/-- A message counts as grabbed exactly when Beth stamped it. -/
def grabbed [DecidableEq Person] (beth : Person) (stamps : List (Stamp Person)) (i : ℕ) : Prop :=
  ∃ s ∈ stamps, s.by_ = beth ∧ s.msgId = i

/-- Stamps from anyone other than Beth never change what counts as grabbed. -/
theorem others_stamps_ignored [DecidableEq Person] (beth : Person)
    (stamps extra : List (Stamp Person)) (hextra : ∀ s ∈ extra, s.by_ ≠ beth) (i : ℕ) :
    grabbed beth (stamps ++ extra) i ↔ grabbed beth stamps i := by
  constructor
  · rintro ⟨s, hs, hb, hi⟩
    rcases List.mem_append.mp hs with h | h
    · exact ⟨s, h, hb, hi⟩
    · exact absurd hb (hextra s h)
  · rintro ⟨s, hs, hb, hi⟩
    exact ⟨s, List.mem_append_left _ hs, hb, hi⟩

/-! ## 3. "Coming from / porting to" -/

/-- A line of the Doc: a spiral separator, a next-level separator, the nine-☢️ stop line,
or ordinary text. Separators carry (round, level). -/
inductive Line where
  | spiral (round level : ℕ)
  | next (round level : ℕ)
  | stop
  | text
  deriving DecidableEq

/-- Everything before the first stop line. -/
def processed (doc : List Line) : List Line :=
  doc.takeWhile (fun l => l ≠ Line.stop)

/-- The level the readout is coming from: the last spiral separator that is processed. -/
def comingFrom (doc : List Line) : Option (ℕ × ℕ) :=
  ((processed doc).filterMap fun
    | .spiral r l => some (r, l)
    | _ => none).getLast?

/-- The level the readout is porting to: the last next-level separator that is processed. -/
def portingTo (doc : List Line) : Option (ℕ × ℕ) :=
  ((processed doc).filterMap fun
    | .next r l => some (r, l)
    | _ => none).getLast?

/-- The separators in Beth's Round 17 Doc as of 9 October 2026, in order, with text between them.
(`OR17.Lv1` was written `⏭️OR17.Lv1`; `OR17.Lv2⏭️` and `OR17.Lv4⏭️` end in ⏭️; `OR17.Lv3`,
`OR17.Lv🌀5` and `OR17.Lv6🌀🧿` end in a spiral; the Doc ends with `⏭️OR18.1`. A row of eight
☢️ inside the pasted 17.5 readout is not the nine-☢️ stop line, and Beth asked for everything
past it to be read.) -/
def round17Doc : List Line :=
  [.text, .next 17 1, .text, .next 17 2, .text, .spiral 17 3, .text, .next 17 4, .text,
   .spiral 17 5, .text, .spiral 17 6, .text, .next 18 1]

/-- For this Doc: coming from 17.6, porting to 18.1. -/
theorem round17_header :
    comingFrom round17Doc = some (17, 6) ∧ portingTo round17Doc = some (18, 1) := by
  decide

/-- Text written after a stop line never changes the header. -/
theorem header_ignores_after_stop (before after : List Line) (h : Line.stop ∉ before) :
    comingFrom (before ++ Line.stop :: after) = comingFrom before ∧
    portingTo (before ++ Line.stop :: after) = portingTo before := by
  have hp : processed (before ++ Line.stop :: after) = processed before := by
    unfold processed
    induction before with
    | nil => simp
    | cons x xs ih =>
      simp only [List.mem_cons, not_or] at h
      have hx : x ≠ Line.stop := Ne.symm h.1
      rw [List.cons_append, List.takeWhile_cons_of_pos (by simpa using hx),
        List.takeWhile_cons_of_pos (by simpa using hx), ih h.2]
  exact ⟨by simp [comingFrom, hp], by simp [portingTo, hp]⟩

/-! ## 4. The monster deck as dice -/

/-- A shuffled monster deck with one card per face holds every face exactly once. -/
theorem shuffled_deck_fair {n : ℕ} (deck : List (Fin n)) (h : deck.Perm (List.finRange n))
    (k : Fin n) : deck.count k = 1 := by
  rw [h.count_eq]
  exact List.count_eq_one_of_mem (List.nodup_finRange n) (List.mem_finRange k)

end R17L6
