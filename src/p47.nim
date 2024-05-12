import std/sequtils
import std/sets

# Upper bound found through trial and error
const max = 500000
const consecutives = 4
var numberToFactors: array[1..max, HashSet[int]]

# Prime sieve
for n in 2..max:
    if numberToFactors[n].len() == 0:
        for i in 2..max:
            let m = i * n
            if m > max:
                break
            numberToFactors[m].incl(n)

# Find consecutives
for n in 2..(max - consecutives + 1):
    let sets = numberToFactors[n..(n + consecutives - 1)]
    if all(sets, proc (a: HashSet[int]): bool = a.len() == consecutives):
        let common = foldl(sets, intersection(a, b))
        if common.len() == 0:
            echo n
            break
