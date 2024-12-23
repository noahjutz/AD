= BST und AVL-Bäume

== BST

=== Rekursives Löschen

```python
if i < self.root.value: # i is left
  left = BST(self.root.l)
  left.delete(i)
  self.root.l = left.root
elif i > self.root.value: # i is right
  right = BST(self.root.r)
  right.delete(i)
  self.root.r = right.root
else: # i is root
  if not self.root.l:
      self.root = self.root.r
  elif not self.root.r:
      self.root = self.root.l
  else: # root has two children
      right = BST(self.root.r)
      suc = right.min()
      self.root.value = suc.value
      right.delete(suc.value)
      self.root.r = right.root
```

Laufzeit: $O(h)$, um den Knoten zu finden, und $O(h)$, um ihn zu löschen (balancierter Baum).

=== Iteratives Löschen

```python
dp, d = self.searchp(i)

if not d.r:
  if dp:
    if d.value < dp.value:
      dp.l = d.l
    else:
      dp.r = d.l
  else:
    self.root = d.l
  return

if not d.l:
  if dp:
    if d.value < dp.value:
      dp.l = d.r
    else:
      dp.r = d.r
  else:
    self.root = d.r
  return

sp, s = self.sucp(d)

if s == d.r:
  s.l = d.l
else:
  sp.l = s.r
  s.l = d.l
  s.r = d.r

if dp:
  if d.value < dp.value:
    dp.l = s
  else:
    dp.r = s
else:
  self.root = s
```

== BST Eindeutigkeit

== AVL Einfügen und Löschen

=== Einfügen

#include "avl_insert.typ"

```python
if self.root == NullNode():
  self.root = node
elif node.value < root.value:
  if root.l == NullNode():
    root.l = node
  else:
    self.insert(node, root.l)
else:
  if root.r == NullNode():
    root.r = node
  else:
    self.insert(node, root.r)

root.refresh_height()
root.rebalance()
```

=== Löschen

#include "avl_delete.typ"

```python
if value < root.value:
  self.delete(value, root.l, root)
elif value > root.value:
  self.delete(value, root.r, root)
else:
  if root.l == NullNode():
    if prev == NullNode():
      self.root = root.r
    elif value < prev.value:
      prev.l = root.r
    else:
        prev.r = root.r
  elif root.r == NullNode():
    if prev == NullNode():
      self.root = root.l
    elif value < prev.value:
      prev.l = root.l
    else:
      prev.r = root.l
  else:
    suc = root.successor().value
    root.value = suc
    self.delete(suc, root.r, root)

root.refresh_height()
root.rebalance()
```

== Minimaler AVL-Baum

$
cal(P)(h) = cases(
  1 "falls" h=0,
  2 "falls" h=1,
  2 dot (cal(P)(h-1) dot cal(P)(h-2))
)
$

$
cal(P)(5) = 4096
$