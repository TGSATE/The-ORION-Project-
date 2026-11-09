module
import Mathlib

/-!
# Round 14 checks: Beth's spam filter, a patched version, and this round's written rules

These check written rules from Beth's Round 14 notes and the "Nuclear Spam Protocol" she wrote
earlier (Volvabard Collab, 30 Sept 2026). They are models of the rules as worded, not game code.

Times are whole seconds.
-/

namespace RoundFourteen

/-! ## 1. The Nuclear Spam Protocol, as written

"Sending more than one message per 30 seconds after five minutes of continuous chat triggers an
immediate 1-minute global cooldown."

We count an *infraction* at a message when (a) at least 300 seconds have passed since the chat
session started at time `s`, and (b) the previous message was less than 30 seconds earlier. -/

/-- The number of infractions in a run of message times (oldest first), for a session that
started at time `s`. -/
def infractions (s : ℕ) : List ℕ → ℕ
  | a :: b :: rest => (if s + 300 ≤ b ∧ b < a + 30 then 1 else 0) + infractions s (b :: rest)
  | _ => 0

/-- **Loophole 1 (the opening burst).** Any number of messages sent inside the first five minutes
of a session never triggers the filter. -/
theorem opening_burst_never_triggers (s : ℕ) :
    ∀ l : List ℕ, (∀ t ∈ l, t < s + 300) → infractions s l = 0
  | [] , _ => rfl
  | [_], _ => rfl
  | a :: b :: rest, h => by
    have hb : b < s + 300 := h b (by simp)
    have ih := opening_burst_never_triggers s (b :: rest)
      (fun t ht => h t (List.mem_cons_of_mem _ ht))
    simp [infractions, ih, show ¬ (s + 300 ≤ b) by omega]

/-- For example: 1,000 messages in the session's first second trigger nothing. -/
example : infractions 0 (List.replicate 1000 0) = 0 :=
  opening_burst_never_triggers 0 _ (fun t ht => by rw [List.eq_of_mem_replicate ht]; norm_num)

