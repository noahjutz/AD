#import "components.typ": single_num_row, arrowed, braced_b

#let nums = (34, 45, 12, 34, 23, 18, 38, 17, 43, 7)
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
    (0, m + 1, braced_b[`a1`]),
    (m + 1, n, braced_b[`a2`])
  )
)