#import "../components.typ": single_num_row, arrowed, braced_b

#let nums = (12, 23, 34, 34, 45, 7, 17, 18, 38, 43)
#let n = nums.len()
#let m = calc.div-euclid(n, 2)

#single_num_row(
  nums,
  labels: (
    (0, 1, arrowed[`f`]),
    (m, m + 1, arrowed[`m`]),
    (n - 1, n, arrowed(`l`)),
  ),
  labels_b: (
    (0, m, braced_b[`a1`]),
    (m, n, braced_b[`a2`])
  ),
  hl_primary: range(m),
  hl_secondary: range(m, n)
)