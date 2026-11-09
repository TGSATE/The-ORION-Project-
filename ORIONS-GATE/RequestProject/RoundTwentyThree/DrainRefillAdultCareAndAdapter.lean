module

public import Mathlib

/-!
# Round 23: Beth's corrections, written as rules and checked

* **Gold Lock, corrected (Beth, 🤟💎).** A gold-locked orb *keeps its level and stays
  gold-locked*. When the player drains its KRION energy into other orbs of the same skill set,
  only the energy leaves. Refilling a gold-locked orb gets a **50% bonus**.
* **Adults with a care plan (Beth, 🆘).** An adult (18+) who is under an IEP or has a responsible
  caregiver uses hardware biometrics only through that caregiver in a council. Other adults are
  allowed as before. Under 13 is still never; 13 to 17 still needs council consent.
* **Bobby's gate, clarified (Beth, 🌀).** ORION does not block Bobby's code. It *adapts* it:
  the money part is taken out, everything else is kept, and Bobby's own version is untouched.
* **The garble puzzle (Beth, 🤟💎).** Two players who hear a common key phrase can look it up
  together, and both then understand it, without losing any word they already knew.

These are models of written rules, not running game code.
-/

namespace RoundTwentyThree

open Finset

/-! ## 1. Gold Lock: drain the energy, keep the level and the lock -/

/-- A skill orb: its level, how much KRION energy it holds, and whether it is gold-locked. -/
public structure Orb where
  level : ℕ
  energy : ℕ
  locked : Bool
  deriving DecidableEq, Repr

/-- A skill set: its orbs, indexed by a finite type `ι`. -/
public abbrev SkillSet (ι : Type*) := ι → Orb

/-- Total KRION energy in a skill set. -/
public def total {ι : Type*} [Fintype ι] (s : SkillSet ι) : ℕ := ∑ i, (s i).energy

