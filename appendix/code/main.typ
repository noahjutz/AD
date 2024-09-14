= Code

== MaxTeilSum-2d <code-mts2d>

```python
import math
import numpy as np

def kadane(array):
    s = 0
    m = -math.inf
    for x in array:
        s = max(x, s + x)
        m = max(m, s)
    return m

def combinations(matrix):
    (n, _) = matrix.shape
    for i in range(n+1):
        for j in range(i):
            yield np.sum(matrix[j:i], axis=0)

def max_subarray_2d(matrix):
    return max(map(kadane, combinations(matrix)))

matrix = np.loadtxt("data.txt", dtype=int)
m = max_subarray_2d(matrix)
print(m)
```