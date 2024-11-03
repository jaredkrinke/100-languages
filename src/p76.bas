REM Sum terms in recurrence relation for partition function

DECLARE FUNCTION sum& (n%)
total% = 100
DIM SHARED lookup&(total% + 1)
lookup&(0) = 1

FOR i% = 1 TO total%
  plusone& = sum&(i%)
NEXT

REM Minus one because the problem specifies "at least two positive integers"
PRINT (plusone& - 1)

FUNCTION sum& (n%)
REM t& is the total, f% is the sign, good% indicates we should continue
t& = 0
f% = 1
good% = 1
k% = 1

WHILE good% = 1
  good% = 0
  i% = n% - (k% * ((3 * k%) - 1) / 2)
  IF i% >= 0 THEN
    good% = 1
    t& = t& + (f% * lookup&(i%))
  END IF
  
  i% = n% - (k% * ((3 * k%) + 1) / 2)
  IF i% >= 0 THEN
    good% = 1
    t& = t& + (f% * lookup&(i%))
  END IF
  k% = k% + 1
  f% = (-1) * f%
WEND
lookup&(n%) = t&
sum& = t&
END FUNCTION

