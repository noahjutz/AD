#import "/config.typ": theme
#import "/components/named_tree.typ": named_tree
#import "@preview/cetz:0.3.1"

#let hidden = (
  fill: none,
  stroke: none
)

#cetz.canvas({
  named_tree(spread: .5, grow: .5, (
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
          node: (stroke: gray)
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