= Graphen

== Speicherung

=== Adjazenzmatrix

Der Knoten $v_i$ in Zeile $i$ zeigt auf die Knoten $v_j$ in den Spalten $j$, welche mit 1 besetzt sind.

#include "adjacency_matrix.typ"

=== Adjazenzfeld

Wir speichern für jeden Knoten seine ausgehenden Kanten in einer flachen Liste.

#include "adjacency_list_dense.typ"