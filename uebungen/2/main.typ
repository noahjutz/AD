#import "/config.typ"
#import "/components/code.typ": code
#show: config.config

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

#code(
  read("instructions.txt"),
  (
    (0, 1, $f(1) := 1$),
    (2, 2, $i := "input"$),
    (3, 5, $f(0) := i^3$),
    (6, 7, $r := r + f(0)$),
    (8, 10, $i := i - 1$),
    (11, 11, $"for" i > 0$),
    (12, 13, "Ausgabe")
  )
)

Der Zustand einer Registermaschine setzt sich aus Instruction-Pointer und Speicherzellen zusammen. In jeder Iteration führt er die aktuelle Anweisung aus und manipuliert dabei seinen Zustand. In Python kann man das als Iterable umsetzen.

#set block(width: 100%)
```python
cmd, arg = instructions[ip]
if cmd == "hlt":
    raise StopIteration

getattr(commands, cmd)(arg)
return [ip, mem]
```

== O-Notation

=== Aussage 1

$
17 + 22 + 45 = O(1)
$

=== Beweis 1

$
O(f(n)) &= {
  g(n) mid(|) #box(baseline: 50%)[
    $
    exists c > 0, n_0 in NN : \
    forall n >= n_0 : g(n) <= c dot f(n)
    $
  ]
} \
O(1) &= {
  g(n) mid(|) #box(baseline: 50%)[
    $
    exists c > 0, n_0 in NN : \
    forall n >= n_0 : g(n) <= c
    $
  ]
} \
&= {g(n) | exists c > 0 : g(n) <= c} \
&= RR^+ \
&in.rev 17 + 22 + 45 #h(4pt) square.filled
$

=== Aussage 2

$
5n^3 + 12n^2 + 3n + 5 = Omega(n^3)
$

=== Beweis 2

$
Omega(f(n)) &= {
  g(n) mid(|) #box(baseline: 50%)[
    $
    exists c > 0, n_0 in NN : \
    forall n >= n_0 : g(n) >= c dot f(n)
    $
  ]
} \
&supset {g(n) | g(n) >= f(n)} \
Omega(n^3) &supset {g(n) | g(n) >= n^3} \
&in.rev 5n^3 + 12n^2 + 3n + 5
$

Weil $n lt.not 0$. $square.filled$

