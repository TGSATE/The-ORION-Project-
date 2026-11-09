module
public import Mathlib

/-!
# Round 15: checking the mathematics printed in shared images

Beth asked for the equations and numbers inside the newly shared images to be
checked. This file checks the parts that are precise enough to state as mathematics.
It does **not** endorse any physical, medical or consciousness claim made around them.

* `introsp3ctor`'s "Finite Fields and Field Brackets" sheet: the bracket table,
  the primality of `196831`, the Frobenius orbit counts and the claim that a field
  `GF(1)` exists (it does not).
* Lucian's "Janus Infinite" card: the curvature formula `R = dω + ω ∧ ω`.
  For an ordinary (scalar) 1-form, `ω ∧ ω = 0`; the `ω ∧ ω` term only matters
  when `ω` takes values in non-commuting matrices.
* Lucian's "Vortex Cœur Humain" formula: `9³ = 729`, `13/260 = 1/20`, the sine
  factor repeats every 20 steps of `k`, `φⁿ` grows without bound for the golden
  ratio, and the factor `(1 + r_s/r)⁻¹` tends to `0` as `r → 0⁺`.
* Mike's "two monsters" note: a free product contains each factor as a subgroup,
  while a torsion-free group contains no non-trivial finite subgroup.
* The Round 15 album recount: `1333 + 51 = 1384`, of which `33 + 18 = 51`.
-/

namespace RoundFifteen

/-! ## 1. Finite fields and field brackets -/

/-- `196831` is prime, so `196830` is the order of the multiplicative group of
`GF(196831)`, as the sheet says. -/
public theorem prime_196831 : Nat.Prime 196831 := by norm_num

/-- The sheet's bracket table, as rows `(n, below, above)`. -/
public def bracketTable : List (ℕ × ℕ × ℕ) :=
  [(5, 4, 7), (9, 8, 11), (10, 9, 11), (15, 13, 16), (24, 23, 25),
   (27, 25, 29), (31, 29, 32), (80, 79, 81), (81, 79, 83), (144, 139, 149),
   (225, 223, 227), (243, 241, 251), (279, 277, 281), (729, 727, 733),
   (810, 809, 811), (196830, 196817, 196831)]

/-- Every row of the bracket table is right: `below < n < above`, both are prime
powers, and no prime power lies strictly between them except possibly `n` itself.
So `below` is the largest prime power below `n` and `above` the smallest above. -/
public theorem bracket_table_correct :
    ∀ row ∈ bracketTable,
      row.2.1 < row.1 ∧ row.1 < row.2.2 ∧
      IsPrimePow row.2.1 ∧ IsPrimePow row.2.2 ∧
      ∀ m ∈ Finset.Ioo row.2.1 row.2.2, m ≠ row.1 → ¬ IsPrimePow m := by
  native_decide

/-- The "self" column: exactly these rows have `n` itself a prime power. -/
public theorem bracket_self_column :
    bracketTable.filter (fun row => IsPrimePow row.1) =
      [(5, 4, 7), (9, 8, 11), (27, 25, 29), (31, 29, 32), (81, 79, 83),
       (243, 241, 251), (729, 727, 733)] := by
  native_decide

/-- The "mult" column: exactly these rows have `n + 1` a prime power, so that
`n` is the order of the multiplicative group of `GF(n + 1)`. -/
public theorem bracket_mult_column :
    (bracketTable.filter (fun row => IsPrimePow (row.1 + 1))).map Prod.fst =
      [10, 15, 24, 31, 80, 810, 196830] := by
  native_decide

/-- The Frobenius orbit counts used on the sheet, by Burnside's count
(fixed points of each power of Frobenius, averaged over the group). -/
public theorem frobenius_orbit_counts :
    (16 + 4) / 2 = 10 ∧ (25 + 5) / 2 = 15 ∧ (4 + 2) / 2 = 3 ∧ (9 + 3) / 2 = 6 ∧
    (81 + 3 + 9 + 3) / 4 = 24 ∧ (64 + 4 + 4) / 3 = 24 := by
  norm_num

/-- There is no field with one element: the sheet's last box `GF(1)` does not exist.
The subfield chain of `GF(16)` stops at `GF(2)`. -/
public theorem no_field_with_one_element (F : Type*) [Field F] [Fintype F] :
    Fintype.card F ≠ 1 :=
  Fintype.one_lt_card.ne'

/-! ## 2. The curvature formula on the Janus Infinite card -/

