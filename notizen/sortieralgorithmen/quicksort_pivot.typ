#import "@preview/cetz:0.2.2"

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

#cetz.canvas({
  import cetz.draw: *
  import cetz.tree

  
})

#nums

#partition(nums, 0)