= Beispiele

== Average-Case-Laufzeit <ex-average-case>

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

#include "binary_subsets.typ"

Daher ist die Summe aller Laufzeiten eine endliche geometrische Reihe mit der Basis $1/2$.

$
sum_(x in {0, 1}^n) T(x)
&= 1 + 1/2 + 1/4 + ... + 1/(2^n) \
&= sum_(k=0)^n (1/2)^k
$

Die Summe aller Laufzeitfunktionen konvergiert gegen 2 für $n -> infinity$. Die Average-Case-Laufzeit von `inc_bin` ist somit konstant.

$
T^"AC" (n) = 1/2^n dot 2 in O(1)
$

#include "binary_complexity.typ"