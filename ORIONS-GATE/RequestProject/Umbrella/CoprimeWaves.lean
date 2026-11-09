module

public import Mathlib
public import RequestProject.Umbrella.CoprimeCodec

/-!
# Coprimes as waves, and encryption as a compressor (☂️1.9, Chapter 2)

Loggie wrote: "I'm modeling coprimes as multi dimensional waves. My system is using encryption as
a compressor by mapping data to residue values in a combinatorial structure."

His code was not available, so this file checks the general math his description rests on.
Nothing here is about his program's code.

* **Residues are waves.** `n % m` repeats with period `m`, like a wave's phase. Several moduli
  together give a wave on a grid (a discrete torus). The joint wave repeats after `lcm m k`
  steps (`joint_wave_repeats`). It covers the whole `m × k` grid before repeating exactly when
  `m` and `k` are coprime (`full_period_iff_coprime`). Otherwise two different inputs land on the
  same point (`non_coprime_wave_collides`).
* **The grid is exactly as big as the number range.** `d` moduli give `∏ mᵢ` grid points
  (`residue_space_size`). So the map loses nothing, but the grid has no spare room to save in.
* **Storing residues never takes fewer bits.** Bits for the residues ≥ bits for the original
  number (`residue_bits_no_saving`). With 3 and 5 it costs one extra bit (`three_five_costs_a_bit`).
* **A cipher doesn't change the count.** A cipher is a one-to-one scramble of the inputs. Running
  one before a lossless codec still leaves some input with a code at least as long as the input
  (`cipher_then_codec_no_universal_saving`).
* **Where real savings come from.** If the data can only be one of `N` known possibilities,
  numbering them uses about `log₂ N` bits (`enumerative_code`). The saving comes from knowing the
  data is restricted. Coprimality and encryption don't create it.
-/

@[expose] public section

namespace Umbrella.CoprimeWaves

/-- The joint residue wave repeats after `lcm m k` steps. -/
theorem joint_wave_repeats (m k n : ℕ) :
    (n + Nat.lcm m k) % m = n % m ∧ (n + Nat.lcm m k) % k = n % k := by
  constructor
  · obtain ⟨c, hc⟩ := Nat.dvd_lcm_left m k
    rw [hc, Nat.add_mul_mod_self_left]
  · obtain ⟨c, hc⟩ := Nat.dvd_lcm_right m k
    rw [hc, Nat.add_mul_mod_self_left]

/-- The joint wave's period `lcm m k` is the full grid size `m * k` exactly when `m` and `k`
are coprime. -/
theorem full_period_iff_coprime {m k : ℕ} (hm : 0 < m) (hk : 0 < k) :
    Nat.lcm m k = m * k ↔ Nat.Coprime m k := by
  constructor
  · intro h
    have h1 := Nat.gcd_mul_lcm m k
    rw [h] at h1
    have hpos : 0 < m * k := Nat.mul_pos hm hk
    have : Nat.gcd m k * (m * k) = 1 * (m * k) := by rw [h1, one_mul]
    exact Nat.eq_of_mul_eq_mul_right hpos this
  · exact Nat.Coprime.lcm_eq_mul

/-- If `m` and `k` share a factor, two different numbers below `m * k` give the same residues,
so the wave closes early and some grid points are never reached. -/
theorem non_coprime_wave_collides {m k : ℕ} (hm : 0 < m) (hk : 0 < k)
    (h : ¬ Nat.Coprime m k) :
    ∃ x < m * k, ∃ y < m * k, x ≠ y ∧ x % m = y % m ∧ x % k = y % k := by
  have hl : 0 < Nat.lcm m k := Nat.lcm_pos hm hk
  have hle : Nat.lcm m k ≤ m * k := Nat.le_of_dvd (Nat.mul_pos hm hk) (Nat.lcm_dvd_mul m k)
  have hne : Nat.lcm m k ≠ m * k := fun he => h ((full_period_iff_coprime hm hk).mp he)
  obtain ⟨h1, h2⟩ := joint_wave_repeats m k 0
  simp only [zero_add] at h1 h2
  exact ⟨0, Nat.mul_pos hm hk, Nat.lcm m k, lt_of_le_of_ne hle hne, hl.ne, h1.symm, h2.symm⟩

/-- With `d` moduli the residue grid has exactly `∏ mᵢ` points: no more room than the range
of numbers it encodes. -/
theorem residue_space_size (d : ℕ) (m : Fin d → ℕ) :
    Fintype.card ((i : Fin d) → Fin (m i)) = ∏ i, m i := by
  simp

/-- Storing the two residues separately never takes fewer bits than storing the number:
`⌈log₂ (m k)⌉ ≤ ⌈log₂ m⌉ + ⌈log₂ k⌉`. -/
theorem residue_bits_no_saving (m k : ℕ) :
    Nat.clog 2 (m * k) ≤ Nat.clog 2 m + Nat.clog 2 k := by
  apply Nat.clog_le_of_le_pow
  rw [pow_add]
  exact Nat.mul_le_mul (Nat.le_pow_clog (by norm_num) m) (Nat.le_pow_clog (by norm_num) k)

/-- Example: numbers below 15 fit in 4 bits, but their residues mod 3 and mod 5 need 2 + 3 = 5
bits. With 5 and 7 it's a tie: 6 bits either way. -/
theorem three_five_costs_a_bit :
    Nat.clog 2 15 = 4 ∧ Nat.clog 2 3 + Nat.clog 2 5 = 5 ∧
      Nat.clog 2 35 = 6 ∧ Nat.clog 2 5 + Nat.clog 2 7 = 6 := by
  decide

/-- A cipher (any one-to-one scramble of `k`-bit blocks) followed by a lossless codec still
gives some input a code at least `k` bits long. Encryption doesn't open up any extra room. -/
theorem cipher_then_codec_no_universal_saving (k : ℕ)
    (cipher : (Fin k → Bool) ≃ (Fin k → Bool))
    (encode : (Fin k → Bool) → List Bool) (lossless : Function.Injective encode) :
    ∃ input, k ≤ (encode (cipher input)).length :=
  CoprimeCodec.no_lossless_codec_shrinks_everything k (encode ∘ cipher)
    (lossless.comp cipher.injective)

/-- Where real savings come from: if the data is known to be one of the `N` items of a set `S`,
numbering those items is lossless and uses only the numbers below `N`. That takes about
`log₂ N` bits, however large the items themselves are. -/
noncomputable def enumerative_code {α : Type*} (S : Finset α) : S ≃ Fin S.card :=
  S.equivFin

end Umbrella.CoprimeWaves
