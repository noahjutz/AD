#import "/config.typ"
#import "/components/code.typ": code
#show: config.config

= Komplexität

== Registermaschine

Die Formel lässt sich algorithmisch folgendermaßen definieren:

#grid(
  columns: (auto, 1fr),
  column-gutter: 12pt,
  align: horizon,
  $
  sum_(i=1)^n i^3 <==>
  $,
  [
    #set block(width: 100%)
    ```py
    result = 0
    for i in range(n):
      result += i ** 3
    ```
  ]
)

Ein For-Loop kann mit Jumps realisiert werden, und eine Potenz lässt sich als Aneinanderreihung mehrerer MUL-Befehle umschreiben.

#code(
  read("instructions.txt"),
  (
    (0, 1, $f(1) := 1$),
    (2, 2, $i := "input"$),
    (3, 5, $f(0) := i^3$),
    (6, 7, $r := r + f(0)$),
    (8, 10, $i := i - 1$),
    (11, 11, $"for" i > 0$),
    (12, 13, "Ausgabe")
  )
)

Der Zustand einer Registermaschine setzt sich aus Instruction-Pointer und Speicherzellen zusammen. In jeder Iteration führt er die aktuelle Anweisung aus und manipuliert dabei seinen Zustand. In Python kann man das als Iterable umsetzen.

#set block(width: 100%)
```python
cmd, arg = instructions[ip]
if cmd == "hlt":
    raise StopIteration

getattr(commands, cmd)(arg)
return [ip, mem]
```

== O-Notation

=== Aussage 1

$
17 + 22 + 45 = O(1)
$

==== Beweis

$
O(f(n)) &= {
  g(n) mid(|) #box(baseline: 50%)[
    $
    exists c > 0, n_0 in NN : \
    forall n >= n_0 : g(n) <= c dot f(n)
    $
  ]
} \
O(1) &= {
  g(n) mid(|) #box(baseline: 50%)[
    $
    exists c > 0, n_0 in NN : \
    forall n >= n_0 : g(n) <= c
    $
  ]
} \
&= {g(n) | exists c > 0 : g(n) <= c} \
&= RR^+ \
&in.rev 17 + 22 + 45 #h(4pt) square.filled
$

=== Aussage 2

$
5n^3 + 12n^2 + 3n + 5 = Omega(n^3)
$

==== Beweis

$
Omega(f(n)) &= {
  g(n) mid(|) #box(baseline: 50%)[
    $
    exists c > 0, n_0 in NN : \
    forall n >= n_0 : g(n) >= c dot f(n)
    $
  ]
} \
&supset {g(n) | g(n) >= f(n)} \
Omega(n^3) &supset {g(n) | g(n) >= n^3} \
&in.rev 5n^3 + 12n^2 + 3n + 5
$

Weil $n lt.not 0$. $square.filled$

=== Aussage 3

$
2^(n+1) = O(2^n)
$

==== Beweis

$
2^(n+1) &= bold(2) dot 2^n \
<=> g(n) &= 2 dot f(n) \
<=> g(n) &= c dot f(n) \
=> g(n) &in Theta(f(n)) \
=> g(n) &in O(f(n)) #h(4pt) square.filled
$

=== Aussage 4

$
2^(2n) = O(2^n)
$

==== Gegenbeweis

Reductio ad absurdum

$
2^(2n) in O(2^n)
&=> f(n) = 2^n \
&=> g(n) = 2^(2n)
$

$
g(n) &<= c dot f(n) \
2^(2n) &<= c dot 2^n \
(2^n)^2 &<= c dot 2^n \
2^n &<= c arrow.zigzag
$

Es gibt kein $c > 0$, welches für alle $n > n_0$ die Funktion $2^n$ nach oben beschränkt. Daher ist die Annahme falsch. $square.filled$

=== Aussage 5

$
log(n!) = Theta(n log n)
$

==== Beweis

Wir verwenden die Stirlingformel.

$
log(n!) &approx log(sqrt(2 pi n) dot (n/e)^n) \
&= log(sqrt(2 pi n)) + log((n/e)^n) \
&= log((2 pi n)^(1/2)) + log((n/e)^n) \
&= 1/2 log(2 pi n) + n log(n/e) \
&= 1/2 log(2 pi) + 1/2 log(n) \
&#hide($=$) + n log(n) - n log(e)
$

Der dominierende Term ist $n log n$. Eine Funktion $g(n)$ ist immer durch ihren dominierenden Term $f(n)$ nach oben und nach unten beschränkt, weil alle untergeordneten Terme durch ein passendes $c$ ausgeglichen werden können. $square.filled$

=== Aussage 6

$
2^n = O(n!)
$

==== Beweis

