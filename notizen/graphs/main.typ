= Graphen

== Speicherung

=== Adjazenzmatrix

Der Knoten $v_i$ in Zeile $i$ zeigt auf die Knoten $v_j$ in Spalte $j$, wenn $a_(i j) = 1$ ist.

#include "representation/matrix.typ"

=== Adjazenzliste (dicht)

Wir speichern für jeden Knoten seine ausgehenden Kanten in einer flachen Kantenliste.

#include "representation/list_dense.typ"

Um den ausgehenden Kanten ihre Knoten zuzuordnen, erstellen wir eine Zuordnungsliste, welche an Index $i$ für den Knoten $v_i$ speichert, welches Segment diesem Knoten gehört. 

#block(width: 100%, include "representation/list_dense_map.typ")

Das Segment wird am Index der ersten Kante identifiziert. hat der Knoten keine ausgehende Kanten, so wird ein Sentinel (-1) verwendet.

=== Adjazenzliste (gestreut)

Verkettete Liste mit zwei next-Pointer:

- Nächster Knoten (nach unten)
- Nächste Kante (nach rechts)

=== Adjazenzliste (hybrid)

Liste, dessen Eintrag an Index $i$ auf eine Verkettete Liste zeigt, welche die ausgehenden Kanten von $v_i$ hat.

== Traversierung

=== Breitensuche

Es werden alle Nachbarn eines Knotens besucht, bevor die Nachbarn der Nachbarn besucht werden.

#align(center, include "traversal/bfs.typ")

==== Implementierung

Es wird ein Knoten $v_0$ gewählt, an dem der Durchlauf beginnt. Dann werden alle Nachbarn einer Warteschlange angehängt. Die Warteschlange wird nach der Reihe abgearbeitet, und dabei werden jeweils alle Nachbarn eines Knotens an die Warteschlange angehängt.

```python
queue.push(v0)
while queue:
  node = queue.popleft()
  for adj in node.adjacent_nodes():
    if adj.color == white:
      queue.push(adj)
      adj.color = gray
  node.color = black
```

=== Tiefensuche

Es wird ein Pfad komplett abgearbeitet, bevor ein neuer anfängt.

#align(center, include "traversal/dfs.typ")

==== Implementierung (Iterativ)

Statt einer Warteschlange wird ein Stack verwendet. Dadurch, dass der zuletzt eingefügte Wert auch zuerst wieder abgearbeitet wird, geht dieser Durchlauf in die Tiefe, bevor er in die Breite geht.

```python
stack.push(v0)
while stack:
  node = stack.pop()
  for adj in node.adjacent_nodes():
    if adj.color != black:
      queue.append(adj)
      adj.color = gray
  node.color = black
```

Wenn wir graue Knoten nur einmal besuchen dürfen, können wir nicht immer maximal in die Tiefe gehen. Wenn wir sie aber mehrmals besuchen, ist die Laufzeit nicht optimal. Um beide Probleme zu lösen, arbeiten wir mit einer anderen Stack-Struktur.

Wir legen wir die Knoten nicht direkt auf den Stack, sondern gruppieren sie nach gemeinsamen Vorgänger. Eine Gruppe im Stack wird in jeder Iteration um eins kleiner, bis nur noch ein Element vorhanden ist. Erst dann wird die Gruppe vom Stack entfernt. Ähnliche Implementierung in @bib-dfs-iterative.

```python
stack.push(v0)
while stack:
  nodes = stack.get()
  node = nodes.pop()
  node.color = black
  if len(nodes) == 0:
    stack.pop()
  stack.append(node.adjacent_nodes())
```

== Topologische Sortierung

Eine topologische Sortierung eines Graphen ist eine Reihenfolge aller Knoten, in der für alle verbundenen Knotenpaare $A -> B$ der Ausgangsknoten $A$ zuerst vorkommt.

#align(center, include "topological_sort.typ")

Der obige Graph hat zwei topologische Sortierungen: $(A,B,C,E)$ und $(A,B,D,E)$.

Der erste Knoten, der bei einer Tiefensuche abgearbeitet wurde (alle Nachbarn wurden besucht) ist der letzte Knoten in einer gültigen topologischen Sortierung. Der zweite ist der vorletzte, und so weiter.

== Minimaler Spannbaum

Für die Konstruktion eines MSTs ist eine Eigenschaft gewichteter zusammenhängender Graphen wichtig: Wenn man die Knotenmenge $V$ in zwei schneidet ($U$ und $V \\ U$), gibt es eine oder mehrere Kanten, welche den Schnitt überqueren. Die Kante mit dem geringsten Gewicht ist für einen MST geeignet (solange der Schnitt nicht bereits durch den MST überquert wird).

Beweis: Es muss bei jedem möglichen Schnitt mindestens eine Kante geben, die $U$ mit $V \\ U$ verbindet, weil ein MST alle Knoten miteinander verbindet. Wählt man die Kante mit kleinstem Gewicht, wird das gesamte Gewicht kleiner. Cut-And-Paste Beweis in @bib-mst-proof.

Beispiel:

#align(center, include "mst/property.typ")

Wir können $(a, c)$ oder $(a, d)$ wählen, um einen MST zu konstruieren, weil dessen Gewicht minimal ist.

=== Kruskal

Alle Kanten werden aufsteigend nach Gewicht sortiert. Eine Kante nach der Anderen wird zum MST hinzugefügt, wenn sie zwei disjunkte Teilgraphen verbindet.

Beweis: Es darf keine disjunkten Teilgraphen geben, weil der Spannbaum alle Knoten verbinden muss. Es gibt keine Kante mit geringerem Gewicht, die infrage kommt, weil die Kanten sortiert abgearbeitet werden.

Implementierung: Disjunkte Teilgraphen sind Mengen an Knoten. Mengen werden durch invertierte Bäume implementiert, sodass der Repräsentant in $O(log n)$ gefunden werden kann.

=== Prim

Von einem beliebigen Startknoten aus wird immer die Kante mit dem geringsten Gewicht hinzugefügt, wenn der Zielknoten nicht bereits besucht wurde.

