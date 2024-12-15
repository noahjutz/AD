#import "@preview/fletcher:0.5.3": diagram, edge

#diagram(node-stroke: 1pt, spacing: (32pt, 0pt), $
&& C edge(->, "dr") \
A edge(->) & B edge(->, "ur") edge(->, "dr") & & E \
&& D edge(->, "ur")
$)