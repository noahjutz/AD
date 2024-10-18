#import "components.typ": bintree, draw_node, note, connect, bent_line

#import "@preview/cetz:0.2.2"

#cetz.canvas({
  import cetz.draw: *
  import cetz.tree: tree

  tree(
    bintree((34, 45, 38).map(n => str(n))),
    draw-node: draw_node.with(hl_primary: 0, hl_secondary: 1),
    spread: 2,
    name: "tree"
  )

  note(0, ang: 0deg)[key]
  note(1, ang: 180deg)[max]
  connect(
    0, 1,
    bent_line.with(bend: -.5, mark: (symbol: ">"))
  )
})