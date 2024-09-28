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

Im folgenden Beispiel ist Insertion Sort für die zwei-Elementige Eingabeliste $(2, 1)$ illustriert. Der Laufindex startet bei $i=1$ und endet auch dort, weil das der letzte Index der Liste ist.

#import "insertion_sort.typ": insertion_sort
#insertion_sort((2, 1))

Längeres Beispiel: @ex-insertion-sort

== Bubble Sort

In jedem Schleifendurchlauf (`i` rot markiert) wird die Teilliste `a[i:]` betrachtet. Von rechts nach links werden Elemente paarweise vertauscht, um den minimalen Wert nach vorne zu bringen.

```python
for i in range(n):
  for j in reversed(range(i, n-1)):
    if a[j] > a[j+1]:
      a[j], a[j+1] = a[j+1], a[j]
```

Nach jedem Schleifendurchlauf ist die Teilliste links des Schlüssels sortiert (grün markiert).

Im Beispiel wird $(3, 2, 1)$ sortiert.

#import "bubble_sort.typ": bubble_sort

#bubble_sort((3, 2, 1))

Längeres Beispiel: @ex-bubble-sort