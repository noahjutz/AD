#import "components.typ": bintree, draw_node, polygon_around, poly_fill
#import "@preview/cetz:0.2.2"

#let nums = (34, 45, 12, 34, 23, 18, 38, 17, 43, 7)

#cetz.canvas({
  import cetz.draw: *
  import cetz.tree: tree

  tree(
    bintree(nums.map(n => str(n))),
    draw-node: draw_node,
    spread: 1.5,
    name: "tree"
  )

  on-layer(-1, {
    polygon_around(
      5, 6,
      poly_fill
    )
    polygon_around(
      7, 8, 9,
      poly_fill
    )
  })
})