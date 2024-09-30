#import "components.typ": single_num_row

#let nums = (1, 2, 5, 4, 3)

#single_num_row(
  nums,
  hl_success: range(2),
  labels: (
    "0": `a[i]`,
    "1": `a[i+1]`
  ),
  arrow: (
    from: 0,
    to: 1,
    direction: "bidirectional"
  )
)