#import "/config.typ": theme
#import "/components/table.typ" as t
#import "/components/grid_layout.typ": grid_layout

#set table(inset: 8pt, stroke: t.inside)
#set par(justify: false)

= Cheat Sheet

#show: scale.with(50%, reflow: true)

#let seg(
    title,
    body,
    inset: 8pt,
    max-width: 200pt,
) = context {
    let segment(width: auto) = stack(
        spacing: 8pt,
        strong(title),
        rect(
            body,
            radius: 8pt,
            inset: inset,
            width: width,
            stroke: 2pt
        )
    )

    let (width, height) = measure(segment())
    if max-width != none and width > max-width {
        segment(width: max-width)
    } else {
        segment()
    }
}

#grid_layout(
    seg("Geom. Reihe", inset: 0pt)[
        #table(
            $ sum_(k=0)^n = (1-q^(n+1))/(1-q) $,
            $ sum_(k=0)^infinity = 1/(1-q) $
        )
    ],
    seg("Ableitungen", inset: 0pt)[
        #table(columns: 2,
            $ f $, $ f' $,
            $ sin(x) $, $ cos(x) $,
            $ cos(x) $, $ -sin(x) $,
            $ tan(x) $, $ 1/(cos^2 x) = 1+tan^2x $,
            $ arcsin(x) $, $ 1/(1-x^2) $,
            $ arccos(x) $, $ (-1)/(1-x^2) $,
            $ arctan(x) $, $ 1/(1+x^2) $,
            $ e^x $, $ e^x $,
            $ a^x $, $ a^x dot ln a $,
            $ ln x $, $ 1/x $
        )
    ],
    seg("Gauß-Summe")[$
        sum_(k=1)^n = (n^2+n)/2
    $],
    seg("e-Funktion")[$
        e^x = sum_(k=0)^infinity (x^k)/(k!)
    $],
    seg("Logarithmus", inset: 0pt)[
        #table(
            $ log(x y) = log x + log y $,
            $ log(1 slash x) = -log x $,
            $ log(x^r) = r dot log x $,
            $ log_a y = (log_b y)/(log_b a) $
        )
    ],
    seg("Mitternachtsformel")[$
        x_(1,2) = (-b plus.minus sqrt(b^2 - 4 a c)) /
        (2 a)
    $],
    seg("Master-Methode", inset: 0pt)[
        #table(
            columns: 2,
            $ f(x) $, $ T(n) $,
            $ o(n^(log_b a)) $, $ Theta(n^(log_b a)) $,
            $ Theta(n^(log_b a)) $, $ Theta(n^(log_b a) log n)$,
            $ omega(n^(log_b a)) \ and a f(n/b) <= c f(n) \ (c < 1) $, [$ Theta(f(n)) $]
        )
    ],
    seg("Potenzregeln", inset: 0pt)[
        #table(
            $ x^a dot x^b = x^(a+b) $,
            $ x^a slash x^b = x^(a-b) $,
            $ a^n dot b^n = (a dot b)^n $,
            $ a^n slash b^n = (a slash b)^n $,
            $ x^(m/n) = root(n, x^m) $
        )
    ],
    seg("Laufzeiten", inset: 0pt, max-width: none)[
        #stack(dir: ltr,
        table(
            columns: 4,
            align: (x, y) => if x != 0 {center} else {start},
            "", "WC", "AC", "BC",
            "MaxTeilSum1", table.cell(colspan: 3)[$n^3$],
            "MaxTeilSum2", table.cell(colspan: 3)[$n^2$],
            "MaxTeilSum3", table.cell(colspan: 3)[$n$],
            "MaxTeilSum4", table.cell(colspan: 3)[$n log n$],
            "Insertion Sort", table.cell(colspan: 2)[$n^2$], $n$,
            "Bubble Sort", table.cell(colspan: 3)[$n^2$],
            "Selection Sort", table.cell(colspan: 3)[$n^2$],
            "Quicksort", $n^2$, table.cell(colspan: 2)[$n log n$],
            "Merge Sort", table.cell(colspan: 3)[$n log n$],
            "Counting Sort", table.cell(colspan: 3)[$n+k$],
            "Map Sort", $n^2$, $n^"[a]"$, $n$,
            "BST Höhe", $n$, $log n$, $1$,
            "AVL Höhe", table.cell(colspan: 2)[$log n$], $1$,
            "B-Tree Höhe", table.cell(colspan: 2)[$ceil(t slash 2) log_ceil(t slash 2) n$], $1$,
            "Heapify", $log n$, $log n$, $1$,
            "BuildHeap", $n$, $n$, $1$,
            "Heap Sort", table.cell(colspan: 3)[$n log n$],
            "Hash-Search", $n$, table.cell(colspan: 2)[$1$],
            "Skiplist-Search", $n$, $log n$, $1$,
            "Textsuche Naiv", $n m$, table.cell(colspan: 2)[$n$],
            "Boyer-Moore", $n m$, table.cell(colspan: 2)[$n slash m$],
            "Breitensuche", table.cell(colspan: 3)[$V+E$],
            "Tiefensuche", table.cell(colspan: 3)[$V+E$],
            "Kruskal", table.cell(colspan: 3)[$E log E$],
            "Prim", table.cell(colspan: 3)[$E log V$],
            "Dijkstra", table.cell(colspan: 3)[$V log V + E log V$],
            "Bellman-Ford", table.cell(colspan: 3)[$V E$],
            "DAG APSP", table.cell(colspan: 3)[$V+E$],
            "Slow-APSP", table.cell(colspan: 3)[$V^4$],
            "Faster-APSP", table.cell(colspan: 3)[$V^3 log V$],
            "Floyd-Warshall", table.cell(colspan: 3)[$V^3$],
        ))
    ],
    seg("Stirlingformel")[
        $ n! approx sqrt(2 pi n) (n/e)^n $
    ],
    seg("Sortieralgorithmen")[
        *Quicksort* \
        Pivot $p$ wählen (z.B. erstes Element). Alle $<=p$ nach links, alle $>p$ nach rechts, dann rekursiv links und rechts.

        *Merge Sort* \
        Rekursiv halbieren, bis Eingabelänge $n=1$. Dann jeweils zwei sortierte Teilfolgen mischen, indem man von links nach rechts geht. Ein Stapel leer $=>$ anderer Stapel oben drauf. In Place möglich durch nach vorne ziehen.

        *Heap Sort* \
        Heapify: L und R sind Heaps, also rekursiv $max(L, R, C)$ nach oben ziehen. BuildHeap: Von $floor(n slash 2)-1$ zur Wurzel Heapify. Heapsort: Wurzel entfernen und ans Ende der Liste, letzten Knoten nach oben, Wurzel Heapify, repeat.

        *Selection Sort* \
        In jeder Iteration das Minimum nach vorne vertauschen
    ],
    seg("MST")[
        *Kruskal* \
        Kanten nach Gewicht sortieren, Teilgraphen ggf. verbinden (Mengenvereinigung). Mengen durch invertierte Bäume, Vereinugung: Kleinerer Baum an Repräsentanten des Größeren.

        *Prim* \
        Wähle beliebige Wurzel $v_0$. `Min-PQ` mit $v_0=0$ und $v_i=infinity$ initialisieren. In Schleife: $u=$ `Min-PQ.pop()`, alle Nachbarn $v in $ `adj[u]` ggf. decreaseKey und $pi$ anpassen.
    ],
    seg("SSSP")[
        *Dijkstra* \
        Wähle beliebige Wurzel $v_0$. `Min-PQ` mit $v_0=0$ und $v_i=infinity$ initialisieren. In Schleife: $u =$ `Min-PQ.pop()`, alle Nachbarn $v in$ `adj[u]` relaxieren (falls `v.d` $>$ `u.d` $+ space w(u,v)$) und decreaseKey.

        *Bellman-Ford* \
        $V$ mal alle Knoten relaxieren. Nochmal relaxieren um negativen Zyklus zu erkennen.
    ],
    seg("Textsuche", max-width: 260pt)[
        *Boyer-Moore* \
        #stack(dir: ltr, spacing: 6pt, [Eingabe:], [
            - Muster $p$ mit Länge $m$
            - Text $t$ mit Länge $n$
        ])

        Schlechtes-Zeichen Hilfstabelle mit Buchstaben $c in Sigma$.
        $
        #raw("shift[c]") = cases(
            m-i-1 "falls" c in p quad *,
            m "sonst"
        )
        $

        $
        * i = "letzter Index von" c in p
        $

        ```
        if p[i] == t[j]: i--; j--
        else: i += max(shift[t[i]], m-j); j = m-1
        ```
    ],
    seg("APSP")[
        *Slow-APSP* \
        $D^((1)) = W, Pi^((1)) = i "falls" w_(i j) < infinity "mit" i != j$. \
        Für alle _Pfadlängen_ 2 bis $|V|-1$:
        - $d_(i j)^' = min(d_(i j)^', d_(i k) + w_(k j)) space forall "Knoten" k$ \
        - $pi_(i j)^' = k$ falls relaxiert wurde. \

        *Faster-APSP* \
        Verwende $D$ statt $W$. \
        $d_(i j)^' = min(d_(i j)^', d_(i k) + d_(k j))$

        *Floyd-Warshall* \
        $D^((0))=W, Pi^((0))=i "falls" w_(i j) < infinity "mit" i != j$. \
        Für alle _Knoten_ 1 bis $n$:
        - $d_(i j)^' = min(d_(i j), d_(i k) + d_(k j))$
        - $pi_(i j)^' = pi_(k j)$ falls relaxiert wurde.
    ],
    seg("Graphen")[
        *Breitensuche* \
        Queue $Q=(v_0)$, in jedem Schritt popleft und adjazente Knoten, welche noch nicht hinzugefügt oder besucht wurden, hinzufügen.

        *Tiefensuche* \
        Rekursiv alle Nachbarn besuchen, oder iterativ Stack umgekehrt füllen.

        *Topologische Sortierung* \
        Tiefensuche, dabei besuchte Knoten an den Anfang einer Liste hinzufügen.
    ],
    seg("Bäume")[
        *BST Löschen* \
        Inorder-NF nach oben, ggf. rechten NF des IO-NF nachschieben

        *AVL Balancieren* \
        $"BF" = 2 => "right-heavy" => "left rotate"$ \
            #h(12pt) $->$ Inner Tree: `r.l` \
        $"BF" = -2 => "left-heavy" => "right rotate"$ \
            #h(12pt) $->$ Inner Tree: `l.r` \
        
        Inner-Heavy $=>$ Davor andere richtung beim inner Tree

        *B-Baum Overflow* (Einfügen) \
        Mittleren Wert nach oben, rekursiv splitten.

        *B-Baum Underflow* (Löschen) \
        Balancieren: Linken/Rechten Nachbarn nach oben, Parent nach unten. Vereinigen: Linken/Rechten Nachbarn verbinden, dazwischen Parent.
    ],
)