module

public import Mathlib

/-!
# The Universal Engine: answering its own open questions

*Linguistic Topology and the Mechanics of the Universal Engine* (tgsate.com, Volume III) lists
"Open Research Inquiries for Falsifiability". *The Gibbs-Toroidal Transmutation Engine* and
*The ORION Engine Architecture* add a mod-9 prime lattice and an eleven-phase loop. Earlier
rounds checked the raw counts (`Friction.latin62_eq_dodecahedron`,
`Friction.tesla_cipher_digital_root`, `Friction.framework_constants_cover_alphabet_sizes`).
This file goes one level deeper and answers the questions the pages actually ask.

These are Level B results (mathematics) only. None of them supports or refutes a Level C or D
reading.

1. **×6 cipher.** What does it keep, and what happens under modular reduction?
2. **5:2 core.** Is "ten anchors = 5 × 2" a real decomposition?
3. **The map `f` from 60 flat corners to 20 vertices.** What exactly is it?
4. **Greek 24 → cube.** Does the count 24 single out the cube?
5. **"What happens to a language whose count does not fit?"**
6. **3 → 6 → 9 and the mod-9 prime lattice.**
7. **Uppercase / lowercase operators U and L.**
8. **The ORION eleven-phase loop and its human gate.**
-/

@[expose] public section

namespace Engine

/-! ## 1. The ×6 ("Sumerian") cipher -/

/-- The ×6 cipher: the `n`-th letter is worth `6 n` (A = 6, B = 12, …, G = 42). -/
def cipher6 (n : ℕ) : ℕ := 6 * n

/-- The value of a word under the ×6 cipher is exactly 6 times its plain A = 1 value. -/
theorem cipher6_word (w : List ℕ) : (w.map cipher6).sum = 6 * w.sum := by
  unfold cipher6
  simpa using List.sum_map_mul_left w id 6

/-- **What the ×6 cipher keeps.** Two words get equal ×6 values exactly when they get equal
plain (A = 1) values, and they are ordered the same way. So the multiplier 6 adds no
information: every word comparison is the same as with A = 1. -/
theorem cipher6_same_comparisons (v w : List ℕ) :
    ((v.map cipher6).sum = (w.map cipher6).sum ↔ v.sum = w.sum) ∧
    ((v.map cipher6).sum ≤ (w.map cipher6).sum ↔ v.sum ≤ w.sum) := by
  rw [cipher6_word, cipher6_word]
  omega

/-- The digital root (repeat digit sums until one digit is left; 0 stays 0). -/
def digitalRoot (m : ℕ) : ℕ := if m = 0 then 0 else 1 + (m - 1) % 9

/-- The digital root keeps the remainder mod 9. -/
theorem digitalRoot_modEq (m : ℕ) : digitalRoot m % 9 = m % 9 := by
  unfold digitalRoot
  split_ifs <;> omega

/-- **What survives modular reduction mod 9.** The digital root of a ×6 value depends only on
the letter's position mod 3: positions 1, 4, 7, … give 6; positions 2, 5, 8, … give 3;
positions 3, 6, 9, … give 9. -/
theorem digitalRoot_cipher6 (n : ℕ) (hn : 0 < n) :
    digitalRoot (cipher6 n) = if n % 3 = 1 then 6 else if n % 3 = 2 then 3 else 9 := by
  unfold digitalRoot cipher6
  split_ifs <;> omega

