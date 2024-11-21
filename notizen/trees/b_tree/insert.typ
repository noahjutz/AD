#import "@preview/diagraph:0.3.0": raw-render

#raw-render(
  width: 100%,
  labels: (
    is_empty: [$v$ = null],
    newroot: [root $:=$ Node(k)],
    is_leaf: [$v$ ist Blatt?],
    is_correct_child: [$k < v.x_i$ \ oder $i > v.n$],
    is_correct_key: [$k < v.x_i$ \ oder $i > v.v$],
    is_overflow: [Overflow?],
    split: [Splitten],
    is_root: [$v$ ist Wurzel?]
  ),
  edges: (
    start: (is_empty: [$v :=$ root]),
    is_correct_child: (
      is_correct_child: [nein \ / $i := i+1$],
      is_leaf: [ja \ / $v := v.c_i$]
    ),
    is_correct_key: (
      is_correct_key: [nein \ / $i := i + 1$],
      is_overflow: [ja \ / `v.insert(i, k)`]
    ),
    split: (
      is_root: [$v :=$ Vorgänger]
    )
  ),
  ```dot
  digraph {
    graph [concentrate=true,splines="curve"]
    node [fontname="Noto Sans", shape=box, margin=.075,height=0,width=0,color=lightgray]
    edge [fontname="Noto Sans", arrowhead="vee"]

    subgraph {
      node [shape=diamond,margin="0,.05"]
      is_empty
      is_leaf
      is_correct_child
      is_correct_key
      is_overflow
      is_root
    }

    start[shape=circle,label="",width=.1,style=filled,fillcolor=black]
    end[shape=doublecircle,label="",width=.1,style=filled,fillcolor=black]
    start:s -> is_empty:n
    is_empty:w -> newroot:n [label="ja"]
    is_empty:e -> is_leaf:n [label="nein"]

    is_leaf:e -> is_correct_child:n [label="nein"]
    is_correct_child:w -> is_leaf [label="ja"]
    is_correct_child:e -> is_correct_child:e [label="nein"]

    is_leaf:w -> is_correct_key:n [label="ja"]
    is_correct_key:e -> is_correct_key:e [label="nein"]
    is_correct_key:w -> is_overflow:n [label="ja"]

    is_overflow:e -> end [label="nein"]
    is_overflow:w -> split:n [label="ja"]
    split:s -> is_root:n
    is_root:e -> is_overflow:s [label="nein"]
    is_root:w -> end [label="ja"]
  }
  ```
)