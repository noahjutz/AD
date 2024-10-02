#import "@preview/cetz:0.2.2"
#import "components.typ": num_row, arrowed
#import "/config.typ": theme

#let partition_loop(nums, pivot_index) = {
  let swaps = ()
  let pivot = nums.at(pivot_index)
  let j = 0
  for (i, x) in nums.enumerate() {
    if i == pivot_index {
      j += 1
      continue
    }
    if x <= pivot {
      swaps.push((i, j))
      swaps.push((j, i, (paint: theme.bg_trans)))
      (nums.at(i), nums.at(j)) = (nums.at(j), nums.at(i))
      j += 1
    }
  }
  return (swaps, nums, j - 1)
}

#let partition_finalize(nums, p, j) = {
  let swaps = ()
  swaps.push((p, j))
  swaps.push((j, p, (paint: theme.bg_trans)))
  (nums.at(p), nums.at(j)) = (nums.at(j), nums.at(p))
  return (swaps, nums)
}

#let nums = (34, 45, 12, 34, 23, 18, 38, 17, 43, 7)
#let pivot = 1
#let (
  swaps_loop,
  nums_loop,
  j_loop
) = partition_loop(nums, pivot)
#let (
  swaps_finalize,
  nums_finalize
) = partition_finalize(nums_loop, pivot, j_loop)

#block(
  breakable: false,
  table(
    columns: (auto,) + (1fr,) * nums.len(),
    align: center,
    ..num_row(
      nums,
      hl_tertiary: pivot,
      below: 0pt,
      arrow_down: swaps_loop,
      labels: (
        (pivot, pivot+1, arrowed[`pivot`]),
      )
    ),
    ..num_row(
      nums_loop,
      hl_primary: range(j_loop + 1).filter(i => i != pivot),
      hl_secondary: range(pivot + 1, nums.len()),
      hl_tertiary: pivot,
      below: 0pt,
      arrow_down: swaps_finalize
    ),
    ..num_row(
      nums_finalize,
      hl_primary: range(j_loop),
      hl_secondary: range(j_loop + 1, nums.len()),
      hl_tertiary: j_loop
    )
  )
)