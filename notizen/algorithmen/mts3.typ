#import "/config.typ": theme

#show table.cell: set text(font: "Noto Sans Mono", size: 8pt)

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
        fill: if start <= i and i < end {theme.primary_light}
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

#table(
  columns: (1fr,) * (nums.len() + 1),
  align: end,
  stroke: none,
  ..c.flatten()
)