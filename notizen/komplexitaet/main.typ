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

Ein Algorithmus hat bei unterschiedlichen Eingaben $Sigma^n$ der gleichen Länge $n$ ggf. unterschiedliche Laufzeiten.

==== Beispiel

Sei $A = #raw("inc_bin")$. Desto mehr 1en am Ende hängen, desto länger muss der Carry weitergereicht werden.

$
T_A (#raw("0000")) < T_A (#raw("0111"))
$

=== Worst-Case und Best-Case

Die Menge aller Laufzeitfunktionen bei einer Eingabelänge $n$ sei

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

Die größte Funktion $T^"WC"$ beschränkt alle $T in Phi$ nach oben, die kleinste Funktion $T^"BC"$ nach unten.

#grid(
  columns: (1fr,) * 2,
  $
  T(n) = O(T^"WC" (n))
  $,
  $
  T(n) = Omega(T^"BC" (n))
  $
)

=== Average-Case

Die Average-Case-Laufzeit ist das arithmetische Mittel über alle Laufzeiten.

$
T^"AC" (n) = 1/(|Sigma^n|) sum_(x in Sigma^n) T(x)
$

==== Beispiel

Es gibt $|Sigma^n| = 2^n$ binäre Zahlen der Länge $n$.

$
T^"AC" (n) &= 1/2^n sum_(x in {0, 1}^n) T(x) \
//&= 1/2^n sum_(x in {1, 2, ..., n}) x \
//&= n(n+1)/2^(n+1)
$

Bei `inc_bin` wird jede 1 am Ende zu einer Null, anschließend wird eine 1 vorangehängt. Die Laufzeit für ein gegebenes $x$ ist also

$
T(x) = max {k | x_k...x_2x_1x_0 = {1}^k} + 1
$

Die Hälfte der Zahlen aus ${0, 1}^n$ endet mit einer 1. Die Hälfte dieser Teilmenge endet wiederum mit zwei 1en, und so weiter.