= Minimaler Spannbaum

Für die Konstruktion eines MSTs ist eine Eigenschaft gewichteter zusammenhängender Graphen wichtig: Wenn man die Knotenmenge $V$ in zwei schneidet ($U$ und $V \\ U$), gibt es eine oder mehrere Kanten, welche den Schnitt überqueren. Die Kante mit dem geringsten Gewicht ist für einen MST geeignet (solange der Schnitt nicht bereits durch den MST überquert wird).

Beweis: Es muss bei jedem möglichen Schnitt mindestens eine Kante geben, die $U$ mit $V \\ U$ verbindet, weil ein MST alle Knoten miteinander verbindet. Wählt man die Kante mit kleinstem Gewicht, wird das gesamte Gewicht kleiner. Cut-And-Paste Beweis in @bib-mst-proof.

Beispiel:

#align(center, include "property.typ")

Wir können $(a, c)$ oder $(a, d)$ wählen, um einen MST zu konstruieren, weil dessen Gewicht minimal ist.

== Kruskal

Alle Kanten werden aufsteigend nach Gewicht sortiert. Eine Kante nach der Anderen wird zum MST hinzugefügt, wenn sie zwei disjunkte Teilgraphen verbindet.

Korrektheit: Es darf keine disjunkten Teilgraphen geben, weil der Spannbaum alle Knoten verbinden muss. Es gibt keine Kante mit geringerem Gewicht, die infrage kommt, weil die Kanten sortiert abgearbeitet werden.

Implementierung: Disjunkte Teilgraphen sind Mengen an Knoten. Mengen werden durch invertierte Bäume implementiert, sodass der Repräsentant in $O(log n)$ gefunden werden kann. Mengen werden vereinigt, indem der kleinere Baum an den Repräsentanten des Größeren gehängt wird.

== Prim

Von einem beliebigen Startknoten aus wird immer die Kante mit dem geringsten Gewicht hinzugefügt, wenn der Zielknoten nicht bereits besucht wurde.

Korrektheit: Wir nennen die Knoten des teilweise konstruierten MSTs $U$ und die übrigen $V \\ U$. Prim wählt in jedem Schritt eine minimale Kante, welche $U$ mit $V \\ U$ verbindet. Diese Kante ist sicher. (Korollar 21.2 CLRS)

Implementierung: Mit Min-Prioritätswarteschlange der noch nicht abgearbeiteten Knoten.
