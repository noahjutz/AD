#import "@preview/cetz:0.3.1"
#import "/config.typ": theme

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

#let max_subarray_l(nums) = {
  let mid = calc.div-euclid(nums.len(), 2)

  let max = -calc.inf
  let index = 0
  for i in range(0, mid).rev() {
    let sum = nums.slice(i, mid).sum()
    if max < sum {
      max = sum
      index = i
    }
  }
  return (index, mid)
}

#let max_subarray_r(nums) = {
  let mid = calc.div-euclid(nums.len(), 2)
  let max = -calc.inf
  let index = 0
  for i in range(mid+1, nums.len()+1) {
    let sum = nums.slice(mid, i).sum()
    if max < sum {
      max = sum
      index = i
    }
  }
  return (mid, index)
}

#let row(nums) = {
  let (l_start, l_end) = max_subarray_l(nums)
  let (r_start, r_end) = max_subarray_r(nums)
    stack(
      dir: ltr,
      ..nums.enumerate().map(((i, n)) => {
        box(
          fill: if l_start <= i and i < l_end {
            theme.primary_trans
          } else if r_start <= i and i < r_end {
            theme.secondary_trans
          },
          inset: (x: 2pt, y: 4pt),
          str(n)
        )
      })
    )
}

#let tree_to_content(tree) = {
  if type(tree.at(0)) == int {
    return row(tree)
  }

  return tree.map(tree_to_content)
}

#cetz.canvas({
  import cetz.draw: *
  import cetz.tree

  set-style(content: (frame: "rect"))
  tree.tree(
    tree_to_content(div_tree(nums)),
    spread: 0.75,
    grow: 1.2,
    draw-edge: (from, to, ..) => line(from, to, mark: (end: "straight"))
  )
})