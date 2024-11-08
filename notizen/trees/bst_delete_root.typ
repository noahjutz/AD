#import "/config.typ": theme
#import "@preview/cetz:0.3.1"
#import cetz.draw: *
#import cetz.tree: tree

#let draw_node(node, parent) = {
  circle((), radius: 4pt)
}

#let named_tree_nodes(root, anc: "0") = {
  let nodes = (root.name,)
  if "l" in root.keys() {
    nodes.push(named_tree_nodes(root.l, anc: anc + "-0"))
  }
  if "r" in root.keys() {
    nodes.push(named_tree_nodes(root.r, anc: anc + "-1"))
  }
  return nodes
}

#let named_tree_anchors(root, anc: "0") = {
  let anchors = (root.name: "named_tree." + anc)
  if "l" in root.keys() {
    anchors += named_tree_anchors(root.l, anc: anc + "-0")
  }
  if "r" in root.keys() {
    anchors += named_tree_anchors(root.r, anc: anc + "-1")
  }
  return anchors
}

#let named_tree(root) = {
  tree(
    named_tree_nodes(root),
    // draw-node: named_tree_draw_node(nodes),
    // draw-edge: named_tree_draw_edge(nodes),
    name: "named_tree"
  )

  set-ctx(ctx => {
    ctx.named_tree_anchors = named_tree_anchors(root)
    return ctx
  })
}

#cetz.canvas({
  named_tree((
    name: "root",
    l: (
      name: "l",
      l: (
        name: "ll"
      ),
      r: (
        name: "rr"
      )
    ),
    r: (
      name: "r",
      l: (
        name: "y",
        l: (
          name: "yl"
        ),
        r: (
          name: "yr"
        )
      ),
      r: (
        name: "rr"
      )
    )
  ))


  get-ctx(ctx => {
    let a = ctx.named_tree_anchors

    circle(a.root, radius: 40pt)
  })
})
