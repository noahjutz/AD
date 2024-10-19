#import "/components/admonition.typ": admonition
#import "/config.typ": theme

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

#import "insertion_sort/insertion_sort.typ": insertion_sort
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

#include "insertion_sort/induction_0.typ"

==== Induktionsschritt (j - 1 #sym.arrow j)

Wir gehen davon aus, dass `a[:j]` nach Iteration $j-1$ sortiert ist.

#include "insertion_sort/induction_1.typ"

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

  #include "insertion_sort/induction_2.typ"

  ==== Induktionsschritt (i + 1 #sym.arrow i)

  Nach Induktionsvoraussetzung gilt nach dem Durchlauf mit $i+1$:
  
  `a[i+2:j+1]` ist korrekt

  Wenn wir zeigen können, dass nach dem Durchlauf mit $i$ gilt:

  `a[i+1:j+1]` ist korrekt

  Dann ist der Induktionsschritt erfüllt.

  Falls $i+1=0$ wird die while-Schleife verlassen, bevor sie für $i$ ausgeführt werden kann. Wir beweisen also für dieses $i$ nichts. #sym.checkmark
  
  Falls `a[i]` $<=$ `key` wird die while-Schleife auch verlassen. #sym.checkmark

  Sonst wird `a[i]` an den Anfang der rechten sortierten Teilliste `a[i+1:j+1]` gesetzt.

  #include "insertion_sort/induction_3.typ"

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

#include "quicksort/partition.typ"

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

Quicksort wird einmal für die Elemente links des Pivots und einmal für die rechts des Pivots aufgerufen. Falls es links oder rechts ein oder kein Element gibt, ist keine Aktion mehr erforderlich (base case).

```python
def quicksort(a, f, l):
  if f >= l:
    return # base case
  m = partition(a, f, l)
  quicksort(a, f, m-1)
  quicksort(a, m+1, l)
```

#include "quicksort/recursion_tree.typ"

=== Laufzeit

Die Partition läuft die Eingabe einmal durch, hat also eine lineare Laufzeit $Theta(n)$.

==== Worst Case

Wenn die Eingabe aufsteigend oder absteigend sortiert ist, wird das Problem in jedem Rekursionsschritt um nur 1 kleiner.

#import "quicksort/quicksort.typ": quicksort
#quicksort(1, 2, 3, 4)

Ist sie aufsteigend sortiert, so wird nur der zweite rekursive Aufruf mit einer Eingabelänge von $n-1$ aufgerufen.

$
T(n) = cases(
  Theta(1) "falls" n <= 1,
  T(n-1) + Theta(n) "sonst"
)
$

Die Rekursionsgleichung ist in $Theta(n^2)$.

==== Best Case

Der Best-Case tritt auf, wenn das Pivot-Element in jedem Schritt die Eingabe halbiert.

#quicksort(4, 1, 3, 2, 6, 5, 7)

In diesem Fall wird das Problem in jedem Schritt halbiert.

$
T(n) = cases(
  Theta(1) "falls" n <= 1,
  2T(n/2) + Theta(n) "sonst"
)
$

Die Lösung dieser Rekursionsgleichung ist $Theta(n log n)$.

==== Average Case

Die Laufzeit hängt davon ab, an welcher Stelle $m$ das Pivotelement landet. Ist immer $m=f$ oder $m=l$, haben wir den Worst Case. Ist immer $m=floor((f+l) slash 2)$, haben wir den Best Case.

Im allgemeinen gilt für beliebige $m in {f,...,l}$:

$
T_m (n) = 
underbrace(T(m-f), "links") +
underbrace(T(l-m), "rechts") +
underbrace(Theta(n), "partition")
$

Weil wir wissen, dass $l-f+1=n$, gilt für $i in {1,...,n}$:

$
T_i (n) = T(i-1) + T(n-i) + Theta(n)
$

== Merge Sort

Genauso wie Quicksort spaltet Merge Sort die Eingabe in jedem Rekursionsschritt in zwei Sublisten.

=== Merge

Die Merge-Prozedur nimmt als Eingabe zwei sortierte Listen `a1[f:m]` und `a2[m:l+1]`.

#include "mergesort/merge_input.typ"

Die beiden Listen werden gemischt, um eine sortierte Liste `anew[f:l+1]` zu produzieren.

#include "mergesort/merge_output.typ"

Um in Linearzeit zu mischen, nutzt quicksort, dass das Minimum zwei sortierter Listen `a1` und `a2` entweder `a1[0]` oder `a2[0]` sein muss.

#include "mergesort/merge_algorithm_0.typ"

Streichen wir den kleineren Wert, so bleiben zwei sortierte Listen übrig, für die wiederum das gleiche gilt.

#include "mergesort/merge_algorithm_1.typ"

In Code kann das folgendermaßen implementiert werden:

```python
if a[a1f] <= a[a2f]:
  anew[i] = a[a1f]
  a1f += 1
else:
  anew[i] = a[a2f]
  a2f += 1
```

Sobald die eine der beiden Listen durchgearbeitet wurde, wird der Rest der anderen Liste angehängt.

#include "mergesort/merge_algorithm_2.typ"

=== Rekursion

Die Eingabe wird rekursiv in 2 Teile gespalten, bis die Eingabe nur noch ein Element hat (base case). Die zwei Teile werden dann gemischt.

#import "mergesort/recursion.typ": mergesort_recursion
#align(
  center,
  mergesort_recursion((34, 45, 12, 34))
)

=== In Place

Um die Merge-Funktion ohne die hilfsliste `anew` zu implementieren, kann man Einträge der Liste nach vorne verschieben.

#include "mergesort/merge_inplace.typ"

```python
while a1f < a2f and a2f < l+1:
  if a[a2f] < a[a1f]:
    a.insert(a1f, a.pop(a2f))
    a2f += 1
  a1f += 1
```

== Heap Sort

=== Linksvoller Baum

Ein Baum ist linksvoll, wenn alle Schichten bis auf die letzte voll besetzt sind, und die letzte von links nach rechts besetzt ist.

#grid(
  columns: 2,
  column-gutter: 12pt,
  align: horizon,
  include "heapsort/linksvoll.typ",
  {
    table(
      columns: (1fr,)*6,
      ..range(6).map(i => {
        box(baseline: -3pt)[$a_#i$]
      })
    )
    table(
      columns: (auto, 1fr),
      align: horizon,
      table.cell(
        fill: theme.primary_light,
        "Linker NF"
      ), $ 2i+1 $,
      table.cell(
        fill: theme.secondary_light,
        "Rechter NF"
      ), $ 2i+2 $,
      table.cell(
        fill: theme.tertiary_light,
        "Vorgänger"
      ), $ floor((i-1)/2) $
    )
  }
)

=== Heap

Ein Heap ist ein linksvoller Binärbaum, der für alle Knoten die Heap-Eigenschaft erfüllt:

#grid(
  columns: 2,
  column-gutter: 8pt,
  row-gutter: 8pt,
  "Minheap:",
  [Vorgänger $<=$ Nachfolger],
  "Maxheap:",
  [Vorgänger $>=$ Nachfolger],
)

