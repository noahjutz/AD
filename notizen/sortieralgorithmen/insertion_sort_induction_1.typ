#import "components.typ": single_num_row, braced, arrowed
#import "/config.typ": theme

#let nums = (1, 5, 5, 3, 2)

#single_num_row(
  nums,
  hl_success: (0, 2),
  labels: (
    (1, 2, braced[hi2]),
    (3, 4, arrowed[hi3])
  ),
  arrow: (
    from: 1,
    to: 2,
    color: theme.fg_light
  )
)