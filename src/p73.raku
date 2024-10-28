#!/usr/bin/raku

say(
  (2..12000)
  .flatmap(-> $d {
    ((floor($d/3)+1)..(ceiling($d/2)-1))
    .grep({ ($d gcd $_) == 1 }) # Must be a reduced proper fraction
  })
  .elems
)
