= Graphen

== Speicherung

=== Adjazenzmatrix

Der Knoten $v_i$ in Zeile $i$ zeigt auf die Knoten $v_j$ in Spalte $j$, wenn $a_(i j) = 1$ ist.

#include "adjacency_matrix.typ"

=== Adjazenzliste (dicht)

Wir speichern für jeden Knoten seine ausgehenden Kanten in einer flachen Kantenliste.

#include "adjacency_list_dense.typ"

Um den ausgehenden Kanten ihre Knoten zuzuordnen, erstellen wir eine Zuordnungsliste, welche an Index $i$ für den Knoten $v_i$ speichert, welches Segment diesem Knoten gehört. 

#block(width: 100%, include "adjacency_list_dense_map.typ")

Das Segment wird am Index der ersten Kante identifiziert. hat der Knoten keine ausgehende Kanten, so wird ein Sentinel (-1) verwendet.

=== Adjazenzliste (gestreut)

=== Adjazenzliste (hybrid)