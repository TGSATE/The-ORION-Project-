module

public import Mathlib

/-!
# Round 22: Beth's answers, written as rules and checked

* **Gold Lock, with the redistribution exception (Beth, 🤟🧿).** A gold-locked skill orb stays
  locked forever, unless the player *chooses* to move its KRION energy into other skill orbs of
  the same skill set. Nothing else unlocks it.
* **Adult Penalty is option B (Beth, 🤟💎🌀🧿).** There is no added penalty. A player who rushes
  the tutorial simply arrives with less tutorial XP: the gap is exactly the XP of the steps they
  skipped.
* **Age tiers for hardware biometrics (Beth, 🤟🧿).** Under 13: never. 13 to 17: only with
  parental consent given through a council gauntlet. 18 and over: allowed. The access port (a
  computer console or mobile device, no biometrics) is open to everyone.
* **ORION's own store gate (Beth, 🤟💎).** Bobby's word-matching gate is not used in the ORION
  build. ORION's gate looks at what an offer *does* (does paying unlock progress?), not at the
  words used to describe it.
* **The garble filter (Beth, 🤟🌀🧿🌀).** A word the listener has no translation for is heard as
  garble. Learning it from a common-language clue makes it heard correctly, and never changes
  any word already learned.

These are models of written rules, not running game code.
-/

namespace RoundTwentyTwo

open Finset

/-! ## 1. Gold Lock with the redistribution exception -/

/-- A skill orb: how much KRION energy it holds, and whether it is gold-locked. -/
public structure Orb where
  energy : ℕ
  locked : Bool
  deriving DecidableEq, Repr

/-- A skill set: its orbs, indexed by a finite type `ι`. -/
public abbrev SkillSet (ι : Type*) := ι → Orb

/-- Total KRION energy in a skill set. -/
public def total {ι : Type*} [Fintype ι] (s : SkillSet ι) : ℕ := ∑ i, (s i).energy

/-- Things that can happen to a skill set. `other` stands for everything that is not the
player's own choice to redistribute (meters moving, time passing, other players, ...). -/
public inductive Event (ι : Type*) where
  /-- The player chooses to move all of orb `src`'s energy into orb `dst` of the same set. -/
  | redistribute (src dst : ι)
  /-- Anything else. -/
  | other

/-- The player's redistribution: allowed only from a locked orb into a different orb of the
same set. The source orb gives up all its energy and is unlocked; the target gains it. -/
public def redistribute {ι : Type*} [DecidableEq ι] (s : SkillSet ι) (src dst : ι) :
    SkillSet ι :=
  if (s src).locked ∧ src ≠ dst then
    fun i =>
      if i = src then { energy := 0, locked := false }
      else if i = dst then { s i with energy := (s i).energy + (s src).energy }
      else s i
  else s

/-- What an event does to the skill set. Only the player's redistribution changes anything
here; `other` events leave the orbs as they are. -/
public def apply {ι : Type*} [DecidableEq ι] (s : SkillSet ι) : Event ι → SkillSet ι
  | .redistribute src dst => redistribute s src dst
  | .other => s

/-- **Nothing but the player's own choice unlocks an orb.** If a locked orb ends up unlocked
after an event, that event was the player redistributing *that* orb's energy. -/
public theorem unlock_only_by_choice {ι : Type*} [DecidableEq ι] (s : SkillSet ι) (e : Event ι)
    (i : ι) (hl : (s i).locked = true) (hu : (apply s e i).locked = false) :
    ∃ dst, e = .redistribute i dst := by
  cases e with
  | other => simp [apply, hl] at hu
  | redistribute src dst =>
    by_cases hi : i = src
    · subst hi; exact ⟨dst, rfl⟩
    · exfalso
      simp only [apply, redistribute] at hu
      split_ifs at hu
      · by_cases hd : i = dst
        · subst hd; simp_all
        · simp_all
      · simp_all

/-- **Forever, otherwise.** Over any sequence of events in which the player never chooses to
redistribute orb `i`, a locked orb `i` stays locked. -/
public theorem locked_forever_unless_redistributed {ι : Type*} [DecidableEq ι] (i : ι) :
    ∀ (es : List (Event ι)) (s : SkillSet ι), (s i).locked = true →
      (∀ dst, Event.redistribute i dst ∉ es) → (es.foldl apply s i).locked = true := by
  intro es
  induction es with
  | nil => intro s h _; exact h
  | cons e es ih =>
    intro s h hno
    apply ih
    · by_contra hc
      obtain ⟨dst, rfl⟩ := unlock_only_by_choice s e i h (by simpa using hc)
      exact hno dst (by simp)
    · intro dst hd
      exact hno dst (by simp [hd])

