#import "/config.typ": theme
#import "@preview/cetz:0.2.2"

#let arrow_canvas(
  length,
  direction,
  color: black
) = cetz.canvas(length: 100%, {
  import cetz.draw: *
  let u = 1/(length+1)
  let tl = if length == 0 {(0, 0)} else {(u/2, 0)}
  let tr = if length == 0 {(8pt, 0)} else {(1-u/2, 0)}

  stroke(color)

  line(
    tl,
    (rel: (0, -10pt)),
    name: "line_start"
  )
  arc(
    "line_start.end",
    start: 180deg,
    stop: 270deg,
    radius: 4pt,
    name: "arc_start"
  )
  line(
    tr,
    (rel: (0, -10pt)),
    name: "line_end"
  )
  arc(
    "line_end.end",
    start: 0deg,
    stop: -90deg,
    radius: 4pt,
    name: "arc_end"
  )
  line(
    "arc_start.end",
    "arc_end.end",
    name: "line_mid",
  )

  let m
  if direction in ("left", "bidirectional") {
    mark(
      "arc_start",
      "line_start.start",
      symbol: "straight",
      length: 6pt,
    )
  }
  if direction in ("right", "bidirectional") {
    mark(
      "arc_end",
      "line_end.start",
      symbol: "straight",
      length: 6pt,
    )
  }
})

// Directions: normal, reversed, bidirectional, none
#let arrow_row(arrow, n, offset: 0) = {
  arrow.from += offset
  arrow.to += offset
  let min = calc.min(arrow.from, arrow.to)
  let max = calc.max(arrow.from, arrow.to)
  let row = ()

  if min > 0 {
    row.push(
      table.cell(
        colspan: min,
        stroke: none,
        ""
      )
    )
  }

  row.push(
    table.cell(
      colspan: max - min + 1,
      inset: (
        bottom: 6pt,
        top: 0pt,
        left: 0pt,
        right: 0pt
      ),
      stroke: none,
      arrow_canvas(
        max - min,
        if "direction" not in arrow.keys() or arrow.direction == "normal" {
          if arrow.to > arrow.from {"right"} else {"left"}
        } else if arrow.direction == "reversed" {
          if arrow.to < arrow.from {"right"} else {"left"}
        } else {arrow.direction},
        color: if "color" in arrow.keys() {arrow.color} else {black}
      )
    )
  )
  if n - max - 1 > 0 {
    row.push(
      table.cell(
        colspan: n - max - 1,
        stroke: none,
        ""
      )
    )
  }
  return row
}

#let empty_row(n, pad: 6pt) = (
  table.cell(
    colspan: n,
    stroke: none,
    inset: 0pt,
    box(height: pad)
  ),
)

#let num_row(
  nums,
  hl: (),
  hl1: none,
  hl2: none,
  hl3: none,
  frame: none,
  arrow: none,
  prefix: (),
) = {
  let columns = ()
  columns += prefix
  columns += nums.map(n => str(n))
  columns = columns.enumerate().map(((i, col)) => {
    i = i - prefix.len()
    table.cell(
      fill: if i < 0 {
        none
      } else if i == hl1 {
        theme.primary_light
      } else if i == hl2 {
        theme.secondary_light
      } else if i == hl3 {
        theme.tertiary_light
      } else if i in hl {
        theme.success_light
      },
      stroke: if i < 0 {gray} else {black},
      text(
        fill: if i < 0 {gray} else {black},
        col
      )
    )
  })

  columns.push(table.cell(
    rowspan: if arrow != none {2} else {1},
    breakable: false,
    inset: 0pt,
    stroke: none,
    ""
  ))

  if arrow != none {
    columns += arrow_row(
      arrow,
      nums.len() + prefix.len(),
      offset: prefix.len()
    )
  }

  return columns
}