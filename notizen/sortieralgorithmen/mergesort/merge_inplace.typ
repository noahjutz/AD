#import "/components/num_row.typ": num_row, arrowed

#let nums = (12, 23, 34, 34, 45, 7, 17, 18, 38, 43)
#let n = nums.len()
#let a1f = 0
#let a2f = calc.div-euclid(n, 2)

#let a1s(nums) = {
  return nums.enumerate()
    .filter(((i, x)) => x in (12, 23, 34, 45))
    .map(((i, x)) => i)
}

#let a2s(nums) = {
  return nums.enumerate()
    .filter(((i, x)) => x in (7, 17, 18, 38, 43))
    .map(((i, x)) => i)
}

#let min_idx(nums, a1f, a2f) = {
  if nums.at(a1f) <= nums.at(a2f) {
    return a1f
  } else {
    return a2f
  }
}

#let numrow(nums, a1f, a2f) = num_row(
  nums,
  hl_primary: a1s(nums).filter(n => n != a1f),
  hl_secondary: a2s(nums).filter(n => n != a2f),
  hl_tertiary: (a1f, a2f),
  arrow: (
    from: min_idx(nums, a1f, a2f),
    to: a1f
  ),
  labels: (
    (a1f, a1f+1, arrowed[`a1f`]),
    (a2f, a2f+1, arrowed[`a2f`])
  )
)

#let step(step, nums, a1f, a2f) = {
  for i in range(step) {
    let minidx = min_idx(nums, a1f, a2f)
    nums.insert(a1f, nums.remove(minidx))
    a1f += 1
    if minidx == a2f {a2f += 1}
  }
  return (nums, a1f, a2f)
}

#table(
  columns: (auto,) + (1fr,) * nums.len(),
  align: center,
  ..for i in range(3) {
    numrow(
      ..step(i, nums, a1f, a2f)
    )
  }
)

#align(center, [...])