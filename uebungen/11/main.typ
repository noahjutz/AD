= Graphen

== Adjazenzmatrix

$G$ ist gerichtet, weil die Adjazenzmatrix keine strikte Dreiecksmatrix ist.

=== Breitensuche

#include "bfs.typ"

=== Tiefensuche

Für die iterative Implementierung verwenden wir einen Stack $Q$. Die Nachbarn des obersten Elements werden in jeder Iteration in umgekehrter Reihenfolge auf den Stack gelegt.

Dadurch, dass bereits besuchte Knoten in dieser Implementierung nochmal besucht werden können, kann es zu Duplikaten kommen. Eine mögliche Lösung dafür wird in @bib-dfs-iterative beschrieben.

#include "dfs.typ"