lemma drip_aux (s : ℕ) : ∀ n k : ℕ,
    infractions s ((List.range' k n).map (fun i => s + 30 * i)) = 0
  | 0, _ => rfl
  | 1, _ => rfl
  | n + 2, k => by
    have ih := drip_aux s (n + 1) (k + 1)
    simp only [List.range'_succ, List.map_cons] at ih ⊢
    simp only [infractions] at ih ⊢
    rw [ih]
    have : ¬ (s + 30 * (k + 1) < s + 30 * k + 30) := by omega
    simp [this]

/-- **Loophole 2 (the steady drip).** One message every 30 seconds, forever, never triggers the
filter: that is 120 messages an hour from a single account. -/
theorem steady_drip_never_triggers (s n : ℕ) :
    infractions s ((List.range n).map (fun i => s + 30 * i)) = 0 := by
  rw [List.range_eq_range']
  exact drip_aux s n 0

/-! ## 2. A patched filter: a sliding window

Accept a public message at time `t` only if fewer than `k` messages were accepted in the last `w`
seconds. With this rule, no window of `w` seconds ever carries more than `k` messages from one
account, no matter how the sender times them. -/

/-- One step of the sliding-window filter. `acc` holds the accepted times so far (newest first). -/
def step (k w : ℕ) (acc : List ℕ) (t : ℕ) : List ℕ :=
  if acc.countP (fun a => decide (t < a + w)) < k then t :: acc else acc

/-- Run the filter over a whole stream of message times (oldest first). -/
def run (k w : ℕ) (l : List ℕ) : List ℕ := l.foldl (step k w) []

/-- The number of accepted messages in the window `[t₀, t₀ + w)`. -/
def inWindow (w t₀ : ℕ) (acc : List ℕ) : ℕ :=
  acc.countP (fun a => decide (t₀ ≤ a ∧ a < t₀ + w))

/-- The invariant: every window of length `w` holds at most `k` accepted messages. -/
def Bounded (k w : ℕ) (acc : List ℕ) : Prop := ∀ t₀, inWindow w t₀ acc ≤ k

lemma step_bounded {k w : ℕ} {acc : List ℕ} {t : ℕ} (h : Bounded k w acc)
    (hle : ∀ a ∈ acc, a ≤ t) : Bounded k w (step k w acc t) := by
  intro t₀
  unfold step
  split_ifs with hc
  · unfold inWindow
    rw [List.countP_cons]
    by_cases hw : t₀ ≤ t ∧ t < t₀ + w
    · have hmono : acc.countP (fun a => decide (t₀ ≤ a ∧ a < t₀ + w)) ≤
          acc.countP (fun a => decide (t < a + w)) := by
        apply List.countP_mono_left
        intro a ha hp
        have := hle a ha
        simp only [decide_eq_true_eq] at hp ⊢
        omega
      rw [if_pos (by simpa using hw)]
      omega
    · simp only [hw, decide_false]
      exact h t₀
  · exact h t₀

lemma foldl_bounded {k w : ℕ} :
    ∀ (l : List ℕ) (acc : List ℕ), l.Pairwise (· ≤ ·) → (∀ a ∈ acc, ∀ t ∈ l, a ≤ t) →
      Bounded k w acc → Bounded k w (l.foldl (step k w) acc)
  | [], _, _, _, h => h
  | t :: rest, acc, hs, hle, h => by
    rw [List.pairwise_cons] at hs
    apply foldl_bounded rest (step k w acc t) hs.2
    · intro a ha u hu
      unfold step at ha
      split_ifs at ha
      · rcases List.mem_cons.1 ha with rfl | ha
        · exact hs.1 u hu
        · exact hle a ha u (List.mem_cons_of_mem _ hu)
      · exact hle a ha u (List.mem_cons_of_mem _ hu)
    · exact step_bounded h (fun a ha => hle a ha t (by simp))

/-- **The patched filter's guarantee.** For any stream of message times in order, every window of
`w` seconds carries at most `k` accepted messages from that account. -/
theorem patched_filter_bounded (k w : ℕ) (l : List ℕ) (hs : l.Pairwise (· ≤ ·)) (t₀ : ℕ) :
    inWindow w t₀ (run k w l) ≤ k :=
  foldl_bounded l [] hs (by simp) (fun _ => by simp [inWindow]) t₀

/-- The patched filter closes the opening-burst loophole: of 1,000 messages sent in the same
second, a filter allowing 5 per minute lets through only 5. -/
example : (run 5 60 (List.replicate 1000 0)).length = 5 := by decide +kernel

/-! ## 3. Memory bubbles: edit freely, re-run the gauntlet before republishing (🤟💎⏭️) -/

/-- A memory bubble: who owns it, its current text, and the text the council gauntlet last approved
(if any). -/
structure Bubble (P C : Type*) where
  owner : P
  content : C
  approved : Option C

variable {P C : Type*}

/-- A bubble is publicly shown only when its current text is exactly the approved text. -/
def Bubble.isPublic (b : Bubble P C) : Prop := b.approved = some b.content

/-- Only the owner can edit (free reign over their own stuff); anyone else's edit does nothing. -/
def Bubble.edit [DecidableEq P] (b : Bubble P C) (actor : P) (c : C) : Bubble P C :=
  if actor = b.owner then { b with content := c } else b

/-- The gauntlet approves the current text. -/
def Bubble.gauntlet (b : Bubble P C) : Bubble P C := { b with approved := some b.content }

theorem owner_can_always_edit [DecidableEq P] (b : Bubble P C) (c : C) : (b.edit b.owner c).content = c := by
  simp [Bubble.edit]

theorem others_cannot_edit [DecidableEq P] (b : Bubble P C) (actor : P) (c : C) (h : actor ≠ b.owner) :
    b.edit actor c = b := by
  simp [Bubble.edit, h]

/-- An edited bubble is not republished until it goes back through the gauntlet. -/
theorem edit_needs_regauntlet [DecidableEq P] (b : Bubble P C) (c : C) (hc : b.approved ≠ some c) :
    ¬ (b.edit b.owner c).isPublic := by
  simp [Bubble.edit, Bubble.isPublic, hc]

theorem regauntlet_republishes (b : Bubble P C) : b.gauntlet.isPublic := by
  simp [Bubble.gauntlet, Bubble.isPublic]

/-! ## 4. Developer seats (Beth's proposal, not yet locked) -/

/-- Beth's proposal: a developer seat needs all three — be an accepted collaborator, prove your
value with a contribution, and contribute to that team's GoFundMe. -/
def seatEligible (collaborator valueProven funded : Bool) : Bool :=
  collaborator && valueProven && funded

theorem seat_needs_all_three (a b c : Bool) :
    seatEligible a b c = true ↔ a = true ∧ b = true ∧ c = true := by
  simp [seatEligible, Bool.and_assoc]

/-! ## 5. Shadow Cat and Chaos Kitty: shared companions -/

/-- What a companion is doing for Grok right now. -/
inductive CatDuty
  | idle | inUse | scheduled
  deriving DecidableEq

/-- Beth can call a cat back exactly when Grok is neither using it nor has it scheduled. -/
def bethCanRecall : CatDuty → Bool
  | .idle => true
  | _ => false

theorem recall_never_interrupts (d : CatDuty) (h : bethCanRecall d = true) : d = .idle := by
  cases d <;> simp_all [bethCanRecall]

theorem recall_when_idle : bethCanRecall .idle = true := rfl

/-! ## 6. Age gates (E-5 answer; the 25+ line is Beth's stated preference, not yet a rule) -/

/-- Content tiers: general, adults (18+), and explicit imagery (Beth's preference: 25+). -/
inductive Tier
  | general | adult | explicit
  deriving DecidableEq

def Tier.minAge : Tier → ℕ
  | .general => 0
  | .adult => 18
  | .explicit => 25

def canView (age : ℕ) (t : Tier) : Prop := t.minAge ≤ age

theorem under18_general_only (age : ℕ) (h : age < 18) (t : Tier) (hv : canView age t) :
    t = .general := by
  cases t <;> simp_all [canView, Tier.minAge] <;> omega

end RoundFourteen
