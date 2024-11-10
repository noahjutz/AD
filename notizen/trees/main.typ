= Bäume

== Binärer Suchbaum

=== Löschen

Löschen wir einen Knoten $z$ mit zwei Nachfolgern, so bleiben zwei Teilbäume übrig, welche die BST-Eigenschaft erfüllen.

#align(center, include "bst/delete_root.typ")

Jeder Knoten im rechten Teilbaum ist größer als jeder Knoten im Linken. Daraus folgt, dass die Wurzel des linken Teilbaums der linke Nachfolger aller dieser Knoten sein darf. Es gibt aber nur einen Knoten innerhalb des rechten Teilbaums, der die Wurzel des rechten Teilbaums als rechten Nachfolger übernehmen darf: das Minimum. (Umgekehrt gilt das gleiche für das _Maximum_ des _linken_ Teilbaums.)

#align(center, include "bst/minimum.typ")

Der rote Knoten ist der _Inorder-Nachfolger_ des zu löschenden Knoten. Wenn wir diesen Knoten zur neuen Wurzel machen, was passiert mit seinem rechten Nachfolger?

==== Rekursive Lösung

Wir kopieren den Wert des Inorder-Nachfolgers in die Wurzel, und löschen dann den Inorder-Nachfolger. Der Base-Case ist erreicht, wenn der zu löschende Knoten weniger als zwei Nachfolger hat. Das ist schon nach einem Selbstaufruf, weil der Inorder-Nachfolger keinen linken Nachfolger haben kann.

==== Iterative Lösung

#align(center, include "bst/new_root.typ")

Das Minimum könnte aber einen rechten Nachfolger haben. Dieser darf an die ursprüngliche Stelle des Minimums gesetzt werden.

#align(center, include "bst/last_step.typ")