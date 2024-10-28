= Heaps

== Mergesort und Quicksort

=== Mergesort

==== Rekursionsbaum

#import "/notizen/sortieralgorithmen/mergesort/recursion.typ": mergesort_recursion

#{
  set align(center)
  set text(size: 11pt)
  set table.cell(inset: (x: 1pt, y: 2pt), stroke: none)
  show table: box.with(stroke: 1pt)
  mergesort_recursion(
    (-5, 13, -32, 7, -3, 17, 23, 12, -35, 19),
    spacing: 0pt
  )
}

==== In Python

```python
def merge(a, i, j, l):
  while i < j and j <= l:
    if a[j] < a[i]:
      a.insert(i, a.pop(j))
      j += 1
    i += 1

def mergesort(a, f, l):
  if f >= l: return
  m=(f+l)//2
  mergesort(a, f, m)
  mergesort(a, m+1, l)
  merge(a, f, m+1, l)

a=[-5, 13, -32, 7, -3, 17, 23, 12, -35, 19]
mergesort(a, 0, len(a)-1)
print(a)
```

=== Heapsort

==== Demonstration

0. Eingabe

#import "heap.typ": heap
#let nums = (-5, 13, -32, 7, -3, 17, 23, 12, -35, 19)
#heap(nums)

1. BuildHeap

#include "buildheap.typ"

2. Sortieren

#include "heapsort.typ"

==== In Python

1. Heapify (a: Eingabeliste, i: Wurzel, n: Heapgröße, j: Maximum)

```python
j = max(
  i, 2*i+1, 2*i+2,
  key=lambda i:
    a[i] if i < n else -math.inf
)
if i != j:
  a[i], a[j] = a[j], a[i]
  heapify(a, j, n)
```

2. BuildHeap (a: Eingabeliste)

```python
for i in range(len(a)//2-1, -1, -1):
  heapify(a, i, len(a))
```

3. HeapSort (a: Eingabeliste)

```python
build_heap(a)
for i in range(len(a)-1, 0, -1):
  a[0], a[i] = a[i], a[0]
  heapify(a, 0, i)
```

== Heap-Beweise

=== Aussage 1

Ein Heap mit $n$ Elementen hat die Höhe $floor(log_2(n))$.

==== Beweis

Weil jeder Knoten zwei Nachfolger haben darf, hat jede Schicht doppelt so viele Knoten wie die vorherige. Ein voll besetzter Heap mit Höhe $h$ hat so viele Elemente:

$
n=1 + 2 + 4 + 8 + ... + 2^h
$

Diese geometrische Reihe lässt sich umschreiben:

$
n=sum_(i=0)^(h) 2^i = 2^(h+1)-1
$

Aber nicht jeder Heap ist voll besetzt, weil die tiefste Schicht nicht voll besetzt sein muss. Die genaue Anzahl an Elementen liegt also zwischen $2^h$ und $2^(h+1)-1$.

Daraus folgt, dass umgekehrt die Höhe mindestens $floor(log n)$ ist.

$
&&n &>= 2^h \
<=>&& log n &>= h \
=>&& floor(log n) &>= h
$

Sie ist auch höchstens $floor(log n)$.

$
&&n &<= 2^(h+1)-1 \
<=>&& n &< 2^(h+1) \
<=>&& log n &< h+1 \
=>&& floor(log n) &< h+1 \
<=>&& floor(log n) &<= h
$
 
Damit gilt  $floor(log n) = h$ #sym.square.filled

=== Aussage 2

Ein Heap mit $n$ Elementen hat höchstens $ceil(n/2^(h+1))$ Knoten auf Höhe $h$.

==== Beweis

// TODO

=== Aussage 3

Für alle $-1 < x < 1$ gilt

$
sum_(k=0)^infinity k x^k = x/(1-x)^2
$

==== Beweis

Die unendliche geometrische Reihe mit Basis $|q|<1$ ist

$
sum_(k=0)^infinity q^k &= 1/(1-q)
$

Beidseitiges differenzieren liefert

$
sum_(k=0)^infinity k q^(k-1) = 1/(1-q)^2
$

Wir multiplizieren $q$ hinzu