$
lim_(n -> infinity) 2^n/n!
&= lim_(n -> infinity) 2^n/(sqrt(2 pi n) dot (n/e)^n) \
&=lim_(n -> infinity) (2^n e^n)/(sqrt(2 pi n) dot n^n) \
&=lim_(n -> infinity) 1/sqrt(2pi) dot
  ((2e)/(sqrt(n) dot n))^n \
&=lim_(n -> infinity) 1/sqrt(2pi) dot
  (lim_(n -> infinity) (2e)/(sqrt(n) dot n))^n \
&=1/sqrt(2pi) dot (0)^n \
&= 0 \
&<= c #h(4pt) square.filled
$

=== Aussage 7

$
n! = O(n^n)
$

==== Beweis

$
n! = product_(i=1)^n i <= product_(i=1)^n n = n^n
#h(4pt) square.filled
$

=== Aussage 8

$
6^(-5) n^(1.25) = Theta(sqrt(n))
$

==== Gegenbeweis

Wir vernachlässigen den konstanten Faktor $6^(-5)$ und konzentrieren uns auf die obere Schranke.

$
n^1.25 in O(n^0.5)
$

Dafür ist notwendig, dass $n^0.5$ dominiert. Das ist nicht der Fall, damit ist die Annahme falsch.

$
lim_(n -> infinity) n^1.25/n^0.5
= (lim_(n -> infinity) n)^(1.25-0.5)
= infinity
#h(4pt) square.filled
$

== Formel von Binet

Die Glieder der Fibonacci-Folge $f_n$ können durch die Formel von Binet berechnet werden.

=== Satz

$
forall n in NN_0:
f_n = (phi^n - psi^n)/(phi-psi)
$

$
"mit" phi = (1+sqrt(5))/2 "und" psi = (1-sqrt(5))/2
$

=== Beweis

==== Anfang (n = 0, n = 1)

Wir Zeigen im Induktionsanfang, dass die Aussage für $f_0$ und $f_1$ gilt, sodass wir im Induktionsschritt für alle $f_2, f_3, ...$ auf die beiden Vorgänger zurückgreifen können.

$
f_0 = 0 = (phi^0-psi^0)/(phi-psi)
#h(4pt) checkmark
$

$
f_1 = 1 = (phi-psi)/(phi-psi)
#h(4pt) checkmark
$

==== Schritt (n - 2, n - 1 #sym.arrow n)

Wir nehmen an, dass die Aussage für die Vorgänger $f_(n-2)$ und $f_(n-1)$ gilt. Wenn die Aussage auch für $f_n$ gilt, dann ist bewiesen, dass sie für alle $n in NN_0$ gilt.

$
f_n = f_(n-1) + f_(n-2)
$

Per Induktionsannahme dürfen wir einsetzen:

$
f_n = (phi^(n-1)-psi^(n-1))/(phi-psi) +
  (phi^(n-2)-psi^(n-2))/(phi-psi) \
$

Umformen:

$
#hide($f_n$) = (
  (phi^(n-1) + phi^(n-2)) - (psi^(n-1)+psi^(n-2))
) / (phi-psi)
$

Ausklammern:

$
#hide($f_n$) = (
  phi^(n-2) dot (1 + phi) - psi^(n-2) dot (1 + psi)
) / (phi-psi)
$

Wir nutzen, dass $phi^2 = phi + 1$ und $psi^2 = psi + 1$.

$
#hide($f_n$) &= (
  phi^(n-2) dot phi^2 - psi^(n-2) dot psi^2
) / (phi-psi) \
&= (phi^n-psi^n)/(phi-psi)
#h(4pt) square.filled
$

=== Vereinfachung

Die Formel von Binet besteht aus einem Minuend und einem Subtrahend.

#grid(columns: 2, column-gutter: 12pt, align: horizon,
  $
  phi^n/sqrt(5) - psi^n/sqrt(5)
  $,
  text(fill: gray)[(Per Definition: $phi-psi=sqrt(5)$)],
)


Der Term $psi^n$ konvergiert gegen null und ist bereits ab $n >= 0$ im Intervall $[-1, 1]$.

#include "psi_convergence.typ"

Der Subtrahend verändert das Ergebnis also um weniger als $1/2$.

$
abs(psi^n/sqrt(5)) <= 1/sqrt(5) < 1/2
$

Dieser Fehler wird durch Rundung korregiert, weil die Formel von Binet eine ganze Zahl liefert. Es gilt also die vereinfachte Formel von Binet:

$
(phi^n-psi^n)/(phi-psi) = round(phi^n/(phi-psi))
#h(8pt) forall n in NN_0
$

=== Laufzeit

Die Laufzeit der rekursiven Berechnug einer Fibonacci-Zahl $f_n$ ist exponentiell, weil jeder Funktionsaufruf zwei weitere Aufrufe tätigt.

#include "rec_tree.typ"