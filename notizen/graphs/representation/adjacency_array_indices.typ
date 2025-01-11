#import "/config.typ": theme
#import "@preview/cetz:0.3.1"

#show table.cell: box.with(width: 20pt)

#let p = table.cell.with(fill: theme.primary_light)
#let s = table.cell.with(fill: theme.secondary_light)
#let t = table.cell.with(fill: theme.tertiary_light)

#block(below: 0pt)[
  #table(
    columns: 8,
    align: center,
    stroke: (x, y) => if x < 7 and y == 1 {black},
    ..range(8).map(i => text(fill: theme.fg_dark, $e_#i$)),
    p("1"), p("2"), p("3"),
    s("2"), s("3"), s("4"),
    t("1"),
    ""
  )
]

#block(spacing: 0pt)[
#cetz.canvas({
  import cetz.draw: *
  for i in range(8) {
    circle((i*20pt, 0), radius: 0, name: "e_"+str(i))
  }

  for i in range(7) {
    circle((i*20pt + 10pt, -30pt), radius: 0, name: "v_"+str(i))
  }

  set-style(mark: (end: "straight"))
  line("v_0", "e_0")
  line("v_1", "e_3")
  line("v_5", "e_6")
  line("v_6", "e_7")
})
]

#table(
  columns: 7,
  align: center,
  stroke: (x, y) => if x < 6 and y == 0 {black},
  "0", "3", "?", "?", "?", "6", strong[_7_],
  ..range(7).map(i => text(fill: theme.fg_dark, $v_#i$))
)

// TODO explain dummy element, figure out how to store v2, v3 and v4