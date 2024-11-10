#import "/config.typ": theme
#import "/components/cetz_util.typ": boxed
#import "/components/named_tree.typ": named_tree
#import "@preview/cetz:0.3.1"
#import cetz.draw: *


#let greyed = (
  fill: white.transparentize(50%),
  stroke: (paint: theme.fg_dark, dash: "dashed")
)

#let hidden = (
  fill: none,
  stroke: none
)

#let ellipsis = content.with(())[...]
#let nil = content.with((), frame: "rect", stroke: none, padding: 4pt, text(fill: theme.fg_dark, "nil"))

#cetz.canvas({
  named_tree((
    name: "z",
    draw: () => {
      for _ in range(2) {
        line(
          (8pt, 8pt),
          (-8pt, -8pt),
          stroke: 2pt + theme.primary
        )
        scale(x: -1)
      }
    },
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
        l: (node: hidden),
        r: (node: hidden)
      ),
      r: (
        l: (node: hidden),
        r: (node: hidden)
      )
    )
  ))
})

#block(spacing: 0pt)[
  #sym.arrow.b
]

#stack(
  dir: ltr,
  spacing: 12pt,
  cetz.canvas({
    named_tree((
      l: (
        l: (node: hidden),
        r: (node: hidden)
      ),
      r: (
        l: (node: hidden),
        r: (node: hidden)
      )
    ))
  }),
  cetz.canvas({
    named_tree((
      l: (
        l: (node: hidden),
        r: (node: hidden)
      ),
      r: (
        l: (node: hidden),
        r: (node: hidden)
      )
    ))
  }),
)