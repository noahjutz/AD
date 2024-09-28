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

==== Laufzeit

Unabhängig davon, ob der Algorithmus von rechts nach links oder andersherum verläuft, hat er eine Schleife durch alle $n$ Elemente, und eine zweite, welche abhängig von der Eingabe null bis $n$ Iterationen hat.

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

Mehr über Selection Sort: @selection-sort

=== Quicksort

