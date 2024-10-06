#import "@preview/cetz:0.2.2"

#let nums = (34, 45, 12, 34, 23, 18, 38, 17, 43, 7)

#let row(nums) = table(
  ..nums.map(n => str(n))
)

#let partition(nums) = {
  let j = 1
  for i in range(1, nums.len()) {
    if nums.at(i) <= nums.at(0) {
      (nums.at(i), nums.at(j)) = (nums.at(j), nums.at(i))
      j += 1
    }
  }

  (nums.at(0), nums.at(j - 1)) = (nums.at(j - 1), nums.at(0))

  return (
    nums.slice(0, j - 1),
    (nums.at(j - 1),),
    nums.slice(j, nums.len()),
  )
}

#let quicksort_tree(root) = {
  if root.len() == 0 {
    return table(hide("11"))
  }
  if root.len() == 1 {
    return row(root)
  }
  let (l, p, r) = partition(root)
  return (
    row(root),
    quicksort_tree(l),
    row(p),
    quicksort_tree(r)
  )
}

#cetz.canvas({
  import cetz.draw: *
  import cetz.tree

  tree.tree(
    quicksort_tree(nums),
    direction: "right"
  )
})