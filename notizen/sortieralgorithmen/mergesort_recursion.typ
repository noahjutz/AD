#let nums = (34, 45, 12, 34, 23, 18, 38, 17, 43, 7)
#let n = nums.len()

#let row(nums, splits: ()) = table(
  align: center,
  row-gutter: range(nums.len())
    .map(i => if i in splits {4pt} else {auto}),
  ..nums.map(n => str(n))
)

#block(
  breakable: false,
  align(
    horizon,
    stack(
      dir: ltr,
      spacing: 4pt,
      row(nums),
      row(nums, splits: (n/2-1,))
    )
  )
)