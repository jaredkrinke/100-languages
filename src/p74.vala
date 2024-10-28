class DigitFactorialChains : GLib.Object {
    public static int[] digitFactorials;

    public static int factorial(int n) {
        int p = 1;
        for (int i = 2; i <= n; i++) {
            p *= i;
        }
        return p;
    }

    public static int[] precomputeDigitFactorials() {
        int[] factorials = new int[10];
        for (int i = 0; i < factorials.length; i++) {
            factorials[i] = factorial(i);
        }
        return factorials;
    }

    public static int sumDigitFactorials(int n) {
        int s = 0;
        while (n > 0) {
            s += digitFactorials[n % 10];
            n /= 10;
        }
        return s;
    }

    public static bool contains(int n, int[] a) {
        foreach (int m in a) {
            if (n == m) {
                return true;
            }
        }
        return false;
    }

    public static int digitFactorialChainLength(int n) {
        int[] seen = {};
        while (!contains(n, seen)) {
            seen.resize(seen.length + 1);
            seen[seen.length - 1] = n;
            n = sumDigitFactorials(n);
        }
        return seen.length;
    }

    public static int solve() {
        int count = 0;
        for (int i = 1; i < 1000000; i++) {
            if (digitFactorialChainLength(i) == 60) {
                count++;
            }
        }
        return count;
    }

    public static int main(string[] args) {
        digitFactorials = precomputeDigitFactorials();
        stdout.printf("%d\n", solve());
        return 0;
    }
}
