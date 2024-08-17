#import "../../config.typ"
#show: config.config
#show: config.page

= Algorithmen

== ggT / kgV

== Eratosthenes

== Matrix

=== Addition

Zwei Matrizen $A$ und $B$ müssen die gleiche Anzahl an Zeilen und Spalten haben, um addiert werden zu können. Das Ergebnis $C$ hat auch die gleiche Anzahl an Zeilen und Spalten. Es wird durch komponentenweise Addition berechnet:

$
c_(i j) = a_(i j) + b_(i j)
$

In Python lässt sich das folgendermaßen implementieren:

```py
for i in range(self.m):
  for j in range(self.n):
    self.data[i][j] += other.data[i][j]
```

=== Multiplikation