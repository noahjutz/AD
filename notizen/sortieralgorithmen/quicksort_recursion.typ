#import "@preview/cetz:0.2.2"

#let nums = (34, 45, 12, 34, 23, 18, 38, 17, 43, 7)

#let row(..nums) = box(
  stroke: black,
  stack(
    dir: ltr,
    ..nums.pos().map(n => box(
      inset: (left: 2pt, right: 2pt, top: 4pt, bottom: 4pt),
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
  return (
    nums.slice(1, j),
    nums.at(0),
    nums.slice(j, nums.len())
  )
}

#let quicksort_tree(root) = {
  if root.len() == 0 {
    return
  }
  let (left, pivot, right) = partition(root)

  let node = (root,)
  if left.len() == 1 {
    node.push(left)
  } else if left.len() > 1 {
    node.push(quicksort_tree(left))
  }
  node.push(pivot)
  if right.len() == 1 {
    node.push(right)
  } else if right.len() > 1 {
    node.push(quicksort_tree(right))
  }
  return node
}

#let tree_to_content(root) = {
  if type(root) != array {
    return row(root)
  }
  let (root, ..children) = root

  return (
    row(..(root,).flatten()),
    ..children.map(c => tree_to_content(c))
  )
}

#let mytree = quicksort_tree(nums)

#cetz.canvas({
  import cetz.draw: *
  import cetz.tree

  tree.tree(
    tree_to_content(mytree),
  )
})

