#import "components.typ": single_num_row, braced, arrowed
#import "/config.typ": theme

#let nums = (4, 5, 5, 2, 1)

#single_num_row(
  nums,
  hl_success: (0, 2),
  labels: (
    (0, 1, braced[`:j-1`]),
    (1, 2, arrowed[`j-1`]),
    (2, 3, braced[`j:j+1`])
  ),
  arrow: (
    from: 1,
    to: 2,
  )
)