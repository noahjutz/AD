#let nums = (34, 45, 12, 34, 23, 18, 38, 17, 43, 7)
#let n = nums.len()

#let row(nums, splits: ()) = table(
  align: center,
  row-gutter: range(nums.len())
    .map(i => if i in splits {4pt} else {auto}),
  ..nums.map(n => str(n))
)

#let split(nums) = {
  let n = nums.len()
  let m = calc.div-euclid(n, 2)
  if nums.len() == 1 {
    return row(nums)
  }
  let a1 = nums.slice(0, m)
  let a2 = nums.slice(m, n)
  stack(
    dir: ltr,
    spacing: 4pt,
    row(nums),
    stack(
      spacing: 8pt,
      split(a1),
      split(a2)
    )
  )
}

#block(
  breakable: false,
  align(
    horizon,
    split(nums)
  )
)