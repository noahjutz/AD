= Rekursion

== MaxTeilSum-2d

Gesucht ist die Teilmatrix, dessen Komponenten aufsummiert maximal sind.

=== Naiver Algorithmus

Man könnte durch alle Teilmatrizen iterieren und die Summen vergleichen. Laufzeit: $Theta(n^4)$.

```python
for i1 in range(n+1):
  for i2 in range(i1):
    for j1 in range(n+1):
      for j2 in range(j1):
        matrix[i2:i1, j2:j1].sum()
```

=== Mit Kadane

Der Algorithmus von Kanade findet die maximale Teilsumme eines Arrays in linearer Laufzeit. Die For-Loops mit Zähler $i_1$ und $i_2$ iterieren durch alle möglichen Zeilenkombinationen. Summieren wir die Zeilen von $i_1$ bis $i_2$ spaltenweise auf, erhalten wir ein Array, das der Algorithmus von Kanade verarbeiten kann.

```python
for i1 in range(n+1):
  for i2 in range(i1):
    yield np.sum(mtx[i2:i1], axis=0)
```

Die Laufzeit ist nur noch $Theta(n^3)$, weil es $n^2$ Zeilenkombinationen gibt, welche jeweils mit dem linearen Algorithmus von Kadane verarbeitet werden. Gesamtes Programm: @code-mts2d

== Rekursionsgleichungen

