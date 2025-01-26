= P und NP

== Matrixkettenmultiplikation

Siehe CLRS Kapitel 14.2

== Hamiltonkreis und TSP

1. Beweis in CLRS Theorem 34.14 (Kapitel 34.5.4)
2. $"TSP" in "NPC" <=> L scripts(<=)_P "TSP" forall L$
3. $"HK" in "P" <=> "P" = "NP"$

== Partitionsproblem

1.
    2-PART: $\(underbrace(2\, 1, in I), underbrace(1\, 2, in.not I)\) -> "true"$ \
    3-PART: $\(underbrace(2, in I_1), underbrace(1\, 1, in I_2), underbrace(2, in.not (I_1 union I_2))\) -> "true"$
2.
    Man kann in polynomieller Zeit prüfen, dass
    $
    sum_(i in I_1) i = sum_(i in I_2) i = sum_(i in.not (I_1 union I_2)) i

    space square.filled
    $
3. Eingabe von 2-PART so modifizieren, dass $I_1 := I$ und $I_2 := {1,...,n}\\I$. Das Eingabetupel um ein $p_(n+1)$ erweitern, welches den Wert $sum_(i in I_2) i$ hat, sodass die Ausgabe von 3-Part nur dann wahr ist, wenn $I_1$ und $I_2$ die gleiche Summe haben. $square.filled$