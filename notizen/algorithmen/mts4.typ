#import "@preview/cetz:0.2.2"

#let nums = (-13, 25, 34, 12, -3, 7, -87, 28, -77, 11)

#let split(nums) = {
  let n = calc.div-euclid(nums.len(), 2)
  return (
    nums.slice(0, n),
    nums.slice(n, nums.len())
  )
}

#let div_tree(nums) = {
  if nums.len() == 1 {return nums}
  let (l, r) = split(nums)
  (nums, div_tree(l), div_tree(r))
}

#let row(nums) = box(
  stroke: 1pt,
  inset: 3pt,
  stack(
    dir: ltr,
    spacing: 4pt,
    ..nums.map(n => str(n))
  )
)

#let tree_to_content(tree) = {
  if type(tree.at(0)) == int {
    return row(tree)
  }

  return tree.map(tree_to_content)
}

#cetz.canvas({
  import cetz.draw: *
  import cetz.tree

  tree.tree(
    tree_to_content(div_tree(nums)),
    spread: 0.75,
    grow: 1.2,
    draw-edge: (from, to, ..) => line(from, to, mark: (end: "straight"))
  )
})