app [main] { pf: platform "https://github.com/roc-lang/basic-cli/releases/download/0.10.0/vNe6s9hWzoTZtFmNkvEICPErI9ptji_ySjicO6CkucY.tar.br" }

import pf.Stdout

numToDigits = \n, digits ->
    if n == 0 then digits
    else numToDigits (n // 10) (List.prepend digits (n % 10))

champernowne = \index, digits, next ->
    if (List.isEmpty digits) then (champernowne index (numToDigits next []) (next + 1))
    else if index == 1 then (Result.withDefault (List.first digits) -1)
    else champernowne (index - 1) (List.dropFirst digits 1) next

digit = \index -> (champernowne index [] 1)

main =
    Stdout.line! (Num.toStr ((digit 1) * (digit 10) * (digit 100) * (digit 1000) * (digit 10000) * (digit 100000) * (digit 1000000)))
