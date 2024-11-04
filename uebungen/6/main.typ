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

Folgende Generator-Funktion traversiert alle Elemente von Head nach Tail. Die Liste darf während der Iteration verändert werden. 

```python
def nodes(head, tail):
  current = head
  while current:
    h = current.next
    yield current
    if current == tail:
      break
    current = h
```

In der Partition-Funktion werden Elemente kleiner als der Pivot direkt vorgezogen. Dadurch könnten Head und Tail verändert werden, also geben wir sie mit Pivot Zurück.

```python
def partition(head, tail):
  pivot = head
  for node in nodes(head.next, tail):
    if node.value > pivot.value:
      continue
    if node == tail:
      tail = tail.prev
    node.detach()
    head.prepend(node)
    head = node

  return (head, pivot, tail)
```

Nach dem gleichen Prinzip werden Head und Tail in Quicksort stets angepasst.

```python
def quicksort(head, tail):
  if head == tail:
    return (head, tail)
  h, p, t = partition(head, tail)

  if p != h:
    h, _ = quicksort(h, p.prev)
  if p != t:
    _, t = quicksort(p.next, t)

  return (h, t)
```

Weil in jeder Rekursion Variablen angelegt werden, ist der Platzverbrauch $Theta(log n)$. Die Laufzeit entspricht der des normalen Quicksort-Algorithmus, also $Theta(n log n)$.

== Ringliste