Object subclass: #Primes
	instanceVariableNames: 'n '
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Project-Euler'!
!Primes commentStamp: 'JK 3/23/2024 11:51' prior: 0!
Prime number functions!


!Primes methodsFor: 'initialize-release' stamp: 'JK 3/23/2024 12:28'!
initialize
	n := 1! !


!Primes methodsFor: 'accessors' stamp: 'JK 3/23/2024 12:24'!
n
	^n! !


!Primes methodsFor: 'generators' stamp: 'JK 3/23/2024 12:28'!
next
	n := n + 1.
	[(Primes isPrime: n) not] whileTrue: [n := n + 1].
	^ n! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

Primes class
	instanceVariableNames: ''!

!Primes class methodsFor: 'checkers' stamp: 'JK 3/23/2024 12:19'!
isPrime: n
	| m |
	m := 2.
	[(m * m) <= n] whileTrue: [
		((n \\ m) = 0) ifTrue: [ ^ false ].
		m := m + 1.
	].
	^true! !


!Primes class methodsFor: 'functions' stamp: 'JK 3/23/2024 12:32'!
nthPrime: n
	| p |
	p := Primes new.
	p initialize.
	(n - 1) timesRepeat: [p next.].
	^(p next)
! !
