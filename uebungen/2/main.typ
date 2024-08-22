#import "../../config.typ": config, page
#show: config
#show: page

= Komplexität

== Registermaschine

Die Formel lässt sich algorithmisch folgendermaßen definieren:

#grid(
  columns: (auto, 1fr),
  column-gutter: 12pt,
  align: horizon,
  $
  sum_(i=1)^n i^3 <==>
  $,
  [
    #set block(width: 100%)
    ```py
    result = 0
    for i in range(n):
      result += i ** 3
    ```
  ]
)

Ein For-Loop kann mit Jumps realisiert werden, und eine Potenz lässt sich als Aneinanderreihung mehrerer MUL-Befehle umschreiben.

#grid(
  columns: (1fr, auto, 1fr),
  column-gutter: 12pt,
  [],
  [
    ```
    LDK 1
    STA 1
    INP 2
    LDA 2
    MUL 2
    MUL 2
    ADD 3
    STA 3
    LDA 2
    SUB 1
    STA 2
    JGZ 4
    OUT 3
    HLT 99
    ```
  ],
  []
)
