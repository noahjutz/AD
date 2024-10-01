#import "components.typ": single_num_row, braced, arrowed
#import "/config.typ": theme

#let nums = (4, 5, 5, 2, 1)

#single_num_row(
  nums,
  hl_success: range(3),
  labels: (
    (0, 1, braced[`:j-1`]),
    (1, 3, braced[`j-1:j+1`])
  ),
  arrow: (
    from: 1,
    to: 2,
  )
)