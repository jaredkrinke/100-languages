;;; Algorithm: simulate 1 million movements, count times landing on
;;; each square, and then find the top 3

(defparameter *square-count* 40)
(defparameter *consecutive-doubles-for-jail* 3)

;;; Special squares
(defparameter *go-index* 0)
(defparameter *jail-index* 10)
(defparameter *go-to-jail-index* 30)
(defparameter *chance-indices* '(7 22 36))
(defparameter *community-chest-indices* '(2 17 33))

;;; Special cards/actions
(defun create-cards (count actions)
  "Creates a list of COUNT cards, containing ACTIONS and no-ops (IDENTITY)"
  (append (copy-seq actions)
	  (loop repeat (- count (length actions))
		collect 'identity)))

(defparameter *community-chest-actions*
  (create-cards 16 '(advance-to-go
		     go-to-jail)))

(defparameter *chance-actions*
  (create-cards 16 '(advance-to-go
		     go-to-jail
		     go-to-c1
		     go-to-e3
		     go-to-h2
		     go-to-r1
		     go-to-next-r
		     go-to-next-r
		     go-to-next-u
		     go-back-3)))

;;; Helpers
(defun join (items &optional (type 'string))
  (apply #'concatenate (cons type items)))

(defun format-index (index)
  (format nil "~2,'0d" index))

(defun format-result (counts)
  (join (mapcar #'format-index
		(subseq (mapcar #'first
				(sort (loop for i upfrom 0
					    for count across counts
					    collect (list i count))
				      #'>
				      :key #'second))
			0 3))))

(defmacro draw-cardf (cards)
  `(let ((first-cell ,cards)
	 (last-cell (last ,cards)))
     (setf ,cards (cdr first-cell))
     (setf (cdr first-cell) nil)
     (setf (cdr last-cell) first-cell)
     (car first-cell)))

(defun shuffle (cards)
  "Returns a copy of CARDS, with items shuffled"
  (let ((v (coerce cards 'vector)))
    (loop with length = (length v)
	  for i from 0 below (1- length)
	  do (rotatef (aref v i)
		      (aref v (+ i (random (- length i))))))
    (coerce v 'list)))

;;; Movement functions (other than IDENTITY)
(defun go-to-jail (&optional position)
  (declare (ignore position))
  *jail-index*)

(defun advance-to-go (position)
  (declare (ignore position))
  *go-index*)

(defun go-to-c1 (position)
  (declare (ignore position))
  11)

(defun go-to-e3 (position)
  (declare (ignore position))
  24)

(defun go-to-h2 (position)
  (declare (ignore position))
  39)

(defun go-to-r1 (position)
  (declare (ignore position))
  5)

(defun go-to-next-r (position)
  (cond ((< position 5) 5)
	((< position 15) 15)
	((< position 25) 25)
	((< position 35) 35)
	(t 5)))

(defun go-to-next-u (position)
  (cond ((< position 12) 12)
	((< position 28) 28)
	(t 12)))

(defun go-back-3 (position)
  (- position 3))

;;; Simulation
(defun simulate-monopoly (sides iterations)
  "Simulates Monopoly movement for ITERATIONS iterations, using two SIDES-sided dice, counting visits to each square"
  (flet ((roll () (loop repeat 2 collect (1+ (random sides)))))
    (loop with position = *go-index*
	  with community-chest-cards = (shuffle *community-chest-actions*)
	  with chance-cards = (shuffle *chance-actions*)
	  with consecutive-doubles = 0
	  with visit-counts = (make-array *square-count* :initial-element 0)
	  for dice = (roll)
	  for is-double = (= (first dice) (second dice))
	  for total = (reduce #'+ dice)
	  for target = (mod (+ position total) *square-count*)
	  repeat iterations
	  do ;; Increment visit count
	     (incf (aref visit-counts position))
	     ;; Check for double
	     (if is-double
		 (incf consecutive-doubles)
		 (setf consecutive-doubles 0))
	     ;; Move, applying any special logic
	     (setf position (cond ((= consecutive-doubles 3)
				   (go-to-jail))
				  ((= target *go-to-jail-index*)
				   (go-to-jail))
				  ((member target *chance-indices*)
				   (funcall (draw-cardf chance-cards) target))
				  ((member target *community-chest-indices*)
				   (funcall (draw-cardf community-chest-cards) target))
				  (t target)))
	  finally (return visit-counts))))

(defun compute-monopoly-stats (sides iterations)
  (let* ((counts (simulate-monopoly sides iterations))
	 (total (reduce #'+ counts)))
    (loop for i upfrom 0
	  for count across counts
	  do (format t "~a: ~1,2f%~%" (format-index i) (/ (* 100 count) total)))))

;;; Entry point
(defun monopoly-odds (&optional (sides 4) (iterations 1000000))
  (format-result (simulate-monopoly sides iterations)))
