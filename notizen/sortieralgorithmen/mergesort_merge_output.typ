#import "components.typ": single_num_row, braced_b

#let a1 = (12, 23, 34, 34, 45)
#let a2 = (7, 17, 18, 38, 43)
#let nums = (7, 12, 17, 18, 23, 34, 34, 38, 43, 45)

#single_num_row(
  nums,
  hl_primary: nums.enumerate()
    .filter(((i, n)) => n in a1)
    .map(((i, n)) => i),
  hl_secondary: nums.enumerate()
    .filter(((i, n)) => n in a2)
    .map(((i, n)) => i),
  labels_b: (
    (0, nums.len(), braced_b[`anew`]),
  )
)