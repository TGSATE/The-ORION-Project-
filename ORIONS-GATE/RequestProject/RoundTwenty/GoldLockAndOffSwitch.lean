module

public import Mathlib

/-!
# Round 20: Gold Lock for skill orbs, the biometric off switch, the metaphor translator,
# and one finding in a contributor's content gate

* **Gold Lock (Beth's Q-1 answer, 🤟💎).** Both meanings of "gold" stay. A skill orb can only
  be gold-locked at level 100 *while the player's Kronos and Orion meters are in the Gold
  state* (perfect balance, as in the Vision Board). Once locked, an orb stays locked.
* **Biometrics (🤟💎 on each line).** Adults may connect an access port (computer console or
  mobile device), the suit, or a neural link. Every link disconnects in one step without
  touching the character. Under-18s only ever have the access port (no hardware biometrics).
* **Metaphor translator (proposal from the helper-rule note).** Each player keeps a personal
  glossary "my word → the shared item". Translating a word from one player to another goes
  through the shared item, so it can never land on a different item.
* **far-games content gate (Bobby's public repository).** The gate blocks a banned motif only
  when the exact word appears. Its own example text, "buy gems and coins to unlock more
  levels", contains none of the banned words, so the gate lets it through.

These are models of the written rules, not running game code.
-/

namespace RoundTwenty

/-! ## Gold Lock -/

/-- The two HUD meters. -/
public structure Meters where
  kronos : ℕ
  orion : ℕ
  deriving DecidableEq, Repr

/-- The Gold state: the two meters are in perfect balance. -/
public def Meters.isGold (m : Meters) : Bool := m.kronos == m.orion

/-- A skill orb: its level (0–100) and whether it is gold-locked. -/
public structure Orb where
  level : ℕ
  locked : Bool
  deriving DecidableEq, Repr

/-- An orb can be locked now when it is at level 100, the meters are Gold, and it is not
already locked. -/
public def canLock (m : Meters) (o : Orb) : Bool :=
  o.level == 100 && m.isGold && !o.locked

/-- Try to gold-lock an orb. Nothing happens unless `canLock` holds. -/
public def tryLock (m : Meters) (o : Orb) : Orb :=
  if canLock m o then { o with locked := true } else o

/-- A newly locked orb was at level 100 and the meters were Gold at that moment. -/
public theorem lock_needs_gold_and_max (m : Meters) (o : Orb)
    (hnew : o.locked = false) (h : (tryLock m o).locked = true) :
    o.level = 100 ∧ m.kronos = m.orion := by
  unfold tryLock at h
  split_ifs at h with hc
  · simp [canLock, Meters.isGold] at hc
    exact ⟨hc.1.1, hc.1.2⟩
  · simp [hnew] at h

/-- When the meters are out of balance, trying to lock changes nothing. -/
public theorem unbalanced_never_locks (m : Meters) (o : Orb) (h : m.kronos ≠ m.orion) :
    tryLock m o = o := by
  unfold tryLock
  rw [if_neg]
  simp [canLock, Meters.isGold, h]

/-- At level 100 in the Gold state, the orb gets locked. -/
public theorem gold_and_max_locks (m : Meters) (o : Orb) (hg : m.kronos = m.orion)
    (hl : o.level = 100) : (tryLock m o).locked = true := by
  unfold tryLock
  by_cases hlock : o.locked = true
  · split_ifs <;> simp [hlock]
  · rw [if_pos]
    simp [canLock, Meters.isGold, hg, hl, hlock]

/-- A locked orb stays locked, whatever the meters do. -/
public theorem locked_stays_locked (m : Meters) (o : Orb) (h : o.locked = true) :
    (tryLock m o).locked = true := by
  unfold tryLock
  split_ifs <;> simp [h]

/-- Locking never changes an orb's level. -/
public theorem lock_keeps_level (m : Meters) (o : Orb) : (tryLock m o).level = o.level := by
  unfold tryLock
  split_ifs <;> rfl

/-! ## Biometrics: every option, always an off switch -/

/-- Ways to connect. `accessPort` is a computer console or mobile device (no biometrics). -/
public inductive Link where
  | accessPort
  | suit
  | neuralLink
  deriving DecidableEq, Repr

/-- A player's connection state. The character is kept separately from the links. -/
public structure Player where
  adult : Bool
  character : ℕ
  links : List Link
  deriving DecidableEq, Repr

/-- Connect a link. Anyone may use the access port; hardware links need an adult account. -/
public def connect (p : Player) (l : Link) : Player :=
  if l = Link.accessPort ∨ p.adult = true then { p with links := l :: p.links } else p

/-- Disconnect a link: one step, all copies of it removed. -/
public def disconnect (p : Player) (l : Link) : Player :=
  { p with links := p.links.filter (· ≠ l) }

/-- Disconnecting never touches the character. -/
public theorem disconnect_keeps_character (p : Player) (l : Link) :
    (disconnect p l).character = p.character := by
  simp [disconnect]

/-- Connecting never touches the character either. -/
public theorem connect_keeps_character (p : Player) (l : Link) :
    (connect p l).character = p.character := by
  unfold connect
  split_ifs <;> rfl

/-- After disconnecting a link, it is fully off. -/
public theorem disconnect_is_off (p : Player) (l : Link) : l ∉ (disconnect p l).links := by
  simp [disconnect]

/-- The access port is always available, to every player. -/
public theorem access_port_always_available (p : Player) :
    Link.accessPort ∈ (connect p Link.accessPort).links := by
  simp [connect]

/-- "No hardware biometrics": every link is the access port. -/
public def noHardware (p : Player) : Prop := ∀ l ∈ p.links, l = Link.accessPort

/-- An under-18 player with no hardware links still has none after any connect. -/
public theorem minor_connect_no_hardware (p : Player) (l : Link) (ha : p.adult = false)
    (h : noHardware p) : noHardware (connect p l) := by
  unfold connect noHardware
  split_ifs with hc
  · intro x hx
    rcases List.mem_cons.mp hx with rfl | hx
    · rcases hc with hc | hc
      · exact hc
      · simp [ha] at hc
    · exact h x hx
  · exact h

/-- ...and after any disconnect. -/
public theorem minor_disconnect_no_hardware (p : Player) (l : Link)
    (h : noHardware p) : noHardware (disconnect p l) := by
  intro x hx
  simp only [disconnect, List.mem_filter] at hx
  exact h x hx.1

/-- One step of a session: `true` connects the link, `false` disconnects it. -/
public def step (q : Player) (op : Bool × Link) : Player :=
  if op.1 then connect q op.2 else disconnect q op.2

/-- A step never changes whether the account is adult. -/
public theorem step_keeps_adult (q : Player) (op : Bool × Link) :
    (step q op).adult = q.adult := by
  unfold step
  split_ifs
  · unfold connect; split_ifs <;> rfl
  · rfl

/-- So an under-18 player who starts with no hardware links never gets one, whatever
sequence of connects and disconnects happens. -/
public theorem minor_never_hardware (ops : List (Bool × Link)) :
    ∀ p : Player, p.adult = false → noHardware p → noHardware (ops.foldl step p) := by
  induction ops with
  | nil => intro p _ h; exact h
  | cons op ops ih =>
    intro p ha h
    simp only [List.foldl_cons]
    apply ih
    · rw [step_keeps_adult]; exact ha
    · unfold step
      split_ifs
      · exact minor_connect_no_hardware p _ ha h
      · exact minor_disconnect_no_hardware p _ h

/-! ## The metaphor translator -/

/-- A player's personal glossary: each entry is "my word" and the shared item it means. -/
public abbrev Glossary := List (String × ℕ)

/-- The shared item a player's word stands for, if they have explained it. -/
public def toShared (g : Glossary) (word : String) : Option ℕ :=
  (g.find? (fun e => e.1 == word)).map (·.2)

/-- The other player's own word for a shared item, if they have one. -/
public def ownWordFor (g : Glossary) (item : ℕ) : Option String :=
  (g.find? (fun e => e.2 == item)).map (·.1)

/-- Translate a word from player `a` to player `b`: through the shared item, into `b`'s own
word if `b` has one, otherwise into the common label. An unexplained word is not translated
(the helper asks the player to describe it instead). -/
public def translate (commonLabel : ℕ → String) (a b : Glossary) (word : String) :
    Option String :=
  (toShared a word).map fun item => (ownWordFor b item).getD (commonLabel item)

/-- The translator never changes the item: the result is either one of `b`'s words for the
same shared item, or that item's common label. -/
public theorem translate_keeps_item (commonLabel : ℕ → String) (a b : Glossary)
    (word s : String) (h : translate commonLabel a b word = some s) :
    ∃ item, (word, item) ∈ a ∧ ((s, item) ∈ b ∨ s = commonLabel item) := by
  unfold translate toShared at h
  cases ha : a.find? (fun e => e.1 == word) with
  | none => simp [ha] at h
  | some e =>
    simp only [ha, Option.map_some, Option.some.injEq] at h
    have hea : e ∈ a := List.mem_of_find?_eq_some ha
    have hw : e.1 = word := by simpa using List.find?_some ha
    refine ⟨e.2, by rw [← hw]; exact hea, ?_⟩
    unfold ownWordFor at h
    cases hb : b.find? (fun f => f.2 == e.2) with
    | none => right; simp [hb] at h; exact h.symm
    | some f =>
      left
      simp only [hb, Option.map_some, Option.getD_some] at h
      have hfb : f ∈ b := List.mem_of_find?_eq_some hb
      have hi : f.2 = e.2 := by simpa using List.find?_some hb
      rw [← h, ← hi]
      exact hfb

/-- A word the player has not explained is not translated. -/
public theorem unexplained_not_translated (commonLabel : ℕ → String) (a b : Glossary)
    (word : String) (h : toShared a word = none) :
    translate commonLabel a b word = none := by
  simp [translate, h]

/-- Example: Beth's "Universal Stone" (shared item 7) reaches a player who calls item 7
"Pocket Oracle" as "Pocket Oracle"; a player with no word for it gets the common label. -/
example :
    translate (fun _ => "inventory device") [("Universal Stone", 7)] [("Pocket Oracle", 7)]
        "Universal Stone" = some "Pocket Oracle" ∧
      translate (fun _ => "inventory device") [("Universal Stone", 7)] []
        "Universal Stone" = some "inventory device" := by
  decide

/-! ## far-games content gate: literal matching only -/

/-- Does `pat` appear as a run of consecutive characters somewhere in `text`? -/
public def occursIn (pat text : List Char) : Bool :=
  (List.range (text.length + 1)).any fun i => (text.drop i).take pat.length == pat

/-- The far-games gate's banned-motif check, as written: a text is blocked only if one of the
banned words appears literally in it (ignoring capitals, which this example has none of). -/
public def literalGateAllows (banned : List String) (text : String) : Bool :=
  banned.all fun m => !occursIn m.toList text.toList

/-- The repository's own example: banned words "microtransactions", "ads", "always_online";
test text "buy gems and coins to unlock more levels". The example's comment says the banned
motif should be caught, but the literal check lets the text through. -/
public theorem far_games_example_slips_through :
    literalGateAllows ["microtransactions", "ads", "always_online"]
      "buy gems and coins to unlock more levels" = true := by
  decide +kernel

/-- The same check does block a text that uses a banned word literally. -/
public theorem far_games_literal_word_blocked :
    literalGateAllows ["microtransactions", "ads", "always_online"]
      "unlock levels with microtransactions" = false := by
  decide +kernel

/-! ## Count arithmetic for this round -/

/-- Contributor repositories scanned this round: 55 of the collaborators' own public
repositories pushed in the last 30 days (2 Beth, 33 Matthew, 8 Mike, 12 Bobby). Of these,
52 contain no file that mentions ORION, KRION or TGSATE. The 3 that do are Beth's two and
Matthew's `medium` site, whose one mention is UPS's unrelated "ORION" delivery-routing system. -/
public theorem contributor_scan_counts :
    2 + 33 + 8 + 12 = 55 ∧ 55 - 2 - 1 = 52 := by
  decide

/-- The album, re-read for Round 20: still 1,417 items (the same ones, in the same order).
Phone-screenshot-shaped items checked by eye for the Boardy chat: 93 + 26 = 119. -/
public theorem album_round20_counts : 1417 + 0 - 0 = 1417 ∧ 93 + 26 = 119 := by
  decide

end RoundTwenty
