#import "components.typ": num_row, arrow_row, empty_row
#import "/config.typ": theme

#let nums = (34, 45, 12, 34, 23, 18, 38, 17, 43, 51)

#let row_1(nums, i, key) = {
  num_row(
    nums,
    hl1: i,
    -1
  )
}

#let rows(nums) = {
  for i in range(1, nums.len()) {
    let key = nums.at(i)
    row_1(nums, i, key)
    let j = i - 1
    while j >= 0 {
      if nums.at(j) < key {break}
      nums.at(j+1) = nums.at(j)
      j -= 1
    }
    nums.at(j+1) = key
  }
}

#table(
  columns: nums.len()+1,
  align: center,
  stroke: none,
  ..rows(nums),
)