#import "/config.typ": theme
#import "/components/math.typ": hlp
#import "/components/admonition.typ": admonition

= Rekursion

== MaxTeilSum-2d

Gesucht ist die Teilmatrix, dessen Komponenten aufsummiert maximal sind.

#align(center,
  box(width: 50%,
    include "mts_2d.typ"
  )
)

=== Naiver Algorithmus

Man könnte durch alle Teilmatrizen iterieren und die Summen vergleichen. Die Laufzeit ist $Theta(n^6)$, weil es $n^4$ Kombinationen gibt, welche in $n^2$ Zeit summiert werden

```python
for i2 in range(n+1):
  for i1 in range(i2):
    for j2 in range(n+1):
      for j1 in range(j2):
        matrix[i1:i2, j1:j2].sum()
```

=== Mit Kadane

Der Algorithmus von Kanade findet die maximale Teilsumme eines Arrays in linearer Laufzeit. Die For-Loops mit Zähler $i_1$ und $i_2$ iterieren durch alle möglichen Zeilenkombinationen. Summieren wir die Zeilen von $i_1$ bis $i_2$ spaltenweise auf, erhalten wir ein Array, das der Algorithmus von Kanade verarbeiten kann.

```python
for i2 in range(n+1):
  for i1 in range(i1):
    yield np.sum(mtx[i1:i2], axis=0)
```

Die Laufzeit ist nur noch $Theta(n^3)$, weil es $n^2$ Zeilenkombinationen gibt, welche jeweils mit dem linearen Algorithmus von Kadane verarbeitet werden. Gesamtes Programm: @code-mts2d

== Iteration und Substitution

=== Gleichung 1

$
T(n) = cases(
  1 "falls" n=1,
  4T(n/2) + n "sonst"
)
$

==== Iteration

$
T(n) = 4 &hlp(T(n/2^1)) + n/2^0 \
= 4 (4 &hlp(T(n/2^2)) + n/2^1) + n/2^0 \
= 4 (4 (4 &hlp(T(n/2^3)) + n/2^2) + n/2^1) + n/2^0 \
= 4 (4 (4 (4 &hlp(T(n/2^4)) + n/2^3) + n/2^2) + n/2^1) + n/2^0 \
$

$
= ... \
= 4^i T(n/2^i) + sum_(k=0)^i n/2^k
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

$
T(n) = cases(
  1 "falls" n=1,
  2T(n/4) + sqrt(n) "sonst"
)
$

==== Iteration

$
T(n) = 2 &hlp(T(n/4^1)) + sqrt(n/4^0) \
= 2 (2 &hlp(T(n/4^2)) + sqrt(n/4^1)) + sqrt(n/4^0) \
= 2 (2 (2 &hlp(T(n/4^3)) + sqrt(n/4^2)) + sqrt(n/4^1)) + sqrt(n/4^0) \
$

$
= ... \
= 2^i T(n/4^i) + sum_(k=0)^(i-1) 2^k sqrt(n/4^k) \
= 2^hlp(log_4 n) T(1) + sum_(k=1)^hlp(log_4 n) 2^k sqrt(n/4^k) \
= sqrt(n) + sum_(k=1)^(log_4 n) 2^k dot (1/2)^k dot sqrt(n) \
= sqrt(n) + sum_(k=1)^(log_4 n) 1^k dot sqrt(n) \
= sqrt(n) + log_4 n dot sqrt(n) \
= Theta(sqrt(n) log n)
$

=== Gleichung 3

$
T(n) = cases(
  1 "falls" n in {1, 2, 3},
  2T(n-1) + n^2 "sonst"
)
$

==== Iteration

$
T(n) = 2&hlp(T(n-1)) + n^2 \
= 2 (2&hlp(T(n-1)) + n^2) + n^2 \
= 2 (2 (2&hlp(T(n-1)) + n^2) + n^2) + n^2
$

$
= ... \
= 2^i T(n-i) + 2^(i-1) n^2 \
= 2^(n-1) T(1) + 2^(n-1) n^2 \
= 2^(n-1) dot (1 + n^2) \
= Theta(2^n)
$

==== Beweis

Induktionsanfang:

$
T(1) = 1 = 1/2 dot 2^1
#h(4pt) checkmark
$

Induktionsschritt:

$
T(n) &= 2underbrace(T(n-1), = Theta(2^n)) + n^2 \
&= 2 dot 2^(n-1) + n^2 \
&= Theta(2^n)
#h(4pt) checkmark
$

== Master-Methode

=== Gleichung 1

$
T(n) = cases(
  1 "falls" n=1,
  T(n/2)+1 "sonst"
)
$

==== Zu zeigen

$
T(n) = Theta(log n)
$

==== Beweis

- $a = 1$
- $b = 2$
- $f(n) = 1$

$
=>&& n^(log_b a) &= n^0 = 1 \
=>&& f(n) &= Theta(n^(log_b a)) \
=>&& T(n) &= Theta(n^(log_b a) log n) \
&&&= Theta(log n)
#h(4pt) square.filled
$

=== Gleichung 2

$
T(n) = cases(
  1 "falls" n=1,
  3T(n/4) + n log n "sonst"
)
$

==== Zu zeigen

$
T(n) = Theta(n log n)
$

==== Beweis

