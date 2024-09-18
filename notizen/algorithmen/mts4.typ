#import "@preview/cetz:0.2.2"
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

#let max_subarray(nums) = {
  let mid = calc.div-euclid(nums.len(), 2)

  let l_max = -calc.inf
  let l_index = 0
  for i in range(0, mid).rev() {
    let sum = nums.slice(i, mid).sum()
    if l_max < sum {
      l_max = sum
      l_index = i
    }
  }

  let r_max = -calc.inf
  let r_index = 0
  for i in range(mid+1, nums.len()+1) {
    let sum = nums.slice(mid, i).sum()
    if r_max < sum {
      r_max = sum
      r_index = i
    }
  }

  return (l_index, r_index)
}

#let row(nums) = {
  let (start, end) = max_subarray(nums)
    stack(
      dir: ltr,
      ..nums.enumerate().map(((i, n)) => {
        box(
          fill: if start <= i and i < end {theme.primary_trans},
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