#import "/config.typ": theme
#import "@preview/cetz:0.2.2"

#let arrow(
  length,
  direction
) = cetz.canvas(length: 100%, {
  import cetz.draw: *

  let u = 1/(length+1)

  let tl = (u/2, 0)
  let tr = (1-u/2, 0)

  if length == 0 {
    tl = (0, 0)
    tr = (1, 0)
  }

  line(
    tl,
    (rel: (0, -6pt)),
    name: "line_start"
  )
  arc(
    "line_start.end",
    start: 180deg,
    stop: 270deg,
    radius: u/2,
    name: "arc_start"
  )
  line(
    tr,
    (rel: (0, -6pt)),
    name: "line_end"
  )
  arc(
    "line_end.end",
    start: 0deg,
    stop: -90deg,
    radius: u/2,
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

#let arrow_row(
  from,
  to,
  n,
  offset: 0,
  direction: "normal" // normal, reversed, bidirectional, none
) = {
  from += offset
  to += offset
  let min = calc.min(from, to)
  let max = calc.max(from, to)
  let row = ()

  if min > 0 {
    row.push(
      table.cell(
        colspan: min,
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
      arrow(
        max - min,
        if direction == "bidirectional" {
          "bidirectional"
        } else if direction == "none" {
          "none"
        } else if direction == "normal" {
          if to > from {"right"} else {"left"}
        } else if direction == "reversed" {
          if to < from {"right"} else {"left"}
        },
      )
    )
  )
  if n - max - 1 > 0 {
    row.push(
      table.cell(
        colspan: n - max - 1,
        ""
      )
    )
  }
  return row
}

#let empty_row(n) = (
  table.cell(colspan: n, ""),
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
  let cell_stroke(i, frame) = {
    let style = frame.color
    let stroke = (:)
    if i == 0 {
      stroke.left = 1pt
    }
    if i == frame.start {
      stroke.left = style
    }
    if i == frame.end {
      stroke.right = style
    }
    if i <= frame.start and frame.end <= i {
      stroke.bottom = style
      stroke.top = style
    }
    return stroke
  }
  let columns = ()
  columns += prefix
  columns += nums.map(n => str(n))
  columns = columns.enumerate().map(((i, col)) => {
    i = i - prefix.len()
    table.cell(
      fill: if i == hl1 {
        theme.primary_light
      } else if i == hl2 {
        theme.secondary_light
      } else if i == hl3 {
        theme.tertiary_light
      } else if i in hl {
        theme.success_light
      },
      stroke: if frame != none {cell_stroke(i, frame)},
      col
    )
  })

  columns.push(table.cell(
    rowspan: if arrow != none {2} else {1},
    inset: 0pt,
    ""
  ))

  if arrow != none {
    columns += arrow_row(
      arrow.from,
      arrow.to,
      nums.len() + prefix.len(),
      offset: prefix.len()
    )
  }

  return columns
}