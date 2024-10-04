#import "@preview/cetz:0.2.2"
#import "components.typ": num_row

#let nums = (34, 45, 12, 34, 23, 18, 38, 17, 43, 7)

#let partition(nums) = {
  let swaps = ()
  let j = 1
  for i in range(1, nums.len()) {
    if nums.at(i) <= nums.at(0) {
      (nums.at(i), nums.at(j)) = (nums.at(j), nums.at(i))
      swaps.push((i, j))
      j += 1
    }
  }
  (nums.at(0), nums.at(j - 1)) = (
    nums.at(j - 1), nums.at(0)
  )
  return (
    swaps,
    nums,
    j - 1
  )
}

#let quicksort_row(nums, depth: calc.inf) = {
  if nums.len() <= 1 or depth == 0 {
    return (
      nums, ()
    )
  }
  let (swaps, nums, j) = partition(nums)
  let (l_nums, l_swaps) = quicksort_row(
    nums.slice(0, j),
    depth: depth - 1
  )
  let (r_nums, r_swaps) = quicksort_row(
    nums.slice(j+1, nums.len()),
    depth: depth - 1
  )
  return (
    (..l_nums, ..r_nums),
    ()
  )
}

#table(
  columns: nums.len() * (1fr,),
  align: center,
  ..quicksort_row(nums, depth: 3).at(0).map(n => str(n))
)