= Beweise

== Stellenwertsystem <proof-positional-system>

#show grid.cell.where(x: 0): set align(end)
#grid(
  columns: 2,
  column-gutter: 12pt,
  row-gutter: 12pt,
  [=== Zu zeigen],
  [
    "Es gibt eine Stellenwertnotation für jede natürliche Zahl."
    $
    forall x in NN, b in {2, 3, 4, ...}:
    exists #h(2pt) x_n...x_2x_1x_0
    $

    $
    "mit" x_i in {0, 1, 2, ..., b-1}
    $

    $
    "und" x = sum_(i=0)^m a_i dot b^i
    $
  ],
  [=== Beweis],
  [Induktion],
  [==== Anfang],
  [
    $x = 1$

    Die Stellenwertnotation von 1 ist für jede Basis 1. 
    
    $
    1 = sum_(i=0)^0 underbrace(x_0, =1) dot b^0
    #h(4pt) checkmark
    $
  ],
  [==== Schritt],
  [
    $x -> x+1$

    Wenn es für $x$ genau eine Stellenwertnotation $x_n...x_2x_1x_0$ gibt, dann gibt es auch für $y = x + 1$ eine Stellenwertnotation $y_(n+1)...y_2y_1y_0$.
  ],
  [==== Fall 1],
  [

    Die niederwertigste Ziffer kann erhöht werden ($x_0 + 1 < b$)

    Die Stellenwertnotation für $x+1$ ist

    $
    x_n...x_2x_1(x_0+1)
    #h(4pt) checkmark
    $

  ],
  [==== Fall 2],
  [
    Es gibt keinen höheren Ziffernwert ($x_0 + 1 = b$)

    Weil der Stellenwert sich mit jeder Stelle um Faktor $b$ erhöht, kann eine Zahl mit maximalem Ziffernwert $a_i = b - 1$ um 1 erhöht werden, indem man die vorangestellte Ziffer $a_(i+1)$ erhöht (carry). 

    $
    y = sum_(i=0)^(n+1) y_i dot b^i
    "mit" y_i = cases(
      x_i "falls es keinen carry mehr gibt",
      x_i+1 "falls" x_i+1<b,
      0 "sonst"
    )
    #h(12pt) checkmark
    $

    Damit ist bewiesen, dass jede Stellenwertnotation um 1 erhöht werden kann, wodurch der Induktionsbeweis gilt. $square.filled$
  ]
)

== Konvergenz der Fibonacci-Folge <proof-fib-convergence>