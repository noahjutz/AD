#import "/components/lefttree.typ": lefttree, draw_node, note, connect, bent_line, fade

#import "@preview/cetz:0.3.1"

#cetz.canvas({
  import cetz.draw: *
  import cetz.tree: tree

  tree(
    lefttree((34, 45, 38).map(n => str(n))),
    draw-node: draw_node.with(hl_primary: 0),
    spread: 2,
    name: "tree"
  )

  note(0, ang: 0deg)[root]
  note(1, ang: 180deg)[largest]
  connect(
    0, 1,
    bent_line.with(bend: -.5, mark: (symbol: ">"))
  )

  fade(1, ang: -45deg)
  fade(2, ang: -45deg)
  fade(1, ang: 225deg)
  fade(2, ang: 225deg)
})