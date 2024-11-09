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
  let anchors = (:)
  if "l" in root.keys() {
    let (n, a) = _parse(root.l, anc: anc + "-0")
    nodes += n
    anchors += a
    root.remove("l")
  }
  if "r" in root.keys() {
    let (n, a) = _parse(root.r, anc: anc + "-1")
    nodes += n
    anchors += a
    root.remove("r")
  }
  nodes.insert(anc, root)
  if "name" in root.keys() {
    anchors.insert(root.name, anc)
  }
  return (nodes, anchors)
}

#let _draw_node(node, parent) = get-ctx(ctx => {
  let a = ctx.nt_nodes.at(node.name)
  set-style(radius: 5pt, fill: white)
  circle(
    (),
    ..a.at("style", default: (:))
  )
  if "draw" in a {
    group({
      set-origin(())
      move-to((0, 0))
      (a.draw)()
    })
  }
})

#let _draw_edge(from, to, ..target) = get-ctx(ctx => {
  let a = ctx.nt_nodes.at(to.slice(1))
  line(
    from,
    to,
    ..a.at("line", default: (:))
  )
})

#let named_tree(root) = {
  import cetz.tree: tree

  set-ctx(ctx => {
    let (n, a) = _parse(root)
    ctx.nt_nodes = n
    ctx.nt_anchors = a
    return ctx
  })

  tree(
    _nodes(root),
    draw-node: _draw_node,
    draw-edge: _draw_edge,
    name: "tree"
  )

}