(def limit 1000000)

(defn closest [d]
  (/ (int (Math/floor (* 3/7 d)))
     d))

(def previous
  (->> (range 2 (+ 1 limit))
    (map closest)
    (filter #(not (= % 3/7)))
    (apply max)))

(println (numerator previous))
