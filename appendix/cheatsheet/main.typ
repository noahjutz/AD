#import "/config.typ": theme
#import "/components/table.typ" as t
#import "/components/grid_layout.typ": grid_layout

#set table(inset: 8pt, stroke: t.inside)
#set par(justify: false)

= Cheat Sheet

#show: scale.with(65%, reflow: true)

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
            $ omega(n^(log_b a)) $, [$ Theta(f(n)) $ (TODO)]
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
        let t = table(
            columns: 4,
            align: (x, y) => if x != 0 {center} else {start},
            "", "WC", "AC", "BC",
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
        ),
        t,
        context line(angle: 90deg, length: measure(t).height, stroke: 2pt),
        table(
            columns: 4,
            align: (x, y) => if x != 0 {center} else {start},
            "", "WC", "AC", "BC",
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
    seg("Textsuche", max-width: 250pt)[
        *Boyer-Moore* \
        #stack(dir: ltr, spacing: 6pt, [Eingabe:], [
            - Muster $p$ mit Länge $m$
            - Text $t$ mit Länge $n$
        ])

        Schlechtes-Zeichen Hilfstabelle mit Buchstaben $c in Sigma$.
        $
        #raw("shift[c]") = cases(
            "Index des ersten" c in p "falls" c in p,
            m "sonst"
        )
        $

        ```
        if p[i] == t[j]: i--; j--
        else: i += max(shift[p[i]], m-j)
        ```
    ]
)