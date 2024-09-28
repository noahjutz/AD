#import "components.typ": num_row, arrow_row, empty_row
#import "/config.typ": theme

#let nums = (34, 45, 12, 34, 23, 18, 38, 17, 43, 51)

#let row_1(nums, i, key) = num_row(
  nums,
  hl1: i,
  hl3: -1,
  prefix: (str(key),),
  arrow: (
    from: i,
    to: -1
  )
)

#let row_2(nums, i, j, key) = num_row(
  nums,
  hl1: i,
  hl2: j,
  prefix: (str(key),),
  arrow: (
    from: j,
    to: j+1
  )
)

#let row_3(nums, i, j, key) = num_row(
  nums,
  hl1: i,
  hl2: j,
  hl3: -1,
  prefix: (str(key),),
  arrow: (
    from: -1,
    to: j+1
  )
)

#let row_4(nums, i) = num_row(
  nums,
  prefix: ([],),
  hl: range(i+1)
)

#let rows(nums) = {
  for i in range(1, nums.len()) {
    let key = nums.at(i)
    row_1(nums, i, key)
    let j = i - 1
    while j >= 0 {
      if nums.at(j) < key {break}
      row_2(nums, i, j, key)
      nums.at(j+1) = nums.at(j)
      j -= 1
    }
    row_3(nums, i, j, key)
    nums.at(j+1) = key
    row_4(nums, i)
  }
}

#table(
  columns: (1fr,) * (nums.len()+1) + (auto,),
  align: center,
  stroke: black,
  ..rows(nums)
)