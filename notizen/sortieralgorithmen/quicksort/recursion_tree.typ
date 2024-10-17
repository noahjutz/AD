#import "@preview/cetz:0.2.2"
#import "/config.typ": theme

#set text(font: "Noto Sans Mono")
#set table(align: center)
#show table.cell: box.with(width: 24pt)

#let nums = (34, 45, 12, 34, 23, 18, 38, 17, 43, 7)

#let row(nums) = table(
  align: center,
  ..nums.map(n => str(n)),
  fill: if nums.len() == 1 {theme.success_light}
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
    return table(sym.emptyset)
  }
  if root.len() == 1 {
    return row(root)
  }
  let (l, p, r) = partition(root)
  return (
    row(root),
    quicksort_tree(r),
    row(p),
    quicksort_tree(l),
  )
}

#cetz.canvas({
  import cetz.draw: *
  import cetz.tree

  tree.tree(
    quicksort_tree(nums),
    direction: "right",
    grow: 1.1
  )
})