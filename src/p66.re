/* Misc. helpers */
let range = (min, max) => Array.to_list(Array.init(max - min + 1, (i) => min + i));
let floor_of_sqrt = (n) => int_of_float(sqrt(float_of_int(n)));
let even = (n: int) => (n mod 2) == 0;
let first = ((a, b)) => a;
let all_but_last = (l) => List.rev(List.tl(List.rev(l)));

let not_square = (n) => {
  let root = floor_of_sqrt(n);
  root * root != n;
}

/* Big rationals (note: There is no native "big integer" or rational support, but a (float, float) tuple works for this particular problem) */
type ratio = (float, float);

let invert = ((n, d): ratio) => (d, n);
let add_int = (a: float, (bn, bd): ratio) => (a *. bd +. bn, bd);

let rec compute_fraction = (terms: list(int)) => switch (terms) {
  | [a] => (float_of_int(a), 1.);
  | [a, ...rest] => add_int(float_of_int(a), invert(compute_fraction(rest)));
  | [] => raise(Arg.Bad("No terms supplied"));
}

/* Continued fraction convergents */
type expansion = { a: int, b: int, c: int };

let find_convergents = (n: int) => {
  let rec recurse = (a0: int, seen: list(expansion), count: int) => {
    let previous = List.hd(seen);
    let c = previous.a * previous.b - previous.c;
    let b = (n - c * c) / previous.b;
    let a = (a0 + c) / b;
    let next = {a, b, c};
    
    switch (List.find_opt((e) => e == next, seen)) {
      | Some(_) => (count, seen |> List.rev |> List.map((e) => e.a))
      | None => recurse(a0, [next, ...seen], count + 1)
    };
  }
  
  let a0: int = floor_of_sqrt(n);
  recurse(a0, [{ a: a0, b: 1, c: 0 }], 0);
}

/* Solve Pell's equation using continued fractions approach */
let find_fundamental_solution = (n) => {
  let (period, terms) = find_convergents(n);
  if (even(period)) {
    compute_fraction(all_but_last(terms));
  } else {
    let a0 = List.hd(terms);
    let rest = List.tl(terms);
    compute_fraction(all_but_last(List.concat([[a0], rest, rest])));
  }
}

/* Main entry point */
let solve = (n) => {
  range(1, n)
    |> List.filter(not_square)
    |> List.map((n) => (n, first(find_fundamental_solution(n))))
    |> List.fold_left(((an, ax), (bn, bx)) => (bx > ax) ? (bn, bx) : (an, ax), (0, 0.))
    |> first;
}

Js.log(solve(1000));
