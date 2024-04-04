# Project Euler problem 22
set f [open "0022_names.txt"]
gets $f line
close $f

set names [lsort [regexp -inline -all {"[^\"]*?"} $line]]

set index 1
scan "A" "%c" A
set sum 0

foreach quoted $names {
  regexp {"([^\"]*)"} $quoted -> name
  foreach letter [split $name ""] {
    scan $letter "%c" code
	incr sum [expr $index * ($code - $A + 1)]
  }
  incr index
}

puts $sum

