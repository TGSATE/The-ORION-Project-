module

public import Mathlib

/-!
A small *proposed* model of the file-import safety rule in Beth's Round 15 notes.
This proves properties of the model, not of Google Docs, a phone, or a deployed app.
In particular, `verifiedCopy` is an explicit state flag, not a proof that any actual
upload or backup is recoverable. A real product would need to implement that check.
-/

namespace R15

/-- Minimal state for an imported attachment and its source file. -/
public structure AttachmentState where
  sourcePresent : Bool
  imported : Bool
  verifiedCopy : Bool
  deletionConfirmed : Bool
  deriving DecidableEq, Repr

/-- The source can be deleted only after a copy has been imported and verified, and the
user separately confirmed deletion. Merely attaching or sharing does not delete it. -/
@[expose] public def requestSourceDeletion (s : AttachmentState) : AttachmentState :=
  if s.imported && s.verifiedCopy && s.deletionConfirmed then
    { s with sourcePresent := false }
  else s

/-- The proposed deletion transition never removes a source without all three gates. -/
public theorem deletion_requires_verified_confirmed_copy (s : AttachmentState)
    (h : (requestSourceDeletion s).sourcePresent = false)
    (hsource : s.sourcePresent = true) :
    s.imported = true ∧ s.verifiedCopy = true ∧ s.deletionConfirmed = true := by
  cases s with
  | mk source imported verified confirmed =>
    cases source <;> cases imported <;> cases verified <;> cases confirmed <;>
      simp_all [requestSourceDeletion]

/-- Without verification or without explicit confirmation, the source stays put. -/
public theorem unverified_or_unconfirmed_keeps_source (s : AttachmentState)
    (hsource : s.sourcePresent = true)
    (h : s.verifiedCopy = false ∨ s.deletionConfirmed = false) :
    (requestSourceDeletion s).sourcePresent = true := by
  rcases h with hv | hc
  · simp [requestSourceDeletion, hv, hsource]
  · simp [requestSourceDeletion, hc, hsource]

/-- Deletion changes only the source-presence flag, retaining an audit record of
what was imported, checked, and confirmed. -/
public theorem deletion_keeps_audit_flags (s : AttachmentState) :
    (requestSourceDeletion s).imported = s.imported ∧
      (requestSourceDeletion s).verifiedCopy = s.verifiedCopy ∧
      (requestSourceDeletion s).deletionConfirmed = s.deletionConfirmed := by
  unfold requestSourceDeletion
  split <;> simp

end R15
