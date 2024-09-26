#import "/config.typ": theme

#show table.cell: set text(size: 8pt)
#show table.cell.where(y: 0): set text(size: 11pt)

#let nums = (-13, 25, 34, 12, -3, 7, -87, 28, -77, 11)

#let rows(nums) = {
  let result = ()

  let start = 0
  let end = 0
  let sum = -1
  for n in nums {
    if sum + n <= n {
      start = end
      sum = n
    } else {
      sum += n
    }
    end += 1

    let next_row = nums.enumerate().map(((i, n)) => {
      table.cell(
        str(n),
        fill: if start <= i and i < end {theme.primary_trans}
      )
    })
    next_row.insert(0, table.cell[
      #set text(weight: "bold")
      #sum
    ])
    result.push(next_row)
 }
 return result
}

#let c = rows(nums)

#block(
  stroke: 1pt,
  table(
    columns: (1fr,) * (nums.len() + 1),
    align: end,
    stroke: (x, y) => {
      if y == 0 {(bottom: 1pt)}
      if x == 0 {(right: 1pt)}
    },
    table.cell(align: center + horizon)[$sum$],
    table.cell(colspan: nums.len(), align: start + horizon)[Liste],
    ..c.flatten()
  )
)