(add-cakelisp-search-directory "runtime")
(import "CHelpers.cake")
(c-import "<stdio.h>")

(var difference (const int) 3330)
(var primes (array 10000 char))

(defmacro primep (n symbol)
  (tokenize-push output (at (token-splice n) primes))
  (return true))

(defun initialize-primes ()
  ;; Initialize all to "prime"
  (each-in-array
   primes n
   (set (at n primes) (? (>= n 2) 1 0)))
  ;; Prime sieve
  (each-in-interval
   2 (array-size primes) n
   (when (> n 1)
     (var m int (+ n n))
     (while (< m (array-size primes))
       (set (at m primes) 0)
       (set m (+ m n))))))

(defun increment-digit-count (n int digits (unsigned int) &return (unsigned int))
  (var shift (const int) (* 3 n))
  (var before (const (unsigned int)) (bit-and 0x7 (bit-shift->> digits shift)))
  (var after (const (unsigned int)) (+ before 1))
  ;; Work around apparent bitwise operation precedence bug
  (var mask0 (const (unsigned int)) (bit-shift-<< 0x7 shift))
  (var mask (const (unsigned int)) (bit-not mask0))
  (var masked (const (unsigned int)) (bit-and mask digits))
  (return (bit-or masked (bit-shift-<< after shift))))

(defun extract-digits (number int &return (unsigned int))
  (var n int number)
  (var result (unsigned int) 0)
  (each-in-interval
   0 4 i
   (set result (increment-digit-count (mod n 10) result))
   (set n (/ n 10)))
  (return result))

(defun find-initial-value (&return int)
  (each-in-interval
   1000 (- 10000 (* 2 difference)) n
   ;; Skip example from problem description
   (unless (= n 1487)
     ;; Check that all 3 values are prime and are also permutations of
     ;; each other
     (var m (const int) (+ n difference))
     (var o (const int) (+ m difference))
     (when (and (primep n)
		(primep m)
		(primep o))
       (var nd (unsigned int) (extract-digits n))
       (var md (unsigned int) (extract-digits m))
       (var od (unsigned int) (extract-digits o))
       (when (and (= nd md)
		  (= md od))
	 (return n)))))
  (return -1))

(defun main (&return int)
  (initialize-primes)
  (var n int (find-initial-value))
  (printf "%04d%04d%04d\n" n (+ n difference) (+ n (* 2 difference)))
  (return 0))
