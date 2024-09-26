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
    let u = 1/length
    bezier(
      (u, 0),
      (1, 0),
      (u, -20pt),
      (1, -20pt),
      mark: if direction == "right" {
        (end: ">")
      } else {
        (start: ">")
      }
    )
  }
)

#let arrow_row(from, to, n: nums.len()) = {
  let min = calc.min(from, to)
  let max = calc.max(from, to)
  return (
    if min - 1 > 0 {
      table.cell(
        colspan: min - 1,
        ""
      )
    },
    table.cell(
      colspan: max - min,
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
    ),
    if n - max - 1 > 0 {
      table.cell(
        colspan: n - max - 1,
        ""
      )
    }
  )
}

#table(
  columns: nums.len(),
  align: center,
  stroke: none,
  ..row(1, 2, nums),
  ..arrow_row(0, 2),
  ..row(0, 2, nums),
  ..arrow_row(5, 0),
)