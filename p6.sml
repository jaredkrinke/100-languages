fun square(n) = n * n;

val numbers = List.tabulate(100, fn n => 1 + n);
val square_of_sum = square(List.foldl op+ 0 numbers);
val sum_of_squares = List.foldl op+ 0 (List.map (fn n => n * n) numbers);

print (Int.toString (abs (sum_of_squares - square_of_sum)));
