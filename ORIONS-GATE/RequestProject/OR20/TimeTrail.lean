import Mathlib

/-!
# OR20.4: the Ghost Writer time trail and touchstone prompt

Beth's correction (Doc `1etuEkoP…`, under the OR20.3 readout): a time stamp must not become
"now". A session is stamped with the last time it was worked on, and when the player comes
back it is stamped again as it is "ported in". This file is a small model of the rule the app
(`ghostwriter_app/js/safety.js`, `touch`) follows, with times in whole minutes:

* touching the session never changes when it started;
* a return is stamped exactly when the player was away for 30 minutes or more;
* every stamped return really was a gap of at least 30 minutes;
* stamps are only ever added, never rewritten or dropped;
* a clock that goes backwards changes nothing.

It also checks the touchstone prompt: after leaving in SOS mode, the "Welcome back, how are
you?" card shows exactly when the player stayed away 12 hours (720 minutes) or more.
-/

namespace OR20.TimeTrail

/-- Away this many minutes (or more) and coming back counts as being ported back in. -/
def returnGap : ℕ := 30

/-- One return: when the player left (last touched) and when they came back. -/
structure Return where
  left : ℕ
  back : ℕ
deriving DecidableEq, Repr

/-- A session's time trail. -/
structure Trail where
  started : ℕ
  last : ℕ
  returns : List Return
deriving DecidableEq, Repr

/-- A new session, started at `now`. -/
def fresh (now : ℕ) : Trail := ⟨now, now, []⟩

/-- The player touched the session at `now`. -/
def touch (t : Trail) (now : ℕ) : Trail :=
  if now < t.last then t
  else if returnGap ≤ now - t.last then
    { t with last := now, returns := t.returns ++ [⟨t.last, now⟩] }
  else { t with last := now }

/-- Touching never changes when the session started. -/
theorem touch_started (t : Trail) (now : ℕ) : (touch t now).started = t.started := by
  unfold touch; split_ifs <;> rfl

/-- A clock that goes backwards changes nothing. -/
theorem touch_backwards (t : Trail) (now : ℕ) (h : now < t.last) : touch t now = t := by
  simp [touch, h]

/-- After a touch at a time no earlier than the last one, "last worked on" is that time. -/
theorem touch_last (t : Trail) (now : ℕ) (h : t.last ≤ now) : (touch t now).last = now := by
  unfold touch; split_ifs <;> first | omega | rfl

/-- Stamps are only added at the end: the old returns are kept, in order. -/
theorem touch_returns_prefix (t : Trail) (now : ℕ) : t.returns <+: (touch t now).returns := by
  unfold touch; split_ifs
  · exact List.prefix_refl _
  · exact List.prefix_append _ _
  · exact List.prefix_refl _

/-- A return is stamped exactly when the player was away 30 minutes or more. -/
theorem touch_stamps_iff (t : Trail) (now : ℕ) (h : t.last ≤ now) :
    (touch t now).returns = t.returns ++ [⟨t.last, now⟩] ↔ t.last + returnGap ≤ now := by
  unfold touch
  split_ifs with h1 h2
  · omega
  · simp; omega
  · simp; omega

/-- A trail is honest when every stamped return was a real gap of at least 30 minutes,
and no return is later than the last time the session was touched. -/
def Honest (t : Trail) : Prop :=
  ∀ r ∈ t.returns, r.left + returnGap ≤ r.back ∧ r.back ≤ t.last

theorem fresh_honest (now : ℕ) : Honest (fresh now) := by
  simp [Honest, fresh]

/-- Touching keeps a trail honest. -/
theorem touch_honest (t : Trail) (now : ℕ) (ht : Honest t) : Honest (touch t now) := by
  unfold touch
  split_ifs with h1 h2
  · exact ht
  · intro r hr
    simp only [List.mem_append, List.mem_singleton] at hr
    rcases hr with hr | rfl
    · have := ht r hr; exact ⟨this.1, by simp; omega⟩
    · exact ⟨by simp; omega, le_refl _⟩
  · intro r hr
    have := ht r hr; exact ⟨this.1, by simp; omega⟩

/-- Any sequence of touches from a fresh session gives an honest trail. -/
theorem touches_honest (start : ℕ) (times : List ℕ) :
    Honest (times.foldl touch (fresh start)) := by
  suffices ∀ t, Honest t → Honest (times.foldl touch t) from this _ (fresh_honest start)
  induction times with
  | nil => intro t ht; exact ht
  | cons n ns ih => intro t ht; exact ih _ (touch_honest t n ht)

/-- An example: start at 0, work at 10, come back three hours later (190), copy at 195.
One return is stamped, from 10 to 190. -/
example : [10, 190, 195].foldl touch (fresh 0) = ⟨0, 195, [⟨10, 190⟩]⟩ := by decide

/-! ## The touchstone prompt -/

/-- Hours after which a touchstone should check in, in minutes. -/
def checkMinutes : ℕ := 12 * 60

/-- The "Welcome back" card shows when the player left in SOS mode (`sosSince ≠ 0`) and
stayed away at least 12 hours. -/
def cameBackFromSos (sosSince lastSeen now : ℕ) : Bool :=
  sosSince ≠ 0 && lastSeen + checkMinutes ≤ now

theorem cameBack_iff (sosSince lastSeen now : ℕ) :
    cameBackFromSos sosSince lastSeen now = true ↔ sosSince ≠ 0 ∧ lastSeen + 720 ≤ now := by
  simp [cameBackFromSos, checkMinutes]

/-- Not in SOS mode: never prompted, however long the player was away. -/
theorem not_sos_no_prompt (lastSeen now : ℕ) : cameBackFromSos 0 lastSeen now = false := by
  simp [cameBackFromSos]

/-- Back within 12 hours: no prompt. -/
theorem back_soon_no_prompt (s lastSeen now : ℕ) (h : now < lastSeen + 720) :
    cameBackFromSos s lastSeen now = false := by
  simp [cameBackFromSos, checkMinutes]; omega

end OR20.TimeTrail
