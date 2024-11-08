#import "/config.typ": theme
#import "@preview/cetz:0.3.1"
#import cetz.draw: *
#import cetz.tree: tree

#let draw_node(node, parent) = {
  circle((), radius: 4pt)
}

#let named_tree(nodes) = {
  return tree(
    named_tree_nodes(nodes),
    draw-node: named_tree_draw_node(nodes),
    draw-edge: named_tree_draw_edge(nodes),
    name: "named_tree"
  )
}

#cetz.canvas({
  tree(
    ("z", ("l", "ll", "lr"), ("r", ("y", "yl", "yr"), "rr")),
    draw-node: draw_node,
    name: "tree"
  )

  for _ in range(2) {
    line(
      (rel: (8pt, 8pt), to: "tree.0"),
      (rel: (-8pt, -8pt), to: "tree.0"),
      stroke: 2pt + theme.primary
    )
    scale(x: -1)
  }
})
