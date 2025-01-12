#import "/config.typ": theme
#import "/components/table.typ" as t
#import "/components/grid_layout.typ": grid_layout

#set table(inset: 8pt, stroke: t.inside)

= Cheat Sheet

== Komplexität

#let seg(title, body, inset: 8pt) = {
    stack(
        spacing: 8pt,
        strong(title),
        rect(
            body,
            radius: 8pt,
            inset: inset,
            stroke: 2pt
        )
    )
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
    ]
)