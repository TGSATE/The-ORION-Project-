module

public import Mathlib
public import RequestProject.RoundEleven.DeepCrawlEleven

/-!
# Round Eleven, annotation pass (page version 1201)

Small models of rules and proposals written on the ORION R11 page after the deep-crawl reply.
They are models of *written text*, not of a running game.

* **Poly and pod (designer's 💎).** "Everybody starts off with a pod with a Linguistic toroidal
  poly in it" and "the poly is the organism, the pod is its biosphere".  We model a pod as a
  container that may or may not house a poly; only the poly translates.
* **`1/(n+1)` for coders.** The same fraction names two different rules.
* **Shared Work ID** (Matthew's council readout, building on the cross-platform reply): one
  artifact shown on several platforms is credited once.
* **Handoff packet** (designer's token-limit idea, Matthew's proposed packet): the incoming
  council member receives the full state, but no authority.
* **Monster table rows** cited in Matthew's readout: arithmetic check of the two smallest
  nontrivial rows.
-/

@[expose] public section

namespace RoundElevenAnnotation

open RoundElevenDeepCrawl

/-! ### Poly (organism) and pod (biosphere) -/

/-- Kinds of poly. Only the linguistic kind is named so far. -/
inductive PolyKind where
  | linguistic
  | other
  deriving DecidableEq, Repr

/-- A pod is the poly's biosphere: it may house a poly, or be empty. -/
structure Pod where
  /-- the organism living in the pod, if any -/
  poly : Option PolyKind
  deriving DecidableEq, Repr

/-- The pod every player starts with: it houses a linguistic poly (designer's 💎). -/
def starterPod : Pod := ⟨some .linguistic⟩

/-- Translation is done by the organism: a pod translates only if it houses a linguistic poly. -/
def podTranslates (p : Pod) : Bool := p.poly == some .linguistic

/-- The translator state of a player wearing pod `p`, with gold-lock status `gold`. -/
def translatorOf (p : Pod) (gold : Bool) : Translator := ⟨podTranslates p, gold⟩

/-- Every player starts with a pod that houses a linguistic poly. -/
theorem starter_pod_houses_linguistic_poly : starterPod.poly = some .linguistic := rfl

/-- With the starter pod, ordinary foreign speech is understood from the first session
(assuming the starter pod is worn, as the designer's text implies). -/
theorem starter_pod_understands_ordinary (gold : Bool) :
    understands .ordinary (translatorOf starterPod gold) = true := by
  cases gold <;> decide

/-- An empty pod (a biosphere with no organism) translates nothing: without a gold-locked
skill, ordinary speech is garbled. -/
theorem empty_pod_garbles : understands .ordinary (translatorOf ⟨none⟩ false) = false := by
  decide

/-- Safety text stays clear whatever pod the player has. -/
theorem safety_clear_any_pod (p : Pod) (gold : Bool) :
    understands .safety (translatorOf p gold) = true :=
  safety_always_clear _

/-! ### `1/(n+1)`: two different rules behind one fraction -/

/-- Equal stake: `n+1` members each carry `1/(n+1)`, and the shares add up to exactly 1;
whereas the progenitor royalty chain `1/2 + 1/3 + 1/4` already pays out more than the sale. -/
theorem one_over_succ_two_meanings (n : ℕ) :
    (∑ _i : Fin (n + 1), (1 : ℚ) / (n + 1) = 1) ∧ (1 : ℚ) < 1 / 2 + 1 / 3 + 1 / 4 := by
  refine ⟨?_, by norm_num⟩
  simp
  field_simp

/-! ### Shared Work ID: one artifact, credited once -/

/-- A manifestation of an artifact on a platform (artifact ID, platform ID). -/
abbrev Manifestation := ℕ × ℕ

/-- Credited works: the number of *distinct* artifact IDs among the manifestations. -/
def credited (ms : Finset Manifestation) : ℕ := (ms.image Prod.fst).card

/-- Showing an already-credited artifact on another platform does not add credit. -/
theorem reuse_adds_no_credit (ms : Finset Manifestation) (a p : ℕ)
    (h : a ∈ ms.image Prod.fst) : credited (insert (a, p) ms) = credited ms := by
  unfold credited
  rw [Finset.image_insert, Finset.insert_eq_of_mem h]

/-- A genuinely new artifact adds exactly one credit, whichever platform it appears on. -/
theorem new_artifact_adds_one (ms : Finset Manifestation) (a p : ℕ)
    (h : a ∉ ms.image Prod.fst) : credited (insert (a, p) ms) = credited ms + 1 := by
  unfold credited
  rw [Finset.image_insert, Finset.card_insert_of_notMem h]

/-- Credit never exceeds the number of manifestations. -/
theorem credited_le_card (ms : Finset Manifestation) : credited ms ≤ ms.card :=
  Finset.card_image_le

/-- Worked example: one artifact used in Chronicles, Ascent and the community layer
(platforms 1, 2, 3) is one credited work, not three. -/
theorem triple_use_single_credit : credited {(7, 1), (7, 2), (7, 3)} = 1 := by decide

/-! ### Handoff packet: state transfers, authority does not -/

/-- What a council seat holds: the working state (any type) and whether it holds authority. -/
structure Seat (S : Type) where
  state : S
  authority : Bool

/-- The packet the outgoing member emits. -/
structure Packet (S : Type) where
  state : S

/-- Outgoing member packs its state. -/
def pack {S : Type} (s : Seat S) : Packet S := ⟨s.state⟩

/-- Incoming member loads the packet; authority must be granted separately. -/
def receive {S : Type} (p : Packet S) : Seat S := ⟨p.state, false⟩

/-- The incoming member picks up exactly where the outgoing one left off. -/
theorem handoff_preserves_state {S : Type} (s : Seat S) : (receive (pack s)).state = s.state :=
  rfl

/-- A handoff never transfers authority, even from a seat that held it. -/
theorem handoff_grants_no_authority {S : Type} (s : Seat S) :
    (receive (pack s)).authority = false := rfl

/-! ### Monster table rows cited in the council readout -/

/-- Row 1 of `irreps_sum.tsv`: the degree 196883 is `47 · 59 · 71`, exponent sum 3. -/
theorem monster_row1 : (196883 : ℕ) = 47 * 59 * 71 := by norm_num

/-- Row 2: the degree 21296876 is `2² · 31 · 41 · 59 · 71`, exponent sum 2+1+1+1+1 = 6. -/
theorem monster_row2 : (21296876 : ℕ) = 2 ^ 2 * 31 * 41 * 59 * 71 := by norm_num

end RoundElevenAnnotation
