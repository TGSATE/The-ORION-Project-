module

public import Mathlib

/-!
# Round 18: the counts behind the Miss T (Triss) process review

* Her 40 most recent public timeline items (2–7 October 2026) split into 25 of her own posts and
  15 reposts of other people.
* Her 25 own posts split into 14 picture-only posts, 5 pictures-with-a-title posts, 5 music links
  and 1 text-only reply; the 19 posts with pictures carry 53 pictures between them.
* The shared ORION album, re-read on 7 October 2026, still has 1,417 items: nothing was added
  or removed since Round 17.

These check the arithmetic of the counts only.
-/

namespace RoundEighteen

/-- Timeline split: 25 own posts + 15 reposts = 40 items, and the own posts split
14 + 5 + 5 + 1 = 25 by kind, 19 of them with pictures. -/
public theorem miss_t_timeline_split :
    25 + 15 = 40 ∧ 14 + 5 + 5 + 1 = 25 ∧ 14 + 5 = 19 := by
  decide

/-- Album recount: 1,417 items in Round 17, nothing added or removed, 1,417 now. -/
public theorem album_unchanged : 1417 + 0 - 0 = 1417 := by
  decide

end RoundEighteen
