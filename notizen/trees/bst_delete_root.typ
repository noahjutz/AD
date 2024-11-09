#import "/config.typ": theme
#import "/components/cetz_util.typ": boxed
#import "/components/named_tree.typ": named_tree
#import "@preview/cetz:0.3.1"

#cetz.canvas({
  import cetz.draw: *
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
      l: (:),
      r: (:)
    ),
    r: (
      l: (
        l: (:),
        r: (:)
      ),
      r: (:)
    )
  ))

  on-layer(-1, {
    boxed(
      "tree.0-0", "tree.0-0-1", "tree.0-0-0",
      rect.with(radius: 5pt, stroke: none, fill: theme.primary_light)
    )
    boxed(
      "tree.0-1", "tree.0-1-1", "tree.0-1-0-0",
      rect.with(radius: 5pt, stroke: none, fill: theme.secondary_light)
    )
  })
})