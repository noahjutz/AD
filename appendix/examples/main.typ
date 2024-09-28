= Beispiele

== AC-Laufzeit beim Inkrementieren <ex-average-case>

Sei $A$ der Algorithmus, der eine binäre Zahl der Länge $n$ um 1 erhöht.

Es gibt $|Sigma^n| = 2^n$ binäre Zahlen der From ${0, 1}^n$.

$
T^"AC"_A (n) &= 1/2^n sum_(x in {0, 1}^n) T(x) \
$

Beim inkrementieren wird jede 1 am Ende zu einer Null, und anschließend wird der Carry vorangehängt. Die Laufzeit für ein gegebenes $x$ ist also

$
T_A (x) = max {k mid(|) x_k...x_2x_1x_0 = {1}^k} + 1
$

Die Hälfte der Zahlen aus ${0, 1}^n$ endet mit einer 1. Die Hälfte dieser Teilmenge endet wiederum mit zwei 1en, und so weiter.

#include "binary_subsets.typ"

Daher ist die Summe aller Laufzeiten eine endliche geometrische Reihe mit der Basis $1/2$.

$
sum_(x in {0, 1}^n) T_A (x)
&= 1 + 1/2 + 1/4 + ... + 1/(2^n) \
&= sum_(k=0)^n (1/2)^k
$

Diese Reihe konvergiert gegen 2. Die Average-Case-Laufzeit $T^"AC"_A (n)$ ist somit konstant.

$
T^"AC"_A (n) = 1/2^n dot 2 in O(1)
$

#include "binary_complexity.typ"

== Insertion Sort <ex-insertion-sort>

#import "/notizen/sortieralgorithmen/insertion_sort.typ": insertion_sort
#insertion_sort((34, 45, 12, 34, 23, 18, 38, 17, 43, 51))

== Bubble Sort <ex-bubble-sort>

#import "/notizen/sortieralgorithmen/bubble_sort.typ": bubble_sort
#bubble_sort((34, 45, 12, 34, 23, 18, 38, 17, 43, 7))

== Selection Sort <ex-selection-sort>

#import "/notizen/sortieralgorithmen/selection_sort.typ": selection_sort
#selection_sort(34, 45, 12, 34, 23, 18, 38, 17, 43, 7)