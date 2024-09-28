#import "components.typ": num_row, arrow_row, empty_row
#import "/config.typ": theme

#let nums = (34, 45, 12, 34, 23, 18, 38, 17, 43, 7)

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


#let rows(nums) = {
  for i in range(nums.len()) {
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
  }
}

#table(
  columns: nums.len()+1,
  align: center,
  stroke: none,
  ..rows(nums)
)