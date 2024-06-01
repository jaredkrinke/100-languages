REM note: First digit must be 1 for 6*n
REM TO be same power

power&=10
lower&=-1
success%=0
PRINT TIME$
WHILE success%=0
  lower&=lower&+1
  IF lower&=power& THEN
    lower&=0
    power&=power&*10&
  END IF
  n&=power&+lower&
  GOSUB check
WEND
PRINT n&
PRINT TIME$
END

check:
m&=n&
GOSUB sortdigits
b&=m&
success%=1
FOR q&=2 TO 6
  m&=(q&*n&)
  GOSUB sortdigits
  IF m&<>b& THEN
    success%=0
    RETURN
  END IF
NEXT
RETURN

countdigits:
FOR i%=0 TO 9
  dc%(i%)=0
NEXT
WHILE m&>0
  REM MOD doesn't work with long ints!
  t&=m&\10&
  r&=m&-(10&*t&)
  dc%(r&)=dc%(r&)+1
  m&=t&
WEND
RETURN

sorteddigits:
m&=0
FOR k%=0 TO 9
  i&=9-k%
  FOR j%=1 TO dc%(i&)
    m&=i&+(10&*m&)
  NEXT
NEXT
RETURN

sortdigits:
GOSUB countdigits
GOSUB sorteddigits
RETURN

