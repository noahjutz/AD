#import "components.typ": single_num_row

#let nums = (1, 5, 4, 3, 2)

#single_num_row(
  nums,
  hl_success: range(2),
  //labels: (
  //  "0": (content: `j-1`),
  //  "1": (content: `j`)
  //),
  arrow: (
    from: 0,
    to: 1,
    direction: "bidirectional"
  )
)