#import "/config.typ": theme

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

#table(
  columns: nums.len(),
  align: center,
  stroke: none,
  ..row(1, 2, nums),
  ..([],)*nums.len(),
  ..row(0, 2, nums),
)