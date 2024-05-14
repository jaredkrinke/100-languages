// Utilities
let rec mapseqInternal f output input =
    match input with
    | [] -> output
    | head :: tail -> (mapseqInternal f ((f (head :: tail)) :: output) tail)

let mapseq f sequence = Seq.rev (mapseqInternal f [] sequence)

// Prime sieve
let max = 1000000
let composites =
    [2..max]
    |> Seq.map (fun n -> seq { for i in 2..(max / n) -> i * n })
    |> Seq.concat

let primes =
    [2..max]
    |> Seq.except composites

let primeSet =
    primes
    |> Set.ofSeq

// Find longest consecutive prime sum under the limit
let rec primeSumUnderInternal sum count best sequence =
    match sequence with
    | [] -> best
    | head :: tail ->
        let newSum = (sum + head)
        let newCount = (count + 1)
        if newSum > max
        then best
        else (primeSumUnderInternal newSum newCount (if Set.contains newSum primeSet then (newSum, newCount) else best) tail)

let primeSumUnder sequence =
    primeSumUnderInternal 0 0 (0, 0) sequence

// Start at each index and find the longest
let solution =
    primes
    |> List.ofSeq
    |> mapseq primeSumUnder
    |> Seq.maxBy (fun (sum, count) -> count)
    |> fun (sum, count) -> sum

printfn $"{solution}"
