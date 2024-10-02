#import "@preview/cetz:0.2.2"
#import "components.typ": num_row
#import "/config.typ": theme

#let nums = (34, 45, 12, 34, 23, 18, 38, 17, 43, 7)

#let partition_loop(nums, pivot_index) = {
  let swaps = ()
  let pivot = nums.at(pivot_index)
  let j = 0
  for (i, x) in nums.enumerate() {
    if x <= pivot {
      swaps.push((i, j))
      swaps.push((j, i, (paint: theme.bg_trans)))
      (nums.at(i), nums.at(j)) = (nums.at(j), nums.at(i))
      j += 1
    }
  }
  return (swaps, nums)
}

#table(
  columns: (auto,) + (1fr,) * nums.len(),
  align: center,
  ..num_row(
    nums,
    below: 0pt,
    arrow_down: partition_loop(nums, 0).at(0)
  ),
  ..num_row(
    partition_loop(nums, 0).at(1)
  )
)
