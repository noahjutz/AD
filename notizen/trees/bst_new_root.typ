#import "/config.typ": theme
#import "/components/named_tree.typ": named_tree
#import "/components/cetz_util.typ": connect
#import "@preview/cetz:0.3.1"
#import cetz.draw: *

#let connect = connect.with(
  from_shape: circle.with(radius: 3pt),
  to_shape: circle.with(radius: 3pt)
)

#let hidden = (
  fill: none,
  stroke: none
)

#cetz.canvas({
  named_tree(spread: .5, grow: .5, (
    name: "to",
    node: (fill: theme.primary_light),
    l: (
      l: (
        l: (node: hidden),
        r: (node: hidden)
      ),
      r: (
        l: (node: hidden),
        r: (node: hidden)
      )
    ),
    r: (
      l: (
        l: (
          name: "from",
          node: (stroke: theme.fg_dark),
        ),
        r: (node: hidden)
      ),
      r: (
        l: (node: hidden),
        r: (node: hidden)
      )
    )
  ))

  get-ctx(ctx => {
    let a = ctx.nt_anchors
    for key in a.keys() {
      a.at(key) = "tree." + a.at(key)
    }

    connect(
      a.from,
      a.to,
      line.with(
        mark: (end: ">"),
        stroke: (paint: theme.fg_dark, dash: "dashed")
      )
    )
  })
})