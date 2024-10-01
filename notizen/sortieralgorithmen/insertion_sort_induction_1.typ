#import "components.typ": single_num_row, braced, arrowed

#single_num_row(
  (12, 34, 34, 45, 45, 18, 38, 17, 43, 51),
  labels: (
    (0, 2, braced[`:i`]),
    (2, 3, arrowed[`i`]),
    (3, 5, braced[`i+1:j+1`])
  ),
  hl_success: range(2) + range(3, 5)
)