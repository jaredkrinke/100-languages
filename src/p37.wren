class Solution {
    static isPrime(n) {
        var i = 2
        var max = n.sqrt.floor
        while (i <= max) {
            if ((n % i) == 0) {
                return false
            }
            i = i + 1
        }
        return true
    }

    static yieldLeftTruncatables(previous, power) {
        var list = []
        for (i in 1..9) {
            for (p in previous) {
                var n = (i * power) + p
                if (Solution.isPrime(n)) {
                    list.add(n)
                    Fiber.yield(n)
                }
            }
        }

        Solution.yieldLeftTruncatables(list, power * 10)
    }

    static yieldRightTruncatables(previous) {
        var list = []
        for (p in previous) {
            for (i in 1..9) {
                var n = (p * 10) + i
                if (Solution.isPrime(n)) {
                    list.add(n)
                    Fiber.yield(n)
                }
            }
        }

        Solution.yieldRightTruncatables(list)
    }

    static yieldMerged(a, b) {
        var x = a.call()
        var y = b.call()
        while (true) {
            var advanceA = (x <= y)
            var advanceB = (y <= x)

            if (x == y) {
                Fiber.yield(x)
            }

            x = advanceA ? a.call() : x
            y = advanceB ? b.call() : y
        }
    }
    
    static solve() {
        // Recursively build up truncatable primes
        var singleDigitPrimes = (2..9).where {|n| Solution.isPrime(n)}
        var leftTruncatables = Fiber.new { Solution.yieldLeftTruncatables(singleDigitPrimes, 10) }
        var rightTruncatables = Fiber.new { Solution.yieldRightTruncatables(singleDigitPrimes) }

        // Merge the two (ordered) lists
        var merged = Fiber.new { Solution.yieldMerged(leftTruncatables, rightTruncatables) }

        // Problem description says there are 11 elements in the intersection of the two sets
        var sum = 0
        for (i in 1..11) {
            sum = sum + merged.call()
        }

        System.print(sum)
    }
}

Solution.solve()
