= Datenstrukturen

== Hashtabelle

Eine Hashtabelle kann verwendet werden, um ein #link("https://de.wikipedia.org/wiki/Menge_(Datenstruktur)")[Set] mit konstanten Zugriffzeiten zu implementieren. Ein Element in dieser Menge ist ein _Schlüssel_. Wenn man jedem Schlüssel einen Wert zuweist, dann ist es ein #link("https://de.wikipedia.org/wiki/Zuordnungstabelle")[Dictionary] @bib-hash-map.

Unter der Haube einer Hashtabelle befindet sich ein statisches Array. Wenn man auf einen Eintrag mit einem Schlüssel $s$ zugreifen möchte, wird der entsprechende Index mit einer _Hashfunktion_ $h(s)$ berechnet.

Um es einfach zu halten, implementieren wir ein Set, dessen Schlüssel nichtnegative ganze Zahlen sind.

=== Hashfunktion

Ziel ist es, die Schlüssel möglichst gleichverteilt auf die Hashtabelle zu verteilen, um Kollisionen zu vermeiden.
auf einen
==== Divisionsmethode

Eine einfache Modulooperation stellt sicher, dass ein beliebiger Schlüssel $s in NN_0$ einem Index zwischen $0$ und $m-1$ zugeordnet wird.

$
h(s) = s mod m
$

Wenn mehrere Schlüssel sich lediglich um ein Vielfaches von $a$ unterscheiden, dann müssen sie sich $m/gcd(a, m)$ Zellen teilen @bib-hash-division-method. Daher wäre es optimal, wenn $gcd(a, m) = 1$. Das ist erfüllt, wenn $a$ und $m$ teilerfremd sind. Wenn wir für $m$ eine Primzahl wählen, dann ist es mit allen $a < m$ teilerfremd.

==== Multiplikationsmethode

Wähle einen Faktor $x in lr(]0,1])$. Der Bruchteil bestimmt die Position in der Hashtabelle.

$
h_x (s) = floor(
  ((x dot s) mod_c 1)
 dot m
)
$

=== Kollisionsbehandlung

Siehe @problem-hash-collisions. Eine schlechte Hashfunktion kann in eine Unendlichschleife geraten.

==== Lineares Probieren

$
h(s, i) = accent(h, acute)(s) + i
$

==== Quadratisches Probieren

$
h(s, i) = accent(h, acute)(s) + c_1 i + c_2 i^2
$

Vermeidet Primary Clustering @bib-hash-quadratic-probing.

==== Doppeltes Hashing

$
h(s, i) = accent(h, acute)(s) + i h_2(s)
$

== Skip-Liste

Eine Skip-Liste ist eine linear verkettete Liste, dessen Knoten nicht nur einen, sondern beliebig viele Nachfolger haben können. Die Höhe eines Knotens ist der Index des letzten Nachfolgers.

```python
@dataclass
class Node:
    key: Any
    height: int
    next: list[Node]
```

Die Höhe wird unabhängig zufällig ausgewählt. Jede Höhe ist halb so Wahrscheinlich wie die vorherige, sodass die Skipliste eine erwartete Höhe von $log n$ hat @bib-skiplist-analysis.

```python
height = np.random.geometric(p=.5)
```

Bei einer Suche werden die Ebenen von oben nach unten iteriert, und für jede Ebene wird so lange nach rechts gesprungen, bis der nächste Wert zu groß wäre @bib-skiplist-operations.