#import "components.typ": num_row, arrow_row, empty_row
#import "/config.typ": theme

#let nums = (34, 45, 12, 34, 23, 18, 38, 17, 43, 51)

#let rows(nums) = {
  for i in range(nums.len()) {
    for j in range(i, nums.len()-1).rev() {
      num_row(
        nums,
        hl1: i,
        hl2: j,
        j+1
      )
      arrow_row(
        j,
        j+1,
        nums.len(),
        direction: "bidirectional"
      )
    }

    num_row(
      nums,
      frame: (
        from: 0,
        to: i,
        color: theme.success
      )
    )

    empty_row(nums.len())
  }
}

#table(
  columns: nums.len(),
  align: center,
  stroke: none,
  ..rows(nums)
)