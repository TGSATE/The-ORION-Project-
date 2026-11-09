module

public import Mathlib

public section

/-!
# Round 17 · Level 5: small checks for this level

These are statements about the rules as written in `R17_L5_READOUT.md`, not about any running app.

1. **Beth's separator rule (17.5).** A Doc is read line by line. A line of nine ☢️ means
   "go no further": nothing after the first such line is ever processed, and everything before it
   is processed in order.
2. **Recording in singularity rooms (17.5).** Every room has an easy recording toggle. A session
   is recorded only when the toggle is on *and* every person in the room has said yes. One person
   saying no, or the toggle being off, means nothing is recorded.
3. **Need-to-know briefs from player cards (17.5).** A player's AI pulls out only the notes tagged
   for that player. The brief keeps every one of those notes, in their original order, and
   nothing tagged for anybody else.
4. **Personal mystic cards in Rat Slap (17.5).** Players can put their own art (their personal
   tarot-style cards) on the deck. Rat Slap only ever reads a card's rank, so re-skinning the deck
   never changes whether a slap is good or how many turns a royal gives.
-/

namespace R17L5

/-! ## 1. The separator rule -/

/-- A line of Beth's Doc: either the nine-☢️ stop line, or anything else. -/
inductive DocLine where
  | stop
  | text (s : String)
  deriving DecidableEq

/-- What gets processed: every line up to (not including) the first stop line. -/
def processed (doc : List DocLine) : List DocLine :=
  doc.takeWhile (fun l => l ≠ DocLine.stop)

/-- No stop line, and nothing after it, is ever processed. -/
theorem stop_not_processed (doc : List DocLine) : DocLine.stop ∉ processed doc := by
  intro h
  have := List.mem_takeWhile_imp h
  simp at this

/-- What is processed is exactly the start of the Doc, in order. -/
theorem processed_isPrefix (doc : List DocLine) : processed doc <+: doc :=
  List.takeWhile_prefix _

/-- Lines written after a stop line never change what is processed. -/
theorem after_stop_ignored (before after₁ after₂ : List DocLine)
    (h : DocLine.stop ∉ before) :
    processed (before ++ DocLine.stop :: after₁) = processed (before ++ DocLine.stop :: after₂) := by
  unfold processed
  induction before with
  | nil => simp
  | cons x xs ih =>
    simp only [List.mem_cons, not_or] at h
    have hx : x ≠ DocLine.stop := Ne.symm h.1
    rw [List.cons_append, List.cons_append, List.takeWhile_cons_of_pos (by simpa using hx),
      List.takeWhile_cons_of_pos (by simpa using hx), ih h.2]

/-! ## 2. Recording toggles -/

/-- A singularity room: its recording toggle and each person's yes/no. -/
structure Room where
  toggleOn : Bool
  people : List String
  saysYes : String → Bool

/-- A session is recorded only with the toggle on and a yes from everyone in the room. -/
def recorded (r : Room) : Bool :=
  r.toggleOn && r.people.all r.saysYes

/-- Toggle off: nothing is recorded. -/
theorem toggle_off_no_recording (r : Room) (h : r.toggleOn = false) : recorded r = false := by
  simp [recorded, h]

/-- If a session is recorded, every person in the room said yes. -/
theorem recorded_means_everyone_agreed (r : Room) (h : recorded r = true) :
    ∀ p ∈ r.people, r.saysYes p = true := by
  simp only [recorded, Bool.and_eq_true, List.all_eq_true] at h
  exact h.2

/-- One person saying no is enough to stop the recording. -/
theorem one_no_stops_recording (r : Room) (p : String) (hp : p ∈ r.people)
    (hno : r.saysYes p = false) : recorded r = false := by
  cases h : recorded r
  · rfl
  · have := recorded_means_everyone_agreed r h p hp
    simp [hno] at this

/-! ## 3. Need-to-know briefs -/

/-- A note on a player card, tagged with who needs it. -/
structure Note where
  forWhom : String
  text : String

/-- A player's brief: only the notes tagged for them. -/
def brief (who : String) (notes : List Note) : List Note :=
  notes.filter (fun n => n.forWhom = who)

/-- Every note tagged for the player is in their brief. -/
theorem brief_keeps_everything_for_them (who : String) (notes : List Note) (n : Note)
    (hn : n ∈ notes) (hw : n.forWhom = who) : n ∈ brief who notes := by
  simp [brief, hn, hw]

/-- Nothing tagged for someone else gets into the brief. -/
theorem brief_only_theirs (who : String) (notes : List Note) (n : Note)
    (hn : n ∈ brief who notes) : n.forWhom = who := by
  simp [brief] at hn
  exact hn.2

/-- The brief keeps the notes in their original order. -/
theorem brief_in_order (who : String) (notes : List Note) : List.Sublist (brief who notes) notes :=
  List.filter_sublist

/-! ## 4. Personal mystic cards on a Rat Slap deck -/

/-- Card ranks: 2–10 as numbers, plus the four royals. -/
inductive Rank where
  | num (k : ℕ)
  | jack | queen | king | ace
  deriving DecidableEq

/-- A card: its rank and suit, plus whatever art the player has put on it. -/
structure Card (Art : Type) where
  rank : Rank
  suit : Fin 4
  art : Art

/-- Turns the next player gets to answer a royal: Ace 1, King 2, Queen 3, Jack 4. -/
def royalTurns : Rank → Option ℕ
  | .ace => some 1
  | .king => some 2
  | .queen => some 3
  | .jack => some 4
  | .num _ => none

/-- A good slap: the top two cards of the pile have the same rank. -/
def goodSlap {Art : Type} : List (Card Art) → Bool
  | a :: b :: _ => decide (a.rank = b.rank)
  | _ => false

/-- Put new art on a card, keeping rank and suit. -/
def reskin {Art Art' : Type} (f : Art → Art') (c : Card Art) : Card Art' :=
  ⟨c.rank, c.suit, f c.art⟩

/-- Re-skinning the pile never changes whether a slap is good. -/
theorem reskin_keeps_slaps {Art Art' : Type} (f : Art → Art') (pile : List (Card Art)) :
    goodSlap (pile.map (reskin f)) = goodSlap pile := by
  match pile with
  | [] => rfl
  | [_] => rfl
  | a :: b :: _ => simp [goodSlap, reskin]

/-- Re-skinning a card never changes how many turns its royal gives. -/
theorem reskin_keeps_royal_turns {Art Art' : Type} (f : Art → Art') (c : Card Art) :
    royalTurns (reskin f c).rank = royalTurns c.rank := by
  simp [reskin]

end R17L5
