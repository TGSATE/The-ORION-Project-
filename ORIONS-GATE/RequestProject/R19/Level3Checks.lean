module

public import Mathlib
public import RequestProject.R19.Level2Checks

@[expose] public section

/-!
# Round 19 · Level 3 (19.3): the "ARI🧿" line, legend lines, the emoji kit, an account's age

Statements about the rules written in `R19_L3_READOUT.md`, `EMOJI_KIT.md` and
`orion/tools/separator_reader.py`. They are about those rules, not about Google Docs or X.

1. **The header.** At 19.3 Beth wrote `OR19.3💎` and then `ARI🧿` on its own line, and the
   legend line `18🌀…⏭️OR19💎` followed by "Indicates ROUND is finished…". Two new reading
   rules: an `ARI🧿` line right under a 🌀 separator makes it a 🧿 line, and a ⏭️ line followed
   by "Indicates…" is the key, not a round change. With them the Doc reads
   **coming from 19.3 → porting to 19.4**. Without them, the 19.1 reader says 19.2 → 19.3
   (the mistake the rules fix). On a Doc with neither kind of line, nothing changes.
2. **The emoji kit.** Beth's base set (🌀 processing, 👾 gathering, 🧿 examining) clashed with
   the 19.2 status light, where 👾 also meant "done" and 🧿 meant "still working". The new kit
   gives every mark exactly one meaning, and "done" (🤟 ready) is a mark of its own.
3. **How old an X account is.** An X post or account number carries its creation time:
   `(number / 2^22) + 1288834974657` milliseconds after 1 January 1970. @paul4jennii's account
   number 1588359648905551873 gives 1667529425251, which is 4 November 2022 (UTC).
-/

namespace R19L3

open R18L1 (Line)

/-! ## 1. The header -/

/-- A Doc line as the 19.3 reader sees it: a separator, a bare `ARI🧿` line, a line starting
with "Indicates" (a legend explanation), or ordinary text. -/
inductive Raw where
  | sep (l : Line)
  | ariEye
  | indicates
  | text
  deriving DecidableEq

/-- The 19.3 pre-pass. `🌀 separator` + `ARI🧿` → a 🧿 line; `⏭️ separator` + "Indicates…"
→ the key (ordinary text); everything else is passed on as before. -/
def fold : List Raw → List Line
  | [] => []
  | .sep (.spiral r l) :: .ariEye :: rest => .exam r l :: .text :: fold rest
  | .sep (.next _ _) :: .indicates :: rest => .text :: .text :: fold rest
  | .sep x :: rest => x :: fold rest
  | _ :: rest => .text :: fold rest

/-- Beth's Doc at 19.3 (9 October 2026), line kinds in order: ⏭️OR17, ⏭️OR18 + NEW NEWS,
`OR18.1`, the unclosed ⏬ row, her spiral, `OR19.1💎🧿` + her marked-up 19.1 readout,
`OR19.2💎🧿` + "Indicates what next level will be…" + her 19.2 notes, `OR19.3💎` + `ARI🧿` +
her marked-up 19.2 readout and NEW NEWS, the legend `18🌀…⏭️OR19💎` + "Indicates ROUND is
finished…", 💎 ×9, the soft end line, and what follows it. -/
def doc19_3 : List Raw :=
  [.sep (.next 17 none), .text, .sep (.next 18 none), .text, .sep (.spiral 18 1), .sep .parkOpen,
   .text, .sep (.exam 19 1), .text, .sep (.exam 19 2), .indicates, .text,
   .sep (.spiral 19 3), .ariEye, .text, .text,
   .sep (.next 19 none), .indicates, .sep .final, .text, .sep .endLine, .text]

/-- **19.3 → 19.4**, with the two 19.3 rules. -/
theorem doc19_3_header : R19L1.header (fold doc19_3) = (some (19, 3), some (19, 4)) := by
  decide

/-- What the reader said *before* the 19.3 rules (`ARI🧿` and "Indicates" read as plain
text): **19.2 → 19.3**, one level behind. This is the mistake the new rules fix. -/
theorem doc19_3_header_old_rules :
    R19L1.header (doc19_3.map fun
      | .sep x => x
      | _ => .text) = (some (19, 2), some (19, 3)) := by
  decide

/-- **Old Docs are read exactly as before:** with no `ARI🧿` line and no "Indicates" line,
the pre-pass changes nothing. -/
theorem fold_plain (xs : List Line) : fold (xs.map Raw.sep) = xs := by
  induction xs with
  | nil => rfl
  | cons x xs ih =>
    cases xs with
    | nil => cases x <;> rfl
    | cons y ys =>
      cases x <;> simp_all [fold]

