#import "/config.typ": theme
#import "@preview/fletcher:0.5.3": diagram, node, edge

#show table.cell: box.with(width: 20pt, height: 20pt)

#diagram(
  spacing: (16pt, 16pt),
  node-inset: 0pt,
  node-shape: rect,
  node((0, 0), name: <v0>)[
    #table(
      columns: 2,
      table.cell(fill: theme.primary_light)[0],
      table.cell(fill: theme.secondary_light)[2],
    )
  ],
  node((rel: (-8pt, 0pt), to: <v0.west>))[$v_0$],
  node((1, 0), name: <v1>)[
    #table([])
  ],
  node((rel: (-8pt, 0pt), to: <v1.west>))[$v_1$],
  node((2, 0), name: <v2>)[
    #table(
      table.cell(fill: theme.tertiary_light)[1]
    )
  ],
  node((rel: (-8pt, 0pt), to: <v2.west>))[$v_2$],
  node((1, 1), name: <array>)[
    #table(columns: 3, "0", "2", "1")
  ],
  edge(<v0.south>, "-|>", <array>),
  edge(<v1.south>, "-|>", <array>),
  edge(<v2.south>, "-|>", <array>)
)