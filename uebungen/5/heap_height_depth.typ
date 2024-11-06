#import "/components/lefttree.typ": lefttree, draw_node
#import "@preview/cetz:0.3.1"

#cetz.canvas({
  import cetz.draw: *
  import cetz.tree: tree

  tree(
    lefttree(([],)*10),
    draw-node: draw_node
  )
})