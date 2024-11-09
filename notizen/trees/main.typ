= Bäume

== Binärer Suchbaum

=== Löschen

Löschen wir einen Knoten $z$ mit zwei Nachfolgern, so bleiben zwei Teilbäume übrig, welche die BST-Eigenschaft erfüllen.

#align(center, include "bst_delete_root.typ")

Jeder Knoten im rechten Teilbaum ist größer als jeder Knoten im Linken. Jeder Knoten aus der linken Hälfte des rechten Teilbaumes würde sich als neue Wurzel eignen. Wir wählen das Minimum:

#align(center, include "bst_new_root.typ")

Das minimum könnte aber einen rechten Nachfolger haben. Dieser darf an die ursprüngliche Stelle des Minimums gesetzt werden.

#align(center, include "bst_last_step.typ")