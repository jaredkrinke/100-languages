( Project Euler problem 5, tested on Gforth 0.7.3 )

( n -- n ; Return first non-divisible natural number, or 20 if all <= 20 divisible )
: evendiv 1 swap 21 2 do dup i mod 0= if swap drop i swap else leave then loop drop ;

( n -- n ; Find first multiple that is evenly divisible by first 20 natural numbers )
: findmult 1000 1 do dup i * evendiv 20 = if i * leave then loop ;

( Only check multiples of product of primes <= 20; print result )
2 3 5 7 11 13 17 19 * * * * * * * findmult .
