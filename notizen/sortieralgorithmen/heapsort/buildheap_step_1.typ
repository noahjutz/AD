#import "components.typ": bintree, draw_node, number
#import "@preview/cetz:0.3.0"

#let nums = (45, 43, 38, 34, 23, 18, 12, 17, 34, 7)

#cetz.canvas({
  import cetz.draw: *
  import cetz.tree: tree

  tree(
    bintree(nums.map(n => str(n))),
    spread: 1.5,
    draw-node: draw_node,
    name: "tree"
  )

  let half = calc.div-euclid(nums.len(), 2)
  for i in range(nums.len()).slice(0, half) {
    number(i, str(half - i - 1))
  }
})