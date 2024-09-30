#import "/components/admonition.typ": admonition

= Sortieralgorithmen

== Insertion Sort <insertion-sort>

Der Algorithmus iteriert durch alle  Elemente ab dem zweiten (rot markiert) und schiebt den Wert so lange nach vorne, bis keine kleineren Werte mehr vor ihm stehen.

```python
for j in range(1, n):
  # a[j] nach vorne schieben
```

Zum Schluss von jeder Iteration ist die Liste bis zur jeweiligen Stelle sortiert (grün markiert).

Das "nach vorne schieben" erfolgt in drei Schritten:

1. Merke dir den Wert des Schlüssels (graue Spalte).
  ```python
  key = a[j]
  ```
2. Iteriere von rechts nach links durch alle Elemente links des Schlüssels (blau markiert) und kopiere das Element jeweils um eine Position nach hinten, wenn es größer ist als das nächste.
  ```python
  i = j-1
  while (i >= 0 and a[i] > key):
    a[i+1] = a[i]
    i -= 1
  ```
3. Setze den Wert des Schlüssels ganz nach vorne.
  ```python
  a[i+1] = key
  ```

=== Beispiel

Im folgenden Beispiel ist Insertion Sort für die Eingabeliste $(3, 2, 1)$ illustriert. Der Zähler (rot markiert) startet bei $i=1$ und endet bei $i=n-1=2$.

#import "insertion_sort.typ": insertion_sort
#insertion_sort(3, 2, 1)

Längeres Beispiel: @ex-insertion-sort

=== Laufzeit

Für jedes Element `a[j]` werden zwischen $0$ und  $j$ Verschiebeoperationen durchgeführt, um `a[j]` richtig in `a[:j+1]` einzusortieren.

#grid(columns: (1fr,)*2,
  $
  T^"WC" (n) = Theta(n^2) #h(16pt)
  $,$
  T^"BC" (n) = Theta(n)
  $
)

Im Schnitt benötigt es $j slash 2$ Verschiebeoperationen, damit ist die AC-Laufzeit

$
T^"AC" (n) = sum_(j=1)^(n-1) j/2 = Theta(n^2)
$

=== Korrektheit

Behauptung: Nach jeden $j$-ten Schleifendurchlauf ist `a[:j+1]` sortiert.

==== Induktionsanfang (j = 1)

Ein Durchlauf der Schleife mit Zähler $j$ sieht so aus:

```python
key = a[j]
i = j-1
while i >= 0 and a[i] > key:
  a[i+1] = a[i]
  i -= 1
a[i+1] = key
```

Setzen wir den festen Wert $j=1$ in den Code ein, dann wird die while-Schleife höchstens einmal betreten. Vereinfacht kann man das als if-else-Block darstellen:

```python
key = a[1]
if a[0] > a[1]:
  a[1] = a[0]
  a[0] = key
else:
  a[1] = key
```

Dieser Code vertauscht `a[0]` und `a[1]`, wenn `a[0]` größer ist. Das heißt, dass `a[0:2]` sortiert sind. #sym.checkmark

#include "insertion_sort_induction_0.typ"

==== Induktionsschritt (j - 1 #sym.arrow j)

Wir gehen davon aus, dass `a[:j]` nach Iteration $j-1$ sortiert ist. Wenn wir zeigen können, dass nach der nächsten Iteration $j$ das Subarray `a[:j+1]` sortiert ist, ist der Induktionsschritt erfüllt.

#admonition(
  [Verschachtelte Induktion]
)[
  Die innere Schleife startet mit $i=j-1$ und läuft ggf. nach unten bis $i=0$. Behauptung: Nach jedem $i$-ten Schleifendurchlauf sind `a[:i]` und `a[i+1:j+1]` sortiert.

  ==== Induktionsanfang (i = j - 1)

  Setzen wir $i = j - 1$ in die While-Schleife ein, erhalten wir diese äquivalente if-Anweisung:

  ```python
  if a[j-1] > a[j]:
    a[j] = a[j-1]
  ```

  Weil wir annehmen, dass `a[:j]` sortiert ist, ist `a[j-1]` der größte Wert in `a[:j]`. Nach der Ausführung des obigen Codes ist `a[j+1]` der größte Wert aus `a[:j+1]`. Damit ist `a[j:j+1]` sortiert. `a[:i]` bleibt unberührt. #sym.checkmark

  #include "insertion_sort_induction_1.typ"

  ==== Induktionsschritt (i + 1 #sym.arrow i)

  Falls $i+1=0$ gibt es keine Nummern vor `a[i+1]`, welche einsortiert werden müssen. Sonst wird in Durchlauf $i$ folgender Code ausgeführt:

  ```python
  if a[i] > key:
    a[i+1] = a[i]
  ```

  Nach Induktionsvoraussetzung gilt:
  
  - `a[:i+1]` ist sortiert
  - `a[i+2:j+1]` ist sortiert

  Nach Ausführung des obigen Codes wird der letzte und damit größte Wert aus der linken sortierten Teilliste `a[:i+1]` an den Anfang der rechten sortierten Teilliste `a[i+2:j+1]` gesetzt, falls er größer als `key` ist.

  #include "insertion_sort_induction_2.typ"

  Weil der kleinste Wert des rechten Teils immer noch größer sein muss als der größte des linken, ist `a[i+1:j+1]` jetzt sortiert. #sym.square.filled
]

Nach dieser inneren Schleifeninvariante sind `a[:i]` und `a[i+1:j+1`] nach Beendigung der While-Schleife mit irgend einem $i$ sortiert. Ferner gilt folgendes:

`a[i-1]` $<=$ `key` $<=$ `a[i+1]`

Nachdem also der Schlüssel an Stelle `a[i]` setzt, ist `a[:j+1]` sortiert. #sym.square.filled

== Bubble Sort <bubble-sort>

In jedem Schleifendurchlauf wird die rechte Teilliste `a[i:]` betrachtet. Von rechts nach links werden die Elemente `a[j]` und `a[j+1]` paarweise vertauscht, um den minimalen Wert nach vorne zu bringen.

```python
for i in range(n):
  for j in reversed(range(i, n-1)):
    if a[j] > a[j+1]:
      a[j], a[j+1] = a[j+1], a[j]
```

Nach jedem Schleifendurchlauf ist die linke Teilliste bis zum Schlüssel sortiert (grün markiert).

Im Beispiel wird $(4, 3, 2, 1)$ sortiert. Der Zähler (rot markiert)  wandert von $i=0$ nach $i=n-2=2$.

#import "bubble_sort.typ": bubble_sort
#bubble_sort(4, 3, 2, 1)

Längeres Beispiel: @ex-bubble-sort

== Selection Sort <selection-sort>

In jedem Schleifendurchlauf ermitteln wir das Minimum in `a[i:]` und vertauschen es mit `a[i]`.

```python
for i in range(n):
  x = a.index(min(a[i:]))
  a[i], a[x] = a[x], a[i]
```

Im Beispiel ist der Zähler rot markiert und das rechte Minimum blau.

#import "selection_sort.typ": selection_sort
#selection_sort(4, 3, 2, 1)

Längeres Beispiel: @ex-selection-sort

== Quicksort

