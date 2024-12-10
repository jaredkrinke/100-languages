Module: p88

define function recurse(best :: <vector>, max, start, depth, sum, product) => ()
	if ((product > max) | (sum > max) | (depth >= size(best)))
		// Too big or irrelevant; abandon this branch
	else
		// 1s don't change the product, so they can be added to adjust the sum
		let index = (product - sum) + depth;
		if ((index >= 2) & (index < size(best)) & (product < best[index]))
			best[index] := product;
		end;

		// Continue checking (with numbers at least as large as the previous one)...
		for (i from start to truncate/(max, product))
			recurse(best, max, i, depth + 1, sum + i, product * i);
		end;
	end;
end function;

define function solve (max :: <integer>)
		=> (result :: <integer>)
	// Skip < 2 per problem description and initialize to known solution
	let best = make(<vector>, size: max + 1, fill: 0);
	for (i from 2 below size(best))
		best[i] := 2 * i; // 2+k+1...+1 = 2*k*1...*1
	end;

	// Only test values >= 2 since 1s can be inferred
	recurse(best, 2 * max, 2, 0, 0, 1);

	// Return sum of unique values
	reduce1(\+, remove-duplicates(best))
end function;

// Main entry point
format-out("%d\n", solve(12000));

