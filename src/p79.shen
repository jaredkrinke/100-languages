\\ Parsing
(define character->int C -> (- (string->n C) (string->n "0")))
(define newline? C -> (= (string->n C) 10))
(define split-lines-recursive
  "" Line -> [Line]
  (@s Char Rest) Line -> [Line | (split-lines-recursive Rest "")] where (newline? Char)
  (@s Char Rest) Line -> (split-lines-recursive Rest (@s Line Char)))

(define split-lines S -> (split-lines-recursive S ""))
(define remove-empties
  [] -> []
  ["" | Rest] -> (remove-empties Rest)
  [S | Rest] -> [S | (remove-empties Rest)])

\\ Note: Topological sort would faster, but I wanted to try Shen's embedded Prolog
(defprolog append3
  [] X X <--;
  [Head | Tail] X [Head | TailAndX] <-- (append3 Tail X TailAndX);)

(defprolog append2
  [] [] <--;
  [List | Rest] Result <-- (append3 List Inner Result)
                           (append2 Rest Inner);)

(defprolog ordered
  A B C List <-- (append2 [BeforeA [A] BeforeB [B] BeforeC [C] AfterC] List);)

\\ Minimizing the solution using Prolog was slow, so remove uniques (starting from the end) procedurally
(define unique-recursive
  [] Result -> Result
  [Head | Tail] Result -> (unique-recursive Tail [Head | Result]) where (not (element? Head Result))
  [Head | Tail] Result -> (unique-recursive Tail Result))
(define unique X -> (unique-recursive (reverse X) []))

\\ Entry point
(let
  lines (remove-empties (split-lines (read-file-as-string "0079_keylog.txt")))
  clauses (map (/. S (append [ordered] (map (fn character->int) (explode S)) [L])) lines)
  nonminimal (eval (append [prolog?] clauses [[return L]]))
  solution (unique nonminimal)

  (map (fn print) solution))

