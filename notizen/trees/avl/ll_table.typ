#import "/config.typ": theme
#import "@preview/cetz:0.3.1"

#let triangle(..args) = box(inset: (x: 2pt), cetz.canvas({
  import cetz.draw: *
  line(
    (0, 0), (8pt, 0), (4pt, 8pt),
    close: true,
    ..args
  )
}))

#table(
  columns: 3,
  align: horizon,
  "Knoten", "Davor", "Danach",
  $ a $,
  $
  max(#triangle(fill: theme.primary_light), b) + 1
  $,
  $
  max(
    #triangle(fill: theme.primary_light),
    #triangle(fill: theme.secondary_light)
  ) + 1
  $,
  $ b $,
  $
  max(
    #triangle(fill: theme.secondary_light),
    #triangle(fill: theme.tertiary_light)
  ) + 1
  $,
  $
  max(a, #triangle(fill: theme.tertiary_light)) + 1
  $
)