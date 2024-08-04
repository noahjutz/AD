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

==== Primfaktorzerlegung

Um den ggT von $a$ und $b$ zu ermitteln, können wir $a$ und $b$ probeweise durch Faktoren teilen. Beispiel mit $a = 3528, b = 3780$:

#align(center, include "ggt_primes_step1.typ")

Um systematischer vorzugehen, ermitteln wir die gemeinsamen minimalen Faktoren von $a$ und $b$ durch Primfaktorzerlegung.

$
3528 &= 2^3 dot 3^2 dot 5^0 dot 7^2 \
3780 &= 2^2 dot 3^3 dot 5^1 dot 7^1
$

Die gemeinsamen Faktoren von $a$ und $b$ sind in diesem Beispiel $2^2, 3^2, 7$. Multipliziert man sie, so erhält man

$
gcd(3528, 3780) = 2^2 dot 3^2 dot 7 = 252
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
  x = 1
  while x % a != 0 or x % b != 0:
    x += 1
  return x
```

==== Primfaktorzerlegung

Um das kleinste gemeinsame Vielfache von $a$ und $b$ zu ermitteln, nehmen wir dieses mal nicht die Schnittmenge beider Primfaktorzerlegungen, sondern die Vereinigung. Wir erweitern also die eine Zerlegung um die Faktoren, welche zusätzlich in der anderen sind.

#include "kgv_primes.typ"

==== Zusammenhang ggT / kgV

Wir haben etabliert, dass beim ggT die gemeinsamen Primfaktoren multipliziert werden, während beim kgV die überschüssigen Primfaktoren hinzumultipliziert werden.

$
gcd(a, b) &= product_(p in PP) p^(min(e_p, f_p)) \
op("lcm")(a, b) &= product_(p in PP) p^(max(e_p, f_p))
$

Daraus lässt sich folgender Zusammenhang schließen:

$
gcd(a, b) dot op("lcm")(a, b) = a dot b
$

Das liegt daran, dass:

$
p^(min(e_p, f_p)) dot p^(max(e_p, f_p)) = p^(e_p+f_p)
$

=== Sieb des \ Eratosthenes

Eine Primzahl hat genau zwei Teiler: sich selbst und 1. Das Gegenstück ist eine Zusammengesetzte Zahl; diese hat mindestens zwei Primfaktoren. Die 1 ist weder prim noch zusammengesetzt.

$
PP = {2, 3, 5, 7, 11, 13, 17, 19, ...}
$

Die Menge aller Primzahlen sind also die natürlichen Zahlen ohne zusammengesetze Zahlen und ohne 1.

==== Prinzip

Um alle Primzahlen bis zu einem Wert $n$ herauszufinden, entfernen wir schrittweise alle zusammengesetzten Zahlen aus der Menge {2, 3, 4, ..., n}. Im Beispiel ist $n = 50$.

#import "eratosthenes.typ": sieve
#sieve(0)

Wir wissen, dass 2 eine Primzahl ist. Im ersten Schritt streichen wir alle Vielfachen von 2. Übrig bleiben alle Werte, dessen Primfaktorzerlegung nicht die 2 enthält.

#sieve(2)

Der nächsthöhere Wert, der keine 2 als Primfaktor hat, ist 3. Weil es keine Primzahl kleiner als 2 gibt, hat 3 keine Primfaktoren, und ist somit eine Primzahl. Analog zum ersten Schritt streichen wir alle Vielfachen von 3.

#sieve(3)

Der nächsthöhere Wert, der keine Primfaktorzerlegung hat, ist 5. Vielfache von 4 zu streichen wäre redundant, weil alle Vielfachen von 4 auch Vielfache von 2 sind.

#sieve(5)