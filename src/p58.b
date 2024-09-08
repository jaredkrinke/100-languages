get "LIBHDR"

let prime(n) = valof $(
	let i = 2 and i2 = 4
	until (i2 > n) | ((n rem i) = 0) do $(
		i := i + 1
		i2 := i * i
	$)
	resultis (n rem i) ~= 0
$)

let start() be $(
	let gap = 2
		and i = 1
		and matches = 0
		and total = 0

	until (total > 0) & (((100 * matches) / total) < 10) do $(
		for j = 1 to 4 do $(
			i := i + gap
			if prime(i) do matches := matches + 1
		$)
		total := 2 * (gap + 1) - 1
		gap := gap + 2
	$)

	writef("Answer: %n*n", gap - 1)
$)

