#import "../../config.typ"
#show: doc => config.config(doc)

#columns(2)[ 
  = Grundlagen
  == ggT / kgV
  === ggT

  Man sagt "$x$ teilt $a$", wenn $a$ ohne Rest durch $x$ teilbar ist.

  $
  x divides a
  $

  Der größte gemeinsame Teiler von $a$ und $b$ $gcd(a, b)$ ist der größte Wert, für den gilt:

  $
  x divides a and x divides b
  $

  Haben $a$ und $b$ mit $a>b$ einen gemeinsamen Teiler $x$, so ist die Differenz $d=a-b$ auch ein vielfaches von $x$.

  #include "ggt_proof.typ"

  Die Rechnung ist also gleich, wenn statt $a$ und $b$ die Parameter $b$ und $d$ verwendet werden.

  $
  gcd(a, b) = gcd(a-b, b) = x
  $

  #include "euclid.typ"

  Irgendwann sind $a_n$ und $b_n$ gleich. Der ggT ist dann $x = a_n = b_n$. Dieses $x$ teilt auch $a_0$ und $b_0$, weil der umgekehrte Schritt lediglich ein vielfaches von $x$ zu $a$ addiert:
  
  $
  a_(n-1) = a_n + b_n \
  b_(n-1) = b_n
  $

  Dieser Algorithmus zur berechnung des ggT ist der *einfache euklidische Algorithmus*. Der Pseudo-Code ist wie folgt:

  ```py
  def gcd(a, b):
    if a == b: return a
    a_next = max(b, a - b)
    b_next = min(b, a - b)
    gcd(a_next, b_next)
  ```
]


