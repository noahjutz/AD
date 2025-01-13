#import "/config.typ": theme
#import "@preview/fletcher:0.5.3"
#import fletcher: diagram, node, edge

#diagram(
  node-stroke: 1pt,
  node-shape: fletcher.shapes.ellipse,
  {
  node(name: <A>)[$a$]
  edge("-", <B>)[8]
  edge("-", <C>)[2]
  edge("-", <D>)[2]
  node((3, -1), name: <B>)[$b$]
  node((3, 0), name: <C>)[$c$]
  node((3, 1), name: <D>)[$d$]
  node(enclose: (<A>,), snap: -1, inset: 16pt, corner-radius: 100pt, stroke: theme.primary, name: <V>)
  node(enclose: (<B>, <C>, <D>), snap: -1, inset: 16pt, corner-radius: 100pt, stroke: theme.secondary, name: <U>)

  node((rel: (0, .7), to: <V>), stroke: none)[$V \\ U$]
  node((rel: (0, 2.2), to: <U>), stroke: none)[$U$]
})