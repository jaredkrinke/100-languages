-- Algorithm: Try all descending sequences of digits in both possible
-- three-operator parse trees using all operators. Note that division could
-- require rational arithmetic, so do that.

-- Rational arithmetic implementation and operations
type Ratio:
	num int
	denom int

func add(a Ratio, b Ratio) Ratio:
	return Ratio{ num = (a.num*b.denom + b.num*a.denom), denom = a.denom*b.denom }

func multiply(a Ratio, b Ratio) Ratio:
	return Ratio{ num = a.num*b.num, denom = a.denom*b.denom }

func subtract(a Ratio, b Ratio) Ratio:
	return add(a, Ratio{ num = -b.num, denom = b.denom })

func divide(a Ratio, b Ratio) Ratio:
	return multiply(a, Ratio{ num = b.denom, denom = b.num })

func intToRatio(n int) Ratio:
	return Ratio{ num = n, denom = 1 }

func ratioToInt(r Ratio) int:
	-- Note: only interested in positive integers
	if (r.denom > 0) and ((r.num % r.denom) == 0):
		return r.num / r.denom
	return 0

-- Functional helpers
func copied(l List[int]) List[int]:
	var result = List[int]{}
	result.appendAll(l)
	return result

func removed(l List[int], i int) List[int]:
	var result = copied(l)
	result.remove(i)
	return result

func appended(l List[int], n int) List[int]:
	var result = copied(l)
	result.append(n)
	return result

func enumeratePermutations(results List[List[int]], output List[int], input List[int]):
	if input.len() <= 0:
		results.append(output)
	else:
		for input -> n, i:
			enumeratePermutations(results, appended(output, n), removed(input, i))

func permutations(l List[int]) List[List[int]]:
	var results = List[List[int]]{}
	enumeratePermutations(results, List[int]{}, l)
	return results

-- Operations and permutations (of indices)
var ops = { add, multiply, subtract, divide }
var perms = permutations(List[int]{0, 1, 2, 3})

-- Count consecutive solutions for a given set of digits
-- Note: Must use a lambda in order to capture globals...
var countConsecutiveSolutions = func(a int, b int, c int, d int) int:
	var digits = List[Ratio]{intToRatio(a), intToRatio(b), intToRatio(c), intToRatio(d)}
	var seen = Map{}
	-- For each permutation of digits
	for perms -> perm:
		-- Cyber bug: Why is int() needed here?
		var n = digits[int(perm[0])]
		var m = digits[int(perm[1])]
		var o = digits[int(perm[2])]
		var p = digits[int(perm[3])]
		-- For each set of operators
		for ops -> op1, o1:
			for ops -> op2, o2:
				for ops -> op3, o3:
					-- For each parse tree
					for List[Ratio]{op2(op1(n, m), op3(o, p)), op3(op2(op1(n, m), o), p)} -> r:
						var v = ratioToInt(r)
						if v > 0:
							seen[v] = true
	-- Finally, count consecutive results
	var count = 0
	var i = 1
	while seen.contains(i):
		count += 1
		i += 1
	return count

-- Try all sets of digits
var best = 0
var solution = "????"
for 1..10 -> a:
	for (a+1)..10 -> b:
		for (b+1)..10 -> c:
			for (c+1)..10 -> d:
				var count = countConsecutiveSolutions(a, b, c, d)
				if count > best:
					best = count
					solution = "$(a)$(b)$(c)$(d)"

print solution

