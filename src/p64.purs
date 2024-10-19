module Main where

import Prelude
import Control.Alternative (guard)
import Data.Array ((..))
import Data.Foldable (length)
import Data.Int (odd)
import Data.Set (fromFoldable, insert, member)
import Effect.Console (log)

-- Track form: a + (sqrt(n) + c) / b - a
type Term = { a :: Int, b :: Int, c :: Int }

-- Helpers
lastPositiveMatch f = recurse 0
  where recurse i = if f (i + 1) then recurse (i + 1) else i

floorOfSqrt n = lastPositiveMatch \i -> (i * i) <= n

-- Compute first term
first n = { a: floorOfSqrt n, b: 1, c: 0 } :: Term

-- Compute next term
next n a0 term =
  let
    c = term.a * term.b - term.c
    b = (n - c * c) / term.b
    a = ((a0 + c) / b)
  in
    { a: a, b: b, c: c } :: Term

-- Compute period
periodInternal n a0 terms previousTerm count =
 let
   nextTerm = next n a0 previousTerm
 in
   if nextTerm `member` terms
     then count
     else (periodInternal n a0 (nextTerm `insert` terms) nextTerm (count + 1))

period :: Int -> Int
period n =
  let
    t0 = first n
  in
    periodInternal n t0.a (fromFoldable [t0]) t0 0

-- Helpers
oddPeriod n = odd (period n)
perfectSquare n =
  let
    root = floorOfSqrt n
  in
    n == root * root

-- Entry point
solve :: Int -> Int
solve max = length (
  do
    n <- 1 .. max
    guard $ ((not (perfectSquare n) ) && (oddPeriod n))
)

main = log (show (solve 10000))
