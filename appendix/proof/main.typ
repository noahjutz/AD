= Beweise

== Stellenwertsystem <proof-positional-system>

#show grid.cell.where(x: 0): set align(end)
#grid(
  columns: 2,
  column-gutter: 12pt,
  row-gutter: 12pt,
  [=== Zu zeigen],
  [
    "Es gibt genau eine Stellenwertnotation für jede natürliche Zahl."
    $
    forall n in NN, b in {2, 3, 4, ...}:
    exists! #h(2pt) a_m...a_2a_1a_0 \ "mit"
    a_i in {0, 1, 2, ..., b-1} \ "und"
    n = sum_(i=0)^m a_i dot b^i
    $
  ],
  [=== Beweis],
  [Induktion],
  [==== Anfang],
  [
    $n = 1$

    Die Stellenwertnotation von 1 ist für jede Basis 1. 
    
    $
    1 = sum_(i=0)^0 underbrace(a_0, =1) dot b^0
    $
  ],
  [==== Schritt],
  [
    $n -> n+1$

    Annahme: Es gibt für $n$ genau eine Stellenwertnotation $a_m...a_2a_1a_0$.

    Fall 1: $a_0 < b - 1$

    Die Stellenwertnotation für $n+1$ ist $a_m...a_2a_1b_0$ mit $b_0 = a_0 + 1$.

    Fall 2: $a_0 = b - 1$

    
  ]
)