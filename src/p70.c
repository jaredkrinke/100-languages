/* Note: some of this code is reused from Zig in the solution to
   problem 72 (with "P72" defined to suppress e.g. main()) */

#ifndef P72
#include <stdlib.h>
#include <stdio.h>
#endif

/* Compute totients 1..n-1 (note: using n-1 so that n is the number of elements in totients) */
void compute_totients(unsigned int n, unsigned int *totients) {
    unsigned long long tmp;
    unsigned int i;
    unsigned int j;

    /* Initialize for totient sieve */
    for (i = 0; i < n; i++) {
        totients[i] = i;
    }

    /* Sieve */
    for (i = 2; i < n; i++) {
        /* Check to see if i is prime by checking to see if totient[i] == i */
        if (totients[i] == i) {
            /* For each multiple, multiply by (i - 1) / i */
            for (j = i; j < n; j += i) {
                tmp = (unsigned long long)totients[j];
                tmp = tmp * (i - 1) / i;
                totients[j] = (unsigned long)tmp;
            }
        }
    }
}

#ifndef P72

/* Count digits in a, storing counts in *counts */
static void count_digits(unsigned int a, unsigned int *counts) {
    int i;
    
    for (i = 0; i < 10; i++) {
        counts[i] = 0;
    }

    while (a > 0) {
        counts[a % 10] += 1;
        a /= 10;
    }
}

/* Return non-zero if a is a permutation of the digits in b */
static int is_permutation(unsigned int a, unsigned int b) {
    int i;
    unsigned int ca[10];
    unsigned int cb[10];
    
    count_digits(a, ca);
    count_digits(b, cb);

    for (i = 0; i < 10; i++) {
        if (ca[i] != cb[i]) {
            return 0;
        }
    }
    return 1;
}

/* Minimize n/phi(n) when n is a permutation of phi(n) */
static unsigned int solve(unsigned int limit) {
    unsigned int i;
    unsigned int n = 0;
    float min = 100.0f;
    float value;
    unsigned int *totients = malloc(limit * sizeof(unsigned int)); /* Too big for stack */

    compute_totients(limit, totients);

    for (i = 2; i < limit; i++) {
        if (is_permutation(i, totients[i])) {
            value = ((float)i)/totients[i];
            if (value < min) {
                n = i;
                min = value;
            }
        }
    }

    free(totients);

    return n;
}

int main(int argc, char **argv) {
    printf("%u\n", solve(10000000));
    return 0;
}

#endif
