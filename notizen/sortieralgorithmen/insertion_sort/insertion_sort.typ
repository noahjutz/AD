#import "/components/num_row.typ": num_row
#import "/config.typ": theme

#let row_push_key(nums, i, key) = num_row(
  nums,
  hl_primary: i,
  prefix: (str(key),),
  arrow: (
    from: i,
    to: -1,
    color: theme.fg_dark
  )
)

#let row_shift_forward(nums, i, j, key) = num_row(
  nums,
  hl_primary: i,
  hl_secondary: j,
  prefix: (str(key),),
  arrow: (
    from: j,
    to: j+1
  )
)

#let row_pop_key(nums, i, j, key) = num_row(
  nums,
  hl_primary: i,
  hl_secondary: j,
  prefix: (str(key),),
  arrow: (
    from: -1,
    to: j+1,
    color: theme.fg_dark
  )
)

#let row_complete(nums, i, key) = num_row(
  nums,
  prefix: (str(key),),
  hl_success: range(i+1),
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
  }
}

#let insertion_sort(..nums) = table(
  columns: (auto,) + (1fr,) * (nums.pos().len()+1),
  align: center,
  ..rows(nums.pos())
)