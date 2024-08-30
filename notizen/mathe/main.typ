= Mathematische Grundlagen

== Fibonacci-Folge

Ein Glied der Fibonacci-Folge $f_n$ ist die Summe der beiden Vorgänger.

$
f_n = cases(
  1 "falls" n <= 2,
  f_(n-1) + f_(n-2) "sonst"
)
$

#include "fib_graph.typ"