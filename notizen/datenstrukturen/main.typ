= Datenstrukturen

== Hashtabelle

Eine Hashtabelle kann verwendet werden, um ein #link("https://de.wikipedia.org/wiki/Menge_(Datenstruktur)")[Set] mit konstanten Zugriffzeiten zu implementieren. Ein Element in dieser Menge ist ein _Schlüssel_. Wenn man jedem Schlüssel einen Wert zuweist, dann ist es ein #link("https://de.wikipedia.org/wiki/Zuordnungstabelle")[Dictionary] @bib-hash-map.

Unter der Haube einer Hashtabelle befindet sich ein statisches Array. Wenn man auf einen Eintrag mit einem Schlüssel $s$ zugreifen möchte, wird mit einer Hashfunktion $h(s)$ der Index des Elements in berechnet.

Um es einfach zu halten, implementieren wir ein Set, dessen Schlüssel Integer-Werte sind.

=== Hashfunktion

Ziel ist es, die Schlüssel möglichst gleichverteilt auf die Hashtabelle zu verteilen, um Kollisionen zu vermeiden.

==== Divisionsmethode

$
h(s) = s mod m
$

==== Multiplikationsmethode

$
h_x (s) = underbrace(
  ((x dot s) mod 1),
  in lr(\] 0,1 \])
) dot m
$

=== Quadratisches Probieren

@bib-hash-quadratic-probing