$
sum_(k=0)^infinity k q^(k-1) dot q &= 1/(1-q)^2 dot q\
<=> sum_(k=0)^infinity k q^k &= q/(1-q)^2
#h(4pt) square.filled
$

== Strassen

Um die Matrixmultiplikation rekursiv zu berechnen, vierteln wir die Problemgröße. Wir berechnen jeden Quadranten der Ausgabe seperat als $n slash 2 times n slash 2$ Matrix.

#include "strassen.typ"

Die vier Ausgabematrizen werden durch die Eingabematrizen folgenderweise berechnet

$
O_(i j) = sum_(k=1)^2 M_(i k) dot N_(k j)
$

Die Berechnung eines Quadranten teilt das Problem wiederum in vier, bis der Base Case erreicht ist. Das ist, wenn die Eingabematrizen $1 times 1$ Matrizen, also Skalare sind. Dann werden lediglich die Zahlen miteinander multipliziert.

=== Korrektheitsbeweis Rekursion

Die Multiplikation zweier $n times n$ Matrizen $M=(m_(i j))$ und $N=(n_(i j))$ ist per Definition

$
o_(i j) = sum_(k=1)^n m_(i k) n_(k j)
$

Betrachten wir zunächst die Berechnung von $O_11$.

#include "o11.typ"

Wir umschreiben die Berechnung so, dass wir uns auf die ganzen Matrizen $M$ und $N$ beziehen. ($m_(i j)$ und $n_(i j)$ sind Einträge aus $M$ und $N$. $o_(i j)$ sind Einträge aus $O_11$.)

$
O_11 &= M_11 dot N_11 + M_12 dot N_21 \
o_(i j) &= sum_(k=1)^(n slash 2) m_(i k) n_(k j) +
sum_(k=n slash 2 + 1)^n m_(i k) n_(k j) \
&= sum_(k=1)^n m_(i k) n_(k j)
#h(4pt) checkmark
$

Um $O_22$ in Bezug auf $M$ und $N$ umzuschreiben, verschieben wir die Indizes, indem wir definieren $p := i - n slash 2$ und $q := j - n slash 2$.

$
O_22 &= M_21 dot N_12 + M_22 dot N_22 \
o_(p q) &= sum_(k=1)^(n slash 2) m_(i k) n_(k j) +
sum_(k=n slash 2 + 1)^n m_(i k) n_(k j) \
&= sum_(k=1)^n m_(i k) n_(k j)
#h(4pt) checkmark
$

Das gleiche könnten wir für $O_12$ und $O_21$ machen, indem wir als Ausgabe $o_(p j)$ und $o_(i q)$ wählen. #sym.square.filled

=== Korrektheitsbeweis Strassen

Wir zeigen für jeden Quadranten $O_11$, $O_12$, $O_21$ und $O_22$, dass er korrekt ist. 

==== Erster Quadrant (11)

Definition abschreiben:

$
O_11 &= H_1 + H_4 - H_5 + H_7 \
&= (M_11 + M_22) dot (N_11 + N_22) + \
&#hide($=$) M_22 dot (N_21 - N_11) - \
&#hide($=$) (M_11 + M_12) dot N_22 + \
&#hide($=$) (M_12 - M_22) dot (N_21 + N_22) \
$

Die Matrixmultiplikation ist distributiv; es gilt $A(B+C) = A B+A C$ und $(B+C)D = B D + C D$.

$
O_11 =& M_11 N_11 + M_11 N_22 + M_22 N_11 + M_22 N_22 + \
&M_22 N_21 - M_22 N_11 - \
&M_11 N_22 - M_12 N_22 + \
&M_12 N_21 + M_12 N_22 - M_22 N_21 - M_22 N_22
$

Die meisten Terme heben sich gegenseitig auf.

$
O_11 &= M_11 N_11 + M_12 N_21
$

Die Korrektheit dieses Termes haben wir oben bewiesen. #sym.checkmark

==== Zweiter Quadrant (21)

$
O_21 &= H_3 + H_5 \
&= M_11 dot (N_12 - N_22) + 
(M_11 + M_12) dot N_22 \
&= M_11 N_12 - M_11 N_22 + M_11 N_22 + M_12 N_22 \
&= M_11 N_12 + M_12 N_22
$

Die Korrektheit dieses Termes haben wir auch oben bewiesen. #sym.checkmark