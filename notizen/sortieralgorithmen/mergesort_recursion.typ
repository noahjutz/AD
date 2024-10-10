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
    return nums
  }
  let a1 = nums.slice(0, m)
  let a2 = nums.slice(m, n)
  return (nums, split(a1), split(a2))
}

#let merge(a1, a2) = {

}

#let contentify(nums) = {
  // todo
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
    "todo"
  )
)

#import "@preview/cetz:0.2.2"

#let deepmap(tuple) = {
  let l = ()
  for x in tuple {
    if type(x.at(0)) == array {
      l.push(deepmap(x))
    }
    else {
      l.push(repr(x))
    }
  }
  return l
}

#cetz.canvas({
  cetz.tree.tree(
    deepmap(split(nums))
  )
})