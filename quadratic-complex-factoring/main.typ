Given a quadratic in the form 
$ "a"x^2 + "b"x + c $

where $a=1$ and no real solutions exist, the factored form of the quadratic is:
$ (x + b/2 + sqrt(c - (b/2)^2)i) (x + b/2 - sqrt(c - (b/2)^2)i) $

When multiplied out through the distributive property, the following table is produced:

#align(center, [
  #table(
    columns: (auto, auto, auto, auto),
    inset: 10pt,
    align: horizon,
    [], $x$, $b/2$, $-sqrt(c - (b/2)^2)i$,
    $x$, $x^2$, $(b/2)x$, $-"x"sqrt(c - (b/2)^2)i$,
    $b/2$, $(b/2)x$, $(b/2)^2$, $-(b/2)sqrt(c - (b/2)^2)i$,
    $sqrt(c - (b/2)^2)i$, $"x"sqrt(c - (b/2)^2)i$, $(b/2)sqrt(c - (b/2)^2)i$, $-(c - (b/2)^2)i^2$,
  )
])

The leftover imaginary terms cancel out:
#align(center, [
  #table(
    columns: (auto, auto, auto, auto),
    inset: 10pt,
    align: horizon,
    [], $x$, $b/2$, $-sqrt(c - (b/2)^2)i$,
    $x$, $x^2$, $(b/2)x$, $cancel(-"x"sqrt(c - (b/2)^2)i)$,
    $b/2$, $(b/2)x$, $(b/2)^2$, $cancel(-(b/2)sqrt(c - (b/2)^2)i)$,
    $sqrt(c - (b/2)^2)i$, $cancel("x"sqrt(c - (b/2)^2)i)$, $cancel((b/2)sqrt(c - (b/2)^2)i)$, $-(c - (b/2)^2)i^2$,
  )
])

Leaving the following:
$ x^2 + 2(b/2)x + (b/2)^2 - (c - (b/2)^2)i^2 $

$-(c - (b/2)^2)i^2$ simplifies to $(-1)(-1)(c - (b/2)^2)$, or $c - (b/2)^2$, which gets us the following:

$ x^2 + cancel(2)(b/cancel(2))x + cancel((b/2)^2) + c - cancel((b/2)^2) $
or:
$ x^2 + "b"x + c $
