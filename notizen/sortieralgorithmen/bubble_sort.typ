#import "components.typ": num_row, empty_row
#import "/config.typ": theme

#let row_swap(nums, i, j, is_swap) = num_row(
  nums,
  hl1: i,
  hl2: j,
  arrow: (
    from: j,
    to: j+1,
    direction: "bidirectional",
    color: if is_swap {black} else {theme.fg_light}
  )
)

#let row_done(nums, i) = num_row(
  nums,
  hl: range(i)
)

#let rows(nums) = {
  for i in range(nums.len()-1) {
    for j in range(i, nums.len()-1).rev() {
      if nums.at(j) > nums.at(j+1) {
        row_swap(nums, i, j, true)
        let h = nums.at(j)
        nums.at(j) = nums.at(j+1)
        nums.at(j+1) = h
      } else {
        row_swap(nums, i, j, false)
      }
    }
    row_done(nums, i+2)
    empty_row(nums.len()+1)
  }
}

#let bubble_sort(..nums) = table(
  columns: (1fr, ) * nums.pos().len() + (auto,),
  align: center,
  stroke: none,
  ..rows(nums.pos())
)