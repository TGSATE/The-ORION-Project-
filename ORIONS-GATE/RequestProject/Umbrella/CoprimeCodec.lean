module

public import Mathlib

/-!
# Coprime codec: what can and can't be checked (☂️1.8)

Umbrella level ☂️1.8, 13 October 2026. Beth's Grok readout describes her boss's "Thesis API",
which includes a file store with "a custom TCMP/coprime compression codec". Its source and docs
could not be read (no web access this round), so nothing here is about that program's code.

This file checks the two pieces of plain math that any "coprime" codec sits on:

* **Coprime splitting is lossless.** If `m` and `n` share no factor, a number below `m * n` is
  completely determined by its two remainders mod `m` and mod `n` (`coprime_split_injective`),
  and every pair of remainders comes from exactly one such number (`coprime_split_surjective`).
  This is the Chinese Remainder Theorem. It splits a number into smaller pieces without losing
  anything, but it does not by itself make the data smaller: the pieces together still carry
  `m * n` possibilities.
* **No lossless codec shrinks every file.** Any lossless (one-to-one) encoding of `k`-bit inputs
  as bit lists must give at least one input a code of length at least `k`
  (`no_lossless_codec_shrinks_everything`). This is the counting (pigeonhole) argument, and it
  holds for every compression scheme, coprime or not.
-/

@[expose] public section

namespace Umbrella.CoprimeCodec

/-- Splitting a number below `m * n` into its remainders mod `m` and mod `n` loses nothing
when `m` and `n` are coprime: two numbers with the same pair of remainders are equal. -/
theorem coprime_split_injective {m n : ℕ} (h : Nat.Coprime m n) {x y : ℕ}
    (hx : x < m * n) (hy : y < m * n) (hm : x % m = y % m) (hn : x % n = y % n) :
    x = y := by
  have h1 : x ≡ y [MOD m] := hm
  have h2 : x ≡ y [MOD n] := hn
  have h3 : x ≡ y [MOD m * n] := (Nat.modEq_and_modEq_iff_modEq_mul h).mp ⟨h1, h2⟩
  unfold Nat.ModEq at h3
  rwa [Nat.mod_eq_of_lt hx, Nat.mod_eq_of_lt hy] at h3

/-- Every pair of remainders `(a, b)` with `a < m`, `b < n` comes from some number below
`m * n`, when `m` and `n` are coprime (and positive). -/
theorem coprime_split_surjective {m n : ℕ} (h : Nat.Coprime m n) (hm0 : 0 < m) (hn0 : 0 < n)
    {a b : ℕ} (ha : a < m) (hb : b < n) :
    ∃ x < m * n, x % m = a ∧ x % n = b := by
  refine ⟨Nat.chineseRemainder h a b, Nat.chineseRemainder_lt_mul h a b hm0.ne' hn0.ne', ?_, ?_⟩
  · have := (Nat.chineseRemainder h a b).2.1
    unfold Nat.ModEq at this
    rw [this, Nat.mod_eq_of_lt ha]
  · have := (Nat.chineseRemainder h a b).2.2
    unfold Nat.ModEq at this
    rw [this, Nat.mod_eq_of_lt hb]

/-- All bit lists shorter than `k`. -/
def shortLists (k : ℕ) : Finset (List Bool) :=
  (Finset.range k).biUnion fun i =>
    (Finset.univ : Finset (List.Vector Bool i)).image Subtype.val

lemma mem_shortLists {k : ℕ} {l : List Bool} (hl : l.length < k) : l ∈ shortLists k := by
  simp only [shortLists, Finset.mem_biUnion, Finset.mem_range, Finset.mem_image,
    Finset.mem_univ, true_and]
  exact ⟨l.length, hl, ⟨l, rfl⟩, rfl⟩

lemma card_shortLists_lt (k : ℕ) : (shortLists k).card < 2 ^ k := by
  calc (shortLists k).card
      ≤ ∑ i ∈ Finset.range k,
          ((Finset.univ : Finset (List.Vector Bool i)).image Subtype.val).card :=
        Finset.card_biUnion_le
    _ ≤ ∑ i ∈ Finset.range k, 2 ^ i := by
        apply Finset.sum_le_sum
        intro i _
        refine (Finset.card_image_le).trans ?_
        exact (Finset.card_univ.trans (card_vector (α := Bool) i)).le
    _ < 2 ^ k := by
        have := Nat.geomSum_eq (le_refl 2) k
        simp only [Nat.add_one_sub_one, Nat.div_one] at this
        rw [this]
        exact Nat.sub_lt (Nat.two_pow_pos k) one_pos

/-- **No lossless codec shrinks every file.** If `encode` turns each `k`-bit input into a list
of bits and never sends two different inputs to the same list, then some input gets a code at
least `k` bits long. -/
theorem no_lossless_codec_shrinks_everything (k : ℕ)
    (encode : (Fin k → Bool) → List Bool) (lossless : Function.Injective encode) :
    ∃ input, k ≤ (encode input).length := by
  by_contra hcon
  push_neg at hcon
  have hmaps : ∀ x ∈ (Finset.univ : Finset (Fin k → Bool)), encode x ∈ shortLists k :=
    fun x _ => mem_shortLists (hcon x)
  have hle := Finset.card_le_card_of_injOn encode hmaps lossless.injOn
  simp only [Finset.card_univ, Fintype.card_fun, Fintype.card_bool, Fintype.card_fin] at hle
  exact absurd (card_shortLists_lt k) (not_lt.mpr hle)

end Umbrella.CoprimeCodec
