#import "components.typ": bintree, draw_node, note, connect, bent_line, fade

#import "@preview/cetz:0.2.2"

#cetz.canvas({
  import cetz.draw: *
  import cetz.tree: tree

  tree(
    bintree((45, 34, 38).map(n => str(n))),
    draw-node: draw_node.with(hl_primary: 1),
    spread: 2,
    name: "tree"
  )

  fade(1, ang: -45deg)
  fade(2, ang: -45deg)
  fade(1, ang: 225deg)
  fade(2, ang: 225deg)

})