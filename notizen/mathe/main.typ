= Mathematische Grundlagen

== Fibonacci-Folge

Eine _Differenzengleichung_ der Ordnung $k$ definiert jedes Glied $x_n$ einer Folge in Abhängigkeit der Vorgänger $x_(n-1), x_(n-2), ..., x_(n-k)$. Es müssen $k$ Initialwerte definiert werden, sodass die Rekursion beendet werden kann.

$
x_n = f(n, x_(n-1), x_(n-2), ..., x_(n-k))
$

Eine _lineare_ Differenzengleichung fordert, dass die Funktion ein lineares Polynom ist.

$
x_n = a_1x_(n-1) + a_2x_(n-2) + ... + a_n x_(n-k) + b
$

Man nennt man diese _homogen_, wenn sie keinen konstanten Term $b$ hat. Die Fibonacci-Folge erfüllt eine _homogene lineare Differenzengleichung_ der Ordnung $k=2$.

$
x_n = a_1x_(n-1) + a_2x_(n-2)
$

Die Koeffizienten sind definiert als $a_1=a_2=1$, und die Initialwerte als $x_0=0$ und $x_1=1$. Die Fibonacci-Folge ist also definiert als:

$
f_n = cases(
  0 "falls" n = 0,
  1 "falls" n = 1,
  f_(n-1) + f_(n-2) "sonst"
)
$

Die ersten 10 Fibonacci-Zahlen sind folglich:

#{
  show table.cell.where(y: 0): set text(fill: gray)
  table(columns: (1fr,) * 10,
    align: center,
    stroke: none,
    ..range(10).map(i => $f_#i$),
    ..range(10).map(i => calc.pow(1.618, i) / calc.sqrt(5))
      .map(i => [#calc.round(i)])
  )
}

Diese Folge beantwortet übrigens die Frage, wie viele Kaninchen es nach $n$ Monaten gibt, wenn jedes erwachsene Kaninchen (Mindestens 1 Monat alt) jeden Monat ein Nachkommen produziert, und niemals stirbt. 

#align(center, include "fib_tree.typ")

#include "fib_plot.typ"