#import "@preview/cetz:0.3.1"
#import cetz.draw: *

#let _nodes(root) = {
  let nodes = ([],)
  if "l" in root.keys() {
    nodes.push(_nodes(root.l))
  }
  if "r" in root.keys() {
    nodes.push(_nodes(root.r))
  }
  return nodes
}

#let _parse(root, anc: "0") = {
  let nodes = (:)
  if "l" in root.keys() {
    nodes += _parse(root.l, anc: anc + "-0")
    root.remove("l")
  }
  if "r" in root.keys() {
    nodes += _parse(root.r, anc: anc + "-1")
    root.remove("r")
  }
  nodes.insert(anc, root)
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
    ctx.named_tree = _parse(root)
    return ctx
  })

  tree(
    _nodes(root),
    draw-node: named_tree_draw_node,
    // draw-edge: named_tree_draw_edge(nodes),
    name: "tree"
  )

}