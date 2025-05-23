# 100 Programming Languages
This repository tracked a [misguided quest to write code in 100 different programming languages](https://log.schemescape.com/posts/programming-languages/100-languages.html), specifically by solving the first 100 [Project Euler](https://projecteuler.net/) problems, using a different--and, ideally, new to me--language for each problem. For the record: no AIs were used (or harmed) in the making of this repository.

Note: my understanding is that educational sharing of methods and solutions for (only!) the first 100 Project Euler problems is currently allowed. **Spoiler alert!**

## Suggest Improvements
Most of these languages were new to me, so my solutions aren't always the best examples (esp. the Julia one). If you're experienced with one of these languages and are willing to share a more idiomatic solution, open a pull request! I'll leave the PR open (so it's clear it's not *my* code) and link it in the table below.

## The List
**(PR)** indicates someone has shared a more idiomatic solution in a pull request.

| # | Problem | Language | Solution |
|--:|---|---|---|
| 1 | [Multiples of 3 or 5](https://projecteuler.net/problem=1) | [SIC-1 Assembly Language](https://esolangs.org/wiki/SIC-1_Assembly_Language) | [p1.sic1](src/p1.sic1) |
| 2 | [Even Fibonacci Numbers](https://projecteuler.net/problem=2) | [SectorLISP](https://justine.lol/sectorlisp2/) | [p2.lisp](src/p2.lisp) |
| 3 | [Largest Prime Factor](https://projecteuler.net/problem=3) | [Fortran](https://fortran-lang.org/) | [p3.f90](src/p3.f90) |
| 4 | [Largest Palindrome Product](https://projecteuler.net/problem=4) | [J](https://www.jsoftware.com/#/) | [p4.ijs](src/p4.ijs) |
| 5 | [Smallest Multiple](https://projecteuler.net/problem=5) | [Gforth](https://gforth.org/) | [p5.fth](src/p5.fth) |
| 6 | [Sum Square Difference](https://projecteuler.net/problem=6) | [Standard ML](https://en.wikipedia.org/wiki/Standard_ML) ([SOSML](https://sosml.org/)) | [p6.sml](src/p6.sml) |
| 7 | [10001st Prime](https://projecteuler.net/problem=7) | [Squeak](https://squeak.org/) ([2.2](https://squeak.js.org/demo/simple.html)) | [p7.st](src/p7.st) |
| 8 | [Largest Product in a Series](https://projecteuler.net/problem=8) | [SQL](https://en.wikipedia.org/wiki/SQL) ([SQLite](https://www.sqlite.org/index.html)) | [p8.sql](src/p8.sql) |
| 9 | [Special Pythagorean Triplet](https://projecteuler.net/problem=9) | [XSLT](https://www.w3.org/TR/xslt-10/) | [p9.xsl](src/p9.xsl) |
| 10 | [Summation of Primes](https://projecteuler.net/problem=10) | [COBOL-85](https://en.wikipedia.org/wiki/COBOL#COBOL-85) | [p10.cbl](src/p10.cbl) |
| 11 | [Largest Product in a Grid](https://projecteuler.net/problem=11) | [Perl](https://www.perl.org/) | [p11.pl](src/p11.pl) |
| 12 | [Highly Divisible Triangular Number](https://projecteuler.net/problem=12) | [WebGPU Shading Language](https://www.w3.org/TR/WGSL/) | [p12.wgsl](src/p12.wgsl) ([HTML host](src/p12.html)) |
| 13 | [Large Sum](https://projecteuler.net/problem=13) | [AWK](https://en.wikipedia.org/wiki/AWK) | [p13.awk](src/p13.awk) |
| 14 | [Longest Collatz Sequence](https://projecteuler.net/problem=14) | [WebAssembly](https://webassembly.org/) ([Text Format](https://webassembly.github.io/spec/core/text/index.html)) | [p14.wat](src/p14.wat) |
| 15 | [Lattice Paths](https://projecteuler.net/problem=15) | [Scratch](https://scratch.mit.edu/) | [p15.sb3](src/p15.sb3) |
| 16 | [Power Digit Sum](https://projecteuler.net/problem=16) | [Commodore BASIC](https://en.wikipedia.org/wiki/Commodore_BASIC) ([2.0](https://www.c64-wiki.com/wiki/BASIC#BASIC_V2.0_of_C64)) | [p16.bas](src/p16.bas) |
| 17 | [Number Letter Counts](https://projecteuler.net/problem=17) | [Verilog](https://en.wikipedia.org/wiki/Verilog) | [p17.v](src/p17.v) |
| 18 | [Maximum Path Sum I](https://projecteuler.net/problem=18) | [XOD](https://xod.io/) | [p18.xodball](src/p18.xodball) ([screenshot](src/p18.png)) |
| 19 | [Counting Sundays](https://projecteuler.net/problem=19) | [EXA](https://www.zachtronics.com/exapunks/) ([TEC Redshift](https://store.steampowered.com/app/948420/EXAPUNKS_TEC_Redshift_Player/)) | [p19.exa](src/p19.exa) ([disc](src/p19.png)) |
| 20 | [Factorial Digit Sum](https://projecteuler.net/problem=20) | [BBC BASIC](https://en.wikipedia.org/wiki/BBC_BASIC) | [p20.bas](src/p20.bas) |
| 21 | [Amicable Numbers](https://projecteuler.net/problem=21) | [Unison](https://www.unison-lang.org/) | [p21.u](src/p21.u) |
| 22 | [Names Scores](https://projecteuler.net/problem=22) | [TCL](https://en.wikipedia.org/wiki/Tcl) | [p22.tcl](src/p22.tcl) |
| 23 | [Non-Abundant Sums](https://projecteuler.net/problem=23) | [Lil](https://beyondloom.com/tools/trylil.html) | [p23.lil](src/p23.lil) |
| 24 | [Lexicographic Permutations](https://projecteuler.net/problem=24) | [PostScript](https://en.wikipedia.org/wiki/PostScript) | [p24.ps](src/p24.ps) |
| 25 | [1000-digit Fibonacci Number](https://projecteuler.net/problem=25) | [fe](https://github.com/rxi/fe) | [p25.fe](src/p25.fe) |
| 26 | [Reciprocal Cycles](https://projecteuler.net/problem=26) | [x86 assembly](https://en.wikipedia.org/wiki/X86) (BIOS) | [p26.asm](src/p26.asm) ([boot sector](src/p26.img)) |
| 27 | [Quadratic Primes](https://projecteuler.net/problem=27) | [RetroForth](http://retroforth.org/) | [p27.forth](src/p27.forth) |
| 28 | [Number Spiral Diagonals](https://projecteuler.net/problem=28) | [Uxntal](https://wiki.xxiivv.com/site/uxntal.html) | [p28.tal](src/p28.tal) |
| 29 | [Distinct Powers](https://projecteuler.net/problem=29) | [APL](https://en.wikipedia.org/wiki/APL_(programming_language)) | [p29.apl](src/p29.apl) **([PR](https://github.com/jaredkrinke/100-languages/pull/2))** |
| 30 | [Digit Fifth Powers](https://projecteuler.net/problem=30) | [Factor](https://factorcode.org/) | [p30.factor](src/p30.factor) |
| 31 | [Coin Sums](https://projecteuler.net/problem=31) | [Rebol](http://www.rebol.com/) | [p31.r](src/p31.r) |
| 32 | [Pandigital Products](https://projecteuler.net/problem=32) | [Bash](https://www.gnu.org/software/bash/) | [p32.sh](src/p32.sh) |
| 33 | [Digit Cancelling Fractions](https://projecteuler.net/problem=33) | [Julia](https://julialang.org/) | [p33.jl](src/p33.jl) |
| 34 | [Digit Factorials](https://projecteuler.net/problem=34) | [Piet](https://www.dangermouse.net/esoteric/piet.html) | [p34.png](src/p34.png) ([ppm](src/p34.ppm), [scaled](src/p34-scaled.png)) |
| 35 | [Circular Primes](https://projecteuler.net/problem=35) | [Turbo Pascal](https://en.wikipedia.org/wiki/Turbo_Pascal) ([7.0](https://archive.org/details/turbopascal7.0)) | [p35.pas](src/p35.pas) |
| 36 | [Double-base Palindromes](https://projecteuler.net/problem=36) | [Hare](https://harelang.org/) | [p36.ha](src/p36.ha) |
| 37 | [Truncatable Primes](https://projecteuler.net/problem=37) | [Wren](https://wren.io/) | [p37.wren](src/p37.wren) |
| 38 | [Pandigital Multiples](https://projecteuler.net/problem=38) | [Pkl](https://pkl-lang.org/index.html) | [p38.pkl](src/p38.pkl) |
| 39 | [Integer Right Triangles](https://projecteuler.net/problem=39) | [قلب](https://nas.sr/%D9%82%D9%84%D8%A8/) | [p39.qlb](src/p39.qlb) |
| 40 | [Champernowne's Constant](https://projecteuler.net/problem=40) | [Roc](https://www.roc-lang.org/) | [p40.roc](src/p40.roc) |
| 41 | [Pandigital Prime](https://projecteuler.net/problem=41) | [wax](https://github.com/LingDong-/wax) | [p41.wax](src/p41.wax) |
| 42 | [Coded Triangle Numbers](https://projecteuler.net/problem=42) | [Boron](https://urlan.sourceforge.io/boron/) | [p42.b](src/p42.b) |
| 43 | [Sub-string Divisibility](https://projecteuler.net/problem=43) | [Self](https://en.wikipedia.org/wiki/Self_(programming_language)) | [p43.self](src/p43.self) |
| 44 | [Pentagon Numbers](https://projecteuler.net/problem=44) | [Haskell](https://www.haskell.org/) | [p44.hs](src/p44.hs) |
| 45 | [Triangular, Pentagonal, and Hexagonal](https://projecteuler.net/problem=45) | [文言](https://wy-lang.org/) | [p45.wy](src/p45.wy) |
| 46 | [Goldbach's Other Conjecture](https://projecteuler.net/problem=46) | [Idris](https://www.idris-lang.org/index.html) | [p46.idr](src/p46.idr) |
| 47 | [Distinct Primes Factors](https://projecteuler.net/problem=47) | [Nim](https://nim-lang.org/) | [p47.nim](src/p47.nim) |
| 48 | [Self Powers](https://projecteuler.net/problem=48) | [Min](https://min-lang.org/) | [p48.min](src/p48.min) |
| 49 | [Prime Permutations](https://projecteuler.net/problem=49) | [Cakelisp](https://macoy.me/blog/programming/CakelispIntro) | [p49.cake](src/p49.cake) |
| 50 | [Consecutive Prime Sum](https://projecteuler.net/problem=50) | [F#](https://fsharp.org/) | [p50.fs](src/p50.fs) |
| 51 | [Prime Digit Replacements](https://projecteuler.net/problem=51) | [Haxe](https://haxe.org/) | [p51.hx](src/p51.hx) |
| 52 | [Permuted Multiples](https://projecteuler.net/problem=52) | [Amiga Basic](https://en.wikipedia.org/wiki/Amiga_Basic) | [p52.bas](src/p52.bas) |
| 53 | [Combinatoric Selections](https://projecteuler.net/problem=53) | [K](https://en.wikipedia.org/wiki/K_(programming_language)) ([oK](http://johnearnest.github.io/ok/index.html)) | [p53.k](src/p53.k) **([PR](https://github.com/jaredkrinke/100-languages/pull/5))** |
| 54 | [Poker Hands](https://projecteuler.net/problem=54) | [TypeScript](https://www.typescriptlang.org/) (type system only) | [p54.ts](src/p54.ts) |
| 55 | [Lychrel Numbers](https://projecteuler.net/problem=55) | [Blazin' Forth](https://jimlawless.net/blog/posts/blazin/) | [p55.forth](src/p55.forth) ([.d64 image](src/p55.d64.zip)) |
| 56 | [Powerful Digit Sum](https://projecteuler.net/problem=56) | [G-Pascal](https://gammon.com.au/GPascal/) | [p56.pas](src/p56.pas) |
| 57 | [Square Root Convergents](https://projecteuler.net/problem=57) | [Scheme](https://en.wikipedia.org/wiki/Scheme_(programming_language)) | [p57.scm](src/p57.scm) |
| 58 | [Spiral Primes](https://projecteuler.net/problem=58) | [BCPL](https://en.wikipedia.org/wiki/BCPL) | [p58.b](src/p58.b) |
| 59 | [XOR Decryption](https://projecteuler.net/problem=59) | [MATLAB](https://en.wikipedia.org/wiki/MATLAB) ([GNU Octave](https://octave.org/)) | [p59.m](src/p59.m) |
| 60 | [Prime Pair Sets](https://projecteuler.net/problem=60) | [MoonScript](https://moonscript.org/) | [p60.moon](src/p60.moon) |
| 61 | [Cyclical Figurate Numbers](https://projecteuler.net/problem=61) | [Fennel](https://fennel-lang.org/) | [p61.fnl](src/p61.fnl) |
| 62 | [Cubic Permutations](https://projecteuler.net/problem=62) | [Erde](https://erde-lang.github.io/) | [p62.erde](src/p62.erde) |
| 63 | [Powerful Digit Counts](https://projecteuler.net/problem=63) | [Hy](https://hylang.org/) | [p63.hy](src/p63.hy) **([PR](https://github.com/jaredkrinke/100-languages/pull/3))** |
| 64 | [Odd Period Square Roots](https://projecteuler.net/problem=64) | [PureScript](https://www.purescript.org/) | [p64.purs](src/p64.purs) |
| 65 | [Convergents of e](https://projecteuler.net/problem=65) | [Ruby](https://www.ruby-lang.org/en/) | [p65.rb](src/p65.rb) |
| 66 | [Diophantine Equation](https://projecteuler.net/problem=66) | [Reason](https://reasonml.github.io/en/) | [p66.re](src/p66.re) |
| 67 | [Maximum Path Sum II](https://projecteuler.net/problem=67) | [T3X/0](https://t3x.org/t3x/0/) | [p67.t](src/p67.t) |
| 68 | [Magic 5-gon Ring](https://projecteuler.net/problem=68) | [AssemblyScript](https://www.assemblyscript.org/) | [p68.ts](src/p68.ts) |
| 69 | [Totient Maximum](https://projecteuler.net/problem=69) | [MiniLang](https://github.com/NICUP14/MiniLang) | [p69.ml](src/p69.ml) |
| 70 | [Totient Permutation](https://projecteuler.net/problem=70) | [C](https://en.wikipedia.org/wiki/C_(programming_language)) (C99) | [p70.c](src/p70.c) |
| 71 | [Ordered Fractions](https://projecteuler.net/problem=71) | [Clojure](https://clojure.org/index) | [p71.clj](src/p71.clj) |
| 72 | [Counting Fractions](https://projecteuler.net/problem=72) | [Zig](https://ziglang.org/) | [p72.zig](src/p72.zig) |
| 73 | [Counting Fractions in a Range](https://projecteuler.net/problem=73) | [Raku](https://raku.org/) | [p73.raku](src/p73.raku) |
| 74 | [Digit Factorial Chains](https://projecteuler.net/problem=74) | [Vala](https://vala.dev/) | [p74.vala](src/p74.vala) |
| 75 | [Singular Integer Right Triangles](https://projecteuler.net/problem=75) | [Odin](https://odin-lang.org/) | [p75.odin](src/p75.odin) |
| 76 | [Counting Summations](https://projecteuler.net/problem=76) | [QBasic](https://en.wikipedia.org/wiki/QBasic) | [p76.bas](src/p76.bas) |
| 77 | [Prime Summations](https://projecteuler.net/problem=77) | [Hazel](https://hazel.org/) | [p77.hazel](src/p77.hazel) |
| 78 | [Coin Partitions](https://projecteuler.net/problem=78) | [Ada](https://en.wikipedia.org/wiki/Ada_(programming_language)) | [p78.adb](src/p78.adb) |
| 79 | [Passcode Derivation](https://projecteuler.net/problem=79) | [Shen](https://shen-language.github.io/) | [p79.shen](src/p79.shen) |
| 80 | [Square Root Digital Expansion](https://projecteuler.net/problem=80) | [Python](https://www.python.org/) | [p80.py](src/p80.py) |
| 81 | [Path Sum: Two Ways](https://projecteuler.net/problem=81) | [Pre-Scheme](https://prescheme.org/) | [p81.scm](src/p81.scm) |
| 82 | [Path Sum: Three Ways](https://projecteuler.net/problem=82) | [LO](https://github.com/glebbash/LO) | [p82.lo](src/p82.lo) |
| 83 | [Path Sum: Four Ways](https://projecteuler.net/problem=83) | [Kitten](https://kittenlang.org/) | [p83.ktn](src/p83.ktn) |
| 84 | [Monopoly Odds](https://projecteuler.net/problem=84) | [Common Lisp](https://en.wikipedia.org/wiki/Common_Lisp) | [p84.lisp](src/p84.lisp) |
| 85 | [Counting Rectangles](https://projecteuler.net/problem=85) | [Bend](https://github.com/HigherOrderCO/bend) | [p85.bend](src/p85.bend) |
| 86 | [Cuboid Route](https://projecteuler.net/problem=86) | [V](https://vlang.io/) | [p86.v](src/p86.v) |
| 87 | [Prime Power Triples](https://projecteuler.net/problem=87) | [Lobster](http://strlen.com/lobster) | [p87.lobster](src/p87.lobster) |
| 88 | [Product-sum Numbers](https://projecteuler.net/problem=88) | [Dylan](https://en.wikipedia.org/wiki/Dylan_(programming_language)) | [p88.dylan](src/p88.dylan) |
| 89 | [Roman Numerals](https://projecteuler.net/problem=89) | [Janet](https://janet-lang.org/) | [p89.janet](src/p89.janet) |
| 90 | [Cube Digit Pairs](https://projecteuler.net/problem=90) | [Quackery](https://github.com/GordonCharlton/Quackery) | [p90.qky](src/p90.qky) |
| 91 | [Right Triangles with Integer Coordinates](https://projecteuler.net/problem=91) | [ATS](https://www.cs.bu.edu/~hwxi/atslangweb/) | [p91.dats](src/p91.dats) |
| 92 | [Square Digit Chains](https://projecteuler.net/problem=92) | [Mouse-83](http://mouse.davidgsimpson.com/mouse83/index.html) | [p92.mou](src/p92.mou) |
| 93 | [Arithmetic Expressions](https://projecteuler.net/problem=93) | [Cyber](https://cyberscript.dev/) | [p93.cy](src/p93.cy) |
| 94 | [Almost Equilateral Triangles](https://projecteuler.net/problem=94) | [Futhark](https://futhark-lang.org/) | [p94.fut](src/p94.fut) |
| 95 | [Amicable Chains](https://projecteuler.net/problem=95) | [Varyx](https://www.vcode.org/) | [p95.vx](src/p95.vx) |
| 96 | [Su Doku](https://projecteuler.net/problem=96) | [Prolog](https://en.wikipedia.org/wiki/Prolog) ([SWI-Prolog](https://www.swi-prolog.org/)) | [p96.pro](src/p96.pro) |
| 97 | [Large Non-Mersenne Prime](https://projecteuler.net/problem=97) | [8080 assembly](https://en.wikipedia.org/wiki/Intel_8080) ([Altair 8800](https://en.wikipedia.org/wiki/Altair_8800)) | [p97.asm](src/p97.asm) |
| 98 | [Anagramic Squares](https://projecteuler.net/problem=98) | [Rye](https://ryelang.org/) | [p98.rye](src/p98.rye) **([PR](https://github.com/jaredkrinke/100-languages/pull/6))** |
| 99 | [Largest Exponential](https://projecteuler.net/problem=99) | [Rexx](https://en.wikipedia.org/wiki/Rexx) | [p99.rex](src/p99.rex) |
| 100 | [Arranged Probability](https://projecteuler.net/problem=100) | [Nelua](https://nelua.io/) | [p100.nelua](src/p100.nelua) |