=== Heapify

Bevor wir ein beliebiges Array in einen Heap umwandeln, lösen wir ein einfacheres Problem: Ein Knoten $a_i$, dessen linker und rechter Teilbaum bereits Heaps sind, soll an die richtige Stelle vertauscht werden. Im folgenden implementieren wir Heapify für einen Maxheap. Betrachten wir als Beispiel

#align(
  center,
  include "heapsort/heapify.typ"
)

Zunächst vergleichen wir den Knoten mit seinen unmittelbaren Nachfolgern. Der maximale Wert muss nach oben, um die Heap-Eigenschaft zu erfüllen.

#align(
  center,
  grid(
    columns: 3,
    align: horizon,
    column-gutter: 8pt,
    include "heapsort/heapify_step_0.typ",
    sym.arrow,
    include "heapsort/heapify_step_1.typ"
  )
)

Durch den Tausch könnte die Heap-Eigenschaft jetzt im linken Teilbaum verletzt sein, also rufen wir Heapify rekursiv auf.

#align(
  center,
  grid(
    columns: 3,
    align: horizon,
    column-gutter: 8pt,
    include "heapsort/heapify_step_2.typ",
    sym.arrow,
    include "heapsort/heapify_step_3.typ"
  )
)

Die Rekursion ist dann beendet, wenn der Knoten größer als seine Nachfolger ist (oder keine Nachfolger hat), weil dann die Heap-Eigenschaft erfüllt ist.

Heapify hat eine Laufzeit von $O(log n)$, weil die Wurzel im schlimmsten Fall nach ganz unten wandern muss.

=== BuildHeap

Wie bringen wir einen beliebigen linksvollen Baum in Max-Heap-Form? Alle Blätter sind bereits korrekte Heaps, weil sie keine Nachfolger haben. Beispiel:

#align(
  center,
  include "heapsort/buildheap_step_0.typ"
)

Wenn wir von ganz unten bis zur Wurzel für alle nicht-Blätter Heapify aufrufen, dann wird der gesamte Baum schrittweise zu einem Heap. Die nicht-Blätter sind in `a[:n//2]`, weil der Vorgänger des letzten Blattes an Stelle $n-1$ ist:

$
floor((n-1-1)/2) = floor(n/2)-1
$

Wir iterieren von rechts nach links durch `a[:n//2]` und rufen für jeden Knoten Heapify auf.

#align(
  center,
  include "heapsort/buildheap_step_1.typ"
)

Da wir für $n slash 2$ Knoten Heapify aufrufen, ist die Laufzeit von BuildHeap durch $O(n log n)$ nach oben beschränkt. Tatsächlich ist BuildHeap noch schneller, weil die meisten Knoten, für die Heapify aufgerufen wird, weit unten sind.

$
T^"WC" (n) = sum_(h=0)^floor(log n)
underbrace(ceil(n slash 2^(h+1)), "Anz. Knoten\nauf Höhe h")
dot underbrace(O(h), "Heapify")
= O(n)
$

=== HeapSort

HeapSort nutzt die Eigenschaft des Max-Heaps, dass der größte Wert in der Wurzel `a[f]` steht.

Zuerst bauen wir einen Heap in $O(n)$ Zeit auf. Dann vertauschen wir `a[0]` und `a[n-1]`, was dazu führt, dass der größte Wert an der letzten Stelle steht. Im nächsten Schritt vernachlässigen wir `a[n-1]` und wiederholen das gleiche für die Subliste `a[:n-1]`. Um diese zu einem Heap zu machen, müssen wir nur Heapify aufrufen.

```python
build_heap(a)
for i in range(n-1, 1, -1):
  a[0], a[n-1] = a[n-1], a[0]
  heapify(n=n-1, root=i)
```