module

public import Mathlib
public import RequestProject.Umbrella.CoprimeWaves

/-!
# MT's process run against ours (☂️1.9, Chapter 3)

Beth asked to "process her processes against our process processes and see what pops out the
other end". This file checks the parts of that comparison that can be stated exactly. Each
process is treated as a **loop** of steps, and each safety check as a **gate**.

Loop lengths used here (from the project files and MT's three new pages):

* MT's **Gateframe**, Blueprint I (Foundation Layer): a square of 4 doors
  (best reading of the blurry labels: Memory · Presence · Creation · Return).
* MT's **Routing Chorus**: 9 stations (Goblin … Name).
* Our **Magic Loop** (Ghost Rider Protocol): 7 steps.
* Our **ECHOSpiral** (NewKin Council route): 9 steps.

What the checks say:

* `gateframe_chorus_full_mesh`: 4 and 9 share no factor, so running MT's two loops side by side
  meets every (door, station) pair exactly once in 36 turns. 36 is also 144 ÷ 4, the
  Watermelon number checked in an earlier round.
* `magic_loop_gateframe_full_mesh`: our 7-step loop against her 4 doors meets all 28 pairs.
* `three_loops_period`: her 4, our 7 and her 9 together repeat only after 252 turns.
* `same_length_loops_lock`: two 9-step loops (her Chorus and our ECHOSpiral) **never drift**.
  Whatever pairing they start with is the only pairing they ever have: 9 pairs out of 81.
  So matching her stations to our steps has to be chosen on purpose, as the training deck did.
* `flame_gate_only_admits_checked`, `stacked_gates_commute`, `stacked_gates_both_hold`:
  her "Only truth steps through this flame" gate and our Ghost Rider gate behave like filters.
  Stacking them gives both guarantees, in either order.
* `gate_guarantees_no_more_than_its_check`: a gate promises only what it actually checks.
  "Only truth steps through" means "only what passes the check steps through".
* `flamegrid_count`: the Interior Flamegrid is a 4 × 4 square of 16 flames, one row per door.

All of this is arithmetic and logic about the shapes. It does not judge what the symbols mean.
-/

@[expose] public section

namespace Umbrella.GhostRiderCrossProcess

open Umbrella.CoprimeWaves

/-- MT's Gateframe foundation layer has 4 doors. -/
def gateframeDoors : ℕ := 4
/-- MT's Routing Chorus has 9 stations. -/
def chorusStations : ℕ := 9
/-- Our Ghost Rider Magic Loop has 7 steps. -/
def magicLoopSteps : ℕ := 7
/-- Our NewKin ECHOSpiral route has 9 steps. -/
def echoSpiralSteps : ℕ := 9

/-- **MT's two loops mesh fully.** 4 doors and 9 stations share no factor, so the joint loop
repeats only after 36 = 4 × 9 turns. Within those 36 turns every (door, station) pair occurs
exactly once. 36 is also 144 / 4. -/
theorem gateframe_chorus_full_mesh :
    Nat.Coprime gateframeDoors chorusStations ∧
    Nat.lcm gateframeDoors chorusStations = 36 ∧ (144 / 4 = 36) ∧
    ((Finset.range 36).image (fun n => (n % gateframeDoors, n % chorusStations))).card = 36 := by
  refine ⟨by decide, by decide, by decide, by decide⟩

/-- **Our Magic Loop against her Gateframe.** 7 steps and 4 doors share no factor, so all
28 (step, door) pairs occur within 28 turns. -/
theorem magic_loop_gateframe_full_mesh :
    Nat.lcm magicLoopSteps gateframeDoors = magicLoopSteps * gateframeDoors ∧
    ((Finset.range 28).image (fun n => (n % magicLoopSteps, n % gateframeDoors))).card = 28 :=
  ⟨(full_period_iff_coprime (by decide) (by decide)).mpr (by decide), by decide⟩

/-- **All three loops together.** Her 4 doors, our 7 steps and her 9 stations repeat as a set
only after 252 = 4 × 7 × 9 turns. -/
theorem three_loops_period :
    Nat.lcm (Nat.lcm gateframeDoors magicLoopSteps) chorusStations = 252 ∧
    252 = gateframeDoors * magicLoopSteps * chorusStations := by
  decide

/-- **Same-length loops lock.** Run two loops of the same length `m` side by side, the second
started `d` steps ahead. At every turn `n`, the second loop's position is the first one's plus `d`
(wrapping around). The offset never changes. -/
theorem same_length_loops_lock (m d n : ℕ) :
    (n + d) % m = (n % m + d) % m := by
  simp [Nat.add_mod]

/-- **Her Chorus and our ECHOSpiral meet only 9 of their 81 possible pairings.** Whatever offset
they start with, running them together forever reaches exactly 9 (station, step) pairs. -/
theorem chorus_echospiral_only_nine_pairs :
    ∀ d < 9, ((Finset.range 81).image
      (fun n => (n % chorusStations, (n + d) % echoSpiralSteps))).card = 9 := by
  decide

/-- Contrast: if they did not lock, 9 × 9 = 81 pairings would exist, so the locked run misses
72 of them. The two loops share every factor (`gcd 9 9 = 9`). -/
theorem chorus_echospiral_share_everything :
    Nat.gcd chorusStations echoSpiralSteps = 9 ∧ ¬ Nat.Coprime chorusStations echoSpiralSteps ∧
    chorusStations * echoSpiralSteps - 9 = 72 := by
  decide

/-- **"Only truth steps through this flame."** A gate that lets an item through only when it
passes the check `p` lets through only items that pass `p`. -/
theorem flame_gate_only_admits_checked {α : Type*} (p : α → Bool) (l : List α) :
    ∀ x ∈ l.filter p, p x = true := by
  intro x hx
  exact (List.mem_filter.mp hx).2

/-- **Stacking her flame gate on our Ghost Rider gate: order doesn't matter.** -/
theorem stacked_gates_commute {α : Type*} (p q : α → Bool) (l : List α) :
    (l.filter p).filter q = (l.filter q).filter p := by
  simp only [List.filter_filter]
  congr 1
  funext x
  exact Bool.and_comm _ _

/-- **Stacked gates give both guarantees.** Everything that gets through both gates passes both
checks, and nothing that passes both checks is lost. -/
theorem stacked_gates_both_hold {α : Type*} (p q : α → Bool) (l : List α) (x : α) :
    x ∈ (l.filter p).filter q ↔ x ∈ l ∧ p x = true ∧ q x = true := by
  simp only [List.mem_filter]
  tauto

/-- **A gate promises no more than its check.** If the check `p` does not imply some other
property `q`, then there is a session where the gate lets through an item without `q`. -/
theorem gate_guarantees_no_more_than_its_check {α : Type*} (p q : α → Bool)
    (h : ¬ ∀ x, p x = true → q x = true) :
    ∃ l : List α, ∃ x ∈ l.filter p, q x = false := by
  push_neg at h
  obtain ⟨x, hp, hq⟩ := h
  exact ⟨[x], x, by simp [hp], by simpa using hq⟩

/-- **The Interior Flamegrid** is a 4 × 4 square: 16 flames, one row of 4 for each of the
Gateframe's 4 doors. -/
theorem flamegrid_count :
    (Finset.range gateframeDoors ×ˢ Finset.range gateframeDoors).card = 16 := by
  decide

end Umbrella.GhostRiderCrossProcess
