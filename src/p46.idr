-- Test first 10000 numbers (empirically determined)
import Data.Nat

divides : Nat -> Nat -> Bool
divides n d = (mod n d) == 0

anyDivides : Nat -> List Nat -> Bool
anyDivides n [] = False
anyDivides n (m::ms) = (divides n m) || (anyDivides n ms)

truncatedSquareRoot : Nat -> Nat
truncatedSquareRoot n = cast (sqrt (cast n))

isPrime : Nat -> Bool
isPrime 1 = False
isPrime 2 = True
isPrime n = not (anyDivides n [2..(max 2(truncatedSquareRoot n))])

isComposite : Nat -> Bool
isComposite n = (n > 2) && (not (isPrime n))

isOdd : Nat -> Bool
isOdd n = not (divides n 2)

-- Note: I couldn't find built-ins for these...
isElem : Nat -> List Nat -> Bool
isElem a [] = False
isElem a (b::bs) = (a == b) || (isElem a bs)

firstOrDefault : List a -> a -> a
firstOrDefault [] a = a
firstOrDefault (b::bs) a = b

-- Actually do the search
limit : Nat
limit = 10000

primes : List Nat
primes = [ p | p <- [1..limit], isPrime p ]

oddComposites : List Nat
oddComposites = [ c | c <- [1..limit], (isComposite c) && (isOdd c) ]

squares : List Nat
squares = [ b * b | b <- [1..limit], b * b <= limit ]

predicted : List Nat
predicted = [ p + (2 * s) | p <- primes, s <- squares, (p + (2 * s)) <= limit ]

contradictions : List Nat
contradictions = [ c | c <- oddComposites, not (isElem c predicted)]

main : IO ()
main = print (firstOrDefault contradictions 0)
