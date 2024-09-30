#import "/config.typ": theme
#import "@preview/cetz:0.2.2"

#let _arrow_canvas(
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
#let _arrow_row(arrow, n, offset: 0) = {
  arrow.from += offset
  arrow.to += offset
  let min = calc.min(arrow.from, arrow.to)
  let max = calc.max(arrow.from, arrow.to)

  if min > 0 {
    (table.cell(
      colspan: min,
      stroke: none,
      ""
    ),)
  }

  (table.cell(
    colspan: max - min + 1,
    inset: (
      bottom: 0pt,
      top: 0pt,
      left: 0pt,
      right: 0pt
    ),
    stroke: none,
    _arrow_canvas(
      max - min,
      if "direction" not in arrow.keys() or arrow.direction == "normal" {
        if arrow.to > arrow.from {"right"} else {"left"}
      } else if arrow.direction == "reversed" {
        if arrow.to < arrow.from {"right"} else {"left"}
      } else {arrow.direction},
      color: if "color" in arrow.keys() {arrow.color} else {black}
    )
  ),)

  if n - max - 1 > 0 {
    (table.cell(
      colspan: n - max - 1,
      stroke: none,
      ""
    ),)
  }
}

#let _empty_row(n, pad: auto) = table.cell(
  colspan: n,
  stroke: none,
  inset: 0pt,
  box(
    height: if pad == auto {6pt}
      else if pad == none {0pt}
      else {pad}
    )
)

#let _prefix_row(prefix) = prefix.map(p => table.cell(
  stroke: theme.fg_light,
  text(fill: theme.fg_light, p)
))

#let _nums_row(
  nums,
  hl_primary,
  hl_secondary,
  hl_tertiary,
  hl_success
) = nums.enumerate().map(((i, n)) => table.cell(
  fill: if i == hl_primary {theme.primary_light}
    else if i == hl_secondary {theme.secondary_light}
    else if i == hl_tertiary {theme.tertiary_light}
    else if i in hl_success {theme.success_light},
  str(n)

))

#let num_row(
  nums,
  hl_primary: none,
  hl_secondary: none,
  hl_tertiary: none,
  hl_success: (),
  frame: none,
  arrow: none,
  below: auto,
  prefix: (),
) = {
  _prefix_row(prefix)
  _nums_row(
    nums,
    hl_primary,
    hl_secondary,
    hl_tertiary,
    hl_success
  )

  (table.cell(
    rowspan: if arrow != none {3} else {2},
    breakable: false,
    inset: 0pt,
    stroke: none,
    ""
  ),)

  if arrow != none {
    _arrow_row(
      arrow,
      nums.len() + prefix.len(),
      offset: prefix.len()
    )
  }

  (_empty_row(
    nums.len() + prefix.len(),
    pad: below
  ),)
}