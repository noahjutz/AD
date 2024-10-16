#import "@preview/cetz:0.2.2"
#import "/config.typ": theme

#let nums = (34, 45, 12, 34)
#let n = nums.len()

#show table.cell: box.with(width: 18pt)

#let row(
  nums,
  is_complete: false
) = table(
  columns: nums.len(),
  align: center,
  inset: (x: 0pt, y: 4pt),
  fill: if is_complete {theme.success_light},
  ..nums.map(n => str(n))
)

#let split(nums) = {
  let n = nums.len()
  let m = calc.div-euclid(n, 2)
  if nums.len() == 1 {
    return nums
  }
  let a1 = nums.slice(0, m)
  let a2 = nums.slice(m, n)
  return (nums, a1, a2)
}

#let merge(a1, a2) = {

}


#let deepmap(tuple) = {
  let l = ()
  for x in tuple {
    if type(x.at(0)) == array {
      l.push(deepmap(x))
    }
    else {
      l.push(row(x))
    }
  }
  return l
}

#let fig(nums) = {
  if nums.len() == 1 {
    return row(nums)
  }
  let (m, l, r) = split(nums)

  stack(
    dir: ttb,
    spacing: 4pt,
    row(m),
    stack(
      dir: ltr,
      spacing: 8pt,
      fig(l),
      fig(r),
    ),
    row(m.sorted(), is_complete: true)
  )
}

#align(
  center,
  block(
    breakable: false,
    fig(nums)
  )
)
