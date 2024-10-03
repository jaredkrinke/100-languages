-- Project Euler problem 60
-- Incrementally add primes to prime pair sets

-- Memoized prime test
isPrimeInternal = (n) ->
  for m = 2, math.floor math.sqrt n
    if n % m == 0
      return false
  return true

primes = {}
isPrime = (n) ->
  result = primes[n]
  if result == nil
    result = isPrimeInternal n
    primes[n] = result
  result

-- Prime pair test
concatenatePair = (n, m) ->
  (math.tointeger n..m), (math.tointeger m..n)

isPrimePair = (n, m) ->
  a, b = concatenatePair n, m
  (isPrime a) and (isPrime b)

-- Utility functions
sum = (list) ->
  result = 0
  for n in *list
    result += n
  result

append = (list, item) ->
  list[#list + 1] = item

concatenate = (a, b) ->
  result = [item for item in *a]
  for item in *b
    append result, item
  result

-- Entry point
result = nil

-- Track biggest set found thus far
minSetSize = 5
bestSetSize = 0
sets = {}

-- Start with 3 since primes can't end in 2
n = 3

while result == nil
  for numbers in *sets
    -- Check if adding n to this set is a new valid set
    valid = true
    for m in *numbers
      if not isPrimePair m, n
        valid = false
        break
    if valid
      -- New valid set; add to the list of sets and check if it's the best so far
      newSet = concatenate numbers, {n}
      append sets, newSet
      if #newSet > bestSetSize
        bestSetSize = #newSet
        print "Found set of size #{bestSetSize} with sum #{sum newSet} (n=#{n}, #sets=#{#sets})"
        if bestSetSize >= minSetSize
          -- Done!
          result = sum newSet
  -- Regardless, add this single number as a new set and find the next prime
  append sets, {n}
  n += 1
  while not isPrime n
    n += 1

print "Solution: #{result}"
