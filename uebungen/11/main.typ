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