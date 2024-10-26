// AssemblyScript solution for Project Euler problem 68

/** Test for "magic" (as defined in the problem statement) */
function isMagic(sides: u8, arrangement: Array<u8>): bool {
  let expected: u8 = 0;
  for (let i: u8 = 0; i < sides; i++) {
    // Check the sum on this line
    const sum = arrangement[i] + arrangement[(i + 1) % sides] + arrangement[i + sides];
    if (expected > 0) {
      if (sum !== expected) {
        // Sum doesn't match previous sum; result: not magic
        return false;
      }
    } else {
      expected = sum;
    }
  }

  // All sums were equal; result: magic
  return true;
}

/** Create a number out of the digit string (with special handling for 10) */
function concatenate(sides: u8, arrangement: Array<u8>): u64 {
  // Find lowest external node
  let lowest = sides * 2;
  let lowestIndex = 0;
  for (let i: u8 = 0; i < sides; i++) {
    const value = arrangement[i + sides];
    if (value < lowest) {
      lowest = value;
      lowestIndex = i;
    }
  }

  let result: u64 = 0;
  for (let i: u8 = 0; i < sides; i++) {
    const index = (lowestIndex + i) % sides;
    const offsets = [index + sides, index, (index + 1) % sides];
    for (let j = 0; j < offsets.length; j++) {
      const value = arrangement[offsets[j]];
      result *= (value < 10) ? 10 : 100;
      result += value;
    }
  }
  
  return result;
}

/** Recursive function to test permutations and, if valid, return the best value */
function recurse(sides: u8, arrangement: Array<u8>, position: u8, remaining: u16): u64 {
  const n = sides * 2;
  if (position >= n) {
    // Permutation is complete; test it
    if (isMagic(sides, arrangement)) {
      return concatenate(sides, arrangement);
    } else {
      return 0;
    }
  } else {
    // Still building permutation
    let best: u64 = 0;
    for (let i: u8 = 0; i < n; i++) {
      const bit: u16 = 1 << i;
      if (remaining & bit) {
        // Also need to ensure that 10 isn't in an internal node (because that would result in a
        // 17-digit string, which is explicitly disallowed in the problem statement)
        if ((i + 1) < 10 || (position > sides)) {
          arrangement[position] = i + 1;
          const result = recurse(sides, arrangement, position + 1, remaining & ~bit);
          if (result > best) {
            best = result;
          }
        }
      }
    }
    return best;
  }
}

/** Main entry point */
export function solve(): u64 {
  const sides: u8 = 5;
  return recurse(sides, new Array<u8>(sides * 2), 0, ~0);
}
