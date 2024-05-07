app [main] { pf: platform "https://github.com/roc-lang/basic-cli/releases/download/0.10.0/vNe6s9hWzoTZtFmNkvEICPErI9ptji_ySjicO6CkucY.tar.br" }

import pf.Stdout

zero = Result.withDefault (List.get (Str.toUtf8 "0") 0) 0u8

champernowne = \length, i ->
    if length <= 0 then ""
    else Str.concat (Num.toStr i) (champernowne (length - (Num.min length (Str.countUtf8Bytes (Num.toStr i)))) (i + 1))

bytes = Str.toUtf8 (champernowne 100000 1)

digit = \i -> (Result.withDefault (List.get bytes (i - 1)) 0u8) - zero

main =
    Stdout.line! (Num.toStr ((digit 1) * (digit 10) * (digit 100) * (digit 1000) * (digit 10000) * (digit 100000)))
