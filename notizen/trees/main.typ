= Bäume

== Binärer Suchbaum

=== Löschen (iterativ)

Löschen wir einen Knoten $z$ mit zwei Nachfolgern, so bleiben zwei Teilbäume übrig, welche die BST-Eigenschaft erfüllen.

#align(center, include "bst/delete_root.typ")

Jeder Knoten im rechten Teilbaum ist größer als jeder Knoten im Linken. Daraus folgt, dass die Wurzel des linken Teilbaums der linke Nachfolger aller dieser Knoten sein darf. Es gibt aber nur einen Knoten innerhalb des rechten Teilbaums, der die Wurzel des rechten Teilbaums als rechten Nachfolger übernehmen darf: das Minimum. (Umgekehrt gilt das gleiche für das _Maximum_ des _linken_ Teilbaums.)

#align(center, include "bst/minimum.typ")

Das Minimum des rechten Teilbaums ist der _Inorder-Nachfolger_ des zu löschenden Knoten. Wir wählen diesen als neue Wurzel.

#align(center, include "bst/new_root.typ")

Falls der Inorder-Nachfolger einen rechten Nachfolger hatte, wird dieser nach oben geschoben.

#align(center, include "bst/last_step.typ")

=== Löschen (rekursiv)

Wir kopieren den Wert des Inorder-Nachfolgers in die Wurzel, und löschen dann rekursiv den Inorder-Nachfolger. Der Base-Case ist erreicht, wenn der zu löschende Knoten weniger als zwei Nachfolger hat. Das ist schon nach einem Selbstaufruf, weil der Inorder-Nachfolger keinen linken Nachfolger haben kann.

== AVL-Baum

Ein AVL-Baum ist ein selbstbalancierender BST. In einem AVL-Baum gilt für jeden Knoten, dass die Höhe des linken und rechten Teilbaums sich um maximal 1 unterscheiden @bib-avl-video @bib-avl-vis.

$
"BF"(x) = h(B_R) - h(B_L), #h(8pt)
abs("BF"(x)) <= 1
$

=== Linksrotation

#align(center, include "avl/ll_rotation.typ")

Die Höhen verändern sich möglicherweise.

#include "avl/ll_table.typ"

=== Rechtsrotation

#align(center, include "avl/rr_rotation.typ")

#include "avl/rr_table.typ"

=== Löschen

Wenn wir die BST-Implementierung zum Löschen verwenden, erfüllt der resultierende Baum möglicherweise nicht mehr die AVL-Eigenschaft @bib-avl-delete. Um sie wieder herzustellen, laufen wir vom Vorgänger des Vorgänger des gelöschten Knoten bis zur Wurzel und rebalancieren jegliche Knoten, die unbalanciert sind.

#align(center, include "avl/delete.typ")

== RS-Baum

Ein Rot-Schwarz Baum (RBT) ist ein selbstbalancierender BST. Der kürzestmögliche Pfad in einem RBT besteht nur aus schwarzen Knoten, und der längstmögliche aus abwechselnd roten und schwarzen Knoten. Daher ist die höhe maximal

$
h <= 2 log_2(n)
$

== B-Baum

Dadurch, dass jeder Knoten mindestens $ceil(t slash 2) >= 2$ Nachfolger hat, ist die Höhe garantiert logarithmisch.

$
h <= log_ceil(t slash 2)(n)
$

=== Einfügen

#include "b_tree/insert.typ"

=== Löschen

Dieses Flowchart beschreibt das Löschen eines Knotens und die Wiederherstellung der B-Baum-Eigenschaften @bib-btree-delete.

#include "b_tree/delete.typ"

=== Unterschiede zu CLRS

- In der Vorlesung hat ein $t$-ärer B-Baum maximal $t$ Nachfolger, in CLRS maximal $2t$.
- In der Implementierung von CLRS werden die B-Baum Eigenschaften beim Einfügen und Löschen nicht gebrochen und wiederhergestellt, sondern präventiv vorgebeugt.