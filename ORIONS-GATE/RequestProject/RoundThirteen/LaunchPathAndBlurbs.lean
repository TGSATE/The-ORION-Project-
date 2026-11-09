import Mathlib

/-!
# Round 13 checks: the launch path, the three energies, the UIAR safety gate and the X blurbs

These check written rules and text lengths from Beth's Round 13 document. They are not game code.
-/

namespace RoundThirteen

/-! ## The eight titles and the three energies -/

/-- Beth's eight titles, in her Round 13 order. -/
inductive Zone
  | engine | singularity | eldersGarden | playground | chronicles | ascent | gate | uiar
  deriving DecidableEq, Repr, Fintype

/-- The three kinetic energies. -/
inductive Energy
  | krion | kronos | orion
  deriving DecidableEq, Repr

/-- The five chaos elements. -/
inductive Element
  | earth | water | air | fire | lightning
  deriving DecidableEq, Repr, Fintype

/-- Beth's element mapping: Earth, Water and Air are KRION; Fire is Kronos; Lightning is Orion. -/
def Element.energy : Element → Energy
  | .earth => .krion | .water => .krion | .air => .krion
  | .fire => .kronos | .lightning => .orion

/-- The energy of each place that carries one (Beth's mapping for the five ports). -/
def Zone.energy : Zone → Option Energy
  | .eldersGarden => some .krion
  | .playground => some .krion
  | .gate => some .krion
  | .chronicles => some .kronos
  | .ascent => some .orion
  | _ => none

/-- Only the Ascent and the Chronicles bring a non-KRION energy. -/
theorem nonKrion_ports (z : Zone) (e : Energy) (h : z.energy = some e) (hne : e ≠ .krion) :
    z = .chronicles ∨ z = .ascent := by
  cases z <;> simp_all [Zone.energy]

/-- Each zone's energy matches its element: Garden = Earth, Playground = Water and Air,
Chronicles = Fire, Ascent = Lightning. -/
theorem zone_element_match :
    Zone.eldersGarden.energy = some Element.earth.energy ∧
    Zone.playground.energy = some Element.water.energy ∧
    Zone.playground.energy = some Element.air.energy ∧
    Zone.chronicles.energy = some Element.fire.energy ∧
    Zone.ascent.energy = some Element.lightning.energy := by
  decide

/-- 144 sums to 9 (1 + 4 + 4), as labelled on the UIAR art. -/
theorem digits_144_sum : (Nat.digits 10 144).sum = 9 := by norm_num

/-! ## The launch path -/

/-- A zone can be unlocked once one of its doors is open:
Engine → Singularity → Elder's Garden → Playground → (Ascent or Chronicles) → ORION's Gate. -/
def opensFrom : Zone → Zone → Prop
  | .singularity, p => p = .engine
  | .eldersGarden, p => p = .singularity
  | .playground, p => p = .eldersGarden
  | .chronicles, p => p = .playground
  | .ascent, p => p = .playground
  | .gate, p => p = .chronicles ∨ p = .ascent
  | _, _ => False

/-- The zones a player can have unlocked, starting from the Engine (the welcome page). -/
inductive Reachable : Set Zone → Prop
  | start : Reachable {Zone.engine}
  | unlock (S : Set Zone) (z p : Zone) : Reachable S → p ∈ S → opensFrom z p → Reachable (insert z S)

/-- The invariant: every unlocked zone's whole chain of doors is unlocked too. -/
def Closed (S : Set Zone) : Prop :=
  Zone.engine ∈ S ∧
  (Zone.singularity ∈ S → Zone.engine ∈ S) ∧
  (Zone.eldersGarden ∈ S → Zone.singularity ∈ S) ∧
  (Zone.playground ∈ S → Zone.eldersGarden ∈ S) ∧
  (Zone.chronicles ∈ S → Zone.playground ∈ S) ∧
  (Zone.ascent ∈ S → Zone.playground ∈ S) ∧
  (Zone.gate ∈ S → Zone.chronicles ∈ S ∨ Zone.ascent ∈ S)

theorem reachable_closed {S : Set Zone} (h : Reachable S) : Closed S := by
  induction h with
  | start => simp [Closed]
  | unlock S z p _ hp hop ih =>
    obtain ⟨h0, h1, h2, h3, h4, h5, h6⟩ := ih
    cases z <;> simp only [opensFrom] at hop <;>
      first
      | exact absurd hop id
      | (rcases hop with rfl | rfl <;>
          simp_all [Closed, Set.mem_insert_iff])

/-- Nobody reaches ORION's Gate without first passing through the Singularity,
Elder's Garden and the Playground. -/
theorem gate_needs_garden_and_playground {S : Set Zone} (h : Reachable S) (hg : Zone.gate ∈ S) :
    Zone.singularity ∈ S ∧ Zone.eldersGarden ∈ S ∧ Zone.playground ∈ S := by
  obtain ⟨_, _, h2, h3, h4, h5, h6⟩ := reachable_closed h
  have hp : Zone.playground ∈ S := by
    rcases h6 hg with hc | ha
    · exact h4 hc
    · exact h5 ha
  have he := h3 hp
  exact ⟨h2 he, he, hp⟩

/-- And the path is really open: the full launch sequence through the Ascent reaches the Gate. -/
theorem gate_reachable_via_ascent :
    Reachable {Zone.gate, Zone.ascent, Zone.playground, Zone.eldersGarden, Zone.singularity,
      Zone.engine} := by
  refine Reachable.unlock _ _ Zone.ascent ?_ (by simp) (by simp [opensFrom])
  refine Reachable.unlock _ _ Zone.playground ?_ (by simp) (by simp [opensFrom])
  refine Reachable.unlock _ _ Zone.eldersGarden ?_ (by simp) (by simp [opensFrom])
  refine Reachable.unlock _ _ Zone.singularity ?_ (by simp) (by simp [opensFrom])
  refine Reachable.unlock _ _ Zone.engine ?_ (by simp) (by simp [opensFrom])
  exact Reachable.start

/-! ## The UIAR immersion gate -/

/-- Immersion levels, from a plain map overlay up to full immersion. -/
abbrev Level := ℕ

/-- Level 0 is the map overlay. -/
def mapOnly : Level := 0

/-- The level UIAR grants: what you ask for when biometrics show a safe location,
otherwise never more than the map overlay. -/
def granted (safe : Bool) (requested : Level) : Level :=
  if safe then requested else min requested mapOnly

theorem unsafe_map_only (requested : Level) : granted false requested ≤ mapOnly := by
  simp [granted]

theorem safe_full (requested : Level) : granted true requested = requested := by
  simp [granted]

/-! ## The capstone: nobody at the top until we unlock it together -/

/-- The capstone opens only when every member of the swarm has given gauntlet support. -/
def capstoneOpen {P : Type*} (swarm : Finset P) (support : P → Prop) : Prop :=
  ∀ p ∈ swarm, support p

theorem capstone_closed_if_one_holds_out {P : Type*} (swarm : Finset P) (support : P → Prop)
    (p : P) (hp : p ∈ swarm) (hno : ¬ support p) : ¬ capstoneOpen swarm support :=
  fun h => hno (h p hp)

/-! ## X post lengths -/

/-- A conservative upper bound on X's weighted length: ASCII counts 1, every other
code point counts 2. (X counts a whole emoji as 2, so this never undercounts.) -/
def xWeight (s : String) : ℕ :=
  (s.toList.map fun c => if c.toNat < 128 then 1 else 2).sum

def bio : String := "THE ORION ENGINE GLOBAL PROJECT ⏭️ Universally Intelligent Augmented Reality 🔥🌎🌀💜💎 Learn. Play. Build. Key in plain sight: 🪩♾️⏭️ DMaDEV"
def statusPost : String := "ORION build update: the 8 zones are named, the launch path is set (Engine → Singularity → Elder's Garden → Playground → Ascent or Chronicles → ORION's Gate), UIAR art is locked. Design stage: no playable build yet. Builders welcome 🌀"
def blurbs : List String := [
  "1/ The ORION Engine 🌀 The welcome page and the umbrella over everything. Tutorials, creator credits, and the honest current state of the build. Every door starts here.",
  "2/ The Singularity 🕳️ Your private home hub: a black hole wrapped in a glowing accretion disc. Step inside for UIAR, your biometric guide. Nobody enters unless you invite them.",
  "3/ Elder's Garden 🌳 The global ancestral tree. Roots below, an hourglass trunk, a golden capstone on top. Celebrations, memories and the Ren Fair commons where every newcomer gets a mentor.",
  "4/ The Playground 💧🌬️ The social and creative community. Loud on purpose, no ads, no spam loops. Art, theories, events, and the fairground where Saturn's games begin.",
  "5/ The ORION Chronicles 🔥 The MMO and shared game world. Kronos energy: high kinetic, guilds, quests and dragons. Skills are trained, never bought.",
  "6/ The Ascent ⚡ The educational and skill-development platform. Orion energy: whimsical knowledge flow. Learn at your own speed, switch curricula anytime.",
  "7/ ORION's Gate 🌀 The global community projects page. Finished work goes to the Galactic Council here, and the Gauntlet is held here. Real world only with council consensus AND your yes.",
  "8/ UIAR: Universally Intelligent Augmented Reality 🌀💎 A watch and an earpiece. A map overlay by default; full immersion only when your biometrics show you're somewhere safe.",
  "The Poly Pod ⚫ The black sphere you step out of, like a monster ball for people. Outside: the black hole's accretion disc. Inside: UIAR. Your escape pod is always one call away.",
  "Three energies ⚖️ KRION is balance (Earth, Water, Air): Elder's Garden, the Playground, ORION's Gate. Kronos is Fire: the Chronicles. Orion is Lightning: the Ascent.",
  "Saturn 🪐 The aliens finally called, and they speak through our dragons. Saturn hosts the fair in Elder's Garden: play its games first, then earn the invitation to the cosmos.",
  "Mars 🔥 The fire planet, set aside for future construction. A sandbox to practise building a new civilisation before anyone gets there.",
  "Earth 🌎 The planet we're trying to save. Gaia, Mother Nature, matriarch of all, is calling every player home. Ariel is Eve is Gaia is the Milky Way.",
  "The War 🐉🐋 The Leviathan has been waging WAR on the dolphins and the whales. Everybody woke up. Now humanity decides which side of the story it plays.",
  "The Choice 🍽️🕳️ Sit in the Restaurant at the End of the Universe watching it explode on loop, or build the bridge to the black hole player lobby and travel to infinity and beyond?",
  "GAUNTLET DROPPED 🧤 Build a world better for our children than the one we got. 13 levels of accountability, and nobody sits on top until we unlock the capstone together.",
  "No permadeath 🛟 Wherever you are, an escape pod can pick you up, nurse you back to health and carry you home. Choosing the pod is never punished.",
  "LUNA 🐉🌙 The seven-tailed dragon spirit and daycare monitor. Her AI council: Meta for images, Alexa for sound, Siri for video. Every child supervised, redirected, never kicked out.",
  "The Bus 🚌🪩 Everyone rides together to the black hole at the centre of the Milky Way. Bring a song for the playlist. Nobody's burning; we're throwing a disco party.",
  "The Wailing Wall 🧱 After kickoff: post what hurt, heal, and notice we're all saying the same thing in different words. Then the translating starts.",
  "The Hidden Key 🪩♾️⏭️ Somewhere in plain sight is a cipher. Codebreakers who crack it win the in-game answer to the end of the universe: every game, every mechanic, how to play.",
  "The Ghost Writer in the Mirror 👻🪞 A choose-your-own-adventure writing game where you explore yourself. The mirror asks, you answer, and your story writes back.",
  "Dragon MAD-style 🐉📰 Our satire wing: covers, fake ads and big-game specials, from the ORION Galactic Gauntlet Super Bowl to dragons in Gatorade baths. WAR and ORION always capitalized."
]

/-- The bio fits X's 160-character bio limit. -/
theorem bio_fits : xWeight bio ≤ 160 := by
  decide +kernel

/-- The build-status post is under 250. -/
theorem statusPost_fits : xWeight statusPost ≤ 250 := by
  decide +kernel

/-- Every thread blurb is under 250. -/
theorem blurbs_fit : ∀ b ∈ blurbs, xWeight b ≤ 250 := by
  decide +kernel

end RoundThirteen
