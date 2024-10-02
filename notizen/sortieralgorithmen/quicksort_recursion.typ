#import "@preview/cetz:0.2.2"

#let nums = (34, 45, 12, 34, 23, 18, 38, 17, 43, 7)

#let row(..nums) = box(
  stroke: black,
  stack(
    dir: ltr,
    ..nums.pos().map(n => box(
      inset: 4pt,
      str(n)
    ))
  )
)

#let partition(nums) = {
  let j = 1
  for i in range(1, nums.len()) {
    if nums.at(i) <= nums.at(0) {
      (nums.at(i), nums.at(j)) = (nums.at(j), nums.at(i))
      j += 1
    }
  }
  return nums
}

#let nums = partition(nums)

#cetz.canvas(length: 100%, {
  import cetz.draw: *
  import cetz.tree

  tree.tree(
    (row(..nums))
  )
})

