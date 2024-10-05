#import "components.typ": num_row
#let nums = (34, 45, 12, 34, 23, 18, 38, 17, 43, 7)

// Returns (pivots, swaps)
#let step(nums) = {
  let swaps = ()
  for partition in nums {
    if partition.len() == 1 {
      swaps.push(0)
    }
  }
}

#table(
  columns: (auto,) + (1fr,) * nums.len(),
  align: center,
  ..num_row(
    (7, 12, 23, 18, 17, 34, 34, 43, 38, 45),
    hl_success: (0, 1, 6, 9),
    hl_primary: (3, 4, 8),
    hl_secondary: 5,
    hl_tertiary: (2, 7),
    arrow_down: (
      (0, 0), (1, 1), (2, 4), (3, 2),
      (4, 3), (5, 5), (6, 6), (7, 8),
      (8, 7), (9, 9)
    ),
    below: 0pt,
  ),
  ..num_row(
    (7, 12, 18, 17, 23, 34, 34, 38, 43, 45),
    hl_success: (0, 1, 4, 5, 6, 7, 8, 9)
  )
)