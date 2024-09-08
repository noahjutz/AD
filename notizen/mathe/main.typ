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

Man nennt man diese _homogen_, wenn sie keinen konstanten Term $b$ hat.

=== Definition

Die Fibonacci-Folge erfüllt eine _homogene lineare Differenzengleichung_ der Ordnung $k=2$.

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

Die ersten 10 Fibonacci-Zahlen sind:

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

=== Fibonaccis Kaninchen

Wie viele Kaninchen gibt es nach $n$ Monaten, wenn jedes erwachsene Kaninchen (mindestens 1 Monat alt) jeden Monat ein Nachkommen produziert, und niemals stirbt?

#include "fib_tree.typ"

Die Anzahl an Kaninchen in einem Monat $n$ sind zunächst alle Kaninchen, die es im Monat davor schon gibt ($f_(n-1)$). Es kommen $f_(n-2)$ neue Kaninchen dazu, weil jedes erwachsene Kaninchen ein neues zeugt. Um erwachsen zu sein, muss es schon zwei Monate zuvor existiert haben. Daraus ergibt sich die Fibonacci-Folge.

$
f_n = f_(n-1) + f_(n-2)
$

=== Iterative Lösung

#include "fib_plot.typ"

Es gibt eine Funktion $f(n)$, welche die $n$-te Fibonacci-Zahl ohne Rekursion berechnet. Für diese Funktion muss gelten:

$
f(n) = f(n-1) + f(n-2)
$

Das Verhältnis zwischen zwei Fibonacci-Zahlen $f_n/f_(n-1)$ konvergiert für $n -> infinity$ gegen einen konstanten Wert $phi approx 1.618$. Beweis: @proof-fib-limit. Die Fibonacci-Folge nähert sich einer geometrischen Folge an.

$
x_n = x_0 dot phi^n
$

// Wir nehmen an, dass diese Funktion exponentiell wächst, weil die Fibonacci-Folge für $n -> infinity$ eine geometrische Folge ist.
// 
// $
// f(n) = r^n
// $

