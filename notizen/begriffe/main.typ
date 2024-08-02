#import "../../config.typ"
#show: doc => config.config(doc)
#show: doc => config.page(doc)

= Begriffe
== Algorithmen
=== ggT

Man sagt "$x$ teilt $a$", wenn $a$ ohne Rest durch $x$ teilbar ist.

$
x divides a
$

Der größte gemeinsame Teiler von $a$ und $b$ $gcd(a, b)$ ist der größte Wert, für den gilt:

$
x divides a and x divides b
$

==== Euklid

Haben $a$ und $b$ mit $a>b$ einen gemeinsamen Teiler $x$, so ist die Differenz $d=a-b$ auch ein vielfaches von $x$.

#include "ggt_proof.typ"

Die Rechnung ist also gleich, wenn statt $a$ und $b$ die Parameter $b$ und $d$ verwendet werden.

$
gcd(a, b) = gcd(a-b, b) = x
$

#include "euclid.typ"

Irgendwann sind $a_n$ und $b_n$ gleich. Der ggT ist dann $x = a_n = b_n$. Dieses $x$ teilt auch $a_0$ und $b_0$, weil der umgekehrte Schritt lediglich ein vielfaches von $x$ zu $a$ addiert.
  
#stack(dir: ltr, spacing: 20pt,
  $
  a_(n-1) = a_n + b_n
  $, $
  b_(n-1) = b_n
  $
)

Dieser Algorithmus zur berechnung des ggT ist der *einfache euklidische Algorithmus*. Der Pseudo-Code ist wie folgt.

```py
def gcd_euclid(a, b):
  if a == b: return a
  a_next = max(b, a - b)
  b_next = min(b, a - b)
  gcd(a_next, b_next)
```

Passt ein $b$ mehrmals in ein $a$, so müssen mehrere Subtraktionsschritte getätigt werden, welche durch eine Moduloberechnung konsolidiert werden können.

#import "@preview/xarrow:0.3.1": xarrow
$
a_0 -->^(-b) a_1 -->^(-b) a_2 -->^(-b) a_n \
a_0 xarrow(#h(24pt) mod b #h(24pt)) a_n
$

Der *verbesserte Algorithmus* gibt $b$ aus, wenn $a mod b = 0$, weil $b$ der kleinere Wert ist und $a$ durch $b$ teilbar ist.
  
Des Weiteren ist $r = a mod b$  per Definition des Modulo immer kleiner als $b$, wir können uns also die $max$/$min$-berechnung sparen.

```py
def gcd_euclid_fast(a, b):
    if a % b == 0: return b
    a_next = b
    b_next = a % b
    return gcd(a_next, b_next)
```

Iterativ kann der Algorithmus folgendermaßen umgeschrieben werden:

```py
def gcd_euclid_fast_iterative(a, b):
  while a % b != 0:
    a, b = b, a % b
  return b
```

#colbreak()
=== kgV
Man nennt $x$ ein Vielfaches von $a$, wenn es ein $k in ZZ$ gibt, sodass

$
x = k dot a
$

Ein gemeinsames Vielfaches von $a$ und $b$ erfüllt mit $k_1, k_2 in ZZ$:

$
x = k_1 dot a = k_2 dot b
$

Zum Beispiel ist 12 ein Vielfaches von 4 und 6, weil $12 = 3 dot 4 = 2 dot 6$.

#include "vielfaches.typ"

Das kleinste gemeinsame Vielfache ist der kleinste Wert $x$, der sowohl ein Vielfaches von $a$ als auch von $b$ ist. Man schreibt:

$
op("lcm")(a, b)
$

Eine naive Implementierung prüft alle $x in NN$ auf die Bedingung $a divides x and b divides x$.

```py
def lcm_naive(a, b):
  n = 1
  while n % a != 0 or n % b != 0:
    n += 1
  return n
```



// TODO zusammenhang kgV und ggT
// Weil $a$ mehrmals in $x$ passt, sagt man auch $a$ teilt $x$.
// 
// $
// a divides x
// $