/-- **The energy stays in the skill set.** Redistributing never creates or destroys KRION
energy: the set's total is the same before and after. -/
public theorem redistribute_keeps_total {ι : Type*} [Fintype ι] [DecidableEq ι]
    (s : SkillSet ι) (src dst : ι) : total (redistribute s src dst) = total s := by
  unfold redistribute
  split_ifs with h
  · obtain ⟨_, hne⟩ := h
    unfold total
    rw [← Finset.add_sum_erase _ _ (Finset.mem_univ src),
      ← Finset.add_sum_erase _ _ (Finset.mem_univ src)]
    have hdst : dst ∈ (univ : Finset ι).erase src := by simp [Ne.symm hne]
    rw [← Finset.add_sum_erase _ _ hdst, ← Finset.add_sum_erase _ _ hdst]
    have hrest : ∑ x ∈ ((univ : Finset ι).erase src).erase dst,
        (if x = src then ({ energy := 0, locked := false } : Orb)
          else if x = dst then { s x with energy := (s x).energy + (s src).energy }
          else s x).energy = ∑ x ∈ ((univ : Finset ι).erase src).erase dst, (s x).energy := by
      apply Finset.sum_congr rfl
      intro x hx
      simp only [Finset.mem_erase] at hx
      simp [hx.1, hx.2.1]
    rw [hrest]
    simp [Ne.symm hne]
    ring
  · rfl

/-- Redistribution only touches the two orbs involved; every other orb in the set is
unchanged. -/
public theorem redistribute_other_orbs {ι : Type*} [DecidableEq ι] (s : SkillSet ι)
    (src dst i : ι) (h1 : i ≠ src) (h2 : i ≠ dst) : redistribute s src dst i = s i := by
  unfold redistribute
  split_ifs <;> simp [h1, h2]

/-! ## 2. Adult Penalty, option B: the natural result of rushing -/

/-- A tutorial: each step's XP, and whether the player did it. -/
public structure TutorialStep where
  xp : ℕ
  done : Bool
  deriving DecidableEq, Repr

/-- XP the player arrives with: the XP of the steps they actually did. Nothing is subtracted. -/
public def entryXP (t : List TutorialStep) : ℕ := (t.filter (·.done)).map (·.xp) |>.sum

/-- XP available from the whole tutorial. -/
public def fullXP (t : List TutorialStep) : ℕ := t.map (·.xp) |>.sum

/-- XP of the steps the player skipped. -/
public def skippedXP (t : List TutorialStep) : ℕ := (t.filter (!·.done)).map (·.xp) |>.sum

/-- **The gap is exactly what was skipped**: arriving XP plus skipped XP is the full tutorial,
so there is no extra penalty on top. -/
public theorem entry_plus_skipped (t : List TutorialStep) :
    entryXP t + skippedXP t = fullXP t := by
  induction t with
  | nil => rfl
  | cons a t ih =>
    unfold entryXP skippedXP fullXP at *
    cases h : a.done <;> simp [h] <;> omega

/-- A rusher never arrives with more than the full tutorial gives. -/
public theorem entry_le_full (t : List TutorialStep) : entryXP t ≤ fullXP t := by
  have := entry_plus_skipped t
  omega

/-- A player who finishes every step loses nothing. -/
public theorem no_penalty_when_finished (t : List TutorialStep) (h : ∀ x ∈ t, x.done = true) :
    entryXP t = fullXP t := by
  have hs : skippedXP t = 0 := by
    unfold skippedXP
    rw [List.filter_eq_nil_iff.mpr (by intro x hx; simp [h x hx])]
    rfl
  have := entry_plus_skipped t
  omega

/-! ## 3. Age tiers for hardware biometrics -/

/-- Ways to connect. `accessPort` is a computer console or mobile device (no biometrics). -/
public inductive Link where
  | accessPort
  | patch
  | wearable
  | neuralLink
  deriving DecidableEq, Repr

/-- A player as far as hardware biometrics is concerned: verified age, and whether a parent
gave consent through a council gauntlet. -/
public structure Account where
  age : ℕ
  councilConsent : Bool
  deriving DecidableEq, Repr

