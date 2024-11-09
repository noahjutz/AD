#import "/config.typ": theme
#import "/components/named_tree.typ": named_tree
#import "@preview/cetz:0.3.1"
#import cetz.draw: *

#let hidden = (
  fill: none,
  stroke: none
)

#cetz.canvas({
  named_tree(spread: .5, grow: .5, (
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
          node: (fill: theme.secondary_light),
          l: (node: hidden, line: hidden),
          r: (
            line: (mark: (start: "straight"), stroke: theme.fg_dark),
            node: (stroke: theme.fg_dark)
          )
        ),
        r: (node: hidden)
      ),
      r: (
        l: (node: hidden),
        r: (node: hidden)
      )
    )
  ))
})