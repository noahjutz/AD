#import "/components/math.typ": hlp, hls
#import "/components/timeline.typ": timeline

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

=== Grenzwertdefinition

$
lim_(n -> infinity) g(n)/f(n) = cases(
  infinity <=> cases(
    f(n) in O(g(n)),
    g(n) in Omega(f(n))
  ),
  c <=> cases(
    g(n) in Theta(f(n)),
    f(n) in Theta(g(n))
  ),
  0 <=> cases(
    f(n) in Omega(g(n)),
    g(n) in O(f(n))
  )
)
$

=== Mengendefinition

$
O(hls(f(n))) = {#h(2pt) hlp(g(n)) mid(|) #box(baseline: 50%)[$
  exists n_0 in NN, c > 0 : \
  forall n >= n_0 : g(n) <= c dot f(n)
$]#h(2pt)}
$

$
Omega(f(n)) = {#h(2pt)g(n) mid(|) #box(baseline: 50%)[$
  exists n_0 in NN, c > 0 : \
  forall n >= n_0 : g(n) >= c dot f(n)
$]#h(2pt)}
$

$
Theta(f(n)) = {#h(2pt)g(n) mid(|) #box(baseline: 50%)[$
  exists n_0 in NN, c > 0 : \
  forall n >= n_0 : g(n) = c dot f(n)
$]#h(2pt)}
$

=== Rechenregeln

- $ f in Theta(f) $
- $ g in Theta(f) \ => c dot g in Theta(f) $
- $
g_1 in Theta(f_1), g_2 in Theta(f_2) \
=> g_1+g_2 in O(max(f_1, f_2)) \
=> g_1+g_2 in Omega(min(f_1, f_2)) \
=> g_1+g_2 in Theta(f_1 + f_2) \
=> g_1 dot g_2 in Theta(f_1 dot f_2)
$

== Komplexitätsklassen

#timeline[
  - $Theta(1)$

    Diese Laufzeitfunktionen konvergieren gegen einen konstanten Wert. Es gibt keine geringere Komplexität als $Theta(1)$.

  - $Theta(log n)$

    Ein Logarithmus zur Basis $b_1$ kann mit einem konstanten Faktor die Basis $b_2$ verwenden.

    $
    log_b_1 n = underbrace(log_b_1 b_2, "konstant") dot log_b_2 n
    $
]

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
T(n) = 5 T(n-1) + T(sqrt(n)) + n^2
$

=== Charakteristisches Polynom

Lineare Rekursionsgleichungen können als exponentielle Funktion dargestellt werden.

$
T(n) = sum_(i=1)^k a_i dot T(n-i)
==>
T(n) = r^n
$

Um die Basis $r$ herauszufinden, lösen wir das charakteristische Polynom.

$
r^n = sum_(i=0)^k a_i dot r^(n-i)
$

=== Substitutionsmethode

Komplexität abschätzen und mittels vollständiger Induktion beweisen.

=== Iterationsmethode

Schrittweise die Formel in Selbstaufrufe einsetzen und ein Muster erkennen.

=== Master-Theorem

Viele Divide & Conquer Algorithmen zerlegen die Eingabe in $b$ Teile, und erzeugen $a$ Subprobleme, welche diese Teile verarbeiten. Die Ergebnisse der Subprobleme werden anschließend kombiniert. Die Laufzeit der Zerlegung und Kombination in jedem Rekursionsschritt ist $f(n)$.

$
T(n) = a T(n/b) + f(n)
$

Der Einfachheit halber gehen wir von einem Base-Case $T(1) = Theta(1)$ aus.

Desto größer $a$ ist, desto breiter wird der Rekursionsbaum, und desto kleiner $b$ ist, desto tiefer wird die Rekursion. Der Rekursionsbaum sieht bei $a=2$ so aus:

#include "master_tree.typ"

Die Gesamtlaufzeit setzt sich aus den _rekursiven Schritten_ und den _Base Cases_ zusammen.

$
T(n) = underbrace(
  sum_(k=0)^(log_b n-1) a^k dot f(n/b^k),
  =: T_R
) + underbrace(
  a^(log_b n) dot Theta(1),
  =: T_B
)
$

Ausschlaggebend für die asymptotische Laufzeit ist, ob $T_R$ oder $T_B$ dominiert.

#grid(columns: (1fr, ) * 2,
  $
  T_R (n) <= a^(log_b n) dot f(n) \
  T_R (n) >= f(n)
  $
)

$
a^(log_b n) = n^(log_b a)
$
