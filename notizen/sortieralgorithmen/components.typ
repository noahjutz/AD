#import "/config.typ": theme
#import "@preview/cetz:0.2.2"

#let num_row(j, i, nums) = nums.enumerate().map(((k, n)) => {
  let stroke_style = theme.fg_light + 2pt
  let stroke = (:)
  if k == 0 {stroke.left = stroke_style}
  if k == i - 1 {stroke.right = stroke_style}
  if 0 <= k and k <= i - 1 {
    stroke.bottom = stroke_style
    stroke.top = stroke_style
  }

  table.cell(
    fill: if k == i {
      theme.primary_light
    } else if k == j {
      theme.secondary_light
    },
    stroke: stroke,
    str(n),
  )
})

#let finished_row(i, nums) = nums.enumerate().map(((k, n)) => {
  let stroke-style = 2pt + theme.success
  let stroke = (:)
  if k == 0 {stroke.left = stroke-style}
  if k == i - 1 {stroke.right = stroke-style}
  if 0 <= k and k <= i - 1 {
    stroke.bottom = stroke-style
    stroke.top = stroke-style
  }
  table.cell(
    stroke: stroke,
    str(n)
  )
})

#let arrow(
  length,
  direction,
  key,
  crossed
) = cetz.canvas(length: 100%, {
  import cetz.draw: *

  if crossed {
    set-style(stroke: (paint: theme.fg_light, dash: "dashed"))
  }

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
  let (mark_from, mark_to) = if direction == "left" {
    ("arc_start", "line_start.start")
  } else {
    ("arc_end", "line_end.start")
  }
  let m
  mark(
    mark_from,
    mark_to, 
    symbol: "straight",
    length: 6pt,
  )

  if key != none {
    content(
      "line_mid.mid",
      anchor: "south",
      padding: 4pt,
      str(key)
    )
  }
})

#let arrow_row(
  from,
  to,
  n,
  key: none,
  crossed: false
) = {
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
        if to > from {"right"} else {"left"},
        key,
        crossed
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

