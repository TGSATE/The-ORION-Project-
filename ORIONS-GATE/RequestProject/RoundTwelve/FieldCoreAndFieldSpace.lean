module

public import Mathlib.Tactic

/-!
# Round 12 checks: Far Queen's steel-ball step, the FieldSpace triplet count,
# the escape-pod rule and the Union Wealth group figures

1. **FieldCore (Far Queen / Bobby, `the-far-queen/fieldcore`, MIT).** The README
   calls `src/steel_ball_proof.py` "THE PROOF": one projected gradient step on
   `F(x) = ½‖x - ψ₀‖²`, followed by radial clipping onto the ball of radius `R`
   about `ψ₀`, shrinks the drift `‖x - ψ₀‖` by the factor `1 - η`. The README also
   says "a mathematician or formal-methods person could close this". Below this is
   proved in Lean for any real normed space, for exactly the step that the Python
   script implements. Two refinements come out of the proof:
   * the bound is exact, `d_{k+1} ≤ (1 - η) d_k`, with no `O(η² d_k²)` error term
     (the script's docstring carries one);
   * the step-size condition is load-bearing: with `η = 3` the ball never settles
     (`steelBall_eta_three_never_settles`).
   This checks the *convergence exhibit only*. It says nothing about the README's
   comparison with language-model forward passes, heat, or cost.
2. **FieldSpace master action (`enuminous/FieldSpace`).** The note says its
   projection rule produces the catalogue's six classes "by counting": 56, 56, 28,
   16, 8 and 1 blocks, out of the 165 triplets of the 11 sectors. Checked below by
   enumerating all triplets.
3. **The escape pod (Beth, Round 12 🤟💎).** "There will be no permanent death in
   my game or punishment for choosing the escape pod." A small state model shows
   that no event ever removes gold-locked progress and that choosing the pod only
   moves the player to safety.
4. **Union Wealth group scenario (Shakes' share).** The screenshot's group figures:
   1,000 people giving \$9,125 each is \$9,125,000, which is 18,250 awards of \$500.

These check written claims and arithmetic. They are not game code.
-/

@[expose] public section

namespace RoundTwelve

/-! ## 1. FieldCore: the steel ball always finds the hole -/

section SteelBall

variable {E : Type*} [NormedAddCommGroup E] [NormedSpace ℝ E]

/-- Radial projection onto the closed ball of radius `R` about `ψ₀`, exactly as in
`steel_ball_proof.py`: points inside the ball are kept, points outside are scaled
back to the sphere. -/
noncomputable def clipToBall (ψ₀ : E) (R : ℝ) (y : E) : E :=
  if ‖y - ψ₀‖ ≤ R then y else ψ₀ + (R / ‖y - ψ₀‖) • (y - ψ₀)

/-- One FieldCore step: a gradient step of size `η` on `F(x) = ½‖x - ψ₀‖²`
(whose gradient is `x - ψ₀`), then the radial projection onto the ball. -/
noncomputable def steelBallStep (ψ₀ : E) (η R : ℝ) (x : E) : E :=
  clipToBall ψ₀ R (x - η • (x - ψ₀))

/-- The projection never moves a point farther from the hole. -/
theorem clipToBall_dist_le (ψ₀ : E) {R : ℝ} (hR : 0 ≤ R) (y : E) :
    ‖clipToBall ψ₀ R y - ψ₀‖ ≤ ‖y - ψ₀‖ := by
  unfold clipToBall
  split_ifs with h
  · exact le_rfl
  · push_neg at h
    have hpos : 0 < ‖y - ψ₀‖ := lt_of_le_of_lt hR h
    rw [add_sub_cancel_left, norm_smul, Real.norm_eq_abs,
      abs_of_nonneg (div_nonneg hR hpos.le), div_mul_cancel₀ _ hpos.ne']
    exact h.le

/-- The projection always lands inside the ball. -/
theorem clipToBall_dist_le_radius (ψ₀ : E) {R : ℝ} (hR : 0 ≤ R) (y : E) :
    ‖clipToBall ψ₀ R y - ψ₀‖ ≤ R := by
  unfold clipToBall
  split_ifs with h
  · exact h
  · push_neg at h
    have hpos : 0 < ‖y - ψ₀‖ := lt_of_le_of_lt hR h
    rw [add_sub_cancel_left, norm_smul, Real.norm_eq_abs,
      abs_of_nonneg (div_nonneg hR hpos.le), div_mul_cancel₀ _ hpos.ne']

/-- The hole is a fixed point: a ball resting in the hole stays there. -/
theorem steelBallStep_ground (ψ₀ : E) (η : ℝ) {R : ℝ} (hR : 0 ≤ R) :
    steelBallStep ψ₀ η R ψ₀ = ψ₀ := by
  simp [steelBallStep, clipToBall, hR]

/-- **One step contracts the drift by `1 - η`**, with no error term, for every
step size `η ≤ 1` and every radius `R ≥ 0`, from any starting point. -/
theorem steelBallStep_contracts (ψ₀ : E) {η R : ℝ} (hη1 : η ≤ 1)
    (hR : 0 ≤ R) (x : E) :
    ‖steelBallStep ψ₀ η R x - ψ₀‖ ≤ (1 - η) * ‖x - ψ₀‖ := by
  have key : x - η • (x - ψ₀) - ψ₀ = (1 - η) • (x - ψ₀) := by
    rw [sub_smul, one_smul]; abel
  calc ‖steelBallStep ψ₀ η R x - ψ₀‖ ≤ ‖x - η • (x - ψ₀) - ψ₀‖ :=
        clipToBall_dist_le ψ₀ hR _
    _ = (1 - η) * ‖x - ψ₀‖ := by
        rw [key, norm_smul, Real.norm_eq_abs, abs_of_nonneg (by linarith)]

/-- **The README's bound** `d_k ≤ (1 - η)^k d_0`, for every number of steps `k`. -/
theorem steelBall_iterate_bound (ψ₀ : E) {η R : ℝ} (hη1 : η ≤ 1)
    (hR : 0 ≤ R) (x : E) (k : ℕ) :
    ‖(steelBallStep ψ₀ η R)^[k] x - ψ₀‖ ≤ (1 - η) ^ k * ‖x - ψ₀‖ := by
  induction k with
  | zero => simp
  | succ k ih =>
    rw [Function.iterate_succ_apply', pow_succ]
    calc ‖steelBallStep ψ₀ η R ((steelBallStep ψ₀ η R)^[k] x) - ψ₀‖
        ≤ (1 - η) * ‖(steelBallStep ψ₀ η R)^[k] x - ψ₀‖ :=
          steelBallStep_contracts ψ₀ hη1 hR _
      _ ≤ (1 - η) * ((1 - η) ^ k * ‖x - ψ₀‖) :=
          mul_le_mul_of_nonneg_left ih (by linarith)
      _ = (1 - η) ^ k * (1 - η) * ‖x - ψ₀‖ := by ring

/-- **Every drop finds the hole**: for `0 < η ≤ 1` the drift tends to `0` from
any starting point. -/
theorem steelBall_finds_hole (ψ₀ : E) {η R : ℝ} (hη0 : 0 < η) (hη1 : η ≤ 1)
    (hR : 0 ≤ R) (x : E) :
    Filter.Tendsto (fun k : ℕ => ‖(steelBallStep ψ₀ η R)^[k] x - ψ₀‖)
      Filter.atTop (nhds 0) := by
  have hgeo : Filter.Tendsto (fun k : ℕ => (1 - η) ^ k * ‖x - ψ₀‖)
      Filter.atTop (nhds 0) := by
    simpa using (tendsto_pow_atTop_nhds_zero_of_lt_one (by linarith : (0:ℝ) ≤ 1 - η)
      (by linarith : 1 - η < 1)).mul_const ‖x - ψ₀‖
  exact squeeze_zero (fun _ => norm_nonneg _)
    (steelBall_iterate_bound ψ₀ hη1 hR x) hgeo

end SteelBall

/-- **The step-size condition matters.** On the real line, with hole `0`,
radius `1` and step size `η = 3`, a ball dropped at `1` bounces between `1` and
`-1` forever: its drift stays `1` and never tends to `0`. -/
theorem steelBall_eta_three_never_settles :
    (∀ k : ℕ, ‖(steelBallStep (0 : ℝ) 3 1)^[k] 1 - 0‖ = 1) ∧
    ¬ Filter.Tendsto (fun k : ℕ => ‖(steelBallStep (0 : ℝ) 3 1)^[k] 1 - 0‖)
        Filter.atTop (nhds 0) := by
  have h1 : steelBallStep (0 : ℝ) 3 1 1 = -1 := by
    norm_num [steelBallStep, clipToBall]
  have h2 : steelBallStep (0 : ℝ) 3 1 (-1) = 1 := by
    norm_num [steelBallStep, clipToBall]
  have orbit : ∀ k : ℕ, (steelBallStep (0 : ℝ) 3 1)^[k] 1 = 1 ∨
      (steelBallStep (0 : ℝ) 3 1)^[k] 1 = -1 := by
    intro k
    induction k with
    | zero => simp
    | succ k ih =>
      rw [Function.iterate_succ_apply']
      rcases ih with h | h <;> rw [h]
      · exact Or.inr h1
      · exact Or.inl h2
  have hnorm : ∀ k : ℕ, ‖(steelBallStep (0 : ℝ) 3 1)^[k] 1 - 0‖ = 1 := by
    intro k
    rcases orbit k with h | h <;> rw [h] <;> norm_num
  refine ⟨hnorm, fun ht => ?_⟩
  simp only [hnorm] at ht
  exact one_ne_zero (tendsto_nhds_unique tendsto_const_nhds ht)

/-! ## 2. FieldSpace: the 165 triplets fall into the six classes -/

/-- The eleven FieldSpace sectors, numbered `E = 0`, `M = 1`, `S = 2`, and the
eight scalars `F, W, T, I, R, H, P, A = 3, …, 10`. -/
abbrev Sector := Fin 11

/-- The sector `E` (dynamical gravity). -/
def sectorE : Sector := 0

/-- The two gauge sectors `M` and `S`. -/
def gaugeSectors : Finset Sector := {1, 2}

/-- All triplets of distinct sectors. -/
def triplets : Finset (Finset Sector) := (Finset.univ : Finset Sector).powersetCard 3

/-- The triplets with a given gravity flag and a given number of gauge sectors. -/
def tripletClass (hasE : Bool) (gauges : ℕ) : Finset (Finset Sector) :=
  triplets.filter fun t => decide (sectorE ∈ t) = hasE ∧ (t ∩ gaugeSectors).card = gauges

/-- There are 165 triplets of the 11 sectors. -/
theorem fieldSpace_triplet_count : triplets.card = 165 := by
  simp [triplets, Finset.card_powersetCard]; rfl

/-- **The six classes of the master-action note, by counting:** 56 three-scalar
blocks, 56 one-gauge blocks, 28 gravity-plus-two-scalar blocks, 16
gravity-gauge-scalar blocks, 8 two-gauge-plus-scalar blocks and one E–M–S block.
They add up to all 165 triplets. -/
theorem fieldSpace_six_classes :
    (tripletClass false 0).card = 56 ∧ (tripletClass false 1).card = 56 ∧
    (tripletClass true 0).card = 28 ∧ (tripletClass true 1).card = 16 ∧
    (tripletClass false 2).card = 8 ∧ (tripletClass true 2).card = 1 ∧
    56 + 56 + 28 + 16 + 8 + 1 = triplets.card := by
  decide +kernel

/-! ## 3. The escape pod: no permanent death, no penalty for choosing the pod -/

/-- What the pod cares about in a player: progress already gold-locked by
meditation, progress still pending, and whether the player is in a safe zone. -/
structure Hero where
  locked : ℕ
  pending : ℕ
  inSafeZone : Bool
  deriving DecidableEq, Repr

/-- Things that can happen to a player. -/
inductive PodEvent
  /-- earn some progress out in the world -/
  | gain (n : ℕ)
  /-- meditate (only takes effect in a safe zone) -/
  | meditate
  /-- get knocked out: the pod picks the player up -/
  | knockedOut
  /-- choose the escape pod -/
  | choosePod
  deriving DecidableEq, Repr

/-- The escape-pod rule. Being knocked out and choosing the pod do the same
thing: the player is carried to safety and keeps everything. -/
def PodEvent.apply : PodEvent → Hero → Hero
  | .gain n, h => { h with pending := h.pending + n, inSafeZone := false }
  | .meditate, h =>
      if h.inSafeZone then { h with locked := h.locked + h.pending, pending := 0 } else h
  | .knockedOut, h => { h with inSafeZone := true }
  | .choosePod, h => { h with inSafeZone := true }

/-- Play a whole sequence of events. -/
def playEvents (es : List PodEvent) (h : Hero) : Hero :=
  es.foldl (fun h e => e.apply h) h

/-- **No punishment for choosing the pod:** it keeps all locked and pending
progress, and only moves the player to a safe zone. -/
theorem choosePod_no_penalty (h : Hero) :
    (PodEvent.choosePod.apply h).locked = h.locked ∧
    (PodEvent.choosePod.apply h).pending = h.pending ∧
    (PodEvent.choosePod.apply h).inSafeZone = true := by
  simp [PodEvent.apply]

/-- Choosing the pod is never worse than being knocked out: it is the same rescue. -/
theorem choosePod_eq_knockedOut (h : Hero) :
    PodEvent.choosePod.apply h = PodEvent.knockedOut.apply h := rfl

/-- One event never removes gold-locked progress. -/
theorem locked_le_apply (e : PodEvent) (h : Hero) : h.locked ≤ (e.apply h).locked := by
  cases e <;> simp only [PodEvent.apply] <;> try split_ifs
  all_goals simp

/-- **No permanent death:** whatever happens, in any order, gold-locked progress
is never lost. -/
theorem no_permanent_loss (es : List PodEvent) (h : Hero) :
    h.locked ≤ (playEvents es h).locked := by
  induction es generalizing h with
  | nil => simp [playEvents]
  | cons e es ih =>
    simp only [playEvents, List.foldl_cons] at ih ⊢
    exact (locked_le_apply e h).trans (ih _)

/-! ## 4. Union Wealth group scenario (screenshot in Shakes' share) -/

/-- 1,000 people each giving \$9,125 (that is \$1 a day for 25 years) make
\$9,125,000, which equals 18,250 family-support awards of \$500. -/
theorem unionWealth_group_figures :
    1000 * (365 * 25) = 9125000 ∧ 18250 * 500 = 9125000 := by norm_num

end RoundTwelve
