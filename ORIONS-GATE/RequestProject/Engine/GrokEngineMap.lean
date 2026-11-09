module

public import Mathlib
public import RequestProject.Engine.OpenInquiries

/-!
# The nine engines on Grok's map: what the mathematics underneath actually does

Beth's Grok readout lists nine engines on tgsate.com: the Nested Tri-Torus, the Avatar Engine
(1:5:1 + 3:1:3), J = 3 resonance, the Watermelon Equation, Tri-Sphere gears, the ORION Engine,
the Ghost Rider Protocol, the biological mirror engines and the 13 Levels. For each one, this
file proves the exact mathematical fact closest to what the page describes. Each result is
mathematics only (the corpus's Level B), not evidence for a physical or metaphysical reading.

The ORION Engine's human gate is `Engine.record_needs_review` in `OpenInquiries.lean`.
-/

@[expose] public section

namespace Engine

/-! ## 1. Nested Tri-Torus: the 120-point boundary is the dodecahedron's 120 flags -/

/-- A flag of the dodecahedron: a vertex, an edge through it and a face containing that edge.
Corner `c` of a face, together with a choice of one of its two face edges, gives a flag. -/
def flag (x : (Fin 12 × Fin 5) × Bool) : Fin 20 × (Fin 20 × Fin 20) × Fin 12 :=
  (corner x.1, (if x.2 then faceEdge x.1 else faceEdge (x.1.1, x.1.2 - 1)), x.1.1)

/-- **60 × 2 = 120 as geometry.** The 60 flat corners, each taken with its 2 edges, give 120
different flags, and in each one the vertex really lies on the edge. A regular solid has exactly
as many symmetries (reflections included) as flags, so these 120 points are also the 120
symmetries of the dodecahedral skybox. (That last step is the standard textbook fact about
regular solids. It is not proved here.) -/
theorem boundary_120_flags :
    (Finset.univ.image flag).card = 120 ∧
    ∀ x, (flag x).1 = (flag x).2.1.1 ∨ (flag x).1 = (flag x).2.1.2 := by
  decide +kernel

/-- 120 is also the number of ways to reorder 5 things (here, the 5 equatorial vectors). -/
theorem five_factorial : Fintype.card (Equiv.Perm (Fin 5)) = 120 := by decide

/-! ## 2. Avatar Engine: 1:5:1 container versus 3:1:3 process -/

/-- Euler characteristic `V − E + F` of a surface listed by its triangles. -/
def eulerChar (faces : List (List ℕ)) : ℤ :=
  let verts := (faces.flatten).dedup
  let edges := (faces.flatMap (fun f => [(f[0]!, f[1]!), (f[1]!, f[2]!), (f[2]!, f[0]!)])).map
    (fun e => (min e.1 e.2, max e.1 e.2)) |>.dedup
  (verts.length : ℤ) - edges.length + faces.length

/-- The 1:5:1 Conical Diamond as a solid: north pole 0, equator 1–5, south pole 6. -/
def diamond151 : List (List ℕ) :=
  (List.range 5).map (fun i => [0, i + 1, (i + 1) % 5 + 1]) ++
  (List.range 5).map (fun i => [6, i + 1, (i + 1) % 5 + 1])

/-- The 3:1:3 Dual Triangular Hourglass: two triangular pyramids meeting tip to tip at the
singularity 0, with bases {1, 2, 3} and {4, 5, 6}. -/
def hourglass313 : List (List ℕ) :=
  [[1, 2, 3], [0, 1, 2], [0, 2, 3], [0, 3, 1], [4, 5, 6], [0, 4, 5], [0, 5, 6], [0, 6, 4]]

/-- **Same 7 points, different shapes.** The 1:5:1 container has 7 vertices, 15 edges and
**10 faces** (the ten anchors again) and Euler characteristic 2: one closed shell, like a sphere.
The 3:1:3 hourglass has 7 vertices, 12 edges and 8 faces, with Euler characteristic **3**, which
is 2 + 2 − 1: two shells pinched together at the one shared point (0,0,0). So "both sum to 7"
hides a real topological difference between the container and the process. -/
theorem container_vs_process :
    (diamond151.flatten.dedup.length = 7 ∧ diamond151.length = 10 ∧ eulerChar diamond151 = 2) ∧
    (hourglass313.flatten.dedup.length = 7 ∧ hourglass313.length = 8 ∧
      eulerChar hourglass313 = 3) := by
  decide +kernel

/-! ## 3. J = 3 resonance: zero net torque -/

/-- **Balanced pulls cancel exactly.** `n ≥ 2` equal pulls spaced evenly around a circle add up
to zero. For `n = 3` these are the three pulls 120° apart (gather, hold, radiate). -/
theorem evenly_spaced_pulls_cancel (n : ℕ) (hn : 2 ≤ n) :
    ∑ k ∈ Finset.range n, (Complex.exp (2 * Real.pi * Complex.I / n)) ^ k = 0 :=
  (Complex.isPrimitiveRoot_exp n (by omega)).geom_sum_eq_zero (by omega)

/-- With only two pulls the balance is a straight push-pull: the second pull is exactly `−1`
times the first. So three is the smallest number that balances in a plane rather than along a
line. -/
theorem two_pulls_are_a_line : Complex.exp (2 * Real.pi * Complex.I / 2) = -1 := by
  rw [show (2 * Real.pi * Complex.I / 2 : ℂ) = Real.pi * Complex.I by ring]
  exact Complex.exp_pi_mul_I

/-! ## 4. Watermelon Equation: 144 → 000 -/

/-- **Where 144 really does become zeros.** In base 12, 144 is written `100`, so a two-dial
base-12 counter rolls over to `00` at exactly 144 steps. Mod 9, 144 is 0: its digit sum is
1 + 4 + 4 = 9. And 144 = 2⁴ · 3², which is why both happen. -/
theorem watermelon_rollover :
    Nat.digits 12 144 = [0, 0, 1] ∧ 144 % 144 = 0 ∧ 144 % 9 = 0 ∧ 1 + 4 + 4 = 9 ∧
    144 = 2 ^ 4 * 3 ^ 2 := by
  norm_num

/-! ## 5. Tri-Sphere gears -/

/-- **A ring of meshed gears turns only if it has an even number of gears.** Neighbouring
meshed gears must turn in opposite directions. Going once around a closed ring of `n` gears,
the direction flips `n` times, so it comes back consistent exactly when `n` is even. -/
theorem gear_ring_turns_iff_even (n : ℕ) :
    (∃ f : ℕ → Bool, (∀ i < n, f (i + 1) ≠ f i) ∧ f n = f 0) ↔ Even n := by
  constructor
  · rintro ⟨f, hstep, hclose⟩
    have bool_flip : ∀ a b c : Bool, a ≠ b → (a = c ↔ ¬ b = c) := by decide
    have key : ∀ i ≤ n, (f i = f 0 ↔ i % 2 = 0) := by
      intro i hi
      induction i with
      | zero => simp
      | succ m ih =>
        rw [bool_flip _ _ _ (hstep m (by omega)), ih (by omega)]
        omega
    exact Nat.even_iff.mpr ((key n le_rfl).mp hclose)
  · intro he
    refine ⟨fun i => decide (i % 2 = 1), fun i _ => ?_, ?_⟩
    · simp only [ne_eq, decide_eq_decide]
      omega
    · simp [Nat.even_iff.mp he]

/-- **Three spheres meshed in a flat ring would jam.** That is the odd case, `n = 3`. The pages
give Phase counterclockwise, Time clockwise and Space a Z-axis fluctuation: the third sphere
leaving the plane is exactly the way out of the jam. -/
theorem three_planar_gears_jam : ¬ ∃ f : ℕ → Bool, (∀ i < 3, f (i + 1) ≠ f i) ∧ f 3 = f 0 := by
  rw [gear_ring_turns_iff_even]
  decide

/-- The unit quaternion for a turn by angle `θ` about one axis. -/
noncomputable def turn (θ : ℝ) : Quaternion ℝ := ⟨Real.cos (θ / 2), Real.sin (θ / 2), 0, 0⟩

/-- **What "spin ½" needs from a gear model.** (The Plasma Substrate page asks for spin ½.) In
the standard description of rotations, a full 360° turn gives `−1`, not `1`, and only a 720° turn
gets back to `1`. -/
theorem spin_half_turns : turn (2 * Real.pi) = -1 ∧ turn (4 * Real.pi) = 1 := by
  refine ⟨?_, ?_⟩ <;> ext <;>
    simp [turn, show 2 * Real.pi / 2 = Real.pi by ring, show 4 * Real.pi / 2 = 2 * Real.pi by ring]

/-- Yet `q` and `−q` move every vector the same way. So a 360° turn looks like "back to start"
from the outside, while the hidden sign has flipped. -/
theorem sign_invisible_on_vectors (q v : Quaternion ℝ) : (-q) * v * star (-q) = q * v * star q := by
  simp [star_neg]

/-! ## 6. Ghost Rider governor -/

/-- **The governor guarantee, stated exactly.** If the gate releases an output only when it
passes the safety check `Safe`, then everything released over a whole session passes `Safe`.
The guarantee is exactly as strong as the check, and no stronger. -/
theorem governed_session_safe {In Out : Type*} (Safe : Out → Prop) (gate : In → Option Out)
    (hgate : ∀ x y, gate x = some y → Safe y) (session : List In) :
    ∀ y ∈ session.filterMap gate, Safe y := by
  intro y hy
  obtain ⟨x, -, hx⟩ := List.mem_filterMap.mp hy
  exact hgate x y hx

/-! ## 7. Biological mirror engines: 0.1 Hz breathing -/

/-- 0.1 Hz breathing is 6 breaths a minute, one every 10 seconds. -/
theorem resonance_breathing : (1 / 10 : ℚ) * 60 = 6 ∧ (1 : ℚ) / (1 / 10) = 10 := by norm_num

/-- **When heart and breath line up.** At 6 breaths a minute and a heart rate of `h` beats a
minute, a whole number of heartbeats fits in `k` breaths exactly when `6 / gcd(h, 6)` divides
`k`. At 60 bpm they line up every breath. At 64 bpm they line up only every 3 breaths
(30 seconds). Checked for every heart rate from 40 to 120 and up to 6 breaths. -/
theorem heart_breath_lock :
    ∀ h ∈ List.range' 40 81, ∀ k ∈ List.range' 1 6, (6 ∣ h * k ↔ 6 / Nat.gcd h 6 ∣ k) := by
  decide

/-! ## 8. The 13 Levels -/

/-- **Thirteen is prime, so no stride gets stuck.** Stepping through 13 levels by any fixed
stride from 1 to 12 (wrapping around) visits all 13 before repeating. -/
theorem thirteen_levels_every_stride_full :
    ∀ k ∈ List.range' 1 12, ((Finset.range 13).image (fun i => k * i % 13)).card = 13 := by
  decide

/-- With 12 levels it would fail: stride 2 visits only 6 levels, stride 3 only 4, stride 4
only 3 and stride 6 only 2. -/
theorem twelve_levels_get_stuck :
    ((Finset.range 12).image (fun i => 2 * i % 12)).card = 6 ∧
    ((Finset.range 12).image (fun i => 3 * i % 12)).card = 4 ∧
    ((Finset.range 12).image (fun i => 4 * i % 12)).card = 3 ∧
    ((Finset.range 12).image (fun i => 6 * i % 12)).card = 2 := by
  decide

end Engine
