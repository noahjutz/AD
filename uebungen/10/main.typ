= Textsuche

== Skip-Liste

=== Einfügen

1. Höhe des Heads nach oben anpassen
2. Für alle Nachfolger des Heads, welche höchstens so hoch wie der neue Knoten sind, von oben nach unten den letzten Nachfolger, der kleiner als `key` ist, auf den neuen Knoten setzen.

=== Suchen

1. Am höchsten Nachfolger des Heads anfangen
2. Falls der Nachfolger kleiner oder gleich `key` ist, ihm folgen
3. Sonst eine Ebene runter gehen
4. Wiederhole ab Schritt 2, bis `key` gefunden wurde oder $"height"=-1$.

=== Löschen

So wie einfügen, aber Nachfolger überbrücken.

== Suche ausführen

=== Naive Suche

#include "naive_search.typ"

=== Boyer-Moore