/-- So the 26 letters fall into three families: 9 letters with root 6, 9 with root 3 and
8 with root 9. -/
theorem cipher6_letter_families :
    ((List.range' 1 26).filter (fun n => digitalRoot (cipher6 n) = 6)).length = 9 ∧
    ((List.range' 1 26).filter (fun n => digitalRoot (cipher6 n) = 3)).length = 9 ∧
    ((List.range' 1 26).filter (fun n => digitalRoot (cipher6 n) = 9)).length = 8 := by
  decide

/-- **Mod 26 (wrapping around the alphabet), ×6 loses letters.** Multiplying by 6 mod 26
reaches only 13 of the 26 residues, so it sends two letters to each value it reaches. -/
theorem cipher6_mod26_halves :
    ((Finset.range 26).image (fun x => 6 * x % 26)).card = 13 := by
  decide

/-- **Why not 6.** A multiplier `k` gives a one-to-one cipher mod 26 exactly when `k` shares no
factor with 26. That means `k` is odd and not 13. 6 is even, so it fails. Multipliers 5 or 7
would work. -/
theorem multiplier_lossless_iff (k : ℕ) (hk : k < 26) :
    ((Finset.range 26).image (fun x => k * x % 26)).card = 26 ↔ Nat.Coprime k 26 := by
  interval_cases k <;> decide

/-! ## 2. The 5:2 core is a genuine decomposition -/

/-- **Ten anchors = 5 × 2 is a Chinese-remainder split.** Each digit `0 … 9` is pinned down
exactly by its remainder mod 5 (one of five "aspects") and mod 2 (one of two "poles"), and every
(aspect, pole) pair occurs exactly once. This works because 5 and 2 share no factor. -/
theorem five_two_core :
    Function.Bijective (fun d : Fin 10 => ((⟨d.val % 5, by omega⟩ : Fin 5),
      (⟨d.val % 2, by omega⟩ : Fin 2))) := by
  decide

/-! ## 3. The compression map `f` : 60 flat corners → 20 vertices -/

/-- The twelve pentagonal faces of a regular dodecahedron, with the 20 vertices numbered
0–19. Each face is listed as its 5 corners in cyclic order. (Computed from the standard
coordinates `(±1, ±1, ±1)`, `(0, ±1/φ, ±φ)`, `(±1/φ, ±φ, 0)`, `(±φ, 0, ±1/φ)`.) -/
def dodecaFaceList : List (List ℕ) :=
  [[0, 8, 4, 15, 9], [0, 8, 14, 2, 10], [0, 9, 1, 13, 10], [1, 9, 15, 5, 11],
   [1, 11, 17, 3, 13], [2, 10, 13, 3, 12], [2, 12, 18, 6, 14], [3, 12, 18, 7, 17],
   [4, 8, 14, 6, 16], [4, 15, 5, 19, 16], [5, 11, 17, 7, 19], [6, 16, 19, 7, 18]]

/-- The vertex at corner `j` of face `i`. -/
def corner (c : Fin 12 × Fin 5) : Fin 20 :=
  ⟨((dodecaFaceList.getD c.1 []).getD c.2 0) % 20, Nat.mod_lt _ (by norm_num)⟩

/-- Each face has 5 different corners. -/
theorem faces_are_pentagons :
    ∀ i : Fin 12, ∀ j k : Fin 5, corner (i, j) = corner (i, k) → j = k := by
  decide

/-- The edges: consecutive corners of a face, stored as (smaller, larger). -/
def faceEdge (c : Fin 12 × Fin 5) : Fin 20 × Fin 20 :=
  let a := corner c
  let b := corner (c.1, c.2 + 1)
  if a ≤ b then (a, b) else (b, a)

/-- The faces glue up correctly: there are exactly 30 edges, and every edge is shared by exactly
two faces. -/
theorem dodeca_edges :
    (Finset.univ.image faceEdge).card = 30 ∧
    ∀ e ∈ Finset.univ.image faceEdge,
      (Finset.univ.filter (fun c => faceEdge c = e)).card = 2 := by
  decide +kernel

/-- **The map `f` is three-to-one.** When the 12 pentagons are folded up, each of the 20
vertices receives exactly 3 of the 60 flat corners. -/
theorem corner_fibers_three :
    ∀ v : Fin 20, (Finset.univ.filter (fun c => corner c = v)).card = 3 := by
  decide

/-- **An exact answer to "what operation `f` performs the compression".** The 60 flat corners
correspond one-to-one with pairs (vertex, one of 3 states), and this correspondence lies over
the folding map. So the "Trinity vertex" with three states is exactly the count of corners that
fold onto each vertex. The three states can be labelled in, out and closed, but the geometry
itself does not say which corner gets which label. -/
theorem corners_equiv_vertex_trinity :
    ∃ e : (Fin 12 × Fin 5) ≃ (Fin 20 × Fin 3), ∀ c, (e c).1 = corner c := by
  have hcard : ∀ v : Fin 20, Fintype.card {c // corner c = v} = 3 := by
    intro v
    rw [Fintype.card_subtype]
    exact corner_fibers_three v
  let e : (Fin 12 × Fin 5) ≃ (Fin 20 × Fin 3) :=
    (Equiv.sigmaFiberEquiv corner).symm.trans
      ((Equiv.sigmaCongrRight fun v => Fintype.equivFinOfCardEq (hcard v)).trans
        (Equiv.sigmaEquivProd _ _))
  refine ⟨e, fun c => ?_⟩
  rfl

/-! ## 4. Does the count 24 single out the cube? -/

/-- The determinant of a signed 3 × 3 permutation matrix, recorded as a permutation and three
signs. These matrices are exactly the symmetries shared by the cube `{±1}³` and the octahedron
`{±eᵢ}`. -/
def signedPermDet (p : Equiv.Perm (Fin 3) × (Fin 3 → Bool)) : ℤ :=
  (Equiv.Perm.sign p.1 : ℤ) * ∏ i, (if p.2 i then -1 else 1)

/-- There are 48 signed permutation matrices, and 24 of them have determinant `+1` (the
rotations). The cube and the octahedron have this same group, so "24 rotations" fits both. -/
theorem cube_octahedron_rotations :
    Fintype.card (Equiv.Perm (Fin 3) × (Fin 3 → Bool)) = 48 ∧
    (Finset.univ.filter (fun p => signedPermDet p = 1)).card = 24 := by
  decide

/-- The full symmetry group of a regular tetrahedron acts as all permutations of its 4 vertices,
and there are 24 of those. So 24 also fits the tetrahedron, counting reflections. -/
theorem tetrahedron_full_symmetries : Fintype.card (Equiv.Perm (Fin 4)) = 24 := by
  decide

/-! ## 5. A language whose count does not fit -/

/-- The constants the corpus already uses (as in
`Friction.framework_constants_cover_alphabet_sizes`). -/
def frameworkConstants : List ℕ := [1, 2, 3, 4, 5, 6, 8, 12, 20, 24, 30, 60, 144]

/-- `n` is one constant or the sum of two of them. -/
def fits2 (n : ℕ) : Bool :=
  frameworkConstants.contains n ||
    frameworkConstants.any (fun a => frameworkConstants.any (fun b => a + b == n))

/-- `n` fits with at most three constants. -/
def fits3 (n : ℕ) : Bool :=
  fits2 n || frameworkConstants.any (fun a => frameworkConstants.any
    (fun b => frameworkConstants.any (fun c => a + b + c == n)))

/-- **Exactly one size from 1 to 36 does not fit with two constants: 19.** So the "at most two
constants" rule really predicts something only for 19 (and then 37, 39, 41, …). -/
theorem only_nineteen_misfits : ∀ n ∈ List.range' 1 36, (fits2 n = true ↔ n ≠ 19) := by
  decide

/-- **With three constants, every size from 1 to 78 fits.** Allowing one more term makes the
rule unable to fail anywhere a real alphabet size could plausibly fall. -/
theorem everything_fits_with_three : ∀ n ∈ List.range' 1 78, fits3 n = true := by
  decide

/-- 79 is the first size that fits no sum of three or fewer constants. -/
theorem seventy_nine_misfits : fits3 79 = false := by decide

/-! ## 6. 3 → 6 → 9 and the mod-9 prime lattice -/

/-- **Doubling mod 9 splits the nine residues into three closed families.** 0 ("9") stays put,
3 and 6 swap, and 1 → 2 → 4 → 8 → 7 → 5 → 1 cycles through the other six. -/
theorem doubling_orbits :
    (2 * 0 % 9 = 0) ∧ (2 * 3 % 9 = 6) ∧ (2 * 6 % 9 = 3) ∧
    (List.range 7).map (fun k => 2 ^ k % 9) = [1, 2, 4, 8, 7, 5, 1] := by
  decide

/-- Doubling never reaches the 3-6-9 axis from 1: no power of 2 is a multiple of 3. -/
theorem pow_two_off_axis (k : ℕ) : 2 ^ k % 3 ≠ 0 := by
  intro h
  have h1 : 3 ∣ 2 ^ k := Nat.dvd_of_mod_eq_zero h
  have h2 := Nat.Prime.dvd_of_dvd_pow Nat.prime_three h1
  omega

/-- **The mod-9 prime claim is true.** A prime above 3 leaves remainder 1, 2, 4, 5, 7 or 8
mod 9. -/
theorem prime_mod_nine (p : ℕ) (hp : p.Prime) (h3 : 3 < p) :
    p % 9 = 1 ∨ p % 9 = 2 ∨ p % 9 = 4 ∨ p % 9 = 5 ∨ p % 9 = 7 ∨ p % 9 = 8 := by
  have h : ¬ 3 ∣ p := by
    intro hd
    have := (Nat.prime_dvd_prime_iff_eq Nat.prime_three hp).1 hd
    omega
  omega

/-- **The "two triangles 120° apart" are the remainders 1 and 2 mod 3.** On a 9-point circle,
{1, 4, 7} and {2, 5, 8} are the two shifted copies of the axis {0, 3, 6}. -/
theorem triangles_are_cosets :
    ∀ r : Fin 9, ((r.val % 3 = 1) ↔ r.val ∈ [1, 4, 7]) ∧
      ((r.val % 3 = 2) ↔ r.val ∈ [2, 5, 8]) := by
  decide

/-- **But the filter does not pick out primes.** Each of the six channels holds a prime and a
composite: 19, 11, 13, 5, 7, 17 against 55, 65, 49, 77, 25, 35. So it removes multiples of 3
and nothing else, and it cannot predict where the primes fall within the six channels. -/
theorem channels_hold_composites :
    [19, 11, 13, 5, 7, 17].map (· % 9) = [1, 2, 4, 5, 7, 8] ∧
    [55, 65, 49, 77, 25, 35].map (· % 9) = [1, 2, 4, 5, 7, 8] ∧
    (∀ p ∈ [19, 11, 13, 5, 7, 17], Nat.Prime p) ∧
    (∀ n ∈ [55, 65, 49, 77, 25, 35], ¬ Nat.Prime n) := by
  refine ⟨by decide, by decide, ?_, ?_⟩ <;> norm_num

/-! ## 7. The U and L operators on the 62-character set -/

/-- The computational Latin set: A–Z, a–z, 0–9. -/
def latin62 : List Char :=
  (List.range 26).map (fun i => Char.ofNat (65 + i)) ++
  (List.range 26).map (fun i => Char.ofNat (97 + i)) ++
  (List.range 10).map (fun i => Char.ofNat (48 + i))

/-- **Conical Duality as exact algebra.** On the 62 characters, U (to uppercase) and L (to
lowercase) are each idempotent; each absorbs the other (U ∘ L = U and L ∘ U = L); both fix the
10 digits; and each one collapses the 62 characters onto 36. So each operator drops exactly one
bit per letter (its case) and keeps everything else. -/
theorem conical_duality :
    latin62.length = 62 ∧ latin62.Nodup ∧
    latin62.all (fun c => c.toUpper.toUpper == c.toUpper && c.toLower.toLower == c.toLower &&
      c.toLower.toUpper == c.toUpper && c.toUpper.toLower == c.toLower) = true ∧
    latin62.all (fun c => !c.isDigit || (c.toUpper == c && c.toLower == c)) = true ∧
    (latin62.map Char.toUpper).dedup.length = 36 ∧
    (latin62.map Char.toLower).dedup.length = 36 := by
  decide +kernel

/-! ## 8. The ORION eleven-phase loop -/

/-- The eleven phases, in the published order. -/
inductive Phase
  | define | retrieve | evaluate | connect | generate | attack | refine
  | humanReview | test | record | reuse
  deriving DecidableEq, Repr

/-- The next phase in the loop (Reuse feeds back into Define). -/
def Phase.next : Phase → Phase
  | .define => .retrieve | .retrieve => .evaluate | .evaluate => .connect
  | .connect => .generate | .generate => .attack | .attack => .refine
  | .refine => .humanReview | .humanReview => .test | .test => .record
  | .record => .reuse | .reuse => .define

theorem Phase.next_iterate_eleven (p : Phase) : Phase.next^[11] p = p := by
  cases p <;> rfl

theorem Phase.next_iterate_mod (k : ℕ) (p : Phase) :
    Phase.next^[k] p = Phase.next^[k % 11] p := by
  conv_lhs => rw [← Nat.mod_add_div k 11]
  rw [Function.iterate_add_apply]
  congr 1
  induction k / 11 with
  | zero => rfl
  | succ m ih => rw [Nat.mul_succ, Function.iterate_add_apply, next_iterate_eleven, ih]

/-- **The human gate holds if the loop is followed.** Starting from a Generate step, every run
that reaches Record has passed through Human Review first. The step order guarantees this only
when no phase is skipped. A shortcut from Generate to Record would break it, so the guarantee
depends on enforcing the order, not on the loop's design alone. -/
theorem record_needs_review (k : ℕ) (hk : Phase.next^[k] .generate = .record) :
    ∃ j < k, Phase.next^[j] .generate = .humanReview := by
  rw [Phase.next_iterate_mod] at hk
  have h5 : k % 11 = 5 := by
    have hlt : k % 11 < 11 := Nat.mod_lt _ (by norm_num)
    interval_cases h : k % 11 <;> simp_all [Phase.next]
  exact ⟨3, by omega, rfl⟩

end Engine
