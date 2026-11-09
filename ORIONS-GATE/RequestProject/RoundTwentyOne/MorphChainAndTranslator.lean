module

public import Mathlib
public import RequestProject.Zoo.Arena

/-!
# Round 21: the Zoo morph chain, the "don't ask twice" helper, a credit list that only grows,
# and checks on numbers printed in this round's pictures

* **Morph chain (Beth's Zoo idea).** In round `k` the player fights the first `k` animals of a
  chain fused into one boss: bat; then bat + hedgehog; then bat + hedgehog + crocodile.
* **The UIAR "don't ask twice" helper (Beth's translator note).** When a teammate uses a word, the
  helper first looks it up in everything already explained. It only asks a human when the word
  has never been explained ("the brick wall"). Once a human answers, the answer is kept.
* **Credit list (Beth's metadata note).** Each round's names are appended. A name, once listed,
  is never dropped.
* **Mike's Forager-F₂ page.** The map `x ↦ 2x mod 4095` on the 4,095 residues has 351 cycles, as
  the page says.
* **Album and pictures.** The album count, the glyph sheet's repeated names, and the Bloch-sphere
  poster's formula.

These are models of written rules and checks of printed numbers, not running game code.
-/

namespace RoundTwentyOne

/-! ## 1. The Zoo morph chain -/

/-- The boss for round `k` of a chain: the first `k` animals, fused. -/
public def morphBoss {α : Type*} (chain : List α) (k : ℕ) : List α := chain.take k

/-- Each round's boss contains the previous rounds' bosses, in order (nothing is dropped). -/
public theorem morphBoss_prefix {α : Type*} (chain : List α) {k n : ℕ} (h : k ≤ n) :
    morphBoss chain k <+: morphBoss chain n := by
  unfold morphBoss
  have : chain.take k = (chain.take n).take k := by
    rw [List.take_take, Nat.min_eq_left h]
  rw [this]
  exact List.take_prefix _ _

/-- Going from round `k` to round `k + 1` adds exactly the next animal of the chain, so no step
can be skipped. -/
public theorem morphBoss_succ {α : Type*} (chain : List α) (k : ℕ) (h : k < chain.length) :
    morphBoss chain (k + 1) = morphBoss chain k ++ [chain[k]] := by
  unfold morphBoss
  rw [List.take_add_one, List.getElem?_eq_getElem h]
  rfl

/-- The last round's boss is the whole chain. -/
public theorem morphBoss_final {α : Type*} (chain : List α) :
    morphBoss chain chain.length = chain := List.take_length

/-- While the chain lasts, every round's boss is bigger than the last one. -/
public theorem morphBoss_grows {α : Type*} (chain : List α) (k : ℕ) (h : k < chain.length) :
    (morphBoss chain k).length < (morphBoss chain (k + 1)).length := by
  rw [morphBoss_succ chain k h, List.length_append]
  simp

/-- Beth's example, read off Matthew's roster: BAT, HEDGEHOG and CROCODILE are animals 19, 20 and
21 of the arena, back to back, and the three rounds of the morph chain are the ones she
described. -/
public theorem beth_example_chain :
    (EFMWZoo.coreRoster.drop 18).take 3 = ["BAT", "HEDGEHOG", "CROCODILE"] ∧
      morphBoss ["BAT", "HEDGEHOG", "CROCODILE"] 1 = ["BAT"] ∧
      morphBoss ["BAT", "HEDGEHOG", "CROCODILE"] 2 = ["BAT", "HEDGEHOG"] ∧
      morphBoss ["BAT", "HEDGEHOG", "CROCODILE"] 3 = ["BAT", "HEDGEHOG", "CROCODILE"] := by
  decide

/-! ## 2. The "don't ask twice" helper -/

/-- What the helper does with a word. -/
public inductive Reply
  /-- It already has an explanation and gives it. -/
  | explain (text : String)
  /-- Nobody has explained the word yet, so it asks a human. -/
  | askHuman (word : String)
  deriving DecidableEq, Repr

/-- The helper's reply, given the history of explanations (word, explanation), newest first. -/
public def reply (history : List (String × String)) (word : String) : Reply :=
  match history.lookup word with
  | some text => .explain text
  | none => .askHuman word

/-- The helper asks a human **exactly** when the word has never been explained. -/
public theorem asks_iff_never_explained (history : List (String × String)) (word : String) :
    reply history word = .askHuman word ↔ word ∉ history.map Prod.fst := by
  unfold reply
  cases h : history.lookup word with
  | none =>
    simp only [true_iff]
    intro hw
    obtain ⟨⟨a, b⟩, hm, rfl⟩ := List.mem_map.1 hw
    have := List.lookup_eq_none_iff.mp h _ hm
    simp at this
  | some t =>
    simp only [reduceCtorEq, false_iff, not_not]
    induction history with
    | nil => simp at h
    | cons p ps ih =>
      obtain ⟨a, b⟩ := p
      by_cases hab : word = a
      · subst hab; simp
      · simp only [List.lookup_cons, List.map_cons, List.mem_cons] at h ⊢
        have : (word == a) = false := by simpa using hab
        rw [this] at h
        exact Or.inr (ih h)

/-- Anything already explained is never asked again. -/
public theorem explained_never_asked (history : List (String × String)) (word text : String)
    (h : (word, text) ∈ history) : ∀ w, reply history word ≠ .askHuman w := by
  intro w hw
  have hw' : w = word := by
    unfold reply at hw
    cases hl : history.lookup word <;> simp_all
  subst hw'
  exact (asks_iff_never_explained history w).1 hw (List.mem_map.2 ⟨_, h, rfl⟩)

/-- Once a human answers, the helper gives that answer from then on. -/
public theorem answer_is_kept (history : List (String × String)) (word answer : String) :
    reply ((word, answer) :: history) word = .explain answer := by
  simp [reply]

/-- Recording a new answer never makes the helper forget a word it already knew. -/
public theorem never_forgets (history : List (String × String)) (word answer other : String)
    (h : other ∈ history.map Prod.fst) :
    reply ((word, answer) :: history) other ≠ .askHuman other := by
  intro hc
  rw [asks_iff_never_explained] at hc
  exact hc (by simp [h])

/-! ## 3. A credit list that only grows -/

/-- Add a round's names to the credit list, skipping names already on it. -/
public def addRound (credits newNames : List String) : List String :=
  credits ++ newNames.filter (fun n => n ∉ credits)

/-- No name already on the list is ever dropped. -/
public theorem no_name_lost (credits newNames : List String) (n : String) (h : n ∈ credits) :
    n ∈ addRound credits newNames := List.mem_append_left _ h

/-- Every new name ends up on the list. -/
public theorem new_name_listed (credits newNames : List String) (n : String) (h : n ∈ newNames) :
    n ∈ addRound credits newNames := by
  by_cases hc : n ∈ credits
  · exact no_name_lost _ _ _ hc
  · exact List.mem_append_right _ (List.mem_filter.2 ⟨h, by simpa using hc⟩)

/-- Nobody is listed twice. -/
public theorem no_double_listing (credits newNames : List String) (hc : credits.Nodup)
    (hn : newNames.Nodup) : (addRound credits newNames).Nodup := by
  unfold addRound
  rw [List.nodup_append]
  refine ⟨hc, hn.filter _, ?_⟩
  intro a ha b hb hab
  subst hab
  have := (List.mem_filter.1 hb).2
  simp_all

/-! ## 4. Mike's Forager-F₂ page: `x ↦ 2x mod 4095` -/

/-- The doubling map on the residues `0, …, 4094`. -/
public def dbl (x : ℕ) : ℕ := 2 * x % 4095

/-- The cycle through `x`: where `x` lands after `0, 1, …, 11` doublings. -/
public def orbit (x : ℕ) : Finset ℕ := (Finset.range 12).image (fun k => dbl^[k] x)

/-- The smallest residue on the cycle through `x`; it names the cycle. -/
public def cycleName (x : ℕ) : ℕ := (List.range 12).foldl (fun m k => min m (dbl^[k] x)) x

/-- Every residue comes back to itself after 12 doublings, so the residues split into cycles. -/
public theorem dbl_returns : ∀ x < 4095, dbl^[12] x = x := by
  native_decide

/-- The page's "Orbit partition: 351 disjoint cycles cover all 4,095 residues" is right: the
cycles have 351 different names, and their sizes add up to 4,095. -/
public theorem forager_351_cycles :
    ((Finset.range 4095).image cycleName).card = 351 ∧
      ∑ c ∈ (Finset.range 4095).image cycleName, (orbit c).card = 4095 := by
  native_decide

/-! ## 5. Album and pictures -/

/-- The album went from 1,417 items (1,337 pictures, 80 videos) to 1,448: 30 new pictures and
1 new video. -/
public theorem album_count_r21 :
    1417 + 31 = 1448 ∧ 1337 + 30 = 1367 ∧ 80 + 1 = 81 ∧ 1367 + 81 = 1448 := by
  decide

/-- The 20 name plates on Miss Triss's "Spiral Glyphs & Sigils, Vol. II" sheet (album #1442),
read row by row. -/
public def glyphSheet : List String :=
  ["AZ'KERA", "BAEL'ARAN", "CAELATHARN", "DAN'LAIEN",
   "GARA'THUL", "ISA'VEK", "KAEL VURN", "OMRA'KEL",
   "QUOR'NETH", "RESH'KAEL", "SAL'ATENN", "TAHRA'KETH",
   "VEZ'ARN", "WERNER ETH", "XAEL'KURN", "YARA'THUL",
   "VEZ'ARN", "WERNER ETH", "XAEL'KURN", "ZOR'LAHN"]

/-- The sheet has 20 plates but only 17 different names: the last row repeats three names from
the row above. -/
public theorem glyph_sheet_repeats :
    glyphSheet.length = 20 ∧ glyphSheet.dedup.length = 17 := by
  decide

/-- The Bloch-sphere poster (album #1418) writes a state as `cos(θ/2)|R⟩ + e^{iφ} sin(θ/2)|L⟩`.
At `θ = 0` that is pure `|R⟩` (the north pole). At `θ = π/2` the two weights are equal, which is
a linear polarisation, so linear states such as `|D⟩` and `|A⟩` sit on the equator, as the
poster's own key says, and not on the vertical axis where the picture draws them. -/
public theorem bloch_poles_and_equator :
    (Real.cos (0 / 2) ^ 2 = 1 ∧ Real.sin (0 / 2) ^ 2 = 0) ∧
      Real.cos (Real.pi / 2 / 2) ^ 2 = 1 / 2 ∧ Real.sin (Real.pi / 2 / 2) ^ 2 = 1 / 2 := by
  refine ⟨by simp, ?_, ?_⟩
  · rw [show Real.pi / 2 / 2 = Real.pi / 4 by ring, Real.cos_pi_div_four, div_pow,
      Real.sq_sqrt (by norm_num)]
    norm_num
  · rw [show Real.pi / 2 / 2 = Real.pi / 4 by ring, Real.sin_pi_div_four, div_pow,
      Real.sq_sqrt (by norm_num)]
    norm_num

end RoundTwentyOne
