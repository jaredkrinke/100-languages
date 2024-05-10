import Data.Set (fromList, member)

-- Compute the first bunch of pentagonal numbers (2500 is an arbitrary limit)
pentagonalNumber n = (n * (3 * n - 1)) `div` 2
pentagonalNumbers = [ pentagonalNumber n | n <- [1..2500] ]
pentagonalNumberSet = fromList pentagonalNumbers

relevant =
  [
    a - b |
    a <- pentagonalNumbers,
    b <- pentagonalNumbers,
    a > b,
    (a + b) `member` pentagonalNumberSet,
    (a - b) `member` pentagonalNumberSet
  ]

-- Got lucky--there's only one match
main = print (relevant !! 0)
