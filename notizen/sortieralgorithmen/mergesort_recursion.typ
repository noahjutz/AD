#import "@preview/cetz:0.2.2"

#let nums = (34, 45, 12, 34, 23)
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

#cetz.canvas({
  cetz.tree.tree(
    deepmap(split(nums)),
    direction: "right",
  )
})