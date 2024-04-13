# Project Euler problem 27 in RetroForth (Unu format)

## Prime testing
~~~
(n,m--b)
:divides? /mod drop #0 eq? ;

(a,b--a,b,a,b)
:2dup over over ;

(a,b,c--)
:drop3 drop drop drop ;

(n--)
:show n:put nl ;

(n--b)
:pprime?
	dup n:sqrt #2
	repeat
		2dup lt? [ drop3 TRUE ] if;
		rot 2dup swap divides? [ drop3 FALSE ] if;
		rot rot
		n:inc
	again ;

(n--b)
:prime? dup #0 gt? [ pprime? ] [ drop FALSE ] choose ;
~~~

## Computing consecutive primes of: n^2 + An + B

~~~
'A var
'B var

(n--m)
:compute @B swap dup @A * swap dup * + + ; (n^2+An+B)

(--n)
:consecutive-primes #0 repeat dup compute prime? 0; drop n:inc again ;
~~~

## Finding the solution

~~~
'BestA var
'BestB var
'BestCount var #0 !BestCount
'Limit var #1000 !Limit

@Limit n:negate #1 + !A
@Limit #2 * #1 - [
	@Limit n:negate !B
	@Limit #2 * #1 + [
		consecutive-primes dup @BestCount gt? [
			@A !BestA
			@B !BestB
			!BestCount
		] [
			drop
		] choose
		@B n:inc !B
	] times
	@A n:inc !A
] times

@BestA n:put sp @BestB n:put sp @BestCount n:put nl
@BestA @BestB * n:put nl
~~~
