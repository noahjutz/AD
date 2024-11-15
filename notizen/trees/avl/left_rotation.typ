#import "/config.typ": theme
#import "/components/named_tree.typ": named_tree
#import "@preview/cetz:0.3.1"

#let hidden = (
  stroke: none,
)

#cetz.canvas({
  import cetz.draw: *
  named_tree(radius: 8pt, spread: 1, grow: 1, (
    body: $a$,
    l: (
      draw: circle.with((), radius: 3pt)
    ),
    r: (
      body: $b$
    )
  ))
})