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
      r: (
        draw: triangle.with(fill: theme.primary_light)
      ),
      l: (
        body: $b$,
        l: (
          draw: triangle.with(fill: theme.secondary_light)
        ),
        r: (
          draw: triangle.with(fill: theme.tertiary_light, stroke: 2pt)
        )
      )
    ))
  }),
  sym.arrow,
  cetz.canvas({
    import cetz.draw: *
    named_tree(radius: 8pt, spread: 1, grow: 1, (
      body: $b$,
      r: (
        body: $a$,
        l: (
          draw: triangle.with(fill: theme.tertiary_light, stroke: 2pt)
        ),
        r: (
          draw: triangle.with(fill: theme.primary_light)
        )
      ),
      l: (
        draw: triangle.with(fill: theme.secondary_light)
      )
    ))
  })
)