# Use Python's built-in arbitrary precision square root function. Is this
# cheating or just "using the right tool for the job"? You decide.

from decimal import *
from math import *

count = 100
squares = [n*n for n in range(1, ceil(sqrt(count)) + 1)];

# Set precision to 110 to avoid rounding of the 100th digit
digits = 100
getcontext().prec = digits + 10

def sumRootDigits(n):
    # digits+1 because of decimal point
    return sum([int(c) for c in str(Decimal(n).sqrt())[0:(digits + 1)] if c.isdigit()])

print(sum([sumRootDigits(n) for n in range(1, count + 1) if not n in squares]))
