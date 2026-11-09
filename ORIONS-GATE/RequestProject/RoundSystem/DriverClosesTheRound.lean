module

public import Mathlib

/-!
# The round ledger: only Beth opens and closes a round

Beth's rule from the Round 14 close (7 October 2026): a **round** is hers. It is opened and
closed only when she says so. Each send-and-return with Aristotle is a **level** (one pass of
processing) inside the round that is currently open; it never starts a new round by itself.

This is the Ghost Rider Protocol's own wording, applied to round-keeping: *"You are the Engine;
I am the Driver. You provide the horsepower, but you do not touch the wheel. If I stop talking,
you idle. You do not guess the next stop."*

The model below is a small state machine:

* `Ledger` records the round number, whether it is open, and how many levels it has had.
* `Event.engineLevel` is Aristotle finishing one level (pass) of processing.
* `Event.driverClose` is Beth saying "Round N is closed".
* `Event.driverOpen` is Beth saying "start the spiral session for the next round".

We check that the Engine can never change the round number, that the round number only moves
when the Driver opens a new round (and then by exactly one), and the concrete relabelling used
in `ROUND_SYSTEM.md`: the nine levels of Beth's Round 14, then her close and her opening of
Round 15.

This is a model of a written working agreement, not software that runs anywhere.
-/

namespace RoundSystem

/-- The state of Beth's round ledger. -/
public structure Ledger where
  /-- The current round number. -/
  round : ℕ
  /-- Whether that round is still open. -/
  isOpen : Bool
  /-- How many levels (passes of processing) the current round has had. -/
  level : ℕ
  deriving DecidableEq, Repr

/-- What can happen to the ledger. -/
public inductive Event where
  /-- Aristotle (the Engine) finishes one level of processing. -/
  | engineLevel
  /-- Beth (the Driver) closes the current round. -/
  | driverClose
  /-- Beth (the Driver) opens the next round's spiral session. -/
  | driverOpen
  deriving DecidableEq, Repr

/-- Who an event comes from: `true` for the Driver (Beth), `false` for the Engine. -/
public def Event.byDriver : Event → Bool
  | .engineLevel => false
  | .driverClose => true
  | .driverOpen => true

/-- One step of the ledger.

* A level adds one to the level count of an open round. If the round is closed, the Engine
  idles: nothing changes (work waits for Beth to open the next round).
* Closing marks the round closed and keeps its number and level count as the record.
* Opening only works on a closed round: the round number goes up by one and the level count
  starts again at zero. Opening an already open round changes nothing. -/
@[expose] public def step (s : Ledger) : Event → Ledger
  | .engineLevel => if s.isOpen then { s with level := s.level + 1 } else s
  | .driverClose => { s with isOpen := false }
  | .driverOpen => if s.isOpen then s else { round := s.round + 1, isOpen := true, level := 0 }

/-- Run a list of events, in order. -/
@[expose] public def run (s : Ledger) (es : List Event) : Ledger := es.foldl step s

/-- **The Engine never touches the wheel:** one Engine level never changes the round. -/
public theorem engineLevel_keeps_round (s : Ledger) : (step s .engineLevel).round = s.round := by
  by_cases h : s.isOpen = true <;> simp [step, h]

/-- **No matter how many levels the Engine processes, the round number stays where Beth left
it.** -/
public theorem engine_only_keeps_round (s : Ledger) (es : List Event)
    (h : ∀ e ∈ es, e = .engineLevel) : (run s es).round = s.round := by
  induction es generalizing s with
  | nil => rfl
  | cons e es ih =>
    have he : e = .engineLevel := h e (by simp)
    subst he
    simp only [run, List.foldl_cons] at *
    rw [ih (step s .engineLevel) (fun e he => h e (by simp [he])), engineLevel_keeps_round]

/-- **Only the Driver moves the round:** if a step changes the round number, that step was
Beth opening a new round. -/
public theorem round_changes_only_on_driverOpen (s : Ledger) (e : Event)
    (h : (step s e).round ≠ s.round) : e = .driverOpen := by
  cases e with
  | engineLevel => exact absurd (engineLevel_keeps_round s) h
  | driverClose => exact absurd rfl h
  | driverOpen => rfl

/-- Every event that changes the round comes from the Driver. -/
public theorem round_changes_only_by_driver (s : Ledger) (e : Event)
    (h : (step s e).round ≠ s.round) : e.byDriver = true := by
  rw [round_changes_only_on_driverOpen s e h]; rfl

/-- **One round at a time:** a single step moves the round number up by at most one. -/
public theorem round_step_le_succ (s : Ledger) (e : Event) :
    s.round ≤ (step s e).round ∧ (step s e).round ≤ s.round + 1 := by
  cases e with
  | engineLevel => rw [engineLevel_keeps_round]; omega
  | driverClose => exact ⟨le_refl _, Nat.le_succ _⟩
  | driverOpen =>
    by_cases h : s.isOpen = true
    · simp [step, h]
    · simp [step, h]

/-- **A round can't be skipped or reopened by accident:** opening an already open round
changes nothing. -/
public theorem driverOpen_on_open_round (s : Ledger) (h : s.isOpen = true) :
    step s .driverOpen = s := by
  simp [step, h]

/-- **While a round is closed, the Engine idles.** A level sent before Beth opens the next round
changes nothing. -/
public theorem engine_idles_when_closed (s : Ledger) (h : s.isOpen = false) :
    step s .engineLevel = s := by
  simp [step, h]

/-- Over any run, the round number grows by at most the number of times Beth opened a round. -/
public theorem round_le_initial_add_opens (s : Ledger) (es : List Event) :
    (run s es).round ≤ s.round + es.count .driverOpen := by
  induction es generalizing s with
  | nil => simp [run]
  | cons e es ih =>
    simp only [run, List.foldl_cons, List.count_cons] at *
    have h1 := ih (step s e)
    cases e with
    | engineLevel =>
      rw [engineLevel_keeps_round] at h1; simpa using h1
    | driverClose => simpa [step] using h1
    | driverOpen =>
      have h2 := (round_step_le_succ s .driverOpen).2
      simp only [beq_self_eq_true, if_true]
      omega

/-! ## The concrete relabelling in `ROUND_SYSTEM.md` -/

/-- Beth's Round 14, freshly opened. -/
public def round14Opened : Ledger := { round := 14, isOpen := true, level := 0 }

/-- The nine send-and-return passes inside Beth's Round 14 document (the ones that used to be
labelled "Round 16" to "Round 24"). -/
public def round14Levels : List Event := List.replicate 9 .engineLevel

/-- After those nine passes it is still Round 14, at level 9 (`R14·L9`). -/
public theorem round14_after_nine_levels :
    run round14Opened round14Levels = { round := 14, isOpen := true, level := 9 } := by
  decide

/-- Beth closes Round 14 and opens the spiral session for Round 15: the ledger reads Round 15,
open, level 0. The next pass will be `R15·L1`. -/
public theorem round15_opens_after_close :
    run round14Opened (round14Levels ++ [.driverClose, .driverOpen]) =
      { round := 15, isOpen := true, level := 0 } := by
  decide

/-- The old labelling counted each pass as a new round. Under the new rule, the eleven passes
that were numbered 14 to 24 (two in the "Ari" doc, nine in the Round 14 doc, with Beth's
close-and-open in between) only move the round from 13 to 14, never to 24. -/
public theorem old_labels_overcounted :
    (run { round := 13, isOpen := true, level := 1 }
      (List.replicate 2 .engineLevel ++ [.driverClose, .driverOpen] ++ round14Levels)).round
      = 14 := by
  decide

end RoundSystem
