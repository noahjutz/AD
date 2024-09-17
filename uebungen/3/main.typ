#import "/config.typ": theme

= Rekursion

== MaxTeilSum-2d

Gesucht ist die Teilmatrix, dessen Komponenten aufsummiert maximal sind.

=== Naiver Algorithmus

Man könnte durch alle Teilmatrizen iterieren und die Summen vergleichen. Laufzeit: $Theta(n^4)$.

```python
for i1 in range(n+1):
  for i2 in range(i1):
    for j1 in range(n+1):
      for j2 in range(j1):
        matrix[i2:i1, j2:j1].sum()
```

=== Mit Kadane

Der Algorithmus von Kanade findet die maximale Teilsumme eines Arrays in linearer Laufzeit. Die For-Loops mit Zähler $i_1$ und $i_2$ iterieren durch alle möglichen Zeilenkombinationen. Summieren wir die Zeilen von $i_1$ bis $i_2$ spaltenweise auf, erhalten wir ein Array, das der Algorithmus von Kanade verarbeiten kann.

```python
for i1 in range(n+1):
  for i2 in range(i1):
    yield np.sum(mtx[i2:i1], axis=0)
```

Die Laufzeit ist nur noch $Theta(n^3)$, weil es $n^2$ Zeilenkombinationen gibt, welche jeweils mit dem linearen Algorithmus von Kadane verarbeitet werden. Gesamtes Programm: @code-mts2d

== Rekursionsgleichungen

#let hl(math) = {
  set text(fill: theme.primary)
  math
}

=== Gleichung 1

$
T(n) = cases(
  1 "falls" n=1,
  4T(n/2) + n "sonst"
)
$

==== Iteration

$
T(n) &=& 4 &hl(T(n/2^1)) + n/2^0 \
&=& 4 (4 &hl(T(n/2^2)) + n/2^1) + n/2^0 \
&=& 4 (4 (4 &hl(T(n/2^3)) + n/2^2) + n/2^1) + n/2^0 \
&=& 4 (4 (4 (4 &hl(T(n/2^4)) + n/2^3) + n/2^2) + n/2^1) + n/2^0 \
$

$
#hide($T(n)$) &= ... \
&= 4^i T(n/2^i) + sum_(k=0)^i n/2^k
$

Wobei $i$ die Rekursionstiefe ist. Der Base-Case ist bei einer Eingabelänge von 1 erreicht.

$
n/2^i &= 1 \
n &= 2^i \
log_2 n &= i
$

Der Base-Case ist also nach $log_2 n$ Rekursionen erreicht.

$
T(n) &= 4^(log_2 n) T(n/2^(log_2 n)) + sum_(k=0)^(log_2 n) n/2^k \
&= (2^(log_2 n))^2 T(1) + n sum_(k=0)^(log_2 n) (1/2)^k \
&= n^2 + n dot (1-(1/2)^(log_2 n+1))/(1-1/2) \
&= n^2 + n dot 2 dot (1 - 1/(2 dot 2^(log_2 n))) \
&= n^2 + n (2 - 1/n) \
&= n^2 + 2n - 1 \
&= Theta(n^2)
$

==== Beweis

Zu zeigen:

$
T(n) = Theta(n^2)
$

Induktionsanfang:

$
T(1) = 1 = 1^2
#h(4pt) checkmark
$

Induktionsschritt:

$
T(n) &= 4 underbrace(T(n/2), = Theta(n^2)) + n \
&= 4n^2 + n \
&= Theta(n^2)
#h(4pt) checkmark
$

=== Gleichung 2