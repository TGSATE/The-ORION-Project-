module

public import RequestProject.R15.Level7Checks

public section

namespace R15.Level8

/-- The digit reductions Beth asked about: the scroll's corrected total is 87,
its digits sum to 15, and the digits of 15 sum to 6. The name "Tesla number"
is her interpretive label, not a mathematical conclusion of this check. -/
theorem trista_digit_reductions :
    R15.Level7.wordValue "TRISTA" = 87 ∧ 8 + 7 = 15 ∧ 1 + 5 = 6 := by
  exact ⟨R15.Level7.trista_name_sum.1, by norm_num, by norm_num⟩

end R15.Level8
