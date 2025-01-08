= Graphen

== Adjazenzmatrix

$G$ ist gerichtet, weil die Adjazenzmatrix keine strikte Dreiecksmatrix ist.

=== Breitensuche

#include "bfs.typ"

=== Tiefensuche

Für die iterative Implementierung verwenden wir einen Stack $Q$. Die Nachbarn des obersten Elements werden in jeder Iteration in umgekehrter Reihenfolge auf den Stack gelegt.

Dadurch, dass bereits besuchte Knoten in dieser Implementierung nochmal besucht werden können, kann es zu Duplikaten kommen. Eine mögliche Lösung dafür wird in @bib-dfs-iterative beschrieben.

#include "dfs.typ"

=== Potenz einer Adjazenzmatrix

Im Quadrat einer Adjazenzmatrix $A^2$ hält in $a_(i j)$ die Anzahl an Pfäden, die von Knoten $i$ nach $j$ über einen anderen Knoten $k$ wandern. In anderen Worten sind das die Pfäde von $i$ nach $j$ der Länge 2.

Multipliziert man nochmal $A$ hinzu, erhält man die Anzahl an Pfäden, die von $i$ nach $j$ über der Pfad $A^2_(i j)$ und einen dritten Knoten $k$ wandern.

Man kann induktiv beweisen, dass $A^m$ im allgemeinen die Anzahl an Pfäden der Länge $m$ von $i$ nach $j$ in $a_(i j)$ enthält. @bib-adj-mtx-powers

== Inzidenzmatrix

Das Produkt einer Inzidenzmatrix $B_(abs(V) times abs(E))$ mit ihrer Transponierten $B B^T$ liefert die #link("https://en.wikipedia.org/wiki/Laplacian_matrix")[Laplace-Matrix] $L_(abs(V) times abs(V))$ des Graphen.

für alle Knotenpaare $i$ und $j$ die Pfäde, welche von $i$ ausgehen und in $j$ eingehen oder umgekehrt. In anderen Worten ist das die Anzahl an Pfäden, die $i$ und $j$ direkt miteinander verbinden (0, 1 oder 2).

Die Einträge der Produktmatrix sind negativ, weil eine Kante das Produkt des Ausgangs und des Eingangs ist ($-1 dot 1$).

Die Hauptdiagonale ($i=j$) enthält in $a_(i i)$ den Grad des Knotens $i$. Die Matrixmultiplikation mit einer Transponierung entspricht in diesem Fall der Summe der Absolutbeträge.