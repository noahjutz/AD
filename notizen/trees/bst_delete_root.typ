#import "/config.typ": theme
#import "/components/lefttree.typ": lefttree, draw_node, index_to_name as i2n
#import "@preview/cetz:0.3.1"

#let l = cetz.canvas({
  import cetz.draw: *
  import cetz.tree: tree

  tree(
    lefttree(([],)*15),
    draw-node: draw_node.with(radius: 2pt),
    spread: .4,
    grow: .5,
    name: "tree"
  )

  for _ in range(2) {
    line(
      (rel: (8pt, 8pt), to: i2n(0)),
      (rel: (-8pt, -8pt), to: i2n(0)),
      stroke: 2pt + theme.primary
    )
    scale(x: -1)
  }
})

#let r = cetz.canvas({
  import cetz.draw: *
  import cetz.tree: tree

  tree(
    lefttree(([],)*15),
    spread: .4,
    grow: .5,
    draw-node: (node, ..) => if node.name != "0" {
      draw_node(node, radius: 2pt)
    },
    draw-edge: (from, to, ..) => {
      if from != "g0" {
        line(from, to)
      }
    }
  )
})

#grid(
  columns: 3,
  align: bottom,
  column-gutter: 0pt,
  l,
  align(horizon)[#sym.arrow],
  r
)