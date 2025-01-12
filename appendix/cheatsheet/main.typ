#import "/config.typ": theme
#import "/components/table.typ" as t

= Cheat Sheet

== Komplexität

#show parbreak: none

#let seg(title, body, inset: 8pt) = {
    box(
        inset: (right: 8pt),
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
    )
}

#seg("Geom. Reihe")[$
    sum_(k=0)^n = (1-q^(n+1))/(1-q)
$]

#seg("Unendl. Geom. Reihe")[$
    sum_(k=0)^infinity = 1/(1-q)
$]

#seg("Ableitungen", inset: 0pt)[
    #table(columns: 2,
        inset: 8pt,
        stroke: t.inside.with(stroke_style: theme.fg_medium),
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
]