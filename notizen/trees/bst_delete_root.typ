#import "/config.typ": theme
#import "@preview/cetz:0.3.1"
#import cetz.draw: *
#import cetz.tree: tree
#import cetz.coordinate: resolve
#import cetz.vector as vec

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

#let boxed(..points, inset: 10pt, fun) = get-ctx(ctx => {
  let min_x = calc.inf
  let max_x = -calc.inf
  let min_y = calc.inf
  let max_y = -calc.inf

  for node in points.pos() {
    let (_, (x, y, z)) = resolve(ctx, node)
    min_x = calc.min(min_x, x)
    max_x = calc.max(max_x, x)
    min_y = calc.min(min_y, y)
    max_y = calc.max(max_y, y)
  }

  let (_, a, b) = resolve(ctx, (0, 0), (0, inset))
  let dist = vec.dist(a, b)

  min_x -= dist
  max_x += dist
  min_y -= dist
  max_y += dist

  fun(
    (min_x, min_y),
    (max_x, max_y)
  )
})

#let named_tree(root) = {
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
    name: "root",
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

    for _ in range(2) {
      line(
        (rel: (8pt, 8pt), to: a.root),
        (rel: (-8pt, -8pt), to: a.root),
        stroke: 2pt + theme.primary
      )
      scale(x: -1)
    }

    boxed(a.l, a.lr, a.ll, rect.with(radius: 5pt))
    boxed(a.r, a.rr, a.yl, rect.with(radius: 5pt))
  })
})
