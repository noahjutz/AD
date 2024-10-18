#import "components.typ": bintree, draw_node, note, connect, bent_line, fade

#import "@preview/cetz:0.2.2"

#cetz.canvas({
  import cetz.draw: *
  import cetz.tree: tree

  tree(
    bintree((34, 43, 23).map(n => str(n))),
    draw-node: draw_node.with(hl_primary: 0),
    spread: 2,
    name: "tree"
  )
  connect(
    0, 1,
    bent_line.with(bend: -.5, mark: (symbol: ">"))
  )

  fade(0, ang: 45deg)
  fade(1, ang: -45deg)
  fade(1, ang: 225deg)
  fade(2, ang: -90deg)
})