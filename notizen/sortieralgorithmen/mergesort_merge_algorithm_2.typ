#import "components.typ": num_row, arrowed

#let nums = (12, 23, 34, 45, 7, 17, 18, 38, 43, [])
#let n = nums.len()-1
#let m = calc.div-euclid(n, 2)

#table(
  columns: (auto, ) + (1fr,) * nums.len(),
  align: center,
  stroke: (x, _) => if x == n+1 {none} else {1pt},
  ..num_row(
    nums,
    hl_tertiary: 3,
    hl_gray: range(3) + range(4, n),
    arrow_down: (
      (3, n - 1),
    ),
    labels: (
      (3, 4, arrowed[`a1f`]),
      (n, n+1, arrowed[`a2f`])
    ),
    below: 0pt
  ),
  ..num_row(
    (7, 12, 17, 18, 23, 34, 38, 43, 45) + ([],),
    hl_success: range(n)
  )
)