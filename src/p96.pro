:- use_module(library(pio)).
:- use_module(library(dcg/basics)).
:- use_module(library(clpfd)).
:- use_module(library(apply)).

%%%% Parsing
% E.g. "Grid 45"
heading --> `Grid `, digit(_),digit(_), eol.

% E.g. "120056709" (note that "0" indicates a blank square)
d(_) --> `0`.
d(N) --> digit(D),{ number_codes(N,[D]) }.
row([D1,D2,D3,D4,D5,D6,D7,D8,D9]) --> d(D1),d(D2),d(D3),d(D4),d(D5),d(D6),d(D7),d(D8),d(D9),eol.

% A single puzzle
puzzle([R1,R2,R3,R4,R5,R6,R7,R8,R9]) --> heading,row(R1),row(R2),row(R3),row(R4),row(R5),row(R6),row(R7),row(R8),row(R9).

% All puzzles (note that the order and cut are used since we know there is only one valid parse tree)
puzzles([Puzzle|Rest]) --> puzzle(Puzzle), puzzles(Rest), !.
puzzles([]) --> [].

%%%% Solving (constraints first)
inRange(Digit) :- Digit in 1..9.
lineGood(Row) :- maplist(inRange, Row), all_distinct(Row).
rowsGood(Rows) :- maplist(lineGood, Rows).
colsGood(Rows) :- transpose(Rows, Columns), maplist(all_distinct, Columns).

blockRowGood([], [], []).
blockRowGood([C11, C12, C13 | C1Rest], [C21, C22, C23 | C2Rest], [C31, C32, C33 | C3Rest]) :- all_distinct([C11, C12, C13, C21, C22, C23, C31, C32, C33]), blockRowGood(C1Rest, C2Rest, C3Rest).
blockRowsGood([R1, R2, R3, R4, R5, R6, R7, R8, R9]) :- blockRowGood(R1, R2, R3), blockRowGood(R4, R5, R6), blockRowGood(R7, R8, R9).

good(Rows) :- rowsGood(Rows), colsGood(Rows), blockRowsGood(Rows).

% Now use labeling() to search for the specific values
solve(Rows) :- good(Rows), append(Rows, Flat), labeling([],Flat).

%%%% Aggregating
result(Puzzle, Result) :- solve(Puzzle), [[H, T, O | _] | _] = Puzzle, Result is 100*H + 10*T + O.
add(X, Y, Sum) :- Sum is X+Y.
sum(Puzzles, Sum) :- maplist(result, Puzzles, Results), foldl(add, Results, 0, Sum).
solvePuzzles(File, Sum) :- phrase_from_file(puzzles(Puzzles),File), sum(Puzzles, Sum).

%%%% Main entry point (set "initialization" to make this script non-interactive)
:- initialization solve,halt.
solve :- solvePuzzles("p096_sudoku.txt", Sum), write(Sum), nl.
