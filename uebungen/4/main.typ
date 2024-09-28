= Sortieralgorithmen

== Sortieralgorithmen modifizieren

=== Insertion Sort

Statt dass in jedem Schleifendurchlauf die Elemente links des Schlüssels sortiert sind, sollten jetzt jene rechts des Schlüssels sortiert sein. Um das zu bewerkstelligen, drehen wir die äußere und innere Iteration um. Die äußere verläuft jetzt nach links und die innere nach rechts.

```python
for j in reversed(range(n)):
  key = a[j]
  i = j+1
  while i < n and a[i] < key:
    a[i-1] = a[i]
    i += 1
  a[i-1] = key
```

Mehr über Insertion Sort: @insertion-sort

=== Bubble Sort

Um das Maximum nach hinten wandern zu lassen, drehen wir wieder beide Schleifen um. Es wird auch nicht mehr vertauscht, wenn der vorgänger kleiner ist, sondern wenn er größer ist.

```python
for i in reversed(range(len(items))):
  for j in range(i):
   if items[j] > items[j+1]:
      items[j], items[j+1] =
        items[j+1], items[j]
```

Mehr über Bubble Sort: @bubble-sort