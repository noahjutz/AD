#import "/config.typ": theme
#import "@preview/diagraph:0.3.0": render
#import "@preview/cetz:0.3.1"
#import "@preview/oxifmt:0.2.1": strfmt

#show table.cell: box.with(width: 20pt)

#let underbrace(l, c) = cetz.canvas(length: 20pt, {
  import cetz.draw: *
  set-style(content: (padding: (top: 4pt)))
  cetz.decorations.flat-brace((l, 0), (0, 0), name: "b")
  content("b.content", c)
})

#let col(c) = "\"" + c.to-hex() + "\""

#render(
  strfmt(
    "digraph {{
      node [fontname=\"Noto Sans\", height=0, margin=.03, shape=circle]
      edge [arrowhead=vee, len=.5]

      0 -> 1 [color={p}]
      0 -> 2 [color={p}]
      0 -> 3 [color={p}]
      1 -> 3 [color={s}]
      1 -> 2 [color={s}]
      1 -> 5 [color={s}]
      5 -> 1 [color={t}]
      4
    }}",
    p: col(theme.primary),
    s: col(theme.secondary),
    t: col(theme.tertiary)
  ),
  engine: "neato",
  labels: range(6).map(i => (str(i), $v_#i$)).to-dict()
)

#let p = table.cell.with(fill: theme.primary_light)
#let s = table.cell.with(fill: theme.secondary_light)
#let t = table.cell.with(fill: theme.tertiary_light)

#block(below: 2pt)[
  #stack(
    dir: ltr,
    align(horizon)[
      #box(width: 24pt)[$E=$]
    ],
    table(
      columns: 7,
      align: center,
      p("1"), p("2"), p("3"),
      s("2"), s("3"), s("4"),
      t("1")
    )
  )
]
#stack(
  dir: ltr,
  h(24pt),
  underbrace(3 * 20pt)[$v_0$],
  underbrace(3 * 20pt)[$v_1$],
  underbrace(1 * 20pt)[$v_5$],
)