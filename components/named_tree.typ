#import "@preview/cetz:0.3.1"
#import cetz.draw: *

#let named_tree_nodes(root) = {
  let nodes = (root.name,)
  if "l" in root.keys() {
    nodes.push(named_tree_nodes(root.l))
  }
  if "r" in root.keys() {
    nodes.push(named_tree_nodes(root.r))
  }
  return nodes
}

#let named_tree_parse(root, anc: "0") = {
  let nodes = (anc: root)
  if "l" in root.keys() {
    nodes += named_tree_parse(root.l, anc: anc + "-0")
  }
  if "r" in root.keys() {
    nodes += named_tree_parse(root.r, anc: anc + "-1")
  }
  return nodes
}

#let named_tree_draw_node(node, parent) = get-ctx(ctx => {
  let a = ctx.named_tree
  circle(
    (),
    radius: 5pt,
  )
})

#let named_tree(root) = {
  import cetz.tree: tree

  set-ctx(ctx => {
    ctx.named_tree = named_tree_parse(root)
    return ctx
  })

  tree(
    named_tree_nodes(root),
    draw-node: named_tree_draw_node,
    // draw-edge: named_tree_draw_edge(nodes),
    name: "tree"
  )
}