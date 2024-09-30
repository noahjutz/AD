#import "components.typ": single_num_row, braced, arrowed
#import "/config.typ": theme

#let nums = (1, 5, 5, 3, 2)

#single_num_row(
  nums,
  hl_success: (0, 2),
  labels: (
    (0, 1, braced[`:j-i`]),
    (1, 2, arrowed[`i`]),
    (2, 3, braced[`j:j+1`])
  ),
  arrow: (
    from: 1,
    to: 2,
  )
)