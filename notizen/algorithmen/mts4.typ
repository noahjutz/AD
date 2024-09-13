#let nums = (-13, 25, 34, 12, -3, 7, -87, 28, -77, 11)

#table(
  columns: (1fr,) * nums.len(),
  ..nums.map(n => str(n))
)