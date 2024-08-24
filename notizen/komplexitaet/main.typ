#import "/config.typ"
#show: config.config

= Komplexität

== O-Notation

Ein Landau-Symbol $M in {O, o, Omega, omega, Theta}$ ist eine Menge, welche aus Funktionen besteht. Diese Menge ist in Abhängigkeit einer Funktion $f$ definiert, welche alle $g in M$ nach oben oder unten beschränkt.

#table(columns: 3,
  $O$, $g(n) <= c dot f(n)$, table.cell(rowspan: 2)[Obere Schranke],
  $o$, $g(n) < c dot f(n)$,
  $Omega$, $g(n) >= c dot f(n)$, table.cell(rowspan: 2)[Untere Schranke],
  $omega$, $g(n) > c dot f(n)$,
  $Theta$, $g(n) in O(n) sect Omega(n)$, "Beides"
)


#grid(
  columns: 2,
  include "start_value.typ",
  include "factor.typ"
)