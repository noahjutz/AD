#import "/config.typ": theme
#import "@preview/cetz:0.3.1"

#show table.cell: square.with(size: 24pt, stroke: none)
#set table.cell(inset: 0pt, align: center + horizon)
#set align(center)

#grid(
  columns: 2,
  column-gutter: 4pt,
  row-gutter: 4pt,
  align: center + horizon,
  cetz.canvas(length: 24pt, {
    import cetz.draw: *
    set-style(content: (padding: 2pt))

    rect((), (2, 2), stroke: none)

    line(
      (.5, 0),
      (2, 1.5),
      mark: (symbol: "straight"),
      name: "mul1"
    )
    content("mul1.mid", anchor: "south-east", sym.dot)

    line(
      (1.5, 0),
      (2, .5),
      mark: (symbol: "straight"),
      name: "mul2"
    )
    content("mul2.mid", anchor: "south-east", sym.dot)
  }),
  {
    show table.cell.where(x: 0): box.with(
      fill: theme.primary_trans
    )
    show table.cell.where(x: 1): set text(
      fill: theme.fg_light
    )
    table(
      columns: 2,
      $M_(1 1)$,
      $M_(1 2)$,
      $M_(2 1)$,
      $M_(2 2)$,
    )
  },
  {
    show table.cell.where(y: 0): box.with(
      fill: theme.primary_trans
    )
    show table.cell.where(y: 1): set text(
      fill: theme.fg_light
    )
    table(
      columns: 2,
      $N_(1 1)$,
      $N_(1 2)$,
      $N_(2 1)$,
      $N_(2 2)$,
    )
  },
  {
    show table.cell.where(x: 0, y: 0): box.with(
      fill: theme.primary_trans
    )
    show table.cell.where(x: 1)
      .or(table.cell.where(y: 1)): set text(
      fill: theme.fg_light
    )
    table(
      columns: 2,
      $O_(1 1)$,
      $O_(1 2)$,
      $O_(2 1)$,
      $O_(2 2)$,
    )
  }
)