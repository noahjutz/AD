= Mathematische Grundlagen

== Fibonacci-Folge

Ein Glied der Fibonacci-Folge $f_n$ ist die Summe der beiden Vorgänger.

$
f_n = cases(
  0 "falls" n = 0,
  1 "falls" n = 1,
  f_(n-1) + f_(n-2) "sonst"
)
$

#align(center, include "fib_tree.typ")

#include "fib_plot.typ"