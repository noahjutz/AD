#import "@preview/cetz:0.2.2"

#show table: set text(size: 8pt)
#set block(spacing: 4pt)

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
  table(
    columns: nums.len(),
    stroke: none,
    align: end,
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
    tree_to_content(div_tree(nums))
  )
})