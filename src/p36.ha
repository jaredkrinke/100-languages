use fmt;
use strings;

fn palindrome(s: str) bool = {
	const buffer = strings::toutf8(s);
	const length = len(buffer);
	const mid = length / 2;
	
	let palindromic = true;
	for (let i = 0z; i < mid && palindromic; i += 1) {
		palindromic = (buffer[length - i - 1] == buffer[i]);
	};
	
	return palindromic;
};

export fn main() void = {
	let sum = 0;
	for (let i = 0; i < 1000000; i += 1) {
		const binary = fmt::asprintf("{:b}", i);
		const decimal = fmt::asprintf("{}", i);
		if (palindrome(binary) && palindrome(decimal)) {
			sum += i;
		};
		free(decimal);
		free(binary);
	};

	fmt::println(sum)!;
};
