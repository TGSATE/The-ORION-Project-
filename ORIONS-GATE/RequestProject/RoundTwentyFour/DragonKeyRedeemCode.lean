module

public import Mathlib

/-!
# The dragon key as a redeem code (a model, not the game's code)

Beth's request: a secret emoji code that gives a player instant access to their dragon, without
the code itself sitting in the game's source.

The design checked here (see `CODERS_SECRET_KEY_EASTER_EGG_REQUEST.md`):

* the player logs in **normally** first; the code is typed into a hidden "redeem" box, it is
  **not** a shared login password;
* the server keeps only a **fingerprint** (`stored = fp code`) of the code, never the code;
* before fingerprinting, the invisible emoji "style" mark U+FE0F is removed, so phones that add
  it and phones that don't both work;
* a correct code adds a dragon to **the redeeming player's own account** and changes nothing
  else: no one's login, owner or other dragons.

`fp` is left abstract: in the real game it would be a slow password hash run on the server.
-/

@[expose] public section

namespace DragonKey

/-- Remove the invisible emoji presentation selector U+FE0F. -/
def stripStyle (s : String) : String := String.ofList (s.toList.filter (· ≠ '\uFE0F'))

/-- With and without the style marks, the public LMDTS icon reads the same after cleaning. -/
theorem stripStyle_icon : stripStyle "🪩♾️⏭️" = stripStyle "🪩♾⏭" := by decide

/-- One player account. `login` stands for whatever the normal sign-in data is. -/
structure Account where
  login : String
  hasDragon : Bool
deriving DecidableEq

/-- What the server holds: accounts, who already redeemed, and **only a fingerprint**. -/
structure Server where
  accounts : ℕ → Account
  redeemed : ℕ → Bool
  stored : ℕ

/-- `p` (already logged in) types `input` into the redeem box. -/
def redeem (fp : String → ℕ) (sv : Server) (p : ℕ) (input : String) : Server :=
  if fp (stripStyle input) = sv.stored ∧ sv.redeemed p = false then
    { sv with
      accounts := Function.update sv.accounts p { sv.accounts p with hasDragon := true }
      redeemed := Function.update sv.redeemed p true }
  else sv

/-- Redeeming never changes anyone's login, the redeeming player's included. -/
theorem redeem_login (fp : String → ℕ) (sv : Server) (p q : ℕ) (input : String) :
    ((redeem fp sv p input).accounts q).login = (sv.accounts q).login := by
  unfold redeem; split_ifs
  · by_cases h : q = p
    · subst h; simp
    · simp [Function.update_of_ne h]
  · rfl

/-- Nobody else's account changes at all. -/
theorem redeem_others (fp : String → ℕ) (sv : Server) (p q : ℕ) (input : String)
    (hq : q ≠ p) : (redeem fp sv p input).accounts q = sv.accounts q := by
  unfold redeem; split_ifs <;> simp [Function.update_of_ne hq]

/-- The fingerprint on the server is never changed by redeeming. -/
theorem redeem_stored (fp : String → ℕ) (sv : Server) (p : ℕ) (input : String) :
    (redeem fp sv p input).stored = sv.stored := by
  unfold redeem; split_ifs <;> rfl

/-- The right code (with or without style marks) gives a first-time player their dragon. -/
theorem redeem_grants (fp : String → ℕ) (code : String) (sv : Server) (p : ℕ)
    (hs : sv.stored = fp (stripStyle code)) (hnew : sv.redeemed p = false) (input : String)
    (hin : stripStyle input = stripStyle code) :
    ((redeem fp sv p input).accounts p).hasDragon = true := by
  unfold redeem; rw [if_pos ⟨by rw [hin, hs], hnew⟩]; simp

/-- A wrong code changes nothing. -/
theorem redeem_wrong (fp : String → ℕ) (sv : Server) (p : ℕ) (input : String)
    (hw : fp (stripStyle input) ≠ sv.stored) : redeem fp sv p input = sv := by
  unfold redeem; rw [if_neg (fun h => hw h.1)]

/-- Each player can redeem once: after a successful redeem, any further try changes nothing. -/
theorem redeem_once (fp : String → ℕ) (sv : Server) (p : ℕ) (a b : String)
    (hok : fp (stripStyle a) = sv.stored ∧ sv.redeemed p = false) :
    redeem fp (redeem fp sv p a) p b = redeem fp sv p a := by
  unfold redeem
  simp only [if_pos hok, Function.update_self, Bool.true_eq_false, and_false, if_false]

/-- Changing the secret means replacing one number on the server: the code stays out of the
source, and a leaked code is retired by swapping `stored`. After the swap the old code fails
(as long as the two fingerprints differ). -/
theorem old_code_retired (fp : String → ℕ) (sv : Server) (p : ℕ) (old new : String)
    (hdiff : fp (stripStyle old) ≠ fp (stripStyle new)) :
    redeem fp { sv with stored := fp (stripStyle new) } p old =
      { sv with stored := fp (stripStyle new) } :=
  redeem_wrong fp _ p old hdiff

/-- Per-person codes with a block list: a blocked account's attempt is ignored before the code is
even checked, and the code a person uses is the one issued to them (`fpOf p`). -/
def redeemFor (blocked : ℕ → Bool) (fpOf : ℕ → String → ℕ) (sv : Server) (p : ℕ)
    (input : String) : Server :=
  if blocked p then sv else redeem (fpOf p) sv p input

/-- A blocked account gets nothing, whatever it types, even a correct code. -/
theorem blocked_gets_nothing (blocked : ℕ → Bool) (fpOf : ℕ → String → ℕ) (sv : Server)
    (p : ℕ) (input : String) (hb : blocked p = true) :
    redeemFor blocked fpOf sv p input = sv := by
  simp [redeemFor, hb]

/-- Lifting the block takes only flipping that one account's entry; nothing else is touched. -/
theorem unblocked_is_normal (blocked : ℕ → Bool) (fpOf : ℕ → String → ℕ) (sv : Server)
    (p : ℕ) (input : String) (hb : blocked p = false) :
    redeemFor blocked fpOf sv p input = redeem (fpOf p) sv p input := by
  simp [redeemFor, hb]

end DragonKey
