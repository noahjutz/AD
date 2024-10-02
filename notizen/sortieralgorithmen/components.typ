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
    inset: 0pt,
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

  if max < n - 1 {
    (table.cell(
      colspan: n - max - 1,
      stroke: none,
      ""
    ),)
  }
}

#let _full_row(n, body) = table.cell(
  colspan: n,
  stroke: none,
  inset: 0pt,
  body
)

#let _empty_row(n, pad) = _full_row(
  n,
  box(height: pad)
)

#let _prefix_row(
  prefix,
  frame
) = prefix.map(p => table.cell(
  stroke: frame,
  text(fill: theme.fg_light, p) 
))

#let _nums_row(
  nums,
  hl_primary,
  hl_secondary,
  hl_tertiary,
  hl_success
) = {
  if type(hl_primary) != array {
    hl_primary = (hl_primary,)
  }
  if type(hl_secondary) != array {
    hl_secondary = (hl_secondary,)
  }
  if type(hl_tertiary) != array {
    hl_tertiary = (hl_tertiary,)
  }
  if type(hl_success) != array {
    hl_success = (hl_success,)
  }

  return nums.enumerate().map(((i, n)) => table.cell(
    fill: if i in hl_primary {theme.primary_light}
      else if i in hl_secondary {theme.secondary_light}
      else if i in hl_tertiary {theme.tertiary_light}
      else if i in hl_success {theme.success_light},
    if type(n) != content {str(n)} else {n}
  ))
}

#let _label_row(
  n,
  labels,
  align,
  offset: 0
) = {
  let first = labels.first().at(0)
  let last = labels.last().at(1)
  first += offset
  last += offset

  if first > 0 {
    (table.cell(
      colspan: first,
      inset: 0pt,
      stroke: none,
      ""
    ),)
  }

  labels.zip(labels.slice(1) + ((-1, -1, none),))
    .map((((f1, t1, b1), (f2, t2, b2))) => {
      (
        table.cell(
          colspan: t1 - f1,
          align: align,
          inset: 0pt,
          stroke: none,
          b1
        ),
        if f2 - t1 > 0 {
          table.cell(
            colspan: f2 - t1,
            inset: 0pt,
            stroke: none,
            []
          )
        }
      )
    })
    .flatten()
    .filter(it => it != none)
  
  if last < n {
    (table.cell(
      colspan: n - last,
      inset: 0pt,
      stroke: none,
      ""
    ),)
  }
}

#let _arrow_down_row(
  arrow_down,
  n,
  offset: 0
) = _full_row(n, cetz.canvas(length: 100%, {
  import cetz.draw: *
  line((0, 0), (1, 0), stroke: none)

  translate(x: .5/n)

  for (from, to, ..style) in arrow_down {
    from += offset
    to += offset
    let x_from = from / n
    let x_to = to / n

    group({
      if style.len() > 0 {
        stroke(style.at(0))
      }
      bezier(
        (x_from, 0),
        (x_to, -32pt),
        (x_from, -16pt),
        (x_to, -16pt),
        mark: (end: ">")
      )
    })
  }
}))

#let num_row(
  nums,
  hl_primary: none,
  hl_secondary: none,
  hl_tertiary: none,
  hl_success: (),
  arrow: none,
  arrow_down: none,
  labels: none,
  labels_b: none,
  below: 4pt,
  prefix: (),
  prefix_frame: theme.fg_light
) = {
  let n = prefix.len() + nums.len()

  (table.cell(
    rowspan: 2 + (arrow, arrow_down, labels, labels_b)
      .map(it => int(it != none))
      .sum(),
    breakable: false,
    inset: 0pt,
    stroke: none,
    []
  ),)

  if labels != none {
    _label_row(
      n,
      labels,
      bottom,
      offset: prefix.len()
    )
  }

  _prefix_row(prefix, prefix_frame)
  _nums_row(
    nums,
    hl_primary,
    hl_secondary,
    hl_tertiary,
    hl_success
  )

  if labels_b != none {
    _label_row(
      n,
      labels_b,
      top,
      offset: prefix.len()
    )
  }

  if arrow != none {
    _arrow_row(
      arrow,
      n,
      offset: prefix.len()
    )
  }

  if arrow_down != none {
    (_arrow_down_row(
      arrow_down,
      n,
      offset: prefix.len()
    ),)
  }

  (_empty_row(
    n,
    below
  ),)
}

#let single_num_row(
  nums,
  hl_primary: none,
  hl_secondary: none,
  hl_tertiary: none,
  hl_success: (),
  arrow: none,
  labels: none,
  below: 0pt,
  prefix: (),
) = table(
  columns: (auto,) + (1fr,) * (nums.len() + prefix.len()),
  align: center,
  ..num_row(
    nums,
    hl_primary: hl_primary,
    hl_secondary: hl_secondary,
    hl_tertiary: hl_tertiary,
    hl_success: hl_success,
    arrow: arrow,
    labels: labels,
    below: below,
    prefix: prefix
  )
)

#let braced(body) = cetz.canvas(length: 100%, {
  import cetz.draw: *
  circle((0, 0), radius: 0)

  hide(line((0, 0), (1, 0), name: "brace_line"))
  circle(
    (rel: (0, 2pt), to: "brace_line.start"),
    radius: 0,
    name: "start"
  )
  circle(
    (rel: (0, 2pt), to: "brace_line.end"),
    radius: 0,
    name: "end"
  )

  group({
    set-viewport((0, 0), (24pt, 24pt))
    cetz.decorations.flat-brace(
      "start",
      "end",
    )
  })

  content(
    (rel: (0, 16pt), to: "brace_line.mid"),
    anchor: "south",
    body
  )
})

#let arrowed(body) = cetz.canvas(length: 100%, {
  import cetz.draw: *
  circle((0, 0), radius: 0)
  line(
    (0, 14pt),
    (0, 0),
    mark: (end: ">"),
    name: "arrow"
  )
  content(
    (0, 16pt), 
    anchor: "south",
    body
  )
})

#let arrowed_b(body) = cetz.canvas(length: 100%, {
  import cetz.draw: *
  circle((0, 0), radius: 0)
  line(
    (0, -14pt),
    (0, 0),
    mark: (end: ">"),
    name: "arrow"
  )
  content(
    (0, -16pt), 
    anchor: "north",
    body
  )
})

#let braced_b(body) = cetz.canvas(length: 100%, {
  import cetz.draw: *
  circle((0, 0), radius: 0)

  hide(line((0, 0), (1, 0), name: "brace_line"))
  circle(
    (rel: (0, -2pt), to: "brace_line.start"),
    radius: 0,
    name: "end"
  )
  circle(
    (rel: (0, -2pt), to: "brace_line.end"),
    radius: 0,
    name: "start"
  )

  group({
    set-viewport((0, 0), (24pt, 24pt))
    cetz.decorations.flat-brace(
      "start",
      "end",
    )
  })

  content(
    (rel: (0, -16pt), to: "brace_line.mid"),
    anchor: "north",
    body
  )
})