import dictionary
import std

def compute_primes(max):
  // Prime sieve
  let composites = dictionary<int, bool>(max)
  for_range(2, max/2) n:
    var m = n * 2
    while m <= max:
      composites.set(m, true)
      m += n
  
  let primes = []
  for_range(2, max) i:
    if not composites.get(i, false):
      push(primes, i)
  return primes

def solve(max):
  // Compute primes
  let square_root = floor(sqrt(max))
  let cube_root = floor(pow(float(max), float(1)/float(3)))
  let fourth_root = floor(pow(float(max), float(1)/float(4)))
  let primes = compute_primes(square_root)
  def for_primes(n_max, f):
    for(primes) n:
      if n > n_max:
        return
      f(n)

  // Compute sums
  let sums = dictionary<int, bool>(max / 5)
  for_primes(square_root) a:
    for_primes(cube_root) b:
      for_primes(fourth_root) c:
        let sum = a*a + b*b*b + c*c*c*c
        if sum < max:
          sums.set(sum, true)

  // Count sums
  print sums.get_keys().length()

// Main entry point
solve(50000000)

