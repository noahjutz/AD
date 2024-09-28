#import "components.typ": num_row, empty_row

#let row_swap(nums, i, j) = num_row(
  nums,
  hl1: i,
  hl2: j,
  arrow: (
    from: j,
    to: i,
    direction: "bidirectional"
  )
)

#let row_done(nums, i) = num_row(
  nums,
  hl: range(i+1)
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
    row_swap(nums, i, j)
    row_done(nums, i)

    let h = nums.at(i)
    nums.at(i) = nums.at(j)
    nums.at(j) = h

    empty_row(nums.len()+1)
  }
}

#let selection_sort(..nums) = table(
  columns: (1fr,) * nums.pos().len() + (auto,),
  align: center,
  ..rows(nums.pos())
)