/-- The 50% bonus for energy going into a gold-locked orb: `a` becomes `a + ⌈a/2⌉`
(odd amounts round up, in the player's favour, as in the Round 8 exchange rule). -/
public def withBonus (a : ℕ) : ℕ := a + (a + 1) / 2

/-- The player drains all of orb `src`'s energy into orb `dst` of the same set. Only the energy
moves: `src` keeps its level and its gold lock. (If `src = dst`, nothing happens.) -/
public def drain {ι : Type*} [DecidableEq ι] (s : SkillSet ι) (src dst : ι) : SkillSet ι :=
  if src ≠ dst then
    fun i =>
      if i = src then { s i with energy := 0 }
      else if i = dst then { s i with energy := (s i).energy + (s src).energy }
      else s i
  else s

/-- Energy earned through play goes into orb `i`; a gold-locked orb gets the 50% bonus. -/
public def refill {ι : Type*} [DecidableEq ι] (s : SkillSet ι) (i : ι) (a : ℕ) : SkillSet ι :=
  fun j => if j = i then
    { s j with energy := (s j).energy + (if (s j).locked then withBonus a else a) }
    else s j

/-- Things that can happen to a skill set. `other` stands for everything else (meters moving,
time passing, other players, ...), which never touches the lock. -/
public inductive Event (ι : Type*) where
  | drain (src dst : ι)
  | refill (i : ι) (a : ℕ)
  | other

/-- What an event does to the skill set. -/
public def apply {ι : Type*} [DecidableEq ι] (s : SkillSet ι) : Event ι → SkillSet ι
  | .drain src dst => drain s src dst
  | .refill i a => refill s i a
  | .other => s

/-- Draining keeps the drained orb's level and gold lock; only its energy goes to zero. -/
public theorem drain_keeps_level_and_lock {ι : Type*} [DecidableEq ι] (s : SkillSet ι)
    (src dst : ι) (h : src ≠ dst) :
    (drain s src dst src).level = (s src).level ∧ (drain s src dst src).locked = (s src).locked ∧
      (drain s src dst src).energy = 0 := by
  simp [drain, h]

/-- No event ever changes any orb's level or lock flag. -/
public theorem apply_keeps_level_and_lock {ι : Type*} [DecidableEq ι] (s : SkillSet ι)
    (e : Event ι) (i : ι) :
    (apply s e i).level = (s i).level ∧ (apply s e i).locked = (s i).locked := by
  cases e with
  | other => simp [apply]
  | refill j a =>
    simp only [apply, refill]
    split_ifs <;> simp
  | drain src dst =>
    simp only [apply, drain]
    split_ifs
    · dsimp only
      split_ifs <;> simp
    · simp

/-- **Gold-locked forever, with no exception now.** Over any sequence of events, a gold-locked
orb stays gold-locked and keeps its level. -/
public theorem locked_forever {ι : Type*} [DecidableEq ι] (i : ι) :
    ∀ (es : List (Event ι)) (s : SkillSet ι),
      (es.foldl apply s i).locked = (s i).locked ∧ (es.foldl apply s i).level = (s i).level := by
  intro es
  induction es with
  | nil => intro s; simp
  | cons e es ih =>
    intro s
    obtain ⟨h1, h2⟩ := ih (apply s e)
    obtain ⟨h3, h4⟩ := apply_keeps_level_and_lock s e i
    simp only [List.foldl_cons]
    exact ⟨h1.trans h4, h2.trans h3⟩

/-- Draining never creates or destroys KRION energy: the skill set's total is the same. -/
public theorem drain_keeps_total {ι : Type*} [Fintype ι] [DecidableEq ι]
    (s : SkillSet ι) (src dst : ι) : total (drain s src dst) = total s := by
  unfold drain
  split_ifs with hne
  · unfold total
    rw [← Finset.add_sum_erase _ _ (Finset.mem_univ src),
      ← Finset.add_sum_erase _ _ (Finset.mem_univ src)]
    have hdst : dst ∈ (univ : Finset ι).erase src := by simp [Ne.symm hne]
    rw [← Finset.add_sum_erase _ _ hdst, ← Finset.add_sum_erase _ _ hdst]
    have hrest : ∑ x ∈ ((univ : Finset ι).erase src).erase dst,
        (if x = src then { s x with energy := 0 }
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

/-- The bonus is at least 50%: twice the bonused amount is at least three times the amount. -/
public theorem withBonus_ge (a : ℕ) : 3 * a ≤ 2 * withBonus a := by
  unfold withBonus; omega

/-- Refilling a gold-locked orb adds the bonused amount; an unlocked orb gets exactly what was
earned. -/
public theorem refill_energy {ι : Type*} [DecidableEq ι] (s : SkillSet ι) (i : ι) (a : ℕ) :
    (refill s i a i).energy =
      (s i).energy + (if (s i).locked then withBonus a else a) := by
  simp [refill]

/-- Refilling one orb leaves every other orb untouched. -/
public theorem refill_other {ι : Type*} [DecidableEq ι] (s : SkillSet ι) (i j : ι) (a : ℕ)
    (h : j ≠ i) : refill s i a j = s j := by
  simp [refill, h]

/-- **A loophole to look at.** The hypothetical rule in which energy *moved* from another orb
into a gold-locked orb also earns the 50% bonus. It is not a rule Beth has adopted; it is here
only to show what it would do (see `bonus_on_moves_pumps_energy`). -/
public def moveWithBonus {ι : Type*} [DecidableEq ι] (s : SkillSet ι) (src dst : ι) :
    SkillSet ι :=
  if src ≠ dst then
    fun i =>
      if i = src then { s i with energy := 0 }
      else if i = dst then
        { s i with energy := (s i).energy +
            (if (s i).locked then withBonus (s src).energy else (s src).energy) }
      else s i
  else s

/-- The pump, concretely: orb 0 is gold-locked at level 100 with 100 energy, orb 1 is unlocked
and empty. Drain 0 into 1, then move 1 back into 0 with the bonus: same orbs, same lock, same
level, but 150 energy instead of 100. -/
public theorem bonus_on_moves_pumps_energy :
    let s : SkillSet (Fin 2) := ![⟨100, 100, true⟩, ⟨1, 0, false⟩]
    let s' := moveWithBonus (drain s 0 1) 1 0
    s' 0 = ⟨100, 150, true⟩ ∧ s' 1 = ⟨1, 0, false⟩ ∧ total s = 100 ∧ total s' = 150 := by
  decide

/-! ## 2. Age tiers, with adults who have a care plan -/

/-- Ways to connect. `accessPort` is a computer console or mobile device (no biometrics). -/
public inductive Link where
  | accessPort
  | patch
  | wearable
  | neuralLink
  deriving DecidableEq, Repr

/-- A player as far as hardware biometrics is concerned: verified age; whether they have a care
plan (an IEP, or another adult responsible for their care); and whether consent was given
through a council gauntlet (by a parent for a minor, by the caregiver for an adult with a care
plan). -/
public structure Account where
  age : ℕ
  carePlan : Bool
  councilConsent : Bool
  deriving DecidableEq, Repr

/-- Beth's tiers: the access port is open to everyone; hardware is never allowed under 13; from
13 to 17 only with council consent; from 18 freely, unless the adult has a care plan, in which
case it goes through their caregiver in a council. -/
public def mayUse (a : Account) (l : Link) : Bool :=
  l == .accessPort ||
    (18 ≤ a.age && (!a.carePlan || a.councilConsent)) ||
    (13 ≤ a.age && a.age < 18 && a.councilConsent)

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
public theorem teen_with_consent (a : Account) (l : Link) (h1 : 13 ≤ a.age) (h2 : a.age < 18)
    (hc : a.councilConsent = true) : mayUse a l = true := by
  simp [mayUse, hc, h1, h2]

/-- An adult without a care plan: allowed (only age and identity verification gate access). -/
public theorem adult_no_care_plan_allowed (a : Account) (l : Link) (ha : 18 ≤ a.age)
    (hp : a.carePlan = false) : mayUse a l = true := by
  simp [mayUse, ha, hp]

/-- An adult with a care plan and no caregiver consent through a council: no hardware. (This
holds at every age: without council consent, nobody with a care plan gets hardware.) -/
public theorem adult_care_plan_needs_caregiver (a : Account) (l : Link)
    (hp : a.carePlan = true) (hc : a.councilConsent = false) (hl : l ≠ .accessPort) :
    mayUse a l = false := by
  simp [mayUse, hp, hc, hl]

/-- An adult with a care plan whose caregiver consents through a council: allowed. -/
public theorem adult_care_plan_with_caregiver (a : Account) (l : Link) (ha : 18 ≤ a.age)
    (hc : a.councilConsent = true) : mayUse a l = true := by
  simp [mayUse, ha, hc]

/-! ## 3. Bobby's gate: adapt his code for ORION, don't block it -/

/-- An offer in a game: its description, what it costs in real money (cents), and whether it
unlocks progress (levels, orbs, XP). -/
public structure Offer where
  text : String
  priceCents : ℕ
  unlocksProgress : Bool
  deriving DecidableEq, Repr

/-- ORION's gate (Beth's 💎): an offer is blocked when paying for it unlocks progress. -/
public def orionBlocks (o : Offer) : Bool := 0 < o.priceCents && o.unlocksProgress

/-- The ORION adapter for Bobby's code: take the money out; keep everything else. -/
public def orionize (o : Offer) : Offer := { o with priceCents := 0 }

/-- After adapting, nothing from Bobby's game is blocked in ORION. -/
public theorem orionize_never_blocked (o : Offer) : orionBlocks (orionize o) = false := by
  simp [orionBlocks, orionize]

/-- Adapting keeps the offer's description and what it unlocks; only the price changes. -/
public theorem orionize_keeps_content (o : Offer) :
    (orionize o).text = o.text ∧ (orionize o).unlocksProgress = o.unlocksProgress := by
  simp [orionize]

/-- Offers that were already free pass through the adapter unchanged. -/
public theorem orionize_free_unchanged (o : Offer) (h : o.priceCents = 0) : orionize o = o := by
  cases o; simp_all [orionize]

/-! ## 4. The garble puzzle: looking a word up together -/

/-- The words a player has a translation for. -/
public abbrev Lexicon := Finset String

/-- Two players hear a common key phrase `w` and look it up together. -/
public def lookUpTogether (l₁ l₂ : Lexicon) (w : String) : Lexicon × Lexicon :=
  (insert w l₁, insert w l₂)

/-- Afterwards both players understand `w`. -/
public theorem both_understand (l₁ l₂ : Lexicon) (w : String) :
    w ∈ (lookUpTogether l₁ l₂ w).1 ∧ w ∈ (lookUpTogether l₁ l₂ w).2 := by
  simp [lookUpTogether]

/-- Nobody loses a word they already knew. -/
public theorem keeps_known_words (l₁ l₂ : Lexicon) (w : String) :
    l₁ ⊆ (lookUpTogether l₁ l₂ w).1 ∧ l₂ ⊆ (lookUpTogether l₁ l₂ w).2 := by
  simp [lookUpTogether, Finset.subset_insert]

/-! ## 5. The album listing arithmetic (not a check that the listing is complete) -/

/-- The observed Round 21 count plus the eleven IDs absent then (four at the first Round 23
check, seven more after the new album link) equals the latest observed public count. This checks
only arithmetic, not the completeness or permanence of the public listing. -/
public theorem album_recount : 1448 + (4 + 7) = 1459 := by decide

/-! ## 6. The Maxwell–Boltzmann post Beth shared: hotter gas, faster and wider -/

/-- The most probable molecular speed in a Maxwell–Boltzmann gas, `√(2kT/m)`, for Boltzmann's
constant `k`, temperature `T` and molecular mass `m`. -/
public noncomputable def mostProbableSpeed (k m T : ℝ) : ℝ := Real.sqrt (2 * k * T / m)

/-- **Heat the gas and the typical speed goes up**: for positive `k` and `m`, a higher
temperature gives a strictly higher most probable speed. -/
public theorem mostProbableSpeed_strictMono {k m : ℝ} (hk : 0 < k) (hm : 0 < m) {T₁ T₂ : ℝ}
    (h0 : 0 ≤ T₁) (h : T₁ < T₂) : mostProbableSpeed k m T₁ < mostProbableSpeed k m T₂ := by
  unfold mostProbableSpeed
  apply Real.sqrt_lt_sqrt
  · positivity
  · apply div_lt_div_of_pos_right _ hm
    nlinarith

/-- **Every speed in the picture stretches by the same factor**: multiplying the temperature by
`c ≥ 0` multiplies the most probable speed by `√c` (so a hotter gas's speeds spread over a wider
range). -/
public theorem mostProbableSpeed_scale (k m T c : ℝ) (hc : 0 ≤ c) :
    mostProbableSpeed k m (c * T) = Real.sqrt c * mostProbableSpeed k m T := by
  unfold mostProbableSpeed
  rw [← Real.sqrt_mul hc]
  congr 1
  ring

end RoundTwentyThree
