= Hashing

== Prioritätswarteschlange

Ich implementiere die Priority Queue mit einem Heap.

=== Insert

Der Wert wird an das Ende des Heaps angehängt, und mit `heapify_btt` nach oben getragen, um die Heap-Eigenschaft wiederherzustellen. Laufzeit: $Theta(log n)$.

=== Get

Weil es ein Min-Heap ist, ist der minimale Wert der erste Eintrag. Laufzeit: $Theta(1)$

=== Pop

Der erste Wert wird mit dem Letzten vertauscht, dann wird der letzte gelöscht. Die Heap-Eigenschaft wird mit `heapify_ttb` wiederhergestellt. Laufzeit: $Theta(log n)$

=== Dec

Der Eintrag an Stelle $i$ wird aktualisiert, und mit `heapify_btt` nach oben getragen. Weil der neue Wert kleiner ist, muss er möglicherweise weiter oben stehen. Laufzeit: $Theta(log n)$

Alle Operationen laufen In-Situ. Die Platzkomplexität ist $Theta(1)$.

== Multiplikationsmethode