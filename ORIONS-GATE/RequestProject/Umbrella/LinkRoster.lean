module

public import Mathlib

/-!
# Who links to whom (☂️1.6): the counting behind the link roster

Umbrella level ☂️1.6, 13 October 2026. Beth asked for a roster of "who all links together
and shares each other's posts". The links below were read from each account's **public**
X timeline through a public mirror (about the 20–66 most recent items per account, so
mostly 8–13 October 2026). A link `a → b` means that in that window `a` reposted, quoted,
replied to or tagged `b`; `repost = true` when at least one of those was a repost.

This file does **not** check the reading of X itself (that is a snapshot, written up in
`umbrella/WHO_LINKS_TO_WHOM.md`). It checks the counting done on that snapshot:

* exactly five pairs link **both ways** (`linksBothWays_iff`);
* Lucien (`@Master4lVl`) is linked to by more distinct roster accounts than anyone else:
  six, while every other account has at most five (`lucien_most_linked`);
* Lucien reposted eight different roster accounts in the window (`lucien_reposted_eight`);
* `@LeoDaVinciWave` (the earthquake-jar poster) has no link to or from the roster
  (`leo_isolated`).
-/

@[expose] public section

namespace Umbrella.LinkRoster

/-- The 22 public X accounts read for the ☂️1.6 link roster. -/
inductive Acct
  | missTris | architectWeaver | ashwinKalyandu2 | civilisationone | cosmosarcive
  | drLogvinovich | enuminous | introsp3ctor | irishgypsy288 | jcPerezCodex
  | justmebob123 | kamenikevan | leoDaVinciWave | luminariFlux | master4lVl
  | mcgeeShakes | museInmotion | planetaryS936 | tgsate62912 | theFarQueen
  | vasaMusk | yeobuzzfx
  deriving DecidableEq, Fintype, Repr

open Acct

/-- One observed link: `src` reposted, quoted, replied to or tagged `dst`. -/
structure Link where
  src : Acct
  dst : Acct
  repost : Bool
  deriving DecidableEq, Repr

/-- Every roster-to-roster link seen in the ☂️1.6 snapshot (counts in the comments). -/
def links : List Link := [
  ⟨architectWeaver, introsp3ctor, true⟩,   -- repost 1
  ⟨ashwinKalyandu2, master4lVl, false⟩,    -- tag 7
  ⟨ashwinKalyandu2, mcgeeShakes, true⟩,    -- repost 1
  ⟨civilisationone, master4lVl, true⟩,     -- repost 1
  ⟨civilisationone, planetaryS936, true⟩,  -- repost 3
  ⟨civilisationone, mcgeeShakes, true⟩,    -- repost 2
  ⟨jcPerezCodex, master4lVl, false⟩,       -- quote 1
  ⟨jcPerezCodex, drLogvinovich, true⟩,     -- tag 7, quote 3, repost 1
  ⟨luminariFlux, civilisationone, true⟩,   -- repost 2
  ⟨luminariFlux, planetaryS936, true⟩,     -- repost 1
  ⟨master4lVl, ashwinKalyandu2, true⟩,     -- repost 12
  ⟨master4lVl, jcPerezCodex, true⟩,        -- repost 3
  ⟨master4lVl, missTris, true⟩,            -- repost 3
  ⟨master4lVl, drLogvinovich, true⟩,       -- repost 1
  ⟨master4lVl, enuminous, true⟩,           -- repost 1
  ⟨master4lVl, introsp3ctor, true⟩,        -- repost 8
  ⟨master4lVl, museInmotion, true⟩,        -- repost 1
  ⟨master4lVl, tgsate62912, true⟩,         -- repost 2
  ⟨vasaMusk, master4lVl, true⟩,            -- tag 5, quote 1, repost 4
  ⟨vasaMusk, mcgeeShakes, false⟩,          -- tag 6
  ⟨vasaMusk, theFarQueen, false⟩,          -- tag 1
  ⟨missTris, tgsate62912, false⟩,          -- quote 1
  ⟨drLogvinovich, jcPerezCodex, true⟩,     -- tag 19, quote 2, repost 4
  ⟨enuminous, drLogvinovich, true⟩,        -- repost 1
  ⟨justmebob123, introsp3ctor, true⟩,      -- repost 1
  ⟨justmebob123, irishgypsy288, true⟩,     -- tag 1, repost 3
  ⟨kamenikevan, justmebob123, true⟩,       -- repost 7
  ⟨mcgeeShakes, introsp3ctor, true⟩,       -- repost 1
  ⟨tgsate62912, civilisationone, false⟩,   -- tag 12
  ⟨tgsate62912, master4lVl, true⟩,         -- tag 22, repost 1
  ⟨tgsate62912, missTris, true⟩,           -- tag 12, repost 2
  ⟨tgsate62912, enuminous, true⟩,          -- tag 22, repost 2
  ⟨tgsate62912, introsp3ctor, false⟩,      -- tag 4
  ⟨tgsate62912, justmebob123, true⟩,       -- tag 12, repost 1
  ⟨tgsate62912, yeobuzzfx, false⟩,         -- tag 10
  ⟨theFarQueen, civilisationone, true⟩,    -- repost 5
  ⟨theFarQueen, master4lVl, true⟩,         -- repost 2
  ⟨theFarQueen, planetaryS936, true⟩,      -- repost 1
  ⟨theFarQueen, missTris, true⟩,           -- repost 2
  ⟨theFarQueen, enuminous, true⟩,          -- repost 3
  ⟨theFarQueen, tgsate62912, true⟩,        -- repost 2
  ⟨yeobuzzfx, cosmosarcive, false⟩         -- quote 1
]

/-- `a` links to `b` in the snapshot. -/
def linked (a b : Acct) : Bool := links.any fun l => l.src == a && l.dst == b

/-- `a` reposted `b` at least once in the snapshot. -/
def reposted (a b : Acct) : Bool := links.any fun l => l.src == a && l.dst == b && l.repost

/-- `a` and `b` link to each other. -/
def linksBothWays (a b : Acct) : Bool := linked a b && linked b a

/-- How many different roster accounts link to `a`. -/
def inDegree (a : Acct) : ℕ := (Finset.univ.filter fun b => linked b a = true).card

/-- Exactly five pairs link both ways: Lucien with Ashwin, with Jean-Claude Perez and with
Beth; Perez with Dr Logvinovich; and Triss with Beth. -/
theorem linksBothWays_iff (a b : Acct) :
    linksBothWays a b = true ↔
      (a, b) ∈ [(ashwinKalyandu2, master4lVl), (master4lVl, ashwinKalyandu2),
                (jcPerezCodex, master4lVl), (master4lVl, jcPerezCodex),
                (jcPerezCodex, drLogvinovich), (drLogvinovich, jcPerezCodex),
                (master4lVl, tgsate62912), (tgsate62912, master4lVl),
                (missTris, tgsate62912), (tgsate62912, missTris)] := by
  revert a b
  decide

/-- Lucien is linked to by six different roster accounts, more than anyone else. -/
theorem lucien_most_linked :
    inDegree master4lVl = 6 ∧ ∀ a, a ≠ master4lVl → inDegree a ≤ 5 := by
  decide

/-- Lucien reposted eight different roster accounts in the window. -/
theorem lucien_reposted_eight :
    (Finset.univ.filter fun b => reposted master4lVl b = true).card = 8 := by
  decide

/-- The earthquake-jar poster has no link to or from anyone on the roster. -/
theorem leo_isolated (a : Acct) :
    linked leoDaVinciWave a = false ∧ linked a leoDaVinciWave = false := by
  revert a
  decide

end Umbrella.LinkRoster
