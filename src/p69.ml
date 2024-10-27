# Empirically, it looks like the way to maximize n/phi(n) is just to multiply
# the sequence of primes (proof left as an exercise for the reader)

import stdlib.io.print

fun isPrime(n: int32): bool
    let m: int32 = 2
    while (m * m) <= n
        if (n % m) == 0
            ret false
        end
        m = m + 1
    end
    ret true
end

fun main: void
    let solution: int32 = 0
    let nextSolution: int32 = 1
    let i: int32 = 2
    while nextSolution < 1000000
        if isPrime(i)
            solution = nextSolution
            nextSolution = nextSolution * i;
        end
        i = i + 1
    end
    println(solution)
end
