#import "@preview/cetz:0.2.2"

#let nums = (34, 45, 12, 34, 23, 18, 38, 17, 43, 7)

#let row(..nums) = box(
  stroke: black,
  stack(
    dir: ltr,
    ..nums.pos().map(n => box(
      inset: (left: 2pt, right: 2pt, top: 4pt, bottom: 4pt),
      if type(n) != content {str(n)} else {n}
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
  let (left, pivot, right) = partition(root)

  return (
    root,
    if left.len() == 0 {
      hide("1")
    } else if left.len() == 1 {
      if left.at(0) == 7 {
        ([], ([], 7))
      }
      else {left}
    } else if left.len() > 1 {
      quicksort_tree(left)
    },
    pivot,
    if right.len() == 0 {
      hide("1")
    } else if right.len() == 1 {
      right
    } else if right.len() > 1 {
      quicksort_tree(right)
    }
  )
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
    draw-edge: (from, to, ..) => {
      line(from, to, mark: (end: ">"))
    },
    spread: .7
  )
})

#line(length: 100%)