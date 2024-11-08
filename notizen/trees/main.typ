= Bäume

== Binärer Suchbaum

=== Löschen

Löschen wir einen Knoten $z$ mit zwei Nachfolgern, so bleiben zwei Teilbäume übrig, welche die BST-Eigenschaft erfüllen.

#align(center, include "bst_delete_root.typ")

Jeder Knoten im rechten Teilbaum ist größer als die Wurzel des linken Teilbaums. 