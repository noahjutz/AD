#import "/config.typ": theme
#import "/components/named_tree.typ": named_tree
#import "/components/cetz_util.typ": boxed
#import "@preview/cetz:0.3.1"
#import cetz.draw: *

#let hidden = (
  fill: none,
  stroke: none
)

#cetz.canvas({
  named_tree(spread: .8, grow: .8, (
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
      line: (mark: (end: "straight")),
      l: (
        line: (mark: (end: "straight")),
        l: (
          line: (mark: (end: "straight")),
          node: (fill: theme.primary_light),
        ),
        r: (node: hidden)
      ),
      r: (
        l: (node: hidden),
        r: (node: hidden)
      )
    )
  ))

  on-layer(-1, {
    boxed(
      "tree.0-1", "tree.0-1-0-0", "tree.0-1-1",
      rect.with(
        stroke: none,
        radius: 6pt,
        fill: theme.tertiary_light
      )
    )
  })
})