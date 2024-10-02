#import "@preview/cetz:0.2.2"
#import "components.typ": num_row, arrowed
#import "/config.typ": theme

#let partition_loop(nums) = {
  let swaps = ()
  let pivot = nums.at(0)
  let j = 1
  for (i, x) in nums.enumerate() {
    if i == 0 {continue}
    if x <= pivot {
      swaps.push((i, j))
      swaps.push((j, i, (paint: theme.bg_trans)))
      (nums.at(i), nums.at(j)) = (nums.at(j), nums.at(i))
      j += 1
    }
  }
  return (swaps, nums, j - 1)
}

#let partition_finalize(nums, j) = {
  let swaps = ()
  swaps.push((0, j))
  swaps.push((j, 0, (paint: theme.bg_trans)))
  (nums.at(0), nums.at(j)) = (nums.at(j), nums.at(0))
  return (swaps, nums)
}

#let nums = (34, 45, 12, 34, 23, 18, 38, 17, 43, 7)
#let (
  swaps_loop,
  nums_loop,
  j_loop
) = partition_loop(nums)
#let (
  swaps_finalize,
  nums_finalize
) = partition_finalize(nums_loop, j_loop)

#block(
  breakable: false,
  table(
    columns: (auto,) + (1fr,) * (nums.len()+1),
    align: center,
    ..num_row(
      nums,
      prefix: ([],),
      hl_tertiary: 0,
      below: 0pt,
      arrow_down: swaps_loop,
      labels: (
        (0, 1, arrowed[`pivot`]),
      ),
    ),
    ..num_row(
      nums_loop,
      prefix: ([],),
      hl_primary: range(1, j_loop + 1),
      hl_secondary: range(j_loop + 1, nums.len()),
      hl_tertiary: 0,
      below: 0pt,
      arrow_down: swaps_finalize
    ),
    ..num_row(
      nums_finalize,
      prefix: ([],),
      hl_primary: range(j_loop),
      hl_secondary: range(j_loop + 1, nums.len()),
      hl_tertiary: j_loop
    )
  )
)