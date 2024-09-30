#import "components.typ": num_row

#let row_swap(nums, i, j) = num_row(
  nums,
  hl_primary: i,
  hl_secondary: j,
  arrow: (
    from: j,
    to: i,
    direction: "bidirectional"
  )
)

#let row_done(nums, i) = num_row(
  nums,
  hl_success: range(i+1)
)

#let rows(nums) = {
  let min_index(nums, start) = {
    let sublist = nums.slice(start, nums.len())
    return sublist.enumerate()
      .find(((i, x)) => x == calc.min(..sublist))
      .at(0) + start
  }

  for i in range(nums.len()) {
    let j = min_index(nums, i)
    row_swap(nums, i, j)

    let h = nums.at(i)
    nums.at(i) = nums.at(j)
    nums.at(j) = h

    row_done(nums, i)
    //empty_row(nums.len()+1)
  }
}

#let selection_sort(..nums) = table(
  columns: (1fr,) * nums.pos().len() + (auto,),
  align: center,
  ..rows(nums.pos())
)