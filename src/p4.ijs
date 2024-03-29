palindrome =: 3 : '((<|.": y)=(<": y))*y'  NB. Checks if same forwards and backwards, then multiplies by Boolean (0 or 1)
>./palindrome "0 (,*/~(i.1000)-.i.100)     NB. Applies "palindrome" to each item in a flattened list of products of values on the interval [100, 999], and takes the max
