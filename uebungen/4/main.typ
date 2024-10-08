= Sortieralgorithmen

== Sortieralgorithmen modifizieren

=== Insertion Sort

Statt dass in jedem Schleifendurchlauf die Elemente links des Schlüssels sortiert sind, sollten jetzt jene rechts des Schlüssels sortiert sein. Um das zu bewerkstelligen, drehen wir die äußere und innere Iteration um. Die äußere verläuft jetzt nach links und die innere nach rechts.

```python
for j in range(n):
  key = a[j]
  i = j-1
  while i >= 0 and a[i] > key:
    a[i+1] = a[i]
    i -= 1
  a[i+1] = key
```

#align(center, sym.arrow.b)

```python
for j in reversed(range(n)):
  key = a[j]
  i = j+1
  while i < n and a[i] < key:
    a[i-1] = a[i]
    i += 1
  a[i-1] = key
```

==== Laufzeit & Korrektheit

Die Laufzeit bleibt gleich. Der Korrektheitsbeweis erfolgt analog zum Beweis des ursprünglichen Algorithmus.

Mehr über Insertion Sort: @insertion-sort

=== Bubble Sort

Um das Maximum nach hinten wandern zu lassen, drehen wir wieder beide Schleifen um.

```python
for i in range(n):
  for j in reversed(range(i, n-1))
   if a[j] > a[j+1]:
      a[j], a[j+1] = a[j+1], a[j]
```

#align(center, sym.arrow.b)

```python
for i in reversed(range(n)):
  for j in range(i, n-1):
   if a[j] > a[j+1]:
      a[j], a[j+1] = a[j+1], a[j]
```

==== Laufzeit & Korrektheit

Entspricht dem ursprünglichen Algorithmus.

Mehr über Bubble Sort: @bubble-sort

=== Selection Sort

```python
for i in range(n):
  x = a.index(min(a[i:]))
  a[i], a[x] = a[x], a[i]
```

#align(center, sym.arrow.b)

```python
for i in reversed(range(n)):
  x = a.index(max(a[:i+1]))
  a[i], a[x] = a[x], a[i]
```

==== Laufzeit & Korrektheit 

Entspricht dem ursprünglichen Algorithmus.

Mehr über Selection Sort: @selection-sort

=== Quicksort

Anstatt einen zufälligen Index zu wählen, können wir einfach `a[f]` mit einer zufälligen Zahl vertauschen.

```python
def partition(a, f, l):
  # ...
```

#align(center, sym.arrow.b)

```python
def partition(a, f, l):
  a[f] = a[random(f, l+1)]
  # ...
```

==== Laufzeit & Korrektheit

Es wird mal pro `partition`-Aufruf mit $Theta(1)$ zufällig vertauscht, damit bleibt die Laufzeit unverändert.

Wenn die nicht-randomisierte Partition korrekt ist, dann ist die Randomisierte auch korrekt, weil die Eingabe `a[f:l+1]` in beliebiger Permutation auftreten darf. Die Reihenfolge der Elemente hat keinen Einfluss auf die Funktionsweise.