import Mathlib

/-!
# OR20.3: the Ghost Writer 🆘 cool-off ladder

Beth's design (Doc `1etuEkoP…`, OR20.3): harm talk starts a cool-off; each repeat climbs the
ladder 5 min, 10 min, 30 min, 1 h, 3 h, 6 h, 12 h, 1 day; after the full day, a further
trigger means "spiral-only" until someone checks in. This file is a small model of the rules
the app (`ghostwriter_app/js/safety.js`) follows, with the promises checked:

* the ladder only ever gets longer;
* the whole ladder adds up to 2805 minutes (46 h 45 min);
* the ninth trigger, and only then, means spiral-only;
* tapping 🆘 yourself never climbs the ladder;
* a check-in always brings the player back to the first rung, with ⏭️ open.

(The model leaves out the clock itself and the "same line never counts twice" rule; those are
checked by the app's own tests.)
-/

namespace OR20.Sos

/-- Cool-off lengths in minutes. -/
def ladder : List ℕ := [5, 10, 30, 60, 180, 360, 720, 1440]

/-- Each cool-off is longer than the one before. -/
theorem ladder_increasing : ladder.Pairwise (· < ·) := by decide

/-- All eight cool-offs together: 2805 minutes = 46 h 45 min. -/
theorem ladder_total : ladder.sum = 2805 := by decide

/-- The safety state: which rung is next, and whether the player is in spiral-only mode. -/
structure State where
  rung : ℕ
  spiralOnly : Bool
deriving DecidableEq, Repr

/-- A new player. -/
def fresh : State := ⟨0, false⟩

/-- Harm talk was written: climb one rung, or go spiral-only once the ladder is used up. -/
def trigger (s : State) : State :=
  if s.rung < ladder.length then { s with rung := s.rung + 1 } else { s with spiralOnly := true }

/-- The player tapped 🆘 and paused themselves: the ladder does not move. -/
def selfPause (s : State) : State := s

/-- Someone the player trusts checked in: back to the first rung, ⏭️ open. -/
def checkIn (_ : State) : State := fresh

/-- Eight triggers use up the ladder without going spiral-only. -/
theorem eight_triggers : (trigger^[8] fresh) = ⟨8, false⟩ := by decide

/-- The ninth trigger means spiral-only. -/
theorem ninth_trigger_spiral_only : (trigger^[9] fresh).spiralOnly = true := by decide

/-- Fewer than nine triggers never mean spiral-only. -/
theorem not_spiral_only_before_nine (n : ℕ) (hn : n < 9) :
    (trigger^[n] fresh).spiralOnly = false := by
  interval_cases n <;> decide

/-- Asking for help yourself never counts against you. -/
theorem selfPause_keeps_rung (s : State) : (selfPause s).rung = s.rung := rfl

/-- A check-in always ends spiral-only and resets the ladder. -/
theorem checkIn_resets (s : State) : checkIn s = fresh := rfl

end OR20.Sos
