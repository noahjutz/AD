#import "../components.typ": single_num_row, arrowed, braced

#let nums = (4, 5, 3, 2, 1)

#single_num_row(
  nums,
  hl_success: range(2),
  labels: (
    (0, 1, arrowed(`j-1`)),
    (1, 2, arrowed(`j`))
  ),
  arrow: (
    from: 0,
    to: 1,
    direction: "bidirectional"
  )
)