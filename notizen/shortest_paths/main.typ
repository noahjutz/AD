= Kürzeste Wege

== SSSP

=== Breitensuche

Findet die kürzesten Wege bei ungewichteten Graphen.

=== Bellman-Ford

Funktioniert auch bei negativen Kantengewichten. Es wird $|V|$ mal jede Kante relaxiert. Die Reihenfolge der Kanten ist für die Korrektheit egal. Falls bei der letzten Iteration Kanten relaxiert werden, gibt es einen kürzesten Weg, der länger als $|V|-1$ ist. Es gibt also einen Negativzyklus @bib-bellman-ford.

=== Dijkstra

Wie Prim, aber es wird nicht die leichteste Kante gewählt, sondern eine, welche den Pfad minimiert.

$
underbrace(A -->^5 B -->^5 C, "MST") >
underbrace(A -->^9 C, "SSSP")
$

=== DAG SSSP

SSSPs Zyklenfreier Graphen können in Linearzeit $Theta(E+V)$ berechnet werden, weil die Knoten, die nach einem bereits abgearbeiteten Knoten kommen, nicht mehr zurück zu diesem Knoten führen (das wäre ein Zyklus), und deshalb nur einmal besucht werden müssen. Implementierung in @tut-dag-sssp.

== APSP

=== Dijkstra und Bellman-Ford

Man kann einen SSSP-Algorithmus mit allen möglichen Startknoten ausführen, um APSP zu erhalten.

```python
parents = []
weights = []
for v in vertices:
  p, w = dijkstra_sssp(origin=v)
  parents.append(p)
  weights.append(w)
```

=== Slow APSP

=== Übersicht der Laufzeiten

#table(columns: (.5fr, .5fr, 1fr),
    table.cell(colspan: 2, "Algorithmus"), "Laufzeit",
    table.cell(rowspan: 3, "Dijkstra"),
    "SSSP", $V log V + E log V$,
    "APSP", $V dot (V log V + E log V)$,
    "APSP Dicht", $V^2 log V$,
    table.cell(rowspan: 3, "Bellman-Ford"),
    "SSSP", $V dot E$,
    "APSP", $V dot (V dot E)$,
    "APSP Dicht", $V^4$,
    "Slow APSP",
    "(TODO)", $V^4$,
    "Faster APSP",
    "(TODO)", $V^3 log V$
)