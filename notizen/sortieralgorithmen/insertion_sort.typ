#import "components.typ": num_row, finished_row, arrow_row
#import "@preview/cetz:0.2.2"

#show table: set text(font: "Noto Sans Mono")

#let nums = (34, 45, 12, 34, 23, 18, 38, 17, 43, 51)

#let rows(nums) = {
  let rows = ()
  let nums = array(nums)
  for i in range(1, nums.len()) {
    let j = i - 1
    let key = nums.at(i)
    while j >= 0 {
      if key < nums.at(j) {
        rows += num_row(j, i, nums)
        rows += arrow_row(j, j+1, nums.len())
        nums.at(j+1) = nums.at(j)
      } else {
        rows += num_row(j, i, nums)
        rows += arrow_row(j, j+1, nums.len(), crossed: true)
        break
      }
      j -= 1
    }
    rows += num_row(j, i, nums)
    rows += arrow_row(i, j+1, nums.len(), key: key)
    nums.at(j+1) = key
    rows += finished_row(i+1, nums)
    rows.push(table.cell(colspan: nums.len(), ""))
  }
  return rows
}

#table(
  columns: nums.len(),
  align: center,
  stroke: none,
  ..rows(nums)
)