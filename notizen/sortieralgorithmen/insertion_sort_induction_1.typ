#import "components.typ": single_num_row, braced, arrowed
#import "/config.typ": theme

#single_num_row(
  (12, 34, 34, 34, 45, 18, 38, 17, 43, 51),
  labels: (
    (0, 2, braced[`:i`]),
    (2, 3, arrowed[`i`]),
    (3, 5, braced[`i+1:j+1`])
  ),
  arrow: (
    from: 2,
    to: 3,
    color: theme.fg_light
  ),
  hl_success: range(2) + range(3, 5)
)