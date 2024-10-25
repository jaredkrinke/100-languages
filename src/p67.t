use t3x;
use string;
use io;

max(a, b) do
	   if (a > b) return a;
	   return b;
end

do
	const lines = 100; ! As given in the problem description
	const numbers = 5050; ! (lines * (lines + 1)) / 2 (N.B. division is not supported in T3X/0 cvalues)

	var data[numbers];

	! Read numbers into data[]
	do
		var file, lineNumber, i;
		i := 0;
		lineNumber := 1;
		file := t3x.open("0067_triangle.txt", t3x.OREAD);
		if (file = %1) halt -1;
	
		for (lineNumber=1,lines+1) do
			var lineCounter;
			var buffer[3];
			buffer[2] := 0;
			
			for (lineCounter=0,lineNumber) do
				t3x.read(file, buffer, 2);
				data[i] := string.aton(buffer, 10, 0);
				i := i + 1;
				t3x.read(file, buffer, 1); ! Skip space or newline
			end
		end
	
		t3x.close(file);
	end

	! Find max at each node, bottom up
	do
		var best[lines], i, j, count;

		! Fill in with leaf values
		count := lines;
		i := numbers - count;
		for (j=0, count) do
			best[j] := data[i];
			i := i + 1;
		end

		i := i - count;
		
		! Compute max of each pair, for each line
		for (count=99,0,-1) do
			i := i - count;
			for (j=0, count) do
				best[j] := data[i] + max(best[j], best[j + 1]);
				i := i + 1;
			end
			i := i - count;
		end

		! Print result
		io.writeln(string.ntoa(best[0], 10));
	end
end
