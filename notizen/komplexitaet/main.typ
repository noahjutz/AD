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

=== Rechenregeln

- $ f in O(f) $
- $ g in O(f) \ => c dot g in O(f) $
- $
g_1 in O(f_1), g_2 in O(f_2) \
=> g_1+g_2 in O(max(f_1, f_2)) \
=> g_1 dot g_2 in O(f_1 dot f_2)
$

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

Beispiel: @ex-average-case

== Rekursionsgleichungen

Die Komplexität rekursiver Algorithmen wird durch eine Rekursionsgleichung beschrieben. 

=== Aufstellen der Rekursionsgleichung

Eine rekursive Funktion hat mindestens eine Abbruchbedingung, welche bei einer trivialen Eingabelänge $n$ eintritt. Die Laufzeiten der Base-Cases sind die _Initialwerte_ der Rekursionsgleichung.

$
T(0) = ..., #h(12pt)
T(1) = ..., #h(12pt)
T(2) = ..., #h(12pt)
...
$

Für alle komplexeren Eingaben $n$ gibt es mindestens einen Selbstaufruf. Dieser Selbstaufruf löst ein einfacheres Subproblem, hat also eine geringere Eingabelänge. Beispiel:

$
T(n) = 5 T(n-1) + T(sqrt(n)) + O(n^2)
$

Der Algorithmus, der diese Laufzeit hat, könnte so aussehen:

```python
def rec(n):
  # Base-Case
  if n in (0, 1, 2):
    return
  
  # 5T(n-1)
  for i in range(5):
    rec(n-1)
  
  # T(sqrt(n))
  rec(sqrt(n))

  # O(n^2)
  for i in range(n):
    for j in range(n):
      print("hi")
```