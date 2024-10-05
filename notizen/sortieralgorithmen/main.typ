#import "/components/admonition.typ": admonition

= Sortieralgorithmen

== Insertion Sort <insertion-sort>

Der Algorithmus iteriert durch alle  Elemente ab dem zweiten (rot markiert) und schiebt den Wert so lange nach vorne, bis keine kleineren Werte mehr vor ihm stehen.

```python
for j in range(1, n):
  # a[j] nach vorne schieben
```

Zum Schluss von jeder Iteration ist die Liste bis zur jeweiligen Stelle sortiert (grün markiert).

Das "nach vorne schieben" erfolgt in drei Schritten:

1. Merke dir den Wert des Schlüssels (graue Spalte).
  ```python
  key = a[j]
  ```
2. Iteriere von rechts nach links durch alle Elemente links des Schlüssels (blau markiert) und kopiere das Element jeweils um eine Position nach hinten, wenn es größer ist als das nächste.
  ```python
  i = j-1
  while (i >= 0 and a[i] > key):
    a[i+1] = a[i]
    i -= 1
  ```
3. Setze den Wert des Schlüssels ganz nach vorne.
  ```python
  a[i+1] = key
  ```

=== Beispiel

Im folgenden Beispiel ist Insertion Sort für die Eingabeliste $(3, 2, 1)$ illustriert. Der Zähler (rot markiert) startet bei $i=1$ und endet bei $i=n-1=2$.

#import "insertion_sort.typ": insertion_sort
#insertion_sort(3, 2, 1)

Längeres Beispiel: @ex-insertion-sort

=== Laufzeit

Für jedes Element `a[j]` werden zwischen $0$ und  $j$ Verschiebeoperationen durchgeführt, um `a[j]` richtig in `a[:j+1]` einzusortieren.

#grid(columns: (1fr,)*2,
  $
  T^"WC" (n) = Theta(n^2) #h(16pt)
  $,$
  T^"BC" (n) = Theta(n)
  $
)

Im Schnitt benötigt es $j slash 2$ Verschiebeoperationen, damit ist die AC-Laufzeit

$
T^"AC" (n) = sum_(j=1)^(n-1) j/2 = Theta(n^2)
$

=== Korrektheit

Behauptung: Nach jeden $j$-ten Schleifendurchlauf ist `a[:j+1]` sortiert.

==== Induktionsanfang (j = 1)

Ein Durchlauf der Schleife mit Zähler $j$ sieht so aus:

```python
key = a[j]
i = j-1
while i >= 0 and a[i] > key:
  a[i+1] = a[i]
  i -= 1
a[i+1] = key
```

Setzen wir den festen Wert $j=1$ in den Code ein, dann wird die while-Schleife höchstens einmal betreten. Vereinfacht kann man das als if-else-Block darstellen:

```python
key = a[1]
if a[0] > a[1]:
  a[1] = a[0]
  a[0] = key
else:
  a[1] = key
```

Dieser Code vertauscht `a[0]` und `a[1]`, wenn `a[0]` größer ist. Das heißt, dass `a[0:2]` sortiert sind. #sym.checkmark

#include "insertion_sort_induction_0.typ"

