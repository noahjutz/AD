#import "components.typ": bintree, draw_node, note, connect, bent_line

#import "@preview/cetz:0.2.2"

#cetz.canvas({
  import cetz.draw: *
  import cetz.tree: tree

  tree(
    bintree((34, 45, 38).map(n => str(n))),
    draw-node: draw_node,
    spread: 3,
    name: "tree"
  )

  note(0, ang: 45deg)[key]
  note(1, ang: 225deg)[max]
  connect(0, 1, bent_line)
})