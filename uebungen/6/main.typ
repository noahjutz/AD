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

Datenstruktur Verkettete Liste:

```python
class Node:
  def __init__(self, value: int):
    self.value = value
    self.next = None

  def step(self, n: int):
    c = self
    for _ in range(n):
      c = c.next
    return c
  
  def pop(self):
    v = self.next.value
    self.next = self.next.next
    return v
```

Initialisierung der Lotto-Liste:

```python
head = Node(1)
tail = head
while True:
  if tail.value == 49:
    tail.next = head
    break
  new = Node(tail.value+1)
  tail.next = new
  tail = new
return head
```

Ziehen von sechs Zufallszahlen:

```python
l = lotto_list()
for i in range(6):
  steps = random.randint(0, 48-i)
  draw = l.step(steps)
  value = draw.pop()
  yield value
```

== Rucksackproblem

=== Stetiges Rucksackproblem

Um das anteilige Rucksackproblem zu lösen, sortieren wir zunächst alle Stücke nach Wert pro Kilo:

```python
def ratio(item):
    return item.value / item.weight

a=sorted(items, key=ratio,
         reverse=True):
```

Dann packen wir die höherwertigen Stücke nacheinander ein, bis eines ggf. nicht ganz hineinpasst. Dieses schneiden wir dann zurecht, indem wir es einen Faktor kleiner als 1 zuweisen.


```python
sack = []
for item in a:
  if item.weight > max_weight:
    sack.append([
      item,
      max_weight / item.weight
    ])
    break
  sack.append([item, 1])
max_weight -= item.weight
return sack
```

Der Algorithmus läuft in $Theta(n log n)$, weil das sortieren am längsten dauert.

=== Diskretes Rucksackproblem

// TODO