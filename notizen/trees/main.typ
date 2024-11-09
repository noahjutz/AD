= Bäume

== Binärer Suchbaum

=== Löschen

Löschen wir einen Knoten $z$ mit zwei Nachfolgern, so bleiben zwei Teilbäume übrig, welche die BST-Eigenschaft erfüllen.

#align(center, include "bst/delete_root.typ")

Jeder Knoten im rechten Teilbaum ist größer als jeder Knoten im Linken. Daraus folgt, dass die Wurzel des linken Teilbaums der linke Nachfolger aller dieser Knoten sein darf. Es gibt aber nur einen Knoten innerhalb des rechten Teilbaums, der den übrigen rechten Teilbaum als rechten Nachfolger übernehmen darf: das Minimum.

#align(center, include "bst/new_root.typ")

Das minimum könnte aber einen rechten Nachfolger haben. Dieser darf an die ursprüngliche Stelle des Minimums gesetzt werden.

#align(center, include "bst/last_step.typ")