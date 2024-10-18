#import "components.typ": bintree, draw_node, note

#import "@preview/cetz:0.3.0"

#cetz.canvas({
  import cetz.tree: tree

  tree(
    bintree((34, 45, 38).map(n => str(n))),
    draw-node: draw_node,
    spread: 3,
    name: "tree"
  )

  note(0)[hi]
})