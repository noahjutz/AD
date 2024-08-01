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

  Der größte gemeinsame Teiler von $a$ und $b$ ist der größte Wert, für den gilt:

  $
  x divides a and x divides b
  $

  Haben $a$ und $b$ mit $a>b$ einen gemeinsamen Teiler $x$, so ist die Differenz $a-b$ auch ein vielfaches von $x$.

  #include "ggt_proof.typ"

  Weil das für jeden gemeinsamen Teiler von $a$ und $b$ gilt, gilt es auch für den größten gemeinsamen Teiler $gcd(a, b)$.

  $
  gcd(a, b) = gcd(a-b, b)
  $

  Ersetzt man Schrittweise den Größeren Wert durch die Differenz, so wird das Problem immer kleiner.

  #include "euclid.typ"

  Irgendwann sind $a$ und $b$ gleich. Der größte Wert, durch den beide Teilbar sind, ist dann $x = a_n = b_n$.
  
  #colbreak()
  Dieser ggT gilt auch für $a_(n-1)$ und $b_(n-1)$, weil:

  $
  a_(n-1) &= b_n \
  b_(n-1) &= a_n+b_n
  $
]


