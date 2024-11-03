= Datenstrukturen

== Sortieren in Linearzeit

=== Counting Sort

// TODO Vorlesung über Counting sort anschauen und Zeitkomplexität verstehen

=== Vergleich Heap-, Count- und Map Sort

==== Map Sort

```python
if b[i] == -1:
  b[i] = key
  break

if dir == "r" and key < b[i] or \
   dir == "l" and key > b[i]:
  key, b[i] = b[i], key
```

==== Komplexitätsanalyse

Counting Sort läuft ab $n > 9000$ in Linearzeit, aber benötigt immer mindestens 9.000 Schritte. Heapsort läuft immer in $Theta(n log n)$. Map Sort läuft immer in $Theta(n)$.

==== Laufzeitmessungen

#include "runtimes.typ"

== Verkettete Liste

// TODO meine Implementierung funktioniert nicht.

Die Partition-Funktion nimmt eine verkettete Liste `a` und bewegt jeden Knoten, der kleiner als das Pivot-Element ist nach vorne, und jeden anderen nach hinten.

```python
it = iter(a)
pivot = next(it)
for node in it:
  a.remove(node)
  if node.value < pivot.value:
    a.insert_before(pivot, node)
  else:
    a.insert_after(pivot, node)
return pivot
```

Quicksort teilt die verkettete Liste in zwei und partitionieret rekursiv:

```python
if a.head == a.tail:
  return
pivot = partition(a)
quicksort(a.slice(a.head, pivot.prev))
quicksort(a.slice(pivot.next, a.tail))
```