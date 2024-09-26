#import "components.typ": num_row, arrow_row
#import "/config.typ": theme

#let nums = (34, 45, 12, 34, 23, 18, 38, 17, 43, 51)

#table(
  columns: nums.len(),
  align: center,
  stroke: none,
  ..num_row(nums)
)