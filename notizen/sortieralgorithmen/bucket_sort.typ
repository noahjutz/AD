#import "/components/num_row.typ": single_num_row, braced_b

#single_num_row(
  ($b_0$, $b_1$, $b_2$, $...$, $b_(n-1)$),
  labels_b: (
    (0, 1, braced_b($lr(\[0\;1/n\[)$)),
    (1, 2, braced_b($lr(\[1/n\;2/n\[)$)),
    (2, 3, braced_b($lr(\[2/n\;3/n\[)$)),
    (4, 5, braced_b($lr(\[ (n-1)/n\;1\[)$))
  )
)