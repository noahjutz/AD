= Komplexität

== O-Notation

Ein Landau-Symbol $M in {O, o, Omega, omega, Theta}$ ist eine Menge, welche aus Funktionen besteht. Diese Menge ist in Abhängigkeit einer Funktion $f$ definiert, welche alle $g in M$ nach oben oder unten beschränkt.

#table(columns: (auto, 1fr, auto),
  $O$, $g(n) <= c dot f(n)$, table.cell(rowspan: 2)[Obere\ Schranke],
  $o$, $g(n) < c dot f(n)$,
  $Omega$, $g(n) >= c dot f(n)$, table.cell(rowspan: 2)[Untere\ Schranke],
  $omega$, $g(n) > c dot f(n)$,
  $Theta$, $c_1 dot f(n) <= g(n) <= c_2 dot f(n)$, "Beides"
)

Die Schranke muss erst ab einem beliebigen $n_0 in NN$ gelten, und sie darf um einen Konstanten Faktor $c > 0$ von $f$ abweichen.

#grid(
  columns: 2,
  include "start_value.typ",
  include "factor.typ"
)

== WC, BC, AC

Ein Algorithmus hat bei unterschiedlichen Eingaben $Sigma^n$ der gleichen Länge $n$ ggf. unterschiedliche Laufzeiten. Zum Beispiel müssen bei der binären Addition um 1 alle 1en von rechts nach links abgelaufen werden.

#[
  #set block(width: 100%)
  ```
  def inc(x, n):
    for i in n until 1:
      flip x[i]
      break if x[i] = 1
  ```
]

Die beiden Eingaben `0000` und `0111` haben die gleiche Länge, aber bei der ersten muss nur ein Bit vertauscht werden, während bei der zweiten alle $n$ Bits vertauscht werden müssen. Die Menge aller Laufzeitfunktionen bei einer Eingabelänge $n$ sei

$
Phi(n) := {T(x) | x in Sigma^n}
$

Die Worst- und Best-Case Laufzeiten sind jeweils:

#grid(columns: (1fr,) * 2,
  $
  T^"WC" (n) &= max(Phi(n)) \
  &= max_(x in Sigma^n) {T(x)}
  $,
  $
  T^"BC" (n) &= min(Phi(n)) \
  &= min_(x in Sigma^n) {T(x)}
  $
)

Die Funktionen in $Phi$ sind nach Wachstumsrate geordnet. Es gilt $g <= f$, falls $f$ dominiert:

$
lim_(n -> infinity) g(n)/f(n) <= c
$

Die größte Funktion beschränkt alle anderen $f(n)$ nach oben, die kleinste Funktion nach unten.

#grid(
  columns: (1fr,) * 2,
  $
  f(n) = O(T^"WC" (n))
  $,
  $
  f(n) = Omega(T^"BC" (n))
  $
)

Die Average-Case-Laufzeit ist das arithmetische Mittel über alle Laufzeiten.

$
T^"AC" (n) = 1/(|Sigma^n|) sum_(x in Sigma^n) T(x)
$

Beispiel:

$
T_A^"AC" (n) &= 1/2^n sum_(x in {0, 1}^n) T(x) \
&= 1/2^n sum_(x in {1, 2, ..., n}) x \
&= n(n+1)/2^(n+1)
$