{
	# Put spaces between all digits (for subsequent split), and gather into an array
	gsub(/[0-9]/, "& ")
	a[++i] = $0
}
END {
	# Add digits into an array starting with *least* significant digit
	# Note: "for (i in a)" order is unspecified
	for (i in a) {
		split(a[i], n_digits, " ")
		l = length(n_digits)
		for (j in n_digits) {
			digit_sums[l - j + 1] += n_digits[j]
		}
	}

	# Calculate digits, including carries
	l = length(digit_sums)
	carry = 0
	for (i = 1; i <= l; i++) {
		sum = carry + digit_sums[i]
		digits[i] = sum % 10
		carry = int(sum / 10)
	}

	# Construct 10-digit result string, starting with carry
	result = carry
	for (i = 0; length(result) < 10; i++) {
		result = result digits[l - i]
	}

	print result
}
