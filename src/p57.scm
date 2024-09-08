(define (count-digits-internal x d)
  (if (> x 0)
    (count-digits-internal (floor (/ x 10)) (+ d 1))
	d))

(define (count-digits x)
  (count-digits-internal x 0))

(define (match r)
  (> (count-digits (numerator r))
     (count-digits (denominator r))))

(define (count-matches matches iterations a)
  (if (>= iterations 0)
    (count-matches (if (match a) (+ 1 matches) matches)
		   (- iterations 1)
		   (+ 1 (/ 1 (+ 1 a))))
    matches))

(define (solve iterations)
  (display (count-matches 0 iterations 1))
  (newline))

(solve 1000)
