= APSP

== Slow-APSP

#include "slow_apsp.typ"

== Faster-APSP

Genauso wie Slow-APSP, aber es werden Schritte übersprungen.

$
L^((1)) -> L^((2)) -> L^((4)) -> underbrace(L^((8)),=L^((5)))
$

== Floyd-Warshall

#include "floyd_warshall.typ"

== Floyd-Warshall Konstruktion

#import "@preview/diagraph:0.3.0": render

#render(
  "digraph {
    node [fontname=\"Noto Sans\", shape=circle, margin=.03, height=0]
    edge [arrowhead=vee, label=1]
    1 -> 3
    2 -> 1
    3 -> 1 [color=gray]
    4 -> 2
  }",
  engine: "neato",
  width: 100%,
  labels: range(1, 5).map(i => (str(i), $v_#i$)).to-dict()
)

Mit $k=1$ wird $v_2 ~> v_3$ über $v_1$ relaxiert. Daraus folgt:

$pi^((1))_(2,3) = 1$

Mit $k=2$ wird $v_4 ~> v_3$ über $v_2$ relaxiert. Daraus folgt:

$
pi^((2))_(4,3) = pi^((1))_(2,3) = 1
$