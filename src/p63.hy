; Note: mostly solved using algebra
(require hyrule [->])
(import math)

(-> (lfor n (range 1 10)
          (math.floor (/ -1 (- (math.log n 10) 1))))
    (sum)
    (print))
