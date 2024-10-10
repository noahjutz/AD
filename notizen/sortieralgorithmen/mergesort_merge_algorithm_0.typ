#import "components.typ": num_row, braced

#let nums = (12, 23, 34, 45, 7, 17, 18, 38, 43)
#let n = nums.len()
#let m = calc.div-euclid(n, 2)

#table(
  columns: (auto, ) + (1fr,) * nums.len(),
  align: center,
  ..num_row(
    nums,
    hl_tertiary: (0, m),
    arrow_down: (
      (0, 0), (m, 0)
    ),
    labels: (
      (0, m, braced[`a1`]),
      (m, n, braced[`a2`])
    ),
    below: 0pt
  ),
  ..num_row(
    (7,) + ([],)*(nums.len()-1),
    hl_success: 0
  )
)