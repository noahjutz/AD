= Graphen

== Speicherung

=== Adjazenzmatrix

Der Knoten $v_i$ in Zeile $i$ zeigt auf die Knoten $v_j$ in Spalte $j$, wenn $a_(i j) = 1$ ist.

#include "adjacency_matrix.typ"

=== Adjazenzfeld

Wir speichern für jeden Knoten seine ausgehenden Kanten in einer flachen Liste.

#include "adjacency_list_dense.typ"

