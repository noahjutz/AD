= Bäume

== Binärer Suchbaum

=== Löschen

Löschen wir einen Knoten $z$ mit zwei Nachfolgern, so bleiben zwei Teilbäume übrig, welche die BST-Eigenschaft erfüllen.

#align(center, include "bst_delete_root.typ")

Jeder Knoten im rechten Teilbaum ist größer als jeder Knoten im Linken. Wir können das Minimum des rechten Baumes als neue Wurzel wählen:

#align(center, include "bst_new_root.typ")