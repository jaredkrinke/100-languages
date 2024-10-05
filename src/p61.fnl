; List utilities
(fn copy-sequence-except [sequence exclusion]
  (let [copy {}]
    (each [_ item (ipairs sequence)]
      (if (not (= item exclusion))
        (table.insert copy item)))
    copy))

; Convert list of numbers into list of [firstTwoDigits secondTwoDigits value]
(fn prepare-digit-list [valueList]
  (let [result {}]
    (each [i value (ipairs valueList)]
      (tset result i [(math.floor (/ value 100))
                      (% value 100)
                      value]))
    result))

; Compute all four-digit figurate numbers
(fn compute-four-digits [f]
  (var n 1)
  (let [result {}]
    (while (< (f n) 1000)
      (set n (+ n 1)))
    (while (< (f n) 10000)
      (table.insert result (f n))
      (set n (+ n 1)))
    (prepare-digit-list result)))

; Find cyclical numbers by trying starting with each number of the first set and then trying each number of every
; other set, printing the sum at the end (but not bothering to end computation, for convenience)
(fn find-cycle-internal [first last sum rest]
  (if (= 0 (length rest))
        (when (= first last)
          (print sum))
      (each [_ valueList (ipairs rest)]
        (each [_ value (ipairs valueList)]
          (when (= first (. value 1))
            (find-cycle-internal (. value 2)
                                 last
                                 (+ sum (. value 3))
                                 (copy-sequence-except rest valueList)))))))

(fn find-cycle [valueLists]
  (let [valueList (. valueLists 1)]
    (each [_ value (ipairs valueList)]
      (find-cycle-internal (. value 2)
                           (. value 1)
                           (. value 3)
                           (copy-sequence-except valueLists valueList)))))

; Entry point
(find-cycle [(compute-four-digits (fn [n] (/ (* n (+ n 1)) 2)))
             (compute-four-digits (fn [n] (* n n)))
             (compute-four-digits (fn [n] (/ (* n (- (* 3 n) 1)) 2)))
             (compute-four-digits (fn [n] (* n (- (* 2 n) 1))))
             (compute-four-digits (fn [n] (/ (* n (- (* 5 n) 3)) 2)))
             (compute-four-digits (fn [n] (* n (- (* 3 n) 2))))])
