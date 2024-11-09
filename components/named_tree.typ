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

#let named_tree_anchors(root, anc: "0") = {
  let anchors = (root.name: anc)
  if "l" in root.keys() {
    anchors += named_tree_anchors(root.l, anc: anc + "-0")
  }
  if "r" in root.keys() {
    anchors += named_tree_anchors(root.r, anc: anc + "-1")
  }
  return anchors
}

#let named_tree_styles(root) = {
  let styles = (root.name: root.at("style", default: (:)))
  if "l" in root.keys() {
    styles += named_tree_styles(root.l)
  }
  if "r" in root.keys() {
    styles += named_tree_styles(root.r)
  }
  return styles
}

#let named_tree_draw_node(node, parent) = get-ctx(ctx => {
  let a = ctx.named_tree_anchors
  let b = a.pairs().map(p => p.rev()).to-dict()
  let s = ctx.named_tree_styles
  circle(
    (),
    radius: 5pt,
    ..s.at(b.at(node.name))
  )
})

#let named_tree(root) = {
  import cetz.tree: tree

  set-ctx(ctx => {
    ctx.named_tree_anchors = named_tree_anchors(root)
    ctx.named_tree_styles = named_tree_styles(root)
    return ctx
  })

  tree(
    named_tree_nodes(root),
    draw-node: named_tree_draw_node,
    // draw-edge: named_tree_draw_edge(nodes),
    name: "tree"
  )
}