==== Induktionsschritt (j - 1 #sym.arrow j)

Wir gehen davon aus, dass `a[:j]` nach Iteration $j-1$ sortiert ist.

#include "insertion_sort_induction_1.typ"

Wenn wir zeigen können, dass nach der nächsten Iteration $j$ das Subarray `a[:j+1]` sortiert ist, ist der Induktionsschritt erfüllt.

#admonition(
  [Verschachtelte Induktion]
)[
  Die innere Schleife startet mit $i=j-1$ und läuft ggf. nach unten bis $i=0$. Behauptung: Nach jedem $i$-ten Schleifendurchlauf gilt sind die Elemente in `a[i+1:j+1]` an der richtigen Stelle.

  ==== Induktionsanfang (i = j - 1)

  Im ersten Durchlauf mit $i = j - 1$ werden folgende Anweisungen ausgeführt:

  ```python
  if a[j-1] > a[j]:
    a[j] = a[j-1]
  ```

  Weil wir annehmen, dass `a[:j]` sortiert ist, ist `a[j-1]` der größte Wert in `a[:j]`. Nach der Ausführung des obigen Codes ist `a[j]` der größte Wert aus `a[:j+1]`. Damit ist `a[j:j+1]` sortiert. `a[:j-1]` bleibt unberührt. #sym.checkmark

  #include "insertion_sort_induction_2.typ"

  ==== Induktionsschritt (i + 1 #sym.arrow i)

  Nach Induktionsvoraussetzung gilt nach dem Durchlauf mit $i+1$:
  
  `a[i+2:j+1]` ist korrekt

  Wenn wir zeigen können, dass nach dem Durchlauf mit $i$ gilt:

  `a[i+1:j+1]` ist korrekt

  Dann ist der Induktionsschritt erfüllt.

  Falls $i+1=0$ wird die while-Schleife verlassen, bevor sie für $i$ ausgeführt werden kann. Wir beweisen also für dieses $i$ nichts. #sym.checkmark
  
  Falls `a[i]` $<=$ `key` wird die while-Schleife auch verlassen. #sym.checkmark

  Sonst wird `a[i]` an den Anfang der rechten sortierten Teilliste `a[i+1:j+1]` gesetzt.

  #include "insertion_sort_induction_3.typ"

  Dort gehört dieser Wert auch hin, weil er durch die äußere IV (`a[:j]` ist sortiert) der größte noch nicht einsortierte Wert ist.

  `a[:i]` $<=$ `a[i]` $<=$ `a[i+1:j+1]` #sym.checkmark
]

Nach dieser inneren Schleifeninvariante sind `a[:i]` und `a[i+1:j+1`] nach Beendigung der While-Schleife mit irgend einem $i$ sortiert. Ferner gilt folgendes:

`a[i-1]` $<=$ `key` $<=$ `a[i+1]`

Nachdem also der Schlüssel an Stelle `a[i]` setzt, ist `a[:j+1]` sortiert. #sym.square.filled

== Bubble Sort <bubble-sort>

In jedem Schleifendurchlauf wird die rechte Teilliste `a[i:]` betrachtet. Von rechts nach links werden die Elemente `a[j]` und `a[j+1]` paarweise vertauscht, um den minimalen Wert nach vorne zu bringen.

```python
for i in range(n):
  for j in reversed(range(i, n-1)):
    if a[j] > a[j+1]:
      a[j], a[j+1] = a[j+1], a[j]
```

Nach jedem Schleifendurchlauf ist die linke Teilliste bis zum Schlüssel sortiert (grün markiert).

=== Beispiel

Im Beispiel wird $(4, 3, 2, 1)$ sortiert. Der Zähler (rot markiert)  wandert von $i=0$ nach $i=n-2=2$.

#import "bubble_sort.typ": bubble_sort
#bubble_sort(4, 3, 2, 1)

Längeres Beispiel: @ex-bubble-sort

=== Laufzeit

Es gibt zwei verschachtelte for-Schleifen in Abhängigkeit von $n$.

$
T^"WC" (n) = T^"BC" (n) = T^"AC" (n) = n^2
$

=== Korrektheit

Nach jedem $i$-ten Schleifendurchlauf ist `a[:i+2]` sortiert.

==== Induktionsanfang (i = 0)

#admonition("Verschachtelte Induktion")[
  Nach jedem $j$-ten Schleifendurchlauf ist `min(a)` in `a[:j+1]` und `a[j]` $<=$ `a[j+1]`
  ==== Induktionsanfang (j = n - 2)

  Die letzten beiden Elemente `a[n-1]` und `a[n-2]` werden ggf. vertauscht, um sie in die richtige Reihenfolge zu bringen. #sym.checkmark

  ==== Induktionsschritt (j + 1 #sym.arrow j)

  Nach IV ist `min(a)` in `a[:j+2]`. Es werden `a[j]` und `a[j+1]` wieder ggf. vertauscht, um sie in die richtige Reihenfolge zu bringen. #sym.checkmark
]

