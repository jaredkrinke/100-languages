1 REM - REPRESENT 2^1000 USING %N LOWER
2 REM - BYTES OF ARRAY A%; ITERATIVELY
3 REM - DIVIDE BY 10 AND ADD REMAINDER
4 REM - (BASE 10 DIGIT) TO SUM

10 N%=126
20 DIM A%(N%)
30 A%(1)=1

35 REM - START DIVISION AT BYTE ST%
40 ST% = 1
60 SUM% = 0

94 REM - == DIVIDE BY 10 ==
95 REM - CHECK FOR DONE WITH BYTE OR
96 REM - EVERYTHING. IF NOT, START FROM
97 REM - BYTE ST%
100 R% = 0
110 IF ST%>N% THEN PRINT SUM%:END
120 IF A%(ST%)=0 THEN ST%=ST%+1:GOTO 110
130 I%=ST%

195 REM - == DIVISION DIGIT LOOP ==
196 REM - SETUP 16-BIT DIVISION
200 D%=(256*R%)+A%(I%)
205 REM - COMPUTE QUOTIENT AND REMAINDER
210 Q% = INT(D%/10)
220 R% = D%-(10*Q%)
225 REM - WRITE BACK QUOTIENT
230 A%(I%)=Q%
235 REM - CHECK FOR DIVISION DONE
240 IF I%=N% GOTO 300
250 I%=I%+1
260 GOTO 200

295 REM - == DIVISION DONE ==
296 REM - ADD REMAINDER TO SUM
300 SUM%=SUM%+R%
305 PRINT R%
310 GOTO 100
