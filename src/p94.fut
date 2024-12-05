-- Triangle with sides a, b, c has area s = (a+b+c)/2, A =
-- sqrt(s*(s-a)*(s-b)*(s-c)). Given sides a, a, a+/-1, for area squared to be a
-- perfect square, note (s-a)*(s-b) with b=a is already square, so only need to
-- test s*(s-c) (with c=a+/-1) which avoids overflow, i.e. 3a^2-/+2a-1 must be
-- square

def is_square (x: i64): bool =
  let root = i64.f64(f64.sqrt(f64.i64(x)))
  in (root * root) == x

def test(a: i64, offset: i64): i64 =
  if is_square(3*a*a - 2*a*offset - 1)
  then (a + a + a + offset)
  else 0

def sum(max_perimeter: i64, offset: i64): i64 =
  let r = 2...(max_perimeter / 3)
  in reduce (+) 0 (map (\a -> test(a, offset)) r)

def main (max_perimeter: i64) =
  sum(max_perimeter, 1) + sum(max_perimeter, -1)

