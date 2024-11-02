package main

import "core:fmt"
import "core:math"

even :: proc(x: int) -> bool {
	return (x % 2) == 0;
}

isPrimitive :: proc (m: int, n: int) -> bool {
	return (math.gcd(m, n) == 1) && (even(m) || even(n))
}

euclidsFormula :: proc (m: int, n: int) -> (int, int, int) {
	return (m*m - n*n), 2*m*n, (m*m + n*n)
}

solve :: proc(max: int) -> int {
	occurrences: [dynamic]int
	defer delete(occurrences)

	resize(&occurrences, max + 1)

	for m: = 2; m < max; m += 1 {
		for n: = 1; n < m; n += 1 {
			if isPrimitive(m ,n) {
				a, b, c := euclidsFormula(m ,n)
				sum := a + b + c
				if sum > max do break
				for s := 1; s * sum <= max; s += 1 do occurrences[s*a + s*b + s*c] += 1
			}
		}
	}

	count := 0
	for i := 0; i < len(occurrences); i += 1 {
		if occurrences[i] == 1 do count += 1
	}

	return count
}

main :: proc() {
	fmt.println(solve(1_500_000))
}

