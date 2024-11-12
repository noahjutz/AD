#import "/config.typ": theme
#import "/components/lefttree.typ": lefttree, draw_node, index_to_name as i2n
#import "/components/cetz_util.typ": note
#import "@preview/cetz:0.3.1"


#let n = 10

#stack(dir: ltr, spacing: 12pt,
  cetz.canvas({
    import cetz.draw: *
    import cetz.tree: tree

    tree(
      lefttree(([],)*n),
      draw-node: draw_node.with(radius: 2pt),
      spread: .6,
      grow: .6,
      name: "tree"
    )

    for i in range(n - 1, calc.ceil(n/2)-1, step: -1) {
      line(
        (rel: (-4pt, -4pt), to: i2n(i)),
        (rel: (4pt, 4pt), to: i2n(i))
      )
    }
    for i in range(n) {
      note(
        pos: i2n(i),
        dist: 5pt,
        text(
          fill: theme.fg_dark,
          str(
            calc.floor(calc.log(n/(i+1), base: 2))
          )
        )
      )
    }
  }),
  align(horizon, sym.arrow),
  cetz.canvas({
    import cetz.draw: *
    import cetz.tree: tree

    let new_n = calc.floor(n/2)

    tree(
      lefttree(([],)*new_n),
      draw-node: draw_node.with(radius: 2pt),
      spread: .6,
      grow: .6,
      name: "tree"
    )

    for i in range(new_n) {
      note(
        pos: i2n(i),
        dist: 5pt,
        text(
          fill: theme.fg_dark,
          str(
            calc.floor(calc.log(new_n/(i+1), base: 2))
          )
        )
      )
    }
  })
)