- $a = 3$
- $b = 4$
- $f(n) = n log n$
- $epsilon := 1-log_4 3$

$
=>&& n^(log_b a + epsilon) &= n \
=>&& lim_(n -> infinity) (f(n))/n^(log_b a+epsilon) &= infinity \
=>&& f(n) &= Omega(n^(log_b a+epsilon))
$

Zusätzlich muss gelten:

$
&&a dot f(n/b) &<= c dot f(n) \
<=>&& 3 dot n/4 log n/4 &<= c dot n log n \
<=>&& 3 dot (n/4 log n/4)/(n log n) &<= c \
<=>&& 3/4 log_n n/4 &<= c \
<=>&& 3/4 underbrace((1 - log_n 4), <= 1) &<= c
#h(4pt) checkmark \
$

$
=> T(n) &= Theta(f(n)) \
&= Theta(n log n)
#h(4pt) square.filled
$

=== Gleichung 3

$
T(n) = cases(
  1 "falls" n=1,
  7T(n/2)+n^2 "sonst"
)
$

==== Zu zeigen

$
T(n) = Theta(n^2.81)
$

==== Beweis

- $a = 7$
- $b = 2$
- $f(n) = n^2$
- $epsilon := log_2(7) - 2$

$
=>&& n^(log_b a - epsilon) &= n^2 \
=>&& f(n) &= Theta(n^(log_b a - epsilon)) \
=>&& T(n) &= Theta(n^(log_b a)) \
&&&approx Theta(n^2.81)
#h(4pt) square.filled
$

== Ackermannfunktion

$
f(n, m) = cases(
  m + 1 "falls" n=0,
  f(n-1, 1) "falls" m=0 "und" n >= 1,
  f(n-1, f(n, m-1)) "sonst"
)
$

=== Rekursiver Algorithmus

```python 
def ack(n, m):
    if n == 0:
        return m+1

    if m == 0 and n >= 1:
        return ack(n-1, 1)

    return ack(n-1, ack(n, m-1))
```

=== Iterativer Algorithmus

```python
stack = deque(((n, m),))
result=0

while stack:
  n, m = stack.pop()
  if m is None:
    m = result

  if n == 0:
    result = m+1
    continue
    
  if m == 0:
    stack.append((n-1, 1))
    continue
    
  stack.append((n-1, None))
  stack.append((n, m-1))

return result
```

=== Korrektheit

Um zu zeigen, dass $f(n, m)$ für alle Eingaben $(n, m) in NN_0^2$ ein Ergebnis liefert, verwenden wir eine Induktion über zwei Variablen @bib-multivariable-induction.

==== Zu zeigen

$
forall n, m in NN_0: f(n, m) "ist definiert"
$

==== Beweis

Wir zeigen, dass $f$ für alle $n$ definiert ist, indem wir zeigen, dass

$
f(n-1, m) "definiert" => f(n, m) "definiert"
$

Für jedes $n$ zeigen wir mittels verschaltelter Induktion, dass $f$ für dieses $n$ und für jedes $m in NN_0$ definiert ist.

$
f(n, m-1) "definiert" => f(n, m) "definiert"
$

==== Induktionsanfang (n = 0)

Es gilt per Definition für $n = 0$ und alle $m in NN_0$:

$
f(0, m) = m+1 #h(4pt) checkmark
$

==== Induktionsschritt (n - 1 #sym.arrow n)

Wir nehmen an, dass $f(n-1, m)$ für ein $n-1$ und alle $m in NN_0$ definiert ist. Das dürfen wir, weil wir im Basisfall gezeigt haben, dass $f(0, m)$ für alle $m in NN_0$ definiert ist.

Anhand dieser Annahme möchten wir zeigen, dass $f(n, m)$ für $n$ und alle $m in NN_0$ definiert ist.

#admonition(title: "Verschachtelte Induktion")[
  ==== Induktionsanfang (m = 0)

  $
  f(n, 0) = f(n-1, 1) "[Def.]" \
  $

  Nach Induktionsannahme ist $f$ für ein $n-1$ und alle $m in NN_0$, insbesondere $m=1$ definiert. $checkmark$

  ==== Induktionsschritt (m - 1 #sym.arrow m)

  Wir nehmen an, dass $f(n, m-1)$ definiert ist, und folgern daraus, dass $f(n, m)$ definiert ist.

  $
  f(n, m) &= f\(n-1, underbrace(f(n, m-1), =: x in NN_0 "(Nach IV)")) "[Def.]" \
  &= f(n-1, x)
  $

  Nach innerer Induktionsannahme ist $f(n, m-1) =: x$ definiert. Nach äußerer Induktionsannahme ist $f(n-1, x)$ für alle $x in NN_0$ definiert. $checkmark$

  ==== Induktionsschluss

  Wir haben gezeigt, dass $f(n, m)$ für alle $m$ definiert ist, sofern $f(n-1, m)$ für alle $m$ definiert ist. $square$
]

==== Induktionsschluss

Wir haben gezeigt, dass $f(n, m)$ für alle $n$ definiert ist, sofern $f(n-1, m)$ definiert ist. In der verschachtelten Induktion haben wir für alle $n$ gezeigt, dass $f(n, m)$ auch für alle $m$ definiert ist. $square.filled$

