#import "/config.typ": theme
#import "/components/math.typ": hlp, hls, hlt
#import "@preview/fletcher:0.5.3": diagram, node, edge

#show table: it => box(
  stroke: (left: 1pt, right: 1pt),
  inset: 4pt,
)[
  #place(dx: -4pt, dy: -4pt, line(length: 8pt))
  #place(dx: -4pt, dy: 100% + 4pt, line(length: 8pt))
  #place(dx: 100% -4pt, dy: -4pt, line(length: 8pt))
  #place(dx: 100% -4pt, dy: 100% + 4pt, line(length: 8pt))
  #it
]

#block(width: 100%)[
  #set align(center + horizon)
  #stack(
    dir: ltr,
    spacing: 12pt,
    diagram(
      //debug: true,
      spacing: (16pt, 20pt),
      node-stroke: 2pt,
      edge-stroke: 2pt,
      mark-scale: 60%,
      node(name: <0>)[$v_0$],
      node(name: <1>, (0, 1))[$v_1$],
      node(name: <2>, (0, 2))[$v_2$],
      edge(
        <0>, "->", <0>,
        stroke: theme.primary,
        bend: 130deg
      ),
      edge(
        <0>, "->", <2>,
        stroke: theme.secondary,
        bend: -45deg
      ),
      edge(
        <2>, "->", <1>,
        stroke: theme.tertiary
      )
    ),
    table(
      columns: 3,
      stroke: none,
      table.cell(fill: theme.primary_light)[1],
      "0",
      table.cell(fill: theme.secondary_light)[1],
      "0", "0", "0",
      "0", table.cell(fill: theme.tertiary_light)[1], "0"
    )
  )
]