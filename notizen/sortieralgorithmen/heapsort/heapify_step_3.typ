#import "components.typ": bintree, draw_node, note, connect, bent_line

#import "@preview/cetz:0.2.2"

#cetz.canvas({
  import cetz.draw: *
  import cetz.tree: tree

  tree(
    bintree((43, 34, 23).map(n => str(n))),
    draw-node: draw_node.with(hl_primary: 1),
    spread: 2,
    name: "tree"
  )
})