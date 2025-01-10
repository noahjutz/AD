#let n = 6

#let adjacency_matrix = (
  (0, calc.inf, calc.inf, calc.inf, -1, calc.inf),
  (1, 0, calc.inf, 2, calc.inf, calc.inf),
  (calc.inf, 2, 0, calc.inf, calc.inf, -8),
  (-4, calc.inf, calc.inf, 0, 3, calc.inf),
  (calc.inf, 7, calc.inf, calc.inf, 0, calc.inf),
  (calc.inf, 5, 10, calc.inf, calc.inf, 0),
)

#let distances = {
  let l = ((calc.inf,) * n,) * n
  for i in range(n) { l.at(i).at(i) = 0 }
  l
}

#let parents = ((none,)*n,)*n

#let highlight = ((false,)*n,)*n
