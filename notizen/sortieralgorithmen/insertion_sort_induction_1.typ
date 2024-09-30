#import "components.typ": single_num_row
#import "/config.typ": theme

#let nums = (1, 5, 5, 3, 2)

#single_num_row(
  nums,
  hl_success: (0, 2),
  labels: (
    "0": `0:i`,
    "2": `j:j+1`
  ),
  arrow: (
    from: 1,
    to: 2,
    color: theme.fg_light
  )
)