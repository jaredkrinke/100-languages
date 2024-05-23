class ProjectEuler51 {
	static final limit = 1000000;
	static var prime = new Array(); // prime[n] is true implies n is prime
  static var digitCountToSubsets: Array<Array<Array<Int>>>; // Subsets of digits that can be replaced, given a digit count

	static function sievePrimes() {
		for (i in 2...limit) {
			prime[i] = true;
		}

		for (i in 2...Std.int(limit / 2)) {
			var j = 2 * i;
			while (j < limit) {
				prime[j] = false;
				j += i;
			}
		}
	}

	static function crossMultiply(n:Int, sets:Array<Array<Int>>):Array<Array<Int>> {
		var result = sets.copy();
		for (set in sets) {
			result.push([n].concat(set));
		}
		return result;
	}

	static function computeSubsets():Void {
		// First, compute ALL subsets for each number of digits
		digitCountToSubsets = new Array();

		var power = 1;
		var digitCount = 1;
		var subsets = [[power], []];

		while (power < limit) {
			digitCountToSubsets[digitCount] = subsets;
			power *= 10;
			digitCount++;
			if (power < limit) {
				subsets = crossMultiply(power, subsets);
			}
		}
    
    // Now, filter out "empty" and "all"
    for (i in 1...digitCount) {
      digitCountToSubsets[i] = digitCountToSubsets[i].filter(function (subset) {
        return (subset.length > 0) && (subset.length < i);
      });
    }
	}

	static function countDigits(n:Int):Int {
		var count = 1;
		var k = 10;
		while (k <= n) {
			k *= 10;
			count++;
		}
		return count;
	}

	static function replaceDigit(n:Int, power:Int, digit:Int):Int {
		var p10 = power * 10;
		var above = Std.int(n / p10) * p10;
		var d = digit * power;
		var below = n % power;
		return above + d + below;
	}

	static function countReplacedPrimes(n:Int):{primeCount:Int, smallestPrime:Int} {
    final digitCount = countDigits(n);
    final subsets = digitCountToSubsets[digitCount];
    var primeCountMax = 0;
    var relatedPrime = 0;
    for (subset in subsets) {
      var primeCount = 0;
      var smallestPrime = 0;
      for (digit in 0...10) {
        // Substitute digits
        var m = n;
        for (power in subset) {
          m = replaceDigit(m, power, digit);
        }
        
        if (prime[m] && (countDigits(m) == digitCount)) {
          primeCount++;
          if (smallestPrime == 0) {
            smallestPrime = m;
          }
        }
      }
      
      if (primeCount > primeCountMax) {
        primeCountMax = primeCount;
        relatedPrime = smallestPrime;
      }
    }
    
    return {
      primeCount: primeCountMax,
      smallestPrime: relatedPrime
    };
	}

	static function findSolution(desiredPrimeCount:Int):Int {
		for (i in 10...limit) {
			if (prime[i]) {
        final result = countReplacedPrimes(i);
				if (result.primeCount >= desiredPrimeCount) {
					return result.smallestPrime;
				}
			}
		}
		return -1;
	}

	static function main() {
		sievePrimes();
    computeSubsets();
		trace(Std.string(findSolution(8)));
	}
}
