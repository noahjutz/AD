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