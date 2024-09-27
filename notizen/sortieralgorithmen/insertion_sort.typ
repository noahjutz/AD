#import "components.typ": num_row, arrow_row, empty_row
#import "/config.typ": theme

#let nums = (34, 45, 12, 34, 23, 18, 38, 17, 43, 51)

#let rows(nums) = {
  for i in range(1, nums.len()) {
    let j = i - 1
    let key = nums.at(i)
    while j >= 0 {
      if key < nums.at(j) {
        num_row(
          nums,
          hl1: i,
          hl2: j,
          frame: (
            from: 0,
            to: i - 1,
            color: theme.fg_light
          ),
          has_arrow: true
        )
        arrow_row(j, j+1, nums.len())
        nums.at(j+1) = nums.at(j)
      } else {
        num_row(
          nums,
          hl1: i,
          hl2: j,
          frame: (
            from: 0,
            to: i - 1,
            color: theme.fg_light
          ),
          has_arrow: true
        )
        arrow_row(j, j+1, nums.len(), crossed: true)
        break
      }
      j -= 1
    }
    num_row(
      nums,
      hl1: i,
      hl2: j,
      frame: (
        from: 0,
        to: i - 1,
        color: theme.fg_light
      ),
      has_arrow: true
    )
    arrow_row(i, j+1, nums.len(), key: key)
    nums.at(j+1) = key
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
  columns: nums.len()+1,
  align: center,
  stroke: none,
  ..rows(nums),
)