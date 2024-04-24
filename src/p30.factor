! Project Euler problem 30

USING: kernel math math.functions math.parser prettyprint ranges sequences ;
IN: p30

: digits ( n -- digits )
  number>string [ CHAR: 0 - ] { } map-as ;

: power ( -- n )
  5 ; inline

: digit-power-sum ( n -- sum )
  digits [ power ^ ] map 0 [ + ] reduce ;

: digit-power-summable ( -- sum )
  ! Note: upper bound comes from all 9s (7 * 9^5 < 1000000)
  10 999999 [a..b] [ dup digit-power-sum = ] filter ;

digit-power-summable 0 [ + ] reduce .
