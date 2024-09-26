= Sortieralgorithmen

== Insertion Sort

Der Algorithmus iteriert durch alle  Elemente ab dem zweiten (rot markiert: "Schlüssel") und schiebt den Wert so lange nach vorne, bis keine kleineren Werte mehr vor ihm stehen. Zum Schluss von jeder Iteration ist die Liste bis zur jeweiligen Stelle sortiert (grün umrandet).

Das "nach vorne schieben" erfolgt in drei Schritten:

1. Merke dir den Wert des Schlüssels.
2. Iteriere von rechts nach links durch alle Elemente links des Schlüssels (blau markiert) und kopiere das Element jeweils um eine Position nach hinten, wenn es größer ist als das nächste.
3. Setze den Wert des Schlüssels ganz nach vorne.

#include "insertion_sort.typ"