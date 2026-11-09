module

public import Mathlib

/-!
# Round 12 follow-up: the album's visible arithmetic, and this round's rulings

1. **Album arithmetic.** The image deep dive (`ORION_IMAGE_DEEP_DIVE.md`) found that the
   numbers drawn *legibly* in the album art are the Cuby / calendar numbers and the golden
   ratio. They are checked here:
   * `93³ = 804,357` (Cuby-93) and `39³ = 59,319` (the grid);
   * `59,319 = 13 × 4,563`: the grid splits into 13 months of 4,563 nodes each;
   * `13 × 28 + 1 = 365` (13 months of 28 days, plus the Year Day);
   * "Erdős–Straus 4/39": `4/39 = 1/13 + 1/40 + 1/1560`, three distinct unit fractions;
   * `144` (the "Kronos 144") is the 12th Fibonacci number;
   * the golden ratio `φ = (1 + √5)/2` satisfies `φ² = φ + 1` and `1/φ = φ − 1`, and
     `1.618 < φ < 1.6181`, matching the "1.6180339887…" and "0.6180339887…" labels.
   The garbled "395,319" seen on the Cuby 4.1 poster is **not** `39³`
   (`garbled_reading_ne_grid`); it is a rendering slip of `59,319`.
2. **Memory bubbles (Beth, Round 12 follow-up).** "That should go for everything except
   for what has been run through any council gauntlet; if it is genuinely a private memory
   that they shared publicly, yes absolutely they should have 100% control over that."
3. **Capability never automatically becomes authority (💎).** Skill never changes who has
   authority over a project.
4. **Lossless council handoff.** "It needs to be a one-to-one package transfer. The only
   difference should be the AI council members' training."

These check arithmetic and written rules. They are not game code.
-/

@[expose] public section

namespace RoundTwelveFollowUp

/-! ## 1. Album arithmetic -/

theorem cuby93_cube : (93 : ℕ) ^ 3 = 804357 := by norm_num

theorem grid39_cube : (39 : ℕ) ^ 3 = 59319 := by norm_num

theorem grid_splits_into_thirteen_months : (59319 : ℕ) = 13 * 4563 := by norm_num

theorem thirteen_month_calendar : 13 * 28 + 1 = 365 := by norm_num

/-- The poster's "395,319" is not the grid size `39³`. -/
theorem garbled_reading_ne_grid : (395319 : ℕ) ≠ 39 ^ 3 := by norm_num

/-- "Erdős–Straus 4/39": three distinct unit fractions summing to `4/39`. -/
theorem erdos_straus_39 : (4 : ℚ) / 39 = 1 / 13 + 1 / 40 + 1 / 1560 := by norm_num

theorem kronos_144_is_fib_12 : Nat.fib 12 = 144 := by decide

/-- The album's golden ratio, `(1 + √5)/2`. -/
noncomputable def phi : ℝ := (1 + Real.sqrt 5) / 2

theorem phi_sq : phi ^ 2 = phi + 1 := by
  have h5 : Real.sqrt 5 ^ 2 = 5 := Real.sq_sqrt (by norm_num)
  unfold phi
  nlinarith [h5]

theorem phi_pos : 0 < phi := by
  unfold phi
  positivity

theorem inv_phi : phi⁻¹ = phi - 1 := by
  have hpos := phi_pos
  have hsq := phi_sq
  field_simp
  nlinarith [hsq]

theorem phi_bounds : 1.618 < phi ∧ phi < 1.6181 := by
  have hlo : (2.236 : ℝ) < Real.sqrt 5 := by
    rw [Real.lt_sqrt (by norm_num)]; norm_num
  have hhi : Real.sqrt 5 < 2.2362 := by
    rw [Real.sqrt_lt' (by norm_num)]; norm_num
  unfold phi
  constructor <;> linarith

/-! ## 2. Memory bubbles in Elder's Garden -/

/-- A planted life-bubble. -/
structure Bubble where
  owner : ℕ
  /-- a genuinely private memory that its owner chose to share publicly -/
  privateOrigin : Bool
  /-- the bubble has been run through a council gauntlet -/
  gauntletRun : Bool
  deriving DecidableEq

/-- Beth's rule: an owner may take a bubble back unless it went through a council
gauntlet; a private memory shared publicly always stays under the owner's control. -/
def canUnplant (requester : ℕ) (b : Bubble) : Prop :=
  requester = b.owner ∧ (b.privateOrigin = true ∨ b.gauntletRun = false)

theorem owner_can_unplant_private (b : Bubble) (h : b.privateOrigin = true) :
    canUnplant b.owner b :=
  ⟨rfl, Or.inl h⟩

theorem owner_can_unplant_unreviewed (b : Bubble) (h : b.gauntletRun = false) :
    canUnplant b.owner b :=
  ⟨rfl, Or.inr h⟩

theorem gauntlet_record_stays (r : ℕ) (b : Bubble) (hp : b.privateOrigin = false)
    (hg : b.gauntletRun = true) : ¬ canUnplant r b := by
  rintro ⟨-, h | h⟩ <;> simp_all

theorem only_owner_unplants (r : ℕ) (b : Bubble) (h : canUnplant r b) : r = b.owner :=
  h.1

/-- Taking a bubble back removes it from the garden and costs the owner no progress. -/
def unplant (garden : List Bubble) (progress : ℕ) (b : Bubble) :
    List Bubble × ℕ :=
  (garden.erase b, progress)

theorem unplant_no_penalty (garden : List Bubble) (progress : ℕ) (b : Bubble) :
    (unplant garden progress b).2 = progress := rfl

theorem unplant_removes (garden : List Bubble) (progress : ℕ) (b : Bubble)
    (hnd : garden.Nodup) : b ∉ (unplant garden progress b).1 :=
  hnd.not_mem_erase

/-! ## 3. Capability never automatically becomes authority (💎) -/

/-- Authority over a project comes only from its admin list, chosen by people. -/
def hasAuthority (admins : ℕ → Finset ℕ) (_skill : ℕ → ℕ) (player project : ℕ) : Prop :=
  player ∈ admins project

/-- Changing anyone's skill level never changes who has authority. -/
theorem capability_not_authority (admins : ℕ → Finset ℕ) (skill skill' : ℕ → ℕ)
    (player project : ℕ) :
    hasAuthority admins skill player project ↔ hasAuthority admins skill' player project :=
  Iff.rfl

/-! ## 4. Lossless AI-council handoff -/

/-- What an AI council member hands over when it runs out of tokens. -/
structure CouncilPackage where
  memory : List String
  quests : List String
  notes : List String
  tokensLeft : ℕ
  training : String

/-- The one-to-one transfer: everything is copied; only the receiving member's
training differs. -/
def handoff (p : CouncilPackage) (newTraining : String) : CouncilPackage :=
  { p with training := newTraining }

theorem handoff_lossless (p : CouncilPackage) (t : String) :
    (handoff p t).memory = p.memory ∧ (handoff p t).quests = p.quests ∧
      (handoff p t).notes = p.notes ∧ (handoff p t).tokensLeft = p.tokensLeft :=
  ⟨rfl, rfl, rfl, rfl⟩

theorem handoff_only_training_differs (p : CouncilPackage) (t : String) :
    handoff p t = { p with training := t } := rfl

/-- Handing the package back to the original member restores it exactly. -/
theorem handoff_round_trip (p : CouncilPackage) (t : String) :
    handoff (handoff p t) p.training = p := rfl

end RoundTwelveFollowUp
