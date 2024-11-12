#import "/components/lefttree.typ": lefttree, draw_node, index_to_name as i2n, number
#import "@preview/cetz:0.3.1"

#let n = 10

#stack(dir: ltr, spacing: 12pt,
  cetz.canvas({
    import cetz.draw: *
    import cetz.tree: tree

    tree(
      lefttree(([],)*n),
      draw-node: draw_node.with(radius: 2pt),
      spread: .5,
      grow: .5,
      name: "tree"
    )

    for i in range(n - 1, calc.ceil(n/2)-1, step: -1) {
      line(
        (rel: (-4pt, -4pt), to: i2n(i)),
        (rel: (4pt, 4pt), to: i2n(i))
      )
    }

    number(0)[3]
    number(1)[2]
    number(3)[1]
    number(7)[0]
  }),
  align(horizon, sym.arrow),
  cetz.canvas({
    import cetz.draw: *
    import cetz.tree: tree

    tree(
      lefttree(([],)*calc.floor(n/2)),
      draw-node: draw_node.with(radius: 2pt),
      spread: .5,
      grow: .5,
      name: "tree"
    )

    number(0)[2]
    number(1)[1]
    number(3)[0]
  })
)