#import "/config.typ": theme
#import "@preview/cetz:0.2.2"

#show table: set text(font: "Noto Sans Mono")

#let nums = (34, 45, 12, 34, 23, 18, 38, 17, 43, 51)

#let row(j, i, nums) = nums.enumerate().map(((k, n)) => {
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

#let arrow(length, direction) = cetz.canvas(
  length: 100%,
  {
    import cetz.draw: *
    let u = 1/(length+1)
    line(
      (u/2, 0),
      (u/2, -6pt),
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
      (1-u/2, 0),
      (1-u/2, -6pt),
      name: "line_end"
    )
    arc(
      "line_end.end",
      start: 0deg,
      stop: -90deg,
      radius: u/2,
      name: "arc_end"
    )
    line("arc_start.end", "arc_end.end")
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
  }
)

#let arrow_row(from, to, n: nums.len()) = {
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
        if to > from {"right"} else {"left"}
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

#let rows(nums) = {
  let rows = ()
  let nums = array(nums)
  for i in range(nums.len()) {
    for j in range(i - 1, -1, step: -1) {
      rows.push(row(j, i, nums))
      rows.push(arrow_row(j, i))
    }
  }
  return rows.flatten()
}

#table(
  columns: nums.len(),
  align: center,
  stroke: none,
  // ..row(1, 2, nums),
  ..row(0, 2, nums),
  ..arrow_row(0, 1),
  //..rows(nums)
)