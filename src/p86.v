import math

fn min(a f32, b f32) f32 {
	if a < b {
		return a
	}
	return b
}

fn min3(a f32, b f32, c f32) f32 {
	return min(a, min(b, c))
}

fn is_square(x f32) bool {
	f := math.floor(math.sqrt(x))
	return (f * f) == x
}

fn shortest_path_is_integer(a int, b int, c int) bool {
	m := min3(a*a + (b+c)*(b+c), b*b + (a+c)*(a+c), c*c + (a+b)*(a+b))
	return is_square(m)
}

limit := 1_000_000

mut i := 0
mut count := 0
for count < limit {
	i++

	a := i
	mut b := i
	for b > 0 {
		mut c := b
		for c > 0 {
			if shortest_path_is_integer(a, b, c) {
				count++
			}
			c--
		}
		b--
	}
}

println(i)

