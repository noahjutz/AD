#import "@preview/cetz:0.2.2"
#import "/config.typ": theme

#let row(
  nums,
  is_complete: false
) = table(
  columns: nums.len(),
  align: center + horizon,
  fill: if is_complete {theme.success_trans},
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

#let mergesort_recursion(nums, spacing: 8pt) = {
  if nums.len() == 1 {
    return row(nums)
  }
  let (all, l, r) = split(nums)

  stack(
    dir: ttb,
    spacing: 4pt,
    row(all),
    stack(
      dir: ltr,
      spacing: spacing,
      mergesort_recursion(l),
      mergesort_recursion(r),
    ),
    row(all.sorted(), is_complete: true)
  )
}
