#import "/config.typ": theme
#import "@preview/cetz:0.3.1"

#show table.cell: box.with(width: 20pt)

#let p = table.cell.with(fill: theme.primary_light)
#let s = table.cell.with(fill: theme.secondary_light)
#let t = table.cell.with(fill: theme.tertiary_light)

#block(below: 0pt)[
  #table(
    columns: 9,
    align: center,
    stroke: (x, y) => if x != 0 {black},
    $E=$,
    p("1"), p("2"), p("3"),
    s("2"), s("3"), s("4"),
    t("1"),
    ""
  )
]

#block(spacing: 0pt)[
#cetz.canvas({
  import cetz.draw: *
  circle((-20pt, 0), radius: 0)
  for i in range(8) {
    circle((i*20pt, 0), radius: 0, name: "e_"+str(i))
  }

  for i in range(7) {
    circle((i*20pt + 10pt, -30pt), radius: 0, name: "v_"+str(i))
  }

  //set-style(mark: (end: ">"))
  let l(a, b) = {
    bezier(
      a, (rel: (0, -8pt), to: b),
      (rel: (0, 16pt), to: a),
      (rel: (0, -24pt), to: b)
    )
    mark(b, (rel: (0, 10pt)), symbol: ">")
  }
  l("v_0", "e_0")
  l("v_1", "e_3")
  l("v_2", "e_6")
  l("v_3", "e_6")
  l("v_4", "e_6")
  l("v_5", "e_6")
  l("v_6", "e_7")
})
]

#table(
  columns: 8,
  align: center,
  stroke: (x, y) => if x != 0 and y == 0 {black},
  $V = $, p("0"), s("3"), "6", "6", "6", t("6"), strong[_7_],
  [], ..range(6).map(i => text(fill: theme.fg_dark, $v_#i$)),
)

// TODO explain dummy element, figure out how to store v2, v3 and v4