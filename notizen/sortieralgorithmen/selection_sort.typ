#import "components.typ": num_row

#let swap_row(nums, i, j) = num_row(
  nums,
  hl1: i,
  hl2: j,
  arrow: (
    from: j,
    to: i,
    direction: "bidirectional"
  )
)

#let rows(nums) = {
  let min_index(nums, i) = {
    let x = calc.min(..nums.slice(i, nums.len()))
    let (j, ..) = nums.enumerate()
      .find(((.., n)) => n == x)
    return j

  }
  for i in range(nums.len()) {
    let j = min_index(nums, i)
    swap_row(nums, i, j)

    let h = nums.at(i)
    nums.at(i) = nums.at(j)
    nums.at(j) = h
  }
}

#let selection_sort(..nums) = table(
  columns: (1fr,) * nums.pos().len() + (auto,),
  align: center,
  ..rows(nums.pos())
)