/-! ## 2. The emoji kit -/

/-- The marks in the kit. -/
inductive Mark where
  | spiral    -- 🌀
  | invader   -- 👾
  | eye       -- 🧿
  | horns     -- 🤟
  | gem       -- 💎
  | nextUp    -- ⏭️
  | radiation -- ☢️
  | devil     -- 😈
  | facepalm  -- 🤦‍♀️
  | news      -- 📰
  deriving DecidableEq, Fintype

/-- What a mark can mean. -/
inductive Meaning where
  | processing | gathering | examining | ready
  | locked | nextStarts | stop | alreadyGrabbed | correction | newsDrop
  deriving DecidableEq, Fintype

/-- **The 19.2 status light, together with Beth's base set**, as (mark, meaning) pairs:
👾 meant both "done" and "gathering", and 🧿 meant both "still working" and "examining". -/
def oldKit : List (Mark × Meaning) :=
  [(.invader, .ready), (.eye, .processing),
   (.spiral, .processing), (.invader, .gathering), (.eye, .examining)]

/-- A kit is clear when no mark carries two meanings. -/
def Clear (kit : List (Mark × Meaning)) : Prop :=
  ∀ a ∈ kit, ∀ b ∈ kit, a.1 = b.1 → a.2 = b.2

instance (kit : List (Mark × Meaning)) : Decidable (Clear kit) := by
  unfold Clear; infer_instance

/-- **The clash Beth caught:** the old kit is not clear. -/
theorem oldKit_clash : ¬ Clear oldKit := by decide

/-- **The 19.3 base kit**, one meaning per mark. -/
def meaningOf : Mark → Meaning
  | .spiral => .processing
  | .invader => .gathering
  | .eye => .examining
  | .horns => .ready
  | .gem => .locked
  | .nextUp => .nextStarts
  | .radiation => .stop
  | .devil => .alreadyGrabbed
  | .facepalm => .correction
  | .news => .newsDrop

/-- The new kit as (mark, meaning) pairs. -/
def newKit : List (Mark × Meaning) :=
  [.spiral, .invader, .eye, .horns, .gem, .nextUp, .radiation, .devil, .facepalm, .news].map
    fun m => (m, meaningOf m)

/-- **The new kit is clear** (no mark has two meanings)… -/
theorem newKit_clear : Clear newKit := by
  intro a ha b hb h
  simp only [newKit, List.mem_map] at ha hb
  obtain ⟨m, -, rfl⟩ := ha
  obtain ⟨n, -, rfl⟩ := hb
  simp_all

/-- Every mark is in the kit. -/
theorem newKit_complete (m : Mark) : (m, meaningOf m) ∈ newKit := by
  cases m <;> decide

/-- …**and no meaning has two marks**, so reading either way is unambiguous. -/
theorem meaningOf_injective : Function.Injective meaningOf := by
  decide

/-- **"Done" has its own mark:** the ready mark is none of the three working stages. -/
theorem ready_is_separate :
    meaningOf .horns = .ready ∧
    ∀ m, meaningOf m ∈ [Meaning.processing, .gathering, .examining] → m ≠ .horns := by
  decide

/-- **Anyone can swap in their own marks** (a one-to-one relabelling of the kit) and their
kit stays clear. -/
theorem relabel_clear (e : Mark ≃ Mark) :
    Clear (newKit.map fun p => (e p.1, p.2)) := by
  intro a ha b hb h
  simp only [List.mem_map] at ha hb
  obtain ⟨p, hp, rfl⟩ := ha
  obtain ⟨q, hq, rfl⟩ := hb
  exact newKit_clear p hp q hq (e.injective h)

/-! ## 3. How old an X account is -/

/-- Creation time (milliseconds since 1 January 1970, UTC) carried by an X number. -/
def createdMs (id : ℕ) : ℕ := id / 2 ^ 22 + 1288834974657

/-- **@paul4jennii's account dates from 4 November 2022 (UTC):** its number gives
1667529425251 ms, which lies between 4 Nov 2022 00:00 (1667520000000) and
5 Nov 2022 00:00 (1667606400000). -/
theorem paul4jennii_account_date :
    createdMs 1588359648905551873 = 1667529425251 ∧
    1667520000000 ≤ createdMs 1588359648905551873 ∧
    createdMs 1588359648905551873 < 1667606400000 := by
  norm_num [createdMs]

end R19L3
