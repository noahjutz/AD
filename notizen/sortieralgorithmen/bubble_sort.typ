#import "components.typ": num_row, arrow_row, empty_row
#import "/config.typ": theme

#let nums = (34, 45, 12, 34, 23, 18, 38, 17, 43, 7)

#let rows(nums) = {
  for i in range(nums.len()) {
    for j in range(i, nums.len()-1).rev() {
      num_row(
        nums,
        hl1: i,
        hl2: j,
        j+1,
        frame: (
          from: i,
          to: nums.len() - 1,
          color: theme.fg_light
        )
      )
      arrow_row(
        j,
        j+1,
        nums.len(),
        direction: "bidirectional",
        crossed: nums.at(j) <= nums.at(j+1)
      )

      if nums.at(j) > nums.at(j+1) {
        let h = nums.at(j)
        nums.at(j) = nums.at(j+1)
        nums.at(j+1) = h
      }
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