/-- Beth's tiers: the access port is open to everyone; hardware is never allowed under 13,
allowed from 13 to 17 only with council-gauntlet parental consent, and allowed from 18. -/
public def mayUse (a : Account) (l : Link) : Bool :=
  l == .accessPort || 18 ≤ a.age || (13 ≤ a.age && a.councilConsent)

/-- The access port is open to every account. -/
public theorem accessPort_open (a : Account) : mayUse a .accessPort = true := by
  simp [mayUse]

/-- Under 13: never any hardware, whatever consent is recorded. -/
public theorem under13_never_hardware (a : Account) (l : Link) (ha : a.age < 13)
    (hl : l ≠ .accessPort) : mayUse a l = false := by
  simp [mayUse, hl]
  omega

/-- 13 to 17 without council consent: no hardware. -/
public theorem teen_needs_consent (a : Account) (l : Link) (ha : a.age < 18)
    (hc : a.councilConsent = false) (hl : l ≠ .accessPort) : mayUse a l = false := by
  simp [mayUse, hl, hc]
  omega

/-- 13 to 17 with council consent: hardware is allowed. -/
public theorem teen_with_consent (a : Account) (l : Link) (ha : 13 ≤ a.age)
    (hc : a.councilConsent = true) : mayUse a l = true := by
  simp [mayUse, hc, ha]

/-- 18 and over: hardware is allowed (only age and identity verification gate access). -/
public theorem adult_allowed (a : Account) (l : Link) (ha : 18 ≤ a.age) : mayUse a l = true := by
  simp [mayUse, ha]

/-! ## 4. ORION's store gate: judge what an offer does, not its words -/

/-- An offer in a game: its description, what it costs in real money (cents), and whether it
unlocks progress (levels, orbs, XP). -/
public structure Offer where
  text : String
  priceCents : ℕ
  unlocksProgress : Bool
  deriving DecidableEq, Repr

/-- ORION's gate (Beth's 💎: no ads, no microtransactions, no buy-more-play-more): an offer is
blocked when paying for it unlocks progress. -/
public def orionBlocks (o : Offer) : Bool := 0 < o.priceCents && o.unlocksProgress

/-- **Rewording can't get past it.** Two offers that do the same thing get the same answer,
whatever words they use. -/
public theorem orion_gate_ignores_wording (o : Offer) (t : String) :
    orionBlocks { o with text := t } = orionBlocks o := by
  simp [orionBlocks]

/-- The far-games example that slipped through Bobby's word gate last round is blocked here,
because it asks for money to unlock levels. (The 99-cent price is a stand-in; any price above
zero gives the same answer.) -/
public theorem far_games_example_blocked_in_orion :
    orionBlocks ⟨"buy gems and coins to unlock more levels", 99, true⟩ = true := by
  simp [orionBlocks]

/-- Free things that unlock progress (earned through play) pass. -/
public theorem free_progress_passes (o : Offer) (h : o.priceCents = 0) : orionBlocks o = false := by
  simp [orionBlocks, h]

/-! ## 5. The garble filter -/

/-- What a listener hears for a word: its meaning, if they have learned it; otherwise garble. -/
public def hear (known : List (String × String)) (word : String) : Option String :=
  (known.find? (·.1 == word)).map (·.2)

/-- Learning a word from a clue: if it is already known, nothing changes; otherwise it is added. -/
public def learn (known : List (String × String)) (word meaning : String) :
    List (String × String) :=
  if (hear known word).isSome then known else known ++ [(word, meaning)]

/-- After learning, the word is no longer garble. -/
public theorem learn_heard (known : List (String × String)) (w m : String) :
    (hear (learn known w m) w).isSome = true := by
  unfold learn
  split_ifs with h
  · exact h
  · simp only [Option.isSome_iff_ne_none, ne_eq, Decidable.not_not] at h
    simp [hear, List.find?_append, Option.map_eq_none_iff.mp h]

/-- Learning a new word never changes what an already-learned word means. -/
public theorem learn_keeps_known (known : List (String × String)) (w m v : String)
    (hv : (hear known v).isSome = true) : hear (learn known w m) v = hear known v := by
  unfold learn
  split_ifs
  · rfl
  · unfold hear at *
    obtain ⟨p, hp⟩ := Option.isSome_iff_exists.mp hv
    obtain ⟨q, hq, rfl⟩ := Option.map_eq_some_iff.mp hp
    simp [List.find?_append, hq]

end RoundTwentyTwo
