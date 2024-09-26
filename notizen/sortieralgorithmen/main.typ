= Sortieralgorithmen

== Insertion Sort <insertion-sort>

Der Algorithmus iteriert durch alle  Elemente ab dem zweiten (rot markiert: "Schlüssel") und schiebt den Wert so lange nach vorne, bis keine kleineren Werte mehr vor ihm stehen.

```python
for j in range(1, n):
  # a[j] nach vorne schieben
```

Zum Schluss von jeder Iteration ist die Liste bis zur jeweiligen Stelle sortiert (grün umrandet: "Schleifeninvariante").

Das "nach vorne schieben" erfolgt in drei Schritten:

1. Merke dir den Wert des Schlüssels.
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

#include "insertion_sort.typ"

== Bubble Sort

