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
  i = randint(f, l)
  a[f], a[i] = a[i], a[f]
  # ...
```

==== Laufzeit & Korrektheit

Es wird mal pro `partition`-Aufruf mit $Theta(1)$ zufällig vertauscht, damit bleibt die Laufzeit unverändert.

Wenn die nicht-randomisierte Partition korrekt ist, dann ist die Randomisierte auch korrekt, weil die Eingabe `a[f:l+1]` in beliebiger Permutation auftreten darf. Die Reihenfolge der Elemente hat keinen Einfluss auf die Funktionsweise.

== Zeitmessungen

Zufällige Zahlenfolge der Länge $n$:

```python
[randint(-5, 256) for _ in range(n)]
```

Um die maximale Eingabelänge zunächst grob zu ermitteln, prüfen wir jede Potenz von 2 (`max_input.py`).

```python
for n in (2**i for i in count()):
  if runtime > 60:
    return n
```

Das Infimum der Eingabelängen muss also in $"lo":=n/2$ und $"hi":=n$ liegen. Mit der Intervallhalbierungsmethode können wir dieses $n$ zu einer beliebigen Genauigkeit `depth` berechnen (`exact_input.py`).

```python
for _ in range(depth):
  m = (hi + lo) // 2
  if runtime > 60:
    hi = m
  else:
    lo = m
return lo
```

Mit einer Tiefe von 20 erhalte ich folgende Eingabelängen $n$, welche innerhalb von $t<60s$ berechnet werden können:

#include "measure_table.typ"

Quicksort überschreitet die maximale Rekursionstiefe, bevor die Zeitgrenze von einer Minute erreicht wird.

== Minkowski-Summe

Gefragt ist, ob es ein $s in ZZ$ gibt, welches sich aus der Summe von zwei Elementen $a_i, a_j in A$ ergibt.

$
s in {a_i+a_j mid(|) (a_i, a_j) in A times A, i != j}
$

=== Naiver Ansatz

Für alle ${a_i + a_j mid(|) (a_i, a_j) in A times A, i != j}$ prüfen, ob $a_i+a_j = s$.

```python
for ai, aj in itertools.product(A, A):
  if ai == aj: continue
  if ai + aj == s: return True
return False
```

=== Besserer Ansatz

Wählen wir $a_i = min(A)$ und $a_j = max(A)$, dann ist die nächstgrößere Summe

$ "sum"_> = min(A without {a_i}) + a_j $

und die nächstkleinere Summe

$ "sum"_< = a_i + max(A without {a_j}) $

Wenn $A$ sortiert ist, dann lässt sich der nächste Wert in $Theta(1)$ berechnen:

$ "sum"_> = a_(i+1) + a_j $

$ "sum"_< = a_i + a_(j-1) $

Wir starten mit $l=0$ und $r=n-1$, und laufen zur Mitte.

```python
a.sort()
l = 0
r = len(a) - 1
while l < r:
  sum = a[l] + a[r]
  if sum == s: return True
  if sum < s: l += 1
  else: r -= 1
return False
```

Das sortieren dauert $Theta(n log n)$, damit dauert der gesamte Algorithmus $Theta(n log n)$.