#import "@preview/diagraph:0.3.0": raw-render

#raw-render(
  width: 100%, 
  edges: (
    "y1": ("start": [$v := $ Inorder-NF]),
    "y4": ("start": [$v := $ Letzter Eintrag in $v_l$]),
    "y5": ("start": [$v := $ Erster Eintrag in $v_r$]),
    "y6": ("start": [$v := $ $p_r$]),
    "n6": ("start": [$v := $ $p_l$]),
  ),
  ```dot
  digraph {
    node[fontname="Noto Sans", shape=box, margin="0,.1",height="0"]
    edge[fontname="Noto Sans"]

    subgraph actions {
      node[margin=".1"]
      y1[label="Mit Inorder-Nachfolger ersetzen"]
      y2[label="Einfach löschen"]
      // y3[label="Einfach löschen"]
      y4[label="Linksverschiebung"]
      y5[label="Rechtsverschiebung"]
      y6[label="Mit rechtem Sibling vereinigen"]
      n6[label="Mit linkem Sibling vereinigen"]
    }

    subgraph choices {
      node[shape=diamond]
      c1[label="Innerer Knoten?"]
      c2[label="Wurzel?"]
      c3[label="Mehr als minimal besetzt?"]
      c4[label="Rechter Sibling mehr als minimal besetzt?"]
      c5[label="Linker Sibling mehr als minimal besetzt?"]
      c6[label="Rechter Sibling vorhanden?"]
    }
   
    start[label="",shape=circle,width=".2",style=filled]
    start -> c1
    c1 -> y1 [label="Ja"]
    c1 -> c2 [label="Nein"]
    c2 -> y2 [label="Ja"]
    c2 -> c3 [label="Nein"]
    c3 -> y2 [label="Ja"]
    c3 -> c4 [label="Nein"]
    c4 -> y4 [label="Ja"]
    c4 -> c5 [label="Nein"]
    c5 -> y5 [label="Ja"]
    c5 -> c6 [label="Nein"]
    c6 -> y6 [label="Ja"]
    c6 -> n6 [label="Nein"]

    y1 -> start

    y4 -> start
    y5 -> start

    y6 -> start
    n6 -> start

    y2 -> end
    end[label="", shape=doublecircle, width=.2,style=filled]
  }
  ```
)