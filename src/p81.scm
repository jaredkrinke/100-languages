; Project Euler problem 81 using Pre-Scheme (Scheme-to-C compiler from Scheme 48)

; There must be some better way to get a hold of the "unit" (void?) type
(define nil (let ((x 0)) (set! x 0)))

; Note: Need to supply a default, in case of I/O error
(define-syntax with-open-file
  (syntax-rules ()
    ((with-open-file (file filename default) body ...)
     (receive (file status) (open-input-file filename)
       ; Oddly, (enum errors no-errors) doesn't work (NO_ERRORS isn't defined in prescheme.h!)
       (if (eq? status 0)
	 (let ((result (begin body ...)))
	   (close-input-port file)
	   result)
	 default)))))

(define-syntax for-range
  (syntax-rules ()
    ((for-range (index initial limit) body ...)
     (let ((l limit))
       (do ((index initial (+ index 1))) ((>= index l))
	 body ...)))))

(define (skip-char file)
  (read-char file)
  nil) ; Annoying that a value is required here...

(define (read-integer-unsafe file)
  (receive (int eof? status) (read-integer file)
    int))

(define matrix-size 80)
(define (matrix-index i j) (+ (* matrix-size i) j))
(define (matrix-set matrix i j value) (vector-set! matrix (matrix-index i j) value))
(define (matrix-get matrix i j) (vector-ref matrix (matrix-index i j)))
(define (min a b) (if (< a b) a b))

(define (matrix-parse filename)
  (letrec
    ((matrix-parse-recursive
       (lambda (file matrix index limit)
         (if (< index limit)
           (begin
             (if (> index 0) (skip-char file))
             (vector-set! matrix index (read-integer-unsafe file))
             (matrix-parse-recursive file matrix (+ index 1) limit))
           matrix))))
    (let* ((size (* matrix-size matrix-size))
           (matrix (make-vector size 0)))
      (with-open-file (file filename matrix)
        (matrix-parse-recursive file matrix 0 size)))))

; Walk left-to-right, top-to-bottom, filling in best of up/left path
(define (matrix-solve matrix)
  (for-range (i 0 matrix-size)
    (for-range (j 0 matrix-size)
      (if (or (> i 0) (> j 0))
        (let ((up   (if (> i 0) (matrix-get matrix (- i 1) j) 1000000000))
  	      (left (if (> j 0) (matrix-get matrix i (- j 1)) 1000000000)))
          (matrix-set matrix i j (+ (matrix-get matrix i j) (min up left)))))))
  (let ((last (- matrix-size 1)))
    (matrix-get matrix last last)))

; Entry point
(define (main argc argv)
  (if (= argc 2)
    (let* ((out (current-output-port))
	   (matrix (matrix-parse (vector-ref argv 1)))
	   (solution (matrix-solve matrix)))
      (write-integer solution out)
      (newline out)
      0)
    -1))

