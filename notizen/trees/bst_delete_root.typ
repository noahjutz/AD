#import "/config.typ": theme
#import "/components/cetz_util.typ": boxed, note
#import "@preview/cetz:0.3.1"
#import cetz.draw: *

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

#let named_tree_draw_node(node, parent) = {
  circle((), radius: 5pt)
}

#let named_tree(root) = {
  import cetz.tree: tree
  tree(
    named_tree_nodes(root),
    draw-node: named_tree_draw_node,
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
    name: "z",
    l: (
      name: "l",
      l: (
        name: "ll"
      ),
      r: (
        name: "lr"
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
          name: "x"
        )
      ),
      r: (
        name: "rr"
      )
    )
  ))


  get-ctx(ctx => {
    let a = ctx.named_tree_anchors

    for _ in range(2) {
      line(
        (rel: (8pt, 8pt), to: a.z),
        (rel: (-8pt, -8pt), to: a.z),
        stroke: 2pt + theme.primary
      )
      scale(x: -1)
    }

    boxed(a.l, a.lr, a.ll, rect.with(radius: 5pt))
    boxed(a.r, a.rr, a.yl, rect.with(radius: 5pt))
    note(a.z, ang: 90deg)[$z$]
    note(a.y, ang: 90deg)[$y$]
    note(a.r, ang: 90deg)[$r$]
    note(a.l, ang: 90deg)[$l$]
    note(a.x, ang: 90deg)[$x$]
  })
})
