#import "components.typ": single_num_row, braced, arrowed
#import "/config.typ": theme

#let nums = (12, 34, 34, 45, 45, 18, 38, 17, 43, 51)

#single_num_row(
  (4, 5, 3, 2, 1),
  labels: (
    (0, 2, braced[`:j`]),
  ),
  hl_success: range(2)
)