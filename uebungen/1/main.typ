#import "/config.typ"
#show: config.config

= Algorithmen

== ggT / kgV

== Eratosthenes

== Matrix

Eine $(m times n)$ Matrix hat $m$ Zeilen und $n$ Spalten.

$
A = (a_(i j))_(1<=i<=m\ 1<=i<=n)
$


=== Addition

Zwei Matrizen $A$ und $B$ müssen die gleiche Anzahl an Zeilen und Spalten haben, um addiert werden zu können. Das Ergebnis $C$ hat auch die gleiche Anzahl an Zeilen und Spalten. Es wird durch komponentenweise Addition berechnet:

$
c_(i j) = a_(i j) + b_(i j)
$

In Python lässt sich das folgendermaßen implementieren:

```py
for i in range(m):
  for j in range(n):
    c[i][j] = a[i][j] + b[i][j]
```

=== Multiplikation

Die Spalten der ersten Matrix muss gleich der Zeilen der Zweiten sein.

$
A.n = B.m
$

Das Ergebnis hat die Zeilen der ersten Matrix und die Spalten der Zweiten.

$
(C_(i j))_(1 <= i <= A.m \ 1 <= j <= B.n)
$

Jeder Ergebniseintrag $c_(i j)$ errechnet sich aus der $i$-ten Zeile in $A$ und der $j$-ten Spalte in B.

#include "matrix_mult.typ"

Konkret wird für jede Spalte in $A$ und jede Zeile in $B$ das Produkt von $a_(i k)$ und $b_(k j)$ berechnet. Alle Produkte werden anschließend aufsummiert.

$
c_(i j) = sum_(k=1)^n a_(i k) dot b_(k j)
$

In Python:

```py
for i in range(m):
  for j in range(p):
    for k in range(n):
      c[i][j] += a[i][k] * b[k][j]
```

== Matrix Laufzeit

Die Addition zwei quadratischer Matrizen hat eine Laufzeit von

$
T_+ = m dot n = n^2
$

weil es so viele Einträge gibt. Die Multiplikation hat eine Laufzeit von

$
T_times = m dot p dot n = n^3
$

weil für jeden Eintrag zusätzlich $n$ Multiplikationen und Additionen ausgeführt werden.

=== Zeitkomplexität

Mit $n = 1000$ benötigt mein Laptop für die Matrixmultiplikation $t = 175$s. Daraus ergibt sich die Frequenz

$
f &= T(n) / t \
&= 1000^3 / 175 \
&approx 5.7 "MHz"
$

Mit meiner Prozessorleistung kann ich in einer gegebenen Dauer $t$ zwei Matrizen der Größe

$
n(t) &= T^(-1)(t dot f) \
&= root(3, t dot 5.7 "MHz")
$

//multiplizieren #footnote[
//Wenn $T(n)$ die Anzahl benötigter Schritte bei einer Eingabelänge $n$ liefert, dann liefert die Umkehrfunktion $T^(-1)(n)$ die Eingabelänge bei einer gegebenen Anzahl an berechneten Schritten.
//]. Daraus ergibt sich die Wertetabelle (Addition wird analog zur Multiplikation gehandhabt):

#table(columns: 3,
  $t$, [$n$ ($times$)], [$n$ ($+$)],
  "1 min", "699", $1.7 dot 10^4$,
  "2 min", "881", $2.5 dot 10^4$,
  "5 min", "1195", $3.9 dot 10^4$,
  "10 min", "1506", $5.6 dot 10^4$
)

=== Platzkomplexität

Mit $n = 2000$ nimmt eine Matrix 92 MB ein. Die Anzahl speicherbarer Elemente $x$ pro Byte ist also 

$
x &= P(n)/s \
&= 2000^2/(92 dot 10^6) \
&approx 0.04
$

Hochgerechnet benötigt eine $10^4 times 10^4$ Matrix

$
s &= P(n)/x \
&= 10^8/0.04 \
&= 2.5 "GB"
$

Bei der Addition ist also die Platzkomplexität der beschränkende Faktor.
