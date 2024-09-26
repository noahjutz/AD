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

=== Bubble Sort