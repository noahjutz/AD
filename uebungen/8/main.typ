= RS- und B-Bäume

== RS-Baum

=== Minimaler RS-Baum

#align(center, include "min_rbt.typ")

=== Höhe RS-Baum

Der kürzestmögliche Pfad mit gegebener Black-Height besteht nur aus schwarzen Knoten. Der längstmögliche Pfad muss nach Eigenschaft 5 genauso viele schwarze Knoten haben, wird aber mit möglichst vielen roten Knoten aufgepumpt.

Nach RS-Baum Eigenschaft 4 kann nur jeder zweite Knoten auf diesem Pfad rot sein, weil rote Knoten keine roten Nachfolger haben dürfen.

#stack(dir: ltr,
    [==== Induktionsanfang],
    h(1fr),
    $h=1$
)

Ein Knoten $v$ mit Höhe $h(v)=1$ hat links und rechts das RS-Blatt. Die Pfadlängen sind beide 1. #sym.checkmark

==== Induktionsannahme

Für alle Knoten $v$ mit $h(v) = h(v')-1$ gilt: Ein längster Pfad zu einem RS-Blatt ist höchstens doppelt so lang wie ein Kürzester.

#stack(
    dir: ltr,
    [==== Induktionsschritt],
    h(1fr),
    $h-1 -> h$
)

#underline[Fall 1]: $v$ ist rot. Der kürzeste Weg von $v'$ ist um 1 kürzer als der von $v$, weil: $v$ ist ein Nachfolger von $v'$. Wählen wir als anderen Nachfolger einen schwarzen Knoten, so können wir den ersten roten Knoten aus $v$ "überspringen".

Der längste Weg von $v'$ ist um 1 länger als der von $v$, weil ein Knoten oben angehängt wurde.

$
s/l <= 2 => (s-1)/(l+1) <= 2
$

#underline[Fall 2]: $v$ ist schwarz. Der kürzeste Weg ist gleich, der Längste wieder um 1 länger.

$
s/l <= 2 => s/(l+1) <= 2
#h(4pt) square.filled
$

== B-Baum Einfügen

== B-Baum Löschen

== B-Bäume konstruieren

