#import "/config.typ": theme
#import "/components/named_tree.typ": named_tree
#import "@preview/cetz:0.3.1"

#let hidden = (
  stroke: none,
)

#let triangle = cetz.draw.line.with(
  (-8pt, -8pt), (8pt, -8pt), (0, 8pt),
  close: true,
)

#grid(
  columns: 3,
  align: horizon,
  cetz.canvas({
    import cetz.draw: *
    named_tree(radius: 8pt, spread: 1, grow: 1, (
      body: $a$,
      l: (
        draw: triangle.with(fill: theme.primary_light)
      ),
      r: (
        body: $b$,
        l: (
          draw: triangle.with(fill: theme.secondary_light)
        ),
        r: (
          draw: triangle.with(fill: theme.tertiary_light)
        )
      )
    ))
  }),
  sym.arrow,
  cetz.canvas({
    import cetz.draw: *
    named_tree(radius: 8pt, spread: 1, grow: 1, (
      body: $b$,
      l: (
        body: $a$,
        l: (
          draw: triangle.with(fill: theme.primary_light)
        ),
        r: (
          draw: triangle.with(fill: theme.secondary_light)
        )
      ),
      r: (
        draw: triangle.with(fill: theme.tertiary_light)
      )
    ))
  })
)