= Beweise

== Stellenwertsystem <proof-positional-system>

=== Zu zeigen

"Es gibt eine Stellenwertnotation für jede natürliche Zahl."

$
forall x in NN, b in {2, 3, 4, ...}:
exists #h(2pt) x_n...x_2x_1x_0
$

$
"mit" x_i in {0, 1, 2, ..., b-1}
$

$
"und" x = sum_(i=0)^m a_i dot b^i
$

=== Beweis
==== Induktionsanfang

$x = 1$

Die Stellenwertnotation von 1 ist für jede Basis 1. 

$
1 = sum_(i=0)^0 underbrace(x_0, =1) dot b^0
#h(4pt) checkmark
$

==== Induktionsschritt

$x -> x+1$

Wenn es für $x$ genau eine Stellenwertnotation $x_n...x_2x_1x_0$ gibt, dann gibt es auch für $y = x + 1$ eine Stellenwertnotation $y_(n+1)...y_2y_1y_0$.

==== Fall 1

Die niederwertigste Ziffer kann erhöht werden ($x_0 + 1 < b$)

Die Stellenwertnotation für $x+1$ ist

$
x_n...x_2x_1(x_0+1)
#h(4pt) checkmark
$

==== Fall 2

Es gibt keinen höheren Ziffernwert ($x_0 + 1 = b$)

Weil der Stellenwert sich mit jeder Stelle um Faktor $b$ erhöht, kann eine Zahl mit maximalem Ziffernwert $a_i = b - 1$ um 1 erhöht werden, indem man die vorangestellte Ziffer $a_(i+1)$ erhöht (carry). 

$
y = sum_(i=0)^(n+1) y_i dot b^i
$

$
y_i = cases(
  x_i "falls es keinen carry mehr gibt",
  x_i+1 "falls" x_i+1<b,
  0 "sonst"
)
#h(12pt) checkmark
$

Damit ist bewiesen, dass jede Stellenwertnotation um 1 erhöht werden kann, wodurch der Induktionsbeweis gilt. $square.filled$

== Grenzwert der Fibonacci-Folge <proof-fib-limit>

=== Zu zeigen

Das Verhältnis zwei aufeinanderfolgender Fibonacci-Zahlen $f_(n+1)/f_n$ konvergiert gegen $phi approx 1.618$.

=== Beweis

$
&& f_n &= f_(n-1) + f_(n-2) \
&<=>& f_n/f_(n-1) &= f_(n-1)/f_(n-1) + f_(n-2)/f_(n-1) \
&<=>& f_(n+1)/f_n &= 1 + f_n/f_(n+1) \
&<=>& x &= 1 + 1/x \
&<=>& x^2 &= x + 1 \
&<=>& 0 &= x^2 - x - 1 \
&<=>& x &= (1 plus.minus sqrt(5))/2
$

$
phi = (1+sqrt(5))/2 approx 1.618
#h(4pt) square.filled
$

== Kadane <proof-kadane>

=== Zu zeigen

Der Algorithmus von Kadane zur Berechnung der maximalen Teilsumme eines Tupels $(x_1, x_2, x_3, ..., x_n)$ ist korrekt.

=== Beweis

Wir zeigen zunächst, dass nach jedem $i$-ten Schritt folgende Schleifeninvariante gilt: $sigma_i$ ist die maximale Teilsumme, welche an Stelle $i$ endet.

==== Induktionsanfang

$i = 1$

Da $sigma_0 = 0$ als das neutrale Element der Addition initialisiert wird, wird im dieser Wert ersten Schritt immer zu $x_1$. Die triviale Teilfolge der Länge 1 hat auch die maximale Teilsumme von $sigma = x_1$.

$
sigma_1 := max {sigma_0, sigma_0 + x_1} = sigma_0 + x_1 = x_1
#h(4pt) checkmark
$

==== Induktionsschritt

$i -> i + 1$

Wenn $sigma_i + x_i$ kleiner ist als $x_i$, und $sigma_i$ die maximale Teilsumme mit Ende $i$ ist, dann gibt es keine Teilfolge vor $x_i$, welche die Teilsumme erhöhen würde.

$
sigma_(i+1) = max {sigma_i, sigma_i + x_i}
#h(4pt) checkmark
$

==== Induktionsschluss

Weil $sigma_i$ die maximale Teilsumme, welche an Stelle $i$ endet, ist, ist das Ergebnis einfach das Maximum aller $sigma_i$.

$
"maxTeilSum" = max_(0 < i < n) sigma_i
#h(4pt) square.filled
$