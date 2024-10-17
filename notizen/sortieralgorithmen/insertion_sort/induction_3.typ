#import "../components.typ": single_num_row, braced, arrowed
#import "/config.typ": theme

#let nums = (4, 4, 5, 3, 2)

#single_num_row(
  nums,
  hl_success: range(1, 3),
  labels: (
    (0, 1, arrowed[`i`]),
    (1, 3, braced[`i+1:j+1`])
  ),
  arrow: (
    from: 0,
    to: 1,
  ),
)