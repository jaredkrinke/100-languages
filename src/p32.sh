#!/bin/bash

# Store sum and seen products
sum=0
products=

# Check all equations for a given permutation of digits
check()
{
    # Inputs are length i and j. Product must be >= max length of i and j, so only use range [1, 4]
    for ((i=1; i <= 4; i++)); do
        a=${1:0:i}
        for ((j=1; j <= 4; j++)); do
            b=${1:i:j}
            c=${1:i+j}
            product=$(( $a * $b ))
            if [[ $product = $c ]]; then
                if [[ !(${products[product]} = 1) ]]; then
                    echo "$a * $b = $c"
                    sum=$((sum+product))
                    products[product]=1
                fi
            fi
        done
    done
}

# Check all permutations of digits
permute()
{
    local i
    local c
    if [[ ${#1} > 0 ]]; then
        for ((i=0; i < ${#1}; i++)); do
            c=${1:i:1}
            permute "${1/$c/''}" "$2$c"
        done
    else
        check $2
    fi
}

# Sum all pandigital products
permute "123456789"
echo "Sum: $sum"
