#include "share/atspre_staload.hats"

typedef point = (int, int)

fn distanceSquared(a: point, b: point): int =
  let
    val x = a.0 - b.0
    val y = a.1 - b.1
  in
    (x * x) + (y * y)
  end

fn countTriangle(p: point, q: point, r: point): int =
  let
    val pq = distanceSquared(p, q)
    val qr = distanceSquared(q, r)
    val rp = distanceSquared(r, p)
  in
    if (pq > 0 && qr > 0 && rp > 0) && ((pq + qr = rp) || (qr + rp = pq) || (rp + pq = qr))
    then 1
    else 0
  end

fn solve (max: int): int =
  let
    fun recurse (count: int, x1: int, y1: int, x2: int, y2: int): int =
      if x1 > max then
        count
      else if y1 > max then
        recurse(count, x1 + 1, 0, 0, 0)
      else if x2 > x1 then
        recurse(count, x1, y1 + 1, 0, 0)
      else if y2 > max then
        recurse(count, x1, y1, x2 + 1, y1)
      else
        let
	  val p = (0, 0)
	  val q = (x1, y1)
	  val r = (x2, y2)
	in
	  recurse(count + countTriangle(p, q, r), x1, y1, x2, y2 + 1)
	end
  in
    recurse(0, 0, 0, 0, 0)
  end

implement
main0 () = (print(solve(50)); print("\n"))

