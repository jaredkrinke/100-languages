; Read in words (note: "replace" with an empty string replacement didn't seem to work)
raw: read/text %"0042_words.txt"
remove-each c raw [eq? c '"']
words: split raw ','

; Add values of characters in word
score: func [word] [
    sum: 0
    foreach c word [
        sum: add sum (add 1 (sub c 'A'))
    ]
    sum
]

; Compute first 50 triangle numbers (aside: probably too many)
n: 1
tris: []
loop 50 [
    append tris (div (mul n (add n 1)) 2)
    ++ n
]

; Count "triangle words" and print
count: 0
foreach word words [
    if (find tris (score word)) [
        ++ count
    ]
]

print count
