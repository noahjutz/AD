#import "components.typ": num_row

#let nums = (0,)

#table(
  columns: (auto,) + (1fr,) * nums.len(),
  align: center,
  ..num_row(nums)
)