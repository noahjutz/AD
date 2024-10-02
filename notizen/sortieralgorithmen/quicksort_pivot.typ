#import "@preview/cetz:0.2.2"
#import "components.typ": num_row

#let nums = (34, 45, 12, 34, 23, 18, 38, 17, 43, 7)
#let pivot = 0

#let partition(nums, pivot_index) = {
  let pivot = nums.at(pivot_index)
  let j = 0
  for (i, x) in nums.enumerate() {
    if x <= pivot {
      (nums.at(i), nums.at(j)) = (nums.at(j), nums.at(i))
      j += 1
    }
  }
  return nums
}

#table(
  columns: (auto,) + (1fr,) * nums.len(),
  align: center,
  ..num_row(
    nums,
    below: 0pt,
    arrow_down: (
      (0, 0),
      (0, 1, (paint: red)),
      (nums.len()-1, 0)
    )
  )
)

#nums

#partition(nums, 0)