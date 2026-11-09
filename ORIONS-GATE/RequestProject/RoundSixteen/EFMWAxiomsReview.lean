import RequestProject.RoundSixteen.EFMWAxiomsUpstream

/-!
# Round 16: a practice review of Matthew's `EFMW-Axioms` repository

`EFMWAxiomsUpstream.lean` (next to this file) is an unmodified copy of
`EFMWAxioms/Axioms.lean` from `github.com/enuminous/EFMW-Axioms`
(commit `a8119c4`, CC BY 4.0). It builds with this project's Lean and Mathlib versions.

This file adds three facts about those twelve formal assumptions:

* they can all hold at the same time (the package `EFMWAxiomSystem` has an example), so the
  assumptions do not contradict one another;
* the scale-invariance assumption (A4) forces the "strength" to be one constant on all positive
  inputs and one constant on all negative inputs;
* the causal-entanglement assumption (A6) forces the relation to be the "always true" relation,
  so it carries no information about which points are related.

As the repository itself says, none of this says anything about nature.
-/

namespace RoundSixteen.EFMWReview

open EFMWAxioms

/-- The twelve EFMW surrogates are jointly satisfiable: here is one model of all of them
(constant functions, a nonzero limiting rotation of `1`, period `1`, identity feedback step). -/
theorem efmw_axiom_system_consistent : Nonempty EFMWAxiomSystem :=
  ⟨{ a1 := { omega := fun _ => 1, omegaInf := 1, converges := tendsto_const_nhds,
             nonzero := one_ne_zero }
     a2 := { trajectory := fun _ => 0, radius := 0, radius_nonneg := le_rfl,
             bounded := fun _ => by simp }
     a3 := { information := fun _ => 0, conserved := fun _ => rfl }
     a4 := { strength := fun _ => 0, invariant := fun _ _ _ => rfl }
     a5 := { coupling := fun _ _ => 0, reciprocal := fun _ _ => rfl }
     a6 := { entangled := fun _ _ => True, universal := fun _ _ => trivial }
     c7 := { curvature := fun _ => 0, quantumGenerator := fun _ => 0, kappa := 0,
             law := fun _ => by simp }
     c8 := { potential := fun _ => 0, mass := fun _ => 0,
             emergence := fun _ => hasDerivAt_const _ _ }
     c9 := { deltaT := fun _ => 0, lowerBound := fun _ => 0, bound_nonneg := fun _ => le_rfl,
             uncertainty := fun _ => le_rfl }
     c10 := { inside := fun _ => 0, outside := fun _ => 0, horizon := 0, interface_match := rfl }
     c11 := { rho := fun _ => 0, period := 1, period_pos := one_pos, periodic := fun _ => rfl }
     c12 := { step := id, admissible := Set.univ, closed := fun _ _ => trivial } }⟩

/-- A4 forces the strength to be constant on the positive numbers. -/
theorem scale_invariant_const_on_pos (h : ScaleInvariantQuantumGravity) {x : ℝ} (hx : 0 < x) :
    h.strength x = h.strength 1 := by
  simpa using h.invariant x 1 hx

/-- A4 forces the strength to be constant on the negative numbers. -/
theorem scale_invariant_const_on_neg (h : ScaleInvariantQuantumGravity) {x : ℝ} (hx : x < 0) :
    h.strength x = h.strength (-1) := by
  simpa using h.invariant (-x) (-1) (neg_pos.mpr hx)

/-- A6 forces the entanglement relation to be the relation that holds between every pair. -/
theorem causal_entanglement_is_trivial {Point : Type*} (h : CausalEntanglement Point) :
    h.entangled = fun _ _ => True := by
  funext p q
  exact propext ⟨fun _ => trivial, fun _ => h.universal p q⟩

end RoundSixteen.EFMWReview