==== Induktionsschritt (i - 1 #sym.arrow i)

#admonition("Verschachtelte Induktion")[
  Nach jedem $j$-ten Schleifendurchlauf ist `min(a[i:])` in `a[i:j+1]`.

  ==== Induktionsanfang (j = n - 2)

  Siehe obige verschachtelte Induktion. #sym.checkmark

  ==== Induktionsschritt (j + 1 #sym.arrow j)

  Siehe obige verschachtelte Induktion. #sym.checkmark
]

==== Induktionsschluss

Nach dem $n-1$-ten Schleifendurchlauf ist `a[:n+1]` sortiert. #sym.square.filled

== Selection Sort <selection-sort>

In jedem Schleifendurchlauf ermitteln wir das Minimum in `a[i:]` und vertauschen es mit `a[i]`.

```python
for i in range(n):
  x = a.index(min(a[i:]))
  a[i], a[x] = a[x], a[i]
```

=== Beispiel

Im Beispiel ist der Zähler rot markiert und das rechte Minimum blau.

#import "selection_sort.typ": selection_sort
#selection_sort(4, 3, 2, 1)

Längeres Beispiel: @ex-selection-sort

=== Laufzeit

$
T^"WC" (n) = T^"BC" (n) = T^"AC" (n) = n^2
$

=== Korrektheit

Nach jedem $i$-ten Schleifendurchlauf ist `a[:i+1]` sortiert.

==== Induktionsanfang (i = 0)

`a[0]` und `min(a)` werden vertauscht. (Verschachtelte Induktion für die Berechnung des Minimums wird weggelassen) #sym.checkmark

==== Induktionsschritt (i - 1 #sym.arrow i)

`a[i]` und `min(a[i:])` werden vertauscht. `a[:i]` ist nach IV bereits sortiert. #sym.checkmark

==== Induktionsschluss

Nach dem $n$-ten Schleifendurchlauf ist die gesamte Liste `a[:n+1]` sortiert. #sym.square.filled

== Quicksort

Um eine Liste `a[f:l+1]` zu sortieren, wird in jedem Rekursionsschritt wird ein beliebiges sogenanntes Pivot-Element ausgewählt. In unserer Implementation wählen wir

```
pivot = a[f]
```

Die Partitionsfunktion sortiert das Pivotelement ein. Die Sublisten links und rechts des Pivots werden anschließend rekursiv sortiert.

=== Partition

Die Partitionsfunktion vertauscht die Liste so, dass alle kleineren Elemente vor dem Pivot und alle größeren hinter ihm stehen.

#include "quicksort_partition.typ"

Um von (a) auf (b) zu kommen, jede Zahl in `a[f+1:]` nach vorne vertauscht, falls sie kleiner als das Pivot ist.

```python
j = f+1
for i in range(f+1, l+1):
  if a[i] <= key:
    a[i], a[j] = a[j], a[i]
    j += 1
```

Jetzt ist `a[1:j]` kleiner, und `a[j:n+1]` größer als das Pivot. Wenn wir also das Pivot bei `a[f]` mit `a[j-1]` vertauschen, ist es an der richtigen Stelle (c).

```python
a[f], a[j-1] = a[j-1], a[f]
```

=== Rekursion

Quicksort wird einmal für die Elemente links des Pivots und einmal für die rechts des Pivots aufgerufen. Falls es links oder rechts keine Elemente gibt, ist keine Aktion mehr erforderlich (base case).

```python
def quicksort(nums, f, l):
  if f >= l:
    return # base case
  part = partition(nums, f, l)
  quicksort(nums, f, part-1)
  quicksort(nums, part+1, l)
```

#include "quicksort_recursion.typ"