/-- The wedge of two scalar 1-forms, evaluated on two vectors. -/
public def wedge {V : Type*} (ω η : V → ℝ) (u v : V) : ℝ := ω u * η v - ω v * η u

/-- For a scalar 1-form, `ω ∧ ω = 0`, so `R = dω + ω ∧ ω` reduces to `R = dω`. -/
public theorem wedge_self_scalar {V : Type*} (ω : V → ℝ) (u v : V) :
    wedge ω ω u v = 0 := by
  unfold wedge
  ring

/-- For matrix-valued 1-forms the term need not vanish: `(ω ∧ ω)(u, v)` is the
commutator `ω(u) ω(v) - ω(v) ω(u)`, which is non-zero for these two matrices. -/
public theorem wedge_self_matrix_ne_zero :
    ∃ A B : Matrix (Fin 2) (Fin 2) ℝ, A * B - B * A ≠ 0 := by
  refine ⟨!![0, 1; 0, 0], !![0, 0; 1, 0], ?_⟩
  intro h
  have := congrFun (congrFun h 0) 0
  simp at this

/-! ## 3. The heart-vortex formula -/

public theorem nine_cubed : (9 : ℕ) ^ 3 = 729 := by norm_num

public theorem thirteen_over_260 : (13 : ℚ) / 260 = 1 / 20 := by norm_num

/-- The sine factor `sin(2π·13k/260)` repeats every 20 steps of `k`. -/
public theorem sine_factor_period (k : ℝ) :
    Real.sin (2 * Real.pi * 13 * (k + 20) / 260) =
      Real.sin (2 * Real.pi * 13 * k / 260) := by
  have : 2 * Real.pi * 13 * (k + 20) / 260 = 2 * Real.pi * 13 * k / 260 + 2 * Real.pi := by
    ring
  rw [this, Real.sin_add_two_pi]

/-- `φⁿ` grows without bound for the golden ratio, so `φ^∞` is not a number. -/
public theorem golden_pow_unbounded :
    Filter.Tendsto (fun n : ℕ => Real.goldenRatio ^ n) Filter.atTop Filter.atTop :=
  tendsto_pow_atTop_atTop_of_one_lt Real.one_lt_goldenRatio

/-- For `r_s > 0`, the factor `(1 + r_s/r)⁻¹` tends to `0` as `r → 0⁺`,
so the "flash point" right-hand side contains a factor `0`. -/
public theorem flash_factor_tendsto_zero (rs : ℝ) (hrs : 0 < rs) :
    Filter.Tendsto (fun r : ℝ => (1 + rs / r)⁻¹) (nhdsWithin 0 (Set.Ioi 0)) (nhds 0) := by
  have h1 : Filter.Tendsto (fun r : ℝ => rs / r) (nhdsWithin 0 (Set.Ioi 0)) Filter.atTop :=
    (Filter.Tendsto.const_mul_atTop hrs tendsto_inv_nhdsGT_zero).congr (fun r => by ring)
  have h2 : Filter.Tendsto (fun r : ℝ => 1 + rs / r) (nhdsWithin 0 (Set.Ioi 0)) Filter.atTop :=
    Filter.tendsto_atTop_add_const_left _ 1 h1
  exact h2.inv_tendsto_atTop

/-! ## 4. The two monsters -/

/-- A free product contains its first factor as a subgroup. -/
public theorem free_product_contains_factor (G H : Type*) [Group G] [Group H] :
    Function.Injective (Monoid.Coprod.inl : G →* Monoid.Coprod G H) :=
  Monoid.Coprod.inl_injective

/-- A torsion-free group (no non-identity element of finite order) contains no copy
of a non-trivial finite group. -/
public theorem no_finite_subgroup_in_torsion_free (G H : Type*) [Group G] [Group H]
    [Finite H] [Nontrivial H] (hG : ∀ g : G, g ≠ 1 → ¬ IsOfFinOrder g) (f : H →* G) :
    ¬ Function.Injective f := by
  intro hf
  obtain ⟨h, hh⟩ := exists_ne (1 : H)
  have hfin : IsOfFinOrder (f h) := MonoidHom.isOfFinOrder f (isOfFinOrder_of_finite h)
  have hne : f h ≠ 1 := fun e => hh (hf (by simpa using e))
  exact hG (f h) hne hfin

/-! ## 5. Album recount -/

public theorem album_recount : 1333 + 51 = 1384 ∧ 33 + 18 = 51 := by norm_num

end RoundFifteen
