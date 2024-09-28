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

Für jedes Element in `a` werden zwischen $0$ und  $j$ Verschiebeoperationen durchgeführt, um `a[j]` richtig in `a[:j+1]` einzusortieren.

#grid(columns: (1fr,)*2,
  $
  T^"WC" (n) = Theta(n^2) #h(16pt)
  $,$
  T^"BC" (n) = Theta(n)
  $
)

== Bubble Sort <bubble-sort>

In jedem Schleifendurchlauf wird die rechte Teilliste `a[i:]` betrachtet. Von rechts nach links werden die Elemente `a[j]` und `a[j+1]` paarweise vertauscht, um den minimalen Wert nach vorne zu bringen.

```python
for i in range(n):
  for j in reversed(range(i, n-1)):
    if a[j] > a[j+1]:
      a[j], a[j+1] = a[j+1], a[j]
```

Nach jedem Schleifendurchlauf ist die linke Teilliste bis zum Schlüssel sortiert (grün markiert).

Im Beispiel wird $(4, 3, 2, 1)$ sortiert. Der Zähler (rot markiert)  wandert von $i=0$ nach $i=n-2=2$.

#import "bubble_sort.typ": bubble_sort
#bubble_sort(4, 3, 2, 1)

Längeres Beispiel: @ex-bubble-sort

== Selection Sort <selection-sort>

In jedem Schleifendurchlauf ermitteln wir das Minimum in `a[i:]` und vertauschen es mit `a[i]`.

```python
for i in range(n):
  x = a.index(min(a[i:]))
  a[i], a[x] = a[x], a[i]
```

Im Beispiel ist der Zähler rot markiert und das rechte Minimum blau.

#import "selection_sort.typ": selection_sort
#selection_sort(4, 3, 2, 1)

Längeres Beispiel: @ex-selection-sort

== Quicksort

