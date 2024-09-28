#import "components.typ": num_row, empty_row
#import "/config.typ": theme

#let row_push_key(nums, i, key) = num_row(
  nums,
  hl1: i,
  prefix: (str(key),),
  arrow: (
    from: i,
    to: -1,
    color: theme.fg_light
  )
)

#let row_shift_forward(nums, i, j, key) = num_row(
  nums,
  hl1: i,
  hl2: j,
  prefix: (str(key),),
  arrow: (
    from: j,
    to: j+1
  )
)

#let row_pop_key(nums, i, j, key) = num_row(
  nums,
  hl1: i,
  hl2: j,
  prefix: (str(key),),
  arrow: (
    from: -1,
    to: j+1,
    color: theme.fg_light
  )
)

#let row_complete(nums, i, key) = num_row(
  nums,
  prefix: (str(key),),
  hl: range(i+1),
)

#let rows(nums) = {
  for i in range(1, nums.len()) {
    let key = nums.at(i)
    row_push_key(nums, i, key)
    let j = i - 1
    while j >= 0 and nums.at(j) > key {
      row_shift_forward(nums, i, j, key)
      nums.at(j+1) = nums.at(j)
      j -= 1
    }
    row_pop_key(nums, i, j, key)
    nums.at(j+1) = key
    row_complete(nums, i, key)
    empty_row(nums.len() + 2)
  }
}

#let insertion_sort(nums) = table(
  columns: (1fr,) * (nums.len()+1) + (auto,),
  align: center,
  stroke: black,
  ..rows(nums)
)