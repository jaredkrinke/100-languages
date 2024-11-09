(def roman-numerals
  "Roman numeral sequences, descending"
  [["M"  1000]
   ["CM" 900]
   ["D"  500]
   ["CD" 400]
   ["C"  100]
   ["XC" 90]
   ["L"  50]
   ["XL" 40]
   ["X"  10]
   ["IX" 9]
   ["V"  5]
   ["IV" 4]
   ["I"  1]])

(defn number->roman-numerals
  "Format number as minimal Roman numerals by appending strings in descending order"
  [num]
  (def buffer (buffer))
  (var n num)
  (each [s value] roman-numerals
    (while (>= n value)
      (buffer/push-string buffer s)
      (-= n value)))
  (string buffer))

# Note: Using a Parsing Expression Grammar for this problem is overkill since all provided inputs are valid (and a
# regular expression would probably suffice), but I wanted to give Janet's built-in PEG support a try.

(defn roman-numeral-to-rule
  "Convert a Roman numeral string and value to a grammar rule"
  [[str value]]
  [(keyword (string/ascii-lower str))
   ~(sequence ,str (constant ,value))])

(def grammar
  "Grammar for parsing Roman numerals"
  (peg/compile
    # There must be some easier way to splice into a struct...
    (struct (splice
              ~[,;(mapcat roman-numeral-to-rule roman-numerals)
                :main (sequence
                        (any :m)
                        (? :cm)
                        (? (choice
                             :d
                    	 :cd))
                        (any :c)
                        (? :xc)
                        (? (choice
                             :l
                    	 :xl))
                        (any :x)
                        (? :ix)
                        (? (choice
                             :v
                             :iv))
                        (any :i))]))))

(defn roman-numerals->number
  "Parse Roman numerals using grammar and sum values"
  [string]
  (->> string
       (peg/match grammar)
       (reduce + 0)))

(defn diff
  "Calculate the difference in characters of original vs. minimal form"
  [numerals]
  (- (length numerals)
     (-> numerals
         (roman-numerals->number)
	 (number->roman-numerals)
	 (length))))

# Entry point
(pp (->> "0089_roman.txt"
         (slurp)
	 (string/split "\n")
	 (map diff)
	 (reduce + 0)))

